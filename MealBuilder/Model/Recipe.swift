//
//  Recipe.swift
//  MealBuilder
//
//  Created by Ryan Nguyen on 7/23/24.
//

import Foundation

struct Recipe: Identifiable, Hashable, Decodable {
    var id: UUID? = .init()
    var name: String
    var description: String?
    var ingredients: [[String]]?
    var instructions: [String]?
    var tags: [String]?
    var images: [String]?
    var duration: String
    var calories: String
    var nutritionFacts: [[String?]]?
    var comments: String?
}

struct MLResponse: Decodable {
    var statusCode: Int
    var body: Recipe
}
