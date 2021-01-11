
import UIKit
import SnapKit

protocol BeersTableViewDelegate: class {
    func searchBeers(with food: String)
    func requestMoreBeers()
    func didSelectedRow(beerSelected: Beers)
}

class BeersTableView: UIView {
    
    weak var delegate: BeersTableViewDelegate?
    
    private var shouldPaginate: Bool = true
    private var beers: [Beers] = []
    private var beersTableView = UITableView()
    private var resultSearch: UISearchController?
    private let spinner = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayReloadBeers(beers: [Beers]) {
        self.beers.removeAll()
        displayBeers(beers: beers)
    }
    
    func displayBeers(beers: [Beers]) {
        shouldPaginate = true
        beersTableView.tableFooterView = nil
        
        loadNewBeers(beers)
        beersTableView.reloadData()
    }
    
    func displayFilterBeers(beers: [Beers]) {
        shouldPaginate = false
        beersTableView.tableFooterView = nil
        
        loadNewBeers(beers)
        beersTableView.reloadData()
    }
    
    func stopFooterSpinner() {
        shouldPaginate = false
    }
}

// MARK: - TableView

extension BeersTableView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if beers.count > 0 {
            tableView.clearAnimation()
            return beers.count
        } else {
            tableView.showAnimation()
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "beersCell")
        cell.selectionStyle = .none
        
        let beersName = beers[indexPath.row].name
        let beersDate = beers[indexPath.row].firstBrewed
        
        cell.textLabel?.attributedText = attributedText(withString: "\("beersList_cellTitle".toLocalized())\(beersName)",
                                                        boldString: "beersList_cellTitle".toLocalized(),
                                                        font: cell.detailTextLabel?.font ?? UIFont.boldSystemFont(ofSize: 0.0))
        cell.detailTextLabel?.attributedText = attributedText(withString: "\("beersList_cellSubtitle".toLocalized())\(beersDate)",
                                                              boldString: "beersList_cellSubtitle".toLocalized(),
                                                              font: cell.detailTextLabel?.font ?? UIFont.boldSystemFont(ofSize: 0.0))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = delegate else { return }
        delegate.didSelectedRow(beerSelected: beers[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if beersTableView.contentOffset.y >= (beersTableView.contentSize.height - beersTableView.frame.size.height) && shouldPaginate {
            beersTableView.tableFooterView = createSpinnerFooter()
            delegate?.requestMoreBeers()
        } else {
            beersTableView.tableFooterView = nil
        }
    }
}

// MARK: - SearchDelegate

extension BeersTableView: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBeerText = searchController.searchBar.text else { return }
        
        if searchBeerText.count != 0 {
            delegate?.searchBeers(with: searchBeerText)
        }
    }
}

// MARK: - Private

extension BeersTableView {
    
    private func setupUI() {
        beersTableView.delegate = self
        beersTableView.dataSource = self
        
        resultSearch = {
            let controller = UISearchController(searchResultsController: nil)
            
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "beersList_searchPlaceholder".toLocalized()
            beersTableView.tableHeaderView = controller.searchBar
            
            return controller
        }()
    }
    
    private func setupConstraints() {
        addSubview(beersTableView)
        
        beersTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
    
    private func loadNewBeers(_ beers: [Beers]) {
        self.beers.removeAll()
        self.beers.append(contentsOf: beers)
    }
    
    private func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 80))
        
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
}
