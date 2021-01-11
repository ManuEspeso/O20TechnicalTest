
import XCTest
import RxBlocking

@testable import O20TechnicalTest
class GetBeersFilterInteractorTest: XCTestCase {
    
    func testBeersFilterInteractorWithSuccessResponse() throws {
        // Given
        let repository = PunkAPIRepositoryMock(jsonName: "getBeersSuccess")
        let interactor = GetBeersFilterInteractorDefault(punkAPIRepository: repository)
        
        // When
        let result = try interactor.execute(filter: "").toBlocking().single()
        guard let beerResponse = result.first else { return }
        
        // Then
        XCTAssertEqual(20, result.count)
        XCTAssertEqual("09/2007", beerResponse.firstBrewed)
        XCTAssertEqual(3, beerResponse.ingredients.malt.count)
    }
    
    func testBeersFilterInteractorWithEmptyResponse() throws {
        // Given
        let repository = PunkAPIRepositoryMock(jsonName: "getBeersEmpty")
        let interactor = GetBeersFilterInteractorDefault(punkAPIRepository: repository)
        
        // When
        let result = try interactor.execute(filter: "").toBlocking().single()
        
        // Then
        XCTAssertEqual(0, result.count)
    }
}
