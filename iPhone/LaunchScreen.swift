import SwiftUI

struct LaunchScreen: View {
    @EnvironmentObject var settings: Settings

    @Binding var isLaunching: Bool

    @State private var size = 1.0
    @State private var opacity = 0.5
    @State private var gradientSize: CGFloat = 0.0

    @Environment(\.colorScheme) var systemColorScheme
    @Environment(\.customColorScheme) var customColorScheme

    var currentColorScheme: ColorScheme {
        if let colorScheme = settings.colorScheme {
            return colorScheme
        } else {
            return systemColorScheme
        }
    }

    var backgroundColor: Color {
        switch currentColorScheme {
        case .light:
            return Color.white
        case .dark:
            return Color.black
        @unknown default:
            return Color.white
        }
    }

    var gradient: LinearGradient {
        LinearGradient(
            colors: [settings.accentColor.opacity(0.3), settings.accentColor.opacity(0.5)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            gradient
                .clipShape(Circle())
                .scaleEffect(gradientSize)

            VStack {
                Image("ICOI2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .padding()
                    .padding()
                    .frame(maxWidth: 250)
            }
            .foregroundColor(settings.accentColor)
            .scaleEffect(size)
            .opacity(opacity)
        }
        .onAppear {
            Task { @MainActor in
                triggerHapticFeedback(.soft)

                withAnimation(.easeInOut(duration: 0.5)) {
                    size = 1.25
                    opacity = 1.0
                    gradientSize = 3.0
                }

                try? await Task.sleep(nanoseconds: 800_000_000)

                triggerHapticFeedback(.soft)
                withAnimation(.easeOut(duration: 0.5)) {
                    size = 1.0
                    gradientSize = 0.0
                }

                await QuranData.shared.waitUntilLoaded()
                await waitForPrayerTimesOrTimeout(seconds: 10)

                try? await Task.sleep(nanoseconds: 700_000_000)

                triggerHapticFeedback(.soft)
                withAnimation {
                    isLaunching = false
                }
            }
        }
    }
    
    private func triggerHapticFeedback(_ feedbackType: HapticFeedbackType) {
        if settings.hapticOn {
            #if !os(watchOS)
            switch feedbackType {
            case .soft:
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            case .light:
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            case .medium:
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            case .heavy:
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            }
            #else
            if settings.hapticOn { WKInterfaceDevice.current().play(.click) }
            #endif
        }
    }

    enum HapticFeedbackType {
        case soft, light, medium, heavy
    }
    
    @MainActor
    func waitForPrayerTimesOrTimeout(seconds: Double = 10) async {
        await withTaskGroup(of: Void.self) { group in
            // Task A: prayer fetch completes
            group.addTask {
                await settings.fetchPrayerTimesAsync(force: false, notification: false)
            }

            // Task B: timeout
            group.addTask {
                try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
            }

            // First one to finish wins
            await group.next()
            group.cancelAll()
        }
    }
}

extension Settings {
    @MainActor
    func fetchPrayerTimesAsync(force: Bool = false, notification: Bool = false) async {
        await withCheckedContinuation { continuation in
            fetchPrayerTimes(force: force, notification: notification) {
                continuation.resume()
            }
        }
    }
}

#Preview {
    LaunchScreen(isLaunching: .constant(true))
        .environmentObject(Settings.shared)
}
