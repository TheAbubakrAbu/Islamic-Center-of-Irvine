import SwiftUI
import BackgroundTasks

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
