
import XCTest
import Alamofire

@testable import O20TechnicalTest
class RequestErrorManagerTest: XCTestCase {

    func testRequestErrorWhenTimeout() {
        let errorGenerated = NSError(domain: "Alamofire.AFError", code: -1001, userInfo:nil)
        let afError = AFError.sessionTaskFailed(error: errorGenerated)
        
        XCTAssertThrowsError(try RequestErrorManager.chechRequestError(afError)) { error in
            XCTAssertEqual(error as! ServiceError, ServiceError.recivedServiceError("Time exceeded when trying to connect to the server"))
        }
    }
    
    func testRequestErrorWhenNoInternet() {
        let errorGenerated = NSError(domain: "Alamofire.AFError", code: -1009, userInfo:nil)
        let afError = AFError.sessionTaskFailed(error: errorGenerated)
        
        XCTAssertThrowsError(try RequestErrorManager.chechRequestError(afError)) { error in
            XCTAssertEqual(error as! ServiceError, ServiceError.recivedServiceError("You don´t have internet connection, check it and try again"))
        }
    }
    
    func testRequestErrorWhenSomethingWrong() {
        let errorGenerated = NSError(domain: "Alamofire.AFError", code: 0, userInfo:nil)
        let afError = AFError.sessionTaskFailed(error: errorGenerated)
        
        XCTAssertThrowsError(try RequestErrorManager.chechRequestError(afError)) { error in
            XCTAssertEqual(error as! ServiceError, ServiceError.recivedServiceError("An error has occurred while trying to get the data, please try again"))
        }
    }
}

