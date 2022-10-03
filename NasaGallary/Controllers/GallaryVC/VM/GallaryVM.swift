//
//  GallaryVM.swift
//  NasaGallary
//
//  Created by Sanjay Thakkar on 03/10/22.
//

import Foundation
import RxCocoa
import RxSwift

class GallaryVM {
       
    // Model Response //
    var PhotosModelBehaviorRelay = BehaviorRelay<[Photo]>(value: [])
    var PhotosModelObservable: Observable<[Photo]> {
        return PhotosModelBehaviorRelay.asObservable()
    }
    
}
