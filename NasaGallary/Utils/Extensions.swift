//
//  Extensions.swift
//  NasaGallary
//
//  Created by Sanjay Thakkar on 03/10/22.
//

import Foundation

extension Bundle {
    static func getJSON<T:Decodable>(from fileName:String, type:T.Type) -> T? {
        guard let url = self.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decodedData = try? JSONDecoder().decode(T.self, from: data) else { return nil }
        return decodedData
    }
}
