//
//  NutritionFactsView.swift
//  MealBuilder
//
//  Created by Ryan Nguyen on 8/3/24.
//

import Foundation
import SwiftUI

struct NutritionFactsView: View {
    var recipe: Recipe
    var body: some View {
        VStack(alignment: .leading) {
            Text("Nutrition Facts")
                .font(.title.bold())
            Rectangle()
                .frame(height: 2)
                .padding(.top, -10)
            
            HStack(alignment: .bottom) {
                Text("[] Servings per recipe")
                    .font(.title2)
                    .padding(.top, -10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text("Serving size")
                Spacer()
                
                Text("[]")
            }
            .font(.title2)
            .bold()
            Rectangle()
                .frame(height: 16)
            
            
            Text("Amount per serving")
            HStack {
                Text("Calories")
                Text(recipe.calories)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .font(.title.bold())
            Rectangle()
                .frame(height: 8)
                .padding(.top, -10)
            
            
            Text("% Daily Value*")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .bold()
            Divider()
                .background(.black)
            
            if let nutritionFacts = recipe.nutritionFacts, nutritionFacts != [] {
                ForEach(nutritionFacts, id: \.self) { nutrient in
                    HStack {
                        Text(nutrient[0] ?? "")
                            .bold()
                        Text("\(nutrient[1] ?? "")\(nutrient[2] ?? "")")
//                        Text(nutrient[2] ?? "")
                        if nutrient.count == 4 {
                            Text("\(nutrient[3] ?? "")%")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .bold()
                        }
                    }
                    Divider()
                        .background(.black)
                }
            }
            else {
                Text("Couldn't get nutrition value this time...")
                    .bold()
            }
            
            HStack {
                Text("That's all!")
                    .italic()
                    .foregroundStyle(.gray)
            }
            
            Rectangle()
                .frame(height: 16)
            
            
            Text("*The % Daily Value (DV) tells you how much a nutrient in a serving of food contributes to a daily diet. 2,000 calories a day is used for general nutrition advice.")
            
        }
        .padding()
        .border(.black, width: 5)
        .shadow(color: .black.opacity(0.3), radius: 15)
        .background(.white)
        .padding()
    }
}

#Preview {
    NutritionFactsView(recipe: .init(name:"",duration:"",calories:"50", nutritionFacts: [["Protein","100","g","125%"],["Fat","100","g","15%"],["Carbohydrates","100","g","40%"],["Fiber","100","g","60%"]]))
}
