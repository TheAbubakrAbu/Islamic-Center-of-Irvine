import SwiftUI

struct ICOIPrayerList: View {
    @EnvironmentObject var settings: Settings
    
    private func columnWidth(for textStyle: UIFont.TextStyle, extra: CGFloat = 4, sample: String? = nil, fontName: String? = nil) -> CGFloat {
        let sampleString = (sample ?? "M") as NSString
        let font: UIFont

        if let fontName = fontName, let customFont = UIFont(name: fontName, size: UIFont.preferredFont(forTextStyle: textStyle).pointSize) {
            font = customFont
        } else {
            font = UIFont.preferredFont(forTextStyle: textStyle)
        }

        return ceil(sampleString.size(withAttributes: [.font: font]).width) + extra
    }

    private var glyphWidth: CGFloat {
        columnWidth(for: .subheadline, extra: 0, sample: "88:88 PM")
    }
    
    var body: some View {
        if let prayersObject = settings.prayersICOI {
            let prayers = prayersObject.prayers
            let halfCount = prayers.count / 2
            let calendar = Calendar.current
            let isFriday = calendar.component(.weekday, from: Date()) == 6
            
            let currentShortenedTransliterationFirst = settings.currentPrayerICOI?.nameTransliteration.split(separator: " ").first ?? ""
            let isJummuahCurrent = settings.currentPrayerICOI?.nameTransliteration.contains("Jummuah") ?? false
            
            Section(header: Text("PRAYER TIMES")) {
                ForEach(0..<halfCount, id: \.self) { i in
                    let index1 = i * 2
                    let index2 = i * 2 + 1
                    
                    let prayer1 = prayers[index1]
                    let prayer2 = prayers[index2]
                    
                    let parts1 = prayer1.nameTransliteration.split(separator: " ")
                    let shortenedTransliteration1 = parts1.first ?? ""
                    let shortenedTransliteration3 = parts1.last ?? ""
                    let isJummuahAtIndex = prayer1.nameTransliteration.contains("Jummuah")
                    
                    let isHighlighted = (shortenedTransliteration1 == currentShortenedTransliterationFirst) || (isJummuahCurrent && isJummuahAtIndex)
                    
                    let isShurooq = (shortenedTransliteration1 == "Shurooq")
                    let isJummuahTitle = (shortenedTransliteration3 == "Jummuah")
                    let isDimmedJummuah = (!isFriday && isJummuahTitle)
                    let iconColor: Color = isShurooq ? .primary : (isDimmedJummuah ? .secondary : settings.accentColor)
                    let titleColor: Color = isDimmedJummuah ? .secondary : .primary
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(isHighlighted ? settings.accentColor.opacity(0.25) : .clear)
                            .padding(.horizontal, -12)
                            #if !os(watchOS)
                            .padding(.vertical, -11)
                            #endif
                        
                        VStack(alignment: .leading) {
                            #if !os(watchOS)
                            HStack {
                                Image(systemName: prayer1.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(iconColor)
                                    .padding(.all, 4)
                                    .padding(.trailing, 8)
                                
                                VStack(alignment: .leading) {
                                    Text(isJummuahTitle ? shortenedTransliteration3 : shortenedTransliteration1)
                                        .font(.headline)
                                        .foregroundColor(titleColor)
                                    
                                    Text(isJummuahTitle ? "Friday" : prayer1.nameEnglish)
                                        .font(.subheadline)
                                        .foregroundColor(titleColor)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    if isShurooq {
                                        Text("Fajr ends:")
                                            .foregroundColor(.secondary)
                                            .font(.subheadline)
                                        
                                        Text("\(prayer1.time, style: .time)")
                                            .foregroundColor(.secondary)
                                            .font(.subheadline)
                                    } else if isJummuahTitle {
                                        HStack(spacing: 0) {
                                            Text("1st:")
                                            
                                            Text(prayer1.time, style: .time)
                                                .frame(width: glyphWidth, alignment: .trailing)
                                        }
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)

                                        HStack(spacing: 0) {
                                            Text("2nd:")
                                            
                                            Text(prayer2.time, style: .time)
                                                .frame(width: glyphWidth, alignment: .trailing)
                                        }
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    } else {
                                        HStack(spacing: 0) {
                                            Text("Adhan:")
                                            
                                            Text(prayer1.time, style: .time)
                                                .frame(width: glyphWidth, alignment: .trailing)
                                        }
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)

                                        HStack(spacing: 0) {
                                            Text("Iqama:")
                                            
                                            Text(prayer2.time, style: .time)
                                                .frame(width: glyphWidth, alignment: .trailing)
                                        }
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    }
                                }
                            }
                            #else
                            HStack {
                                Image(systemName: prayer1.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(iconColor)
                                    .padding(.all, 4)
                                    .padding(.trailing, 8)
                                
                                VStack(alignment: .leading) {
                                    Text(isJummuahTitle ? shortenedTransliteration3 : shortenedTransliteration1)
                                        .font(.headline)
                                        .foregroundColor(titleColor)
                                    
                                    Text(isJummuahTitle ?  "Friday" : prayer1.nameEnglish)
                                        .font(.subheadline)
                                        .foregroundColor(titleColor)
                                }
                                
                                Spacer()
                            }
                            
                            VStack(alignment: .leading) {
                                if isShurooq {
                                    Text("Fajr ends \(prayer1.time, style: .time)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                } else if isJummuahTitle {
                                    Text("First: \(prayer1.time, style: .time)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    
                                    Text("Second: \(prayer2.time, style: .time)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                } else {
                                    Text("Adhan: \(prayer1.time, style: .time)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                    
                                    Text("Iqama: \(prayer2.time, style: .time)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                }
                            }
                            #endif
                        }
                        .padding(.vertical, 4)
                        .foregroundColor(isShurooq ? .primary : settings.accentColor)
                    }
                }
            }
        }
    }
}
