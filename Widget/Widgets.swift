import WidgetKit
import SwiftUI

@main
struct Widgets: WidgetBundle {
    var body: some Widget {
        CountdownWidget()
        CountdownAdhanWidget()
        CountdownIqamahWidget()
        #if os(iOS)
        if #available(iOS 16.1, *) {
            LockScreen1Widget()
            LockScreen1AdhanWidget()
            LockScreen1IqamahWidget()
            
            LockScreen2Widget()
            LockScreen2AdhanWidget()
            LockScreen2IqamahWidget()
        }
        #endif
    }
}
