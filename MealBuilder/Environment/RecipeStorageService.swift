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
    
    @Published var inventory = [[String]]()
    
    func addRecipe(_ newRecipe: Recipe) {
        self.recipes.append(newRecipe)
        print("saved \(newRecipe)")
    }
    
    func addToInventory(_ newIngredient: [String]) {
        self.inventory.append(newIngredient)
        print("Added \(newIngredient)")
    }
}
