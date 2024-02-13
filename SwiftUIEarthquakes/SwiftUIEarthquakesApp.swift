//
//  SwiftUIEarthquakesApp.swift
//  SwiftUIEarthquakes
//
//  Created by Alexey Dubovik on 13.02.24.
//

import SwiftUI

@main
struct SwiftUIEarthquakesApp: App {
    @StateObject var quakesProvider = QuakesProvider()
    var body: some Scene {
        WindowGroup {
            Quakes()
                .environmentObject(quakesProvider)
        }
    }
}
