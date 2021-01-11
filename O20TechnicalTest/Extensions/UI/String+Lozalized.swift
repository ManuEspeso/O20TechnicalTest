
import Foundation

extension String {
    
    func toLocalized() -> String {
        return NSLocalizedString(self,
                                 comment:"")
    }
}
