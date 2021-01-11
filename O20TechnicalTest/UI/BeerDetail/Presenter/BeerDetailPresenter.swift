
import Foundation

protocol BeerDetailPresenter {
    func getInternetImage(from string: String?) -> Data?
}

class BeerDetailPresenterDefault {
    
    private let getInternetImageInteractor: GetInternetImageInteractor
    
    init(getInternetImageInteractor: GetInternetImageInteractor) {
        self.getInternetImageInteractor = getInternetImageInteractor
    }
}

// MARK: - Delegate

extension BeerDetailPresenterDefault: BeerDetailPresenter {
    
    func getInternetImage(from string: String?) -> Data? {
        getInternetImageInteractor.execute(from: string)
    }
}
