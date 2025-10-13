import SwiftUI
import os
import WidgetKit
import UserNotifications
import SwiftSoup

let logger = Logger(subsystem: "com.Quran.Elmallah.Islamic-Pillars.Islamic-Center-of-Irvine", category: "ICOI")

final class Settings: ObservableObject {
    static let shared = Settings()
    
    static let encoder: JSONEncoder = {
        let enc = JSONEncoder()
        enc.dateEncodingStrategy = .millisecondsSince1970
        return enc
    }()

    static let decoder: JSONDecoder = {
        let dec = JSONDecoder()
        dec.dateDecodingStrategy = .millisecondsSince1970
        return dec
    }()
    
    private init() {
        if self.reciter.starts(with: "ar") {
            if let match = reciters.first(where: { $0.ayahIdentifier == self.reciter }) {
                self.reciter = match.name
            } else {
                self.reciter = "Muhammad Al-Minshawi (Murattal)"
            }
        }
    }
    
    func updateCurrentAndNextPrayer() {
        guard let todayPrayersICOI = prayersICOI else {
            logger.debug("Failed to get today's ICOI prayer times")
            return
        }
        
        let calendar = Calendar.current
        let now = Date()
        let isFriday = calendar.component(.weekday, from: now) == 6
        
        var prayersICOIToday = todayPrayersICOI.prayers
        
        // On non-Fridays, remove the last two entries (Jumuah slots) efficiently and safely.
        if !isFriday, prayersICOIToday.count >= 2 {
            prayersICOIToday.removeLast(2)
        }
                
        let currentICOI = prayersICOIToday.last(where: { $0.time <= now })
        let nextICOI = prayersICOIToday.first(where: { $0.time > now })

        if let next = nextICOI {
            nextPrayerICOI = next
        } else if let firstPrayerToday = prayersICOIToday.first,
                  let firstPrayerTomorrow = calendar.date(byAdding: .day, value: 1, to: firstPrayerToday.time) {
            nextPrayerICOI = Prayer(
                nameArabic: "أذان الفجر",
                nameTransliteration: "Fajr Adhan",
                nameEnglish: "Dawn",
                time: firstPrayerTomorrow,
                image: "sunrise",
                rakah: 2,
                sunnahBefore: 2,
                sunnahAfter: 0
            )
        }

        currentPrayerICOI = currentICOI ?? prayersICOIToday.last
    }
    
    @inlinable
    func arabicNumberString(from numberString: String) -> String {
        if !numberString.unicodeScalars.contains(where: { 48...57 ~= $0.value }) {
            return numberString
        }
        
        var out = String.UnicodeScalarView()
        out.reserveCapacity(numberString.unicodeScalars.count)
        
        let arabicZero = UnicodeScalar(0x0660)!
        for s in numberString.unicodeScalars {
            if 48...57 ~= s.value {
                let mapped = UnicodeScalar(arabicZero.value + (s.value - 48))!
                out.append(mapped)
            } else {
                out.append(s)
            }
        }
        return String(out)
    }
    
    func formatArabicDate(_ date: Date) -> String {
        struct Cache {
            static let formatter: DateFormatter = {
                let f = DateFormatter()
                f.timeStyle = .short
                f.locale = Locale(identifier: "ar")
                return f
            }()
        }
        Cache.formatter.timeZone = .current
        let s = Cache.formatter.string(from: date)
        return arabicNumberString(from: s)
    }

    private let hijriDateFormatterArabic: DateFormatter = {
        let formatter = DateFormatter()
        var hijriCalendar = Calendar(identifier: .islamicUmmAlQura)
        hijriCalendar.locale = Locale(identifier: "ar")
        formatter.calendar = hijriCalendar
        formatter.dateFormat = "d MMMM، yyyy"
        formatter.locale = Locale(identifier: "ar")
        return formatter
    }()

    private let hijriDateFormatterEnglish: DateFormatter = {
        let formatter = DateFormatter()
        var hijriCalendar = Calendar(identifier: .islamicUmmAlQura)
        hijriCalendar.locale = Locale(identifier: "ar")
        formatter.calendar = hijriCalendar
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "en")
        return formatter
    }()

    func formatDate(_ date: Date) -> String {
        struct Cache {
            static let formatter: DateFormatter = {
                let f = DateFormatter()
                f.timeStyle = .short
                return f
            }()
        }
        Cache.formatter.timeZone = .current
        return Cache.formatter.string(from: date)
    }

    func updateDates() {
        struct Cache {
            static let df: DateFormatter = {
                let f = DateFormatter()
                f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                return f
            }()
        }

        let now = Date()
        let currentDateString = Cache.df.string(from: now)
        let currentDateInRiyadh = Cache.df.date(from: currentDateString) ?? now

        var hijriCalendar = Calendar(identifier: .islamicUmmAlQura)
        hijriCalendar.locale = Locale(identifier: "ar")

        let hijriComponents = hijriCalendar.dateComponents([.year, .month, .day], from: currentDateInRiyadh)
        let hijriDateArabic = hijriCalendar.date(from: hijriComponents)
        let refDate = hijriDateArabic ?? currentDateInRiyadh

        withAnimation {
            let arabicFormattedDate = hijriDateFormatterArabic.string(from: refDate)
            self.hijriDateArabic = arabicNumberString(from: arabicFormattedDate) + " هـ"
            self.hijriDateEnglish = hijriDateFormatterEnglish.string(from: refDate)
        }
    }
    
    func getICOIPrayerTimes(completion: @escaping (Prayers?) -> Void) {
        guard let url = URL(string: "https://timing.athanplus.com/masjid/widgets/embed?theme=3&masjid_id=6adJkrKk&color=7A0C05&labeljumuah1=Jumuah%201") else {
            logger.debug("Invalid URL")
            DispatchQueue.main.async { completion(nil) }
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data, let html = String(data: data, encoding: .utf8) else {
                logger.debug("Failed to load ICOI prayer data.")
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            struct Cache {
                static let formatter: DateFormatter = {
                    let f = DateFormatter()
                    f.locale = Locale(identifier: "en_US_POSIX")
                    f.dateFormat = "h:mm a"
                    return f
                }()
            }
            let formatter = Cache.formatter
            
            var prayers: [Prayer] = []
            prayers.reserveCapacity(16)
            
            let weekday = Calendar.current.component(.weekday, from: Date())
            let isFriday = weekday == 6
            
            do {
                let document = try SwiftSoup.parse(html)
                
                let rows = try document.select("table.full-table-sec tr.no-border").array()
                let todayRows = Array(rows.prefix(6))
                
                let calendar = Calendar.current
                let currentDate = Date()
                
                let jumuahList = try document.select("ul.testing-sec li").array()
                let firstTwoJumuahs = Array(jumuahList.prefix(2))
                
                var jumuahTimes: [Date] = []
                jumuahTimes.reserveCapacity(2)
                
                for row in todayRows {
                    let name = try row.select("td").first()?.text()
                    let adhanTimeText = try row.select("td.one-span span").text()
                    let iqamahTimeText = try row.select("td b").text()
                    let sunriseTimeText = try row.select("td.cnter-jummah span").text()
                    
                    if let name = name,
                       let adhanTime = formatter.date(from: adhanTimeText),
                       let iqamahTime = formatter.date(from: iqamahTimeText) {
                        
                        if isFriday && name == "Dhuhr" {
                            for li in firstTwoJumuahs {
                                let timeText = try li.select("b").first()?.text() ?? ""
                                if let jumuahTime = formatter.date(from: timeText.trimmingCharacters(in: .whitespacesAndNewlines)) {
                                    let jumuahDate = calendar.date(
                                        bySettingHour: calendar.component(.hour, from: jumuahTime),
                                        minute: calendar.component(.minute, from: jumuahTime),
                                        second: 0,
                                        of: currentDate
                                    ) ?? currentDate
                                    jumuahTimes.append(jumuahDate)
                                }
                            }
                            
                            for (index, jumuahTime) in jumuahTimes.enumerated() {
                                prayers.append(
                                    Prayer(
                                        nameArabic: "\(index + 1 == 1 ? "الجُمُعَة الأُوَل" : "الجُمُعَة الثَانِي")",
                                        nameTransliteration: "\(index + 1 == 1 ? "First" : "Second") Jummuah",
                                        nameEnglish: "\(index + 1 == 1 ? "First" : "Second") Friday",
                                        time: jumuahTime,
                                        image: "sun.max.fill",
                                        rakah: 2,
                                        sunnahBefore: 0,
                                        sunnahAfter: 4
                                    )
                                )
                            }
                        } else {
                            let adhanDate = calendar.date(
                                bySettingHour: calendar.component(.hour, from: adhanTime),
                                minute: calendar.component(.minute, from: adhanTime),
                                second: 0,
                                of: currentDate
                            ) ?? currentDate
                            
                            let iqamahDate = calendar.date(
                                bySettingHour: calendar.component(.hour, from: iqamahTime),
                                minute: calendar.component(.minute, from: iqamahTime),
                                second: 0,
                                of: currentDate
                            ) ?? currentDate
                            
                            self.appendPrayer(for: name, adhanTime: adhanDate, iqamahTime: iqamahDate, into: &prayers)
                        }
                    } else if let sunriseDate = formatter.date(from: sunriseTimeText) {
                        let sunriseDateComponent = calendar.date(
                            bySettingHour: calendar.component(.hour, from: sunriseDate),
                            minute: calendar.component(.minute, from: sunriseDate),
                            second: 0,
                            of: currentDate
                        ) ?? currentDate
                        prayers.append(
                            Prayer(
                                nameArabic: "الشروق",
                                nameTransliteration: "Shurooq",
                                nameEnglish: "Sunrise",
                                time: sunriseDateComponent,
                                image: "sunrise.fill",
                                rakah: 0,
                                sunnahBefore: 0,
                                sunnahAfter: 0
                            )
                        )
                        prayers.append(
                            Prayer(
                                nameArabic: "الشروق",
                                nameTransliteration: "Shurooq",
                                nameEnglish: "Sunrise",
                                time: sunriseDateComponent,
                                image: "sunrise.fill",
                                rakah: 0,
                                sunnahBefore: 0,
                                sunnahAfter: 0
                            )
                        )
                    }
                }
                
                if !isFriday {
                    for li in firstTwoJumuahs {
                        let timeText = try li.select("b").first()?.text() ?? ""
                        if let jumuahTime = formatter.date(from: timeText.trimmingCharacters(in: .whitespacesAndNewlines)) {
                            let jumuahDate = calendar.date(
                                bySettingHour: calendar.component(.hour, from: jumuahTime),
                                minute: calendar.component(.minute, from: jumuahTime),
                                second: 0,
                                of: currentDate
                            ) ?? currentDate
                            jumuahTimes.append(jumuahDate)
                        }
                    }
                    
                    for (index, jumuahTime) in jumuahTimes.enumerated() {
                        prayers.append(
                            Prayer(
                                nameArabic: "\(index + 1 == 1 ? "الجُمُعَة الأُوَل" : "الجُمُعَة الثَانِي")",
                                nameTransliteration: "\(index + 1 == 1 ? "First" : "Second") Jummuah",
                                nameEnglish: "\(index + 1 == 1 ? "First" : "Second") Friday",
                                time: jumuahTime,
                                image: "sun.max.fill",
                                rakah: 2,
                                sunnahBefore: 0,
                                sunnahAfter: 4
                            )
                        )
                    }
                }
                
                logger.debug("Getting ICOI prayer times")
                DispatchQueue.main.async {
                    let newPrayers = Prayers(day: currentDate, prayers: prayers, setNotification: false)
                    completion(newPrayers)
                }
            } catch {
                logger.debug("Error parsing HTML: \(error)")
                DispatchQueue.main.async { completion(nil) }
            }
        }
        
        task.resume()
    }

    func appendPrayer(for name: String, adhanTime: Date, iqamahTime: Date, into prayers: inout [Prayer]) {
        switch name {
        case "Fajr":
            prayers.append(Prayer(nameArabic: "أذان الفجر", nameTransliteration: "Fajr Adhan", nameEnglish: "Dawn", time: adhanTime, image: "sunrise", rakah: 2, sunnahBefore: 2, sunnahAfter: 0))
            prayers.append(Prayer(nameArabic: "إقامة الفجر", nameTransliteration: "Fajr Iqamah", nameEnglish: "Dawn", time: iqamahTime, image: "sunrise", rakah: 2, sunnahBefore: 2, sunnahAfter: 0))
            
        case "Dhuhr":
            prayers.append(Prayer(nameArabic: "أذان الظهر", nameTransliteration: "Dhuhr Adhan", nameEnglish: "Noon", time: adhanTime, image: "sun.max", rakah: 4, sunnahBefore: 4, sunnahAfter: 2))
            prayers.append(Prayer(nameArabic: "إقامة الظهر", nameTransliteration: "Dhuhr Iqamah", nameEnglish: "Noon", time: iqamahTime, image: "sun.max", rakah: 4, sunnahBefore: 4, sunnahAfter: 2))
            
        case "Asr":
            prayers.append(Prayer(nameArabic: "أذان العصر", nameTransliteration: "Asr Adhan", nameEnglish: "Afternoon", time: adhanTime, image: "sun.min", rakah: 4, sunnahBefore: 0, sunnahAfter: 0))
            prayers.append(Prayer(nameArabic: "إقامة العصر", nameTransliteration: "Asr Iqamah", nameEnglish: "Afternoon", time: iqamahTime, image: "sun.min", rakah: 4, sunnahBefore: 0, sunnahAfter: 0))
            
        case "Maghrib":
            prayers.append(Prayer(nameArabic: "أذان المغرب", nameTransliteration: "Maghrib Adhan", nameEnglish: "Sunset", time: adhanTime, image: "sunset", rakah: 3, sunnahBefore: 0, sunnahAfter: 2))
            prayers.append(Prayer(nameArabic: "إقامة المغرب", nameTransliteration: "Maghrib Iqamah", nameEnglish: "Sunset", time: iqamahTime, image: "sunset", rakah: 3, sunnahBefore: 0, sunnahAfter: 2))
            
        case "Isha":
            prayers.append(Prayer(nameArabic: "أذان العشاء", nameTransliteration: "Isha Adhan", nameEnglish: "Night", time: adhanTime, image: "moon", rakah: 4, sunnahBefore: 0, sunnahAfter: 2))
            prayers.append(Prayer(nameArabic: "إقامة العشاء", nameTransliteration: "Isha Iqamah", nameEnglish: "Night", time: iqamahTime, image: "moon", rakah: 4, sunnahBefore: 0, sunnahAfter: 2))
            
        default:
            logger.debug("Unknown prayer name: \(name)")
        }
    }

    func fetchPrayerTimes(force: Bool = false, notification: Bool = false, completion: (() -> Void)? = nil) {
        var hasUpdatedDates = false
        
        if hijriDateArabic.isEmpty || hijriDateEnglish.isEmpty {
            updateDates()
            hasUpdatedDates = true
        }
        
        if !force, let prayersObject = prayersICOI, !prayersObject.prayers.isEmpty, prayersObject.day.isSameDay(as: Date()) {
            logger.debug("Updated current and next prayer times")
            
            updateCurrentAndNextPrayer()
            
            if !prayersObject.setNotification || notification  {
                schedulePrayerTimeNotifications()
                printAllScheduledNotifications()
            }
            
            completion?()
        } else {
            logger.debug("New prayer times")
            if !hasUpdatedDates { updateDates() }
            
            getICOIPrayerTimes { prayers in
                withAnimation {
                    self.prayersICOI = prayers
                }
                self.updateCurrentAndNextPrayer()
                self.schedulePrayerTimeNotifications()
                self.printAllScheduledNotifications()
                WidgetCenter.shared.reloadAllTimelines()
                
                completion?()
            }
        }
    }
    
    func nextDate(for dayLabel: String, baseDate: Date = Date()) -> Date {
        let lower = dayLabel.lowercased()
        if lower == "daily" { return baseDate }
        
        let weekdayMap: [String: Int] = [
            "mon": 2, "monday": 2,
            "tue": 3, "tuesday": 3,
            "wed": 4, "wednesday": 4, "weds": 4,
            "thu": 5, "thursday": 5,
            "fri": 6, "friday": 6,
            "sat": 7, "saturday": 7,
            "sun": 1, "sunday": 1
        ]
        guard let weekdayNumber = weekdayMap[lower] else { return baseDate }
        
        let calendar = Calendar.current
        if let next = calendar.nextDate(after: baseDate, matching: DateComponents(weekday: weekdayNumber), matchingPolicy: .nextTime) {
            return next
        }
        return baseDate
    }

    func combineDateAndTime(baseDate: Date, timeString: String) -> Date {
        let upperTime = timeString.uppercased()
        let period: String
        if upperTime.contains("AM") {
            period = "AM"
        } else if upperTime.contains("PM") {
            period = "PM"
        } else {
            return baseDate
        }
        
        let parts = timeString.split(separator: "-")
        guard let firstPart = parts.first else { return baseDate }
        let timePart = firstPart.trimmingCharacters(in: .whitespaces)
        
        let combinedString = timePart + " " + period
        
        struct Cache {
            static let formatter: DateFormatter = {
                let f = DateFormatter()
                f.locale = Locale(identifier: "en_US_POSIX")
                f.dateFormat = "h:mm a"
                return f
            }()
        }
        
        if let timeDate = Cache.formatter.date(from: combinedString) {
            let calendar = Calendar.current
            var baseComponents = calendar.dateComponents([.year, .month, .day], from: baseDate)
            let timeComponents = calendar.dateComponents([.hour, .minute], from: timeDate)
            baseComponents.hour = timeComponents.hour
            baseComponents.minute = timeComponents.minute
            return calendar.date(from: baseComponents) ?? baseDate
        }
        
        return baseDate
    }

    func getEventsICOI(completion: @escaping (Events?) -> Void) {
        guard let url = URL(string: "https://www.icoi.net/weekly-programs/") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                logger.debug("Error fetching ICOI events: \(error.localizedDescription)")
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            guard let data = data,
                  let html = String(data: data, encoding: .utf8) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            do {
                let document = try SwiftSoup.parse(html)
                let columns = try document.select("div.elementor-column.elementor-inner-column")
                var eventsList: [Event] = []
                eventsList.reserveCapacity(32)
                
                let validDays = ["Daily", "Mon", "Tue", "WED", "THU", "FRI", "Sat", "Sun"]
                
                for column in columns.array() {
                    let spans = try column.select("span.elementor-heading-title")
                    if spans.count < 2 { continue }
                    
                    let dayLabel = try spans.get(0).text().trimmingCharacters(in: .whitespacesAndNewlines)
                    if !validDays.contains(dayLabel) { continue }
                    
                    let baseDate = self.nextDate(for: dayLabel)
                    var index = 1
                    while index < spans.count {
                        let eventName = try spans.get(index).text().trimmingCharacters(in: .whitespacesAndNewlines)
                        var details = ""
                        if index + 1 < spans.count {
                            details = try spans.get(index + 1).text().trimmingCharacters(in: .whitespacesAndNewlines)
                        }
                        
                        var eventTime = ""
                        var eventLocation = ""
                        if details.contains("|") {
                            let parts = details.components(separatedBy: "|")
                            eventTime = parts[0].trimmingCharacters(in: .whitespacesAndNewlines)
                            if parts.count > 1 {
                                eventLocation = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
                            }
                        } else {
                            eventTime = details
                        }
                        
                        let eventDate = self.combineDateAndTime(baseDate: baseDate, timeString: eventTime)
                        
                        let event = Event(
                            dayOfWeek: dayLabel,
                            name: eventName,
                            link: "",
                            date: eventDate,
                            time: eventTime,
                            location: eventLocation
                        )
                        eventsList.append(event)
                        
                        index += 2
                    }
                }
                
                let eventsModel = Events(events: eventsList, day: Date())
                DispatchQueue.main.async {
                    completion(eventsModel)
                }
            } catch {
                logger.debug("Error parsing HTML: \(error)")
                DispatchQueue.main.async { completion(nil) }
            }
        }.resume()
    }

    func fetchEvents(force: Bool = false) {
        var hasUpdatedDates = false
        
        if hijriDateArabic.isEmpty || hijriDateEnglish.isEmpty {
            updateDates()
            hasUpdatedDates = true
        }
        
        if force || eventsICOI == nil || eventsICOI?.events.isEmpty == true || eventsICOI?.day.isSameDay(as: Date()) == false {
            logger.debug("New events")
            
            if !hasUpdatedDates {
                updateDates()
                hasUpdatedDates = true
            }
            
            getEventsICOI { events in
                self.eventsICOI = events
            }
        }
    }
    
    func getBusinessesICOI(completion: @escaping (Businesses?) -> Void) {
        guard let url = URL(string: "https://www.icoi.net/business-directory/") else {
            logger.debug("Invalid URL")
            DispatchQueue.main.async { completion(nil) }
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data, let html = String(data: data, encoding: .utf8) else {
                logger.debug("Failed to fetch ICOI business data.")
                DispatchQueue.main.async { completion(nil) }
                return
            }

            do {
                let document = try SwiftSoup.parse(html)

                // Grab all <p> elements that contain <span class="listing-phone">
                let businessElements = try document.select("p:has(span.listing-phone)").array()

                var businesses: [Business] = []
                businesses.reserveCapacity(businessElements.count)

                struct Cache {
                    static let nonDigits = CharacterSet.decimalDigits.inverted
                }

                for element in businessElements {
                    // Get the entire text from <p>
                    var pText = try element.text()

                    // Extract the phone text from within <span class="listing-phone">
                    let phoneNumberRaw = try element.select("span.listing-phone").text()

                    // Convert that phone text to digits only
                    var phoneNumber = phoneNumberRaw
                        .components(separatedBy: Cache.nonDigits)
                        .joined()

                    // If phone starts with '1' but is longer than 10 digits, remove the first '1'
                    if phoneNumber.hasPrefix("1"), phoneNumber.count > 10 {
                        phoneNumber.removeFirst()
                    }

                    // Remove the phone text from pText to isolate the name
                    if let range = pText.range(of: phoneNumberRaw) {
                        pText.removeSubrange(range)
                    }

                    // Clean up the name (remove plus signs, dashes, parentheses, etc.)
                    let name = pText
                        .replacingOccurrences(of: "+", with: "")
                        .replacingOccurrences(of: "—", with: "")
                        .replacingOccurrences(of: "(", with: "")
                        .replacingOccurrences(of: ")", with: "")
                        .trimmingCharacters(in: .whitespacesAndNewlines)

                    // Attempt to get the first link in this <p> as the website
                    let websiteLink = try element.select("a").first()?.attr("href") ?? ""

                    let business = Business(
                        name: name,
                        phoneNumber: phoneNumber,
                        website: websiteLink
                    )
                    businesses.append(business)
                }

                let fullBusinesses = Businesses(businesses: businesses, day: Date())
                DispatchQueue.main.async { completion(fullBusinesses) }

            } catch {
                logger.debug("Error parsing HTML: \(error)")
                DispatchQueue.main.async { completion(nil) }
            }
        }.resume()
    }

    func fetchBusinesses(force: Bool = false, completion: (() -> Void)? = nil) {
        var hasUpdatedDates = false

        if hijriDateArabic.isEmpty || hijriDateEnglish.isEmpty {
            updateDates()
            hasUpdatedDates = true
        }

        if force || businessesICOI == nil || businessesICOI?.businesses.isEmpty == true || businessesICOI?.day.isSameDay(as: Date()) == false {
            logger.debug("New businesses")

            if !hasUpdatedDates { updateDates() }

            getBusinessesICOI { businesses in
                self.businessesICOI = businesses
                completion?()
            }
        } else {
            completion?()
        }
    }
    
    func printAllScheduledNotifications() {
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests { (requests) in
            for request in requests {
                logger.debug("\(request.content.body)")
            }
        }
    }
    
    func scheduleDailyRefreshReminders(using center: UNUserNotificationCenter, prayers: [Prayer]) {
        let cal = Calendar.current
        let now = Date()

        // --- FIX: make sure we look up Dhuhr Adhan correctly (was "Dhuhr" before) ---
        if let dhuhrAdhan = prayers.first(where: { $0.nameTransliteration == "Dhuhr Adhan" }) {
            if let preDhuhr = cal.date(byAdding: .minute, value: -30, to: dhuhrAdhan.time), preDhuhr > now {
                let comps = cal.dateComponents([.year, .month, .day, .hour, .minute], from: preDhuhr)
                let content = UNMutableNotificationContent()
                content.title = "Islamic Center of Irvine"
                content.body  = "Please open the app to refresh today’s prayer times and notifications."
                content.sound = .default

                let trig = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
                let req  = UNNotificationRequest(identifier: "DailyRefreshPreDhuhr", content: content, trigger: trig)
                center.add(req) { error in
                    if let e = error {
                        logger.debug("Error scheduling DailyRefreshPreDhuhr: \(e.localizedDescription)")
                    }
                }
            }
        }

        // --- NEW: Reminder between Shurooq and Dhuhr Adhan (midpoint) ---
        if let shurooq = prayers.first(where: { $0.nameTransliteration == "Shurooq" }),
           let dhuhrAdhan = prayers.first(where: { $0.nameTransliteration == "Dhuhr Adhan" }) {

            let start = shurooq.time
            let end   = dhuhrAdhan.time

            if end > start {
                let halfInterval = (end.timeIntervalSince1970 - start.timeIntervalSince1970) / 2.0
                let midpoint = Date(timeIntervalSince1970: start.timeIntervalSince1970 + halfInterval)

                if midpoint > now {
                    let comps = cal.dateComponents([.year, .month, .day, .hour, .minute], from: midpoint)
                    let content = UNMutableNotificationContent()
                    content.title = "Islamic Center of Irvine"
                    content.body  = "Midday check-in: open the app to ensure prayer times are fresh."
                    content.sound = .default

                    let trig = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
                    let req  = UNNotificationRequest(identifier: "RefreshMidpointShurooqDhuhr", content: content, trigger: trig)
                    center.add(req) { error in
                        if let e = error {
                            logger.debug("Error scheduling midpoint refresh: \(e.localizedDescription)")
                        }
                    }
                }
            }
        }

        // --- REMOVED: pre-Fajr refresh (per your request) ---

        // --- Keep scheduling TOMORROW’s early prayers now, but ONLY if toggles are ON (A) ---
        let fajrAdhanToday   = prayers.first(where: { $0.nameTransliteration == "Fajr Adhan" })
        let fajrIqamahToday  = prayers.first(where: { $0.nameTransliteration == "Fajr Iqamah" })
        let shurooqToday     = prayers.first(where: { $0.nameTransliteration == "Shurooq" })

        func cloneForTomorrow(from p: Prayer, translit: String) -> Prayer {
            let tmrw = cal.date(byAdding: .day, value: 1, to: p.time) ?? p.time.addingTimeInterval(86400)
            return Prayer(
                nameArabic: p.nameArabic,
                nameTransliteration: translit,
                nameEnglish: p.nameEnglish,
                time: tmrw,
                image: p.image,
                rakah: p.rakah,
                sunnahBefore: p.sunnahBefore,
                sunnahAfter: p.sunnahAfter
            )
        }

        // Only schedule if those specific toggles are enabled
        if let fajrAdhanToday, adhanFajr {
            let fajrAdhanTomorrow = cloneForTomorrow(from: fajrAdhanToday, translit: "Fajr Adhan")
            scheduleNotification(for: fajrAdhanTomorrow, preNotificationTime: nil)
        }

        if let fajrIqamahToday, iqamahFajr {
            let fajrIqamahTomorrow = cloneForTomorrow(from: fajrIqamahToday, translit: "Fajr Iqamah")
            if iqamahFajrPreNotification > 0 {
                scheduleNotification(for: fajrIqamahTomorrow, preNotificationTime: iqamahFajrPreNotification)
            }
            scheduleNotification(for: fajrIqamahTomorrow, preNotificationTime: nil)
        }

        if let shurooqToday, sunriseTime {
            let shurooqTomorrow = cloneForTomorrow(from: shurooqToday, translit: "Shurooq")
            scheduleNotification(for: shurooqTomorrow, preNotificationTime: nil)
        }
    }

    func schedulePrayerTimeNotifications() {
        #if !os(watchOS)
        guard let prayerObject = prayersICOI else { return }
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
        
        let calendar = Calendar.current
        let isFriday = (calendar.component(.weekday, from: Date()) == 6)
        
        var prayerTimes = prayerObject.prayers
        if !isFriday, prayerTimes.count >= 2 {
            // Remove Jumuah slots on non-Fridays (preserves original behavior).
            prayerTimes.removeLast(2)
        }
        
        for prayerTime in prayerTimes {
            let notification: Bool
            var preNotificationTime: Int?
            
            switch prayerTime.nameTransliteration {
            case "Fajr Adhan":
                notification = adhanFajr
            case "Fajr Iqamah":
                notification = iqamahFajr
                preNotificationTime = iqamahFajrPreNotification
                if khateraFajr {
                    scheduleKhateraNotification(for: prayerTime, minutesAfter: 30, name: "Fajr Khatera")
                }
            case "Shurooq":
                notification = sunriseTime
            case "Dhuhr Adhan":
                notification = adhanDhuhr
            case "Dhuhr Iqamah":
                notification = iqamahDhuhr
                preNotificationTime = iqamahDhuhrPreNotification
            case "First Jummuah":
                notification = firstJummuah
                preNotificationTime = firstJummuahPreNotification
            case "Second Jummuah":
                notification = secondJummuah
                preNotificationTime = secondJummuahPreNotification
            case "Asr Adhan":
                notification = adhanAsr
            case "Asr Iqamah":
                notification = iqamahAsr
                preNotificationTime = iqamahAsrPreNotification
            case "Maghrib Adhan":
                notification = adhanMaghrib
            case "Maghrib Iqamah":
                notification = iqamahMaghrib
                preNotificationTime = iqamahMaghribPreNotification
            case "Isha Adhan":
                notification = adhanIsha
            case "Isha Iqamah":
                notification = iqamahIsha
                preNotificationTime = iqamahIshaPreNotification
                if khateraIsha {
                    scheduleKhateraNotification(for: prayerTime, minutesAfter: 30, name: "Isha Khatera")
                }
            default:
                continue
            }
            
            if notification {
                scheduleNotification(for: prayerTime, preNotificationTime: nil)
            }
            if let m = preNotificationTime, m > 0 {
                scheduleNotification(for: prayerTime, preNotificationTime: m)
            }
        }
        
        if ratingJummuah {
            let components = DateComponents(hour: 15, minute: 0, weekday: 6)
            if let date = calendar.nextDate(after: Date(), matching: components, matchingPolicy: .nextTime) {
                let content = UNMutableNotificationContent()
                content.title = "Islamic Center of Irvine"
                content.body = "Tap here if you want to rate the khutbah"
                content.sound = UNNotificationSound.default
                
                let triggerComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
                
                let request = UNNotificationRequest(identifier: "jummuahRating", content: content, trigger: trigger)
                center.add(request) { error in
                    if let e = error {
                        logger.debug("Error scheduling jummuahRating: \(e.localizedDescription)")
                    }
                }
            }
        }
        
        scheduleDailyRefreshReminders(using: center, prayers: prayerTimes)
        
        prayersICOI?.setNotification = true
        #endif
    }

    func scheduleNotification(for prayerTime: Prayer, preNotificationTime: Int?) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Islamic Center of Irvine"
        
        let calendar = Calendar.current
        let baseTime = prayerTime.time
        var triggerTime = baseTime
        
        if let pre = preNotificationTime, pre != 0 {
            triggerTime = calendar.date(byAdding: .minute, value: -pre, to: baseTime) ?? baseTime
            if prayerTime.nameTransliteration == "Shurooq" {
                content.body = "Shurooq is in \(pre) min [\(formatDate(baseTime))]"
            } else {
                content.body = "\(prayerTime.nameTransliteration) is in \(pre) min [\(formatDate(baseTime))]"
            }
        } else {
            if prayerTime.nameTransliteration == "Shurooq" {
                content.body = "Time for Shurooq at \(formatDate(baseTime))"
            } else {
                content.body = "Time for \(prayerTime.nameTransliteration) at \(formatDate(baseTime))"
            }
        }
        
        content.sound = .default
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: triggerTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { error in
            if let e = error {
                logger.debug("Error scheduling notification: \(e.localizedDescription)")
            }
        }
    }

    func scheduleKhateraNotification(for prayerTime: Prayer, minutesAfter: Int, name: String) {
        let center = UNUserNotificationCenter.current()
        let khateraDate = prayerTime.time.addingTimeInterval(TimeInterval(minutesAfter * 60))
        
        let content = UNMutableNotificationContent()
        content.title = "Islamic Center of Irvine"
        content.body = "Tap here to rate the \(name). You can turn this notification off in app."
        content.sound = .default
        
        let calendar = Calendar.current
        let comps = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: khateraDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        
        let request = UNNotificationRequest(identifier: "\(name)Notification", content: content, trigger: trigger)
        center.add(request) { error in
            if let e = error {
                logger.debug("Error scheduling khatera: \(e.localizedDescription)")
            }
        }
    }

    func requestNotificationAuthorization() {
        #if !os(watchOS)
        let center = UNUserNotificationCenter.current()

        center.getNotificationSettings { [weak self] settings in
            guard let self = self else { return }
            switch settings.authorizationStatus {
            case .notDetermined:
                center.requestAuthorization(options: [.alert, .sound]) { [weak self] (granted, _) in
                    DispatchQueue.main.async {
                        guard let self = self else { return }
                        if granted {
                            if self.showNotificationAlert {
                                self.fetchPrayerTimes(notification: true)
                            }
                            self.showNotificationAlert = false
                        } else {
                            if !self.notificationNeverAskAgain {
                                self.showNotificationAlert = true
                            }
                        }
                    }
                }
            case .authorized:
                DispatchQueue.main.async {
                    if self.showNotificationAlert {
                        self.fetchPrayerTimes(notification: true)
                    }
                    self.showNotificationAlert = false
                }
            case .denied:
                DispatchQueue.main.async {
                    self.showNotificationAlert = true
                    logger.debug("Permission denied")
                    if !self.notificationNeverAskAgain {
                        self.showNotificationAlert = true
                    }
                }
            default:
                break
            }
        }
        #endif
    }
    
    func hapticFeedback() {
        #if os(iOS)
        if hapticOn { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
        #endif
        
        #if os(watchOS)
        if hapticOn { WKInterfaceDevice.current().play(.click) }
        #endif
    }
    
    let accentColor: Color = Color(red: 175 / 255, green: 28 / 255, blue: 51 / 255)
    let accentColor2: Color = Color(red: 255 / 255, green: 140 / 255, blue: 140 / 255)
    
    @AppStorage("hijriDateArabic") var hijriDateArabic: String = ""
    @AppStorage("hijriDateEnglish") var hijriDateEnglish: String = ""
    
    @AppStorage("prayersICOIData", store: UserDefaults(suiteName: "group.com.ICOI.AppGroup")!)
    private var prayersICOIDataRaw: Data = Data() {
        didSet { objectWillChange.send() }
    }

    var prayersICOI: Prayers? {
        get {
            guard !prayersICOIDataRaw.isEmpty else { return nil }
            return try? Self.decoder.decode(Prayers.self, from: prayersICOIDataRaw)
        }
        set {
            if let newValue, let data = try? Self.encoder.encode(newValue) {
                prayersICOIDataRaw = data
            } else {
                prayersICOIDataRaw = Data()
            }
        }
    }
    
    @AppStorage("eventsICOIData") private var eventsICOIDataRaw: Data = Data() {
        didSet { objectWillChange.send() }
    }

    var eventsICOI: Events? {
        get {
            guard !eventsICOIDataRaw.isEmpty else { return nil }
            return try? Self.decoder.decode(Events.self, from: eventsICOIDataRaw)
        }
        set {
            if let newValue, let data = try? Self.encoder.encode(newValue) {
                eventsICOIDataRaw = data
            } else {
                eventsICOIDataRaw = Data()
            }
        }
    }
    
    @AppStorage("businessesICOIData") private var businessesICOIDataRaw: Data = Data() {
        didSet { objectWillChange.send() }
    }

    var businessesICOI: Businesses? {
        get {
            guard !businessesICOIDataRaw.isEmpty else { return nil }
            return try? Self.decoder.decode(Businesses.self, from: businessesICOIDataRaw)
        }
        set {
            if let newValue, let data = try? Self.encoder.encode(newValue) {
                businessesICOIDataRaw = data
            } else {
                businessesICOIDataRaw = Data()
            }
        }
    }

    
    @AppStorage("currentPrayerICOIData") var currentPrayerICOIData: Data?
    @Published var currentPrayerICOI: Prayer? {
        didSet {
            currentPrayerICOIData = try? Self.encoder.encode(currentPrayerICOI)
        }
    }

    @AppStorage("nextPrayerICOIData") var nextPrayerICOIData: Data?
    @Published var nextPrayerICOI: Prayer? {
        didSet {
            nextPrayerICOIData = try? Self.encoder.encode(nextPrayerICOI)
        }
    }
        
    @AppStorage("defaultView") var defaultView: Bool = true
    
    @AppStorage("colorSchemeString") var colorSchemeString: String = "system"
    var colorScheme: ColorScheme? {
        get {
            return colorSchemeFromString(colorSchemeString)
        }
        set {
            colorSchemeString = colorSchemeToString(newValue)
        }
    }
    
    func colorSchemeFromString(_ colorScheme: String) -> ColorScheme? {
        switch colorScheme {
        case "light":
            return .light
        case "dark":
            return .dark
        default:
            return nil
        }
    }

    func colorSchemeToString(_ colorScheme: ColorScheme?) -> String {
        switch colorScheme {
        case .light:
            return "light"
        case .dark:
            return "dark"
        default:
            return "system"
        }
    }

    @AppStorage("showNotificationAlert") var showNotificationAlert: Bool = false

    @AppStorage("notificationNeverAskAgain") var notificationNeverAskAgain = false

    @AppStorage("adhanFajr") var adhanFajr: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("iqamahFajr") var iqamahFajr: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("sunriseTime") var sunriseTime: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("adhanDhuhr") var adhanDhuhr: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("iqamahDhuhr") var iqamahDhuhr: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }
    
    @AppStorage("firstJummuah") var firstJummuah: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("secondJummuah") var secondJummuah: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }
    
    @AppStorage("ratingJummuah") var ratingJummuah: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }
    
    @AppStorage("khateraFajr") var khateraFajr: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }
    
    @AppStorage("khateraIsha") var khateraIsha: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("adhanAsr") var adhanAsr: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("iqamahAsr") var iqamahAsr: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("adhanMaghrib") var adhanMaghrib: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("iqamahMaghrib") var iqamahMaghrib: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("adhanIsha") var adhanIsha: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("iqamahIsha") var iqamahIsha: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }
    
    @AppStorage("iqamahFajrPreNotification") var iqamahFajrPreNotification: Int = 0 {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("iqamahDhuhrPreNotification") var iqamahDhuhrPreNotification: Int = 0 {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("firstJummuahPreNotification") var firstJummuahPreNotification: Int = 0 {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("secondJummuahPreNotification") var secondJummuahPreNotification: Int = 0 {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("iqamahAsrPreNotification") var iqamahAsrPreNotification: Int = 0 {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("iqamahMaghribPreNotification") var iqamahMaghribPreNotification: Int = 0 {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("iqamahIshaPreNotification") var iqamahIshaPreNotification: Int = 0 {
        didSet { fetchPrayerTimes(notification: true) }
    }
    
    @AppStorage("beginnerMode") var beginnerMode: Bool = false
    
    @AppStorage("lastReadSurah") var lastReadSurah: Int = 0
    @AppStorage("lastReadAyah") var lastReadAyah: Int = 0
    
    @AppStorage("lastListenedSurahData") private var lastListenedSurahData: Data?
    var lastListenedSurah: LastListenedSurah? {
        get {
            guard let data = lastListenedSurahData else { return nil }
            do {
                return try Self.decoder.decode(LastListenedSurah.self, from: data)
            } catch {
                logger.debug("Failed to decode last listened surah: \(error)")
                return nil
            }
        }
        set {
            if let newValue = newValue {
                do {
                    lastListenedSurahData = try Self.encoder.encode(newValue)
                } catch {
                    logger.debug("Failed to encode last listened surah: \(error)")
                }
            } else {
                lastListenedSurahData = nil
            }
        }
    }
    
    @AppStorage("favoriteSurahsData") private var favoriteSurahsData = Data()
    var favoriteSurahs: [Int] {
        get {
            (try? Self.decoder.decode([Int].self, from: favoriteSurahsData)) ?? []
        }
        set {
            favoriteSurahsData = (try? Self.encoder.encode(newValue)) ?? Data()
        }
    }
    
    @AppStorage("bookmarkedAyahsData") private var bookmarkedAyahsData = Data()
    var bookmarkedAyahs: [BookmarkedAyah] {
        get {
            (try? Self.decoder.decode([BookmarkedAyah].self, from: bookmarkedAyahsData)) ?? []
        }
        set {
            bookmarkedAyahsData = (try? Self.encoder.encode(newValue)) ?? Data()
        }
    }
        
    @AppStorage("showBookmarks") var showBookmarks = true
    @AppStorage("showFavorites") var showFavorites = true

    @AppStorage("favoriteLetterData") private var favoriteLetterData = Data()
    var favoriteLetters: [LetterData] {
        get {
            (try? Self.decoder.decode([LetterData].self, from: favoriteLetterData)) ?? []
        }
        set {
            favoriteLetterData = (try? Self.encoder.encode(newValue)) ?? Data()
        }
    }
    
    @AppStorage("hapticOn") var hapticOn: Bool = true
    
    @AppStorage("groupBySurah") var groupBySurah: Bool = true
    @AppStorage("searchForSurahs") var searchForSurahs: Bool = true
    
    @AppStorage("reciter") var reciter: String = "Muhammad Al-Minshawi (Murattal)"
    @AppStorage("reciteType") var reciteType = "Continue to Next"
    
    @AppStorage("showArabicText") var showArabicText: Bool = true
    @AppStorage("cleanArabicText") var cleanArabicText: Bool = false
    @AppStorage("fontArabic") var fontArabic: String = "KFGQPCHafsEx1UthmanicScript-Reg"
    @AppStorage("fontArabicSize") var fontArabicSize: Double = Double(UIFont.preferredFont(forTextStyle: .body).pointSize) + 10
    
    @AppStorage("useFontArabic") var useFontArabic: Bool = true
    
    @AppStorage("showTransliteration") var showTransliteration: Bool = true
    @AppStorage("showEnglishSaheeh") var showEnglishSaheeh: Bool = true
    @AppStorage("showEnglishMustafa") var showEnglishMustafa: Bool = false
    
    @AppStorage("englishFontSize") var englishFontSize: Double = Double(UIFont.preferredFont(forTextStyle: .body).pointSize)
    
    var hijriCalendar: Calendar = {
        var calendar = Calendar(identifier: .islamicUmmAlQura)
        calendar.locale = Locale(identifier: "ar")
        return calendar
    }()
    
    var specialEvents: [(String, DateComponents, String, String)] {
        let currentHijriYear = hijriCalendar.component(.year, from: Date())
        return [
            ("Islamic New Year", DateComponents(year: currentHijriYear, month: 1, day: 1), "Start of Hijri year", "The first day of the Islamic calendar; no special acts of worship or celebration are prescribed."),
            ("Day Before Ashura", DateComponents(year: currentHijriYear, month: 1, day: 9), "Recommended to fast", "The Prophet ﷺ intended to fast the 9th to differ from the Jews, making it Sunnah to do so before Ashura."),
            ("Day of Ashura", DateComponents(year: currentHijriYear, month: 1, day: 10), "Recommended to fast", "Ashura marks the day Allah saved Musa (Moses) and the Israelites from Pharaoh; fasting expiates sins of the previous year."),
            
            ("First Day of Ramadan", DateComponents(year: currentHijriYear, month: 9, day: 1), "Begin obligatory fast", "The month of fasting begins; all Muslims must fast from Fajr (dawn) to Maghrib (sunset)."),
            ("Last 10 Nights of Ramadan", DateComponents(year: currentHijriYear, month: 9, day: 21), "Seek Laylatul Qadr", "The most virtuous nights of the year; increase worship as these nights are beloved to Allah and contain Laylatul Qadr."),
            ("27th Night of Ramadan", DateComponents(year: currentHijriYear, month: 9, day: 27), "Likely Laylatul Qadr", "A strong possibility for Laylatul Qadr — the Night of Decree when the Qur’an was sent down — though not confirmed."),
            ("Eid Al-Fitr", DateComponents(year: currentHijriYear, month: 10, day: 1), "Celebration of ending the fast", "Celebration marking the end of Ramadan; fasting is prohibited on this day; encouraged to fast 6 days in Shawwal."),
            
            ("First 10 Days of Dhul-Hijjah", DateComponents(year: currentHijriYear, month: 12, day: 1), "Most beloved days", "The best days for righteous deeds; fasting and dhikr are highly encouraged."),
            ("Beginning of Hajj", DateComponents(year: currentHijriYear, month: 12, day: 8), "Pilgrimage begins", "Pilgrims begin the rites of Hajj, heading to Mina to start the sacred journey."),
            ("Day of Arafah", DateComponents(year: currentHijriYear, month: 12, day: 9), "Recommended to fast", "Fasting for non-pilgrims expiates sins of the past and coming year."),
            ("Eid Al-Adha", DateComponents(year: currentHijriYear, month: 12, day: 10), "Celebration of sacrifice during Hajj", "The day of sacrifice; fasting is not allowed and sacrifice of an animal is offered."),
            ("End of Eid Al-Adha", DateComponents(year: currentHijriYear, month: 12, day: 13), "Hajj and Eid end", "Final day of Eid Al-Adha; pilgrims and non-pilgrims return to daily life."),
        ]
    }
    
    func toggleLetterFavorite(letterData: LetterData) {
        withAnimation {
            if isLetterFavorite(letterData: letterData) {
                favoriteLetters.removeAll(where: { $0.id == letterData.id })
            } else {
                favoriteLetters.append(letterData)
            }
        }
    }

    func isLetterFavorite(letterData: LetterData) -> Bool {
        return favoriteLetters.contains(where: {$0.id == letterData.id})
    }
}
