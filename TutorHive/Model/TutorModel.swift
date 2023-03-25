//
//  TutorModel.swift
//  TutorHive
//
//  Created by Rodrigo Chavez on 2023-03-15.
//

import Foundation

struct Tutor: Identifiable {
    var id: String
    var name: String
    var lastName: String
    var skills: [String]
    var language: [String]
    var description: String
    var price: Float
}


