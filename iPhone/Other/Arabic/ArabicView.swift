import SwiftUI

class LetterDataFactory {
    private var idCounter = 1

    func makeLetterData(letter: String, forms: [String], name: String, transliteration: String, showTashkeel: Bool, sound: String) -> LetterData {
        let data = LetterData(id: idCounter, letter: letter, forms: forms, name: name, transliteration: transliteration, showTashkeel: showTashkeel, sound: sound)
        idCounter += 1
        return data
    }
}

let factory = LetterDataFactory()

let standardArabicLetters = [
    factory.makeLetterData(letter: "ا", forms: ["ـا", "ـا ـ", "ا ـ"], name: "اَلِف", transliteration: "alif", showTashkeel: false, sound: "a"),
    factory.makeLetterData(letter: "ب", forms: ["ـب", "ـبـ", "بـ"], name: "بَاء", transliteration: "baa", showTashkeel: true, sound: "b"),
    factory.makeLetterData(letter: "ت", forms: ["ـت", "ـتـ", "تـ"], name: "تَاء", transliteration: "taa", showTashkeel: true, sound: "t"),
    factory.makeLetterData(letter: "ث", forms: ["ـث", "ـثـ", "ثـ"], name: "ثَاء", transliteration: "thaa", showTashkeel: true, sound: "th"),
    factory.makeLetterData(letter: "ج", forms: ["ـج", "ـجـ", "جـ"], name: "جِيم", transliteration: "jeem", showTashkeel: true, sound: "j"),
    factory.makeLetterData(letter: "ح", forms: ["ـح", "ـحـ", "حـ"], name: "حَاء", transliteration: "Haa", showTashkeel: true, sound: "H"),
    factory.makeLetterData(letter: "خ", forms: ["ـخ", "ـخـ", "خـ"], name: "خَاء", transliteration: "khaa", showTashkeel: true, sound: "kh"),
    factory.makeLetterData(letter: "د", forms: ["ـد", "ـد ـ", "د ـ"], name: "دَال", transliteration: "daal", showTashkeel: true, sound: "d"),
    factory.makeLetterData(letter: "ذ", forms: ["ـذ", "ـذ ـ", "ذ ـ"], name: "ذَال", transliteration: "dhaal", showTashkeel: true, sound: "dh"),
    factory.makeLetterData(letter: "ر", forms: ["ـر", "ـر ـ", "ر ـ"], name: "رَاء", transliteration: "raa", showTashkeel: true, sound: "r"),
    factory.makeLetterData(letter: "ز", forms: ["ـز", "ـز ـ", "ز ـ"], name: "زَاي", transliteration: "zay", showTashkeel: true, sound: "z"),
    factory.makeLetterData(letter: "س", forms: ["ـس", "ـسـ", "سـ"], name: "سِين", transliteration: "seen", showTashkeel: true, sound: "s"),
    factory.makeLetterData(letter: "ش", forms: ["ـش", "ـشـ", "شـ"], name: "شِين", transliteration: "sheen", showTashkeel: true, sound: "sh"),
    factory.makeLetterData(letter: "ص", forms: ["ـص", "ـصـ", "صـ"], name: "صَاد", transliteration: "Saad", showTashkeel: true, sound: "S"),
    factory.makeLetterData(letter: "ض", forms: ["ـض", "ـضـ", "ضـ"], name: "ضَاد", transliteration: "Daad", showTashkeel: true, sound: "D"),
    factory.makeLetterData(letter: "ط", forms: ["ـط", "ـطـ", "طـ"], name: "طَاء", transliteration: "Taa", showTashkeel: true, sound: "T"),
    factory.makeLetterData(letter: "ظ", forms: ["ـظ", "ـظـ", "ظـ"], name: "ظَاء", transliteration: "Dhaa", showTashkeel: true, sound: "Dh"),
    factory.makeLetterData(letter: "ع", forms: ["ـع", "ـعـ", "عـ"], name: "عَين", transliteration: "'ayn", showTashkeel: true, sound: "'a"),
    factory.makeLetterData(letter: "غ", forms: ["ـغ", "ـغـ", "غـ"], name: "غَين", transliteration: "ghayn", showTashkeel: true, sound: "gh"),
    factory.makeLetterData(letter: "ف", forms: ["ـف", "ـفـ", "فـ"], name: "فَاء", transliteration: "faa", showTashkeel: true, sound: "f"),
    factory.makeLetterData(letter: "ق", forms: ["ـق", "ـقـ", "قـ"], name: "قَاف", transliteration: "qaaf", showTashkeel: true, sound: "q"),
    factory.makeLetterData(letter: "ك", forms: ["ـك", "ـكـ", "كـ"], name: "كَاف", transliteration: "kaaf", showTashkeel: true, sound: "k"),
    factory.makeLetterData(letter: "ل", forms: ["ـل", "ـلـ", "لـ"], name: "لَام", transliteration: "laam", showTashkeel: true, sound: "l"),
    factory.makeLetterData(letter: "م", forms: ["ـم", "ـمـ", "مـ"], name: "مِيم", transliteration: "meem", showTashkeel: true, sound: "m"),
    factory.makeLetterData(letter: "ن", forms: ["ـن", "ـنـ", "نـ"], name: "نُون", transliteration: "noon", showTashkeel: true, sound: "n"),
    factory.makeLetterData(letter: "ه", forms: ["ـه", "ـهـ", "هـ"], name: "هَاء", transliteration: "haa", showTashkeel: true, sound: "h"),
    factory.makeLetterData(letter: "و", forms: ["ـو", "ـو ـ", "و ـ"], name: "وَاو", transliteration: "waw", showTashkeel: true, sound: "w"),
    factory.makeLetterData(letter: "ي", forms: ["ـي", "ـيـ", "يـ"], name: "يَاء", transliteration: "yaa", showTashkeel: true, sound: "y"),
]

let otherArabicLetters = [
    factory.makeLetterData(letter: "ة", forms: ["ـة", "ـة ـ", "ة ـ"], name: "تَاء مَربُوطَة", transliteration: "taa marbuuTa", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "ء", forms: ["ـ ء", "ـ ء ـ", "ء ـ"], name: "هَمزَة", transliteration: "hamza", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "أ", forms: ["ـأ", "ـأ ـ", "أ ـ"], name: "هَمزَة عَلَى أَلِف", transliteration: "hamza on alif", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "إ", forms: ["ـإ", "ـإ ـ", "إ ـ"], name: "هَمزَة عَلَى أَلِف", transliteration: "hamza on alif", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "ئ", forms: ["ـئ", "ـئ ـ", "ئ ـ"], name: "هَمزَة عَلَى يَاء", transliteration: "hamza on yaa", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "ؤ", forms: ["ـؤ", "ـؤ ـ", "ؤ ـ"], name: "هَمزَة عَلَى وَاو", transliteration: "hamza on waw", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "ٱ", forms: ["ٱـ", "ـٱ", "ـٱـ"], name: "هَمزَة الوَصل", transliteration: "hamzatul waSl", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "آ", forms: ["ـآ", "ـآ ـ", "آ ـ"], name: "أَلِف مَدَّ", transliteration: "alif mad", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "يٓ", forms: ["ـيٓ", "ـيٓـ", "يٓـ"], name: "يَاء مَدّ", transliteration: "yaa mad", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "وٓ", forms: ["ـوٓ", "ـوٓـ", "وٓـ"], name: "واو مَدّ", transliteration: "waw mad", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "ى", forms: ["ـى", "ـى ـ", "ى ـ"], name: "أَلِف مَقصُورَة", transliteration: "alif maqSoorah", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "ل ا - لا", forms: ["ـلا", "ـلا ـ", "لا ـ"], name: "لَاء", transliteration: "laa", showTashkeel: false, sound: ""),
]

let numbers = [
    (number: "٠", name: "صِفر", transliteration: "sifr", englishNumber: "0"),
    (number: "١", name: "وَاحِد", transliteration: "waahid", englishNumber: "1"),
    (number: "٢", name: "اِثنَين", transliteration: "ithnaan", englishNumber: "2"),
    (number: "٣", name: "ثَلاثَة", transliteration: "thalaathah", englishNumber: "3"),
    (number: "٤", name: "أَربَعَة", transliteration: "arbaʿah", englishNumber: "4"),
    (number: "٥", name: "خَمسَة", transliteration: "khamsah", englishNumber: "5"),
    (number: "٦", name: "سِتَّة", transliteration: "sittah", englishNumber: "6"),
    (number: "٧", name: "سَبعَة", transliteration: "sabʿah", englishNumber: "7"),
    (number: "٨", name: "ثَمانِيَة", transliteration: "thamaaniyah", englishNumber: "8"),
    (number: "٩", name: "تِسعَة", transliteration: "tisʿah", englishNumber: "9"),
    (number: "١٠", name: "عَشَرَة", transliteration: "ʿasharah", englishNumber: "10"),
]

let tashkeels = [
    Tashkeel(english: "Fatha", arabic: "فَتْحَة", tashkeelMark: "َ", transliteration: "a"),
    Tashkeel(english: "Kasra", arabic: "كَسْرَة", tashkeelMark: "ِ", transliteration: "i"),
    Tashkeel(english: "Damma", arabic: "ضَمَّة", tashkeelMark: "ُ", transliteration: "u"),
    Tashkeel(english: "Fathatayn", arabic: "فَتْحَتَيْن", tashkeelMark: "ًا", transliteration: "an"),
    Tashkeel(english: "Kasratayn", arabic: "كَسْرَتَيْن", tashkeelMark: "ٍ", transliteration: "in"),
    Tashkeel(english: "Dammatayn", arabic: "ضَمَّتَيْن", tashkeelMark: "ٌ", transliteration: "un"),
    Tashkeel(english: "Alif", arabic: "أَلِف", tashkeelMark: "َا", transliteration: "aa"),
    Tashkeel(english: "Yaa", arabic: "يَاء", tashkeelMark: "ِي", transliteration: "ii"),
    Tashkeel(english: "Waw", arabic: "وَاو", tashkeelMark: "ُو", transliteration: "uu"),
    Tashkeel(english: "Dagger Alif", arabic: "ألف خنجرية", tashkeelMark: "َٰ", transliteration: "aa"),
    Tashkeel(english: "Miniature Yaa", arabic: "يَاء صغيرة", tashkeelMark: "ِۦ", transliteration: "ii"),
    Tashkeel(english: "Miniature Waw", arabic: "واو صغيرة", tashkeelMark: "ُۥ", transliteration: "uu"),
    Tashkeel(english: "Alif Mad", arabic: "أَلِف مَدّ", tashkeelMark: "َآ", transliteration: "aaaa"),
    Tashkeel(english: "Yaa Mad", arabic: "يَاء مَدّ", tashkeelMark: "ِيٓ", transliteration: "iiii"),
    Tashkeel(english: "Waw Mad", arabic: "واو مَدّ", tashkeelMark: "ُوٓ", transliteration: "uuuu"),
    Tashkeel(english: "Alif Maqsoorah", arabic: "ياء بلا نقاط", tashkeelMark: "َى", transliteration: "aa"),
    Tashkeel(english: "Shaddah", arabic: "شَدَّة", tashkeelMark: "ّ", transliteration: ""),
    Tashkeel(english: "Sukoon", arabic: "سُكُون", tashkeelMark: "ْ", transliteration: "")
]

struct Tashkeel {
    let english: String
    let arabic: String
    let tashkeelMark: String
    let transliteration: String
}

struct LetterSectionHeader: View {
    @EnvironmentObject var settings: Settings
    
    let letterData: LetterData
    
    var body: some View {
        HStack {
            Text("LETTER")
                .font(.subheadline)
            Spacer()
            Image(systemName: settings.isLetterFavorite(letterData: letterData) ? "star.fill" : "star")
                .foregroundColor(settings.accentColor)
                .font(.subheadline)
                .onTapGesture {
                    settings.hapticFeedback()
                    settings.toggleLetterFavorite(letterData: letterData)
                }
        }
    }
}

struct ArabicNumberRow: View {
    @EnvironmentObject var settings: Settings
    let numberData: (number: String, name: String, transliteration: String, englishNumber: String)
    
    var body: some View {
        HStack {
            Text(numberData.englishNumber)
                .font(.title3)
            
            Spacer()
            
            VStack(alignment: .center) {
                Text(numberData.name)
                    .font(settings.useFontArabic ? .custom(settings.fontArabic, size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize) : .subheadline)
                    .foregroundColor(settings.accentColor)
                
                Text(numberData.transliteration)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(numberData.number)
                .font(.title2)
                .foregroundColor(settings.accentColor)
        }
    }
}

struct ArabicView: View {
    @EnvironmentObject var settings: Settings
    
    @State private var searchText = ""
    @AppStorage("groupingType") private var groupingType: String = "normal"
    
    let similarityGroups: [[String]] = [
        ["ا", "و", "ي"],
        ["ب", "ت", "ث"],
        ["ج", "ح", "خ"],
        ["د", "ذ"],
        ["ر", "ز"],
        ["س", "ش"],
        ["ص", "ض"],
        ["ط", "ظ"],
        ["ع", "غ"],
        ["ف", "ق"],
        ["ك", "ل"],
        ["م", "ن"],
        ["ه", "ة"]
    ]
    
    var body: some View {
        VStack {
            List {
                if searchText.isEmpty {
                    if !settings.favoriteLetters.isEmpty {
                        Section(header: Text("FAVORITE LETTERS")) {
                            ForEach(settings.favoriteLetters.sorted(), id: \.id) { favorite in
                                ArabicLetterRow(letterData: favorite)
                            }
                        }
                    }
                    
                    if groupingType == "normal" {
                        Section(header: Text("STANDARD ARABIC LETTERS")) {
                            ForEach(standardArabicLetters, id: \.letter) { letterData in
                                ArabicLetterRow(letterData: letterData)
                            }
                        }
                    } else {
                        ForEach(similarityGroups.indices, id: \.self) { index in
                            let group = similarityGroups[index]
                            let groupLettersString = group.joined(separator: " AND ")
                            
                            Section(header: Text(index == 0 ? "VOWEL LETTERS" : groupLettersString)) {
                                ForEach(group, id: \.self) { letter in
                                    if let letterData = standardArabicLetters.first(where: { $0.letter == letter }) {
                                        ArabicLetterRow(letterData: letterData)
                                    } else if let letterData = otherArabicLetters.first(where: { $0.letter == letter }) {
                                        ArabicLetterRow(letterData: letterData)
                                    }
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("SPECIAL ARABIC LETTERS")) {
                        ForEach(otherArabicLetters, id: \.letter) { letterData in
                            ArabicLetterRow(letterData: letterData)
                        }
                    }
                    
                    Section(header: Text("ARABIC NUMBERS")) {
                        ForEach(numbers, id: \.number) { numberData in
                            ArabicNumberRow(numberData: numberData)
                        }
                    }
                    
                    Section(header: Text("QURAN SIGNS")) {
                        HStack {
                            Text("Make Sujood (Prostration)")
                                .font(.subheadline)
                            Spacer()
                            Text("۩")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor)
                        }
                        
                        HStack {
                            Text("The Mandatory Stop")
                                .font(.subheadline)
                            Spacer()
                            Text("مـ")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor)
                        }
                        
                        HStack {
                            Text("The Preferred Stop")
                                .font(.subheadline)
                            Spacer()
                            Text("قلى")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor)
                        }
                        
                        HStack {
                            Text("The Permissible Stop")
                                .font(.subheadline)
                            Spacer()
                            Text("ج")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor)
                        }
                        
                        HStack {
                            Text("The Short Pause")
                                .font(.subheadline)
                            Spacer()
                            Text("س")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor)
                        }
                        
                        HStack {
                            Text("Stop at One")
                                .font(.subheadline)
                            Spacer()
                            Text("∴ ∴")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor)
                        }
                        
                        HStack {
                            Text("The Preferred Continuation")
                                .font(.subheadline)
                            Spacer()
                            Text("صلى")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor)
                        }
                        
                        HStack {
                            Text("The Mandatory Continuation")
                                .font(.subheadline)
                            Spacer()
                            Text("لا")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor)
                        }
                        
                        Link("View More: Tajweed Rules & Stopping/Pausing Signs",
                             destination: URL(string: "https://studioarabiya.com/blog/tajweed-rules-stopping-pausing-signs/")!)
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor)
                    }
                } else {
                    Section(header: Text("SEARCH RESULTS")) {
                        ForEach(standardArabicLetters.filter { letterData in
                            let st = searchText.lowercased()
                            return st.isEmpty ||
                            letterData.letter.lowercased().contains(st) ||
                            letterData.name.lowercased().contains(st) ||
                            letterData.transliteration.lowercased().contains(st)
                        }) { letterData in
                            ArabicLetterRow(letterData: letterData)
                        }
                        
                        ForEach(otherArabicLetters.filter { letterData in
                            let st = searchText.lowercased()
                            return st.isEmpty ||
                            letterData.letter.lowercased().contains(st) ||
                            letterData.name.lowercased().contains(st) ||
                            letterData.transliteration.lowercased().contains(st)
                        }) { letterData in
                            ArabicLetterRow(letterData: letterData)
                        }
                    }
                }
            }
            #if os(watchOS)
            .searchable(text: $searchText)
            #endif
            .applyConditionalListStyle(defaultView: true)
            .dismissKeyboardOnScroll()
            
            #if !os(watchOS)
            Picker("Grouping", selection: $groupingType.animation(.easeInOut)) {
                Text("Normal Grouping").tag("normal")
                Text("Group by Similarity").tag("similarity")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            SearchBar(text: $searchText.animation(.easeInOut))
                .padding(.horizontal, 8)
            #endif
        }
        .navigationTitle("Arabic Alphabet")
    }
}

struct ArabicLetterRow: View {
    @EnvironmentObject var settings: Settings
    let letterData: LetterData
    
    var body: some View {
        VStack {
            NavigationLink(destination: ArabicLetterView(letterData: letterData)) {
                HStack {
                    Text(letterData.transliteration)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text(letterData.letter)
                        .font(settings.useFontArabic ? .custom(settings.fontArabic, size: UIFont.preferredFont(forTextStyle: .title2).pointSize) : .title2)
                        .foregroundColor(settings.accentColor)
                }
                .padding(.vertical, -2)
                #if !os(watchOS)
                .swipeActions(edge: .leading) {
                    Button(action: {
                        settings.hapticFeedback()
                        
                        settings.toggleLetterFavorite(letterData: letterData)
                    }) {
                        Image(systemName: settings.isLetterFavorite(letterData: letterData) ? "star.fill" : "star")
                    }
                    .tint(settings.accentColor)
                }
                .swipeActions(edge: .trailing) {
                    Button(action: {
                        settings.hapticFeedback()
                        
                        settings.toggleLetterFavorite(letterData: letterData)
                    }) {
                        Image(systemName: settings.isLetterFavorite(letterData: letterData) ? "star.fill" : "star")
                    }
                    .tint(settings.accentColor)
                }

                .contextMenu {
                    Button(role: settings.isLetterFavorite(letterData: letterData) ? .destructive : nil, action: {
                        settings.hapticFeedback()
                        settings.toggleLetterFavorite(letterData: letterData)
                    }) {
                        Label(settings.isLetterFavorite(letterData: letterData) ? "Unfavorite Letter" : "Favorite Letter", systemImage: settings.isLetterFavorite(letterData: letterData) ? "star.fill" : "star")
                    }
                    
                    Button(action: {
                        UIPasteboard.general.string = letterData.letter
                        settings.hapticFeedback()
                    }) {
                        Label("Copy Letter", systemImage: "doc.on.doc")
                    }
                        
                    Button(action: {
                        UIPasteboard.general.string = letterData.transliteration
                        settings.hapticFeedback()
                    }) {
                        Label("Copy Transliteration", systemImage: "doc.on.doc")
                    }
                }
                #endif
            }
        }
    }
}

import SwiftUI

struct ArabicLetterView: View {
    @EnvironmentObject var settings: Settings
    
    let letterData: LetterData
        
    var body: some View {
        VStack {
            List {
                Section(header: LetterSectionHeader(letterData: letterData)) {
                    VStack {
                        HStack(alignment: .center) {
                            Spacer()
                            
                            Text(letterData.transliteration)
                                .font(.subheadline)
                            
                            Spacer()
                            
                            Text(letterData.name)
                                .font(settings.useFontArabic ? .custom(settings.fontArabic, size: UIFont.preferredFont(forTextStyle: .title1).pointSize) : .title)
                            
                            Spacer()
                        }
                    }
                    #if !os(watchOS)
                    .listRowSeparator(.hidden, edges: .bottom)
                    #endif
                    .padding(.vertical, settings.useFontArabic ? 0 : 2)
                }
                
                Section(header: Text("DIFFERENT FORMS")) {
                    VStack {
                        HStack(alignment: .center) {
                            ForEach(0..<3, id: \.self) { index in
                                Spacer()
                                Text(letterData.forms[index])
                                    .font(settings.useFontArabic ? .custom(settings.fontArabic, size: UIFont.preferredFont(forTextStyle: .title1).pointSize) : .title)
                                Spacer()
                            }
                        }
                    }
                    #if !os(watchOS)
                    .listRowSeparator(.hidden, edges: .bottom)
                    #endif
                    .padding(.vertical, settings.useFontArabic ? 0 : 2)
                }
                
                if letterData.transliteration == "alif" || letterData.transliteration == "waw" || letterData.transliteration == "yaa" {
                    Section(header: Text("SPECIAL ROLE OF VOWEL LETTERS")) {
                        Text("In Arabic, three letters (Alif, Waw, and Yaa) have a special dual role:")
                            .font(.body)
                        
                        if letterData.transliteration == "alif" {
                            Text("- **Alif (ا)**: Functions as a long vowel 'aa' when used after a letter with a fatha. For example, كِتَاب (kitaab - book). Alif never carries tashkeel unless it represents Hamza.")
                                .font(.body)
                        }
                        
                        if letterData.transliteration == "waw" {
                            Text("- **Waw (و)**: Functions as a long vowel 'uu' when used after a letter with a damma, like in رَسُول (rasool - messenger). As a consonant, it makes the 'w' sound, like in وَقَفَ (waqafa - stood).")
                                .font(.body)
                        }
                        
                        if letterData.transliteration == "yaa" {
                            Text("- **Yaa (ي): Functions as a long vowel 'ii' when used after a letter with a kasra, like in كِتَابِي (kitaabi - my book). As a consonant, it makes the 'y' sound, like in يَد (yad - hand).")
                                .font(.body)
                        }
                        
                        Text("These letters serve as vowels when they follow specific diacritics, and as consonants when they begin a word or are preceded by a sukoon.")
                            .font(.body)
                    }
                }
                
                if letterData.showTashkeel {
                    Section(header: Text("DIFFERENT HARAKAAT (VOWELS)")) {
                        let chunks = tashkeels.chunked(into: 3)
                        ForEach(0..<chunks.count, id: \.self) { index in
                            VStack {
                                #if !os(watchOS)
                                if index > 0 {
                                    Divider()
                                        .padding(.trailing, -100)
                                }
                                #endif
                                
                                TashkeelRow(
                                    letterData: letterData,
                                    tashkeels: chunks[index]
                                )
                                .padding(.top, 14)
                                .padding(.bottom, index == chunks.count - 1 ? 14 : 0)
                            }
                            #if !os(watchOS)
                            .listRowSeparator(.hidden, edges: .bottom)
                            #endif
                        }
                    }
                }
                if (!letterData.showTashkeel && letterData.transliteration != "alif") || letterData.transliteration == "yaa" {
                    Section(header: Text("PURPOSE")) {
                        if letterData.transliteration == "yaa" {
                            Text("In the Uthmani script of the Quran, when 'yaa' is written at the end of a word (or by itself), it is usually written without the two dots underneath.")
                                .font(.body)
                        } else if letterData.transliteration == "taa marbuuTa" {
                            Text("\"Taa marbuuTa\" means \"tied taa\" and is used to indicate the feminine gender in Arabic.")
                                .font(.body)
                            Text("It is typically added to the end of a noun to show that the noun is feminine. For example, the Arabic word for teacher is \"معلم\" (mu'allim) for a male and \"معلمة\" (mu'allima) for a female.")
                                .font(.body)
                            Text("Taa marbuuTa is pronounced as a \"t\" sound in certain cases, such as when the word is in the construct state or has a suffix. Otherwise, it is often silent but affects the preceding vowel, usually creating a short \"ah\" sound, similar to 'ه' (as in \"mu'allimah\").")
                                .font(.body)
                        } else if letterData.transliteration == "hamzatul waSl" {
                            Text("The term \"hamzatul waSl\" translates to \"connecting hamza\" or \"hamza of connection.\"")
                                .font(.body)
                            Text("Hamzatul waSl is always written as an Alif (ا) and is pronounced only if it begins a word at the start of speech. When the word follows another in a sentence, the hamzatul waSl is not pronounced, creating a smooth connection between words.")
                                .font(.body)
                            Text("If a word starts with hamzatul waSl, its pronunciation depends on the third letter of the word. For verbs: if the third letter has a damma, pronounce it with a damma (أُ); if it has a kasra or fatha, pronounce it with a kasra (إِ).")
                                .font(.body)
                            Text("In the Quran, there are seven nouns that start with hamzatul waSl. These nouns always begin with a kasra when pronounced in isolation.")
                                .font(.body)
                            Text("Hamzatul waSl is usually not written with diacritics, but in learner texts or the Quran, it may be marked with a small ص above the Alif, indicating waSl.")
                                .font(.body)
                        } else if letterData.transliteration.contains("hamza") {
                            Text("The letter Hamza has multiple forms, depending on its position and the surrounding vowels or diacritics (tashkeel):")
                                .font(.body)
                            Text("Hamza on its own (ء): Used when Hamza appears in the middle or end of a word without a preceding vowel.")
                                .font(.body)
                            Text("Hamza on an Alif (أ or إ): When Hamza begins a word, it is written on an Alif. A fatha or damma places it above (أ), while a kasra places it below (إ).")
                                .font(.body)
                            Text("Hamza on a Waw (ؤ): Appears after a damma or following a Waw.")
                                .font(.body)
                            Text("Hamza on a Yaa (ئ): Appears after a kasra or following a Yaa.")
                                .font(.body)
                            Text("Although Hamza takes different forms, it represents the same sound ('ah'). These forms are based on Arabic orthography (spelling conventions) rather than phonetics.")
                                .font(.body)
                        } else if letterData.transliteration.contains("mad") {
                            Text("The wavy line above a vowel letter is called a 'mad'. It elongates the vowel sound, typically lasting 4 counts.")
                                .font(.body)
                            
                            if letterData.transliteration.contains("alif") {
                                Text("If an Alif Mad is followed by a letter with a shaddah, the elongation extends to 6 counts.")
                                    .font(.body)
                            }
                        } else if letterData.transliteration == "alif maqSoorah" {
                            Text("Alif maqSoorah resembles a Yaa without dots and usually replaces a regular Alif at the end of a word. It is used in certain cases, including some Quranic words and non-Arabic proper nouns. It is the exact same and sounds the same as alif.")
                                .font(.body)
                        } else if letterData.transliteration == "laa" {
                            Text("The combination of ل and ا forms a unique shape: لا.")
                                .font(.body)
                        }
                    }
                }
            }
            
            #if !os(watchOS)
            Picker("Arabic Font", selection: $settings.useFontArabic.animation(.easeInOut)) {
                Text("Quranic Font").tag(true)
                Text("Basic Font").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.bottom, 12)
            #endif
        }
        .applyConditionalListStyle(defaultView: true)
        .dismissKeyboardOnScroll()
        .navigationTitle(letterData.letter)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

struct TashkeelRow: View {
    @EnvironmentObject var settings: Settings
    let letterData: LetterData
    let tashkeels: [Tashkeel]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(tashkeels, id: \.english) { tashkeel in
                VStack(alignment: .center) {
                    if !tashkeel.transliteration.isEmpty {
                        Text(letterData.sound + tashkeel.transliteration)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } else if tashkeel.english == "Shaddah" {
                        Text(letterData.sound + letterData.sound)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } else if tashkeel.english == "Sukoon" {
                        Text(letterData.sound)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Text(letterData.letter + tashkeel.tashkeelMark)
                        .font(settings.useFontArabic ? .custom(settings.fontArabic, size: UIFont.preferredFont(forTextStyle: .title1).pointSize) : .title)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, settings.useFontArabic ? 0 : 8)
                    
                    #if !os(watchOS)
                    Text(tashkeel.english)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    #endif
                }
            }
        }
    }
}
