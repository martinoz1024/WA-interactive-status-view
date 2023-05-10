//
//  DetailViewModel.swift
//  ViewMaskingAnimation
//
//  Created by Martin on 09.05.23.
//

import Foundation
import SwiftUI

extension ContentView {
    class ViewModel: ObservableObject{
        
        @Published var selectedImage: Image  = Image("zebra")
        
        @Published var show = false
        
        let users: [User] = [.maxPersona, .lieschenPersona]
        
        func dismiss() {
            show = false
        }
        func present(){
            show = true
        }
    }
}

