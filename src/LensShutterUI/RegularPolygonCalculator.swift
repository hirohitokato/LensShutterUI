//
//  RegularPolygonCalculator.swift
//
//  Created by Kato Hirohito on 2022/11/19.
//

import Foundation

/// 正多角形に対する関数群
class RegularPolygonCalculator {
    
    /// `numVertices`で表す正N角形の各頂点の座標群を`CGPoint`の配列で返す
    /// - Parameters:
    ///   - numVertices: 正N角形の頂点の数。2以上の値を取る
    ///   - radius: 正N角形中心から頂点までの距離
    ///   - offset: 回転のオフセット。単位:度
    /// - Returns: 各頂点の座標を含んだ配列。エラー時は空配列を返す。
    static func getVertices(_ numVertices: Int,
                            radius: Double = 1.0,
                            offset: Double = 0.0) -> [CGPoint] {
        guard numVertices > 1 else {
            return []
        }

        // 円の中心をN等分したときの、各分割の中心角は 2π/N
        let rad = 2.0 * Double.pi / Double(numVertices)
        let offset = offset * Double.pi / 180.0

        // 正N角形の拡張点を円周上に描画する。
        // 円周上の点は x = r cosθ, y = r sinθ で求められる
        let result = (0..<numVertices)
            .map { Double($0) }
            .map {
                CGPoint(x: radius * cos(rad * $0 + offset),
                        y: radius * sin(rad * $0 + offset))
            }
        return result
    }
    
    /// `numVertices`で表す正N角形の内角(degree)を返す
    /// - Parameters:
    ///   - numVertices: 正N角形の頂点の数。2以上の値を取る
    /// - Returns: 内角。単位:度
    static func interiorAngle(_ numVertices: Int) -> Double {
        let n = Double(numVertices)
        return (180 * (n - 2)) / n
    }
}
