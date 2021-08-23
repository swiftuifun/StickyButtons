import SwiftUI

//	SwiftUI : Fun {
//		http://github.com/swiftuifun
//		http://twitter.com/swiftuifun
//		http://instagram.com/swiftuifun/
//	}

func doAfter(delay: Double,
			 _ action: @escaping ()->Void) {
	
	Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { timer in
		action()
	}
	
}

func doWhen(_ condition: @autoclosure @escaping ()->Bool,
			_ action: @escaping ()->Void) {
	
	Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
		if condition() {
			timer.invalidate()
			action()
		}
	}
	
}

func doWhile(_ condition: @autoclosure @escaping ()->Bool,
			 interval: Double? = 0.1,
			 _ action: @escaping ()->Void, completion: (()->Void)? = {}) {
	
	Timer.scheduledTimer(withTimeInterval: interval!, repeats: true) { timer in
		if condition() {
			action()
		} else {
			timer.invalidate()
			completion!()
		}
	}
	
}
