//
//  ContentView.swift
//  ViewMaskingAnimation
//
//  Created by Martin on 05.05.23.
//

import SwiftUI

struct ContentView: View {
    @Namespace var namespace
    @State var fullScreen = false
    
    @State var maskFrameHeight: CGFloat = 100.0
    @State var maskOpacity: CGFloat = 0.0
    
    @StateObject var detailViewModel = DetailViewModel()
    
    var body: some View {
            ZStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        StatusCell(user: detailViewModel.users.first!, namespace: namespace, hidePicture: $detailViewModel.show)
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 1.0)){
                                    detailViewModel.present()
                                }
                            }
                        
                        StatusCell(user: detailViewModel.users.last!, namespace: namespace, hidePicture: .constant(false))
                        }
                    
        if detailViewModel.show{
                    GeometryReader { geo in
                        RectangleDetail(finalWidth: geo.size.width * 0.95, finalHeight: geo.size.height, namespace: namespace, user: detailViewModel.users.first!)
                    }
                }
            }
            .padding()
            
            .environmentObject(detailViewModel)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View {
  @inlinable
  public func reverseMask<Mask: View>(
    alignment: Alignment = .center,
    @ViewBuilder _ mask: () -> Mask
  ) -> some View {
    self.mask {
      Rectangle()
        .overlay(alignment: alignment) {
          mask()
            .blendMode(.destinationOut)
        }
    }
  }
}
