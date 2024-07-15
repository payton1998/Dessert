//
//  NetworkManager.swift
//  Dessert
//
//  Created by Payton Mitchell on 7/14/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchDesserts(completion: @escaping ([Meal]) -> Void) {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let response = try JSONDecoder().decode(MealsResponse.self, from: data)
                if let meals = response.meals {
                    DispatchQueue.main.async {
                        completion(meals.sorted { $0.strMeal < $1.strMeal })
                    }
                }
            }
            catch {
                print("Error \(error)")
            }
        }.resume()
    }
    
    func fetchMealDetail(id: String, completion: @escaping (MealDetail?) -> Void) {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let response = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                if let mealDetail = response.meals?.first {
                    DispatchQueue.main.async {
                        completion(mealDetail)
                    }
                }
            }
            catch {
                print("Error \(error)")
            }
        }.resume()
    }
}

