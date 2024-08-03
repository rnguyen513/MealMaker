//
//  ExpandedRecipeView.swift
//  MealBuilder
//
//  Created by Ryan Nguyen on 8/3/24.
//

import Foundation
import SwiftUI

struct ExpandedRecipeView: View {
    var width: CGFloat
    
    var recipe: Recipe
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text(recipe.name)
                    .font(.title.bold())
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    
                    if let tags = recipe.tags {
                        ForEach(tags, id:\.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .padding(.horizontal, 7)
                                .padding(.vertical, 5)
                                .foregroundStyle(.white)
                                .background {
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundStyle(.gray)
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, -10)
            }
            
            if let images = recipe.images {
                Image(images.first!)
                    .resizable()
                    .frame(width:100,height:100)
                    .aspectRatio(contentMode: .fit)
                //                            .padding(.trailing, 30)
                    .clipShape(.rect(cornerRadius: 5))
                    .shadow(color: .black.opacity(0.1), radius:10, x: 10, y: 10)
            }
            
            Spacer()
            Spacer()
            
            Text(recipe.description ?? "No description")
                .padding()
                .padding(.top, -20)
            
            Spacer()
            
            HStack {
                Label(recipe.duration, systemImage: "clock")
                Label(recipe.calories, systemImage: "flame.fill")
                    .foregroundStyle(.orange)
            }
            .padding(.top, -10)
            
            NutritionFactsView(recipe: recipe)
            
            Spacer()
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ExpandedRecipeView(width: 350, recipe: .init(name:"Blue Salad", description: "", tags: ["2 Servings", "Vegan"], images: ["london2"], duration: "25 MIN", calories: "23 CALORIES"))
}
