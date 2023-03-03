import SwiftUI
struct BlockTimeView: View {
    @State var cols: [LogsBlock]
    var h: CGFloat = 0
    var opacity: Double = 0.0
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<cols.count, id: \.self) { value in
                let log = cols[value]
                ZStack {
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: log.width, height: h)
                            .opacity(opacity)
                    }
                    if log.log != .NA && log.minutes>=60 {
                        HStack(spacing: 0) {
                            if log.minutes >= 60 {
                                Spacer()
                            }
                            VStack(spacing: 0) {
                                Text(getTimePerBlock(log.minutes))
                                    .landscapeLogsInnerTime()
                                Spacer()
                            }
                        }.frame(height: h)
                    }
                }
            }
        }
    }
    
    func getTimePerBlock(_ width: Int) -> String {
        if width >= 60 {
            let hours = (width)/60
            let mins = width%60
            return formatIn24Hrs(hours: hours, mins: mins)
        } else {
            return ":\(width)"
        }
    }
    
    func formatIn24Hrs(hours: Int, mins: Int) -> String {
        let strHrs = hours > 9 ? "\(hours)" : "0\(hours)"
        let strMins = mins > 9 ? "\(mins)" : "0\(mins)"
        return strHrs + ":" + strMins
    }
}
