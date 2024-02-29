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

struct GreyedOutButton: View {
    var body: some View {
        VStack {
            Button("Select Location") {}
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(10)
        }
        .padding()
        
    }
}

