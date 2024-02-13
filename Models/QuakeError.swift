//
//  QuakeError.swift
//  SwiftUIEarthquakes
//
//  Created by Alexey Dubovik on 13.02.24.
//

import Foundation

enum QuakeError {
    case missingData
}

extension QuakeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString(
                "Found and will discard a quake missing a valid code, magnitude, place, or time.",
                comment: ""
            )
        }
    }
}
