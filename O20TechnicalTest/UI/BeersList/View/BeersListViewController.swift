
import UIKit

protocol BeersListView: class {
    func showBeers(beers: [Beers])
    func showFilterBeers(beers: [Beers])
    func removeFooterSpinner()
    func showError(message: String)
}

class BeersListViewController: UIViewController {
    
    var presenter: BeersListPresenter?
    private let beersTableView = BeersTableView()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        presenter?.loadBeers()
    }
    
    private func setupUI() {
        title = "beersList_title".toLocalized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(reloadBeers))
        beersTableView.delegate = self
        view = beersTableView
    }
    
    @objc private func reloadBeers() {
        guard let beers = presenter?.reloadBeers() else { return }
        beersTableView.displayReloadBeers(beers: beers)
    }
}

// MARK: - Delegate

extension BeersListViewController: BeersListView {
    
    func showBeers(beers: [Beers]) {
        beersTableView.displayBeers(beers: beers)
    }
    
    func showFilterBeers(beers: [Beers]) {
        beersTableView.displayFilterBeers(beers: beers)
    }
    
    func removeFooterSpinner() {
        beersTableView.stopFooterSpinner()
    }
    
    func showError(message: String) {
        self.alert(message: message, title: "alertTitle_somethingWrong".toLocalized(), completion: nil)
    }
}

// MARK: - TableView Delegate

extension BeersListViewController: BeersTableViewDelegate {
    
    func searchBeers(with food: String) {
        presenter?.filterBeers(by: food)
    }
    
    func requestMoreBeers() {
        presenter?.loadBeers()
    }
    
    func didSelectedRow(beerSelected: Beers) {
        presenter?.navigateToDetailBeer(beerSelected)
    }
}
