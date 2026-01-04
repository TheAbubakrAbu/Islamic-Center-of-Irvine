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
                        VStack {
                            ICOIPrayerView()
                            
                            if quranPlayer.isPlaying || quranPlayer.isPaused {
                                NowPlayingView(quranView: false)
                                    .animation(.easeInOut, value: quranPlayer.isPlaying)
                                    .padding(.bottom, 9)
                            }
                        }
                        .tabItem {
                            Image(systemName: "moon.stars.fill")
                            Text("Prayers")
                        }
                        
                        VStack {
                            ICOILinksView()
                            
                            if quranPlayer.isPlaying || quranPlayer.isPaused {
                                NowPlayingView(quranView: false)
                                    .animation(.easeInOut, value: quranPlayer.isPlaying)
                                    .padding(.bottom, 9)
                            }
                        }
                        .tabItem {
                            Image(systemName: "link")
                            Text("Links")
                        }
                        
                        QuranView()
                            .tabItem {
                                Image(systemName: "character.book.closed.ar")
                                Text("Quran")
                            }
                        
                        VStack {
                            IslamView()
                            
                            if quranPlayer.isPlaying || quranPlayer.isPaused {
                                NowPlayingView(quranView: false)
                                    .animation(.easeInOut, value: quranPlayer.isPlaying)
                                    .padding(.bottom, 9)
                            }
                        }
                        .tabItem {
                            Image(systemName: "ellipsis.circle.fill")
                            Text("Tools")
                        }
                        
                        VStack {
                            ICOISettingsView()
                            
                            if quranPlayer.isPlaying || quranPlayer.isPaused {
                                NowPlayingView(quranView: false)
                                    .animation(.easeInOut, value: quranPlayer.isPlaying)
                                    .padding(.bottom, 9)
                            }
                        }
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
            .accentColor(settings.accentColor)
            .tint(settings.accentColor)
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
