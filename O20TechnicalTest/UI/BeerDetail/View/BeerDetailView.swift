
import UIKit

class BeerDetailView: UIView {
    
    private let beerImage: UIImage
    private let beerDescription: String
    private let beerMalt: [String]
    private let beerHops: [String]
    
    private let beerImageView: UIImageView = UIImageView()
    private let beerDescriptionLabel: UILabel = UILabel()
    private let beerTableView = UITableView()
    
    required init(beerImage: UIImage, beerDescription: String, beerMalt: [String], beerHops: [String]) {
        self.beerImage = beerImage
        self.beerDescription = beerDescription
        self.beerMalt = beerMalt
        self.beerHops = beerHops
        
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TableView

extension BeerDetailView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        max(beerMalt.count, beerHops.count)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "tableView_headerTitle".toLocalized()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "beerIngredients")
        cell.selectionStyle = .none
        
        let ingredientsJoined = beerMalt + beerHops
        cell.textLabel?.text = ingredientsJoined[indexPath.row]
        
        return cell
    }
}

// MARK: - Private

extension BeerDetailView {
    
    private func setupUI() {
        backgroundColor = .white
        beerTableView.delegate = self
        beerTableView.dataSource = self
        
        beerDescriptionLabel.numberOfLines = 10
        beerDescriptionLabel.textAlignment = .center
        
        beerImageView.image = beerImage
        beerImageView.contentMode = .scaleAspectFit
        beerDescriptionLabel.text = beerDescription
    }
    
    private func setupConstraints() {
        addSubview(beerImageView)
        addSubview(beerDescriptionLabel)
        addSubview(beerTableView)
        
        beerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(95)
            make.centerX.equalTo(self)
            make.height.equalTo(125)
            make.width.equalTo(70)
        }
        
        beerDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(beerImageView.snp_bottomMargin).offset(30)
            make.centerX.equalTo(self)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
        }
        
        beerTableView.snp.makeConstraints { make in
            make.top.equalTo(beerDescriptionLabel.snp_bottomMargin).offset(35)
            make.bottom.equalTo(self.safeAreaInsets.bottom)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
}

