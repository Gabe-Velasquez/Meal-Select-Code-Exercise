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
            Picker(selection: $selectedOption, label: Text("Select an option")) {
                            ForEach(0..<options.count) { index in
                                Text(self.options[index]).tag(index)
                            }
                        }
                        .pickerStyle(MenuPickerStyle()) // Apply MenuPickerStyle to make it look like a dropdown menu

                        Text("Selected Option: \(options[selectedOption])")
                            .padding()
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
