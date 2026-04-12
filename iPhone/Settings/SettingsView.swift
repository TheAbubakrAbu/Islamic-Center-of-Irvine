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
        navigationContainer
    }

    private var navigationContainer: some View {
        Group {
            #if os(iOS)
            if #available(iOS 16.0, *) {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    NavigationSplitView {
                        settingsList
                    } detail: {
                        SettingsQuranView(showEdits: true)
                    }
                } else {
                    NavigationStack {
                        settingsList
                    }
                }
            } else {
                NavigationView {
                    settingsList
                }
                .navigationViewStyle(.stack)
            }
            #else
            NavigationView {
                settingsList
            }
            .navigationViewStyle(.stack)
            #endif
        }
    }

    private var settingsList: some View {
        List {
            #if !os(watchOS)
            Section(header: Text("NOTIFICATIONS")) {
                NavigationLink(destination: NotificationView()) {
                    Label(
                        title: { Text("Notification Settings") },
                        icon: {
                            Image(systemName: "bell.badge")
                                .foregroundColor(settings.accentColor.color)
                        }
                    )
                    .padding(.vertical, 4)
                    .accentColor(settings.accentColor.color)
                }
            }
            #endif

            Section(header: Text("AL-QURAN")) {
                NavigationLink(destination:
                    SettingsQuranView(showEdits: true)
                ) {
                    Label(
                        title: { Text("Quran Settings") },
                        icon: {
                            Image(systemName: "character.book.closed.ar")
                                .foregroundColor(settings.accentColor.color)
                        }
                    )
                    .padding(.vertical, 4)
                    .accentColor(settings.accentColor.color)
                }
                .accentColor(settings.accentColor.color)
            }
            
            Section(header: Text("LAST UPDATED")) {
                SyncButton(title: "Prayers:", lastUpdated: settings.prayersICOI?.day, syncAction: {
                    settings.fetchPrayerTimes(force: true)
                })
                
                SyncButton(title: "Businesses:", lastUpdated: settings.businessesICOI?.day, syncAction: {
                    settings.fetchBusinesses(force: true)
                })
                
                Text("Syncing is available every 5 minutes.\n\nAll updates for prayers, events, and businesses occur automatically when you launch the app for the first time each day.")
                    .font(.caption)
                    .foregroundColor(.secondary)
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
                        .foregroundColor(settings.accentColor.color)
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
                
                if let url = URL(string: "https://forms.gle/s2mp1uSr9rEXTWU29") {
                    Link(destination: url) {
                        Label("Feedback via Google Form", systemImage: "quote.bubble.fill")
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor2)
                    }
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
                        .frame(width: glyphWidth)
                    
                    Text("ammelmallah@icloud.com")
                        .font(.subheadline)
                        .foregroundColor(settings.accentColor.color)
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
                
                VersionNumber(width: glyphWidth)
                    .font(.subheadline)
            }
            
            AlIslamAppsSection()
        }
        .navigationTitle("Settings")
        .applyConditionalListStyle(defaultView: true)
    }
    
    private func columnWidth(for textStyle: UIFont.TextStyle, extra: CGFloat = 4, sample: String? = nil, fontName: String? = nil) -> CGFloat {
        let sampleString = (sample ?? "M") as NSString
        let font: UIFont

        if let fontName = fontName, let customFont = UIFont(name: fontName, size: UIFont.preferredFont(forTextStyle: textStyle).pointSize) {
            font = customFont
        } else {
            font = UIFont.preferredFont(forTextStyle: textStyle)
        }

        return ceil(sampleString.size(withAttributes: [.font: font]).width) + extra
    }

    private var glyphWidth: CGFloat {
        columnWidth(for: .subheadline, extra: 0, sample: "Contact: ")
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
                    .foregroundColor(settings.accentColor.color)
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
                .background(canSync ? settings.accentColor.color : Color.gray)
                .cornerRadius(24)
                .onTapGesture {
                    if canSync {
                        settings.hapticFeedback()
                        syncAction()
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
            
            Text("The default list view is the standard interface found in many of Apple's first party apps, including Notes. This setting applies everywhere in the app except here in Settings.")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.vertical, 2)
        }
        #endif
        
        Toggle("Haptic Feedback", isOn: $settings.hapticOn.animation(.easeInOut))
            .font(.subheadline)
    }
}

struct VersionNumber: View {
    @EnvironmentObject var settings: Settings
    
    var width: CGFloat?
    
    var body: some View {
        HStack {
            if let width = width {
                Text("Version:")
                    .frame(width: width)
            } else {
                Text("Version")
            }
            
            Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0")
                .foregroundColor(settings.accentColor.color)
                .padding(.leading, -4)
        }
        .foregroundColor(.primary)
    }
}
