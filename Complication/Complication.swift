import WidgetKit
import SwiftUI

struct PrayersEntryView: View {
    var entry: PrayersProvider.Entry
    
    var body: some View {
        VStack {
            if let nextPrayer = entry.nextPrayer {
                VStack {
                    Image(systemName: nextPrayer.image)
                        .foregroundColor(nextPrayer.nameTransliteration == "Shurooq" ? .primary : nextPrayer.nameTransliteration.contains("Adhan") ? entry.color1 : entry.color2)
                    
                    Text(nextPrayer.time, style: .time)
                        .font(.caption)
                        .foregroundColor(nextPrayer.nameTransliteration == "Shurooq" ? .primary : nextPrayer.nameTransliteration.contains("Adhan") ? entry.color1 : entry.color2)
                }
            } else {
                Text("Open app")
                    .font(.caption)
                    .foregroundColor(entry.color1)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

@main
struct Complication: Widget {
    let kind: String = "Complication"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PrayersProvider()) { entry in
            PrayersEntryView(entry: entry)
        }
        .configurationDisplayName("Next Prayer")
    }
}
