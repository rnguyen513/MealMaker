//
//  ExpandedRecipeView.swift
//  MealBuilder
//
//  Created by Ryan Nguyen on 8/3/24.
//

import Foundation
import SwiftUI

struct ExpandedRecipeView: View {
    var recipe: Recipe
    
    var preview: Bool
    
    @State private var showIngredients: Bool = false
    @State private var showInventory: Bool = false
    
    @EnvironmentObject var stateManagerService: StateManagerService
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ZStack {
                VStack {
                    ScrollView(.vertical) {
                        VStack {
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
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(.rect(cornerRadius: 15))
                            .padding(.horizontal)
                            
                            if let images = recipe.images, !images.isEmpty, images.first != "spaghetti" {
                                AsyncImage(url: URL(string: images.first!))
                                    .frame(maxWidth: .infinity)
                                    .clipShape(.rect(cornerRadius: 5))
                                    .aspectRatio(contentMode: .fill)
                                    .padding()
                                    .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)
                            }
                            else {
                                Text("No image")
                                    .padding()
                            }
                            
                            if let ingredients = recipe.ingredients, preview || showIngredients {
                                VStack {
                                    HStack {
                                        Text("ingredients")
                                            .font(.title)
                                        if !preview {
                                            Image(systemName: "xmark")
                                                .onTapGesture {
                                                    withAnimation {
                                                        showIngredients = false
                                                    }
                                                }
                                        }
                                    }
                                    ForEach(ingredients, id: \.self) { ingredient in
                                        if ingredient.count == 2 {
                                            Text("\(ingredient[0]) - \(ingredient[1])")
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                                .clipShape(.rect(cornerRadius: 15))
                                        }
                                        else if ingredient.count == 3 {
                                            Text("\(ingredient[0]) - \(ingredient[1])\(ingredient[2])")
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                                .clipShape(.rect(cornerRadius: 15))
                                        }
                                        else {
                                            Text("Error with ingredient")
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                                .clipShape(.rect(cornerRadius: 15))
                                        }
                                    }
                                }
                                .padding()
                                .bold()
                                .background(.ultraThinMaterial)
                                .padding(.bottom, 10)
                                .transition(.push(from: .top))
                                .animation(.easeInOut, value: showIngredients)
                            }
                            
                            if let description = recipe.description {
                                Text(description)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .clipShape(.rect(cornerRadius: 15))
                                    .padding(.horizontal)
//                                    .padding(.top, -10)
                            } else {
                                Text("No description")
                            }
                            
                            HStack {
                                Label(recipe.duration, systemImage: "clock")
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .clipShape(.rect(cornerRadius: 15))
                                Label(recipe.calories, systemImage: "flame.fill")
                                    .foregroundStyle(.orange)
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .clipShape(.rect(cornerRadius: 15))
                            }
                            
                            NutritionFactsView(recipe: recipe)
                            
                            if let instructions = recipe.instructions {
                                ForEach(instructions, id: \.self) { instruction in
                                    Text(instruction)
                                        .padding()
                                        .background(.ultraThinMaterial)
                                        .clipShape(.rect(cornerRadius: 15))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                }
                            }
                        }
                        .padding(.top, preview ? 100 : 30)
                        .padding(.bottom, 100)
                    }
                    .scrollIndicators(.hidden)
                }
                
                if showInventory {
                    InventoryView()
                        .zIndex(5)
                }
                
                
                if !preview {
                    VStack {
                        Spacer()
                        HStack {
                            Image(systemName: "xmark")
                                .padding()
                                .background(.red.gradient)
                                .clipShape(.circle)
                                .shadow(color: .red, radius: 3)
                                .zIndex(1)
                                .onTapGesture {
                                    print("close")
                                    withAnimation {
                                        stateManagerService.selectedRecipe = nil
                                        stateManagerService.showingExpandedRecipe = false
                                    }
                                }
                            Spacer()
                            Image(systemName: "tray")
                                .padding()
                                .background(showInventory ? .red.opacity(0.5) : .gray.opacity(0.3))
                                .clipShape(.circle)
                                .shadow(color: .black, radius: 3)
                                .zIndex(1)
                                .onTapGesture {
                                    print("open inventory")
                                    withAnimation {
                                        showInventory.toggle()
                                    }
                                }
                            
                            Image(systemName: "chart.bar.doc.horizontal")
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(.circle)
                                .shadow(color: .black, radius: 3)
                                .zIndex(1)
                                .onTapGesture {
                                    print("open ingredients")
                                    withAnimation {
                                        showIngredients.toggle()
                                    }
                                }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .frame(width: size.width, height: size.height)
        }
    }
}

#Preview {
    ExpandedRecipeView(recipe: .init(name:"Blue Salad", description: "This came from southern living...", ingredients: [["Broccoli", "2", "cup"], ["Chicken Breast", "150", "g"]], tags: ["2 Servings", "Vegan"], images: ["london2"], duration: "25 MIN", calories: "23"), preview: false)
        .environmentObject(StateManagerService())
        .environmentObject(RecipeStorageService())
}
