//
//  Extensions.swift
//  NasaGallary
//
//  Created by Sanjay Thakkar on 03/10/22.
//

import Foundation
import UIKit
import RxSwift

extension Bundle {
    static func getJSON<T:Decodable>(from fileName:String, type:T.Type) -> Observable<T?> {
        return Observable<T?>.create { observer in
            guard let url = self.main.url(forResource: fileName, withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                observer.onNext(nil)
                //observer.onCompleted()
                return Disposables.create {}
            }
            observer.onNext(decodedData)
            observer.onCompleted()
            return Disposables.create {}
        }
    }
}

public extension UICollectionView {
    
    /**
     Register nibs faster by passing the type - if for some reason the `identifier` is different then it can be passed
     - Parameter type: UITableViewCell.Type
     - Parameter identifier: String?
     */
    func registerCell(type: UICollectionViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib.getNib(with: cellId), forCellWithReuseIdentifier: identifier ?? cellId)
    }
}

public extension UINib {
    static func getNib(with name:String) -> UINib? {
        return UINib(nibName: name, bundle: nil)
    }
}

public extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension String {
    func dateFormatted() -> Date? {
        let dateFormtter = DateFormatter()
        dateFormtter.dateFormat = "yyyy-MM-dd"
        return dateFormtter.date(from: self)
    }
}
