import UIKit
import BackgroundTasks
import UserNotifications
import WidgetKit

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    private let taskID = "com.Quran.Elmallah.Islamic-Pillars.Islamic-Center-of-Irvine.fetchPrayerTimes"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: taskID, using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }

        scheduleAppRefresh()
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleAppRefresh()
    }

    private func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: taskID)
        request.earliestBeginDate = nextRunDate()

        if let date = request.earliestBeginDate {
            logger.debug("🔧 Scheduling BGAppRefresh – earliestBeginDate: \(date.formatted())")
        }

        do {
            try BGTaskScheduler.shared.submit(request)
            logger.debug("✅ BGAppRefresh submitted")
        } catch {
            logger.error("❌ BG submit failed: \(error.localizedDescription)")
        }
    }

    private func nextRunDate(offsetMins: Double = 180) -> Date {
        guard
            let firstPrayer = Settings.shared.prayersICOI?
                .prayers.sorted(by: { $0.time < $1.time })
                .first?.time
        else {
            logger.debug("No ICOI prayer time available; scheduling 30 minutes later")
            return Date().addingTimeInterval(30 * 60)
        }

        let calendar = Calendar.current
        let timeParts = calendar.dateComponents([.hour, .minute, .second], from: firstPrayer)
        
        var tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())!
        let hour = timeParts.hour ?? 0
        let minute = timeParts.minute ?? 0
        let second = timeParts.second ?? 0
        tomorrow = calendar.date(bySettingHour: hour, minute: minute, second: second, of: tomorrow)!

        let target = tomorrow.addingTimeInterval(-offsetMins * 60)
        let minimum = Date().addingTimeInterval(15 * 60)
        let scheduled = max(target, minimum)
        
        logger.debug("Computed next run date for ICOI refresh: \(scheduled.formatted()) (offsetMins: \(offsetMins))")
        return scheduled
    }

    private func handleAppRefresh(task: BGAppRefreshTask) {
        logger.debug("🚀 BGAppRefresh fired for ICOI")
        scheduleAppRefresh()

        task.expirationHandler = {
            logger.error("⏰ BG task expired before finishing for ICOI")
            task.setTaskCompleted(success: false)
        }

        Settings.shared.fetchPrayerTimes(force: true, notification: true) {
            logger.debug("🎉 BG task completed – ICOI prayer times refreshed")
            task.setTaskCompleted(success: true)
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
