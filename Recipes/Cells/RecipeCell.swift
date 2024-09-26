//
//  RecipeCell.swift
//  Recipes
//
//  Created by Miha on 25/09/2024.
//

import SwiftUI

struct RecipeCell: View {
    let recipe: Recipe
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: recipe.images.thumbnail.url)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Text("Loading...")
            }
            .frame(width: 100, height: 100)
            
            Text(recipe.label)
        }
    }
}

struct RecipeCell_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCell(recipe: Recipe.getMockRecepie())
    }
}
