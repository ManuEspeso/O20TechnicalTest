
import XCTest

@testable import O20TechnicalTest
class GetInternetImageInteractorTest: XCTestCase {
    
    func testGetImageWithURLSuccess() throws {
        // Given
        let repository = GetInternetImageRepositoryTest()
        let interactor = GetInternetImageInteractorDefault(getInternetImageRepository: repository)
        
        // When
        let result = interactor.execute(from: "hola")
        
        // Then
        XCTAssertNotNil(result)
    }
    
    func testGetImageWithURLWrong() throws {
        // Given
        let repository = GetInternetImageRepositoryTest()
        let interactor = GetInternetImageInteractorDefault(getInternetImageRepository: repository)
        
        // When
        let result = interactor.execute(from: "")
        
        // Then
        XCTAssertNil(result)
    }
    
    func testGetImageWithBadURLFormatted() throws {
        // Given
        let repository = GetInternetImageRepositoryTest()
        let interactor = GetInternetImageInteractorDefault(getInternetImageRepository: repository)
        
        // When
        let result = interactor.execute(from: nil)
        
        // Then
        XCTAssertNil(result)
    }
}
