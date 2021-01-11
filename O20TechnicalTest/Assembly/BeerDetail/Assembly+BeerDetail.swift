
protocol BeerDetailViewProvider {
    func getBeerDetailViewController() -> BeerDetailViewController
}

extension Assembly: BeerDetailViewProvider {
    
    func getBeerDetailViewController() -> BeerDetailViewController {
        let view = BeerDetailViewController()
        view.presenter = getBeerDetailPresenter()
        
        return view
    }
    
    func getBeerDetailPresenter() -> BeerDetailPresenter {
        BeerDetailPresenterDefault(getInternetImageInteractor: getInternetImageInteractor())
    }
    
    func getInternetImageInteractor() -> GetInternetImageInteractor {
        GetInternetImageInteractorDefault(getInternetImageRepository: GetInternetImageRepositoryDefault())
    }
}
