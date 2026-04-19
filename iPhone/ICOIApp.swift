import SwiftUI
import WidgetKit
import StoreKit

@main
struct IslamicCenterofIrvineApp: App {
    @StateObject private var settings = Settings.shared
    @StateObject private var quranData = QuranData.shared
    @StateObject private var quranPlayer = QuranPlayer.shared
    @StateObject private var namesData = NamesViewModel.shared
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @Environment(\.scenePhase) private var scenePhase

    @State private var isLaunching = true
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLaunching {
                    LaunchScreen(isLaunching: $isLaunching)
                } else {
                    TabView {
                        ICOIPrayerView()
                            .withNowPlayingInset()
                            .tabItem {
                                Image(systemName: "moon.stars.fill")
                                Text("Prayers")
                            }
                        
                        ICOILinksView()
                            .withNowPlayingInset()
                            .tabItem {
                                Image(systemName: "link")
                                Text("Links")
                            }
                        
                        QuranView()
                            .tabItem {
                                Image(systemName: "character.book.closed.ar")
                                Text("Quran")
                            }
                        
                        IslamView()
                            .withNowPlayingInset()
                            .tabItem {
                                Image(systemName: "ellipsis.circle.fill")
                                Text("Tools")
                            }
                        
                        ICOISettingsView()
                            .withNowPlayingInset()
                            .tabItem {
                                Image(systemName: "gearshape.fill")
                                Text("Settings")
                            }
                    }
                }
            }
            .environmentObject(quranData)
            .environmentObject(quranPlayer)
            .environmentObject(namesData)
            .environmentObject(settings)
            .accentColor(settings.accentColor.color)
            .tint(settings.accentColor.color)
            .preferredColorScheme(settings.colorScheme)
            .transition(.opacity)
            .animation(.easeInOut, value: isLaunching)
            .appReviewPrompt()
            .onAppear {
                withAnimation {
                    settings.fetchPrayerTimes()
                    settings.fetchBusinesses()
                }
            }
        }
        .onChange(of: scenePhase) { _ in
            quranPlayer.saveLastListenedSurah()
        }
    }
}

private struct NowPlayingInsetModifier: ViewModifier {
    @EnvironmentObject private var quranPlayer: QuranPlayer

    func body(content: Content) -> some View {
        content.safeAreaInset(edge: .bottom) {
            VStack(spacing: SafeAreaInsetVStackSpacing.standard) {
                if quranPlayer.isPlaying || quranPlayer.isPaused {
                    NowPlayingView()
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 8)
            .background(Color.white.opacity(0.00001))
            .animation(.easeInOut, value: quranPlayer.isPlaying || quranPlayer.isPaused)
        }
    }
}

private extension View {
    func withNowPlayingInset() -> some View {
        modifier(NowPlayingInsetModifier())
    }
}
