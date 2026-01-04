import SwiftUI
import Foundation
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
        } else if self.reciter.isEmpty {
            self.reciter = "Muhammad Al-Minshawi (Murattal)"
        }
    }
    
    func updateCurrentAndNextPrayer() {
        guard let todayPrayersICOI = prayersICOI else {
            logger.debug("Failed to get today's ICOI prayer times")
            return
        }

        let calendar = Calendar.current
        let now = Date()

        // -------- Today list (remove Jumuah if not Friday TODAY) --------
        var todayList = todayPrayersICOI.prayers
        let isFridayToday = (calendar.component(.weekday, from: now) == 6)
        if !isFridayToday, todayList.count >= 2 {
            todayList.removeLast(2)
        }

        // Current + next within today
        let currentToday = todayList.last(where: { $0.time <= now })
        let nextToday = todayList.first(where: { $0.time > now })

        // If we have a next prayer today, use it
        if let nextToday {
            nextPrayerICOI = nextToday
            currentPrayerICOI = currentToday ?? todayList.last
            return
        }

        // -------- Otherwise, try tomorrow cache (real data) --------
        if let tmr = prayersICOITomorrow, !tmr.prayers.isEmpty {
            // Ensure it's actually tomorrow (not stale)
            if let expectedTomorrow = calendar.date(byAdding: .day, value: 1, to: todayPrayersICOI.day),
               tmr.day.isSameDay(as: expectedTomorrow) {

                var tmrList = tmr.prayers
                let isFridayTmr = (calendar.component(.weekday, from: tmr.day) == 6)
                if !isFridayTmr, tmrList.count >= 2 {
                    tmrList.removeLast(2)
                }

                if let firstTomorrow = tmrList.first {
                    nextPrayerICOI = firstTomorrow
                    currentPrayerICOI = currentToday ?? todayList.last
                    return
                }
            }
        }

        // -------- Otherwise, try day-after cache --------
        if let da = prayersICOIDayAfterTomorrow, !da.prayers.isEmpty {
            if let expectedDayAfter = calendar.date(byAdding: .day, value: 2, to: todayPrayersICOI.day),
               da.day.isSameDay(as: expectedDayAfter) {

                var daList = da.prayers
                let isFridayDA = (calendar.component(.weekday, from: da.day) == 6)
                if !isFridayDA, daList.count >= 2 {
                    daList.removeLast(2)
                }

                if let firstDayAfter = daList.first {
                    nextPrayerICOI = firstDayAfter
                    currentPrayerICOI = currentToday ?? todayList.last
                    return
                }
            }
        }

        // -------- Final fallback: old behavior (fake Fajr tomorrow) --------
        if let firstPrayerToday = todayList.first,
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

        currentPrayerICOI = currentToday ?? todayList.last
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
        guard let url = URL(string: "https://themasjidapp.org/80220/prayers") else {
            logger.debug("Invalid URL")
            DispatchQueue.main.async { completion(nil) }
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil,
                  let data = data,
                  let html = String(data: data, encoding: .utf8) else {
                logger.debug("Failed to load ICOI prayer data.")
                DispatchQueue.main.async { completion(nil) }
                return
            }

            // Time parsing (e.g. "5:31AM")
            struct Cache {
                static let timeFormatter: DateFormatter = {
                    let f = DateFormatter()
                    f.locale = Locale(identifier: "en_US_POSIX")
                    f.dateFormat = "h:mma"
                    return f
                }()
            }
            let timeFormatter = Cache.timeFormatter

            // =========================================================
            // Helpers
            // =========================================================
            func isoNow(_ date: Date, in tz: TimeZone) -> String {
                let f = ISO8601DateFormatter()
                f.timeZone = tz
                f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                return f.string(from: date)
            }

            func normalizeTimeText(_ raw: String) -> String {
                raw
                    .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .uppercased()
                    .replacingOccurrences(of: " ", with: "")
            }

            func isPlaceholderTime(_ raw: String) -> Bool {
                let cleaned = normalizeTimeText(raw)
                return cleaned.isEmpty || cleaned == "—" || cleaned == "-" || cleaned == "NULL" || cleaned == "NIL"
            }

            /// Backfill lookup for sparse iqamas (and safe for adhan too).
            func backfillTimeString(
                table: [String: Any]?,
                startKey: Int,
                field: String,
                maxLookback: Int,
                label: String
            ) -> (value: String?, foundKey: Int?) {
                guard let table else { return (nil, nil) }

                for delta in 0...maxLookback {
                    let k = startKey - delta
                    guard k >= 1 else { break }

                    guard let dayDict = table[String(k)] as? [String: Any] else { continue }
                    if let s = dayDict[field] as? String, !isPlaceholderTime(s) {
                        if delta == 0 {
                            logger.debug("✅ \(label) \(field) found on key=\(k): \(normalizeTimeText(s))")
                        } else {
                            logger.debug("↩️ \(label) \(field) missing on key=\(startKey), backfilled from key=\(k): \(normalizeTimeText(s))")
                        }
                        return (s, k)
                    }
                }

                logger.debug("❌ \(label) \(field) not found for key=\(startKey) within lookback=\(maxLookback)")
                return (nil, nil)
            }

            /// Combine a time string like "5:31AM" into a Date on `baseDay` (in masjid tz calendar).
            func createPrayerDate(from timeText: String, calendar: Calendar, baseDay: Date) -> Date? {
                let cleaned = normalizeTimeText(timeText)
                if isPlaceholderTime(cleaned) { return nil }

                guard let time = timeFormatter.date(from: cleaned) else { return nil }

                return calendar.date(
                    bySettingHour: calendar.component(.hour, from: time),
                    minute: calendar.component(.minute, from: time),
                    second: 0,
                    of: baseDay
                )
            }

            /// Always returns: Fajr pair, 2x Sunrise, Dhuhr pair, Asr pair, Maghrib pair, Isha pair,
            /// and adds 2x Jumuah at the end on non-Fridays (based on THAT day’s weekday).
            func buildDayPrayers(
                targetDate: Date,
                dayKeyInt: Int,
                calendar: Calendar,
                imported: [String: Any]?,
                iqamas: [String: Any]?,
                events: [[String: Any]]?
            ) -> [Prayer] {
                let baseDay = calendar.startOfDay(for: targetDate)
                let weekday = calendar.component(.weekday, from: targetDate)
                let isFridayForThatDay = (weekday == 6)

                logger.debug("---- BuildDay ---- date=\(isoNow(targetDate, in: calendar.timeZone)) key=\(dayKeyInt) isFriday=\(isFridayForThatDay)")

                var out: [Prayer] = []
                out.reserveCapacity(16)

                // Adhan fields (imported): fajr, sunrise, zuhr, asr, maghrib, isha
                let fajrAdhanS    = backfillTimeString(table: imported, startKey: dayKeyInt, field: "fajr",    maxLookback: 30, label: "Adhan").value
                let sunriseS      = backfillTimeString(table: imported, startKey: dayKeyInt, field: "sunrise", maxLookback: 30, label: "Adhan").value
                let zuhrAdhanS    = backfillTimeString(table: imported, startKey: dayKeyInt, field: "zuhr",    maxLookback: 30, label: "Adhan").value
                let asrAdhanS     = backfillTimeString(table: imported, startKey: dayKeyInt, field: "asr",     maxLookback: 30, label: "Adhan").value
                let maghribAdhanS = backfillTimeString(table: imported, startKey: dayKeyInt, field: "maghrib", maxLookback: 30, label: "Adhan").value
                let ishaAdhanS    = backfillTimeString(table: imported, startKey: dayKeyInt, field: "isha",    maxLookback: 30, label: "Adhan").value

                // Iqamah fields (iqamas): fajr, dhuhr, asr, maghrib, isha
                let fajrIqamaS    = backfillTimeString(table: iqamas, startKey: dayKeyInt, field: "fajr",    maxLookback: 60, label: "Iqama").value
                let dhuhrIqamaS   = backfillTimeString(table: iqamas, startKey: dayKeyInt, field: "dhuhr",   maxLookback: 60, label: "Iqama").value
                let asrIqamaS     = backfillTimeString(table: iqamas, startKey: dayKeyInt, field: "asr",     maxLookback: 60, label: "Iqama").value
                let maghribIqamaS = backfillTimeString(table: iqamas, startKey: dayKeyInt, field: "maghrib", maxLookback: 60, label: "Iqama").value
                let ishaIqamaS    = backfillTimeString(table: iqamas, startKey: dayKeyInt, field: "isha",    maxLookback: 60, label: "Iqama").value

                // Fajr
                if let fajrAdhanS, let fajrIqamaS,
                   let adhanTime = createPrayerDate(from: fajrAdhanS, calendar: calendar, baseDay: baseDay),
                   let iqamahTime = createPrayerDate(from: fajrIqamaS, calendar: calendar, baseDay: baseDay) {
                    self.appendPrayer(for: "Fajr", adhanTime: adhanTime, iqamahTime: iqamahTime, into: &out)
                } else {
                    logger.debug("⚠️ Missing Fajr pair: adhan=\(fajrAdhanS ?? "nil") iqama=\(fajrIqamaS ?? "nil")")
                }

                // Sunrise x2
                if let sunriseS,
                   let sunriseTime = createPrayerDate(from: sunriseS, calendar: calendar, baseDay: baseDay) {
                    out.append(Prayer(nameArabic: "الشروق", nameTransliteration: "Shurooq", nameEnglish: "Sunrise",
                                      time: sunriseTime, image: "sunrise.fill", rakah: 0, sunnahBefore: 0, sunnahAfter: 0))
                    out.append(Prayer(nameArabic: "الشروق", nameTransliteration: "Shurooq", nameEnglish: "Sunrise",
                                      time: sunriseTime, image: "sunrise.fill", rakah: 0, sunnahBefore: 0, sunnahAfter: 0))
                } else {
                    logger.debug("⚠️ Missing Sunrise: \(sunriseS ?? "nil")")
                }

                // Dhuhr (adhan key is zuhr)
                if let zuhrAdhanS, let dhuhrIqamaS,
                   let adhanTime = createPrayerDate(from: zuhrAdhanS, calendar: calendar, baseDay: baseDay),
                   let iqamahTime = createPrayerDate(from: dhuhrIqamaS, calendar: calendar, baseDay: baseDay) {
                    self.appendPrayer(for: "Dhuhr", adhanTime: adhanTime, iqamahTime: iqamahTime, into: &out)
                } else {
                    logger.debug("⚠️ Missing Dhuhr pair: adhan=\(zuhrAdhanS ?? "nil") iqama=\(dhuhrIqamaS ?? "nil")")
                }

                // Asr
                if let asrAdhanS, let asrIqamaS,
                   let adhanTime = createPrayerDate(from: asrAdhanS, calendar: calendar, baseDay: baseDay),
                   let iqamahTime = createPrayerDate(from: asrIqamaS, calendar: calendar, baseDay: baseDay) {
                    self.appendPrayer(for: "Asr", adhanTime: adhanTime, iqamahTime: iqamahTime, into: &out)
                } else {
                    logger.debug("⚠️ Missing Asr pair: adhan=\(asrAdhanS ?? "nil") iqama=\(asrIqamaS ?? "nil")")
                }

                // Maghrib
                if let maghribAdhanS, let maghribIqamaS,
                   let adhanTime = createPrayerDate(from: maghribAdhanS, calendar: calendar, baseDay: baseDay),
                   let iqamahTime = createPrayerDate(from: maghribIqamaS, calendar: calendar, baseDay: baseDay) {
                    self.appendPrayer(for: "Maghrib", adhanTime: adhanTime, iqamahTime: iqamahTime, into: &out)
                } else {
                    logger.debug("⚠️ Missing Maghrib pair: adhan=\(maghribAdhanS ?? "nil") iqama=\(maghribIqamaS ?? "nil")")
                }

                // Isha
                if let ishaAdhanS, let ishaIqamaS,
                   let adhanTime = createPrayerDate(from: ishaAdhanS, calendar: calendar, baseDay: baseDay),
                   let iqamahTime = createPrayerDate(from: ishaIqamaS, calendar: calendar, baseDay: baseDay) {
                    self.appendPrayer(for: "Isha", adhanTime: adhanTime, iqamahTime: iqamahTime, into: &out)
                } else {
                    logger.debug("⚠️ Missing Isha pair: adhan=\(ishaAdhanS ?? "nil") iqama=\(ishaIqamaS ?? "nil")")
                }

                // Jumuah events (same behavior)
                if let events = events {
                    let jumuahEvents = events
                        .filter { ($0["isJuma"] as? Bool) == true }
                        .sorted { ($0["order"] as? Int ?? 0) < ($1["order"] as? Int ?? 0) }

                    for (index, e) in jumuahEvents.enumerated() {
                        let timeDesc = (e["timeDesc"] as? String ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
                        if let t = createPrayerDate(from: timeDesc, calendar: calendar, baseDay: baseDay) {
                            out.append(
                                Prayer(
                                    nameArabic: index == 0 ? "الجُمُعَة الأُوَل" : "الجُمُعَة الثَانِي",
                                    nameTransliteration: "\(index == 0 ? "First" : "Second") Jumuah",
                                    nameEnglish: "\(index == 0 ? "First" : "Second") Friday",
                                    time: t,
                                    image: "sun.max.fill",
                                    rakah: 2,
                                    sunnahBefore: 0,
                                    sunnahAfter: 4
                                )
                            )
                        }
                    }
                }

                // On NON-Fridays for that day, move Jumuah to end (your exact existing style)
                if !isFridayForThatDay {
                    let jumuahPrayers = out.filter { $0.nameTransliteration.contains("Jumuah") }
                    out.removeAll { $0.nameTransliteration.contains("Jumuah") }
                    out.append(contentsOf: jumuahPrayers)
                }

                // Final sanity logs
                let sunriseCount = out.filter { $0.nameEnglish == "Sunrise" }.count
                logger.debug("BuildDay result count=\(out.count) sunriseCount=\(sunriseCount)")

                return out
            }

            // =========================================================
            // Parse & build (prefer NEXT_DATA)
            // =========================================================
            do {
                let document = try SwiftSoup.parse(html)

                if let nextDataEl = try document.select("script#__NEXT_DATA__").first() {
                    let nextDataString = try nextDataEl.html()

                    if let nextData = nextDataString.data(using: .utf8),
                       let json = try JSONSerialization.jsonObject(with: nextData) as? [String: Any] {

                        let props = json["props"] as? [String: Any]
                        let pageProps = props?["pageProps"] as? [String: Any]
                        let masjid = pageProps?["masjid"] as? [String: Any]

                        let tzID = masjid?["timezone"] as? String ?? "America/Los_Angeles"
                        let tz = TimeZone(identifier: tzID) ?? .current

                        var calendar = Calendar(identifier: .gregorian)
                        calendar.timeZone = tz

                        let now = Date()

                        guard let dayOfYearToday = calendar.ordinality(of: .day, in: .year, for: now) else {
                            throw NSError(domain: "ICOI", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to compute dayOfYear"])
                        }

                        // Tables
                        let azanParams = masjid?["azanParams"] as? [String: Any]
                        let imported = (azanParams?["imported"] as? [String: Any])
                        let iqamas = (masjid?["iqamas"] as? [String: Any])
                        let events = (masjid?["events"] as? [[String: Any]])

                        logger.debug("========== ICOI NEXT_DATA DEBUG ==========")
                        logger.debug("Masjid timezone: \(tzID)")
                        logger.debug("Now (masjid tz): \(isoNow(now, in: tz))")
                        logger.debug("Computed dayOfYear key today: \(dayOfYearToday)")
                        logger.debug("Imported table present? \(imported != nil)")
                        logger.debug("Iqamas table present? \(iqamas != nil)")
                        logger.debug("Events present? \(events != nil)")
                        logger.debug("=========================================")

                        if imported == nil {
                            logger.debug("❌ NEXT_DATA: imported table missing. Falling back to HTML.")
                        } else {
                            // Build 3 days
                            let todayDate = now
                            let tomorrowDate = calendar.date(byAdding: .day, value: 1, to: todayDate) ?? todayDate.addingTimeInterval(86400)
                            let dayAfterDate = calendar.date(byAdding: .day, value: 2, to: todayDate) ?? todayDate.addingTimeInterval(86400 * 2)

                            let keyToday = dayOfYearToday
                            let keyTomorrow = calendar.ordinality(of: .day, in: .year, for: tomorrowDate) ?? (keyToday + 1)
                            let keyDayAfter = calendar.ordinality(of: .day, in: .year, for: dayAfterDate) ?? (keyToday + 2)

                            logger.debug("📅 Building keys: today=\(keyToday) tomorrow=\(keyTomorrow) dayAfter=\(keyDayAfter)")

                            let prayersToday = buildDayPrayers(
                                targetDate: todayDate,
                                dayKeyInt: keyToday,
                                calendar: calendar,
                                imported: imported,
                                iqamas: iqamas,
                                events: events
                            )

                            let prayersTomorrow = buildDayPrayers(
                                targetDate: tomorrowDate,
                                dayKeyInt: keyTomorrow,
                                calendar: calendar,
                                imported: imported,
                                iqamas: iqamas,
                                events: events
                            )

                            let prayersDayAfter = buildDayPrayers(
                                targetDate: dayAfterDate,
                                dayKeyInt: keyDayAfter,
                                calendar: calendar,
                                imported: imported,
                                iqamas: iqamas,
                                events: events
                            )

                            // Completeness check (today must be good or we fallback)
                            let englishNames = prayersToday.map(\.nameEnglish)
                            let hasCore =
                                englishNames.contains("Dawn") &&
                                englishNames.contains("Noon") &&
                                englishNames.contains("Afternoon") &&
                                englishNames.contains("Sunset") &&
                                englishNames.contains("Night")

                            let sunriseCount = prayersToday.filter { $0.nameEnglish == "Sunrise" }.count
                            let hasSunriseTwice = (sunriseCount >= 2)

                            logger.debug("NEXT_DATA today count=\(prayersToday.count) hasCore=\(hasCore) sunriseCount=\(sunriseCount)")

                            if hasCore && hasSunriseTwice {
                                logger.debug("✅ Getting ICOI prayer times (NEXT_DATA + backfilled iqamas) + next 2 days")

                                DispatchQueue.main.async {
                                    // A) Two variables for each next day (same Prayers style)
                                    self.prayersICOITomorrow = Prayers(day: tomorrowDate, prayers: prayersTomorrow, setNotification: false)
                                    self.prayersICOIDayAfterTomorrow = Prayers(day: dayAfterDate, prayers: prayersDayAfter, setNotification: false)

                                    // Today (original completion)
                                    completion(Prayers(day: todayDate, prayers: prayersToday, setNotification: false))
                                }
                                return
                            } else {
                                logger.debug("⚠️ NEXT_DATA today incomplete after backfill. Falling back to HTML.")
                            }
                        }
                    }
                }

                // =========================================================
                // HTML fallback (kept simple: today only)
                // =========================================================
                var prayers: [Prayer] = []
                prayers.reserveCapacity(16)

                let rows = try document.select("tbody tr").array()

                let calendar = Calendar.current
                let currentDate = Date()
                let weekday = Calendar.current.component(.weekday, from: currentDate)
                let isFriday = weekday == 6

                // Use device calendar for fallback (matches your prior behavior)
                for row in rows {
                    let cells = try row.select("td").array()
                    guard cells.count >= 2 else { continue }

                    let nameCell = try cells[0].text().trimmingCharacters(in: .whitespacesAndNewlines)

                    if nameCell.lowercased().contains("jumuah") {
                        let timesText = try cells[1].text()
                        let times = timesText.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

                        for (index, timeStr) in times.enumerated() {
                            let cleaned = normalizeTimeText(String(timeStr))
                            if isPlaceholderTime(cleaned) { continue }
                            if let time = timeFormatter.date(from: cleaned) {
                                let t = calendar.date(
                                    bySettingHour: calendar.component(.hour, from: time),
                                    minute: calendar.component(.minute, from: time),
                                    second: 0,
                                    of: currentDate
                                ) ?? currentDate

                                prayers.append(
                                    Prayer(
                                        nameArabic: index == 0 ? "الجُمُعَة الأُوَل" : "الجُمُعَة الثَانِي",
                                        nameTransliteration: "\(index == 0 ? "First" : "Second") Jumuah",
                                        nameEnglish: "\(index == 0 ? "First" : "Second") Friday",
                                        time: t,
                                        image: "sun.max.fill",
                                        rakah: 2,
                                        sunnahBefore: 0,
                                        sunnahAfter: 4
                                    )
                                )
                            }
                        }
                        continue
                    }

                    guard cells.count >= 3 else { continue }

                    let beginsText = try cells[1].text()
                    let iqamaText = try cells[2].text()

                    if nameCell.lowercased().contains("sunrise") {
                        let cleaned = normalizeTimeText(beginsText)
                        if !isPlaceholderTime(cleaned), let time = timeFormatter.date(from: cleaned) {
                            let sunriseTime = calendar.date(
                                bySettingHour: calendar.component(.hour, from: time),
                                minute: calendar.component(.minute, from: time),
                                second: 0,
                                of: currentDate
                            ) ?? currentDate

                            prayers.append(Prayer(nameArabic: "الشروق", nameTransliteration: "Shurooq", nameEnglish: "Sunrise",
                                                  time: sunriseTime, image: "sunrise.fill", rakah: 0, sunnahBefore: 0, sunnahAfter: 0))
                            prayers.append(Prayer(nameArabic: "الشروق", nameTransliteration: "Shurooq", nameEnglish: "Sunrise",
                                                  time: sunriseTime, image: "sunrise.fill", rakah: 0, sunnahBefore: 0, sunnahAfter: 0))
                        }
                        continue
                    }

                    if iqamaText != "—" {
                        let beginsClean = normalizeTimeText(beginsText)
                        let iqamaClean = normalizeTimeText(iqamaText)

                        guard !isPlaceholderTime(beginsClean), !isPlaceholderTime(iqamaClean) else { continue }
                        guard let adhanTime = timeFormatter.date(from: beginsClean),
                              let iqamahTime = timeFormatter.date(from: iqamaClean) else { continue }

                        let adhanDate = calendar.date(
                            bySettingHour: calendar.component(.hour, from: adhanTime),
                            minute: calendar.component(.minute, from: adhanTime),
                            second: 0,
                            of: currentDate
                        ) ?? currentDate

                        let iqamaDate = calendar.date(
                            bySettingHour: calendar.component(.hour, from: iqamahTime),
                            minute: calendar.component(.minute, from: iqamahTime),
                            second: 0,
                            of: currentDate
                        ) ?? currentDate

                        self.appendPrayer(for: nameCell, adhanTime: adhanDate, iqamahTime: iqamaDate, into: &prayers)
                    }
                }

                if !isFriday {
                    let jumuahPrayers = prayers.filter { $0.nameTransliteration.contains("Jumuah") }
                    prayers.removeAll { $0.nameTransliteration.contains("Jumuah") }
                    prayers.append(contentsOf: jumuahPrayers)
                }

                logger.debug("Getting ICOI prayer times (HTML fallback)")

                DispatchQueue.main.async {
                    // If we had to fallback, clear the next-day cached variables (so you don’t show stale next days)
                    self.prayersICOITomorrow = nil
                    self.prayersICOIDayAfterTomorrow = nil

                    completion(Prayers(day: currentDate, prayers: prayers, setNotification: false))
                }
            } catch {
                logger.debug("Error parsing HTML: \(error)")
                DispatchQueue.main.async { completion(nil) }
            }
        }

        task.resume()
    }

    func appendPrayer(for name: String, adhanTime: Date, iqamahTime: Date, into prayers: inout [Prayer]) {
        let prayerName = name.capitalized
        
        switch prayerName {
        case let n where n.contains("Fajr"):
            prayers.append(Prayer(nameArabic: "أذان الفجر", nameTransliteration: "Fajr Adhan", nameEnglish: "Dawn", time: adhanTime, image: "sunrise", rakah: 2, sunnahBefore: 2, sunnahAfter: 0))
            prayers.append(Prayer(nameArabic: "إقامة الفجر", nameTransliteration: "Fajr Iqamah", nameEnglish: "Dawn", time: iqamahTime, image: "sunrise", rakah: 2, sunnahBefore: 2, sunnahAfter: 0))
            
        case let n where n.contains("Dhuhr"):
            prayers.append(Prayer(nameArabic: "أذان الظهر", nameTransliteration: "Dhuhr Adhan", nameEnglish: "Noon", time: adhanTime, image: "sun.max", rakah: 4, sunnahBefore: 4, sunnahAfter: 2))
            prayers.append(Prayer(nameArabic: "إقامة الظهر", nameTransliteration: "Dhuhr Iqamah", nameEnglish: "Noon", time: iqamahTime, image: "sun.max", rakah: 4, sunnahBefore: 4, sunnahAfter: 2))
            
        case let n where n.contains("Asr"):
            prayers.append(Prayer(nameArabic: "أذان العصر", nameTransliteration: "Asr Adhan", nameEnglish: "Afternoon", time: adhanTime, image: "sun.min", rakah: 4, sunnahBefore: 0, sunnahAfter: 0))
            prayers.append(Prayer(nameArabic: "إقامة العصر", nameTransliteration: "Asr Iqamah", nameEnglish: "Afternoon", time: iqamahTime, image: "sun.min", rakah: 4, sunnahBefore: 0, sunnahAfter: 0))
            
        case let n where n.contains("Maghrib"):
            prayers.append(Prayer(nameArabic: "أذان المغرب", nameTransliteration: "Maghrib Adhan", nameEnglish: "Sunset", time: adhanTime, image: "sunset", rakah: 3, sunnahBefore: 0, sunnahAfter: 2))
            prayers.append(Prayer(nameArabic: "إقامة المغرب", nameTransliteration: "Maghrib Iqamah", nameEnglish: "Sunset", time: iqamahTime, image: "sunset", rakah: 3, sunnahBefore: 0, sunnahAfter: 2))
            
        case let n where n.contains("Isha"):
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

        // ---------------------------------------------------------
        // Keep your existing refresh reminders (unchanged)
        // ---------------------------------------------------------
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

        func shiftDays(_ date: Date, by days: Int) -> Date {
            cal.date(byAdding: .day, value: days, to: date) ?? date.addingTimeInterval(TimeInterval(days * 86400))
        }

        if let shurooq = prayers.first(where: { $0.nameTransliteration == "Shurooq" }),
           let dhuhrAdhan = prayers.first(where: { $0.nameTransliteration == "Dhuhr Adhan" }) {

            for d in 2...3 {
                let start = shiftDays(shurooq.time, by: d)
                let end   = shiftDays(dhuhrAdhan.time, by: d)
                guard end > start else { continue }

                let midpoint = Date(timeIntervalSince1970: (start.timeIntervalSince1970 + end.timeIntervalSince1970) / 2.0)
                if midpoint > now {
                    let comps = cal.dateComponents([.year, .month, .day, .hour, .minute], from: midpoint)
                    let content = UNMutableNotificationContent()
                    content.title = "Islamic Center of Irvine"
                    content.body  = "Please open the app to refresh today’s prayer times and notifications."
                    content.sound = .default

                    let trig = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
                    let req  = UNNotificationRequest(identifier: "RefreshMidpointShurooqDhuhr+\(d)", content: content, trigger: trig)
                    center.add(req) { error in
                        if let e = error {
                            logger.debug("Error scheduling midpoint +\(d): \(e.localizedDescription)")
                        }
                    }
                }
            }
        }

        // ---------------------------------------------------------
        // CHANGE: Only do "tomorrow Fajr/Shurooq clone" fallback
        // if we do NOT already have *VALID* cached tomorrow/day-after.
        // ---------------------------------------------------------
        func hasValidCachedDay(_ obj: Prayers?, expectedOffsetDays: Int) -> Bool {
            guard let obj, !obj.prayers.isEmpty else { return false }
            guard let base = prayersICOI?.day else { return false }
            guard let expected = cal.date(byAdding: .day, value: expectedOffsetDays, to: base) else { return false }
            return obj.day.isSameDay(as: expected)
        }

        let hasTomorrow = hasValidCachedDay(prayersICOITomorrow, expectedOffsetDays: 1)
        let hasDayAfter = hasValidCachedDay(prayersICOIDayAfterTomorrow, expectedOffsetDays: 2)

        guard !(hasTomorrow || hasDayAfter) else {
            return
        }

        // ---------------------------------------------------------
        // Your existing fallback cloning (unchanged), now gated
        // ---------------------------------------------------------
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

        // Schedules one day's prayers
        func scheduleDay(_ prayersObj: Prayers) {
            var list = prayersObj.prayers

            // Friday logic based on THAT day
            let isFridayForThatDay = (calendar.component(.weekday, from: prayersObj.day) == 6)

            // Remove Jumuah slots on non-Fridays
            if !isFridayForThatDay, list.count >= 2 {
                list.removeLast(2)
            }

            // Prevent Shurooq scheduling twice (because the list intentionally contains 2)
            var shurooqScheduledKeys = Set<String>()
            shurooqScheduledKeys.reserveCapacity(2)

            for prayerTime in list {
                if prayerTime.nameTransliteration == "Shurooq" {
                    let comps = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: prayerTime.time)
                    let key = "Shurooq-\(comps.year ?? 0)-\(comps.month ?? 0)-\(comps.day ?? 0)-\(comps.hour ?? 0)-\(comps.minute ?? 0)"
                    if !shurooqScheduledKeys.insert(key).inserted { continue }
                }

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

                case "First Jumuah":
                    notification = firstJumuah
                    preNotificationTime = firstJumuahPreNotification

                case "Second Jumuah":
                    notification = secondJumuah
                    preNotificationTime = secondJumuahPreNotification

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

                if notification, let m = preNotificationTime, m > 0 {
                    scheduleNotification(for: prayerTime, preNotificationTime: m)
                }
            }
        }

        scheduleDay(prayerObject)

        if let tmr = prayersICOITomorrow, !tmr.prayers.isEmpty {
            scheduleDay(tmr)
        }
        if let da = prayersICOIDayAfterTomorrow, !da.prayers.isEmpty {
            scheduleDay(da)
        }

        if ratingJumuah {
            let components = DateComponents(hour: 15, minute: 0, weekday: 6)
            if let date = calendar.nextDate(after: Date(), matching: components, matchingPolicy: .nextTime) {
                let content = UNMutableNotificationContent()
                content.title = "Islamic Center of Irvine"
                content.body = "Tap here if you want to rate the khutbah"
                content.sound = .default

                let triggerComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)

                let request = UNNotificationRequest(identifier: "jumuahRating", content: content, trigger: trigger)
                center.add(request) { error in
                    if let e = error {
                        logger.debug("Error scheduling jumuahRating: \(e.localizedDescription)")
                    }
                }
            }
        }

        var todayList = prayerObject.prayers
        let isFridayToday = (calendar.component(.weekday, from: prayerObject.day) == 6)
        if !isFridayToday, todayList.count >= 2 {
            todayList.removeLast(2)
        }
        scheduleDailyRefreshReminders(using: center, prayers: todayList)

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
    
    @AppStorage("prayersICOITomorrowData", store: UserDefaults(suiteName: "group.com.ICOI.AppGroup")!)
    private var prayersICOITomorrowRaw: Data = Data() {
        didSet { objectWillChange.send() }
    }

    var prayersICOITomorrow: Prayers? {
        get {
            guard !prayersICOITomorrowRaw.isEmpty else { return nil }
            return try? Self.decoder.decode(Prayers.self, from: prayersICOITomorrowRaw)
        }
        set {
            if let newValue, let data = try? Self.encoder.encode(newValue) {
                prayersICOITomorrowRaw = data
            } else {
                prayersICOITomorrowRaw = Data()
            }
        }
    }

    @AppStorage("prayersICOIDayAfterTomorrowData", store: UserDefaults(suiteName: "group.com.ICOI.AppGroup")!)
    private var prayersICOIDayAfterTomorrowRaw: Data = Data() {
        didSet { objectWillChange.send() }
    }

    var prayersICOIDayAfterTomorrow: Prayers? {
        get {
            guard !prayersICOIDayAfterTomorrowRaw.isEmpty else { return nil }
            return try? Self.decoder.decode(Prayers.self, from: prayersICOIDayAfterTomorrowRaw)
        }
        set {
            if let newValue, let data = try? Self.encoder.encode(newValue) {
                prayersICOIDayAfterTomorrowRaw = data
            } else {
                prayersICOIDayAfterTomorrowRaw = Data()
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
    
    @AppStorage("firstJumuah") var firstJumuah: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("secondJumuah") var secondJumuah: Bool = true {
        didSet { fetchPrayerTimes(notification: true) }
    }
    
    @AppStorage("ratingJumuah") var ratingJumuah: Bool = true {
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

    @AppStorage("firstJumuahPreNotification") var firstJumuahPreNotification: Int = 0 {
        didSet { fetchPrayerTimes(notification: true) }
    }

    @AppStorage("secondJumuahPreNotification") var secondJumuahPreNotification: Int = 0 {
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
    
    var favoriteSurahSet: Set<Int> { Set(favoriteSurahs) }
    var bookmarkedAyahSet: Set<String> { Set(bookmarkedAyahs.map(\.id)) }
        
    @AppStorage("showBookmarks") var showBookmarks = true
    @AppStorage("showFavorites") var showFavorites = true
    
    @AppStorage("shareShowAyahInformation") var showAyahInformation: Bool = true
    @AppStorage("shareShowSurahInformation") var showSurahInformation: Bool = false

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
