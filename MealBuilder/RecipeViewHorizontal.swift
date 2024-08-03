//
//  RecipeViewHorizontal.swift
//  MealBuilder
//
//  Created by Ryan Nguyen on 7/24/24.
//

import SwiftUI

struct RecipeViewHorizontal: View {
    var width: CGFloat
    var height: CGFloat
    
    var recipe: Recipe
    
    var body: some View {
        Text("kjlksjdf")
        Rectangle()
            .foregroundStyle(.thinMaterial)
            .frame(width: width, height: height)
            .clipShape(.rect(cornerRadius: 15))
            .shadow(radius: 15, x: 10, y: 5)
//            .overlay {
//                VStack {
//                    
//                }
//            }
    }
}

#Preview {
    RecipeViewHorizontal(width: 100, height: 200, recipe: .init(name: "Blue Salad", description: "", tags: ["2 Servings","Vegan"], images: ["chicken"], duration: "20 MIN", calories: "23 CAL"))
}
