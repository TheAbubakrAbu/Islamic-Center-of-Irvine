import WidgetKit
import SwiftUI

struct PrayersProvider: TimelineProvider {
    private let settings = Settings.shared

    private let appGroupStore = UserDefaults(suiteName: "group.com.ICOI.AppGroup")!

    private func loadPrayersICOIFromGroup() -> Prayers? {
        guard let data = appGroupStore.data(forKey: "prayersICOIData"),
              let prayers = try? Settings.decoder.decode(Prayers.self, from: data)
        else { return nil }
        return prayers
    }

    private func updateAdhanAndIqamah(prayers: Prayers) -> (currentAdhan: Prayer?, nextAdhan: Prayer?, currentIqamah: Prayer?, nextIqamah: Prayer?) {
        let now = Date()

        func lower(_ s: String?) -> String { (s ?? "").lowercased() }

        func isJummuah(_ p: Prayer) -> Bool {
            let t = lower(p.nameTransliteration)
            let e = lower(p.nameEnglish)
            return t.contains("jummu") || t.contains("jumma") || t.contains("jumu") ||
                   e.contains("friday") || t.contains("khutbah") || e.contains("khutbah")
        }

        func isAdhan(_ p: Prayer) -> Bool {
            let t = lower(p.nameTransliteration)
            let e = lower(p.nameEnglish)
            return t.contains("adhan") || e.contains("adhan")
        }

        func isIqamah(_ p: Prayer) -> Bool {
            let t = lower(p.nameTransliteration)
            let e = lower(p.nameEnglish)
            return t.contains("iqama") || e.contains("iqama") || isJummuah(p)
        }

        let all = prayers.prayers.sorted { $0.time < $1.time }
        let adhans  = all.filter(isAdhan)
        let iqamahs = all.filter(isIqamah)

        let currentAdhan  = adhans.last(where:  { $0.time <= now })
        let currentIqamah = iqamahs.last(where: { $0.time <= now })

        var nextAdhan  = adhans.first(where:  { $0.time > now })
        var nextIqamah = iqamahs.first(where: { $0.time > now })

        if nextAdhan == nil, let first = adhans.first { nextAdhan = nextDayVersion(of: first) }
        if nextIqamah == nil, let first = iqamahs.first { nextIqamah = nextDayVersion(of: first) }

        return (currentAdhan, nextAdhan, currentIqamah, nextIqamah)
    }

    private func nextDayVersion(of prayer: Prayer?) -> Prayer? {
        guard let p = prayer,
              let nextTime = Calendar.current.date(byAdding: .day, value: 1, to: p.time)
        else { return nil }
        return Prayer(
            nameArabic: p.nameArabic,
            nameTransliteration: p.nameTransliteration,
            nameEnglish: p.nameEnglish,
            time: nextTime,
            image: p.image,
            rakah: p.rakah,
            sunnahBefore: p.sunnahBefore,
            sunnahAfter: p.sunnahAfter
        )
    }

    private func makeEntry(from prayers: Prayers?, fallbackDate: Date = Date()) -> PrayersEntry {
        let p = prayers?.prayers ?? []
        let current = settings.currentPrayerICOI
        let next    = settings.nextPrayerICOI

        let times = prayers.map(updateAdhanAndIqamah)
        return PrayersEntry(
            date: fallbackDate,
            color1: settings.accentColor,
            color2: settings.accentColor2,
            prayers: p,
            currentPrayer: current,
            nextPrayer: next,
            currentAdhan: times?.currentAdhan,
            nextAdhan: times?.nextAdhan,
            currentIqamah: times?.currentIqamah,
            nextIqamah: times?.nextIqamah
        )
    }

    private func nextRefreshDate(for prayers: Prayers?) -> Date {
        let now = Date()
        guard let list = prayers?.prayers, !list.isEmpty else {
            // No data? Try again in ~30 minutes
            return Calendar.current.date(byAdding: .minute, value: 30, to: now) ?? now.addingTimeInterval(1800)
        }
        
        // Refresh shortly after the next prayer boundary or in 30 min, whichever is sooner
        let upcoming = list.filter { $0.time > now }.min(by: { $0.time < $1.time })?.time
        let soft = Calendar.current.date(byAdding: .minute, value: 30, to: now) ?? now.addingTimeInterval(1800)
        if let u = upcoming {
            return min(u.addingTimeInterval(5), soft)
        }
        
        return soft
    }

    func placeholder(in context: Context) -> PrayersEntry {
        let prayers = settings.prayersICOI ?? loadPrayersICOIFromGroup()
        return makeEntry(from: prayers)
    }

    func getSnapshot(in context: Context, completion: @escaping (PrayersEntry) -> Void) {
        if settings.prayersICOI == nil, let cached = loadPrayersICOIFromGroup() {
            settings.prayersICOI = cached
            settings.updateCurrentAndNextPrayer()
        }

        settings.fetchPrayerTimes {
            let prayers = settings.prayersICOI ?? loadPrayersICOIFromGroup()
            completion(makeEntry(from: prayers))
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<PrayersEntry>) -> Void) {
        if settings.prayersICOI == nil, let cached = loadPrayersICOIFromGroup() {
            settings.prayersICOI = cached
            settings.updateCurrentAndNextPrayer()
        }

        settings.fetchPrayerTimes {
            let prayers = settings.prayersICOI ?? loadPrayersICOIFromGroup()
            let entry = makeEntry(from: prayers)
            let refresh = nextRefreshDate(for: prayers)
            completion(Timeline(entries: [entry], policy: .after(refresh)))
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
