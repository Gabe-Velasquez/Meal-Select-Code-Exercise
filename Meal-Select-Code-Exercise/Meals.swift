//
//  Meals.swift
//  Meal-Select-Code-Exercise
//
//  Created by Gabriel  Velasquez on 1/26/24.
//

import Foundation
import SwiftUI

class mealFetch{
    static func fetchMeals(selectedOption: Int, options: [String], completion: @escaping([Meal]) -> Void) {
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
                    completion(response.meals.sorted(by: { $0.strMeal < $1.strMeal }))
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
