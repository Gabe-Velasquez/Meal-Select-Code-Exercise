//
//  Meals.swift
//  Meal-Select-Code-Exercise
//
//  Created by Gabriel  Velasquez on 1/26/24.
//

import Foundation
import SwiftUI

struct Meal: Hashable, Codable, Identifiable {
    let id: String?
    let strMeal: String
    let strMealThumb: String
}

struct MealsResponse: Codable {
    let meals: [Meal]
}

class ViewModel: ObservableObject{
    @Published var meals: [Meal] = []
    @Published var selectedOptionIndex = 0
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

    func fetchMeals() {
        let selectedOptionString = options[selectedOptionIndex].lowercased()
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(selectedOptionString)"
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON data: \(jsonString)")
            }
            do {
                let response = try JSONDecoder().decode(MealsResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.meals = response.meals.sorted(by: { $0.strMeal < $1.strMeal })
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }

}

//struct Meal: Hashable, Codable{
//        let idMeal: Int
//        let strMeal: String
//        let strCategory: String
//        let strArea: String
//        let strInstructions: String
//        let strMealThumb: String
//        let strTags: String
//        let strYoutube: String
//        let strIngredient: String
//        let strMeasure: String
//}
//
//class ViewModel: ObservableObject{
//    @Published var meals: [Meal] = []
//    
//    func fetch(){
//        guard let url = URL(string:
//            "www.themealdb.com/api/json/v1/1/lookup.php?i=52772")else{
//            return
//        }
//        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _,
//            error in
//            guard let data=data,error==nil else{
//                return
//            }
//            do{
//                let meals=try JSONDecoder().decode([Meal].self,
//                    from:data)
//                DispatchQueue.main.async{
//                    self?.meals = meals
//                }
//            }catch{
//                print(error)
//            }
//        }
//        task.resume()
//    }
//}

