
import Foundation
import Alamofire

enum RequestError: Error {
    case httpError(Int)
}

class RequestErrorManager {
    
    static func chechRequestError(_ error: Error) throws {
        guard !(error is RequestError) else { throw error }
        
        try mapAFError(with: error)
    }
    
    static private func mapAFError(with error: Error) throws {
        guard case let AFError.sessionTaskFailed(afError) = error else {
            return
        }
        
        switch (afError as NSError).code {
        case Int(CFNetworkErrors.cfurlErrorTimedOut.rawValue):
            throw ServiceError.recivedServiceError("serviceError_timeout".toLocalized())
        case Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue):
            throw ServiceError.recivedServiceError("serviceError_internetLost".toLocalized())
        default:
            throw ServiceError.recivedServiceError("alertMessage_generic".toLocalized())
        }
    }
}
