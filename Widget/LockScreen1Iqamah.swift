import WidgetKit
import SwiftUI

struct LockScreen1IqamahView: View {
    var entry: PrayersProvider.Entry

    var body: some View {
        VStack(alignment: .center) {
            if entry.prayers.isEmpty {
                Text("Open app to get prayer times")
                    .font(.caption)
            } else {
                if let nextPrayer = entry.nextIqamah {
                    Text(nextPrayer.nameTransliteration)
                        .font(.caption2)
                        .multilineTextAlignment(.center)
                    
                    Text(nextPrayer.time, style: .time)
                        .font(.caption2)
                }
            }
        }
    }
}

struct LockScreen1IqamahWidget: Widget {
    let kind: String = "LockScreen1Iqamah"

    var body: some WidgetConfiguration {
        #if os(iOS)
        if #available(iOS 16, *) {
            return StaticConfiguration(kind: kind, provider: PrayersProvider()) { entry in
                LockScreen1EntryView(entry: entry)
            }
            .supportedFamilies([.accessoryCircular])
            .configurationDisplayName("Next Iqamah Time")
            .description("View the next Iqamah time")
        } else {
            return StaticConfiguration(kind: kind, provider: PrayersProvider()) { entry in
                LockScreen1EntryView(entry: entry)
            }
            .supportedFamilies([.systemSmall])
            .configurationDisplayName("Next Iqamah Time")
            .description("View the next Iqamah time")
        }
        #endif
        
        #if os(macOS)
        return StaticConfiguration(kind: kind, provider: PrayersProvider()) { entry in
            LockScreen1EntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("Next Iqamah Time")
        .description("View the next Iqamah time")
        #endif
    }
}
