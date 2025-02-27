import SwiftUI
import WatchConnectivity
import WidgetKit

@main
struct IslamicCenterofIrvineApp: App {
    @StateObject private var settings = Settings.shared
    @StateObject private var quranData = QuranData.shared
    @StateObject private var quranPlayer = QuranPlayer.shared
    @StateObject private var namesData = NamesViewModel.shared
    
    @State private var isLaunching = true
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        _ = WatchConnectivityManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLaunching {
                    LaunchScreen(isLaunching: $isLaunching)
                } else {
                    TabView {
                        ICOIPrayerView()
                            .tabItem {
                                Image(systemName: "moon.stars.fill")
                                Text("Prayers")
                            }
                        
                        ICOIEventsView()
                            .tabItem {
                                Image(systemName: "calendar")
                                Text("Events")
                            }
                        
                        ICOILinksView()
                            .tabItem {
                                Image(systemName: "link")
                                Text("Links")
                            }
                        
                        OtherView()
                            .tabItem {
                                Image(systemName: "ellipsis.circle.fill")
                                Text("Tools")
                            }
                        
                        ICOISettingsView()
                            .tabItem {
                                Image(systemName: "gearshape.fill")
                                Text("Settings")
                            }
                    }
                }
            }
            .environmentObject(settings)
            .environmentObject(quranData)
            .environmentObject(quranPlayer)
            .environmentObject(namesData)
            .accentColor(settings.accentColor)
            .preferredColorScheme(settings.colorScheme)
            .transition(.opacity)
            .onAppear {
                withAnimation {
                    settings.fetchPrayerTimes()
                    settings.fetchEvents()
                    settings.fetchBusinesses()
                }
            }
        }
        .onChange(of: settings.lastReadSurah) { _ in
            sendMessageToWatch()
        }
        .onChange(of: settings.lastReadAyah) { _ in
            sendMessageToWatch()
        }
        .onChange(of: settings.favoriteSurahs) { _ in
            sendMessageToWatch()
        }
        .onChange(of: settings.bookmarkedAyahs) { _ in
            sendMessageToWatch()
        }
        .onChange(of: settings.favoriteLetters) { _ in
            sendMessageToWatch()
        }
    }
    
    private func sendMessageToWatch() {
        guard WCSession.default.isPaired else {
            print("No Apple Watch is paired")
            return
        }
        
        let settingsData = settings.dictionaryRepresentation()
        let message = ["settings": settingsData]

        if WCSession.default.isReachable {
            print("Watch is reachable. Sending message to watch: \(message)")

            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print("Error sending message to watch: \(error.localizedDescription)")
            }
        } else {
            print("Watch is not reachable. Transferring user info to watch: \(message)")
            WCSession.default.transferUserInfo(message)
        }
    }
}
