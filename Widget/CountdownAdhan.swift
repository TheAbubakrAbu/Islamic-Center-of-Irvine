import WidgetKit
import SwiftUI

struct CountdownAdhan: View {
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

    var body: some View {
        VStack {
            if entry.prayers.isEmpty {
                Text("Open app to get prayer times")
                    .foregroundColor(entry.color1)
            } else {
                if let currentPrayer = entry.currentAdhan, let nextPrayer = entry.nextAdhan {
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
                                            .foregroundColor(entry.color1)
                                        
                                        Text(currentPrayer.nameTransliteration)
                                            .font(.headline)
                                            .foregroundColor(entry.color1)
                                        
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
                                        
                                        Text(nextPrayer.nameTransliteration)
                                            .font(.headline)
                                            .foregroundColor(entry.color1)
                                        
                                        Image(systemName: nextPrayer.image)
                                            .font(.subheadline)
                                            .foregroundColor(entry.color1)
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
                                    .foregroundColor(entry.color1)
                                
                                Text(currentPrayer.nameTransliteration)
                                    .font(.headline)
                                    .foregroundColor(entry.color1)
                                    .padding(.top, 0.5)
                                    .padding(.bottom, -6)
                                
                                Text("Next: \(nextPrayer.nameTransliteration)")
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
    }
}

struct CountdownAdhanWidget: Widget {
    let kind: String = "CountdownAdhanWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PrayersProvider()) { entry in
            if #available(iOS 17, *) {
                CountdownAdhan(entry: entry)
            } else {
                CountdownAdhan(entry: entry)
                    .padding()
            }
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Adhan Countdown")
        .description("View the current and next Adhan times")
    }
}
