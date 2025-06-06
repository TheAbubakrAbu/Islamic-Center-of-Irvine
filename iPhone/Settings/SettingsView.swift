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
                        HStack {
                            Image(systemName: "scroll.fill")
                            
                            Text("View Credits")
                        }
                        .font(.subheadline)
                        .foregroundColor(settings.accentColor)
                    }
                    .sheet(isPresented: $showingCredits) {
                        CreditsView()
                    }
                    
                    Button(action: {
                        if settings.hapticOn { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
                        
                        withAnimation(.smooth()) {
                            if let url = URL(string: "itms-apps://itunes.apple.com/app/id6463835936?action=write-review") {
                                UIApplication.shared.open(url)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "star.bubble.fill")
                            
                            Text("Leave a Review")
                        }
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
                        HStack {
                            Image(systemName: "quote.bubble.fill")
                            
                            Text("Send Feedback via Google Form")
                        }
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
                    #endif
                    
                    HStack {
                        Text("Contact me at: ")
                        
                        Text("ammelmallah@icloud.com")
                            .foregroundColor(settings.accentColor)
                            .padding(.leading, -4)
                    }
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    #if !os(watchOS)
                    .contextMenu {
                        Button(action: {
                            settings.hapticFeedback()
                            
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
            }
            .navigationTitle("App Settings")
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
                .background(settings.accentColor)
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

struct ReciterListView: View {
    @EnvironmentObject var settings: Settings
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        List {
            Section(header: Text("Reciters")) {
                ForEach(reciters, id: \.self) { reciter in
                    Button(action: {
                        settings.hapticFeedback()
                        
                        withAnimation {
                            settings.reciter = reciter.name
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(reciter.name)
                                    .font(.subheadline)
                                    .foregroundColor(reciter.name == settings.reciter ? settings.accentColor : .primary)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                                
                                Image(systemName: "checkmark")
                                    .foregroundColor(settings.accentColor)
                                    .opacity(reciter.name == settings.reciter ? 1 : 0)
                            }
                            
                            if reciter.ayahIdentifier.contains("minshawi") && !reciter.name.contains("Minshawi") {
                                Text("This reciter is only available for surah recitation. Defaults to Minshawi (Murattal) for ayahs.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("Select Reciter")
        .applyConditionalListStyle(defaultView: true)
    }
}

struct SettingsQuranView: View {
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var quranData: QuranData
    
    @State private var showEdits: Bool

    init(showEdits: Bool = false) {
        _showEdits = State(initialValue: showEdits)
    }
    
    var body: some View {
        Section(header: Text("RECITATION")) {
            VStack(spacing: 10) {
                NavigationLink(destination: ReciterListView().environmentObject(settings)) {
                    Label("Choose Reciter", systemImage: "headphones")
                }
                
                HStack {
                    Text(settings.reciter)
                        .foregroundColor(settings.accentColor)
                    
                    Spacer()
                }
            }
            .accentColor(settings.accentColor)
            
            Picker("After Surah Recitation Ends", selection: $settings.reciteType.animation(.easeInOut)) {
                Text("Continue to Next").tag("Continue to Next")
                Text("Continue to Previous").tag("Continue to Previous")
                Text("End Recitation").tag("End Recitation")
            }
            .font(.subheadline)
            
            Text("The Quran recitations are streamed online and not downloaded, which may consume a lot of data if used frequently, especially when using cellular data.")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        
        Section(header: Text("ARABIC TEXT")) {
            Toggle("Show Arabic Quran Text", isOn: $settings.showArabicText.animation(.easeInOut))
                .font(.subheadline)
                .disabled(!settings.showTransliteration && !settings.showEnglishTranslation)
            
            if settings.showArabicText {
                VStack(alignment: .leading) {
                    Toggle("Remove Arabic Tashkeel (Vowel Diacritics) and Signs", isOn: $settings.cleanArabicText.animation(.easeInOut))
                        .font(.subheadline)
                        .disabled(!settings.showArabicText)
                    
                    #if !os(watchOS)
                    Text("This option removes Tashkeel, which are vowel diacretic marks such as Fatha, Damma, Kasra, and others, while retaining essential vowels like Alif, Yaa, and Waw. It also adjusts \"Mad\" letters and the \"Hamzatul Wasl,\" and removes baby vowel letters, various textual annotations including stopping signs, chapter markers, and prayer indicators. This option is not recommended.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 2)
                    #else
                    Text("This option removes Tashkeel (vowel diacretics).")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 2)
                    #endif
                }
                
                Picker("Arabic Font", selection: $settings.fontArabic.animation(.easeInOut)) {
                    Text("Uthmani").tag("KFGQPCHafsEx1UthmanicScript-Reg")
                    Text("Indopak").tag("Al_Mushaf")
                }
                #if !os(watchOS)
                .pickerStyle(SegmentedPickerStyle())
                #endif
                .disabled(!settings.showArabicText)
                
                Stepper(value: $settings.fontArabicSize.animation(.easeInOut), in: 15...50, step: 2) {
                    Text("Arabic Font Size: \(Int(settings.fontArabicSize))")
                        .font(.subheadline)
                }
                
                VStack(alignment: .leading) {
                    Toggle("Enable Arabic Beginner Mode", isOn: $settings.beginnerMode.animation(.easeInOut))
                        .font(.subheadline)
                        .disabled(!settings.showArabicText)
                    
                    Text("Puts a space between each Arabic letter to make it easier for beginners to read the Quran.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 2)
                }
            }
        }
        
        Section(header: Text("ENGLISH TEXT")) {
            Toggle("Show Transliteration", isOn: $settings.showTransliteration.animation(.easeInOut))
                .font(.subheadline)
                .disabled(!settings.showArabicText && !settings.showEnglishTranslation)
            
            Toggle("Show English Translation", isOn: $settings.showEnglishTranslation.animation(.easeInOut))
                .font(.subheadline)
                .disabled(!settings.showArabicText && !settings.showTransliteration)
            
            if settings.showTransliteration || settings.showEnglishTranslation {
                Stepper(value: $settings.englishFontSize.animation(.easeInOut), in: 13...20, step: 1) {
                    Text("English Font Size: \(Int(settings.englishFontSize))")
                        .font(.subheadline)
                }
            }
            
            Toggle("Use System Font Size", isOn: Binding(
                get: {
                    let systemBodySize = Double(UIFont.preferredFont(forTextStyle: .body).pointSize)
                    var usesSystemSizes = true
                    
                    if settings.showArabicText {
                        usesSystemSizes = usesSystemSizes && (settings.fontArabicSize == systemBodySize + 10)
                    }
                    
                    if settings.showTransliteration || settings.showEnglishTranslation {
                        usesSystemSizes = usesSystemSizes && (settings.englishFontSize == systemBodySize)
                    }
                    return usesSystemSizes
                },
                set: { newValue in
                    let systemBodySize = Double(UIFont.preferredFont(forTextStyle: .body).pointSize)
                    withAnimation {
                        if newValue {
                            settings.fontArabicSize = systemBodySize + 10
                            settings.englishFontSize = systemBodySize
                        } else {
                            settings.fontArabicSize = systemBodySize + 11
                            settings.englishFontSize = systemBodySize + 1
                        }
                    }
                }
            ))
            .font(.subheadline)
        }
        
        #if !os(watchOS)
        if showEdits {
            Section(header: Text("FAVORITES AND BOOKMARKS")) {
                NavigationLink(destination: FavoritesView(type: .surah).environmentObject(quranData).accentColor(settings.accentColor)) {
                    Text("Edit Favorite Surahs")
                        .font(.subheadline)
                        .foregroundColor(settings.accentColor)
                }
                
                NavigationLink(destination: FavoritesView(type: .ayah).environmentObject(quranData).accentColor(settings.accentColor)) {
                    Text("Edit Bookmarked Ayahs")
                        .font(.subheadline)
                        .foregroundColor(settings.accentColor)
                }
                
                NavigationLink(destination: FavoritesView(type: .letter).environmentObject(quranData).accentColor(settings.accentColor)) {
                    Text("Edit Favorite Letters")
                        .font(.subheadline)
                        .foregroundColor(settings.accentColor)
                }
            }
        }
        #endif
    }
}

#if !os(watchOS)
enum FavoriteType {
    case surah, ayah, letter
}

struct FavoritesView: View {
    @EnvironmentObject var quranData: QuranData
    @EnvironmentObject var settings: Settings
    
    @State private var editMode: EditMode = .inactive

    let type: FavoriteType

    var body: some View {
        List {
            switch type {
            case .surah:
                if settings.favoriteSurahs.isEmpty {
                    Text("No favorite surahs here, long tap a surah to favorite it.")
                } else {
                    ForEach(settings.favoriteSurahs.sorted(), id: \.self) { surahId in
                        if let surah = quranData.quran.first(where: { $0.id == surahId }) {
                            SurahRow(surah: surah)
                        }
                    }
                    .onDelete(perform: removeSurahs)
                }
            case .ayah:
                if settings.bookmarkedAyahs.isEmpty {
                    Text("No bookmarked ayahs here, long tap an ayah to bookmark it.")
                } else {
                    ForEach(settings.bookmarkedAyahs.sorted {
                        if $0.surah == $1.surah {
                            return $0.ayah < $1.ayah
                        } else {
                            return $0.surah < $1.surah
                        }
                    }, id: \.id) { bookmarkedAyah in
                        let surah = quranData.quran.first(where: { $0.id == bookmarkedAyah.surah })
                        let ayah = surah?.ayahs.first(where: { $0.id == bookmarkedAyah.ayah })
                        
                        if let _ = surah, let ayah = ayah {
                            HStack {
                                Text("\(bookmarkedAyah.surah):\(bookmarkedAyah.ayah)")
                                    .font(.headline)
                                    .foregroundColor(settings.accentColor)
                                    .padding(.trailing, 8)
                                
                                VStack {
                                    if(settings.showArabicText) {
                                        Text(ayah.textArabic)
                                            .font(.custom(settings.fontArabic, size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize * 1.1))
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .lineLimit(1)
                                    }
                                    
                                    if(settings.showTransliteration) {
                                        Text(ayah.textTransliteration ?? "")
                                            .font(.subheadline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .lineLimit(1)
                                    }
                                    
                                    if(settings.showEnglishTranslation) {
                                        Text(ayah.textEnglish ?? "")
                                            .font(.subheadline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .lineLimit(1)
                                    }
                                }
                                .padding(.vertical, 2)
                            }
                        }
                    }
                    .onDelete(perform: removeAyahs)
                }
            case .letter:
                if settings.favoriteLetters.isEmpty {
                    Text("No favorite letters here, long tap a letter to favorite it.")
                } else {
                    ForEach(settings.favoriteLetters.sorted(), id: \.id) { favorite in
                        ArabicLetterRow(letterData: favorite)
                    }
                    .onDelete(perform: removeLetters)
                }
            }
            
            Section {
                if !isListEmpty {
                    Button("Delete All") {
                        deleteAll()
                    }
                    .foregroundColor(.red)
                }
            }
        }
        .navigationTitle(titleForFavoriteType(type))
        .toolbar {
            EditButton()
        }
        .environment(\.editMode, $editMode)
    }

    private var isListEmpty: Bool {
        switch type {
        case .surah: return settings.favoriteSurahs.isEmpty
        case .ayah: return settings.bookmarkedAyahs.isEmpty
        case .letter: return settings.favoriteLetters.isEmpty
        }
    }

    private func deleteAll() {
        switch type {
        case .surah:
            settings.favoriteSurahs.removeAll()
        case .ayah:
            settings.bookmarkedAyahs.removeAll()
        case .letter:
            settings.favoriteLetters.removeAll()
        }
    }
    
    private func removeSurahs(at offsets: IndexSet) {
        settings.favoriteSurahs.remove(atOffsets: offsets)
    }

    private func removeAyahs(at offsets: IndexSet) {
        settings.bookmarkedAyahs.remove(atOffsets: offsets)
    }

    private func removeLetters(at offsets: IndexSet) {
        settings.favoriteLetters.remove(atOffsets: offsets)
    }
    
    private func titleForFavoriteType(_ type: FavoriteType) -> String {
        switch type {
        case .surah:
            return "Favorite Surahs"
        case .ayah:
            return "Bookmarked Ayahs"
        case .letter:
            return "Favorite Letters"
        }
    }
}
#endif

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
