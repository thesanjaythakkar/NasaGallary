//
//  GallaryVM.swift
//  NasaGallary
//
//  Created by Sanjay Thakkar on 03/10/22.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay

/// Gallary View Model
class GallaryVM {
       
    private let disposeBag = DisposeBag()
    
    public let photos: BehaviorSubject<[Photo]> = BehaviorSubject(value: [])
    public let sortedPhotos: BehaviorSubject<[Photo]> = BehaviorSubject(value: [])

    init() {
        self.getAllPhotos()
    }
    
    func getAllPhotos() {
        DataProvider.shared.loadData(fileName: "data", type: [Photo].self).subscribe { data in
            self.photos.onNext(data ?? [])
        }.disposed(by: disposeBag)
        self.photos.subscribe (onNext: { photos in
            self.sortedPhotos.onNext(self.sort(photos: photos))
        }).disposed(by: disposeBag)
    }
    
    func sort(photos:[Photo]?) -> [Photo] {
        guard let photos = photos else { return [] }
            return photos.sorted(by: { photo1, photo2 in
                                if let date1 = photo1.date.dateFormatted(), let date2 = photo2.date.dateFormatted() {
                                    return date1 > date2
                                }
                                return false
                            })
    }
}
