//
//  DetailViewModel.swift
//  ViewMaskingAnimation
//
//  Created by Martin on 09.05.23.
//

import Foundation
import SwiftUI

class DetailViewModel: ObservableObject{
    
    @Published var selectedImage: Image  = Image("zebra")
    
    @Published var show = false
    
    let users: [User] = [User(name: "Max Muster", imageName: "zebra"), User(name: "Lischen Müller", imageName: "blueberries", lastOnline: .seconds(7200))]
    
    func dismiss() {
        show = false
    }
    func present(){
        show = true
    }
}
