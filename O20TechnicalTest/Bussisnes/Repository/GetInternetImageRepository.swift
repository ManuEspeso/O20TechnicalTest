
import Foundation
import RxSwift

protocol GetInternetImageRepository {
    func getImage(path string: String?) -> Data?
}
