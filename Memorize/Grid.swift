//
//  Grid.swift
//  Memorize
//
//  Created by Eric Hou on 10/4/20.
//

import SwiftUI

// Using protocols to constrain generics
struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    // Detect and avoid memory cycles with the @escaping
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        // Figure out how much space has been allocated with the view
        GeometryReader { geometry in
            // GeometryReader is escaping so we need self.body
            self.body(for: geometry.size)
        }
    }
    
    // func so we can access self thats within scope
    func body(for size: CGSize) -> some View {
        ForEach(items) { item in
            // ForEach is escaping so we need self.body
            self.body(for: item, in: size)
        }
    }
    
    // func so we dont need self
    func body(for item: Item, in size: CGSize) -> some View {
        return viewForItem(item)
    }
}
