import SwiftUI

struct ICOIPrayerView: View {
    @EnvironmentObject var settings: Settings
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var showingSettingsSheet = false
    
    @State private var activeAlert: ICOIAlertType?

    enum ICOIAlertType: Int, Identifiable {
        case notficationError
        case prayerTimeFetchError
        case showVisitWebsiteButton
        case jumuahRating
        case khateraRating

        var id: Int { rawValue }
    }

    @AppStorage("lastJumuahRatingTimestamp") private var lastJumuahRatingTimestamp: Double?

    @inline(__always)
    private func askForJumuahRating() {
        lastJumuahRatingTimestamp = Date().timeIntervalSinceReferenceDate
        activeAlert = .jumuahRating
    }

    @AppStorage("lastKhateraRatingTimestamp") private var lastKhateraRatingTimestamp: Double?

    @inline(__always)
    private func askForKhateraRating() {
        lastKhateraRatingTimestamp = Date().timeIntervalSinceReferenceDate
        activeAlert = .khateraRating
    }

    private func promptForJumuahOrKhateraRatingIfNeeded() {
        #if !os(watchOS)
        let now = Date()
        let calendar = Calendar.current

        // Friday flow (after 3pm, once per day)
        if calendar.component(.weekday, from: now) == 6,
           calendar.component(.hour, from: now) > 15 {
            if let ts = lastJumuahRatingTimestamp {
                let lastAskedDate = Date(timeIntervalSinceReferenceDate: ts)
                if !calendar.isDate(lastAskedDate, inSameDayAs: now) {
                    askForJumuahRating()
                    return
                }
            } else {
                askForJumuahRating()
                return
            }
        }

        // Khatera flow (10–50 min after Fajr/Isha Iqamah, once per day)
        if let prayers = settings.prayersICOI {
            let fajrIqamah = prayers.prayers.first {
                $0.nameTransliteration.compare("Fajr Iqamah", options: .caseInsensitive) == .orderedSame
            }?.time

            let ishaIqamah = prayers.prayers.first {
                $0.nameTransliteration.compare("Isha Iqamah", options: .caseInsensitive) == .orderedSame
            }?.time

            if let fajrIqamah, let ishaIqamah {
                let tenMinutes: TimeInterval = 10 * 60
                let fiftyMinutes: TimeInterval = 50 * 60

                let fajrRatingWindow = fajrIqamah.addingTimeInterval(tenMinutes)...fajrIqamah.addingTimeInterval(fiftyMinutes)
                let ishaRatingWindow = ishaIqamah.addingTimeInterval(tenMinutes)...ishaIqamah.addingTimeInterval(fiftyMinutes)

                if fajrRatingWindow.contains(now) || ishaRatingWindow.contains(now) {
                    if let ts = lastKhateraRatingTimestamp {
                        let lastAskedDate = Date(timeIntervalSinceReferenceDate: ts)
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
    
    private func refreshICOI(forced: Bool = false) {
        settings.requestNotificationAuthorization()

        settings.fetchPrayerTimes(force: forced) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if settings.prayersICOI == nil {
                    activeAlert = .prayerTimeFetchError
                } else if !settings.notificationNeverAskAgain && settings.showNotificationAlert {
                    activeAlert = .notficationError
                } else if settings.prayersICOI != nil {
                    promptForJumuahOrKhateraRatingIfNeeded()
                }
            }
        }
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
            .refreshable {
                refreshICOI(forced: true)
            }
            .onAppear {
                refreshICOI()
            }
            .onChange(of: scenePhase) { _ in
                refreshICOI()
            }
            .navigationTitle("ICOI Prayers")
            .applyConditionalListStyle(defaultView: settings.defaultView)
            #if !os(watchOS)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        settings.hapticFeedback()
                        showingSettingsSheet = true
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $showingSettingsSheet) {
                NavigationView {
                    NotificationView()
                }
            }
            #endif
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

                case .jumuahRating:
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
                case .jumuahRating:
                    Text("If you attended Jumuah today, do you want to rate the khutbah?")
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
