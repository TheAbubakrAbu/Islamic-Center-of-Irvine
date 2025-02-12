import SwiftUI
import WatchConnectivity
import WidgetKit
import BackgroundTasks

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

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Register your task
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.Quran.Elmallah.Islamic-Pillars.Islamic-Center-of-Irvine.fetchPrayerTimes", using: nil) { task in
            // This block is called when your task is run
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }

        // Schedule the task for the first time
        scheduleAppRefresh()

        // Set this object as the delegate for the user notification center.
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.Quran.Elmallah.Islamic-Pillars.Islamic-Center-of-Irvine.fetchPrayerTimes")
        
        if let prayerObject = Settings.shared.prayersICOI, let nextPrayerTime = prayerObject.prayers.first?.time {
            let calendar = Calendar.current
            
            var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: nextPrayerTime)
            if let tomorrow = calendar.date(byAdding: .day, value: 1, to: calendar.date(from: dateComponents)!) {
                dateComponents = calendar.dateComponents([.hour, .minute, .second], from: nextPrayerTime)
                if let nextPrayerTimeTomorrow = calendar.date(bySettingHour: dateComponents.hour!, minute: dateComponents.minute!, second: dateComponents.second!, of: tomorrow) {
                    let refreshTime = calendar.date(byAdding: .hour, value: -1, to: nextPrayerTimeTomorrow)!
                    print("Scheduling before Fajr tomorrow")
                    request.earliestBeginDate = refreshTime
                } else {
                    print("Error creating date for next prayer time tomorrow")
                    request.earliestBeginDate = Date(timeIntervalSinceNow: 24 * 60 * 60)
                }
            } else {
                print("Error creating date for tomorrow")
                request.earliestBeginDate = Date(timeIntervalSinceNow: 24 * 60 * 60)
            }
            
        } else {
            print("Scheduling 24 hours later, no prayer time")
            request.earliestBeginDate = Date(timeIntervalSinceNow: 24 * 60 * 60)
        }
        
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Scheduled background app refresh")
        } catch {
            print("Could not schedule background app refresh: \(error)")
        }
    }
    
    func handleAppRefresh(task: BGAppRefreshTask) {
        // Schedule the next refresh
        scheduleAppRefresh()
        
        // Perform the data fetch and notification scheduling
        Settings.shared.fetchPrayerTimes()

        // Mark the task as complete when done
        task.setTaskCompleted(success: true)
    }
    
    // Called when a notification is delivered to a foreground app.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Show the notification alert (and play the sound) even if the app is in the foreground
        completionHandler([.banner, .sound])
    }
}

struct DismissKeyboardOnScrollModifier: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            if #available(iOS 16.0, *) {
                content
                    .scrollDismissesKeyboard(.immediately)
            } else {
                content
                    .gesture(
                        DragGesture().onChanged { _ in
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    )
            }
        }
    }
}

extension View {
    func applyConditionalListStyle(defaultView: Bool) -> some View {
        self.modifier(ConditionalListStyle(defaultView: defaultView))
    }
    
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func dismissKeyboardOnScroll() -> some View {
        self.modifier(DismissKeyboardOnScrollModifier())
    }
}

struct ConditionalListStyle: ViewModifier {
    @EnvironmentObject var settings: Settings
    
    @Environment(\.colorScheme) var systemColorScheme
    @Environment(\.customColorScheme) var customColorScheme
    
    var defaultView: Bool
    
    var currentColorScheme: ColorScheme {
        if let colorScheme = settings.colorScheme {
            return colorScheme
        } else {
            return systemColorScheme
        }
    }

    func body(content: Content) -> some View {
        Group {
            if defaultView {
                content
                    .accentColor(settings.accentColor)
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                content
                    .listStyle(PlainListStyle())
                    .accentColor(settings.accentColor)
                    .background(currentColorScheme == .dark ? Color.black : Color.white)
                    .navigationBarTitleDisplayMode(.inline)
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
        Button(action: {
            if let url = URL(string: url) {
                settings.hapticFeedback()
                
                DispatchQueue.main.async {
                    UIApplication.shared.open(url)
                }
            }
        }) {
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
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    var onSearchButtonClicked: (() -> Void)?

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
        }

        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()

            text = ""
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search"
        searchBar.autocorrectionType = .no
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        DispatchQueue.main.async {
            self.text = searchBar.text ?? ""
        }
    }
}
