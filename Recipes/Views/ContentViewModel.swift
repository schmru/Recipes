//
//  ContentViewModel.swift
//  Recipes
//
//  Created by Miha on 25/09/2024.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var hitsList: [Hit] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var alertText = ""
    
    private let networkManager =  NetworkManager.shared
    
    /**
     Get data from server
     - Parameter searchText: Text to search recipes by
     */
    func getRecipes(searchText: String) {
        isLoading = true
        Task {
            do {
                let hits = try await networkManager.fetchData(searchText: searchText)
                DispatchQueue.main.async {
                    self.hitsList = hits
                    self.isLoading = false
                }
            } catch {
                self.isLoading = false
                self.alertText = "Something went wrong\n\n" + error.localizedDescription + "\n\nPlease try again later"
                self.showAlert = true
            }
        }
    }
}
