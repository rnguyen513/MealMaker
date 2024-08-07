//
//  StateManagerService.swift
//  MealBuilder
//
//  Created by Ryan Nguyen on 8/6/24.
//

import Foundation

class StateManagerService: ObservableObject {
    @Published var showingExpandedRecipe: Bool = false
    @Published var selectedRecipe: Recipe?
}
