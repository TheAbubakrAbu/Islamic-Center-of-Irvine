import WidgetKit
import SwiftUI

struct LockScreen2EntryView: View {
    var entry: PrayersProvider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            if entry.prayers.isEmpty {
                Text("Open app to get prayer times")
                    .font(.caption)
            } else {
                if let currentPrayer = entry.currentPrayer, let nextPrayer = entry.nextPrayer {
                    HStack {
                        Image(systemName: currentPrayer.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 13, height: 13)
                            .padding(.trailing, -4)
                        
                        Text(currentPrayer.nameTransliteration)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    
                    Text("Time left: \(nextPrayer.time, style: .timer)")
                        .font(.caption)
                    
                    Text("\(nextPrayer.nameTransliteration) at \(nextPrayer.time, style: .time)")
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                        .padding(.top, -4)
                }
            }
        }
        .lineLimit(1)
    }
}

struct LockScreen2Widget: Widget {
    let kind: String = "LockScreen2Widget"

    var body: some WidgetConfiguration {
        #if os(iOS)
        if #available(iOS 16, *) {
            return StaticConfiguration(kind: kind, provider: PrayersProvider()) { entry in
                LockScreen2EntryView(entry: entry)
            }
            .supportedFamilies([.accessoryRectangular])
            .configurationDisplayName("Prayer Times")
            .description("View the current and next prayer times")
        } else {
            return StaticConfiguration(kind: kind, provider: PrayersProvider()) { entry in
                LockScreen2EntryView(entry: entry)
            }
            .supportedFamilies([.systemSmall])
            .configurationDisplayName("Prayer Times")
            .description("View the current and next prayer times")
        }
        #endif
        
        #if os(macOS)
        return StaticConfiguration(kind: kind, provider: PrayersProvider()) { entry in
            LockScreen2EntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("Prayer Times")
        .description("View the current and next prayer times")
        #endif
    }
}
