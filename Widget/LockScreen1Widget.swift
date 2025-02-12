import WidgetKit
import SwiftUI

struct LockScreen1EntryView: View {
    var entry: PrayersProvider.Entry

    var body: some View {
        VStack(alignment: .center) {
            if entry.prayers.isEmpty {
                Text("Open app to get prayer times")
                    .font(.caption)
            } else {
                if let nextPrayer = entry.nextPrayer {
                    Text(nextPrayer.nameTransliteration)
                        .font(.caption2)
                        .multilineTextAlignment(.center)
                    
                    Text(nextPrayer.time, style: .time)
                        .font(.caption2)
                }
            }
        }
        .lineLimit(1)
        .minimumScaleFactor(0.5)
    }
}

struct LockScreen1Widget: Widget {
    let kind: String = "LockScreen1Widget"

    var body: some WidgetConfiguration {
        #if os(iOS)
        if #available(iOS 16, *) {
            return StaticConfiguration(kind: kind, provider: PrayersProvider()) { entry in
                LockScreen1EntryView(entry: entry)
            }
            .supportedFamilies([.accessoryCircular])
            .configurationDisplayName("Next Prayer Time")
            .description("View the next prayer time")
        } else {
            return StaticConfiguration(kind: kind, provider: PrayersProvider()) { entry in
                LockScreen1EntryView(entry: entry)
            }
            .supportedFamilies([.systemSmall])
            .configurationDisplayName("Next Prayer Time")
            .description("View the next prayer time")
        }
        #endif
        
        #if os(macOS)
        return StaticConfiguration(kind: kind, provider: PrayersProvider()) { entry in
            LockScreen1EntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("Next Prayer Time")
        .description("View the next prayer time")
        #endif
    }
}
