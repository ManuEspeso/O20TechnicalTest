
import Foundation

protocol GetInternetImageInteractor {
    func execute(from string: String?) -> Data?
}

class GetInternetImageInteractorDefault: GetInternetImageInteractor {
    
    private let getInternetImageRepository: GetInternetImageRepository
    
    init(getInternetImageRepository: GetInternetImageRepository) {
        self.getInternetImageRepository = getInternetImageRepository
    }
    
    func execute(from string: String?) -> Data? {
        getInternetImageRepository.getImage(path: string)
    }
}
