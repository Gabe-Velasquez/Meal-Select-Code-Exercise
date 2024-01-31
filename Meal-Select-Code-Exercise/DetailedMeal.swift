//
//  DetailedMeal.swift
//  Meal-Select-Code-Exercise
//
//  Created by Gabriel  Velasquez on 1/30/24.
//

import Foundation

struct MealDetail: Hashable, Codable, Equatable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    let ingredients: [(String, String)]
    
    private enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strMealThumb
        case strInstructions
        // Add coding keys if you have more properties
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.idMeal = try container.decode(String.self, forKey: .idMeal)
        self.strMeal = try container.decode(String.self, forKey: .strMeal)
        self.strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        self.strInstructions = try container.decode(String.self, forKey: .strInstructions)
        
        // Initialize ingredients property with the constructed array
        self.ingredients = {
            var ingredientsArray: [(String, String)] = []
            
            for index in 1...20 {
                let ingredientKey = "strIngredient\(index)"
                let measureKey = "strMeasure\(index)"
                
                if let ingredientCodingKey = CodingKeys(rawValue: ingredientKey),
                   let measureCodingKey = CodingKeys(rawValue: measureKey) {
                    if let ingredient = try? container.decode(String.self, forKey: ingredientCodingKey),
                       let measure = try? container.decode(String.self, forKey: measureCodingKey) {
                        ingredientsArray.append((ingredient, measure))
                    }
                }
            }
            return ingredientsArray
        }()
    }
    static func == (lhs: MealDetail, rhs: MealDetail) -> Bool {
            return lhs.idMeal == rhs.idMeal &&
                   lhs.strMeal == rhs.strMeal &&
                   lhs.strMealThumb == rhs.strMealThumb &&
                   lhs.strInstructions == rhs.strInstructions &&
                    lhs.ingredients.elementsEqual(rhs.ingredients, by: ==)
        }
    func hash(into hasher: inout Hasher) {
            hasher.combine(idMeal)
            hasher.combine(strMeal)
            hasher.combine(strMealThumb)
            hasher.combine(strInstructions)
            for (ingredient, measure) in ingredients {
                hasher.combine(ingredient)
                hasher.combine(measure)
            }
        }
}

class MealDetailView: View {
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
