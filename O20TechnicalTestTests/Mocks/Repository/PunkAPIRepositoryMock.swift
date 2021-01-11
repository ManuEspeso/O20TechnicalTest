
import Foundation
import RxSwift

@testable import O20TechnicalTest
class PunkAPIRepositoryMock: PunkAPIRepository {
    
    private enum FakeError: Error {
        case anError
    }
    
    private let jsonName: String
    
    init(jsonName: String) {
        self.jsonName = jsonName
    }
    
    func getBeersPaginated(page: Int) -> Single<[BeersResponse]> {
        connect()
    }
    
    func getBeers(with food: String) -> Single<[BeersResponse]> {
        connect()
    }
    
    private func connect() -> Single<[BeersResponse]> {
        Single.create { single -> Disposable in
            let result = self.readJSONArray(name: self.jsonName, type: BeersResponse.self)
            
            guard let beersData = result else {
                single(.failure(FakeError.anError))
                return Disposables.create()
            }
            single(.success(beersData))
            return Disposables.create()
        }
    }
    
    private func readJSONArray<T: Decodable>(name: String, type: T.Type) -> [T]? {
        let bundle = Bundle(for: PunkAPIRepositoryMock.self)
        guard let url = bundle.url(forResource: name, withExtension: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            return try JSONDecoder().decode([T].self, from: data)
        }
        catch {
            return nil
        }
    }
}
