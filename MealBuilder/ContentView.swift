//
//  ContentView.swift
//  MealBuilder
//
//  Created by Ryan Nguyen on 7/19/24.
//

import SwiftUI

struct ContentView: View {
    private var recipes: [Recipe] = [
        .init(name: "Blue Salad", description: "This came from southern living...", tags: ["2 Servings","Vegan"], images: ["chicken"], duration: "20 MIN", calories: "23 CAL"),
        .init(name: "Spaghetti & Meatballs", description: "Your perfect spaghetti and meatballs.", tags: ["4 Servings", "Protein"], images: ["spaghetti"], duration: "45 MIN", calories: "400 CAL"),
        .init(name: "Chicken and Rice", description: "Good ol' chicken and rice. Can't go wrong.", tags: ["3 Servings", "Protein", "Quick"], images: ["steak"], duration: "25 MIN", calories: "400 CAL")
    ]
    
    var body: some View {
//        NavigationStack {
            VStack {
                HStack {
                    Text("Welcome Chef Lora")
                        .font(.title.bold())
                    Spacer()
                    
                    Button(action: {
                        print("switch to horizontal view")
                    }) {
                        Image(systemName: "square.split.2x2.fill")
                            .foregroundStyle(.black)
                    }
                    
                }
                .opacity(0.8)
                .zIndex(1)
                .padding()
                .background(.ultraThinMaterial)
                //            .background(.purple.opacity(0.2))
                
                GeometryReader { geometry in
                    
                    VStack {
                    }
                    .frame(width:geometry.size.width)
                    .zIndex(1)
                    
                    ScrollView(.vertical) {
                        VStack {
                            
                            
                            Button("New", systemImage: "plus") {
                                print("sdf")
                            }
                            .frame(width:geometry.size.width*0.9)
                            .padding(.vertical)
                            .background(.green.opacity(0.7))
                            .foregroundStyle(.white)
                            .font(.title2.bold())
                            .clipShape(.rect(cornerRadius: 15))
                            .padding(.bottom, -30)
                            .padding(.top, geometry.size.height*0.1)
                            
                            
                            ForEach(recipes) { _recipe in
                                RecipeViewHotdog(width: geometry.size.width*0.9, height: 300, recipe: _recipe)
                            }
                            .offset(y:geometry.size.height*0.05)
                            .padding(.horizontal)
                            
                            
                            Text("nothing to see here")
                                .offset(y:geometry.size.height*0.1)
                                .opacity(0.6)
                            
                            
                        }
                        .padding(.bottom, geometry.size.height*0.25)
                    }
                    .scrollIndicators(.hidden)
                    .frame(width: geometry.size.width, height: geometry.size.height*1.2)
                    .offset(y:-geometry.size.height*0.1)
//                    .background(.red)
                }
                
                HStack {
                    ForEach(["house.fill","square.split.2x2.fill","square.fill","gear"], id: \.self) { img in
                        
                        Button(action: {
                            print("\(img) tapped")
                        }) {
                            Image(systemName:img)
                                .offset(y:10)
                                .foregroundStyle(.black.opacity(0.8))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial.opacity(0.9))
            }
//            .navigationTitle("Welcome Chef Lora")
//        }
    }
}

#Preview {
    ContentView()
}
