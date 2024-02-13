//
//  QuakeMagnitude.swift
//  SwiftUIEarthquakes
//
//  Created by Alexey Dubovik on 13.02.24.
//

import SwiftUI

struct QuakeMagnitude: View {
    var quake: Quake

    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.black)
            .frame(width: 80, height: 60)
            .overlay {
                Text("\(quake.magnitude.formatted(.number.precision(.fractionLength(1))))")
                    .font(.title)
                    .bold()
                    .foregroundStyle(quake.color)
            }
    }
}

