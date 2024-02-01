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
    @State private var selectedMeal: Meal? = nil
    @State private var isShowingModal = false
    @State private var mealInstructions: String = ""
    @State private var ingredients: [String] = []
    @State private var selectedMealDetail: MealDetail? = nil
    


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
                    mealFetch.fetchMeals(selectedOption: selectedOption, options: options) { fetchedMeals in
                        self.meals = fetchedMeals
                    }
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
                                            fetchMealDetails(for: meal.idMeal)
                                            isShowingModal = true
                                        }
                                }
                                Text(meal.strMeal)
                                    .onTapGesture {
                                        selectedMeal = meal
                                        fetchMealDetails(for: meal.idMeal)
                                        isShowingModal = true
                                    }
                            }
                        }
                    }
                }
            }
            .frame(width: 300)
            .sheet(isPresented: $isShowingModal) {
                if let selectedMealDetail = selectedMealDetail {
                    MealDetailView(mealDetail: selectedMealDetail)
                }
            }
        }

    func fetchMealDetails(for mealID: String) {
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
                let response = try JSONDecoder().decode(MealDetail.self, from: data)
                DispatchQueue.main.async {
                    // Present MealDetailView with the fetched meal detail
                    isShowingModal = true
                    self.selectedMealDetail = response
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
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
    let meals: [MealDetail]
}

struct MealInstructions: Decodable {
    let strInstructions: String
}

struct MealDetail: Decodable {
    let id: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?

        var ingredients: [(String, String)] {
            var ingredientsArray: [(String, String)] = []

            // Add ingredients and their measures to the array
            if let ingredient1 = strIngredient1, let measure1 = strMeasure1, !ingredient1.isEmpty {
                ingredientsArray.append((ingredient1, measure1))
            }
            if let ingredient2 = strIngredient2, let measure2 = strMeasure2, !ingredient2.isEmpty {
                ingredientsArray.append((ingredient2, measure2))
            }
            if let ingredient3 = strIngredient3, let measure3 = strMeasure3, !ingredient3.isEmpty {
                ingredientsArray.append((ingredient3, measure3))
            }
            // Repeat for all ingredients and measures

            return ingredientsArray
        }
//    enum CodingKeys: String, CodingKey{
//        case idMeal
//        case strMeal
//        case strMealThumb
//        case strInstructions
//        case strIngredient1
//        case strIngredient2
//        case strIngredient3
//        case strIngredient4
//        case strIngredient5
//        case strIngredient6
//        case strIngredient7
//        case strIngredient8
//        case strIngredient9
//        case strIngredient10
//        case strIngredient11
//        case strIngredient12
//        case strIngredient13
//        case strIngredient14
//        case strIngredient15
//        case strIngredient16
//        case strIngredient17
//        case strIngredient18
//        case strIngredient19
//        case strIngredient20
//        case strMeasure1
//        case strMeasure2
//        case strMeasure3
//        case strMeasure4
//        case strMeasure5
//        case strMeasure6
//        case strMeasure7
//        case strMeasure8
//        case strMeasure9
//        case strMeasure10
//        case strMeasure11
//        case strMeasure12
//        case strMeasure13
//        case strMeasure14
//        case strMeasure15
//        case strMeasure16
//        case strMeasure17
//        case strMeasure18
//        case strMeasure19
//        case strMeasure20
//    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(String.self, forKey: .idMeal)
//        strMeal = try container.decode(String.self, forKey: .strMeal)
//        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
//        strInstructions = try container.decode(String.self, forKey: .strInstructions)
//        strIngredient1 = try container.decodeIfPresent(String.self, forKey: .strIngredient1)
//        strIngredient2 = try container.decodeIfPresent(String.self, forKey: .strIngredient2)
//        strIngredient3 = try container.decodeIfPresent(String.self, forKey: .strIngredient3)
//        strIngredient4 = try container.decodeIfPresent(String.self, forKey: .strIngredient4)
//        strIngredient5 = try container.decodeIfPresent(String.self, forKey: .strIngredient5)
//        strIngredient6 = try container.decodeIfPresent(String.self, forKey: .strIngredient6)
//        strIngredient7 = try container.decodeIfPresent(String.self, forKey: .strIngredient7)
//        strIngredient8 = try container.decodeIfPresent(String.self, forKey: .strIngredient8)
//        strIngredient9 = try container.decodeIfPresent(String.self, forKey: .strIngredient9)
//        strIngredient10 = try container.decodeIfPresent(String.self, forKey: .strIngredient10)
//        strIngredient11 = try container.decodeIfPresent(String.self, forKey: .strIngredient11)
//        strIngredient12 = try container.decodeIfPresent(String.self, forKey: .strIngredient12)
//        strIngredient13 = try container.decodeIfPresent(String.self, forKey: .strIngredient13)
//        strIngredient14 = try container.decodeIfPresent(String.self, forKey: .strIngredient14)
//        strIngredient15 = try container.decodeIfPresent(String.self, forKey: .strIngredient15)
//        strIngredient16 = try container.decodeIfPresent(String.self, forKey: .strIngredient16)
//        strIngredient17 = try container.decodeIfPresent(String.self, forKey: .strIngredient17)
//        strIngredient18 = try container.decodeIfPresent(String.self, forKey: .strIngredient18)
//        strIngredient19 = try container.decodeIfPresent(String.self, forKey: .strIngredient19)
//        strIngredient20 = try container.decodeIfPresent(String.self, forKey: .strIngredient20)
//    }
}

struct MealDetailView: View {
    let mealDetail: MealDetail

    var body: some View {
        ScrollView {
            VStack {
                Text("Meal Details")
                    .font(.title)
                    .padding()

                Text(mealDetail.strMeal)
                    .font(.headline)

                Text("Ingredients:")
                    .font(.headline)
                    .padding(.top, 10)

                ForEach(mealDetail.ingredients, id: \.0) { ingredient, measure in
                    Text("\(measure) \(ingredient)")
                }

                Text("Instructions:")
                    .font(.headline)
                    .padding(.top, 10)

                Text(mealDetail.strInstructions)
                    .padding()
            }
            .padding()
        }
    }
}
