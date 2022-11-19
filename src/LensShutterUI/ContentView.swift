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
            ZStack {
                ForEach(0..<Int(numVertices), id:\.self) { i in
                    Rectangle()
                        .frame(width: 80,height: 160, alignment: .center)
                        .foregroundColor(.blue)
                        .offset(x:-40,y:-80)
                        .rotationEffect(vertexAngle(i))
                        .offset(vertexPos(i))
                        .shadow(radius: 3)
                }
            }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Slider(value: $numVertices, in: 2...10, step: 1) {
                Text("N角形(\(Int(numVertices)))：")
            }
            Slider(value: $angle,
                   in: 0...(RegularPolygonCalculator.interiorAngle(Int(numVertices))/2)) {
                Text("回転角(\(Int(angle)))：")
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

    func vertexPos(_ i: Int) -> CGSize {
        let vertices = RegularPolygonCalculator.getVertices(
            Int(numVertices),
            radius: 100, offset: 0)
        return CGSize(width: vertices[i].x,
                      height: vertices[i].y)
    }

    func slider<V, C>(
        value: Binding<V>,
        in bounds: ClosedRange<V> = 0...1,
        step: V.Stride = 1,
        label: () -> C,
        onEditingChanged: @escaping (Bool) -> Void = { _ in })
    -> some View where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint, C: View {
        HStack {
            label()
            Slider(value: value,
                   in: bounds,
                   step: step,
                   onEditingChanged: onEditingChanged,
                   label: {EmptyView()})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
