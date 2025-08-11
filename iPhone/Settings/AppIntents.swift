import AppIntents

@available(iOS 16.0, *)
struct AppShortcutsRoot: AppShortcutsProvider {
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: PlaySurahAppIntent(),
            phrases: [
              "Play a surah in \(.applicationName)",
              "Recite a surah in \(.applicationName)",
              "Play surah in \(.applicationName)",
              "Recite surah in \(.applicationName)",
              "\(.applicationName), play a surah",
              "\(.applicationName), recite a surah",
              "\(.applicationName), play surah",
              "\(.applicationName), recite surah",
              "شغّل سورة في \(.applicationName)",
              "اقرأ سورة في \(.applicationName)"
            ],
            shortTitle: "Play Surah",
            systemImageName: "book"
        )

        AppShortcut(
            intent: PlayRandomSurahAppIntent(),
            phrases: [
                "Play random surah in \(.applicationName)",
                "Recite random surah in \(.applicationName)",
                "Play random in \(.applicationName)",
                "Recite random in \(.applicationName)",
                "\(.applicationName), play a random surah",
                "\(.applicationName), recite a random surah",
                "\(.applicationName), play random surah",
                "\(.applicationName), recite random surah",
                "\(.applicationName), play random",
                "\(.applicationName), recite random",
                "شغّل سورة عشوائية في \(.applicationName)",
                "اقرأ سورة عشوائية في \(.applicationName)"
            ],
            shortTitle: "Random Surah",
            systemImageName: "shuffle"
        )

        AppShortcut(
            intent: PlayLastListenedSurahAppIntent(),
            phrases: [
                "Play last listened surah in \(.applicationName)",
                "Recite last listened surah in \(.applicationName)",
                "Play last listened in \(.applicationName)",
                "Recite last listened in \(.applicationName)",
                "Play last in \(.applicationName)",
                "Recite last in \(.applicationName)",
                "Play last surah in \(.applicationName)",
                "Recite last surah in \(.applicationName)",
                "\(.applicationName), play last listened surah",
                "\(.applicationName), recite last listened surah",
                "\(.applicationName), play last listened",
                "\(.applicationName), recite last listened",
                "\(.applicationName), play last",
                "\(.applicationName), recite last",
                "\(.applicationName), play last surah",
                "\(.applicationName), recite last surah",
                "شغّل آخر سورة تم الاستماع إليها في \(.applicationName)",
                "اقرأ آخر سورة تم الاستماع إليها في \(.applicationName)"
            ],
            shortTitle: "Last Listened Surah",
            systemImageName: "gobackward"
        )
    }
}
