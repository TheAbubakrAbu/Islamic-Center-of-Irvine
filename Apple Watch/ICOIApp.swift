import SwiftUI
import WidgetKit

@main
struct IslamicCenterofIrvineApp: App {
    @StateObject private var settings = Settings.shared
    @StateObject private var quranData = QuranData.shared
    @StateObject private var quranPlayer = QuranPlayer.shared
    @StateObject private var namesData = NamesViewModel.shared
    
    @State private var isLaunching = true
    
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
            .tint(settings.accentColor)
            .preferredColorScheme(settings.colorScheme)
            .transition(.opacity)
            .animation(.easeInOut, value: isLaunching)
            .onAppear {
                withAnimation {
                    settings.fetchPrayerTimes()
                    settings.fetchEvents()
                    settings.fetchBusinesses()
                }
            }
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
