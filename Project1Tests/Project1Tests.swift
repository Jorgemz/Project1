//
//  Project1Tests.swift
//  Project1Tests
//
//  Created by 🤨 on 18/02/23.
//

import XCTest
@testable import Project1

final class Project1Tests: XCTestCase {

    func testLoadingImages() {
        //given
        let sut = ViewController()
        
        //when
        sut.loadViewIfNeeded()
        
        //then
        XCTAssertEqual(sut.pictures.count, 10, "There should be ten pictures")
    }
    
    func testTableExists() {
        //given
        let sut = ViewController()
        
        //when
        sut.loadViewIfNeeded()
        
        //then
        XCTAssertNotNil(sut.tableView)
    }
    
    func testTableViewHasCorrectRowCount() {
        //given
        let sut = ViewController()
        
        //when
        sut.loadViewIfNeeded()
        
        //then
        let rowCount = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rowCount, sut.pictures.count)
    }

    func testEachCellHasTheCorrectText() {
        //given
        let sut = ViewController()
        
        //when
        sut.loadViewIfNeeded()
        
        //then
        for (index, picture) in sut.pictures.enumerated() {
            let indexPath = IndexPath(item: index, section: 0)
            let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
            XCTAssertEqual(cell.textLabel?.text, picture)
        }
    }
    
    func testCellsHaveDisclosureIndicators() {
        // given
        let sut = ViewController()

        // when
        sut.loadViewIfNeeded()
        
        // then
        for index in sut.pictures.indices {
            let indexPath = IndexPath(item: index, section: 0)
            let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
            XCTAssertEqual(cell.accessoryType, .disclosureIndicator)
        }
    }
    
    func testViewControllerUsesLargeTitles() {
        // given
        let sut = ViewController()
        _ = UINavigationController(rootViewController: sut)
                                   
        // when
        sut.loadViewIfNeeded()
        
        // then
        XCTAssertTrue(sut.navigationController?.navigationBar.prefersLargeTitles ?? false)
    }
    
    func testNavigationBarHasStormViewerTitle() {
        // given
        let sut = ViewController()

        // when
        sut.loadViewIfNeeded()
        
        // then
        XCTAssertEqual(sut.title, "Storm Viewer")
    }
}
