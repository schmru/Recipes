//
//  ContentView.swift
//  Recipes
//
//  Created by Miha on 24/09/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State var searchText: String = ""
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack {
                TextField("Enter your recipe", text: $searchText)
                    .padding(12)
                    .background(.yellow,
                                in: RoundedRectangle(cornerRadius: 12))
                    .accessibilityIdentifier("SearchInput")
                
                Button(role: .destructive,
                       action: {viewModel.getRecipes(searchText: searchText)},
                       label: {
                    Label("Search", systemImage: "magnifyingglass")
                })
                    .padding(12)
                    .foregroundColor(.black)
                    .background(.yellow,
                                in: RoundedRectangle(cornerRadius: 12))
                    .accessibilityIdentifier("SearchButton")
            }
            .padding(.horizontal, 16.0)
            if viewModel.isLoading {
                Spacer()
                ProgressView()
            } else {
                if viewModel.hitsList.isEmpty {
                    Spacer()
                    Text("No recipes to show")
                } else {
                    List {
                        ForEach(viewModel.hitsList, id: \.self) { hit in
                            RecipeCell(recipe: .init(label: hit.recipe.label,
                                                     image: hit.recipe.image))
                        }
                    }
                    .onAppear(perform: {
                        UITableView.appearance().contentInset.top = -35
                        UITableView.appearance().contentInset.bottom = -35
                    })
                    .accessibilityIdentifier("RecipesList")
                }
            }
            Spacer()
            
        }
        .padding(.top, 16.0)
        .alert(viewModel.alertText, isPresented: $viewModel.showAlert) {
                    Button("OK", role: .cancel) { }
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
