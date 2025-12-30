import WidgetKit
import SwiftUI

struct PrayerEntryView: View {
    @Environment(\.widgetFamily) var widgetFamily

    var entry: PrayersProvider.Entry
    
    var hijriCalendar: Calendar = {
        var calendar = Calendar(identifier: .islamicUmmAlQura)
        calendar.locale = Locale(identifier: "ar")
        return calendar
    }()
    
    var hijriDate1: String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = hijriCalendar
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "en")
        return dateFormatter.string(from: Date())
    }
    
    var hijriDate2: String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = hijriCalendar
        dateFormatter.dateStyle = .full
        dateFormatter.locale = Locale(identifier: "en")
        return dateFormatter.string(from: Date())
    }
    
    func formattedName(for name: String) -> String {
        if name == "First Jumuah" {
            return "1st Jumuah"
        } else if name == "Second Jumuah" {
            return "2nd Jumuah"
        } else {
            return name
        }
    }

    var body: some View {
        VStack {
            if entry.prayers.isEmpty {
                Text("Open app to get prayer times")
                    .foregroundColor(entry.color1)
            } else {
                if let currentPrayer = entry.currentPrayer, let nextPrayer = entry.nextPrayer {
                    VStack {
                        if widgetFamily == .systemMedium {
                            Text(hijriDate2)
                                .lineLimit(1)
                                .foregroundColor(entry.color1)
                                .font(.caption)
                                .padding(.top, 2)
                            
                            Spacer()
                            
                            Divider()
                                .background(entry.color1)
                                .padding(.bottom, 2)
                                .padding(.horizontal, 4)
                            
                            Spacer()
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: currentPrayer.image)
                                            .font(.subheadline)
                                            .foregroundColor(currentPrayer.nameTransliteration == "Shurooq" ? .primary : currentPrayer.nameTransliteration.contains("Adhan") ? entry.color1 : entry.color2)
                                        
                                        Text(formattedName(for: currentPrayer.nameTransliteration))
                                            .font(.headline)
                                            .foregroundColor(currentPrayer.nameTransliteration == "Shurooq" ? .primary : currentPrayer.nameTransliteration.contains("Adhan") ? entry.color1 : entry.color2)
                                        
                                        Spacer()
                                        
                                        Text("Time left: \(nextPrayer.time, style: .timer)")
                                            .font(.caption)
                                    }
                                    .padding(.leading, 6)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 4)
                            
                            HStack {
                                Spacer()
                                VStack(alignment: .trailing) {
                                    HStack {
                                        Text("Starts at \(nextPrayer.time, style: .time)")
                                            .font(.caption)
                                        
                                        Text(formattedName(for: nextPrayer.nameTransliteration))
                                            .font(.headline)
                                            .foregroundColor(nextPrayer.nameTransliteration == "Shurooq" ? .primary : nextPrayer.nameTransliteration.contains("Adhan") ? entry.color1 : entry.color2)
                                        
                                        Image(systemName: nextPrayer.image)
                                            .font(.subheadline)
                                            .foregroundColor(nextPrayer.nameTransliteration == "Shurooq" ? .primary : nextPrayer.nameTransliteration.contains("Adhan") ? entry.color1 : entry.color2)
                                    }
                                    .padding(.top, -4)
                                }
                            }
                            .padding(.horizontal, 4)
                            
                            Spacer()
                        } else {
                            Spacer()
                            
                            HStack {
                                Text(hijriDate1)
                                    .lineLimit(1)
                                    .foregroundColor(entry.color1)
                                    .font(.caption2)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Image(systemName: currentPrayer.image)
                                    .font(.subheadline)
                                    .foregroundColor(currentPrayer.nameTransliteration == "Shurooq" ? .primary : currentPrayer.nameTransliteration.contains("Adhan") ? entry.color1 : entry.color2)
                                
                                Text(formattedName(for: currentPrayer.nameTransliteration))
                                    .font(.headline)
                                    .foregroundColor(currentPrayer.nameTransliteration == "Shurooq" ? .primary : currentPrayer.nameTransliteration.contains("Adhan") ? entry.color1 : entry.color2)
                                    .padding(.top, 0.5)
                                    .padding(.bottom, -6)
                                
                                Text("Next: \(formattedName(for: nextPrayer.nameTransliteration))")
                                    .font(.caption2)
                                
                                Text("Starts at \(nextPrayer.time, style: .time)")
                                    .font(.caption2)
                                
                                Divider()
                                    .background(entry.color1)
                                    .padding(.vertical, -4)
                                
                                Text("Time left: \(nextPrayer.time, style: .timer)")
                                    .font(.caption2)
                                    .padding(.top, -4)
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
        }
        .lineLimit(1)
        .minimumScaleFactor(0.85)
    }
}

struct CountdownWidget: Widget {
    let kind: String = "CountdownWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PrayersProvider()) { entry in
            if #available(iOS 17, *) {
                PrayerEntryView(entry: entry)
            } else {
                PrayerEntryView(entry: entry)
                    .padding()
            }
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Prayer Countdown")
        .description("View the current and next prayer times")
    }
}
