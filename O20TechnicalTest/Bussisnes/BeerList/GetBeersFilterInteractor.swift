
import RxSwift

protocol GetBeersFilterInteractor {
    func execute(filter: String) -> Single<[BeersResponse]>
}

class GetBeersFilterInteractorDefault: GetBeersFilterInteractor {
    
    private let punkAPIRepository: PunkAPIRepository
    
    init(punkAPIRepository: PunkAPIRepository) {
        self.punkAPIRepository = punkAPIRepository
    }
    
    func execute(filter: String) -> Single<[BeersResponse]> {
        punkAPIRepository.getBeers(with: filter)
    }
}
