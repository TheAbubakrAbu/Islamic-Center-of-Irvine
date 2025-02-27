import SwiftUI

struct DismissKeyboardOnScrollModifier: ViewModifier {
    func body(content: Content) -> some View {
        #if !os(watchOS)
        Group {
            if #available(iOS 16.0, *) {
                content
                    .scrollDismissesKeyboard(.immediately)
            } else {
                content
                    .gesture(
                        DragGesture().onChanged { _ in
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    )
            }
        }
        #else
        Group {
            content
        }
        #endif
    }
}
