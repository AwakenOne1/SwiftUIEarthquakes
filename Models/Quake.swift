//
//  Quake.swift
//  SwiftUIEarthquakes
//
//  Created by Alexey Dubovik on 13.02.24.
//

import Foundation

struct Quake {
    let magnitude: Double
    let place: String
    let time: Date
    let code: String
    let detail: URL
}

extension Quake: Identifiable {
    var id: String { code }
}
