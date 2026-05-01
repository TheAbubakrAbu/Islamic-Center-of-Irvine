#if os(iOS)
import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject private var settings: Settings
    @Environment(\.colorScheme) private var systemColorScheme
    @Environment(\.openURL) private var openURL
    @Environment(\.dismiss) private var dismiss

    @State private var openedAppStoreFromHero = false
    @State private var popCenter = false
    @State private var popLeft = false
    @State private var popRight = false

    private var currentColorScheme: ColorScheme {
        settings.colorScheme ?? systemColorScheme
    }

    private var isDarkMode: Bool {
        currentColorScheme == .dark
    }

    private var heroSpring: Animation {
        .spring(response: 0.52, dampingFraction: 0.62, blendDuration: 0)
    }

    private var masjidAppColor: Color {
        Color(red: 79 / 255, green: 169 / 255, blue: 192 / 255)
    }

    private var daysUntilClosure: Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let closureDate = calendar.date(from: DateComponents(year: 2026, month: 5, day: 15)) ?? today
        return max(0, calendar.dateComponents([.day], from: today, to: closureDate).day ?? 0)
    }

    private var closureTimingText: String {
        switch daysUntilClosure {
        case 0:
            return "today, May 15, 2026"
        case 1:
            return "in 1 day, on May 15, 2026"
        default:
            return "in \(daysUntilClosure) days, on May 15, 2026"
        }
    }

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                let s = LaunchScreenLayout.scale(for: geo.size)
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        masjidAppHero(layoutScale: s)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("The ICOI app is being discontinued")
                                .font(.title2.weight(.bold))
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)

                            Text("It will close \(closureTimingText). You can continue using the ICOI app until then, and after that please transition to The Masjid App for ICOI updates and services.")
                                .font(.body)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)

                            Text("Download The Masjid App at icoi.themasjidapp.net/download.")
                                .font(.subheadline.weight(.semibold))
                                .foregroundColor(masjidAppColor)
                                .multilineTextAlignment(.leading)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .conditionalGlassEffect(rectangle: true, useColor: 0.2, customTint: masjidAppColor)

                        Text("Jazakumullahu Khairan for using the ICOI app and supporting the Islamic Center of Irvine community.")
                            .font(.body)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("More Islamic Apps")
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text("The Al-Islamic apps are separate optional apps for prayer times, Quran, and Islamic learning.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.leading)
                        }

                        appHeroStack(layoutScale: min(s, 0.78))
                            .padding(.top, 2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 22)
                    .padding(.top, 8)
                }
                .adaptiveSafeArea(edge: .bottom) {
                    actionButtons
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                }
                .animation(.easeInOut, value: openedAppStoreFromHero)
                .transition(.opacity)
            }
            .navigationTitle("Assalamu Alaikum")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: runHeroPopAnimation)
        }
        .navigationViewStyle(.stack)
    }

    private func masjidAppHero(layoutScale s: CGFloat) -> some View {
        Button {
            settings.hapticFeedback()
            openURLIfPossible(Self.masjidAppURL)
        } label: {
            VStack(spacing: 12) {
                Image("Masjid App")
                    .resizable()
                    .scaledToFit()
                    .frame(width: min(118 * s, 156), height: min(118 * s, 156))
                    .clipShape(RoundedRectangle(cornerRadius: min(28 * s, 34), style: .continuous))
                    .shadow(color: masjidAppColor.opacity(isDarkMode ? 0.28 : 0.22), radius: 14, x: 0, y: 6)

                VStack(spacing: 4) {
                    Text("Move to The Masjid App")
                        .font(.title3.weight(.bold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)

                    Text("ICOI updates and services are moving there.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .padding(.horizontal, 16)
            .conditionalGlassEffect(rectangle: true, useColor: 0.24, customTint: masjidAppColor)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Download The Masjid App")
    }

    private func runHeroPopAnimation() {
        popCenter = false
        popLeft = false
        popRight = false
        withAnimation(heroSpring) {
            popCenter = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            withAnimation(heroSpring) {
                popLeft = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
            withAnimation(heroSpring) {
                popRight = true
            }
        }
    }

    private func appHeroStack(layoutScale s: CGFloat) -> some View {
        let card = 120 * s
        let cr = 32 * s
        let inset = 10 * s
        let titleFont: Font = s > 1.15 ? .callout.weight(.semibold) : .caption.weight(.semibold)
        let jump: CGFloat = 88 * s
        let oxLeft: CGFloat = -108 * s
        let oxRight: CGFloat = 114 * s
        let oy: CGFloat = -6 * s
        let stackHeight = (275 * s) + (s > 1 ? 24 * s : 0)

        return ZStack {
            Button {
                openAppStoreFromHero(Self.alAdhanAppURL)
            } label: {
                VStack(spacing: 10 * s) {
                    Text("Al-Adhan")
                        .font(titleFont)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    
                    LaunchCompanionCard(
                        imageName: "Al-Adhan",
                        accentColor: masjidAppColor,
                        isDarkMode: isDarkMode,
                        width: card,
                        height: card,
                        cornerRadius: cr,
                        imageInset: inset,
                        opacity: 1
                    )
                }
            }
            .contentShape(Rectangle())
            .scaleEffect(popLeft ? 1 : 0.18)
            .offset(y: popLeft ? 0 : jump)
            .opacity(popLeft ? 1 : 0.35)
            .rotationEffect(.degrees(-5.6))
            .offset(x: oxLeft, y: oy)
            .accessibilityLabel("Al-Adhan on the App Store")

            Button {
                openAppStoreFromHero(Self.alQuranAppURL)
            } label: {
                VStack(spacing: 10 * s) {
                    Text("Al-Quran")
                        .font(titleFont)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    LaunchCompanionCard(
                        imageName: "Al-Quran",
                        accentColor: masjidAppColor,
                        isDarkMode: isDarkMode,
                        width: card,
                        height: card,
                        cornerRadius: cr,
                        imageInset: inset,
                        opacity: 1
                    )
                }
            }
            .contentShape(Rectangle())
            .scaleEffect(popRight ? 1 : 0.18)
            .offset(y: popRight ? 0 : jump)
            .opacity(popRight ? 1 : 0.35)
            .rotationEffect(.degrees(7))
            .offset(x: oxRight, y: oy)
            .accessibilityLabel("Al-Quran on the App Store")

            Button {
                openAppStoreFromHero(Self.alIslamAppURL)
            } label: {
                VStack(spacing: 10 * s) {
                    Text("Al-Islam")
                        .font(titleFont)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    
                    LaunchLogoCard(
                        title: "Al-Islam",
                        accentColor: masjidAppColor,
                        isDarkMode: isDarkMode,
                        shimmerOffset: 0,
                        layoutScale: s,
                        showShimmer: false
                    )
                }
            }
            .contentShape(Rectangle())
            .scaleEffect(popCenter ? 1 : 0.2)
            .offset(y: popCenter ? 0 : jump * 1.05)
            .opacity(popCenter ? 1 : 0.4)
            .accessibilityLabel("Al-Islam on the App Store")
        }
        .frame(height: stackHeight)
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private var actionButtons: some View {
        HStack {
            Button {
                settings.hapticFeedback()
                openURLIfPossible(Self.masjidAppURL)
            } label: {
                Text("Get The Masjid App")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.72)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
            }
            .conditionalGlassEffect(rectangle: true, useColor: 0.42, customTint: masjidAppColor)
            
            Button {
                settings.hapticFeedback()
                dismiss()
            } label: {
                Text(openedAppStoreFromHero ? "Done" : "Use ICOI Until Then")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.72)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
            }
            .conditionalGlassEffect(
                rectangle: true,
                useColor: 0.38,
                customTint: settings.accentColor.color
            )
            .accessibilityLabel(openedAppStoreFromHero ? "Done" : "Use ICOI until then")
        }
    }

    private func openAppStoreFromHero(_ url: URL?) {
        settings.hapticFeedback()
        withAnimation(.easeInOut(duration: 0.25)) {
            openedAppStoreFromHero = true
        }
        openURLIfPossible(url)
    }

    private func openURLIfPossible(_ url: URL?) {
        guard let url else { return }
        openURL(url)
    }

    private static let alAdhanAppURL = URL(string: "https://apps.apple.com/us/app/al-adhan-prayer-times/id6475015493?platform=iphone")
    private static let alIslamAppURL = URL(string: "https://apps.apple.com/us/app/al-islam-islamic-pillars/id6449729655?platform=iphone")
    private static let alQuranAppURL = URL(string: "https://apps.apple.com/us/app/al-quran-beginner-quran/id6474894373?platform=iphone")
    private static let masjidAppURL = URL(string: "https://icoi.themasjidapp.net/download")
}

#Preview {
    SplashScreen()
        .environmentObject(Settings.shared)
}
#endif
