import SwiftUI

//	SwiftUI : Fun {
//		http://github.com/swiftuifun
//		http://twitter.com/swiftuifun
//		http://instagram.com/swiftuifun/
//	}

@main
struct StickyButtonsApp: App {
    var body: some Scene {
        WindowGroup {
			LoginView()
		}.windowStyle(HiddenTitleBarWindowStyle())
    }
}
