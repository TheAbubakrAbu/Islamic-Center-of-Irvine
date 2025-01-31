import SwiftUI

struct CreditsView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        List {
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    Text("The Islamic Center of Irvine (ICOI) App was created by Abubakr Elmallah (أبوبكر الملاح), who was a 17-year old high school student when this app was published on October 3, 2023.")
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
            
            Text("Version 3.4.2")
                .font(.caption)

            Section(header: Text("APPS BY ABUBAKR ELMALLAH")) {
                HStack {
                    Image("Al-Adhan")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 8)
                    
                    Link("Al-Adhan | Prayer Times", destination: URL(string: "https://apps.apple.com/us/app/al-adhan-prayer-times/id6475015493?platform=iphone")!)
                        .font(.subheadline)
                }
                
                HStack {
                    Image("Al-Islam")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 8)
                    
                    Link("Al-Islam | Islamic Pillars", destination: URL(string: "https://apps.apple.com/us/app/al-islam-islamic-pillars/id6449729655?platform=iphone")!)
                        .font(.subheadline)
                }
                
                HStack {
                    Image("Al-Quran")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 8)
                    
                    Link("Al-Quran | Beginner Quran", destination: URL(string: "https://apps.apple.com/us/app/al-quran-beginner-quran/id6474894373?platform=iphone")!)
                        .font(.subheadline)
                }
                
                HStack {
                    Image("Aurebesh")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 8)
                    
                    Link("Aurebesh Translator", destination: URL(string: "https://apps.apple.com/us/app/aurebesh-translator/id6670201513?platform=iphone")!)
                        .font(.subheadline)
                }
                
                HStack {
                    Image("Datapad")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 8)
                    
                    Link("Datapad | Aurebesh Translator", destination: URL(string: "https://apps.apple.com/us/app/datapad-aurebesh-translator/id6450498054?platform=iphone")!)
                        .font(.subheadline)
                }
                
                HStack {
                    Image("ICOI")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 8)
                    
                    Link("Islamic Center of Irvine (ICOI)", destination: URL(string: "https://apps.apple.com/us/app/islamic-center-of-irvine/id6463835936?platform=iphone")!)
                        .font(.subheadline)
                }
            }
            
            Section(header: Text("DISCORD BOT BY ABUBAKR ELMALLAH")) {
                HStack {
                    Image("Sabacc")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 8)
                    
                    Link("Sabacc Droid", destination: URL(string: "https://discordbotlist.com/bots/sabaac-droid")!)
                        .font(.subheadline)
                }
            }
        }
        .listStyle(.plain)
        .accentColor(settings.accentColor)
    }
}
