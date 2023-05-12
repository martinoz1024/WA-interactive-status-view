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
    let circleRadius: CGFloat = 80
    var borderColor: Color = .gray
    
    private var borderWith: CGFloat {
        return circleRadius / 100 * 1.5
    }
    
    private var borderRadius: CGFloat {
        return circleRadius * 1.1
    }
    
    
    var body: some View {
        HStack{
            ZStack{
                Circle()
                    .strokeBorder(borderColor, lineWidth: borderWith)
                    .foregroundColor(.clear)
                    .frame(width: borderRadius, height: borderRadius)
                    
                if !hidePicture{
                    Image(user.imageName)
                        .resizable()
                        .scaledToFill()
                        .clipShape(
                            Circle())
                        .matchedGeometryEffect(id: user, in: namespace)
                        .frame(width: circleRadius, height: circleRadius)
                }
                else{
                    Circle()
                        .foregroundColor(.clear)
                        .frame(width: circleRadius, height: circleRadius)
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
