import SwiftUI

//	SwiftUI : Fun {
//		http://github.com/swiftuifun
//		http://twitter.com/swiftuifun
//		http://instagram.com/swiftuifun/
//	}

struct ImageView: View {
	@Binding var active: Bool
	var image: String
	var size: CGSize
	@State private var randomvalue: Double = 0
	
	var body: some View {
		ZStack {
			Image(image)
				.resizable()
				.scaledToFill()
				.frame(width: size.width, height: size.height)
				.scaleEffect(active ? CGFloat(randomvalue/20)+1 : 1)
				.clipShape(Circle())
				.saturation(active ? Double.random(in: 1...2) : 1)
				.contrast(active ? Double.random(in: 1...2) : 1)
				.shadow(color: .black.opacity(active ? 0.15 : 0.25), radius: active ? 40 : 20, x: 0, y: active ? 80 : 40)
		}
		.onAppear {
			waitForAnimation()
		}
	}
	func waitForAnimation () {
		
		doWhen(active) {
			doWhile(active) {
				randomvalue = Double.random(in: 0...1)
				doWhen(!active) {
					randomvalue = 0
					waitForAnimation()
				}
			}
		}
	}
}
