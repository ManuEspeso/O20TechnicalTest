
import Foundation
import RxSwift

extension Observable where Element == (HTTPURLResponse, Data) {
    
    func expectingElement<T : Decodable>(ofType type: T.Type) -> Observable<T> {
        return self.map{ (httpURLResponse, data) -> T in
            if (200 ... 299).contains(httpURLResponse.statusCode) {
                let object = try JSONDecoder().decode(type, from: data)
                return object
            } else {
                throw RequestError.httpError(httpURLResponse.statusCode)
            }
        }
    }
}
