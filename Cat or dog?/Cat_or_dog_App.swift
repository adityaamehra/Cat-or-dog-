//
//  Cat_or_dog_App.swift
//  Cat or dog?
//
//  Created by Adityaa Mehra on 12/07/21.
//

import SwiftUI

@main
struct Cat_or_dog_App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(model: AnimalModel())
        }
    }
}
