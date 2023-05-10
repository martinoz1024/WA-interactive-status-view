//
//  RectangleDetail.swift
//  ViewMaskingAnimation
//
//  Created by Martin on 05.05.23.
//

import Foundation
import SwiftUI

struct RectangleDetail: View{
    
    var finalWidth: CGFloat
    var finalHeight: CGFloat
    let namespace: Namespace.ID
    let user: User
    var animationDuration: CGFloat = 1.0
    @State var maskFrameHeight: CGFloat = 150.0
    @State var maskOpacity: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    
    @State var scale: CGFloat = 1
    
    @EnvironmentObject var viewModel: DetailViewModel
    
    
    var body: some View{
        GeometryReader { geo in
            VStack(alignment: .center) {
                Image(user.imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                    .offset(CGSize(width: offset.width * 0.5, height: offset.height * 0.5))
                    .mask {
                        if geo.size.width < finalWidth{
                            Circle()
                                .clipped()
                                .opacity(maskOpacity)
                        }
                        else{
                            Circle()
                                .frame(width:  maskFrameHeight, height:   maskFrameHeight)
                                .opacity(maskOpacity)
                                .onAppear {
                                    maskFrameHeight = finalHeight
                                    //animate(maxheight: finalHeight * 1.2)
                                }
                        }
                    }
                    .background(Color.clear)
                    .matchedGeometryEffect(id: user, in: namespace)
                    .frame(width: geo.size.width, height: geo.size.height)
            }
            
        }
        .scaleEffect(scale)
        .offset(offset)
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
        
        if 1 - scale > 0.8{
            self.scale = 1 - scale
            self.offset.width = value.translation.width / 10
            self.offset.height = value.translation.height / 10
        }
        
    }
    
    func onEnded(value: DragGesture.Value){
        withAnimation(.spring()){
            if scale < 0.9{
                viewModel.dismiss()
                return
            }
            scale = 1
            maskFrameHeight = finalHeight
            offset = .zero
            
        }
    }
}

extension View {
    func circularShape(){
        
    }
}

struct rectanglePreview: PreviewProvider{
    @Namespace static var test
    @StateObject static var detailViewModel = DetailViewModel()
    static var previews: some View {
        RectangleDetail(finalWidth: 400, finalHeight: 800.0, namespace: test, user: User(name: "", imageName: "zebra"))
            .environmentObject(detailViewModel)
    }
    
    
}
