
import Foundation
import RxSwift
import Alamofire
import RxAlamofire

class PunkAPIRepositoryDefault: PunkAPIRepository {
    
    private let session = URLSession.shared
    private let urlBase: String = "https://api.punkapi.com/v2/beers"
    private let beersPerPage: Int = 20
    
    func getBeersPaginated(page: Int) -> Single<[BeersResponse]> {
        guard var urlComps = URLComponents(string: urlBase) else { return .error(ServiceError.recivedServiceError("Cannot conect to \(urlBase)")) }
        urlComps.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(beersPerPage)")
        ]
        
        return connect(to: urlComps.string ?? "")
    }
    
    func getBeers(with food: String) -> Single<[BeersResponse]> {
        let foodWithoutSpaces = food.replacingOccurrences(of: " ", with: "_")
        
        guard var urlComps = URLComponents(string: urlBase) else { return .error(ServiceError.recivedServiceError("Cannot conect to \(urlBase)")) }
        urlComps.queryItems = [
            URLQueryItem(name: "food", value: "\(foodWithoutSpaces)"),
            URLQueryItem(name: "per_page", value: "\(beersPerPage)")
        ]
        
        return connect(to: urlComps.string ?? "")
    }
    
    private func connect<T: Decodable>(to url: String) -> Single<T> {
        return RxAlamofire
            .requestData(.get, url, encoding: URLEncoding.default)
            .expectingElement(ofType: T.self)
            .do(onError: RequestErrorManager.chechRequestError)
            .asSingle()
    }
}
