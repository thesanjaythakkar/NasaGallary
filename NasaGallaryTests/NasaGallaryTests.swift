//
//  NasaGallaryTests.swift
//  NasaGallaryTests
//
//  Created by Sanjay Thakkar on 03/10/22.
//

import XCTest
import RxSwift
@testable import NasaGallary

class NasaGallaryTests: XCTestCase {

    let viewModel: GallaryVM = GallaryVM()
    var index = 0
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testFileRead() throws {
        
        Bundle.getJSON(from: "data", type: [Photo].self).asObservable().subscribe(onNext: { data in
            XCTAssertNotNil(data)
        }).disposed(by: DisposeBag())
                                                                                  
        Bundle.getJSON(from: "xyz", type: [Photo].self).asObservable().subscribe(onNext: { data in
            XCTAssertNil(data)
        }).disposed(by: DisposeBag())
    }
    func testGallaryViewModel_array_shouldBeEmpty() throws {
        viewModel.sortedPhotos.asObserver().subscribe(onNext:  { photos in
            XCTAssertFalse(photos.isEmpty)
            XCTAssertEqual(photos.count, 26)
        }).disposed(by: DisposeBag())
    }
    
    func testPhotoContainsTitle() throws {
        viewModel.sortedPhotos.asObserver().subscribe(onNext:  { photos in
            let photo = photos[self.index]
            XCTAssertNotNil(photo.title)
        }).disposed(by: DisposeBag())
    }
    func testPhotoContainsImageURL() throws {
        viewModel.sortedPhotos.asObserver().subscribe(onNext:  { photos in
            let photo = photos[self.index]
            XCTAssertNotNil(photo.url)
        }).disposed(by: DisposeBag())
    }
    func testPhotoContainsExplanation() throws {
        viewModel.sortedPhotos.asObserver().subscribe(onNext:  { photos in
            let photo = photos[self.index]
            XCTAssertNotNil(photo.explanation)
        }).disposed(by: DisposeBag())
    }
    func testPhotoContainsDate() throws {
        viewModel.sortedPhotos.asObserver().subscribe(onNext:  { photos in
            let photo = photos[self.index]
            XCTAssertNotNil(photo.date)
        }).disposed(by: DisposeBag())
    }
    func testPhotoContainsCopyRight() throws {
        viewModel.sortedPhotos.asObserver().subscribe(onNext:  { photos in
            let photo = photos[self.index]
            XCTAssertNotNil(photo.copyright)
        }).disposed(by: DisposeBag())
    }
    func testSorting() throws {
        viewModel.photos.asObserver().subscribe(onNext:  { photos in
            XCTAssertNotNil(self.viewModel.sort(photos:photos))
        }).disposed(by: DisposeBag())
    }
    func testDateFormatter() throws {
        XCTAssertNotNil("2022-10-21".dateFormatted())
        XCTAssertNil("10-21-2022".dateFormatted())
    }
    func testLoadCell() throws {
        let cell = UINib.getNib(with: GallaryCell.identifier)
        XCTAssertNotNil(cell)
    }
    

}
