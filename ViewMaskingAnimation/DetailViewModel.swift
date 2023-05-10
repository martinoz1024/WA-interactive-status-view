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
    
    let users: [User] = [.max, .lischen]
    
    func dismiss() {
        show = false
    }
    func present(){
        show = true
    }
}
