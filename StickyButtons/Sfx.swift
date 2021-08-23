import Foundation
import AVFoundation

//	SwiftUI : Fun {
//		http://github.com/swiftuifun
//		http://twitter.com/swiftuifun
//		http://instagram.com/swiftuifun/
//	}

enum sfxName : String {
	case drag = "Tink.m4a"
	case spring = "Pop.aiff"
	case click = "Blow.m4a"
}

class Sfx: NSObject, ObservableObject, AVAudioPlayerDelegate {
	
	private var player: AVAudioPlayer?
	private var queue: [AVAudioPlayer] = []
	
	func play(_ name: sfxName) {
		guard let url = Bundle.main.url(forResource: name.rawValue.components(separatedBy: ".")[0],withExtension: name.rawValue.components(separatedBy: ".")[1]) else { return }
		player = try! AVAudioPlayer(contentsOf: url)
		player?.delegate = self
		player?.play()
		queue.append(player!)
	}
	
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
		queue = queue.filter {$0 != player}
	}

}
