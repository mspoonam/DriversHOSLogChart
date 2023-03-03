import SwiftUI
struct DrawLogBoxView: View {
    var width: CGFloat
    var height: CGFloat
    var cols: Int
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<cols, id: \.self) { mark in
                LogBoxView(width: width, height: height)
            }
        }
    }
}
