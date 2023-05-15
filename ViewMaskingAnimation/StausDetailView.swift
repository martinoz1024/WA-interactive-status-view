//
//  StatusDetailView.swift
//  ViewMaskingAnimation
//
//  Created by Martin on 05.05.23.
//

import Foundation
import SwiftUI

struct StausDetailView: View{
    
    var finalWidth: CGFloat
    var finalHeight: CGFloat
    let namespace: Namespace.ID
    let user: User
    var animationDuration: CGFloat = 0.2
    let dismissAction: (()->Void)?
    @State var maskFrameHeight: CGFloat = 150.0
    @State var maskOpacity: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    
    @State var scale: CGFloat = 1
    
    
    var body: some View{
        
            GeometryReader { geo in
                ZStack {
                    Image(user.imageName)
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.vertical)
                    
                    Rectangle()
                        .background(
                            Material.thin
                        )
                        .edgesIgnoringSafeArea(.vertical)
                    VStack(alignment: .center) {
                        Image(user.imageName)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(15)
                            .offset(CGSize(width: offset.width * 0.5, height: offset.height * 0.5))
                        .matchedGeometryEffect(id: user, in: namespace)
                            .frame(width: geo.size.width)
                    }
                }
                .mask {
                    
                    /*if geo.size.width < finalWidth{
                        Circle()
                            .clipped()
                            .opacity(maskOpacity)
                    }*/
                    if geo.size.width >= finalWidth{
                        Circle()
                            .frame(width:  maskFrameHeight, height:   maskFrameHeight)
                            .opacity(maskOpacity)
                            .onAppear {
                                maskFrameHeight = finalHeight * 1.2
                                //animate(maxheight: finalHeight * 1.2)
                            }
                    }
                }
                .background(Color.clear)
                .scaleEffect(scale)
                .offset(offset)
                .frame(width: geo.size.width, height: geo.size.height)
                
                
            }
            
            .gesture(DragGesture(minimumDistance: 0).onChanged(onChange(value:)).onEnded(onEnded(value:)))
            
        
        
        
    }
    
    private func animate(maxheight: CGFloat){
        withAnimation(.easeInOut(duration: animationDuration)){
            maskFrameHeight = maxheight
        }
    }
    
    func diameter(proxy: GeometryProxy) -> CGFloat{
        return proxy.size.width
    }
    
    func onChange(value: DragGesture.Value){

        let velocity = abs(value.predictedEndLocation.y - value.location.y)
        
        if value.translation.height < 0 && self.scale  >= 1{
            if maskFrameHeight >= finalWidth{
                maskFrameHeight = min(maskFrameHeight + 20 * velocity * 0.01, finalHeight)
                return
            }
            return
        }
        print("height: \(value.translation.height)")
        print("velocity: \(velocity)")
        
        if maskFrameHeight > finalWidth{
            maskFrameHeight = max(maskFrameHeight - 20 * velocity * 0.1, finalWidth)
            return
        }
        
        let scale = value.translation.height / UIScreen.main.bounds.height * 0.66
        
        if 1 - scale > 0.4{
            self.scale = 1 - scale
            self.offset.width = value.translation.width / 5
            self.offset.height = value.translation.height / 5
        }
        
    }
    
    func onEnded(value: DragGesture.Value){
        withAnimation(.spring()){
            if scale < 0.9{
                dismissAction?()
                return
            }
            scale = 1
            maskFrameHeight = finalHeight * 1.2
            offset = .zero
            
        }
    }
}

extension View {
    func circularShape(){
        
    }
}

struct statusPreview: PreviewProvider{
    @Namespace static var test
    static var previews: some View {
        StausDetailView(finalWidth: 390, finalHeight: 800.0, namespace: test, user: User(name: "", imageName: "zebra"), dismissAction: nil)
    }
    
    
}
