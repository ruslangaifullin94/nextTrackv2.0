//
//  ContentView.swift
//  task4
//
//  Created by Руслан Гайфуллин on 10.10.2023.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var namespace
    
    private let playImageName = "play.fill"
    
    private let matchedGeometryId = "Play"
    
    @State private var isAnimate = false
    var size: CGFloat = 45
    var duration = 0.22
    var scale = 0.86
    var color = Color.gray
    
    var body: some View {
        Button {
            withAnimation(.interpolatingSpring(stiffness: 100, damping: 10)) {
                isAnimate.toggle()
            } completion: {
                isAnimate.toggle()
            }
        } label: {
            ZStack {
                Image(systemName: playImageName)
                    .font(.system(size: 40))
                    .scaleEffect(isAnimate ? 1 : 0)
                    .opacity(isAnimate ? 1 : 0.5)
                    .offset(x: 0)
                    .matchedGeometryEffect(id: matchedGeometryId, in: namespace)
                Image(systemName: playImageName)
                    .font(.system(size: 40))
                    .offset(x: isAnimate ? 30 : 0)
                    .matchedGeometryEffect(id: matchedGeometryId, in: namespace)
                Image(systemName: playImageName)
                    .font(.system(size: 40))
                    
                    .scaleEffect(isAnimate ? 0 : 1)
                    .offset(x: 30)
                    .opacity(isAnimate ? 0.5 : 1)
                    .matchedGeometryEffect(id: playImageName, in: namespace)
                
            }
            .offset(x: -10)
            .foregroundStyle(Color.blue)
        }
        .buttonStyle(NextTrackButtonStyle(size: size, duration: duration, scale: scale, color: color))
        
    }
}

struct NextTrackButtonStyle: PrimitiveButtonStyle {
    var size: CGFloat
    var duration: CGFloat
    var scale: CGFloat
    var color: Color
    @State private var isAnimating = false
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundStyle(color.opacity(0.4))
                .frame(width: size * 2)
                .opacity(isAnimating ? 0.5 : 0)
            
            configuration.label
                .font(.system(size: size))
                .foregroundStyle(color)
                .onTapGesture {
                    configuration.trigger()
                    withAnimation(.spring(duration: duration)) {
                        isAnimating.toggle()
                    } completion: {
                        isAnimating = false
                    }
                }
        }
        .scaleEffect(isAnimating ? scale : 1)
    }
}

#Preview {
    ContentView()
}
