import SwiftUI
struct SmartChartHosLogsView: View {
    @ObservedObject private(set) var vm: SmartChartHosLogsViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text("")
                    .frame(width: vm.sW, height: vm.txtH, alignment: .trailing)
                HStack(spacing: 0) {
                    ForEach(0..<vm.cols, id: \.self) { mark in
                        HStack {
                            Text("\(mark)")
                                .fontLogHours(vm.chartOrientation)
                        }
                        .frame(width: vm.w, height: vm.txtH)
                    }
                } .frame(height: vm.txtH)
                Text("")
                    .frame(width: vm.tW, height: vm.txtH, alignment: .leading)
            }
            .frame(height: vm.txtH*3 )
            VStack(alignment: .leading, spacing: 0) {
                ForEach(vm.rows, id: \.id) { row in
                    HStack(spacing: 0) {
                        Text("\(row.lblStatus)")
                            .fontLogName(vm.chartOrientation)
                            .frame(width: vm.sW, height: vm.h, alignment: .trailing)
                        
                        VStack {
                            ZStack(alignment: .leading) {
                                HStack(spacing: 0) {
                                    ForEach(0..<row.cols.count, id: \.self) { value in
                                        let log = row.cols[value]
                                        Button(action: {
                                            if vm.chartOrientation == .landscapeLook {
                                                
                                            }
                                        }) {
                                            if log.isTwoLayered {
                                                VStack(spacing: 0) {
                                                    Rectangle()
                                                        .fill(log.color1)
                                                        .frame(width: log.width, height: vm.h3)
                                                        .opacity(vm.opacity)
                                                    Rectangle()
                                                        .fill(log.color2)
                                                        .frame(width: log.width, height: vm.h2)
                                                        .opacity(vm.opacity)
                                                }
                                            } else {
                                                Rectangle()
                                                    .fill(log.color1)
                                                    .frame(width: log.width, height: vm.h)
                                                    .opacity(vm.opacity)
                                            }
                                        }
                                    } // end of for each
                                }
                                DrawLogBoxView(width: vm.w, height: vm.h, cols: vm.cols)
                                if vm.chartOrientation == .landscapeLook {
                                    BlockTimeView(cols: row.cols, h: vm.h, opacity: vm.opacity)
                                }
                            }
                        }
                        .frame(width: vm.cW, height: vm.h, alignment: .leading)
                        .border(Color(LogColor.B.rawValue))
                        
                        if vm.chartOrientation == .landscapeLook {
                            Text("\(row.lblTotalTime)")
                                .fontLogName(vm.chartOrientation)
                                .frame(width: vm.tW, height: vm.h, alignment: .leading)
                        }
                    }
                }
            }
            if vm.chartOrientation == .landscapeLook {
                YardPCView(showLblYard: vm.isYardShown, showLblPC: vm.isPersonalConveyanceShown, spaceAtStart: vm.sW)
            }
        }
    }
}
