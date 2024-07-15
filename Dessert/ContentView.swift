//
//  ContentView.swift
//  Dessert
//
//  Created by Payton Mitchell on 7/14/24.
//

import SwiftUI

struct ContentView: View {
    @State private var desserts: [Meal] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(desserts, id: \.idMeal) { dessert in
                    NavigationLink(destination: MealDetailView(mealID: dessert.idMeal)) {
                        HStack {
                            AsyncImage(url: URL(string: dessert.strMealThumb)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50) // Set desired image size
                            } placeholder: {
                                ProgressView() // Loading indicator
                            }
                            
                            Text(dessert.strMeal)
                                .font(.headline)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Desserts")
                        .font(.headline)
                }
            }
            .onAppear {
                NetworkManager.shared.fetchDesserts { meals in
                    self.desserts = meals
                }
            }
        }
    }
}
