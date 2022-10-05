//
//  DataProvider.swift
//  NasaGallary
//
//  Created by Sanjay Thakkar on 05/10/22.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

class DataProvider {
    
    static let shared = DataProvider()
    
    private init(){}
    
    func loadData<T: Decodable>(fileName:String, type: T.Type) -> Observable<T?> {
        return Observable.from([fileName])
            .flatMap { fileName -> Observable<T?> in
                return Bundle.getJSON(from: fileName, type: type)
        }.asObservable()
    }
}
