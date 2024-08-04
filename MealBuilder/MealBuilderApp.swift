//
//  MealBuilderApp.swift
//  MealBuilder
//
//  Created by Ryan Nguyen on 7/19/24.
//

import SwiftUI

@main
struct MealBuilderApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environmentObject(MLRequestService())
            NutritionFactsPickerView()
                .environmentObject(MLRequestService())
                .environmentObject(RecipeStorageService())
        }
    }
}
