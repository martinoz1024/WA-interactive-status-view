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
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
            ZStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        StatusCell(user: viewModel.users.first!, namespace: namespace, hidePicture: $viewModel.show)
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 1.0)){
                                    viewModel.present()
                                }
                            }
                        
                        StatusCell(user: viewModel.users.last!, namespace: namespace, hidePicture: .constant(false))
                        }
                    
        if viewModel.show{
                    GeometryReader { geo in
                        RectangleDetail(finalWidth: geo.size.width * 0.95, finalHeight: geo.size.height, namespace: namespace, user: viewModel.users.first!, dismissAction: {
                            viewModel.dismiss()
                        })
                    }
                }
            }
            .padding()
            
            .environmentObject(viewModel)
        
        
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
