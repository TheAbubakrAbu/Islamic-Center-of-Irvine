import SwiftUI

struct createButtonForURL: View {
    @EnvironmentObject var settings: Settings
    
    var url: String
    var title: String
    var image: String

    var body: some View {
        Button(action: {
            if let url = URL(string: url) {
                settings.hapticFeedback()
                
                DispatchQueue.main.async {
                    UIApplication.shared.open(url)
                }
            }
        }) {
            HStack {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                    .foregroundColor(settings.accentColor2)
                    .padding(.trailing, 10)
                
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(settings.accentColor2)
            }
        }
    }
}

