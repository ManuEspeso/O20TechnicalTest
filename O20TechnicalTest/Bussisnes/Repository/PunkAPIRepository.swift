
import RxSwift

protocol PunkAPIRepository {
    func getBeersPaginated(page: Int) -> Single<[BeersResponse]>
    func getBeers(with food: String) -> Single<[BeersResponse]>
}
