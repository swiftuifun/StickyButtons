import SwiftUI

//	SwiftUI : Fun {
//		http://github.com/swiftuifun
//		http://twitter.com/swiftuifun
//		http://instagram.com/swiftuifun/
//	}

struct LoginView: View {
	@State var activeItem: UUID = UUID.init()
	var size: CGSize = CGSize(width: 120, height: 120)
	var items: Array = ["Cactus", "Eagle", "Lotus"]
	
	var body: some View {
		ZStack {
			Image("Wallpaper")
				.resizable()
				.scaledToFill()
			VStack {
				HStack (spacing: 80) {
					ForEach(items, id: \.self) {item in
						StickyButtonView(image: item, size: size, activeItem: $activeItem)
					}
				}.padding(.bottom, 60)
			}
		}.frame(minWidth: 700, minHeight: 400)
		.ignoresSafeArea(.all)
	}
}
