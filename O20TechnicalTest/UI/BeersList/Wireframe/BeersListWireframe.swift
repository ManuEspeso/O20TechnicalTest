
import UIKit

protocol BeersListWireframe {
    func navigateToBeerDetail(_ beerSelected: Beers)
}

class BeersListWireframeDefault: BeersListWireframe {
    
    weak var sourceView: UIViewController?
 
    func navigateToBeerDetail(_ beerSelected: Beers) {
        let beerDetail = container.getBeerDetailViewController()
        beerDetail.beerSelected = beerSelected
        
        sourceView?.navigationController?.pushViewController(beerDetail, animated: true)
    }
}
