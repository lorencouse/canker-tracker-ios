//
//  NavigationButton.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/2/29.
//

import Foundation
import SwiftUI

struct NavigationButton<Destination: View>: View {
    var destination: Destination
    var label: String
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Spacer()
                Text(label)
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
        }
        .padding()
    }
}

struct CustomButton: View {
    let buttonLabel: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
                Text(buttonLabel)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        .padding()
    }
}

