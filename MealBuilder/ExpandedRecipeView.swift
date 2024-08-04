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
    
    var preview: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ZStack {
                VStack {
                    ScrollView(.vertical) {
                        VStack {
                            Text(recipe.name)
                                .font(.title.bold())
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
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
                            .padding(.horizontal)
                        }
                        
                        if let images = recipe.images {
                            Image(images.first!)
                                .resizable()
                                .frame(maxWidth: .infinity)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(.rect(cornerRadius: 5))
                                .padding()
                                .shadow(color: .black.opacity(0.1), radius:10, x: 10, y: 10)
                        }
                        
                        if let description = recipe.description {
                            Text(description)
                                .padding()
                                .padding(.top, -20)
                        } else {
                            Text("No description")
                        }
                        
                        HStack {
                            Label(recipe.duration, systemImage: "clock")
                            Label(recipe.calories, systemImage: "flame.fill")
                                .foregroundStyle(.orange)
                        }
                        .padding(.top, -10)
                        
                        NutritionFactsView(recipe: recipe)
                        
                        if let instructions = recipe.instructions {
                            ForEach(instructions, id: \.self) { instruction in
                                Text(instruction)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                
                if !preview {
                    Image(systemName: "tray")
                        .padding()
                        .background(.ultraThinMaterial)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .clipShape(.circle)
                        .shadow(color: .black, radius: 3)
                        .zIndex(1)
                        .offset(x: size.width/2 * 0.8, y: size.height/2 * 0.95)
                        .onTapGesture {
                            print("open inventory")
                        }
                    
                    Image(systemName: "chart.bar.doc.horizontal")
                        .padding()
                        .background(.ultraThinMaterial)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .clipShape(.circle)
                        .shadow(color: .black, radius: 3)
                        .zIndex(1)
                        .offset(x: size.width/2 * 0.5, y: size.height/2 * 0.95)
                        .onTapGesture {
                            print("open inventory")
                        }
                }
            }
            .frame(width: size.width, height: size.height)
        }
    }
}

#Preview {
    ExpandedRecipeView(width: 350, recipe: .init(name:"Blue Salad", description: "This came from southern living...", tags: ["2 Servings", "Vegan"], images: ["london2"], duration: "25 MIN", calories: "23 CALORIES"), preview: false)
}
