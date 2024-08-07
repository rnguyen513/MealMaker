//
//  RecipeViewHotdog.swift
//  MealBuilder
//
//  Created by Ryan Nguyen on 7/22/24.
//

import Foundation
import SwiftUI

struct RecipeViewHotdog: View {
    var width: CGFloat
    var height: CGFloat
    
    var recipe: Recipe
    
    var body: some View {
        Rectangle()
            .foregroundStyle(.thinMaterial)
            .frame(width: width, height: height)
            .clipShape(.rect(cornerRadius: 15))
            .shadow(radius: 15, x: 10, y: 5)
            .overlay {
                VStack {
                    HStack {
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
                        Spacer()
                        Spacer()
                        
                        if let images = recipe.images, !images.isEmpty, images.first != "spaghetti" {
                            AsyncImage(url: URL(string: images.first!))
                                .frame(maxWidth: width * 0.25, maxHeight: height * 0.25)
                                .clipShape(.rect(cornerRadius: 5))
                                .aspectRatio(contentMode: .fill)
                                .padding()
                                .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)
                        }
                        else {
                            Text("No picture")
                                .foregroundStyle(.gray)
                                .padding()
                        }
                        
                        Spacer()
                    }
                    .padding()
                    
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
                    
                    Spacer()
                }
            }
    }
}

#Preview {
//    RecipeViewHotdog(width: 350, height: 300, recipe: .init(name:"Blue Salad", description: "", tags: ["2 Servings", "Vegan"], images: ["london2"], duration: "25 MIN", calories: "23 CALORIES"))
    ContentView()
        .environmentObject(MLRequestService())
        .environmentObject(RecipeStorageService())
        .environmentObject(StateManagerService())
}
