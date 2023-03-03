import SwiftUI

struct ChartStickView: View {
    @ObservedObject private(set) var vm: ChartStickViewModel
    var body: some View {
        VStack(spacing:0) {
            HStack {
                VStack(spacing:0) {
                    Rectangle().frame(width: vm.w, height: vm.h).foregroundColor(.black)
                    RoundedRectangle(cornerRadius: vm.r)
                        .foregroundColor(.black)
                        .frame(width: vm.r, height: vm.r)
                }
                .frame(width:vm.w, height: vm.h + vm.r)
            }
        }
        .frame(height: vm.tH)
    }
}

extension ChartStickView {
    class ChartStickViewModel: ObservableObject {
        var w: CGFloat = 0
        var h: CGFloat = 0
        var r: CGFloat = 0
        var tH: CGFloat = 0
        var time: String = ""
        var space: String = "left"
        init(w: CGFloat, h: CGFloat, tH: CGFloat,
             r: CGFloat, mins: String="00:47",
             space: String = "left") {
            self.w = w
            self.h = h
            self.r = r
            self.tH = tH
            self.time = mins
            self.space = space
        }
    }
}
