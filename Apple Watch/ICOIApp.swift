import SwiftUI
import WatchConnectivity
import WidgetKit

@main
struct ICOI0_Watch_AppApp: App {
    @StateObject private var settings = Settings.shared
    @StateObject private var quranData = QuranData.shared
    @StateObject private var quranPlayer = QuranPlayer.shared
    @StateObject private var namesData = NamesViewModel.shared
    
    @State private var isLaunching = true
    
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
                        
                        ICOIEventsView()
                        
                        ICOILinksView()
                        
                        OtherView()
                        
                        ICOISettingsView()
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
                }
            }
        }
        .onChange(of: settings.lastReadSurah) { newValue in
            sendMessageToPhone()
        }
        .onChange(of: settings.lastReadAyah) { newValue in
            sendMessageToPhone()
        }
        .onChange(of: settings.favoriteSurahs) { newValue in
            sendMessageToPhone()
        }
        .onChange(of: settings.bookmarkedAyahs) { newValue in
            sendMessageToPhone()
        }
        .onChange(of: settings.favoriteLetters) { newValue in
            sendMessageToPhone()
        }
    }
    
    func sendMessageToPhone() {
        let settingsData = settings.dictionaryRepresentation()
        let message = ["settings": settingsData]

        if WCSession.default.isReachable {
            // Old method: Directly send the message if the phone is reachable
            print("Phone is reachable. Sending message to phone: \(message)")
            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                // Handle any error that occurred while sending the message
                print("Error sending message to phone: \(error.localizedDescription)")
            }
        } else {
            // New method: If the phone is not reachable, use transferUserInfo to queue up the data
            print("Phone is not reachable. Transferring user info to phone: \(message)")
            WCSession.default.transferUserInfo(message)
        }
    }
}

struct createButtonForURL: View {
    @EnvironmentObject var settings: Settings
    
    var url: String
    var title: String
    var image: String

    var body: some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)
                .foregroundColor(settings.accentColor2)
                .padding(.trailing, 10)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(settings.accentColor2)
        }
    }
}
