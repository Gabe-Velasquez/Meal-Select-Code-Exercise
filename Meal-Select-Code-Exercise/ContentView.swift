//
//  ContentView.swift
//  Meal-Select-Code-Exercise
//
//  Created by Gabriel  Velasquez on 1/26/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var selectedOption = 0
    
    let options = [
        "Beef", 
        "Breakfast",
        "Chicken",
        "Goat",
        "Lamb",
        "Miscellaneous",
        "Pasta",
        "Pork",
        "Seafood",
        "Side",
        "Starter",
        "Vegan",
        "Vegetarian"
    ]
    @State private var meals: [Meal] = []
    @State private var selectedMeal: Meal? = nil
//    @State private var isShowingModal = false
//    @State private var mealInstructions: String = ""
//    @State private var ingredients: [String] = []
//    @State private var selectedMealDetail: MealDetail? = nil


    var body: some View {
        VStack {
            Text("What sounds good to eat?")
                .bold()
                .padding(10)
            Picker(selection: $selectedOption, label: Text("Select a Category")) {
                ForEach(0..<options.count, id: \.self) { index in
                    Text(self.options[index])
                }
            }
            .pickerStyle(MenuPickerStyle())
            Button(action: {
                viewModel.fetchMeals()
            }) {
                Text("Submit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Text("Selected Option: \(options[selectedOption])")
            
            Spacer()
            Divider()
            ScrollView {
                VStack {
                    List(viewModel.meals) { meal in
                        HStack {
//                            URLImage(urlString: meal.strMealThumb)
//                                .frame(width: 50, height: 50)
//                                .cornerRadius(8)
//                                .onTapGesture {
//                                    isShowingModal = true
//                                }
                            Text(meal.strMeal)
//                                .onTapGesture {
//                                    isShowingModal = true
//                                }
                            Spacer()
                        }
                    }
                }
                .frame(width: 300)
//                .sheet(isPresented: $isShowingModal) {
//                    if let selectedMealDetail = selectedMealDetail {
//                        MealDetailView(mealDetail: selectedMealDetail)
//                    }
//                }
            }
        }
    }
}

//func fetchMealDetails(for mealID: String, isShowingModal: Binding<Bool>) {
//    let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
//    guard let url = URL(string: urlString) else {
//        return
//    }
//
//    URLSession.shared.dataTask(with: url) { [weak self] data, response, error in // Capture self weakly
//        guard let self = self else { return } // Unwrap weak self
//
//        guard let data = data, error == nil else {
//            print("Error: \(error?.localizedDescription ?? "Unknown error")")
//            return
//        }
//
//        do {
//            let response = try JSONDecoder().decode(MealDetail.self, from: data)
//            DispatchQueue.main.async { // Update UI on main thread
//                isShowingModal.wrappedValue = true
//                self.selectedMealDetail = response // Access self's properties
//            }
//        } catch {
//            print("Error decoding JSON: \(error)")
//        }
//    }.resume()
//}



