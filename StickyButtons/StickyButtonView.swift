import SwiftUI

//	SwiftUI : Fun {
//		http://github.com/swiftuifun
//		http://twitter.com/swiftuifun
//		http://instagram.com/swiftuifun/
//	}

struct StickyButtonView: View, Identifiable {
	var id = UUID()
	let image: String
	let size: CGSize
	@Binding var activeItem: UUID
	
	@State var position: CGPoint = .zero
	@State var homeposition: CGPoint?
	var ratio = 6
	
	var draganimation: Animation = Animation.spring(response: 0.1, dampingFraction: 0.3, blendDuration: 0)
	var dropanimation: Animation = Animation.spring(response: 0.1, dampingFraction: 0.2, blendDuration: 0)
	
	@State private var shiftx: Int = 0
	@State private var shifty: Int = 0
	@State private var deg: Double = 0
	@State private var tiltx: CGFloat = 0
	@State private var tilty: CGFloat = 0
	@State private var scale: CGFloat = 1
	
	@State private var dragging = false
	@State private var sound = true
	
	@ObservedObject var sfx = Sfx()
	
	var body: some View {
		HStack {
			ZStack {
				EmptyView().trackingMouse { value in
					if dragging {
						dragItem(value: value)
					} else {
						dropItem()
					}
				}
				
				ImageView(active: $dragging, image: image, size: CGSize(width: size.width, height: size.height))
					.onAppear {
						homeposition = CGPoint(x: size.width/2, y: size.height/2)
						position = homeposition!
						dropItem()
					}
					.onChange(of: activeItem) { value in
						if dragging {
							if value != self.id {
								dropItem()
								dragging = false
								dropItem()
							}
						}
					}
					.onTapGesture {
						if dragging {
							// states
							dragging = false
							sound = false
							selectItem()
							// sfx
							sfx.play(.click)
							doAfter(delay: 1) {sound = true}
						}
					}
					.onHover {value in
						dragging = value
						
						//sound effects
						if dragging {
							activeItem = self.id
							sfx.play(.drag)
							
							sound = false
							doAfter(delay: 0.2) {sound = true}
						} else if sound {
							if activeItem == id {
								sfx.play(.spring)
							}
						}
					}
					.position(position)
					.scaleEffect(scale)
					.rotation3DEffect(Angle(degrees: deg), axis: (x: tiltx, y:tilty, z:0))
				
			}
			.frame(width: size.width, height: size.height)
		}.zIndex(dragging ? 1 : 0)
	}
	
	func dragItem(value: CGPoint) {
		
		var x = Int(value.x)
		var y = Int(value.y)
		
		shiftx = Int(homeposition!.x - position.x)/ratio
		x = x + shiftx
		shifty = Int(homeposition!.y - position.y)/ratio
		y = y + shifty
		
		deg = Double( max(abs(shiftx), abs(shifty)) )/3
		tiltx = CGFloat(shifty)*0.5
		tilty = CGFloat(-shiftx)*0.5
		
		scale = 1.2 + CGFloat( max(abs(shiftx), abs(shifty)) )/100
		
		withAnimation(draganimation) { position = CGPoint(x:x, y: y)}
	}
	
	func dropItem() {
		withAnimation(dropanimation) {
			position = homeposition!
			tiltx = 0
			tilty = 0
			deg = 0
			scale = 1
		}
	}
	
	func selectItem() {
		withAnimation(.easeInOut) {
			position = homeposition!
			tiltx = 0
			tilty = 0
			deg = 0
			scale = 1
		}
	}
}
