import SwiftUI

struct ICOIEventsView: View {
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var quranData: QuranData
    
    @Environment(\.scenePhase) private var scenePhase

    @State private var selector: String = "Events"
    @State private var activeAlert: ICOIAlertType?
    
    enum ICOIAlertType: Identifiable {
        case eventsFetchError
        case showVisitWebsiteButton
        
        var id: Int {
            switch self {
            case .eventsFetchError:
                return 0
            case .showVisitWebsiteButton:
                return 1
            }
        }
    }
    
    func extractSurahAndAyah(from programLink: String) -> (Surah?, Int?, Int?) {
        let components = programLink.components(separatedBy: " ")

        guard components.count >= 2,
              let surahAyahPart = components.first?.components(separatedBy: ":"),
              let surahIdString = surahAyahPart.first, let surahId = Int(surahIdString),
              let surah = quranData.quran.first(where: { $0.id == surahId }),
              let ayahNumber = surahAyahPart.count > 1 ? Int(surahAyahPart[1]) : nil else {
            return (nil, nil, nil)
        }

        let pageString = components.dropFirst().joined(separator: " ")
        let pageMatches = pageString.matches(for: "\\d+")
        let pageNumber = pageMatches.first.flatMap(Int.init)

        return (surah, ayahNumber, pageNumber)
    }
    
    func programVStack(for program: Program, surah: Surah? = nil, ayahNumber: Int? = nil, pageNumber: Int? = nil) -> some View {
        VStack(alignment: .leading) {
            Text(program.name)
                .font(.headline)
                .foregroundColor(settings.accentColor)
            
            Text("Days: \(program.days)")
                .font(.subheadline)
                .padding(.top, 1)
            Text("Time: \(program.time)")
                .font(.subheadline)
                .padding(.top, 1)
            Text("Location: \(program.location)")
                .font(.subheadline)
                .padding(.top, 1)
            Text("Info: \(program.notes)")
                .font(.subheadline)
                .padding(.top, 1)
            
            if let surah = surah, let ayahNumber = ayahNumber {
                Text("Last read: \(surah.nameTransliteration) \(surah.id):\(ayahNumber)"
                     + (pageNumber != nil ? " (Page \(pageNumber!))" : ""))
                    .font(.subheadline)
                    .foregroundColor(settings.accentColor2)
                    .padding(.top, 1)
            } else {
                #if !os(watchOS)
                if !program.link.isEmpty, let url = URL(string: program.link) {
                    Link("Tap to go to URL", destination: url)
                        .font(.subheadline)
                        .foregroundColor(settings.accentColor2)
                        .padding(.top, 1)
                }
                #endif
            }
        }
        .multilineTextAlignment(.leading)
        #if !os(watchOS)
        .contextMenu {
            if program.link.contains("."), let url = URL(string: program.link) {
                Button(action: {
                    settings.hapticFeedback()
                    
                    UIApplication.shared.open(url)
                }) {
                    Label("Go to Website", systemImage: "safari.fill")
                }
                
                Button(action: {
                    settings.hapticFeedback()
                    
                    UIPasteboard.general.string = program.link
                }) {
                    Label("Copy Link", systemImage: "link")
                }
            }
            
            Button(action: {
                settings.hapticFeedback()
                
                let infoString = """
                Name: \(program.name)
                URL: \(program.link)
                Days: \(program.days)
                Time: \(program.time)
                Location: \(program.location)
                Info: \(program.notes)
                """
                UIPasteboard.general.string = infoString
            }) {
                Label("Copy Information", systemImage: "doc.on.doc")
            }
        }
        #endif
    }
    
    var body: some View {
        NavigationView {
            List {
                Picker("Sort Type", selection: $selector.animation(.easeInOut)) {
                    Text("Events").tag("Events")
                    Text("Programs").tag("Programs")
                }
                #if !os(watchOS)
                .pickerStyle(SegmentedPickerStyle())
                #endif
                
                Link(destination: URL(string: "https://www.icoi.net/weekly-programs/")!) {
                    HStack {
                        Image(systemName: "calendar")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                            .foregroundColor(settings.accentColor)
                            .padding(.trailing, 8)
                        
                        Text("View Weekly Events")
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor2)
                    }
                }
                #if !os(watchOS)
                .contextMenu {
                    Button(action: {
                        settings.hapticFeedback()
                        
                        UIPasteboard.general.string = "https://www.icoi.net/weekly-programs/"
                    }) {
                        Text("Copy Link")
                        Image(systemName: "doc.on.doc")
                    }
                }
                #endif
                
                if let eventsObject = settings.eventsICOI, let programsObject = settings.programsICOI {
                    if selector == "Events" {
                        ForEach(eventsObject.events, id: \.name) { event in
                            if event.name.lowercased() == "no upcoming events" {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(event.name)
                                            .font(.headline)
                                            .foregroundColor(settings.accentColor)
                                            .padding(.bottom, 1)
                                    }
                                    .multilineTextAlignment(.leading)
                                }
                            } else {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(event.name)
                                            .font(.headline)
                                            .foregroundColor(settings.accentColor)
                                            .padding(.bottom, 1)
                                        
                                        Text("\(event.date, style: .date)")
                                            .font(.subheadline)
                                            .padding(.bottom, 1)
                                        Text("\(event.time)")
                                            .font(.subheadline)
                                            .padding(.bottom, 1)
                                        Text("\(event.location)")
                                            .font(.subheadline)
                                        
                                        #if !os(watchOS)
                                        if !event.link.isEmpty, let url = URL(string: event.link) {
                                            Link("Tap to go to URL", destination: url)
                                                .font(.subheadline)
                                                .foregroundColor(settings.accentColor2)
                                                .padding(.top, 1)
                                        }
                                        #endif
                                    }
                                    .multilineTextAlignment(.leading)
                                }
                                #if !os(watchOS)
                                .contextMenu {
                                    if event.link.contains("."), let url = URL(string: event.link) {
                                        Button(action: {
                                            settings.hapticFeedback()
                                            
                                            UIApplication.shared.open(url)
                                        }) {
                                            Label("Go to Website", systemImage: "safari.fill")
                                        }
                                        
                                        Button(action: {
                                            settings.hapticFeedback()
                                            
                                            UIPasteboard.general.string = event.link
                                        }) {
                                            Label("Copy Link", systemImage: "link")
                                        }
                                    }
                                    
                                    Button(action: {
                                        settings.hapticFeedback()
                                        
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateStyle = .long
                                        
                                        let infoString = """
                                        Name: \(event.name)
                                        URL: \(event.link)
                                        Date: \(dateFormatter.string(from: event.date))
                                        Time: \(event.time)
                                        Location: \(event.location)
                                        """
                                        UIPasteboard.general.string = infoString
                                    }) {
                                        Label("Copy Information", systemImage: "doc.on.doc")
                                    }
                                }
                                #endif
                            }
                        }
                    } else if selector == "Programs" {
                        ForEach(programsObject.programs, id: \.name) { program in
                            if program.name == "No upcoming programs" {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(program.name)
                                            .font(.headline)
                                            .foregroundColor(settings.accentColor)
                                            .padding(.bottom, 1)
                                    }
                                    .multilineTextAlignment(.leading)
                                }
                            } else {
                                if program.link.contains(":") {
                                    let (surah, ayahNumber, pageNumber) = extractSurahAndAyah(from: program.link)
                                    if let surah = surah, let ayahNumber = ayahNumber {
                                        NavigationLink(destination: AyahsView(surah: surah, ayah: ayahNumber)) {
                                            programVStack(for: program, surah: surah, ayahNumber: ayahNumber, pageNumber: pageNumber)
                                        }
                                    } else {
                                        programVStack(for: program)
                                    }
                                } else {
                                    programVStack(for: program)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("ICOI Events")
            .navigationBarTitleDisplayMode(.inline)
            #if !os(watchOS)
            .applyConditionalListStyle(defaultView: settings.defaultView)
            #endif
            .refreshable {
                settings.fetchEventsAndPrograms(force: true)
                
                if settings.eventsICOI == nil {
                    activeAlert = .eventsFetchError
                } else if let eventsObject = settings.eventsICOI, let programsObject = settings.programsICOI, eventsObject.events.first?.name.lowercased() == "no upcoming events" && !programsObject.programs.isEmpty {
                    selector = "Programs"
                }
            }
            .onAppear {
                settings.fetchEventsAndPrograms()
                
                if settings.eventsICOI == nil {
                    activeAlert = .eventsFetchError
                } else if let eventsObject = settings.eventsICOI, let programsObject = settings.programsICOI, eventsObject.events.first?.name.lowercased() == "no upcoming events" && !programsObject.programs.isEmpty {
                     selector = "Programs"
                 }
            }
            .onChange(of: scenePhase) { newScenePhase in
                if newScenePhase == .active {
                    settings.fetchEventsAndPrograms()
                    
                    if settings.eventsICOI == nil {
                        activeAlert = .eventsFetchError
                    } else if let eventsObject = settings.eventsICOI, let programsObject = settings.programsICOI, eventsObject.events.first?.name.lowercased() == "no upcoming events" && !programsObject.programs.isEmpty {
                        selector = "Programs"
                    }
                }
            }
            .confirmationDialog(
                Text("Unable to retrieve ICOI events from icoi.net"),
                isPresented: Binding<Bool>(
                    get: { activeAlert != nil },
                    set: { if !$0 { activeAlert = nil } }
                ),
                presenting: activeAlert,
                actions: { alertType in
                    switch alertType {
                    case .eventsFetchError:
                        Button("OK", role: .none) { }
                        Button("Try Again", role: .destructive) {
                            settings.fetchEventsAndPrograms()

                            if settings.eventsICOI == nil {
                                activeAlert = .showVisitWebsiteButton
                            }
                        }

                    case .showVisitWebsiteButton:
                        #if !os(watchOS)
                        Button("OK", role: .none) { }
                        Button("Visit icoi.net", role: .destructive) {
                            if let url = URL(string: "https://www.icoi.net/") {
                                UIApplication.shared.open(url)
                            }
                        }
                        #else
                        Button("OK", role: .none) { }
                        Button("Try Again", role: .destructive) {
                            settings.fetchEventsAndPrograms()
                        }
                        #endif
                    }
                },
                message: { alertType in
                    Text("Please check your internet connection. The website may be temporarily unavailable.")
                }
            )
        }
        .navigationViewStyle(.stack)
    }
}

extension String {
    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("Invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
