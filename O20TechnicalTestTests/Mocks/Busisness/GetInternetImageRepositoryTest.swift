
import Foundation

@testable import O20TechnicalTest
class GetInternetImageRepositoryTest: GetInternetImageRepository {
    
    func getImage(path string: String?) -> Data? {
        guard let string = string else { return nil }
        
        if string.isEmpty {
            return nil
        }
        return Data(base64Encoded: string)
    }
}
