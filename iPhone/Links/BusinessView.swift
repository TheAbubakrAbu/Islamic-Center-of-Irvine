import SwiftUI

struct ICOIBusinessView: View {
    @EnvironmentObject var settings: Settings
    
    func formatBusinessInfo(business: Business) -> (String?, String?, String) {
        let rawNumber = business.phoneNumber.replacingOccurrences(of: "-", with: "")
        let businessName: String? = business.name.split(separator: "-").first.map { String($0).trimmingCharacters(in: .whitespaces) }
        var formattedNumber: String?

        if rawNumber.count == 10 {
            let startIndex = rawNumber.startIndex
            let areaCodeEnd = rawNumber.index(startIndex, offsetBy: 3)
            let middleEnd = rawNumber.index(areaCodeEnd, offsetBy: 3)

            let areaCode = rawNumber[startIndex..<areaCodeEnd]
            let middle = rawNumber[areaCodeEnd..<middleEnd]
            let lastFour = rawNumber[middleEnd...]

            formattedNumber = "(\(areaCode)) \(middle)-\(lastFour)"
        } else {
            formattedNumber = business.phoneNumber
        }

        return (businessName, formattedNumber, rawNumber)
    }
    
    var body: some View {
        Section(header: Text("ICOI LOCAL BUSINESSES")) {
            if let businessesObject = settings.businessesICOI {
                ForEach(businessesObject.businesses, id: \.name) { business in
                    let (businessName, formattedNumber, rawNumber) = formatBusinessInfo(business: business)
                    VStack(alignment: .leading) {
                        HStack {
                            if let businessName = businessName {
                                Text(businessName)
                                    .font(.headline)
                            }
                            
                            Spacer()
                            
                            if let formattedNumber = formattedNumber {
                                Text(formattedNumber)
                                    .font(.subheadline)
                                    .foregroundColor(settings.accentColor)
                            } else {
                                Text(business.phoneNumber)
                                    .font(.subheadline)
                                    .foregroundColor(settings.accentColor)
                            }
                        }
                        
                        if !business.website.isEmpty {
                            let formattedWebsite = business.website.hasPrefix("http") ? business.website : "http://" + business.website
                            #if !os(watchOS)
                            if let websiteURL = URL(string: formattedWebsite), UIApplication.shared.canOpenURL(websiteURL) {
                                Link(formattedWebsite, destination: websiteURL)
                                    .font(.subheadline)
                                    .foregroundColor(settings.accentColor2)
                            }
                            #else
                            Text(formattedWebsite)
                                .font(.subheadline)
                                .foregroundColor(settings.accentColor2)
                            #endif
                        }
                    }
                    #if !os(watchOS)
                    .contextMenu {
                        if let businessName = businessName {
                            Button(action: {
                                settings.hapticFeedback()
                                
                                UIPasteboard.general.string = businessName
                            }) {
                                HStack {
                                    Image(systemName: "person.3.fill")
                                    Text("Copy Name")
                                }
                            }
                        }
                        
                        if let formattedNumber = formattedNumber, !rawNumber.isEmpty {
                            Button(action: {
                                settings.hapticFeedback()
                                
                                UIPasteboard.general.string = formattedNumber
                            }) {
                                HStack {
                                    Image(systemName: "phone.fill")
                                    Text("Copy Phone Number")
                                }
                            }
                            
                            Button(action: {
                                if let url = URL(string: "tel:\(rawNumber)") {
                                    settings.hapticFeedback()
                                    
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                HStack {
                                    Image(systemName: "phone.arrow.up.right.fill")
                                    Text("Call Number")
                                }
                            }
                        }
                        
                        if !business.website.isEmpty {
                            if let websiteURL = URL(string: business.website), UIApplication.shared.canOpenURL(websiteURL) {
                                Button(action: {
                                    settings.hapticFeedback()
                                    
                                    UIApplication.shared.open(websiteURL)
                                }) {
                                    HStack {
                                        Label("Go to Website", systemImage: "safari.fill")
                                    }
                                }
                            }
                            
                            Button(action: {
                                settings.hapticFeedback()
                                
                                UIPasteboard.general.string = business.website
                            }) {
                                HStack {
                                    Image(systemName: "link")
                                    Text("Copy Link")
                                }
                            }
                        }
                    }
                    #endif
                }
            }
            
            #if !os(watchOS)
            createButtonForURL(url: "https://docs.google.com/forms/d/e/1FAIpQLSdSbCZt5uebhgGBiwGjhQHNVHmm9FxVAR0dX3AUO8GMMLu8OA/viewform", title: "Add your Local Business", image: "plus.square.fill.on.square.fill")
            
            createButtonForURL(url: "https://www.icoi.net/business-directory/", title: "View Business Directory", image: "list.bullet.rectangle.fill")
            #endif
        }
    }
}
