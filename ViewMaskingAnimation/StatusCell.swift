//
//  StatusCell.swift
//  ViewMaskingAnimation
//
//  Created by Martin on 09.05.23.
//

import Foundation

import SwiftUI

struct StatusCell: View {
    
    let user: User
    let namespace: Namespace.ID
    var hidePicture: Bool
    
    
    var body: some View {
        HStack{
            ZStack{
                Circle()
                    .strokeBorder(.gray, lineWidth: 1.5)
                    .foregroundColor(.clear)
                    .frame(width: 105, height: 105)
                    
                if !hidePicture{
                    Image(user.imageName)
                        .resizable()
                        .scaledToFill()
                        .clipShape(
                            Circle())
                        .matchedGeometryEffect(id: user, in: namespace)
                        .frame(width: 100, height: 100)
                }
                else{
                    Circle()
                        .foregroundColor(.clear)
                        .frame(width: 100, height: 100)
                }
            }
            VStack(alignment: .leading, spacing: 5, content: {
                Text(user.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("last online \(user.lastOnline.formatted())h ago")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .fontWeight(.light)
            })
        }
    }
}
