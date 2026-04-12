import SwiftUI

struct ICOIPrayerCountdown: View {
    @EnvironmentObject var settings: Settings
    @Environment(\.scenePhase) private var scenePhase
    
    // Cache Calendar to avoid repeated lookups.
    private let calendar = Calendar.current
    
    @State private var progressToNextPrayer: Double = 0.0
    @State private var interval: TimeInterval = 60.0
    @State private var timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    func calculateProgress() -> Double {
        if let currentPrayer = settings.currentPrayerICOI, let nextPrayer = settings.nextPrayerICOI {
            let now = Date()

            let currentHour = calendar.component(.hour, from: currentPrayer.time)
            let nextHour = calendar.component(.hour, from: nextPrayer.time)
            let nowHour = calendar.component(.hour, from: now)

            // Adjust the currentPrayer and nextPrayer times based on the current time
            var currentPrayerAdjusted = currentPrayer.time
            var nextPrayerAdjusted = nextPrayer.time
            if currentHour > nowHour { // currentPrayer should be from "yesterday"
                currentPrayerAdjusted = calendar.date(byAdding: .day, value: -1, to: currentPrayer.time) ?? currentPrayer.time
            }
            if nextHour < nowHour { // nextPrayer should be for "tomorrow"
                nextPrayerAdjusted = calendar.date(byAdding: .day, value: 1, to: nextPrayer.time) ?? nextPrayer.time
            }

            let totalInterval = nextPrayerAdjusted.timeIntervalSince(currentPrayerAdjusted)
            let remainingInterval = nextPrayerAdjusted.timeIntervalSince(now)

            // Ensure valid intervals
            guard totalInterval > 0, remainingInterval >= 0, totalInterval >= remainingInterval else {
                return 0
            }

            // Clamp for numerical safety
            let progress = 1 - (remainingInterval / totalInterval)
            return min(max(progress, 0), 1)
        }
        return 0
    }
    
    private func setupTimer() {
        progressToNextPrayer = calculateProgress()
    }
    
    var body: some View {
        if let currentPrayer = settings.currentPrayerICOI, let nextPrayer = settings.nextPrayerICOI {
            Section(header:
                HStack {
                    Text("CURRENT")
                
                    Spacer()
                
                    Text("UPCOMING")
                }
            ) {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: currentPrayer.image)
                                
                                Text(currentPrayer.nameTransliteration)
                            }
                            .font(.title3)
                            .foregroundColor(currentPrayer.nameTransliteration == "Shurooq" ? .primary : settings.accentColor.color)
                            
                            Text("Started at \(currentPrayer.time, style: .time)")
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                            .background(settings.accentColor.color)
                            .padding(.horizontal, 2)
                        
                        VStack(alignment: .trailing) {
                            HStack {
                                Text(nextPrayer.nameTransliteration)
                                
                                Image(systemName: nextPrayer.image)
                            }
                            .font(.title3)
                            .foregroundColor(nextPrayer.nameTransliteration == "Shurooq" ? .primary : settings.accentColor.color)
                            
                            Text("Starts at \(nextPrayer.time, style: .time)")
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                    VStack(alignment: .leading) {
                        ProgressView(value: progressToNextPrayer, total: 1)
                            .onReceive(timer) { _ in
                                let newProgress = calculateProgress()
                                progressToNextPrayer = newProgress
                                if newProgress >= 1 {
                                    settings.fetchPrayerTimes()
                                    setupTimer()
                                }
                            }
                            .padding(.top, -4)
                        
                        Text("Time Left: \(nextPrayer.time, style: .timer)")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            }
            .onAppear {
                setupTimer()
            }
            .onChange(of: scenePhase) { _ in
                setupTimer()
            }
            .onChange(of: progressToNextPrayer) { value in
                if value >= 1 {
                    settings.fetchPrayerTimes()
                    setupTimer()
                }
            }
            .onChange(of: currentPrayer) { value in
                setupTimer()
            }
            .onChange(of: nextPrayer) { value in
                setupTimer()
            }
        }
    }
}

#Preview {
    ICOIPrayerView()
        .environmentObject(Settings.shared)
}
