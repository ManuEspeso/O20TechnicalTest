
import UIKit
import Lottie

fileprivate let animationView = AnimationView(name: "not-found")

extension UITableView {
    
    func showAnimation() {
        animationView.frame = .zero
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        
        self.backgroundView = animationView;
        self.separatorStyle = .none;
    }
    
    func clearAnimation() {
        separatorStyle = .singleLine
        animationView.stop()
        self.backgroundView = nil
    }
}
