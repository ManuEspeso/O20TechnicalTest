
import XCTest
import RxBlocking

@testable import O20TechnicalTest
class GetBeersInteractorTest: XCTestCase {
    
    func testBeersInteractorWithSuccessResponse() throws {
        // Given
        let repository = PunkAPIRepositoryMock(jsonName: "getBeersSuccess")
        let interactor = GetBeersInteractorDefault(punkAPIRepository: repository)
        
        // When
        _ = interactor.execute().do(onSuccess: { beersResponse in
            // Then
            XCTAssertEqual(20, beersResponse.count)
            guard let beerResponse = beersResponse.first else { return }
            XCTAssertEqual("Buzz", beerResponse.name)
            XCTAssertEqual("09/2007", beerResponse.firstBrewed)
            XCTAssertEqual(3, beerResponse.ingredients.malt.count)
        })
    }
    
    func testBeersInteractorWithEmptyResponse() throws {
        // Given
        let repository = PunkAPIRepositoryMock(jsonName: "getBeersEmpty")
        let interactor = GetBeersInteractorDefault(punkAPIRepository: repository)
        
        // When
        _ = interactor.execute().do(onSuccess: { beersResponse in
            // Then
            XCTAssertEqual(0, beersResponse.count)
        })
    }
    
    func testBeersInteractorPaginationCompleted() throws {
        // Given
        let repository = PunkAPIRepositoryMock(jsonName: "getBeersEmpty")
        let interactor = GetBeersInteractorDefault(punkAPIRepository: repository)
        
        // When
        interactor.paginationCompleted = true
        
        XCTAssertThrowsError(try interactor.execute().toBlocking().single()) { error in
            // Then
            XCTAssertEqual(error as? GetBeersInteractorError, GetBeersInteractorError.paginationCompleted)
        }
    }
    
    func testBeersInteractorIncreasePageNumber() throws {
        // Given
        let repository = PunkAPIRepositoryMock(jsonName: "getBeersSuccess")
        let interactor = GetBeersInteractorDefault(punkAPIRepository: repository)
        let pageNumber = interactor.pageNumber
        
        // When
        XCTAssertEqual(1, pageNumber)
        
        _ = interactor.execute().do(onSuccess: { beersResponse in
            // Then
            XCTAssertEqual(2, pageNumber)
        })
    }
}
