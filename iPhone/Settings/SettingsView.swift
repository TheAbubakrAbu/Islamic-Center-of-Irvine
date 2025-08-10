import SwiftUI

struct ICOISettingsView: View {
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var quranData: QuranData
    
    @State private var showingCredits = false
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
    func timeSinceLastSync(_ lastSyncDate: Date?) -> Double {
        guard let lastSyncDate = lastSyncDate else { return Double.infinity }
        let currentTime = Date()
        let timeDifference = currentTime.timeIntervalSince(lastSyncDate)
        return timeDifference / 60
    }
    
    var body: some View {
        NavigationView {
            List {
                #if !os(watchOS)
                Section(header: Text("NOTIFICATIONS")) {
                    NavigationLink(destination: NotificationView()) {
                        Label("Notification Settings", systemImage: "bell.badge")
                    }
                }
                #endif

                Section(header: Text("QURAN")) {
                    NavigationLink(destination:
                        List {
                            SettingsQuranView(showEdits: true).environmentObject(quranData)
                        }
                        .applyConditionalListStyle(defaultView: true)
                        .navigationTitle("Quran Settings")
                    ) {
                        Label("Quran Settings", systemImage: "character.book.closed.ar")
                    }
                }
                
                Section(header: Text("LAST UPDATED")) {
                    SyncButton(title: "Prayers:", lastUpdated: settings.prayersICOI?.day, syncAction: {
                        settings.fetchPrayerTimes(force: true)
                    })
                    
                    SyncButton(title: "Events:", lastUpdated: settings.eventsICOI?.day, syncAction: {
                        settings.fetchEvents(force: true)
                    })
                    
                    SyncButton(title: "Businesses:", lastUpdated: settings.businessesICOI?.day, syncAction: {
                        settings.fetchBusinesses(force: true)
                    })
                    
                    #if !os(watchOS)
                    Text("Syncing is available every 5 minutes.\n\nAll updates for prayers, events, and businesses occur automatically when you launch the app for the first time each day.\n\nPrayer times are specifically synced daily before Fajr to ensure accurate notifications.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("Notifications will not update automatically in the background overnight if your phone is in low power mode, offline (airplane mode), or turned off, since it needs an internet connection to retrieve new prayer times from the website.")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 2)
                    #else
                    Text("Syncing is available every 5 minutes.\n\nAll updates for prayers, events, and businesses occur automatically when you launch the app for the first time each day.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    #endif
                }
                
                Section(header: Text("APPEARANCE")) {
                    SettingsAppearanceView()
                }
                
                Section(header: Text("CREDITS AND FEEDBACK")) {
                    #if !os(watchOS)
                    Button(action: {
                        settings.hapticFeedback()
                        
                        showingCredits = true
                    }) {
                        Label("View Credits", systemImage: "scroll.fill")
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor)
                    }
                    .sheet(isPresented: $showingCredits) {
                        CreditsView()
                    }

                    Button(action: {
                        settings.hapticFeedback()
                        
                        withAnimation(.smooth()) {
                            if let url = URL(string: "itms-apps://itunes.apple.com/app/id6463835936?action=write-review") {
                                UIApplication.shared.open(url)
                            }
                        }
                    }) {
                        Label("Leave a Review", systemImage: "star.bubble.fill")
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor2)
                    }
                    .contextMenu {
                        Button(action: {
                            settings.hapticFeedback()
                            
                            UIPasteboard.general.string = "itms-apps://itunes.apple.com/app/id6463835936?action=write-review"
                        }) {
                            HStack {
                                Image(systemName: "doc.on.doc")
                                Text("Copy Website")
                            }
                        }
                    }
                    
                    Link(destination: URL(string: "https://forms.gle/s2mp1uSr9rEXTWU29")!, label: {
                        Label("Feedback via Google Form", systemImage: "quote.bubble.fill")
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor2)
                    })
                    .contextMenu {
                        Button(action: {
                            settings.hapticFeedback()
                            
                            UIPasteboard.general.string = "https://forms.gle/s2mp1uSr9rEXTWU29"
                        }) {
                            HStack {
                                Image(systemName: "doc.on.doc")
                                Text("Copy Website")
                            }
                        }
                    }

                    Button(action: {
                        settings.hapticFeedback()
                        
                        withAnimation(.smooth()) {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    }) {
                        Label("Open App Settings", systemImage: "gearshape.fill")
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor2)
                    }
                    #endif

                    HStack {
                        Text("Contact: ")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                        
                        Text("ammelmallah@icloud.com")
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, -4)
                    }
                    #if !os(watchOS)
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = "ammelmallah@icloud.com"
                        }) {
                            HStack {
                                Image(systemName: "doc.on.doc")
                                Text("Copy Email")
                            }
                        }
                    }
                    #endif
                }
                
                AlIslamAppsSection()
            }
            .navigationTitle("Settings")
            .applyConditionalListStyle(defaultView: true)
        }
        .navigationViewStyle(.stack)
    }
}

struct NotificationView: View {
    @EnvironmentObject var settings: Settings
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        List {
            Section(header: Text("ALL PRAYER NOTIFICATIONS")) {
                Toggle("Turn On All Notifications", isOn: Binding(
                    get: {
                        settings.adhanFajr &&
                        settings.adhanDhuhr &&
                        settings.adhanAsr &&
                        settings.adhanMaghrib &&
                        settings.adhanIsha &&
                        settings.iqamahFajr &&
                        settings.iqamahDhuhr &&
                        settings.iqamahAsr &&
                        settings.iqamahMaghrib &&
                        settings.iqamahIsha &&
                        settings.firstJummuah &&
                        settings.secondJummuah &&
                        settings.ratingJummuah &&
                        settings.sunriseTime &&
                        settings.khateraFajr &&
                        settings.khateraIsha
                    },
                    set: { newValue in
                        withAnimation {
                            settings.adhanFajr = newValue
                            settings.adhanDhuhr = newValue
                            settings.adhanAsr = newValue
                            settings.adhanMaghrib = newValue
                            settings.adhanIsha = newValue
                            
                            settings.iqamahFajr = newValue
                            settings.iqamahDhuhr = newValue
                            settings.iqamahAsr = newValue
                            settings.iqamahMaghrib = newValue
                            settings.iqamahIsha = newValue
                            
                            settings.firstJummuah = newValue
                            settings.secondJummuah = newValue
                            
                            settings.ratingJummuah = newValue
                            
                            settings.sunriseTime = newValue
                            
                            settings.khateraFajr = newValue
                            settings.khateraIsha = newValue
                        }
                    }
                ))
                .font(.subheadline)
                
                Toggle("Turn On All Adhan Notifications", isOn: Binding(
                    get: {
                        settings.adhanFajr &&
                        settings.adhanDhuhr &&
                        settings.adhanAsr &&
                        settings.adhanMaghrib &&
                        settings.adhanIsha &&
                        settings.firstJummuah &&
                        settings.secondJummuah
                    },
                    set: { newValue in
                        withAnimation {
                            settings.adhanFajr = newValue
                            settings.adhanDhuhr = newValue
                            settings.adhanAsr = newValue
                            settings.adhanMaghrib = newValue
                            settings.adhanIsha = newValue
                            settings.firstJummuah = newValue
                            settings.secondJummuah = newValue
                        }
                    }
                ))
                .font(.subheadline)
                
                Toggle("Turn On All Iqamah Notifications", isOn: Binding(
                    get: {
                        settings.iqamahFajr &&
                        settings.iqamahDhuhr &&
                        settings.iqamahAsr &&
                        settings.iqamahMaghrib &&
                        settings.iqamahIsha
                    },
                    set: { newValue in
                        withAnimation {
                            settings.iqamahFajr = newValue
                            settings.iqamahDhuhr = newValue
                            settings.iqamahAsr = newValue
                            settings.iqamahMaghrib = newValue
                            settings.iqamahIsha = newValue
                        }
                    }
                ))
                .font(.subheadline)
                
                Stepper(value: Binding(
                    get: { settings.iqamahFajrPreNotification },
                    set: { newValue in
                        withAnimation {
                            settings.iqamahFajrPreNotification = newValue
                            settings.iqamahDhuhrPreNotification = newValue
                            settings.iqamahAsrPreNotification = newValue
                            settings.iqamahMaghribPreNotification = newValue
                            settings.iqamahIshaPreNotification = newValue
                            settings.firstJummuahPreNotification = newValue
                            settings.secondJummuahPreNotification = newValue
                        }
                    }
                ), in: 0...30, step: 5) {
                    Text("All Prayer Prenotifications:")
                        .font(.subheadline)
                    Text("\(settings.iqamahFajrPreNotification) minute\(settings.iqamahFajrPreNotification != 1 ? "s" : "")")
                        .font(.subheadline)
                        .foregroundColor(settings.accentColor)
                }
            }
            
            Section(header: Text("Khateras")) {
                Toggle("Fajr Khatera Rating", isOn: $settings.khateraFajr)
                    .font(.subheadline)
                
                Toggle("Isha Khatera Rating", isOn: $settings.khateraIsha)
                    .font(.subheadline)
                
                Text("You will receive notifications 30 minutes after the Fajr and Isha Iqamah times, reminding you to rate the khatera.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            PrayerSettingsSection(prayerName: "Fajr", adhanTime: $settings.adhanFajr, iqamahTime: $settings.iqamahFajr, iqamahPreNotification: $settings.iqamahFajrPreNotification, jummuahPreNotification: .constant(0))
            PrayerSettingsSection(prayerName: "Shurooq", adhanTime: $settings.sunriseTime, iqamahTime: $settings.sunriseTime, iqamahPreNotification: .constant(0), jummuahPreNotification: .constant(0))
            PrayerSettingsSection(prayerName: "Dhuhr", adhanTime: $settings.adhanDhuhr, iqamahTime: $settings.iqamahDhuhr, iqamahPreNotification: $settings.iqamahDhuhrPreNotification, jummuahPreNotification: .constant(0))
            
            PrayerSettingsSection(prayerName: "Jummuah", adhanTime: $settings.firstJummuah, iqamahTime: $settings.secondJummuah, iqamahPreNotification: $settings.firstJummuahPreNotification, jummuahPreNotification: $settings.secondJummuahPreNotification)
                                  
            PrayerSettingsSection(prayerName: "Asr", adhanTime: $settings.adhanAsr, iqamahTime: $settings.iqamahAsr, iqamahPreNotification: $settings.iqamahAsrPreNotification, jummuahPreNotification: .constant(0))
            PrayerSettingsSection(prayerName: "Maghrib", adhanTime: $settings.adhanMaghrib, iqamahTime: $settings.iqamahMaghrib, iqamahPreNotification: $settings.iqamahMaghribPreNotification, jummuahPreNotification: .constant(0))
            PrayerSettingsSection(prayerName: "Isha", adhanTime: $settings.adhanIsha, iqamahTime: $settings.iqamahIsha, iqamahPreNotification: $settings.iqamahIshaPreNotification, jummuahPreNotification: .constant(0))
        }
        .onAppear {
            settings.requestNotificationAuthorization()
            
            settings.fetchPrayerTimes() {
                if settings.showNotificationAlert {
                    showAlert = true
                }
            }
        }
        .onChange(of: scenePhase) { _ in
            settings.requestNotificationAuthorization()
            
            settings.fetchPrayerTimes() {
                if settings.showNotificationAlert {
                    showAlert = true
                }
            }
        }
        .confirmationDialog("", isPresented: $showAlert, titleVisibility: .visible) {
            Button("Open Settings") {
                #if !os(watchOS)
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                #endif
            }
            Button("Ignore", role: .cancel) { }
        } message: {
            Text("Please go to Settings and enable notifications to be notified of prayer times.")
        }
        .navigationTitle("Notification Settings")
        .applyConditionalListStyle(defaultView: true)
    }
}

import SwiftUI

struct SyncButton: View {
    @EnvironmentObject var settings: Settings
    
    var title: String
    var lastUpdated: Date?
    var syncAction: () -> Void
    var canSync: Bool {
        guard let lastUpdated = lastUpdated else { return true }
        return Date().timeIntervalSince(lastUpdated) >= (5 * 60)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(settings.accentColor)
                if let lastUpdated = lastUpdated {
                    Text(ICOISettingsView.dateFormatter.string(from: lastUpdated))
                        .font(.subheadline)
                } else {
                    Text("Not synced")
                        .font(.subheadline)
                }
            }
            
            Spacer()
            
            Text("Sync Now")
                .font(.subheadline)
                .padding(8)
                .foregroundColor(.white)
                .background(canSync ? settings.accentColor : Color.gray)
                .cornerRadius(10)
                .onTapGesture {
                    if canSync {
                        settings.hapticFeedback()
                        syncAction()
                    }
                }
        }
    }
}

struct PrayerSettingsSection: View {
    @EnvironmentObject var settings: Settings
    
    let prayerName: String
    
    @Binding var adhanTime: Bool
    @Binding var iqamahTime: Bool
    @Binding var iqamahPreNotification: Int
    @Binding var jummuahPreNotification: Int
    
    var body: some View {
        Section(header: Text(prayerName.uppercased())) {
            if prayerName == "Shurooq" {
                Toggle("Shurooq (Sunrise) Notification", isOn: $adhanTime.animation(.easeInOut))
                    .font(.subheadline)
            } else if prayerName == "Jummuah" {
                Toggle("First Jummuah Notification", isOn: $adhanTime.animation(.easeInOut))
                    .font(.subheadline)
                
                Stepper(value: $iqamahPreNotification.animation(.easeInOut), in: 0...30, step: 5) {
                    Text("1st Jummuah Prenotification:")
                        .font(.subheadline)
                    
                    Text("\(iqamahPreNotification) minute\(iqamahPreNotification != 1 ? "s" : "")")
                        .font(.subheadline)
                        .foregroundColor(settings.accentColor)
                }
            
                Toggle("Second Jummuah Notification", isOn: $iqamahTime.animation(.easeInOut))
                    .font(.subheadline)
                
                Stepper(value: $jummuahPreNotification.animation(.easeInOut), in: 0...30, step: 5) {
                    Text("2nd Jummuah Prenotification:")
                        .font(.subheadline)
                    
                    Text("\(jummuahPreNotification) minute\(jummuahPreNotification != 1 ? "s" : "")")
                        .font(.subheadline)
                        .foregroundColor(settings.accentColor)
                }
                
                Toggle("Jummuah Rating Notification at 3:00", isOn: $settings.ratingJummuah.animation(.easeInOut))
                    .font(.subheadline)
                
                Text("On Fridays, Dhuhr notifications are not sent and are instead replaced with Jummuah notifications.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 2)
            } else {
                Toggle("Adhan Notification", isOn: $adhanTime.animation(.easeInOut))
                    .font(.subheadline)
            
                Toggle("Iqamah Notification", isOn: $iqamahTime.animation(.easeInOut))
                    .font(.subheadline)
                
                Stepper(value: $iqamahPreNotification.animation(.easeInOut), in: 0...30, step: 5) {
                    Text("Iqamah Prenotification:")
                        .font(.subheadline)
                    
                    Text("\(iqamahPreNotification) minute\(iqamahPreNotification != 1 ? "s" : "")")
                        .font(.subheadline)
                        .foregroundColor(settings.accentColor)
                }
            }
        }
    }
}

struct SettingsAppearanceView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        #if !os(watchOS)
        Picker("Color Theme", selection: $settings.colorSchemeString.animation(.easeInOut)) {
            Text("System").tag("system")
            Text("Light").tag("light")
            Text("Dark").tag("dark")
        }
        .font(.subheadline)
        .pickerStyle(SegmentedPickerStyle())
        
        VStack(alignment: .leading) {
            Toggle("Default List View", isOn: $settings.defaultView.animation(.easeInOut))
                .font(.subheadline)
            
            Text("The default list view is the standard interface found in many of Apple's first party apps, including Notes. This setting only applies only to the prayer and Quran view.")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.vertical, 2)
        }
        #endif
        
        Toggle("Haptic Feedback", isOn: $settings.hapticOn.animation(.easeInOut))
            .font(.subheadline)
    }
}
