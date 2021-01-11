
import UIKit

class BeerDetailViewController: UIViewController {
    
    var presenter: BeerDetailPresenter?
    var beerSelected: Beers?
    private var beerDetailView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        guard let imageData = presenter?.getInternetImage(from: beerSelected?.image),
            let beerImage = UIImage(data: imageData),
            let beerSelected = beerSelected else { return }
        
        beerDetailView = BeerDetailView(beerImage: beerImage,
                                        beerDescription: beerSelected.description,
                                        beerMalt: beerSelected.malt,
                                        beerHops: beerSelected.hops)
        view = beerDetailView
    }
}
