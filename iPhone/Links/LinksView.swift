import SwiftUI

struct ICOILinksView: View {
    @EnvironmentObject var settings: Settings
    
    @Environment(\.scenePhase) private var scenePhase

    @State private var activeAlert: ICOIAlertType?
    
    enum ICOIAlertType: Identifiable {
        case businessFetchError
        case showVisitWebsiteButton
        
        var id: Int {
            switch self {
            case .businessFetchError:
                return 0
            case .showVisitWebsiteButton:
                return 1
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                #if !os(watchOS)
                Section(header: Text("ICOI LINKS")) {
                    Button(action: {
                        if let url = URL(string: "https://www.icoi.net/") {
                            settings.hapticFeedback()
                            
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack {
                            Image("ICOI2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(settings.accentColor2)
                                .padding(.leading, -2)
                                .padding(.trailing, 2)
                            
                            Text("icoi.net")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor2)
                        }
                    }
                    .contextMenu {
                        Button(action: {
                            settings.hapticFeedback()
                            
                            UIPasteboard.general.string = "https://www.icoi.net/"
                        }) {
                            Text("Copy Link")
                            Image(systemName: "link")
                        }
                    }
                    
                    Link(destination: URL(string: "http://maps.apple.com/?address=2+Truman,Irvine,CA+92620")!) {
                        HStack {
                            Image(systemName: "location.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                                .foregroundColor(settings.accentColor)
                                .padding(.trailing, 8)
                            
                            Text("2 Truman, Irvine, CA 92620")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor2)
                        }
                    }
                    .contextMenu {
                        Button(action: {
                            settings.hapticFeedback()
                            
                            UIPasteboard.general.string = "2 Truman, Irvine, CA 92620"
                        }) {
                            Text("Copy Address")
                            Image(systemName: "doc.on.doc")
                        }
                    }
                    
                    Link(destination: URL(string: "https://www.icoi.net/fundraising-ramadan-2025/")!) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                                .foregroundColor(settings.accentColor)
                                .padding(.trailing, 8)
                            
                            Text("Give Now. Power Your Masjid.")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor2)
                        }
                    }
                    .contextMenu {
                        Button(action: {
                            settings.hapticFeedback()
                            
                            UIPasteboard.general.string = "https://www.icoi.net/fundraising-ramadan-2025/"
                        }) {
                            Text("Copy Link")
                            Image(systemName: "doc.on.doc")
                        }
                    }
                    
                    Link(destination: URL(string: "https://www.icoi.net/donate/")!) {
                        HStack {
                            Image(systemName: "gift.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                                .foregroundColor(settings.accentColor)
                                .padding(.trailing, 8)
                            
                            Text("Give Zakat/Sadaqah")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor2)
                        }
                    }
                    .contextMenu {
                        Button(action: {
                            settings.hapticFeedback()
                            
                            UIPasteboard.general.string = "https://www.icoi.net/donate/"
                        }) {
                            Text("Copy Link")
                            Image(systemName: "doc.on.doc")
                        }
                    }
                }
                
                Section(header: Text("THE VILLAGE IN IRVINE")) {
                    Link(destination: URL(string: "https://www.thevillageinirvine.com/")!) {
                        HStack {
                            Image(systemName: "house.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                                .foregroundColor(settings.accentColor)
                                .padding(.trailing, 8)
                            
                            Text("Visit the Village")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor2)
                        }
                    }
                    .contextMenu {
                        Button(action: {
                            settings.hapticFeedback()
                            
                            UIPasteboard.general.string = "https://www.thevillageinirvine.com/"
                        }) {
                            Text("Copy Link")
                            Image(systemName: "doc.on.doc")
                        }
                    }
                    
                    Link(destination: URL(string: "https://maps.apple.com/?address=5530%20Trabuco%20Rd,%20Irvine,%20CA%20%2092620,%20United%20States&ll=33.697056,-117.765272&q=5530%20Trabuco%20Rd")!) {
                        HStack {
                            Image(systemName: "location.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                                .foregroundColor(settings.accentColor)
                                .padding(.trailing, 8)
                            
                            Text("5530 Trabuco, Irvine, CA 92620")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor2)
                        }
                    }
                    .contextMenu {
                        Button(action: {
                            settings.hapticFeedback()
                            
                            UIPasteboard.general.string = "5530 Trabuco, Irvine, CA 92620"
                        }) {
                            Text("Copy Address")
                            Image(systemName: "doc.on.doc")
                        }
                    }
                }
                    
                Section(header: Text("MORE")) {
                    Button(action: {
                        if let url = URL(string: "tel://949786ICOI") {
                            settings.hapticFeedback()
                            
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack {
                            Image(systemName: "phone.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                                .foregroundColor(settings.accentColor)
                                .padding(.trailing, 10)
                            
                            Text("Call (949) 786-ICOI")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor)
                        }
                    }
                    .contextMenu {
                        Button(action: {
                            settings.hapticFeedback()
                            
                            UIPasteboard.general.string = "(949) 786-ICOI"
                        }) {
                            Text("Copy Phone Number")
                            Image(systemName: "doc.on.doc")
                        }
                    }

                    Button(action: {
                        if let urlString = "mailto:office@icoi.net".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
                            settings.hapticFeedback()
                            
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                                .foregroundColor(settings.accentColor)
                                .padding(.trailing, 10)
                            
                            Text("Email office@icoi.net")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor)
                        }
                    }
                    .contextMenu {
                        Button(action: {
                            settings.hapticFeedback()
                            
                            UIPasteboard.general.string = "office@icoi.net"
                        }) {
                            Text("Copy Email Address")
                            Image(systemName: "doc.on.doc")
                        }
                    }
                    
                    Button(action: {
                        if let url = URL(string: "https://calendar.google.com/calendar/u/0/appointments/schedules/AcZssZ24WefX2potVuR2-7MKuzHd-_eNrUUS_J89-sZFLTBBs-0C2zMD1GvlIAfJgHJ5-iWkySpxLQWE") {
                            settings.hapticFeedback()
                            
                            DispatchQueue.main.async {
                                UIApplication.shared.open(url)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                                .foregroundColor(settings.accentColor2)
                                .padding(.trailing, 10)
                            
                            Text("Schedule Appointment with Sheikh Tarik Ata")
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor2)
                            
                            Spacer()
                            
                            Image("Tarik")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                                .foregroundColor(settings.accentColor2)
                        }
                    }
                    .contextMenu {
                        Button(action: {
                            settings.hapticFeedback()
                            
                            UIPasteboard.general.string = "https://calendar.google.com/calendar/u/0/appointments/schedules/AcZssZ24WefX2potVuR2-7MKuzHd-_eNrUUS_J89-sZFLTBBs-0C2zMD1GvlIAfJgHJ5-iWkySpxLQWE"
                        }) {
                            Text("Copy Link")
                            Image(systemName: "doc.on.doc")
                        }
                    }
                    
                    createButtonForURL(url: "https://open.spotify.com/show/21boeFrl1YETpYbclnDSYf?si=5d069a3507c54d22", title: "Follow the ICOI Podcast on Spotify", image: "waveform.and.mic")
                    
                    createButtonForURL(url: "https://www.icoi.net/subscribe-to-icoi-newsletter-2/", title: "Subscribe to ICOI's Newsletter", image: "newspaper.fill")
                    
                    createButtonForURL(url: "https://www.icoi.net/membership/", title: "Become an ICOI Member", image: "person.fill")
                    
                    createButtonForURL(url: "https://docs.google.com/forms/d/e/1FAIpQLSfDJHdUW27bg0tc1DrBCcZz8VGSinIqhWNy5woiw5ccfxbooQ/viewform", title: "Become an ICOI Volunteer", image: "person.2.fill")
                }
                #endif
                
                ICOIBusinessView()
            }
            .navigationTitle("ICOI Links")
            .applyConditionalListStyle(defaultView: true)
            .refreshable {
                settings.fetchBusinesses(force: true) {
                    if settings.businessesICOI == nil {
                        activeAlert = .businessFetchError
                    }
                }
            }
            .onAppear {
                settings.fetchBusinesses() {
                    if settings.businessesICOI == nil {
                        activeAlert = .businessFetchError
                    }
                }
            }
            .onChange(of: scenePhase) { _ in
                settings.fetchBusinesses() {
                    if settings.businessesICOI == nil {
                        activeAlert = .businessFetchError
                    }
                }
            }
            .confirmationDialog(
                Text("Unable to retrieve local businesses from icoi.net"),
                
                isPresented: Binding<Bool>(
                    get: { activeAlert != nil },
                    set: { if !$0 { activeAlert = nil } }
                ),
                
                presenting: activeAlert,
                
                actions: { alertType in
                    switch alertType {
                    case .businessFetchError:
                        Button("Try Again", role: .destructive) {
                            settings.fetchBusinesses {
                                if settings.businessesICOI == nil {
                                    activeAlert = .showVisitWebsiteButton
                                }
                            }
                        }
                        
                        Button("OK", role: .cancel) { }
                        
                    case .showVisitWebsiteButton:
                        #if !os(watchOS)
                        Button("Visit icoi.net", role: .destructive) {
                            if let url = URL(string: "https://www.icoi.net/") {
                                UIApplication.shared.open(url)
                            }
                        }
                        #else
                        Button("Try Again", role: .destructive) { settings.fetchBusinesses() }
                        #endif
                        
                        Button("OK", role: .cancel) { }
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
