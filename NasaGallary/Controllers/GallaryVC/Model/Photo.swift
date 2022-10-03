//
//  Photos.swift
//  NasaGallary
//
//  Created by Sanjay Thakkar on 03/10/22.
//

import Foundation

struct Photo:  Codable {
    var copyright: String?
    var title: String
    var explanation: String
    var date: String
    var url: String
    var dateObj: Date?
}
