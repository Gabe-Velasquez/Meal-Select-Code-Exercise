//
//  Meals.swift
//  Meal-Select-Code-Exercise
//
//  Created by Gabriel  Velasquez on 1/26/24.
//

import Foundation
import SwiftUI
//
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

