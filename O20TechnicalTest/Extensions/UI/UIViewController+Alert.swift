
import UIKit

extension UIViewController {
    typealias OnTap = () -> ()
    
    func alert(message: String, title: String = "", completion: OnTap?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "tryAgain_alertActionTitle".toLocalized(), style: .default, handler: { action in
            completion?()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
