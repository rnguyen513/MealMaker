//
//  InventoryView.swift
//  MealBuilder
//
//  Created by Ryan Nguyen on 8/9/24.
//

import Foundation
import SwiftUI

struct InventoryView: View {
    @EnvironmentObject var recipeStorageService: RecipeStorageService
    
    @State private var showAdd: Bool = false
    @State private var newName: String = ""
    @State private var newQuantity: String = ""
    @State private var newUnit: String = ""
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            ZStack {
                VStack {
                    ScrollView(.vertical) {
                        VStack {
                            Spacer()
                            if !recipeStorageService.inventory.isEmpty {
                                Text("You have:")
                                ForEach(recipeStorageService.inventory, id: \.self) { ingredient in
                                    Text("\(ingredient[0]) - \(ingredient[1])\(ingredient[2])")
                                        .padding()
                                        .frame(width: 200, height: 100)
                                        .background(.gray.opacity(0.6))
                                        .clipShape(.rect(cornerRadius: 15))
                                        .padding()
                                }
                            }
                            else {
                                Text("There's nothing in your pantry...")
                            }
                            Spacer()
                            Button("Add", systemImage: "plus") {
                                withAnimation {
                                    showAdd = true
                                }
                            }
                            .padding()
                            .font(.title.bold())
                            .foregroundStyle(.white)
                            .background(.green.gradient.opacity(0.7))
                            .clipShape(.rect(cornerRadius: 15))
                            Spacer()
                        }
                        .frame(height: size.height * 0.8)
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(width: size.width*0.9, height: size.height*0.8)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 15))
                .shadow(radius: 10)
                .position(x: size.width / 2, y: size.height / 2)
                
                if showAdd {
                    VStack {
                        Text("Add new ingredient")
                        TextField("Name of ingredient", text: $newName)
                        TextField("Quantity of ingredient", text: $newQuantity)
                        TextField("Unit of ingredient", text: $newUnit)
                        Button("Ok") {
                            recipeStorageService.addToInventory([newName, newQuantity, newUnit])
                            withAnimation {
                                newName = ""
                                newQuantity = ""
                                newUnit = ""
                                showAdd = false
                            }
                        }
                    }
                    .padding()
                    .frame(width: size.width * 0.5)
                    .background(.orange.gradient.opacity(0.8))
                    .clipShape(.rect(cornerRadius: 15))
                    .zIndex(2)
                    .transition(.blurReplace)
                    .animation(.easeInOut, value: showAdd)
                }
                
//                VStack {
//                    Spacer()
//                    HStack {
//                        Spacer()
//                        Spacer()
//                        Button("", systemImage: "xmark") {
//                            print("hjioh")
//                        }
//                        Spacer()
//                    }
//                    Spacer()
//                    Spacer()
//                    Spacer()
//                }
                
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    InventoryView()
        .environmentObject(RecipeStorageService())
}
