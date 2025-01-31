import SwiftUI

struct ICOIPrayerList: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        if let prayersObject = settings.prayersICOI {
            let halfCount = prayersObject.prayers.count / 2
            let weekday = Calendar.current.component(.weekday, from: Date())
            let isFriday = weekday == 6
            
            Section(header: Text("PRAYER TIMES")) {
                ForEach(0..<halfCount, id: \.self) { i in
                    let index1 = i * 2
                    let index2 = i * 2 + 1
                    
                    let shortenedTransliteration1 = prayersObject.prayers[index1].nameTransliteration.split(separator: " ").first ?? ""
                    let shortenedTransliteration2 = settings.currentPrayerICOI?.nameTransliteration.split(separator: " ").first ?? ""
                    let shortenedTransliteration3 = prayersObject.prayers[index1].nameTransliteration.split(separator: " ").last ?? ""
                    let isJummuahCurrent = settings.currentPrayerICOI?.nameTransliteration.contains("Jummuah") ?? false
                    let isJummuahAtIndex = prayersObject.prayers[index1].nameTransliteration.contains("Jummuah")
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill((shortenedTransliteration1 == shortenedTransliteration2 || (isJummuahCurrent && isJummuahAtIndex)) ? settings.accentColor.opacity(0.25) : .clear)
                            .padding(.horizontal, -12)
                        
                        VStack(alignment: .leading) {
                            #if !os(watchOS)
                            HStack {
                                Image(systemName: prayersObject.prayers[index1].image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(shortenedTransliteration1 == "Shurooq" ? .primary : !isFriday && shortenedTransliteration3 == "Jummuah" ? .secondary : settings.accentColor)
                                    .padding(.all, 4)
                                    .padding(.trailing, 8)
                                
                                VStack(alignment: .leading) {
                                    Text(shortenedTransliteration3 == "Jummuah" ? shortenedTransliteration3 : shortenedTransliteration1)
                                        .font(.headline)
                                        .foregroundColor(!isFriday && shortenedTransliteration3 == "Jummuah" ? .secondary : .primary)
                                    
                                    Text(shortenedTransliteration3 == "Jummuah" ? "Friday" : prayersObject.prayers[index1].nameEnglish)
                                        .font(.subheadline)
                                        .foregroundColor(!isFriday && shortenedTransliteration3 == "Jummuah" ? .secondary : .primary)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    if shortenedTransliteration1 == "Shurooq" {
                                        Text("Fajr ends:")
                                            .foregroundColor(.secondary)
                                            .font(.subheadline)
                                        
                                        Text("\(prayersObject.prayers[index1].time, style: .time)")
                                            .foregroundColor(.secondary)
                                            .font(.subheadline)
                                    } else if shortenedTransliteration3 == "Jummuah" {
                                        Text("First: \(prayersObject.prayers[index1].time, style: .time)")
                                            .foregroundColor(.secondary)
                                            .font(.subheadline)
                                        
                                        Text("Second: \(prayersObject.prayers[index2].time, style: .time)")
                                            .foregroundColor(.secondary)
                                            .font(.subheadline)
                                    } else {
                                        Text("Adhan: \(prayersObject.prayers[index1].time, style: .time)")
                                            .foregroundColor(.secondary)
                                            .font(.subheadline)
                                        
                                        Text("Iqamah: \(prayersObject.prayers[index2].time, style: .time)")
                                            .foregroundColor(.secondary)
                                            .font(.subheadline)
                                    }
                                }
                            }
                            #else
                            HStack {
                                Image(systemName: prayersObject.prayers[index1].image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(shortenedTransliteration1 == "Shurooq" ? .primary : !isFriday && shortenedTransliteration3 == "Jummuah" ? .secondary : settings.accentColor)
                                    .padding(.all, 4)
                                    .padding(.trailing, 8)
                                
                                VStack(alignment: .leading) {
                                    Text(shortenedTransliteration3 == "Jummuah" ? shortenedTransliteration3 : shortenedTransliteration1)
                                        .font(.headline)
                                        .foregroundColor(!isFriday && shortenedTransliteration3 == "Jummuah" ? .secondary : .primary)
                                    
                                    Text(shortenedTransliteration3 == "Jummuah" ?  "Friday" : prayersObject.prayers[index1].nameEnglish)
                                        .font(.subheadline)
                                        .foregroundColor(!isFriday && shortenedTransliteration3 == "Jummuah" ? .secondary : .primary)
                                }
                                
                                Spacer()
                            }
                            
                            VStack(alignment: .leading) {
                                if shortenedTransliteration1 == "Shurooq" {
                                    Text("Fajr ends \(prayersObject.prayers[index1].time, style: .time)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                } else if shortenedTransliteration3 == "Jummuah" {
                                    Text("First: \(prayersObject.prayers[index1].time, style: .time)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    
                                    Text("Second: \(prayersObject.prayers[index2].time, style: .time)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                } else {
                                    Text("Adhan: \(prayersObject.prayers[index1].time, style: .time)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    
                                    Text("Iqamah: \(prayersObject.prayers[index2].time, style: .time)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                }
                            }
                            #endif
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
    }
}
