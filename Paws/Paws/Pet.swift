//
//  Pet.swift
//  Paws
//
//  Created by Dhruv Patel on 29/05/26.
//

import Foundation
import SwiftData

@Model
final class Pet {
    var name: String
    @Attribute(.externalStorage) var photo: Data?
    init(name: String, photo: Data? = nil) {
        self.name = name
        self.photo = photo
    }
}
