//
//  Remoteimage.swift
//  Meal-Select-Code-Exercise
//
//  Created by Gabriel  Velasquez on 1/26/24.
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    @State var data: Data?
    
    var body: some View{
        if let data = data, let uiimage = UIImage(data: data){
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: 130, height: 75)
                .background(Color.mint)
        }else{
            Image("")
                .resizable()
                .frame(width: 130, height: 75)
                .background(Color.mint)
                .onAppear{
                    fetchData()
                }
        }
    }
    private func fetchData(){
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    self.data = data
                } else {
                    print("Error fetching image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        task.resume()
    }
}
