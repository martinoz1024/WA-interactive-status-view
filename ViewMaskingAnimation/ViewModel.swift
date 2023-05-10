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
       
        @Published var selectedUser: User? = nil
        @Published var hidePreviewImageOfSelecetedUser = false
        @Published var show = false
        
        let users: [User] = [.maxPersona, .lieschenPersona]
        
        func dismiss() {
            selectedUser = nil
            show = false
        }
        func present(){
            show = true
        }
        
        func selectUser(user: User){
            selectedUser = user
        }
        
        func hidePreviewImage(user: User) -> Bool {
            guard let selectedUser else{ return false}
            if selectedUser == user {
                return true
            }
            return false
        }
    }
}

