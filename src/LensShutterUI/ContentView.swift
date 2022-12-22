//
//  ContentView.swift
//  LensShutterUI
//
//  Created by Kato Hirohito on 2022/11/19.
//

import SwiftUI

struct ContentView: View {
    @State var numVertices: Int = 4
    @State var numVerticesDouble: Double = 4.0

    /// Blade angle. 0.0 is fully released, 1.0 is fully closed.
    @State var angle: Double = 0.0
    var body: some View {
        VStack {
            LensShutterView(numVertices: $numVertices, angle: $angle)
            Slider(value: $numVerticesDouble, in: 2...10, step: 1,
                   label: { Text("N角形(\(Int(numVerticesDouble)))：") },
                   onEditingChanged: { _ in
                numVertices = Int(numVerticesDouble)
            })
            HStack {
                Button(action: {
                    withAnimation {
                        angle = (angle == 0.0) ? 1.0 : 0.0
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                            withAnimation {
                                angle = (angle == 0.0) ? 1.0 : 0.0
                            }
                        }
                    }
                }) {
                    Text("Take")
                }
                Slider(value: $angle, in: 0...1.0) {
                    Text("回転角(\(Int(angle * (RegularPolygonCalculator.interiorAngle(numVertices) / 2))))：")
                }
            }
        }
        .background(content: {
            ContainerRelativeShape()
               .fill(Color.yellow)
        })
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(numVertices: 4)
    }
}
