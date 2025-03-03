import SwiftUI

struct ICOIPrayerView: View {
    @EnvironmentObject var settings: Settings
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var activeAlert: ICOIAlertType?
    
    enum ICOIAlertType: Identifiable {
        case notficationError
        case prayerTimeFetchError
        case showVisitWebsiteButton
        case jummuahRating
        case khateraRating
        
        var id: Int {
            switch self {
            case .notficationError:
                return 0
            case .prayerTimeFetchError:
                return 1
            case .showVisitWebsiteButton:
                return 2
            case .jummuahRating:
                return 3
            case .khateraRating:
                return 4
            }
        }
    }
    
    @AppStorage("lastJummuahRatingTimestamp") private var lastJummuahRatingTimestamp: Double?
    
    private func askForJummuahRating() {
        lastJummuahRatingTimestamp = Date().timeIntervalSinceReferenceDate
        activeAlert = .jummuahRating
    }
    
    @AppStorage("lastKhateraRatingTimestamp") private var lastKhateraRatingTimestamp: Double?
    
    private func askForKhateraRating() {
        lastKhateraRatingTimestamp = Date().timeIntervalSinceReferenceDate
        activeAlert = .khateraRating
    }
    
    private func promptForJummuahOrKhateraRatingIfNeeded() {
        #if !os(watchOS)
        let today = Date()
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: today)
        let isFriday = dayOfWeek == 6
        
        if isFriday {
            let hour = calendar.component(.hour, from: today)
            let minutes = calendar.component(.minute, from: today)
            let isAfterTwoThirty = (hour > 14) || (hour == 14 && minutes >= 30)

            if isAfterTwoThirty {
                if let lastAskedTimestamp = lastJummuahRatingTimestamp {
                    let lastAskedDate = Date(timeIntervalSinceReferenceDate: lastAskedTimestamp)
                    if !calendar.isDate(lastAskedDate, inSameDayAs: today) {
                        askForJummuahRating()
                        return
                    }
                } else {
                    askForJummuahRating()
                    return
                }
            }
        }
        
        if let prayers = settings.prayersICOI {
            let now = Date()

            if let fajrIqamah = prayers.prayers.first(where: { $0.nameTransliteration.lowercased() == "fajr iqamah" })?.time,
               let ishaIqamah = prayers.prayers.first(where: { $0.nameTransliteration.lowercased() == "isha iqamah" })?.time {
                
                let fajrRatingWindow = fajrIqamah.addingTimeInterval(10 * 60)...fajrIqamah.addingTimeInterval(50 * 60)
                let ishaRatingWindow = ishaIqamah.addingTimeInterval(10 * 60)...ishaIqamah.addingTimeInterval(50 * 60)
                
                if (fajrRatingWindow.contains(now) || ishaRatingWindow.contains(now)) {
                    if let lastAskedTimestamp = lastKhateraRatingTimestamp {
                        let lastAskedDate = Date(timeIntervalSinceReferenceDate: lastAskedTimestamp)
                        if !calendar.isDate(lastAskedDate, inSameDayAs: now) {
                            askForKhateraRating()
                        }
                    } else {
                        askForKhateraRating()
                    }
                }
            }
        }
        #endif
    }
    
    var body: some View {
        NavigationView {
            List {
                #if !os(watchOS)
                Section(header: settings.defaultView ? Text("HIJRI DATE") : nil) {
                    NavigationLink(destination: HijriCalendarView()) {
                        HStack {
                            Text(settings.hijriDateEnglish)
                                .multilineTextAlignment(.center)
                            
                            Spacer()
                            
                            Text(settings.hijriDateArabic)
                        }
                    }
                    .font(.footnote)
                    .foregroundColor(settings.accentColor)
                    .contextMenu {
                        Button(action: {
                            settings.hapticFeedback()
                            
                            UIPasteboard.general.string = settings.hijriDateEnglish
                        }) {
                            Text("Copy English Date")
                            Image(systemName: "doc.on.doc")
                        }
                        
                        Button(action: {
                            settings.hapticFeedback()
                            
                            UIPasteboard.general.string = settings.hijriDateArabic
                        }) {
                            Text("Copy Arabic Date")
                            Image(systemName: "doc.on.doc")
                        }
                    }
                }
                #else
                HStack {
                    Spacer()
                    
                    Text(settings.hijriDateEnglish)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
                .font(.footnote)
                .foregroundColor(settings.accentColor)
                #endif
                
                if settings.prayersICOI != nil {
                    ICOIPrayerCountdown()
                    ICOIPrayerList()
                }
                
                #if !os(watchOS)
                Button(action: {
                    if let url = URL(string: "https://masjidal.com/widget/monthly/?masjid_id=6adJkrKk&jumuah_text=Jumuah%201") {
                        settings.hapticFeedback()
                        
                        UIApplication.shared.open(url)
                    }
                }) {
                    HStack {
                        Image(systemName: "calendar")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                            .foregroundColor(settings.accentColor2)
                            .padding(.trailing, 10)
                        
                        Text("View Monthly Prayer Calendar")
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor2)
                    }
                }
                
                Button(action: {
                    if let url = URL(string: "https://forms.gle/tRzMiv8dvTH9mG877") {
                        settings.hapticFeedback()
                        
                        UIApplication.shared.open(url)
                    }
                }) {
                    HStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                            .foregroundColor(settings.accentColor2)
                            .padding(.trailing, 10)
                        
                        Text("Rate a Khutbah at ICOI")
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor2)
                    }
                }
                #endif
            }
            .navigationTitle("ICOI Prayers")
            .navigationBarTitleDisplayMode(.inline)
            .applyConditionalListStyle(defaultView: settings.defaultView)
            .refreshable {
                settings.requestNotificationAuthorization()
                
                settings.fetchPrayerTimes(force: true) {
                    if settings.prayersICOI == nil {
                        activeAlert = .prayerTimeFetchError
                    } else if !settings.notificationNeverAskAgain && settings.showNotificationAlert {
                        activeAlert = .notficationError
                    } else if settings.prayersICOI != nil {
                        promptForJummuahOrKhateraRatingIfNeeded()
                    }
                }
            }
            .onAppear {
                settings.requestNotificationAuthorization()
                
                settings.fetchPrayerTimes() {
                    if settings.prayersICOI == nil {
                        activeAlert = .prayerTimeFetchError
                    } else if !settings.notificationNeverAskAgain && settings.showNotificationAlert {
                        activeAlert = .notficationError
                    } else if settings.prayersICOI != nil {
                        promptForJummuahOrKhateraRatingIfNeeded()
                    }
                }
            }
            .onChange(of: scenePhase) { newScenePhase in
                if newScenePhase == .active {
                    settings.requestNotificationAuthorization()
                    
                    settings.fetchPrayerTimes() {
                        if settings.prayersICOI == nil {
                            activeAlert = .prayerTimeFetchError
                        } else if !settings.notificationNeverAskAgain && settings.showNotificationAlert {
                            activeAlert = .notficationError
                        } else if settings.prayersICOI != nil {
                            promptForJummuahOrKhateraRatingIfNeeded()
                        }
                    }
                }
            }
            .confirmationDialog("", isPresented: Binding(
                get: { activeAlert != nil },
                set: { if !$0 { activeAlert = nil } }
            ), titleVisibility: .visible) {
                switch activeAlert {
                case .notficationError:
                    Button("Open Settings") {
                        #if !os(watchOS)
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                        #endif
                    }
                    Button("Never Ask Again", role: .destructive) {
                        settings.notificationNeverAskAgain = true
                    }
                    Button("Ignore", role: .cancel) { }

                case .prayerTimeFetchError:
                    Button("Try Again", role: .destructive) {
                        settings.fetchPrayerTimes() {
                            if settings.prayersICOI == nil {
                                activeAlert = .showVisitWebsiteButton
                            }
                        }
                    }
                    
                    Button("OK", role: .cancel) { }

                case .showVisitWebsiteButton:
                    #if !os(watchOS)
                    Button("Visit icoi.net", role: .destructive) {
                        if let url = URL(string: "https://www.icoi.net/") {
                            UIApplication.shared.open(url)
                        }
                    }
                    #else
                    Button("Try Again", role: .destructive) {
                        settings.fetchPrayerTimes()
                    }
                    #endif
                    
                    Button("OK", role: .cancel) { }

                case .jummuahRating:
                    #if !os(watchOS)
                    Button("Yes") {
                        if let url = URL(string: "https://forms.gle/tRzMiv8dvTH9mG877") {
                            UIApplication.shared.open(url)
                        }
                    }
                    #else
                    Button("Yes") {}
                    #endif
                    
                    Button("No", role: .destructive) {}

                case .khateraRating:
                    #if !os(watchOS)
                    Button("Yes") {
                        if let url = URL(string: "https://forms.gle/GnfRGHyDAsqj6Wqn8") {
                            UIApplication.shared.open(url)
                        }
                    }
                    #else
                    Button("Yes") {}
                    #endif
                    
                    Button("No", role: .destructive) {}

                case .none:
                    EmptyView()
                }
            } message: {
                switch activeAlert {
                case .notficationError:
                    Text("Please go to Settings and enable notifications to be notified of prayer times.")
                case .prayerTimeFetchError:
                    Text("Please check your internet connection. The website may be temporarily unavailable.")
                case .showVisitWebsiteButton:
                    Text("Please check your internet connection. The website may be temporarily unavailable.")
                case .jummuahRating:
                    Text("If you attended Jummuah today, do you want to rate the khutbah?")
                case .khateraRating:
                    Text("Would you like to rate the khatera?")
                case .none:
                    EmptyView()
                }
            }

        }
        .navigationViewStyle(.stack)
    }
}
