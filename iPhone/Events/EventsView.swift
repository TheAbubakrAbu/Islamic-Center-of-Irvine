import SwiftUI

struct ICOIEventsView: View {
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var quranData: QuranData
    
    @Environment(\.scenePhase) private var scenePhase

    @State private var activeAlert: ICOIAlertType?
    @State private var selectedDay: String = "All"
    
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
    
    let days = ["All", "Daily", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var filteredEvents: [Event] {
        guard let eventsObject = settings.eventsICOI else { return [] }
        if selectedDay == "All" {
            return eventsObject.events
        }
        return eventsObject.events
            .filter { $0.dayOfWeek.prefix(3).uppercased() == selectedDay.prefix(3).uppercased() }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("\(selectedDay) Events")) {
                        #if os(watchOS)
                        Picker("Selected Days", selection: $selectedDay) {
                            ForEach(days, id: \.self) { day in
                                Text(day).tag(day)
                            }
                        }
                        #endif
                        
                        ForEach(filteredEvents, id: \.name) { event in
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
                                    VStack(alignment: .leading, spacing: 4) {
                                        if !event.name.isEmpty {
                                            Text(event.name)
                                                .font(.headline)
                                                .foregroundColor(settings.accentColor)
                                        }
                                        
                                        Text("\(event.date, style: .date)")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                        
                                        if !event.time.isEmpty {
                                            Text(event.time)
                                                .font(.subheadline)
                                        }
                                        
                                        if !event.location.isEmpty {
                                            Text(event.location)
                                                .font(.subheadline)
                                        }
                                        
                                        #if !os(watchOS)
                                        if !event.link.isEmpty, let url = URL(string: event.link) {
                                            Link("Tap to go to URL", destination: url)
                                                .font(.subheadline)
                                                .foregroundColor(settings.accentColor2)
                                                .padding(.top, 2)
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
                    }
                }
                
                #if !os(watchOS)
                DaySelectionView(days: days, selectedDay: $selectedDay)
                
                Link(destination: URL(string: "https://www.icoi.net/weekly-programs/")!) {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "calendar")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                            .padding(.trailing, 8)
                        
                        Text("View Weekly Events")
                            .font(.subheadline)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .background(settings.accentColor)
                    .foregroundColor(.primary)
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 4)
                }
                .contextMenu {
                    Button(action: {
                        settings.hapticFeedback()
                        UIPasteboard.general.string = "https://www.icoi.net/weekly-programs/"
                    }) {
                        Text("Copy Link")
                        Image(systemName: "doc.on.doc")
                    }
                }
                .padding(.bottom, 4)
                #endif
            }
            .navigationTitle("ICOI Events")
            .navigationBarTitleDisplayMode(.inline)
            .refreshable {
                settings.fetchEvents(force: true)
                if settings.eventsICOI == nil {
                    activeAlert = .eventsFetchError
                }
            }
            .onAppear {
                settings.fetchEvents()
                if settings.eventsICOI == nil {
                    activeAlert = .eventsFetchError
                }
            }
            .onChange(of: scenePhase) { newScenePhase in
                if newScenePhase == .active {
                    settings.fetchEvents()
                    if settings.eventsICOI == nil {
                        activeAlert = .eventsFetchError
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
                            settings.fetchEvents()
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
                            settings.fetchEvents()
                        }
                        #endif
                    }
                },
                message: { _ in
                    Text("Please check your internet connection. The website may be temporarily unavailable.")
                }
            )
        }
        .navigationViewStyle(.stack)
    }
}

struct DaySelectionView: View {
    @EnvironmentObject var settings: Settings
    
    let days: [String]
    @Binding var selectedDay: String
    
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(days, id: \.self) { day in
                Button(action: {
                    settings.hapticFeedback()
                    
                    withAnimation {
                        selectedDay = day
                    }
                }) {
                    Text(day == "Daily" ? day : String(day.prefix(3)))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(selectedDay == day ? Color.accentColor : Color.gray.opacity(0.2))
                        .foregroundColor(selectedDay == day ? Color.white : Color.primary)
                        .cornerRadius(10)
                        .minimumScaleFactor(0.5)
                }
            }
        }
        .padding(.horizontal)
    }
}
