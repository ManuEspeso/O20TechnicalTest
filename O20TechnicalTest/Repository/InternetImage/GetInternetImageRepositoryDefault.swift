
import Foundation
import RxSwift

class GetInternetImageRepositoryDefault: GetInternetImageRepository {
    
    func getImage(path string: String?) -> Data? {
        guard let string = string else { return nil }
        guard let url = URL(string: string) else { return nil }
        
        do {
            let data = try Data(contentsOf: url, options: [])
            return data
        }
        catch {
            return nil
        }
    }
}
