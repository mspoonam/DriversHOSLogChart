import SwiftUI
struct LogBoxView: View {
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(width: width, height: height)
            .border(Color(LogColor.B.rawValue))
    }
}

