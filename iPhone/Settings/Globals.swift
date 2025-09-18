import SwiftUI

struct Prayers: Identifiable, Codable, Equatable {
    var id = UUID()
    let day: Date
    let prayers: [Prayer]
    var setNotification: Bool
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
    var uniqueKey: String {
        "\(name)-\(date.timeIntervalSince1970)-\(location)"
    }
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

struct ShareSettings: Equatable {
    var arabic = false
    var transliteration = false
    var englishSaheeh = false
    var englishMustafa = false
    var showFooter = false
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

private let quranStripScalars: Set<UnicodeScalar> = {
    var s = Set<UnicodeScalar>()

    // Tashkeel  U+064B…U+065F
    for v in 0x064B...0x065F { if let u = UnicodeScalar(v) { s.insert(u) } }

    // Quranic annotation signs  U+06D6…U+06ED
    for v in 0x06D6...0x06ED { if let u = UnicodeScalar(v) { s.insert(u) } }

    // Extras: short alif, madda, open ta-marbuta, dagger alif
    [0x0670, 0x0657, 0x0674, 0x0656].forEach { v in
        if let u = UnicodeScalar(v) { s.insert(u) }
    }

    return s
}()

extension String {
    var removingArabicDiacriticsAndSigns: String {
        var out = String.UnicodeScalarView()
        out.reserveCapacity(unicodeScalars.count)

        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x0671: // ٱ  hamzatul-wasl
                out.append(UnicodeScalar(0x0627)!)
            default:
                if !quranStripScalars.contains(scalar) { out.append(scalar) }
            }
        }
        return String(out)
    }

    subscript(_ r: Range<Int>) -> Substring {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return self[start..<end]
    }
}
