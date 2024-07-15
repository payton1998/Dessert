import SwiftUI

struct MealDetailView: View {
    let mealID: String
    @State private var mealDetail: MealDetail?

    var body: some View {
        VStack {
            ScrollView {
                if let mealDetail = mealDetail {
                    Text(mealDetail.strMeal)
                        .font(.largeTitle)
                    
                    AsyncImage(url: URL(string: mealDetail.strMealThumb)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    } placeholder: {
                        ProgressView() 
                    }
                    
                    Text("Instructions: \(mealDetail.strInstructions)")
                        .padding(.leading)
                        .font(.body)
                    
                    Text("Ingredients:")
                        .font(.headline)
                        .padding(.top)
                    
                    ForEach(1...20, id: \.self) { index in
                        let ingredient = mealDetail.getIngredient(at: index)
                        let measurement = mealDetail.getMeasurement(at: index)
                        
                        if let ingredient = ingredient, !ingredient.isEmpty {
                            Text("- \(ingredient) (\(measurement ?? ""))")
                        }
                    }
                } else {
                    Text("Loading...")
                }
            }
            .toolbar {
                    Text(mealDetail?.strMeal ?? "Meal Detail")
                        .font(.headline)
            }
        }
        .onAppear {
            NetworkManager.shared.fetchMealDetail(id: mealID) { detail in
                self.mealDetail = detail
            }
        }
    }
}
