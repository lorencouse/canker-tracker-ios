//
//  YesNoSoreView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/7.
//

import Foundation
import SwiftUI

struct YesNoSoreView: View {
    @State private var activeCankerSores: Bool = false
    @State private var noActiveCankerSores: Bool = false
    
    var body: some View {
        VStack {
            Text("Do you currently have any Canker Sores?")
            HStack {
                CustomButton(buttonLabel: "Yes", action: { activeCankerSores = true })
                CustomButton(buttonLabel: "No", action: { noActiveCankerSores = true })
            }
            
            
            NavigationLink("", destination: MainMouthView(), isActive: $activeCankerSores)

        }
    }
}
