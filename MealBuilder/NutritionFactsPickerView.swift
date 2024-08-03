//
//  NutritionFactsPickerView.swift
//  MealBuilder
//
//  Created by Ryan Nguyen on 7/24/24.
//

import SwiftUI

struct NutritionFactsPickerView: View {
    @State private var servings: Int = 3
    @State private var servingSize: Int = 0
    @State private var totalFat: Int = 15
    @State private var protein: Int = 35
    
    @State private var isLoading: Bool = false
    @State private var showResult: Bool = false
    
    @EnvironmentObject var mlRequestService: MLRequestService
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ZStack {
                if isLoading {
                    Rectangle()
                        .frame(width:size.width, height: size.height)
                        .ignoresSafeArea()
                        .background(.thinMaterial.opacity(0.1))
                        .zIndex(2)
                }
                VStack {
                    if /*isLoading*/ false {
//                        ProgressView()
                    }
                    else {
                        ScrollView {
                            if showResult, let newRecipe = mlRequestService.responseData {
                                RecipeViewHotdog(width:size.width*0.95, height: 300, recipe: newRecipe)
                                    .padding(.top, 100)
                                    .transition(.opacity)
                                    .animation(.easeInOut)
                            } else {
                                VStack(alignment: .leading) {
                                    Text("Nutrition Facts")
                                        .font(.title.bold())
                                    Rectangle()
                                        .frame(height: 2)
                                        .padding(.top, -10)
                                    
                                    HStack(alignment: .bottom) {
                                        TextField("", value: $servings, formatter: NumberFormatter())
                                            .keyboardType(.numberPad)
                                        //                            .padding(.horizontal)
                                            .frame(maxWidth: 25)
                                            .padding(.leading)
                                            .border(.black, width: 2)
                                            .font(.title2.bold())
                                        Text("Servings per recipe")
                                            .font(.title2)
                                            .padding(.top, -10)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    HStack {
                                        Text("Serving size")
                                        Spacer()
                                        TextField("", value: $servingSize, formatter: NumberFormatter())
                                            .frame(maxWidth: 75)
                                            .padding(.leading)
                                            .border(.black, width: 2)
                                        
                                        Text("g")
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
                                        TextField("", value: $totalFat, formatter: NumberFormatter())
                                            .frame(maxWidth: 35)
                                            .border(.black, width: 1)
                                        Text("g")
                                        Text("8%")
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .bold()
                                    }
                                    Divider()
                                        .background(.black)
                                    
                                    
                                    HStack {
                                        Text("Saturated Fat")
                                            .bold()
                                        TextField("", value: .constant(""), formatter: NumberFormatter())
                                            .frame(maxWidth: 35)
                                            .border(.black, width: 1)
                                        Text("g")
                                        Text("15%")
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .bold()
                                    }
                                    Divider()
                                        .background(.black)
                                    
                                    
                                    HStack {
                                        Text("Trans Fat")
                                            .bold()
                                        TextField("", value: .constant(""), formatter: NumberFormatter())
                                            .frame(maxWidth: 35)
                                            .border(.black, width: 1)
                                        Text("g")
                                        Text("5%")
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .bold()
                                    }
                                    Divider()
                                        .background(.black)
                                    
                                    HStack {
                                        Text("Protein")
                                            .bold()
                                        TextField("", value: $protein, formatter: NumberFormatter())
                                            .frame(maxWidth: 35)
                                            .border(.black, width: 1)
                                        Text("g")
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
                        .scrollIndicators(.hidden)
                    }
                }
                .ignoresSafeArea()
                .frame(width: size.width, height: size.height)
                .background(LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .overlay {
                    HStack {
                        if isLoading {
                            ProgressView()
                        }
                        else if let responseData = mlRequestService.responseData {
                            Button("Continue?") {
                                print(responseData)
                            }
                        } else {
                            Button("Let's go", systemImage: "arrowshape.right.fill") {
                                print("Servings: \(servings), totalFat: \(totalFat), protein: \(protein)")
                                isLoading = true
                                Task {
                                    //Groq query
                                    let url = "https://9j4e4m0xc4.execute-api.us-east-1.amazonaws.com/testStage/MealMakerGroq"
                                    let parameters: [String: Any] = ["GroqRequest":"Create a meal recipe with \(totalFat) grams of total fat and \(protein) grams of protein per serving. The overall recipe should prepare \(servings) servings. Follow the schema: struct Recipe: Identifiable, Hashable, Encodable, Decodable { var id: UUID = .init() var name: String var description: String var tags: [String]? var images: [String]? var duration: String var calories: String var macrosPerServing: [[String]]? }"]
                                    mlRequestService.postRequest(urlString:url, parameters:parameters) { success in
                                        DispatchQueue.main.async {
                                            isLoading = false
                                            if success {
                                                withAnimation {
                                                    showResult = true
                                                }
                                            } else {
                                                print("try again")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .foregroundStyle(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.green.gradient)
                    .clipShape(.capsule)
                    .offset(y:(size.height/2 * 0.975))
//                    .shadow(color: .black.opacity(0.5), radius: 15)
                    .padding()
                }
                
                VStack {
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    NutritionFactsPickerView()
        .environmentObject(MLRequestService())
}
