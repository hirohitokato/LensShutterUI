//
//  LensShutterView.swift
//  LensShutterUI
//
//  Created by Kato Hirohito on 2022/12/20.
//

import SwiftUI


/// レンズシャッターを模擬するビュー
///  @TODO: 羽根の前後関係が完全ではないのを修正
struct LensShutterView: View {
    /// 羽根の数
    @Binding var numVertices: Int
    /// 羽根の角度。0.0-1.0で指定する。1.0が羽根を閉じた状態
    @Binding var angle: Double
    
    var body: some View {
        GeometryReader { proxy in
                ForEach(0..<Int(numVertices), id:\.self) { i in
                    Rectangle()
                        .foregroundColor(Color(white: 0.2))
                        .background(content: {
                            ContainerRelativeShape()
                                .fill(Color(white: 0.3))
                        })
                        .frame(width: proxy.size.width,
                               height: proxy.size.height*3,
                               alignment: .bottom)
                        .offset(x:-proxy.size.width / 2,
                                y:-proxy.size.height / 2)
                        .rotationEffect(vertexAngle(i, angle: angle))
                        .offset(vertexPos(i, size: proxy.size))
                        .shadow(radius: 5)
                        .animation(.default.speed(3), value: angle)
                }.mask(Rectangle())
        }
    }

    private func vertexAngle(_ i: Int, angle: Double) -> Angle {
        let i = Double(i)
        let initialOffset = 360 / Double(numVertices) * i
        let degree = angle * (RegularPolygonCalculator.interiorAngle(numVertices) / 2)
        let additionalOffset = 180 * (1 + 1 / Double(numVertices))
        return Angle(degrees: initialOffset + degree + additionalOffset)
    }

    private func vertexPos(_ i: Int, size: CGSize) -> CGSize {
        let dx = size.width / 2
        let dy = size.height / 2
        let radius = sqrt(dx * dx + dy * dy) * 1.5
        let vertices = RegularPolygonCalculator.getVertices(
            Int(numVertices),
            radius: radius, offset: 0)
        return CGSize(width: vertices[i].x,
                      height: vertices[i].y - size.height)
    }
}

struct LensShutterView_Previews: PreviewProvider {
    @State static var numVertices: Int = 8
    @State static var angle: Double = 0.0
    static var previews: some View {
        LensShutterView(numVertices: $numVertices, angle: $angle)
    }
}
