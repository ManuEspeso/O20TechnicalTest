
import RxSwift

enum GetBeersInteractorError: Error {
    case paginationCompleted
}

protocol GetBeersInteractor {
    func execute() -> Single<[BeersResponse]>
}

class GetBeersInteractorDefault: GetBeersInteractor {
    
    var paginationCompleted: Bool = false
    var pageNumber: Int = 1
    private let punkAPIRepository: PunkAPIRepository
    
    init(punkAPIRepository: PunkAPIRepository) {
        self.punkAPIRepository = punkAPIRepository
    }
    
    func execute() -> Single<[BeersResponse]> {
        guard !paginationCompleted else {
            return .error(GetBeersInteractorError.paginationCompleted)
        }
        
        return punkAPIRepository
            .getBeersPaginated(page: pageNumber)
            .do(onSuccess: { [weak self] beersResponse in
                if beersResponse.isEmpty {
                    self?.paginationCompleted = true
                }
                self?.pageNumber += 1
            })
    }
}
