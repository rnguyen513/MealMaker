//
//  RecipeStorageService.swift
//  MealBuilder
//
//  Created by Ryan Nguyen on 8/3/24.
//

import Foundation
import SwiftUI

class RecipeStorageService: ObservableObject {
    @Published var recipes = [Recipe]()
    
    func addRecipe(_ newRecipe: Recipe) {
        self.recipes.append(newRecipe)
    }
}
