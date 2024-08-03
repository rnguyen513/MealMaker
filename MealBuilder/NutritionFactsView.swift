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
                Text("3 Servings per recipe")
                    .font(.title2)
                    .padding(.top, -10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text("Serving size")
                Spacer()
                
                Text("250g")
            }
            .font(.title2)
            .bold()
            Rectangle()
                .frame(height: 16)
            
            
            Text("Amount per serving")
            HStack {
                Text("Calories")
                Text("650")
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
            
            
            HStack {
                Text("Total Fat")
                    .bold()
                Text("6g")
                Text("8%")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .bold()
            }
            Divider()
                .background(.black)
            
            
            HStack {
                Text("Saturated Fat")
                    .bold()
                Text("10g")
                Text("15%")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .bold()
            }
            Divider()
                .background(.black)
            
            
            HStack {
                Text("Trans Fat")
                    .bold()
                Text("3g")
                Text("5%")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .bold()
            }
            Divider()
                .background(.black)
            
            HStack {
                Text("Protein")
                    .bold()
                Text("40g")
                Text("45%")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .bold()
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
        .padding(.top, 100)
        .transition(.opacity)
        .animation(.easeInOut)
    }
}

#Preview {
    NutritionFactsView(recipe: .init(name:"",duration:"",calories:""))
}
