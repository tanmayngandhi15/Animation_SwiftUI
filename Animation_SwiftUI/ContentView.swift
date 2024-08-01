//
//  ContentView.swift
//  Animation_SwiftUI
//
//  Created by Tanmay N. Gandhi on 31/07/24.
//

import SwiftUI

class AnimationManager: ObservableObject {
    @Published var grow = false
    @Published var rotationAngle = 0.0
    @Published var xOffset: CGFloat = 0
    @Published var yOffset: CGFloat = 0
    @Published var animationStep: Int = 0
    @Published var imageId = 0
    
    let imageArray = ["diwali_fireworks", "fan_blade", "colourfull_fan"]
    
    
    private var timer_1: Timer?
    private var timer_2: Timer?
    
    init() {
        startTimers()
    }
    
    private func startTimers() {
        timer_1 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            withAnimation(.easeInOut(duration: 2)) {
                self?.rotationAngle -= 360
                self?.grow.toggle()
            }
        }
        
        timer_2 = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            let maxX = UIScreen.main.bounds.maxX - 200
            let maxY = UIScreen.main.bounds.maxY - 230
            
            withAnimation(.easeInOut(duration: 4)) {
                switch self.animationStep {
                case 0:
                    self.xOffset = maxX / 2
                    self.yOffset = 0
                case 1:
                    self.xOffset = maxX
                    self.yOffset = maxY / 2
                case 2:
                    self.xOffset = maxX / 2
                    self.yOffset = maxY
                case 3:
                    self.xOffset = 0
                    self.yOffset = maxY / 2
                case 4:
                    self.xOffset = maxX / 2
                    self.yOffset = 0
                case 5:
                    self.xOffset = maxX / 2
                    self.yOffset = maxY / 2
                default:
                    self.xOffset = 0
                    self.yOffset = 0
                }
                
                self.animationStep = self.animationStep>5 ? 0 : self.animationStep+1
                
                //  animationStep = Int.random(in: 0...6)
            }
        }
        
    }
    
    deinit {
        timer_1?.invalidate()
        timer_2?.invalidate()
    }
}

struct ContentView: View {
    @StateObject private var animationManager = AnimationManager()
    
    var body: some View {
        
        VStack {
            
            ZStack {
                GeometryReader { geometry in
                    
                    VStack {
                        Image(animationManager.imageArray[animationManager.imageId])
                            .resizable()
                            .scaledToFit()
                            .frame(width: animationManager.grow ? 200 : 100, height: animationManager.grow ? 200 : 100)
                            .rotationEffect(.degrees(animationManager.rotationAngle))
                            .offset(x: animationManager.xOffset, y: animationManager.yOffset)
                            .animation(.easeInOut(duration: 2), value: animationManager.grow)
                            .animation(.easeInOut(duration: 2), value: animationManager.rotationAngle)
                            .animation(.easeInOut(duration: 4), value: animationManager.xOffset)
                    }
                }
            }
            
            ZStack {
                
                Spacer()
                
                Button(action: {
                    animationManager.imageId = animationManager.imageId >= 2 ? 0 : animationManager.imageId + 1
                }) {
                    Text("Tap")
                        .font(.title)
                        .padding()
                        .frame(width: 80, height: 80)
                        .background(
                            .purple
                        )
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 2)
                        )
                    
                }
                .padding(.bottom, 30)
            }
        }
        .background(.black)
        
    }
}

#Preview {
    ContentView()
}
