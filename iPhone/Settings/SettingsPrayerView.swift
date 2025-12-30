import SwiftUI

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
                        settings.firstJumuah &&
                        settings.secondJumuah &&
                        settings.ratingJumuah &&
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
                            
                            settings.firstJumuah = newValue
                            settings.secondJumuah = newValue
                            
                            settings.ratingJumuah = newValue
                            
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
                        settings.firstJumuah &&
                        settings.secondJumuah
                    },
                    set: { newValue in
                        withAnimation {
                            settings.adhanFajr = newValue
                            settings.adhanDhuhr = newValue
                            settings.adhanAsr = newValue
                            settings.adhanMaghrib = newValue
                            settings.adhanIsha = newValue
                            settings.firstJumuah = newValue
                            settings.secondJumuah = newValue
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
                            settings.firstJumuahPreNotification = newValue
                            settings.secondJumuahPreNotification = newValue
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
            
            PrayerSettingsSection(prayerName: "Fajr", adhanTime: $settings.adhanFajr, iqamahTime: $settings.iqamahFajr, iqamahPreNotification: $settings.iqamahFajrPreNotification, jumuahPreNotification: .constant(0))
            PrayerSettingsSection(prayerName: "Shurooq", adhanTime: $settings.sunriseTime, iqamahTime: $settings.sunriseTime, iqamahPreNotification: .constant(0), jumuahPreNotification: .constant(0))
            PrayerSettingsSection(prayerName: "Dhuhr", adhanTime: $settings.adhanDhuhr, iqamahTime: $settings.iqamahDhuhr, iqamahPreNotification: $settings.iqamahDhuhrPreNotification, jumuahPreNotification: .constant(0))
            
            PrayerSettingsSection(prayerName: "Jumuah", adhanTime: $settings.firstJumuah, iqamahTime: $settings.secondJumuah, iqamahPreNotification: $settings.firstJumuahPreNotification, jumuahPreNotification: $settings.secondJumuahPreNotification)
                                  
            PrayerSettingsSection(prayerName: "Asr", adhanTime: $settings.adhanAsr, iqamahTime: $settings.iqamahAsr, iqamahPreNotification: $settings.iqamahAsrPreNotification, jumuahPreNotification: .constant(0))
            PrayerSettingsSection(prayerName: "Maghrib", adhanTime: $settings.adhanMaghrib, iqamahTime: $settings.iqamahMaghrib, iqamahPreNotification: $settings.iqamahMaghribPreNotification, jumuahPreNotification: .constant(0))
            PrayerSettingsSection(prayerName: "Isha", adhanTime: $settings.adhanIsha, iqamahTime: $settings.iqamahIsha, iqamahPreNotification: $settings.iqamahIshaPreNotification, jumuahPreNotification: .constant(0))
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

struct PrayerSettingsSection: View {
    @EnvironmentObject var settings: Settings
    
    let prayerName: String
    
    @Binding var adhanTime: Bool
    @Binding var iqamahTime: Bool
    @Binding var iqamahPreNotification: Int
    @Binding var jumuahPreNotification: Int
    
    var body: some View {
        Section(header: Text(prayerName.uppercased())) {
            if prayerName == "Shurooq" {
                Toggle("Shurooq (Sunrise) Notification", isOn: $adhanTime.animation(.easeInOut))
                    .font(.subheadline)
            } else if prayerName == "Jumuah" {
                Toggle("First Jumuah Notification", isOn: $adhanTime.animation(.easeInOut))
                    .font(.subheadline)
                
                Stepper(value: $iqamahPreNotification.animation(.easeInOut), in: 0...30, step: 5) {
                    Text("1st Jumuah Prenotification:")
                        .font(.subheadline)
                    
                    Text("\(iqamahPreNotification) minute\(iqamahPreNotification != 1 ? "s" : "")")
                        .font(.subheadline)
                        .foregroundColor(settings.accentColor)
                }
            
                Toggle("Second Jumuah Notification", isOn: $iqamahTime.animation(.easeInOut))
                    .font(.subheadline)
                
                Stepper(value: $jumuahPreNotification.animation(.easeInOut), in: 0...30, step: 5) {
                    Text("2nd Jumuah Prenotification:")
                        .font(.subheadline)
                    
                    Text("\(jumuahPreNotification) minute\(jumuahPreNotification != 1 ? "s" : "")")
                        .font(.subheadline)
                        .foregroundColor(settings.accentColor)
                }
                
                Toggle("Jumuah Rating Notification at 3:00", isOn: $settings.ratingJumuah.animation(.easeInOut))
                    .font(.subheadline)
                
                Text("On Fridays, Dhuhr notifications are not sent and are instead replaced with Jumuah notifications.")
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
