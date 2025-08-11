import SwiftUI

struct CreditsView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        Text("The ICOI App was created by Abubakr Elmallah (أبوبكر الملاح), who was a 17-year old high school student when this app was published on October 3, 2023.")
                            .font(.headline)
                            .padding(.vertical, 4)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        Link("abubakrelmallah.com", destination: URL(string: "https://abubakrelmallah.com/")!)
                            .foregroundColor(settings.accentColor2)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 4)
                            .padding(.bottom, 8)
                            .contextMenu {
                                Button(action: {
                                    UIPasteboard.general.string = "https://abubakrelmallah.com/"
                                }) {
                                    HStack {
                                        Image(systemName: "doc.on.doc")
                                        Text("Copy Website")
                                    }
                                }
                            }
                        
                        Spacer()
                    }
                    
                    Divider()
                        .background(settings.accentColor)
                        .padding(.trailing, -100)
                }
                .listRowSeparator(.hidden)
                
                Section(header: Text("CREDITS")) {
                    Link("Credit for the Arabic and English transliteration of the Quran data goes to Risan Bagja Pradana", destination: URL(string: "https://github.com/risan/quran-json")!)
                        .foregroundColor(settings.accentColor2)
                        .font(.body)
                    
                    Link("Credit for the English Saheeh International translation of the Quran data goes to Global Quran", destination: URL(string: "https://globalquran.com/download/data/")!)
                        .foregroundColor(settings.accentColor2)
                        .font(.body)
                    
                    Link("Credit for the Uthmani Hafs Quran font goes to Urdu Nigar", destination: URL(string: "https://urdunigaar.com/download/hafs-quran-ttf-font/")!)
                        .foregroundColor(settings.accentColor2)
                        .font(.body)
                    
                    Link("Credit for the Indopak Quran font goes to Urdu Nigar", destination: URL(string: "https://urdunigaar.com/download/al-mushaf-arabic-font-ttf-font-download/")!)
                        .foregroundColor(settings.accentColor2)
                        .font(.body)
                    
                    Link("Credit for the 99 Names of Allah from KabDeveloper", destination: URL(string: "https://github.com/KabDeveloper/99-Names-Of-Allah/tree/main")!)
                        .foregroundColor(settings.accentColor2)
                        .font(.body)
                    
                    Link("Credit for the Ayah Quran Recitations goes to Al Quran", destination: URL(string: "https://alquran.cloud/cdn")!)
                        .foregroundColor(settings.accentColor2)
                        .font(.body)
                    
                    Link("Credit for the Surah Quran Recitations goes to MP3 Quran", destination: URL(string: "https://mp3quran.net/eng")!)
                        .foregroundColor(settings.accentColor2)
                        .font(.body)
                }
                
                Section {
                    VersionNumber()
                        .font(.caption)
                }
                
                Section(header: Text("APPS BY ABUBAKR ELMALLAH")) {
                    ForEach(appsByAbubakr) { app in
                        AppLinkRow(imageName: app.imageName, title: app.title, url: app.url)
                    }
                }

                Section(header: Text("DISCORD BOTS BY ABUBAKR ELMALLAH")) {
                    ForEach(botsByAbubakr) { bot in
                        AppLinkRow(imageName: bot.imageName, title: bot.title, url: bot.url)
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(settings.accentColor)
            .tint(settings.accentColor)
            .navigationTitle("Credits")
        }
    }
}

let appsByAbubakr: [AppItem] = [
    AppItem(imageName: "Al-Adhan", title: "Al-Adhan | Prayer Times", url: "https://apps.apple.com/us/app/al-adhan-prayer-times/id6475015493?platform=iphone"),
    AppItem(imageName: "Al-Islam", title: "Al-Islam | Islamic Pillars", url: "https://apps.apple.com/us/app/al-islam-islamic-pillars/id6449729655?platform=iphone"),
    AppItem(imageName: "Al-Quran", title: "Al-Quran | Beginner Quran", url: "https://apps.apple.com/us/app/al-quran-beginner-quran/id6474894373?platform=iphone"),
    AppItem(imageName: "ICOI", title: "Islamic Center of Irvine (ICOI)", url: "https://apps.apple.com/us/app/islamic-center-of-irvine/id6463835936?platform=iphone"),
    AppItem(imageName: "Aurebesh", title: "Aurebesh Translator", url: "https://apps.apple.com/us/app/aurebesh-translator/id6670201513?platform=iphone"),
    AppItem(imageName: "Datapad", title: "Datapad | Aurebesh Translator", url: "https://apps.apple.com/us/app/datapad-aurebesh-translator/id6450498054?platform=iphone"),
]

let botsByAbubakr: [AppItem] = [
    AppItem(imageName: "SabaccDroid", title: "Sabacc Droid", url: "https://discordbotlist.com/bots/sabaac-droid"),
    AppItem(imageName: "AurebeshDroid", title: "Aurebesh Droid", url: "https://discordbotlist.com/bots/aurebesh-droid")
]

struct AppItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let url: String
}

struct AppLinkRow: View {
    @EnvironmentObject var settings: Settings
    
    var imageName: String
    var title: String
    var url: String

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                .frame(width: 50, height: 50)
                .padding(.trailing, 8)

            Link(title, destination: URL(string: url)!)
                .font(.subheadline)
        }
        .contextMenu {
            Button {
                if settings.hapticOn { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
                UIPasteboard.general.string = url
            } label: {
                Label("Copy Website", systemImage: "doc.on.doc")
            }
        }
    }
}
