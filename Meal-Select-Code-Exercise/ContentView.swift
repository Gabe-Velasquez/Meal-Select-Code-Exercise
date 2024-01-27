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
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("What sounds good to eat?")
                .bold()
                .padding(10)
            Picker(selection: $selectedOption, label: Text("Select a Category")) {
                            ForEach(0..<options.count) { index in
                                Text(self.options[index]).tag(index);
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
                            .padding()
        }
        
        func fetchMeals() {
            let selectedOption = options[selectedOption]; else {
                return
            }
            let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=\(selectedOption)"
            guard let url = URL(string: urlString) else {
                return
            }
            URLSession.shared.dataTask(with: url){data, response, error in
                guard let data = data,error == nil else{
                    print("Error: \(error?.localizedDescription ?? "Unkown error")")
                    return
                }
            }
        }
//        NavigationView{
//            List{
//                ForEach(viewModel.meals, id:\.self){ meal in
//                    HStack{
//                        Image("")
//                            .frame(width:120, height:55)
//                            .background(Color.gray)
//                        Text(meal.name)
//                            .bold()
//                    }
//                }
//            }
//            .navigationTitle("Meals")
//            .onAppear(){
//                viewModel.fetch()
//            }
//        }
        
        Spacer()
    }
}

#Preview {
    ContentView()
}
