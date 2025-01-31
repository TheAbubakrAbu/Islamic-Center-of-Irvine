import WidgetKit
import SwiftUI

struct PrayersProvider: TimelineProvider {
    var settings = Settings.shared

    let appGroupUserDefaults = UserDefaults(suiteName: "group.com.ICOI.AppGroup")

    func getPrayersICOI() {
        if let data = appGroupUserDefaults?.data(forKey: "prayersICOIData") {
            let decoder = JSONDecoder()
            if let prayers = try? decoder.decode(Prayers.self, from: data) {
                settings.prayersICOI = prayers
            }
        }
    }
    
    func updateAdhanAndIqamah(prayers: Prayers) -> (currentAdhan: Prayer?, nextAdhan: Prayer?, currentIqamah: Prayer?, nextIqamah: Prayer?) {
        let now = Date()
        
        let adhansToday = prayers.prayers.filter { $0.nameTransliteration.contains("Adhan") }
        let iqamahsToday = prayers.prayers.filter { $0.nameTransliteration.contains("Iqamah") }
        
        let currentAdhan = adhansToday.last { $0.time <= now }
        let currentIqamah = iqamahsToday.last { $0.time <= now }
        
        var nextAdhan = adhansToday.first { $0.time > now }
        var nextIqamah = iqamahsToday.first { $0.time > now }
        
        if nextAdhan == nil {
            nextAdhan = getNextDayPrayer(prayers: adhansToday)
        }
        
        if nextIqamah == nil {
            nextIqamah = getNextDayPrayer(prayers: iqamahsToday)
        }
        
        return (currentAdhan, nextAdhan, currentIqamah, nextIqamah)
    }

    func getNextDayPrayer(prayers: [Prayer]) -> Prayer? {
        guard let firstPrayer = prayers.first else { return nil }
        return Prayer(nameArabic: firstPrayer.nameArabic,
                      nameTransliteration: firstPrayer.nameTransliteration,
                      nameEnglish: firstPrayer.nameEnglish,
                      time: Calendar.current.date(byAdding: .day, value: 1, to: firstPrayer.time)!,
                      image: firstPrayer.image,
                      rakah: firstPrayer.rakah,
                      sunnahBefore: firstPrayer.sunnahBefore,
                      sunnahAfter: firstPrayer.sunnahAfter)
    }
    
    func placeholder(in context: Context) -> PrayersEntry {
        getPrayersICOI()
        
        if let prayers = settings.prayersICOI, let current = settings.currentPrayerICOI, let next = settings.nextPrayerICOI {
            let times = updateAdhanAndIqamah(prayers: prayers)
            
            return PrayersEntry(date: Date(), color1: settings.accentColor, color2: settings.accentColor2, prayers: prayers.prayers, currentPrayer: current, nextPrayer: next, currentAdhan: times.currentAdhan, nextAdhan: times.nextAdhan, currentIqamah: times.currentIqamah, nextIqamah: times.nextIqamah)
        }
        
        return PrayersEntry(date: Date(), color1: settings.accentColor, color2: settings.accentColor2, prayers: [], currentPrayer: nil, nextPrayer: nil, currentAdhan: nil, nextAdhan: nil, currentIqamah: nil, nextIqamah: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (PrayersEntry) -> Void) {
        getPrayersICOI()
        
        settings.fetchPrayerTimes {
            if let prayers = self.settings.prayersICOI, let current = self.settings.currentPrayerICOI, let next = self.settings.nextPrayerICOI {
                let times = updateAdhanAndIqamah(prayers: prayers)
                
                let entry = PrayersEntry(date: Date(), color1: settings.accentColor, color2: settings.accentColor2, prayers: prayers.prayers, currentPrayer: current, nextPrayer: next, currentAdhan: times.currentAdhan, nextAdhan: times.nextAdhan, currentIqamah: times.currentIqamah, nextIqamah: times.nextIqamah)
                
                completion(entry)
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<PrayersEntry>) -> ()) {
        getPrayersICOI()
        
        settings.fetchPrayerTimes {
            var entries: [PrayersEntry] = []
            
            if let prayers = self.settings.prayersICOI, let current = self.settings.currentPrayerICOI, let next = self.settings.nextPrayerICOI {
                let times = updateAdhanAndIqamah(prayers: prayers)
                
                let entry = PrayersEntry(date: Date(), color1: settings.accentColor, color2: settings.accentColor2, prayers: prayers.prayers, currentPrayer: current, nextPrayer: next, currentAdhan: times.currentAdhan, nextAdhan: times.nextAdhan, currentIqamah: times.currentIqamah, nextIqamah: times.nextIqamah)

                entries.append(entry)
                
                let timeline = Timeline(entries: entries, policy: .after(entries.last?.date ?? Date()))
                completion(timeline)
            }
        }
    }
}

struct PrayersEntry: TimelineEntry {
    let date: Date
    let color1: Color
    let color2: Color
    let prayers: [Prayer]
    
    let currentPrayer: Prayer?
    let nextPrayer: Prayer?
    
    let currentAdhan: Prayer?
    let nextAdhan: Prayer?
    
    let currentIqamah: Prayer?
    let nextIqamah: Prayer?
}
