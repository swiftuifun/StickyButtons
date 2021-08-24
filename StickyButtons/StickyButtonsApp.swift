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
				.onReceive(NotificationCenter.default.publisher(for: NSApplication.willUpdateNotification)) { _ in
					for window in NSApplication.shared.windows {
						window.standardWindowButton(NSWindow.ButtonType.zoomButton)!.isHidden = true
						window.standardWindowButton(NSWindow.ButtonType.closeButton)!.isHidden = true
						window.standardWindowButton(NSWindow.ButtonType.miniaturizeButton)!.isHidden = true
					}
				}
		}.windowStyle(HiddenTitleBarWindowStyle())
		
	}
}
