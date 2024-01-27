//
//  ContentView.swift
//  Meal-Select-Code-Exercise
//
//  Created by Gabriel  Velasquez on 1/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedOption = 0
    let options = [
        "Beef", "Breakfast", "Chicken", "Goat", "Lamb",
        "Miscellaneous", "Pasta", "Pork", "Seafood", "Side",
        "Starter", "Vegan", "Vegetarian"
    ]
    @State private var meals: [Meal] = []
    @State private var selectedMeal: Meal? = nil
    @State private var isShowingModal = false
    @State private var mealInstructions: String = ""
    @State private var mealIngredients: [String] = []

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
                fetchMeals()
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
                    ForEach(meals) { meal in
                        VStack{
                            
                            if let url = URL(string: meal.strMealThumb),
                               let imageData = try? Data(contentsOf: url),
                               let uiImage = UIImage(data: imageData){
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height:100)
                                    .onTapGesture {
                                        selectedMeal = meal
                                        fetchInstructions(for: meal.idMeal)
                                        isShowingModal.toggle()
                                    }
                            }
                            Text(meal.strMeal)
                                .onTapGesture {
                                    selectedMeal = meal
                                    fetchInstructions(for: meal.idMeal)
                                    isShowingModal.toggle()
                                }
                        }
                    }
                }
            }
        }
        .frame(width: 350)
        .sheet(isPresented: $isShowingModal) {
            if let selectedMeal = selectedMeal {
                MealDetailView(meal: selectedMeal, ingredients: mealIngredients, instructions: mealInstructions )
            }
        }
    }

    func fetchMeals() {
        let selectedOptionString = options[selectedOption].lowercased()
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(selectedOptionString)"
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let response = try JSONDecoder().decode(MealsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.meals = response.meals.sorted(by: {$0.strMeal < $1.strMeal})
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }

    func fetchInstructions(for mealID: String) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let response = try JSONDecoder().decode(MealInstructionsResponse.self, from: data)
                if let meal = response.meals.first {
                    DispatchQueue.main.async {
                        self.mealInstructions = meal.strInstructions
                        self.mealIngredients = meal.ingredients
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Meal: Decodable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    var id: String { idMeal }
}

struct MealsResponse: Decodable {
    let meals: [Meal]
}

struct MealInstructionsResponse: Decodable {
    let meals: [MealInstructions]
}

struct MealInstructions: Decodable {
    let strInstructions: String
    let ingredients:[String]
}

struct MealDetailView: View {
    let meal: Meal
    let ingredients: [String]
    let instructions: String

    var body: some View {
        VStack {
            Text("Meal Details")
                .font(.title)
                .padding()

            Text(meal.strMeal)
                .font(.headline)
            
            Text("Ingredients:")
            ForEach(0..<ingredients.count, id: \.self) { index in
                Text(ingredients[index])
                    .padding(.leading)
            }

            Text("Instructions:")
            Text(instructions)
                .padding()
        }
    }
}
