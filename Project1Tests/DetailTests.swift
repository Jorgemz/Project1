//
//  DetailTests.swift
//  Project1Tests
//
//  Created by 🤨 on 18/02/23.
//

@testable import Project1
import XCTest

final class DetailTests: XCTestCase {

    func testDetailImageViewExists() {
        // given
        let sut = DetailViewController()

        // when
        sut.loadViewIfNeeded()

        // then
        XCTAssertNotNil(sut.imageView)
    }
    
    func testDetailViewIsImageView() {
        // given
        let sut = DetailViewController()
        
        // when
        sut.loadViewIfNeeded()
        
        // then
        XCTAssertEqual(sut.view, sut.imageView)
    }
    
    func testDetailLoadsImage() {
        // given
        let filenameToTest = "nssl0049.jpg"
        let imageToLoad = UIImage(named: filenameToTest, in: Bundle.main, compatibleWith: nil)

        let sut = DetailViewController()
        sut.selectedImage = filenameToTest
        
        // when
        sut.loadViewIfNeeded()

        // then
        XCTAssertEqual(sut.imageView.image, imageToLoad)
    }

    func _testSelectingImageShowsDetail() {
        // given
        let sut = ViewController()
        let navigationController = UINavigationController(rootViewController: sut)
        let testIndexPath = IndexPath(row: 0, section: 0)

        // when
        sut.tableView(sut.tableView, didSelectRowAt: testIndexPath)

        // create an expectation…
        let expectation = XCTestExpectation(description: "Selecting a table view cell.")

        // …then fulfill it asynchronously
        DispatchQueue.main.async {
            expectation.fulfill() }
        
        // then
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(navigationController.topViewController is DetailViewController)
    }
    
    func _testSelectingImageShowsDetailImage() {
        // given
        let sut = ViewController()
        let navigationController = UINavigationController(rootViewController: sut)
        let testIndexPath = IndexPath(row: 0, section: 0)
        let filenameToTest = "nssl0049.jpg"
        let imageToLoad = UIImage(named: filenameToTest, in: Bundle.main, compatibleWith: nil)
        
        // when
        sut.tableView(sut.tableView, didSelectRowAt: testIndexPath)
        
        let expectation = XCTestExpectation(description: "Selecting a table view cell.")
        
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 1)
        
        guard let detail = navigationController.topViewController as? DetailViewController else {
            XCTFail("Didn't push to a detail view controller.")
            return
        }
        
        detail.loadViewIfNeeded()
        
        XCTAssertEqual(detail.imageView.image, imageToLoad)
    }
    
    func testSelectingImageShowsDetail() {
        // given
        let sut = ViewController()
        var selectedImage: String?
        let testIndexPath = IndexPath(row: 0, section: 0)

        // when
        sut.pictureSelectAction = {
            selectedImage = $0
        }
        
        sut.tableView(sut.tableView, didSelectRowAt: testIndexPath)

        // then
        XCTAssertEqual(selectedImage, "nssl0049.jpg")
    }
    
    func testSelectingImageShowsDetailImage() {
        // given
        let sut = ViewController()
        let testIndexPath = IndexPath(row: 0, section: 0)
        let filenameToTest = "nssl0049.jpg"
        let imageToLoad = UIImage(named: filenameToTest, in: Bundle.main, compatibleWith: nil)
        
        // when
        sut.pictureSelectAction = {
            let detail = DetailViewController()
            detail.selectedImage = $0
            detail.loadViewIfNeeded()
            XCTAssertEqual(detail.imageView.image, imageToLoad)
        }
        
        sut.tableView(sut.tableView, didSelectRowAt: testIndexPath)
    }
}
