import SwiftUI

struct CreateLinkForURL: View {
    @EnvironmentObject var settings: Settings

    var url: String
    var title: String
    var image: String

    var body: some View {
        if let destination = URL(string: url) {
            Link(destination: destination) {
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
}
