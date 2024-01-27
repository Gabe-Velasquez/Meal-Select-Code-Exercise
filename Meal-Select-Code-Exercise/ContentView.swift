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
                ScrollView{
                    VStack {
                        ForEach(meals) { (meal: Meal) in
                            Text(meal.strMeal)
                                .padding()
                        }
                    }
                }
            }
            .frame(width: 300)
        }

        func fetchMeals() {
            let selectedOptionString = options[selectedOption].lowercased()
            let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=\(selectedOptionString)"
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
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

    struct Meal: Decodable, Identifiable {
        let idMeal: String
        let strMeal: String
        var id: String {idMeal}
    }

    struct MealsResponse: Decodable {
        let meals: [Meal]
    }
