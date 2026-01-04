import SwiftUI

struct ICOIPrayerList: View {
    @EnvironmentObject var settings: Settings
    
    @State private var selectedDay: DaySelection = .today
    
    private enum DaySelection: Int, CaseIterable, Identifiable {
        case today = 0
        case tomorrow = 1
        case dayAfterTomorrow = 2
        var id: Int { rawValue }
    }
    
    private func columnWidth(for textStyle: UIFont.TextStyle, extra: CGFloat = 4, sample: String? = nil, fontName: String? = nil) -> CGFloat {
        let sampleString = (sample ?? "M") as NSString
        let font: UIFont

        if let fontName = fontName, let customFont = UIFont(name: fontName, size: UIFont.preferredFont(forTextStyle: textStyle).pointSize) {
            font = customFont
        } else {
            font = UIFont.preferredFont(forTextStyle: textStyle)
        }

        return ceil(sampleString.size(withAttributes: [.font: font]).width) + extra
    }

    private var glyphWidth: CGFloat {
        columnWidth(for: .subheadline, extra: 0, sample: "88:88 PM")
    }
    
    private func label(for selection: DaySelection) -> String {
        let calendar = Calendar.current
        let date: Date
        
        switch selection {
        case .today:
            date = settings.prayersICOI?.day ?? Date()
        case .tomorrow:
            date = settings.prayersICOITomorrow?.day ?? calendar.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        case .dayAfterTomorrow:
            date = settings.prayersICOIDayAfterTomorrow?.day ?? calendar.date(byAdding: .day, value: 2, to: Date()) ?? Date()
        }
        
        struct Cache {
            static let df: DateFormatter = {
                let f = DateFormatter()
                f.locale = Locale.current
                f.dateStyle = .medium
                f.timeStyle = .none
                return f
            }()
        }
        
        let dayText: String
        switch selection {
        case .today: dayText = "Today"
        case .tomorrow: dayText = "Tomorrow"
        case .dayAfterTomorrow: dayText = "Day After"
        }
        
        return "\(dayText) • \(Cache.df.string(from: date))"
    }
    
    private var selectedPrayersObject: Prayers? {
        switch selectedDay {
        case .today:
            return settings.prayersICOI
        case .tomorrow:
            return settings.prayersICOITomorrow
        case .dayAfterTomorrow:
            return settings.prayersICOIDayAfterTomorrow
        }
    }
    
    private var selectedDateForFridayCheck: Date {
        selectedPrayersObject?.day ?? Date()
    }
    
    private var hasToday: Bool {
        (settings.prayersICOI?.prayers.isEmpty == false)
    }

    private var hasTomorrow: Bool {
        (settings.prayersICOITomorrow?.prayers.isEmpty == false)
    }

    private var hasDayAfter: Bool {
        (settings.prayersICOIDayAfterTomorrow?.prayers.isEmpty == false)
    }

    private var availableSelections: [DaySelection] {
        var list: [DaySelection] = []
        if hasToday { list.append(.today) }
        if hasTomorrow { list.append(.tomorrow) }
        if hasDayAfter { list.append(.dayAfterTomorrow) }
        return list
    }

    private func clampSelection(_ desired: DaySelection) -> DaySelection {
        if availableSelections.contains(desired) { return desired }
        return availableSelections.first ?? .today
    }
    
    var body: some View {
        if let prayersObject = selectedPrayersObject, !prayersObject.prayers.isEmpty {
            let prayers = prayersObject.prayers
            let halfCount = prayers.count / 2
            
            let calendar = Calendar.current
            let isFridayForThatDay = calendar.component(.weekday, from: selectedDateForFridayCheck) == 6
            
            // Highlight should ONLY track “today/current” when viewing TODAY.
            let shouldHighlight = (selectedDay == .today)
            let currentShortenedTransliterationFirst = settings.currentPrayerICOI?.nameTransliteration.split(separator: " ").first ?? ""
            let isJumuahCurrent = settings.currentPrayerICOI?.nameTransliteration.contains("Jumuah") ?? false
            
            Section(header: Text("PRAYER TIMES")) {
                ForEach(0..<halfCount, id: \.self) { i in
                    let index1 = i * 2
                    let index2 = i * 2 + 1
                    
                    let prayer1 = prayers[index1]
                    let prayer2 = prayers[index2]
                    
                    let parts1 = prayer1.nameTransliteration.split(separator: " ")
                    let shortenedTransliteration1 = parts1.first ?? ""
                    let shortenedTransliteration3 = parts1.last ?? ""
                    let isJumuahAtIndex = prayer1.nameTransliteration.contains("Jumuah")
                    
                    let isHighlighted = shouldHighlight &&
                    ((shortenedTransliteration1 == currentShortenedTransliterationFirst) || (isJumuahCurrent && isJumuahAtIndex))
                    
                    let isShurooq = (shortenedTransliteration1 == "Shurooq")
                    let isJumuahTitle = (shortenedTransliteration3 == "Jumuah")
                    let isDimmedJumuah = (!isFridayForThatDay && isJumuahTitle)
                    let iconColor: Color = isShurooq ? .primary : (isDimmedJumuah ? .secondary : settings.accentColor)
                    let titleColor: Color = isDimmedJumuah ? .secondary : .primary
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(isHighlighted ? settings.accentColor.opacity(0.25) : .clear)
                            .padding(.horizontal, -12)
                            #if !os(watchOS)
                            .padding(.vertical, -11)
                            #endif
                        
                        VStack(alignment: .leading) {
                            #if !os(watchOS)
                            HStack {
                                Image(systemName: prayer1.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(iconColor)
                                    .padding(.all, 4)
                                    .padding(.trailing, 8)
                                
                                VStack(alignment: .leading) {
                                    Text(isJumuahTitle ? shortenedTransliteration3 : shortenedTransliteration1)
                                        .font(.headline)
                                        .foregroundColor(titleColor)
                                    
                                    Text(isJumuahTitle ? "Friday" : prayer1.nameEnglish)
                                        .font(.subheadline)
                                        .foregroundColor(titleColor)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    if isShurooq {
                                        Text("Fajr ends:")
                                            .foregroundColor(.secondary)
                                            .font(.subheadline)
                                        
                                        Text("\(prayer1.time, style: .time)")
                                            .foregroundColor(.secondary)
                                            .font(.subheadline)
                                    } else if isJumuahTitle {
                                        HStack(spacing: 0) {
                                            Text("1st:")
                                            Text(prayer1.time, style: .time)
                                                .frame(width: glyphWidth, alignment: .trailing)
                                        }
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)

                                        HStack(spacing: 0) {
                                            Text("2nd:")
                                            Text(prayer2.time, style: .time)
                                                .frame(width: glyphWidth, alignment: .trailing)
                                        }
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    } else {
                                        HStack(spacing: 0) {
                                            Text("Adhan:")
                                            Text(prayer1.time, style: .time)
                                                .frame(width: glyphWidth, alignment: .trailing)
                                        }
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)

                                        HStack(spacing: 0) {
                                            Text("Iqama:")
                                            Text(prayer2.time, style: .time)
                                                .frame(width: glyphWidth, alignment: .trailing)
                                        }
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    }
                                }
                            }
                            #else
                            HStack {
                                Image(systemName: prayer1.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(iconColor)
                                    .padding(.all, 4)
                                    .padding(.trailing, 8)
                                
                                VStack(alignment: .leading) {
                                    Text(isJumuahTitle ? shortenedTransliteration3 : shortenedTransliteration1)
                                        .font(.headline)
                                        .foregroundColor(titleColor)
                                    
                                    Text(isJumuahTitle ? "Friday" : prayer1.nameEnglish)
                                        .font(.subheadline)
                                        .foregroundColor(titleColor)
                                }
                                
                                Spacer()
                            }
                            
                            VStack(alignment: .leading) {
                                if isShurooq {
                                    Text("Fajr ends \(prayer1.time, style: .time)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                } else if isJumuahTitle {
                                    Text("First: \(prayer1.time, style: .time)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    
                                    Text("Second: \(prayer2.time, style: .time)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                } else {
                                    Text("Adhan: \(prayer1.time, style: .time)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    
                                    Text("Iqama: \(prayer2.time, style: .time)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                }
                            }
                            #endif
                        }
                        .padding(.vertical, 4)
                        .foregroundColor(isShurooq ? .primary : settings.accentColor)
                    }
                }
                
                #if !os(watchOS)
                VStack(alignment: .leading, spacing: 8) {
                    Picker("Showing", selection: $selectedDay) {
                        ForEach(availableSelections) { sel in
                            Text(label(for: sel)).tag(sel)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .padding(.top, 4)
                #endif
            }
            .onChange(of: settings.prayersICOI?.day) { _ in
                selectedDay = .today
            }
            .onChange(of: settings.prayersICOITomorrow?.day) { _ in
                let clamped = clampSelection(selectedDay)
                if clamped != selectedDay {
                    selectedDay = clamped
                }
            }
            .onChange(of: settings.prayersICOIDayAfterTomorrow?.day) { _ in
                let clamped = clampSelection(selectedDay)
                if clamped != selectedDay {
                    selectedDay = clamped
                }
            }
        }
    }
}

#Preview {
    ICOIPrayerView()
        .environmentObject(Settings.shared)
}
