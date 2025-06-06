import SwiftUI
import WidgetKit
import UserNotifications
import SwiftSoup

struct LetterData: Identifiable, Codable, Equatable, Comparable {
    let id: Int
    let letter: String
    let forms: [String]
    let name: String
    let transliteration: String
    let showTashkeel: Bool
    let sound: String
    
    static func < (lhs: LetterData, rhs: LetterData) -> Bool {
        return lhs.id < rhs.id
    }
}

struct Prayer: Identifiable, Codable, Equatable {
    var id = UUID()
    let nameArabic: String
    let nameTransliteration: String
    let nameEnglish: String
    let time: Date
    let image: String
    let rakah: Int
    let sunnahBefore: Int
    let sunnahAfter: Int
    
    static func ==(lhs: Prayer, rhs: Prayer) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Prayers: Identifiable, Codable, Equatable {
    var id = UUID()
    let day: Date
    let prayers: [Prayer]
    var setNotification: Bool
}

struct Events: Codable {
    let events: [Event]
    let day: Date
}

struct Event: Codable {
    let dayOfWeek: String
    let name: String
    let link: String
    let date: Date
    let time: String
    let location: String
}

struct Businesses: Codable {
    let businesses: [Business]
    let day: Date
}

struct Business: Codable {
    let name: String
    let phoneNumber: String
    let website: String
}

extension Date {
    func isSameDay(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: date)
    }
}

final class Settings: NSObject, ObservableObject {
    static let shared = Settings()
    private var appGroupUserDefaultsICOI: UserDefaults?
    private var appGroupUserDefaults: UserDefaults?
    
    override init() {
        self.appGroupUserDefaultsICOI = UserDefaults(suiteName: "group.com.ICOI.AppGroup")
        self.appGroupUserDefaults = UserDefaults(suiteName: "group.com.IslamicPillars.AppGroup")
        
        self.prayersICOIData = appGroupUserDefaultsICOI?.data(forKey: "prayersICOIData") ?? Data()
        self.eventsICOIData = appGroupUserDefaultsICOI?.data(forKey: "eventsICOIData") ?? Data()
        self.businessesICOIData = appGroupUserDefaultsICOI?.data(forKey: "businessesICOIData") ?? Data()
        
        self.favoriteSurahsData = appGroupUserDefaults?.data(forKey: "favoriteSurahsData") ?? Data()
        self.bookmarkedAyahsData = appGroupUserDefaults?.data(forKey: "bookmarkedAyahsData") ?? Data()
        self.favoriteLetterData = appGroupUserDefaults?.data(forKey: "favoriteLetterData") ?? Data()
    }
    
    func updateCurrentAndNextPrayer() {
        guard let todayPrayersICOI = prayersICOI else {
            print("Failed to get today's ICOI prayer times")
            return
        }
        
        let weekday = Calendar.current.component(.weekday, from: Date())
        let isFriday = weekday == 6
        
        var prayersICOIToday = todayPrayersICOI.prayers
        
        if !isFriday {
            prayersICOIToday = prayersICOIToday.dropLast()
            prayersICOIToday = prayersICOIToday.dropLast()
        }
                
        let now = Date()
        
        let currentICOI = prayersICOIToday.last(where: { $0.time <= now })
        let nextICOI = prayersICOIToday.first(where: { $0.time > now })

        if let next = nextICOI {
            nextPrayerICOI = next
        } else if let firstPrayerToday = prayersICOIToday.first {
            var tomorrowComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: firstPrayerToday.time)
            tomorrowComponents.day! += 1
            if let firstPrayerTomorrow = Calendar.current.date(from: tomorrowComponents) {
                nextPrayerICOI = Prayer(nameArabic: "أذان الفجر", nameTransliteration: "Fajr Adhan", nameEnglish: "Dawn", time: firstPrayerTomorrow, image: "sunrise", rakah: 2, sunnahBefore: 2, sunnahAfter: 0)
            }
        }

        currentPrayerICOI = currentICOI ?? prayersICOIToday.last
    }
    
    func arabicNumberString(from numberString: String) -> String {
        let arabicNumbers = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"]

        var arabicNumberString = ""
        for character in numberString {
            if let digit = Int(String(character)) {
                arabicNumberString += arabicNumbers[digit]
            } else {
                arabicNumberString += String(character)  // handle non-digit characters like ':' in time
            }
        }
        return arabicNumberString
    }
    
    func formatArabicDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale(identifier: "ar")
        let dateInEnglish = formatter.string(from: date)
        return arabicNumberString(from: dateInEnglish)
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
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone.current
        return formatter.string(from: date)
    }
    
    func updateDates() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let currentDateString = dateFormatter.string(from: Date())
        let currentDateInRiyadh = dateFormatter.date(from: currentDateString) ?? Date()

        var hijriCalendar = Calendar(identifier: .islamicUmmAlQura)
        hijriCalendar.locale = Locale(identifier: "ar")
        
        let hijriComponents = hijriCalendar.dateComponents([.year, .month, .day], from: currentDateInRiyadh)
        let hijriDateArabic = hijriCalendar.date(from: hijriComponents)

        withAnimation {
            let arabicFormattedDate = hijriDateFormatterArabic.string(from: hijriDateArabic ?? currentDateInRiyadh)
            self.hijriDateArabic = arabicNumberString(from: arabicFormattedDate) + " هـ"
            self.hijriDateEnglish = hijriDateFormatterEnglish.string(from: hijriDateArabic ?? currentDateInRiyadh)
        }
    }
    
    func getICOIPrayerTimes(completion: @escaping (Prayers?) -> Void) {
        guard let url = URL(string: "https://timing.athanplus.com/masjid/widgets/embed?theme=3&masjid_id=6adJkrKk&color=7A0C05&labeljumuah1=Jumuah%201") else {
            print("Invalid URL")
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                let html = String(data: data, encoding: .utf8)
                var prayers: [Prayer] = []
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "h:mm a"
                
                let weekday = Calendar.current.component(.weekday, from: Date())
                let isFriday = weekday == 6
                
                do {
                    let document = try SwiftSoup.parse(html ?? "")
                    
                    let rows = try document.select("table.full-table-sec tr.no-border").array()
                    let todayRows = Array(rows.prefix(6))
                    
                    let calendar = Calendar.current
                    let currentDate = Date()
                    
                    let jumuahList = try document.select("ul.testing-sec li").array()
                    let firstTwoJumuahs = Array(jumuahList.prefix(2))
                    var jumuahTimes: [Date] = []
                    
                    for row in todayRows {
                        let name = try row.select("td").first()?.text()
                        let adhanTime = try row.select("td.one-span span").text()
                        let iqamahTime = try row.select("td b").text()
                        
                        let sunriseTime = try row.select("td.cnter-jummah span").text()
                        
                        if let name = name, let adhanTime = formatter.date(from: adhanTime), let iqamahTime = formatter.date(from: iqamahTime) {
                            if isFriday && name == "Dhuhr" {
                                for li in firstTwoJumuahs {
                                    let timeText = try li.select("b").first()?.text() ?? ""
                                    
                                    if let jumuahTime = formatter.date(from: timeText.trimmingCharacters(in: .whitespacesAndNewlines)) {
                                        let jumuahDateComponent = calendar.date(bySettingHour: calendar.component(.hour, from: jumuahTime), minute: calendar.component(.minute, from: jumuahTime), second: 0, of: currentDate) ?? currentDate
                                        jumuahTimes.append(jumuahDateComponent)
                                    }
                                }
                                
                                for (index, jumuahTime) in jumuahTimes.enumerated() {
                                    prayers.append(Prayer(nameArabic: "\(index + 1 == 1 ? "الجُمُعَة الأُوَل" : "الجُمُعَة الثَانِي")", nameTransliteration: "\(index + 1 == 1 ? "First" : "Second") Jummuah", nameEnglish: "\(index + 1 == 1 ? "First" : "Second") Friday", time: jumuahTime, image: "sun.max.fill", rakah: 2, sunnahBefore: 0, sunnahAfter: 4))
                                }
                            } else {
                                let adhanDate = calendar.date(bySettingHour: calendar.component(.hour, from: adhanTime), minute: calendar.component(.minute, from: adhanTime), second: 0, of: currentDate) ?? currentDate
                                
                                let iqamahDate = calendar.date(bySettingHour: calendar.component(.hour, from: iqamahTime), minute: calendar.component(.minute, from: iqamahTime), second: 0, of: currentDate) ?? currentDate
                                
                                self.appendPrayer(for: name, adhanTime: adhanDate, iqamahTime: iqamahDate, into: &prayers)
                            }
                        } else if let sunriseDate = formatter.date(from: sunriseTime) {
                            let sunriseDateComponent = calendar.date(bySettingHour: calendar.component(.hour, from: sunriseDate), minute: calendar.component(.minute, from: sunriseDate), second: 0, of: currentDate) ?? currentDate
                            prayers.append(Prayer(nameArabic: "الشروق", nameTransliteration: "Shurooq", nameEnglish: "Sunrise", time: sunriseDateComponent, image: "sunrise.fill", rakah: 0, sunnahBefore: 0, sunnahAfter: 0))
                            prayers.append(Prayer(nameArabic: "الشروق", nameTransliteration: "Shurooq", nameEnglish: "Sunrise", time: sunriseDateComponent, image: "sunrise.fill", rakah: 0, sunnahBefore: 0, sunnahAfter: 0))
                        }
                    }

                    if !isFriday {
                        for li in firstTwoJumuahs {
                            let timeText = try li.select("b").first()?.text() ?? ""
                            
                            if let jumuahTime = formatter.date(from: timeText.trimmingCharacters(in: .whitespacesAndNewlines)) {
                                let jumuahDateComponent = calendar.date(bySettingHour: calendar.component(.hour, from: jumuahTime), minute: calendar.component(.minute, from: jumuahTime), second: 0, of: currentDate) ?? currentDate
                                jumuahTimes.append(jumuahDateComponent)
                            }
                        }
                        
                        for (index, jumuahTime) in jumuahTimes.enumerated() {
                            prayers.append(Prayer(nameArabic: "\(index + 1 == 1 ? "الجُمُعَة الأُوَل" : "الجُمُعَة الثَانِي")", nameTransliteration: "\(index + 1 == 1 ? "First" : "Second") Jummuah", nameEnglish: "\(index + 1 == 1 ? "First" : "Second") Friday", time: jumuahTime, image: "sun.max.fill", rakah: 2, sunnahBefore: 0, sunnahAfter: 4))
                        }
                    }
                    
                    print("Getting ICOI prayer times")
                    DispatchQueue.main.async {
                        let newPrayers = Prayers(day: currentDate, prayers: prayers, setNotification: false)
                        completion(newPrayers)
                    }
                    
                } catch {
                    print("Error parsing HTML: \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } else {
                print("Failed to load ICOI prayer data.")
                DispatchQueue.main.async {
                    completion(nil)
                }
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
            print("Unknown prayer name: \(name)")
        }
    }
    
    func fetchPrayerTimes(force: Bool = false, notification: Bool = false, completion: (() -> Void)? = nil) {
        var hasUpdatedDates = false
        var hasUpdatedNotifications = false
        
        if hijriDateArabic.isEmpty || hijriDateEnglish.isEmpty {
            updateDates()
            hasUpdatedDates = true
        }
        
        if !force && prayersICOI != nil && prayersICOI?.prayers.isEmpty == false && prayersICOI?.day.isSameDay(as: Date()) == true {
            print("Updated current and next prayer times")
            
            updateCurrentAndNextPrayer()
            
            if let prayersObject = prayersICOI, !prayersObject.setNotification || (notification && !hasUpdatedNotifications)  {
                schedulePrayerTimeNotifications()
                printAllScheduledNotifications()
                hasUpdatedNotifications = true
            }
            
            completion?()
        } else {
            print("New prayer times")
            if !hasUpdatedDates { updateDates() }
            
            getICOIPrayerTimes { prayers in
                withAnimation {
                    self.prayersICOI = prayers
                }
                self.updateCurrentAndNextPrayer()
                self.schedulePrayerTimeNotifications()
                self.printAllScheduledNotifications()
                WidgetCenter.shared.reloadAllTimelines()
                
                self.printAllScheduledNotifications()
                completion?()
            }
        }
    }
    
    func nextDate(for dayLabel: String, baseDate: Date = Date()) -> Date {
        let calendar = Calendar.current
        var weekdayNumber: Int?
        
        switch dayLabel.lowercased() {
        case "mon", "monday":
            weekdayNumber = 2
        case "tue", "tuesday":
            weekdayNumber = 3
        case "wed", "wednesday", "weds":
            weekdayNumber = 4
        case "thu", "thursday":
            weekdayNumber = 5
        case "fri", "friday":
            weekdayNumber = 6
        case "sat", "saturday":
            weekdayNumber = 7
        case "sun", "sunday":
            weekdayNumber = 1
        case "daily":
            return baseDate
        default:
            return baseDate
        }
        
        if let weekdayNumber = weekdayNumber,
           let next = calendar.nextDate(after: baseDate,
                                        matching: DateComponents(weekday: weekdayNumber),
                                        matchingPolicy: .nextTime) {
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
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        if let timeDate = formatter.date(from: combinedString) {
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
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching ICOI events: \(error.localizedDescription)")
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
                        
                        let event = Event(dayOfWeek: dayLabel,
                                          name: eventName,
                                          link: "",
                                          date: eventDate,
                                          time: eventTime,
                                          location: eventLocation)
                        eventsList.append(event)
                        
                        index += 2
                    }
                }
                
                let eventsModel = Events(events: eventsList, day: Date())
                DispatchQueue.main.async {
                    completion(eventsModel)
                }
            } catch {
                print("Error parsing HTML: \(error)")
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
            print("New events")
            
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
            print("Invalid URL")
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                // Convert the raw data to a string for parsing
                let html = String(data: data, encoding: .utf8)

                do {
                    // Parse HTML using SwiftSoup
                    let document = try SwiftSoup.parse(html ?? "")

                    // Grab all <p> elements that contain <span class="listing-phone">
                    // (this will pick up UMMA, Inland Leather, Accounting48, Dr. Q, etc.)
                    let businessElements = try document.select("p:has(span.listing-phone)")

                    var businesses: [Business] = []

                    for element in businessElements.array() {
                        // Get the entire text from <p>
                        // e.g. "Inland Leather +1 949 214 4436"
                        var pText = try element.text()

                        // Extract the phone text from within <span class="listing-phone">
                        // e.g. "+1 949 214 4436"
                        let phoneNumberRaw = try element.select("span.listing-phone").text()

                        // Convert that phone text to digits only
                        var phoneNumber = phoneNumberRaw
                            .components(separatedBy: CharacterSet.decimalDigits.inverted)
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
                        // (Might be an actual site like https://inlandleather.com/, or a PDF link, etc.)
                        let websiteLink = try element.select("a").first()?.attr("href") ?? ""

                        // Create the struct
                        let business = Business(
                            name: name,
                            phoneNumber: phoneNumber,
                            website: websiteLink
                        )
                        businesses.append(business)
                    }

                    // Wrap them in Businesses struct, and return
                    let fullBusinesses = Businesses(businesses: businesses, day: Date())
                    DispatchQueue.main.async {
                        completion(fullBusinesses)
                    }

                } catch {
                    print("Error parsing HTML: \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } else {
                print("Failed to fetch ICOI business data.")
                DispatchQueue.main.async {
                    completion(nil)
                }
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
            print("New businesses")
            
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
            let sortedRequests = requests.compactMap { request -> (date: Date, request: UNNotificationRequest)? in
                if let trigger = request.trigger as? UNCalendarNotificationTrigger,
                   let nextTriggerDate = trigger.nextTriggerDate() {
                    return (date: nextTriggerDate, request: request)
                }
                return nil
            }.sorted { $0.date < $1.date }

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"

            for sortedRequest in sortedRequests {
                let date = dateFormatter.string(from: sortedRequest.date)
                print("\(sortedRequest.request.content.body) at \(date)")
            }
        }
    }
    
    func schedulePrayerTimeNotifications() {
        #if !os(watchOS)
        guard let prayerObject = prayersICOI else { return }
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
        
        let weekday = Calendar.current.component(.weekday, from: Date())
        let isFriday = (weekday == 6)
        
        var prayerTimes = prayerObject.prayers
        
        if !isFriday {
            prayerTimes = prayerTimes.dropLast()
            prayerTimes = prayerTimes.dropLast()
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
            if let date = Calendar.current.nextDate(after: Date(), matching: components, matchingPolicy: .nextTime) {
                let content = UNMutableNotificationContent()
                content.title = "Islamic Center of Irvine (ICOI)"
                content.body = "Tap here if you want to rate the khutbah"
                content.sound = UNNotificationSound.default
                
                let triggerComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
                
                let request = UNNotificationRequest(identifier: "jummuahRating", content: content, trigger: trigger)
                center.add(request) { error in
                    if let e = error {
                        print("Error scheduling jummuahRating:", e.localizedDescription)
                    }
                }
            }
        }
        
        prayersICOI?.setNotification = true
        #endif
    }

    func scheduleNotification(for prayerTime: Prayer, preNotificationTime: Int?) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Islamic Center of Irvine (ICOI)"
        
        let baseTime = prayerTime.time
        var triggerTime = baseTime
        
        if let pre = preNotificationTime, pre != 0 {
            triggerTime = Calendar.current.date(byAdding: .minute, value: -pre, to: baseTime) ?? baseTime
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

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerTime)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { error in
            if let e = error {
                print("Error scheduling notification:", e.localizedDescription)
            }
        }
    }

    func scheduleKhateraNotification(for prayerTime: Prayer, minutesAfter: Int, name: String) {
        let center = UNUserNotificationCenter.current()
        let khateraDate = prayerTime.time.addingTimeInterval(TimeInterval(minutesAfter * 60))
        
        let content = UNMutableNotificationContent()
        content.title = "Islamic Center of Irvine (ICOI)"
        content.body = "Tap here to rate the \(name). You can turn this notification off in app."
        content.sound = .default
        
        let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: khateraDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        
        let request = UNNotificationRequest(identifier: "\(name)Notification", content: content, trigger: trigger)
        center.add(request) { error in
            if let e = error {
                print("Error scheduling khatera:", e.localizedDescription)
            }
        }
    }

    func requestNotificationAuthorization() {
        #if !os(watchOS)
        let center = UNUserNotificationCenter.current()

        center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                    DispatchQueue.main.async {
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
                    print("Permission denied")
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
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        #endif
        
        #if os(watchOS)
        WKInterfaceDevice.current().play(.click)
        #endif
    }
    
    let accentColor: Color = Color(red: 175 / 255, green: 28 / 255, blue: 51 / 255)
    let accentColor2: Color = Color(red: 255 / 255, green: 140 / 255, blue: 140 / 255)
    
    @AppStorage("hijriDateArabic") var hijriDateArabic: String = ""
    @AppStorage("hijriDateEnglish") var hijriDateEnglish: String = ""
    
    @Published var prayersICOIData: Data {
        didSet {
            if !prayersICOIData.isEmpty {
                appGroupUserDefaultsICOI?.setValue(prayersICOIData, forKey: "prayersICOIData")
            }
        }
    }
    var prayersICOI: Prayers? {
        get {
            let decoder = JSONDecoder()
            return try? decoder.decode(Prayers.self, from: prayersICOIData)
        }
        set {
            let encoder = JSONEncoder()
            prayersICOIData = (try? encoder.encode(newValue)) ?? Data()
        }
    }
    
    @Published var eventsICOIData: Data {
        didSet {
            if !eventsICOIData.isEmpty {
                appGroupUserDefaultsICOI?.setValue(eventsICOIData, forKey: "eventsICOIData")
            }
        }
    }
    var eventsICOI: Events? {
        get {
            let decoder = JSONDecoder()
            return try? decoder.decode(Events.self, from: eventsICOIData)
        }
        set {
            let encoder = JSONEncoder()
            eventsICOIData = (try? encoder.encode(newValue)) ?? Data()
        }
    }
    
    @Published var businessesICOIData: Data {
        didSet {
            if !businessesICOIData.isEmpty {
                appGroupUserDefaultsICOI?.setValue(businessesICOIData, forKey: "businessesICOIData")
            }
        }
    }
    var businessesICOI: Businesses? {
        get {
            let decoder = JSONDecoder()
            return try? decoder.decode(Businesses.self, from: businessesICOIData)
        }
        set {
            let encoder = JSONEncoder()
            businessesICOIData = (try? encoder.encode(newValue)) ?? Data()
        }
    }
    
    @AppStorage("currentPrayerICOIData") var currentPrayerICOIData: Data?
    @Published var currentPrayerICOI: Prayer? {
        didSet {
            let encoder = JSONEncoder()
            currentPrayerICOIData = try? encoder.encode(currentPrayerICOI)
        }
    }

    @AppStorage("nextPrayerICOIData") var nextPrayerICOIData: Data?
    @Published var nextPrayerICOI: Prayer? {
        didSet {
            let encoder = JSONEncoder()
            nextPrayerICOIData = try? encoder.encode(nextPrayerICOI)
        }
    }
    
    // Convert Settings object to a dictionary
    func dictionaryRepresentation() -> [String: Any] {
        let encoder = JSONEncoder()
        var dict: [String: Any] = [
            "beginnerMode": self.beginnerMode,
            "lastReadSurah": self.lastReadSurah,
            "lastReadAyah": self.lastReadAyah,
        ]
        
        do {
            dict["favoriteSurahsData"] = try encoder.encode(self.favoriteSurahs)
        } catch {
            print("Error encoding favoriteSurahs: \(error)")
        }

        do {
            dict["bookmarkedAyahsData"] = try encoder.encode(self.bookmarkedAyahs)
        } catch {
            print("Error encoding bookmarkedAyahs: \(error)")
        }

        do {
            dict["favoriteLetterData"] = try encoder.encode(self.favoriteLetters)
        } catch {
            print("Error encoding favoriteLetters: \(error)")
        }
        
        do {
            dict["prayersICOIData"] = try encoder.encode(self.prayersICOI)
        } catch {
            print("Error encoding prayers: \(error)")
        }
        
        do {
            if let eventsICOI = self.eventsICOI {
                dict["eventsICOIData"] = try encoder.encode(eventsICOI)
            }
        } catch {
            print("Error encoding eventsICOI: \(error)")
        }
        
        do {
            dict["businessesICOIData"] = try encoder.encode(self.businessesICOI)
        } catch {
            print("Error encoding businessesICOI: \(error)")
        }
        
        return dict
    }

    // Update Settings object from a dictionary
    func update(from dict: [String: Any]) {
        let decoder = JSONDecoder()
        if let beginnerMode = dict["beginnerMode"] as? Bool {
            self.beginnerMode = beginnerMode
        }
        if let lastReadSurah = dict["lastReadSurah"] as? Int {
            self.lastReadSurah = lastReadSurah
        }
        if let lastReadAyah = dict["lastReadAyah"] as? Int {
            self.lastReadAyah = lastReadAyah
        }
        if let favoriteSurahsData = dict["favoriteSurahsData"] as? Data {
            self.favoriteSurahs = (try? decoder.decode([Int].self, from: favoriteSurahsData)) ?? []
        }
        if let bookmarkedAyahsData = dict["bookmarkedAyahsData"] as? Data {
            self.bookmarkedAyahs = (try? decoder.decode([BookmarkedAyah].self, from: bookmarkedAyahsData)) ?? []
        }
        if let favoriteLetterData = dict["favoriteLetterData"] as? Data {
            self.favoriteLetters = (try? decoder.decode([LetterData].self, from: favoriteLetterData)) ?? []
        }
        
        if let prayersICOIData = dict["prayersICOIData"] as? Data {
            self.prayersICOI = try? decoder.decode(Prayers.self, from: prayersICOIData)
        }
        
        if let eventsICOIData = dict["eventsICOIData"] as? Data {
            self.eventsICOI = try? decoder.decode(Events.self, from: eventsICOIData)
        }
        
        if let businessesICOIData = dict["businessesICOIData"] as? Data {
            self.businessesICOI = try? decoder.decode(Businesses.self, from: businessesICOIData)
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
                return try JSONDecoder().decode(LastListenedSurah.self, from: data)
            } catch {
                print("Failed to decode last listened surah: \(error)")
                return nil
            }
        }
        set {
            if let newValue = newValue {
                do {
                    lastListenedSurahData = try JSONEncoder().encode(newValue)
                } catch {
                    print("Failed to encode last listened surah: \(error)")
                }
            } else {
                lastListenedSurahData = nil
            }
        }
    }
    
    @Published var favoriteSurahsData: Data {
        didSet {
            appGroupUserDefaults?.setValue(favoriteSurahsData, forKey: "favoriteSurahsData")
        }
    }
    var favoriteSurahs: [Int] {
        get {
            let decoder = JSONDecoder()
            return (try? decoder.decode([Int].self, from: favoriteSurahsData)) ?? []
        }
        set {
            let encoder = JSONEncoder()
            favoriteSurahsData = (try? encoder.encode(newValue)) ?? Data()
        }
    }
    
    @Published var favoriteSurahsCopy: [Int] = []

    @Published var bookmarkedAyahsData: Data {
        didSet {
            appGroupUserDefaults?.setValue(bookmarkedAyahsData, forKey: "bookmarkedAyahsData")
        }
    }
    var bookmarkedAyahs: [BookmarkedAyah] {
        get {
            let decoder = JSONDecoder()
            return (try? decoder.decode([BookmarkedAyah].self, from: bookmarkedAyahsData)) ?? []
        }
        set {
            let encoder = JSONEncoder()
            bookmarkedAyahsData = (try? encoder.encode(newValue)) ?? Data()
        }
    }
    
    @Published var bookmarkedAyahsCopy: [BookmarkedAyah] = []
    
    @AppStorage("showBookmarks") var showBookmarks = true
    @AppStorage("showFavorites") var showFavorites = true

    @Published var favoriteLetterData: Data {
        didSet {
            appGroupUserDefaults?.setValue(favoriteLetterData, forKey: "favoriteLetterData")
        }
    }
    var favoriteLetters: [LetterData] {
        get {
            let decoder = JSONDecoder()
            return (try? decoder.decode([LetterData].self, from: favoriteLetterData)) ?? []
        }
        set {
            let encoder = JSONEncoder()
            favoriteLetterData = (try? encoder.encode(newValue)) ?? Data()
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
    @AppStorage("showEnglishTranslation") var showEnglishTranslation: Bool = true
    
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
    
    func toggleSurahFavorite(surah: Surah) {
        withAnimation {
            if isSurahFavorite(surah: surah) {
                favoriteSurahs.removeAll(where: { $0 == surah.id })
            } else {
                favoriteSurahs.append(surah.id)
            }
        }
    }
    
    func toggleSurahFavoriteCopy(surah: Surah) {
        withAnimation {
            if isSurahFavoriteCopy(surah: surah) {
                favoriteSurahsCopy.removeAll(where: { $0 == surah.id })
            } else {
                favoriteSurahsCopy.append(surah.id)
            }
        }
    }

    func isSurahFavorite(surah: Surah) -> Bool {
        return favoriteSurahs.contains(surah.id)
    }
    
    func isSurahFavoriteCopy(surah: Surah) -> Bool {
        return favoriteSurahsCopy.contains(surah.id)
    }

    func toggleBookmark(surah: Int, ayah: Int) {
        withAnimation {
            let bookmark = BookmarkedAyah(surah: surah, ayah: ayah)
            if let index = bookmarkedAyahs.firstIndex(where: {$0.id == bookmark.id}) {
                bookmarkedAyahs.remove(at: index)
            } else {
                bookmarkedAyahs.append(bookmark)
            }
        }
    }
    
    func toggleBookmarkCopy(surah: Int, ayah: Int) {
        withAnimation {
            let bookmark = BookmarkedAyah(surah: surah, ayah: ayah)
            if let index = bookmarkedAyahsCopy.firstIndex(where: {$0.id == bookmark.id}) {
                bookmarkedAyahsCopy.remove(at: index)
            } else {
                bookmarkedAyahsCopy.append(bookmark)
            }
        }
    }

    func isBookmarked(surah: Int, ayah: Int) -> Bool {
        let bookmark = BookmarkedAyah(surah: surah, ayah: ayah)
        return bookmarkedAyahs.contains(where: {$0.id == bookmark.id})
    }
    
    func isBookmarkedCopy(surah: Int, ayah: Int) -> Bool {
        let bookmark = BookmarkedAyah(surah: surah, ayah: ayah)
        return bookmarkedAyahsCopy.contains(where: {$0.id == bookmark.id})
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

func arabicNumberString(from number: Int) -> String {
    let arabicNumbers = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"]
    let numberString = String(number)
    
    var arabicNumberString = ""
    for character in numberString {
        if let digit = Int(String(character)) {
            arabicNumberString += arabicNumbers[digit]
        }
    }
    return arabicNumberString
}

struct CustomColorSchemeKey: EnvironmentKey {
    static let defaultValue: ColorScheme? = nil
}

extension EnvironmentValues {
    var customColorScheme: ColorScheme? {
        get { self[CustomColorSchemeKey.self] }
        set { self[CustomColorSchemeKey.self] = newValue }
    }
}
