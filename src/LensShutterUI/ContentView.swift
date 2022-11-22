//
//  ContentView.swift
//  LensShutterUI
//
//  Created by Kato Hirohito on 2022/11/19.
//

import SwiftUI

struct ContentView: View {
    @State var numVertices: Double = 4

    @State var angle: Double = 0.0
    var body: some View {
        VStack {
            GeometryReader { proxy in
                    ForEach(0..<Int(numVertices), id:\.self) { i in
                        Rectangle()
                            .frame(width: proxy.size.width,
                                   height: proxy.size.height*3,
                                   alignment: .bottom)
                            .offset(x:-proxy.size.width / 2,
                                    y:-proxy.size.height / 2)
                            .foregroundColor(.secondary)
                            .rotationEffect(vertexAngle(i))
                            .offset(vertexPos(i, size: proxy.size))
                            .shadow(radius: 3)
                    }.mask(Rectangle())
            }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Slider(value: $numVertices, in: 2...10, step: 1) {
                Text("N角形(\(Int(numVertices)))：")
            }
            HStack {
                Button(action: {
                    withAnimation {
                        if angle == 0.0 {
                            angle = RegularPolygonCalculator.interiorAngle(Int(numVertices))/2
                        } else {
                            angle = 0
                        }
                    }
                }) {
                    Text("Take")
                }
                Slider(value: $angle,
                       in: 0...(RegularPolygonCalculator.interiorAngle(Int(numVertices))/2)) {
                    Text("回転角(\(Int(angle)))：")
                }
            }
        }
        .padding()
    }

    func vertexAngle(_ i: Int) -> Angle {
        let i = Double(i)
        let initialOffset = 360 / numVertices * i
        let degree = angle
        let additionalOffset = 180 * (1 + 1 / numVertices)
        return Angle(degrees: initialOffset + degree + additionalOffset)
    }

    func vertexPos(_ i: Int, size: CGSize) -> CGSize {
        let dx = size.width / 2
        let dy = size.height / 2
        let radius = sqrt(dx * dx + dy * dy)
        let vertices = RegularPolygonCalculator.getVertices(
            Int(numVertices),
            radius: radius, offset: 0)
        return CGSize(width: vertices[i].x,
                      height: vertices[i].y - size.height)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
