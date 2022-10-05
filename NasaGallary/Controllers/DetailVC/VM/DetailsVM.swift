//
//  DetailsVM.swift
//  NasaGallary
//
//  Created by Sanjay Thakkar on 05/10/22.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class DetailsVM {
    private let disposeBag = DisposeBag()
    
    public let selectedPhoto: ReplaySubject<Photo> = ReplaySubject<Photo>.create(bufferSize: 1)
    public let heroID: ReplaySubject<String> = ReplaySubject<String>.create(bufferSize: 1)

    public let imgURL: BehaviorSubject<String> =  BehaviorSubject(value: "")
    public let date: BehaviorSubject<String> = BehaviorSubject(value: "")
    public let description = BehaviorSubject(value: "")
    public let title = BehaviorSubject(value: "")
    public let copyright = BehaviorSubject(value: "")

    
    init() {
        selectedPhoto.asObservable()
            .subscribe(onNext:{ photo in
                self.imgURL.onNext(photo.url)
                self.date.onNext(photo.date)
                self.description.onNext(photo.explanation)
                self.title.onNext(photo.title)
                if let copyRight = photo.copyright {
                    self.copyright.onNext("© " + copyRight)
                }
                
                
        }).disposed(by: disposeBag)
        

    }
}
