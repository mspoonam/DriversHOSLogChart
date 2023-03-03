import Foundation
import SwiftUI

extension SmartChartHosLogsView {
    
    class SmartChartHosLogsViewModel: ObservableObject {
        var rows: [LogsRow]
        var cols = 24
        var showTotalTime = true
        @Published var sampleData: [SampleData] = []
        var arrON = [LogsBlock]()
        var arrOFF = [LogsBlock]()
        var arrD = [LogsBlock]()
        var arrSB = [LogsBlock]()
        var cW: CGFloat = 0
        var cH: CGFloat = 0
        var h: CGFloat = 0
        var h2: CGFloat = 0
        var h3: CGFloat = 0
        var w: CGFloat = 0
        var line: CGFloat = 0
        var txtH: CGFloat = 12 // top numbers height
        var sW: CGFloat = 35
        var tW: CGFloat = 50
        var totalON = 0
        var totalOFF = 0
        var totalD = 0
        var totalSB = 0
        var opacity:Double = 0.0
        var colName: [LogState] = []
        var isYardShown = false
        var isPersonalConveyanceShown = false
        var chartOrientation: ChartOrientation
        /**
         Sample data foe these phones to get the calculations
         Iphone 8    : width: 375.0 height: 667.0 size: (375.0, 667.0)
         Iphone 11  : width: 667.0 height: 375.0 size: (667.0, 375.0)
         */
        init(showTotalTime: Bool = true,
             logs: [SampleData],
             chartOrientation: ChartOrientation,
             opacity: Double = 1.0) {
            rows = [LogsRow]()
            self.chartOrientation = chartOrientation
            self.showTotalTime = showTotalTime
            self.sampleData = logs
            self.opacity = opacity
            initUiProps(chartOrientation)
            initLogicProps()
            calculateData()
            startDrawing()
        }
        
        func initLogicProps() {
            arrON = []
            arrOFF = []
            arrSB = []
            arrD = []
            colName = []
        }
        
        func initUiProps(_ chartOrientation: ChartOrientation) {
            var width:CGFloat = UIScreen.main.bounds.size.width
            let height:CGFloat = UIScreen.main.bounds.size.height
            if chartOrientation == .portraitLook {
                width = width < height ? width : height // small area is the width
            } else {
                width = width > height ? width : height // small area is the width
            }
            cW = width/1.3
            cH = cW/3.95
            w = cW/24
            h = cH/4
            line = cW/1440
            h2 = h/11
            h3 = h - h2
        }
        
        func calculateData() {
            for info in sampleData {
                let fromTime = info.fromTime ?? ""
                let toTime = info.toTime ?? ""
                let fMin = getMin(str: fromTime)
                let tMin = getMin(str: toTime)
                let state = getState(status: info.status ?? "")
                if getStateWiseArr(state: state, fMin: fMin, tMin: tMin) {
                    setYardAndPersonalConveyanceShown(state)
                    setTotal(state: state, value: tMin - fMin)
                    setColumnsNew(state: state, fromMin: fMin, toMin: tMin)
                } else {
                    continue
                }
            }
        }
        
        func setYardAndPersonalConveyanceShown(_ state: LogState) {
            if state == .Y {
                isYardShown = true
            } else if state == .PC {
                isPersonalConveyanceShown = true
            }
        }
        
        func getStateWiseArr(state: LogState, fMin: Int, tMin: Int) -> Bool {
            if state == .NA {
                return false
            }
            if fMin == -1 || tMin == -1 || state == .NA {
                return false
            }
            let dura = tMin - fMin
            if dura == 0 {
                return false
            }
            return true
        }
        
        func setTotal(state: LogState, value: Int) {
            switch state {
            case .ON, .Y:
                return totalON += value
            case .D:
                return totalD += value
            case .OFF, .PC:
                return totalOFF += value
            case .SB:
                return totalSB += value
            case .NA:
                return
            }
        }
        
        func setColumnsNew(state: LogState, fromMin: Int, toMin: Int) {
            if fromMin >= 0 && toMin >= 0 && toMin >= fromMin {
                let width: CGFloat = CGFloat(toMin-fromMin) * line
                let minutes = toMin-fromMin
                switch state {
                case .ON, .Y:
                    let block = LogsBlock(id: fromMin, width: width, minutes: minutes,
                                          color1: getColor(.ON) , color2: getColor(.Y),
                                          log: state, isTwoLayered: ((state == .Y) ? true : false))
                    arrON.append(block)
                    arrD.append(getDummyBlock(fromMin: fromMin, width: width, minutes: minutes))
                    arrOFF.append(getDummyBlock(fromMin: fromMin, width: width, minutes: minutes))
                    arrSB.append(getDummyBlock(fromMin: fromMin, width: width, minutes: minutes))
                case .D:
                    let block = LogsBlock(id: fromMin, width: width, minutes: minutes,
                                          color1: getColor(.D) , color2: getColor(.D),
                                          log: state, isTwoLayered: false)
                    
                    arrD.append(block)
                    arrON.append(getDummyBlock(fromMin: fromMin, width: width, minutes: minutes))
                    arrOFF.append(getDummyBlock(fromMin: fromMin, width: width, minutes: minutes))
                    arrSB.append(getDummyBlock(fromMin: fromMin, width: width, minutes: minutes))
                case .OFF, .PC:
                    let block = LogsBlock(id: fromMin, width: width, minutes: minutes,
                                          color1: getColor(.OFF) , color2: getColor(.PC),
                                          log: state, isTwoLayered: ((state == .PC) ? true : false))
                    arrOFF.append(block)
                    arrON.append(getDummyBlock(fromMin: fromMin, width: width, minutes: minutes))
                    arrD.append(getDummyBlock(fromMin: fromMin, width: width, minutes: minutes))
                    arrSB.append(getDummyBlock(fromMin: fromMin, width: width, minutes: minutes))
                case .SB:
                    let block = LogsBlock(id: fromMin, width: width, minutes: minutes,
                                          color1: getColor(.SB) , color2: getColor(.SB),
                                          log: state, isTwoLayered: false)
                    arrSB.append(block)
                    arrON.append(getDummyBlock(fromMin: fromMin, width: width, minutes: minutes))
                    arrOFF.append(getDummyBlock(fromMin: fromMin, width: width, minutes: minutes))
                    arrD.append(getDummyBlock(fromMin: fromMin, width: width, minutes: minutes))
                case .NA:
                    return
                }
            }
        }
        
        func getDummyBlock(fromMin: Int, width: CGFloat, minutes: Int) -> LogsBlock {
            let block = LogsBlock(id: fromMin, width: width, minutes: minutes,
                                  color1: getColor(.NA) , color2: getColor(.NA),
                                  log: .NA, isTwoLayered: false)
            return block
        }
        
        func getMin(str: String) -> Int {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
            if let date = dateFormatter.date(from: str) {
                let calendar = Calendar.current
                let comp = calendar.dateComponents([.hour, .minute], from: date)
                let hour = comp.hour ?? 0
                let minute = comp.minute ?? 0
                return (hour * 60) + minute
            }
            return -1
        }
        
        func getState(status: String) -> LogState {
            let status = status.lowercased()
            if status == LogState.ON.rawValue {
                return .ON
            } else if status == LogState.OFF.rawValue {
                return .OFF
            } else if status == LogState.SB.rawValue {
                return .SB
            } else if status == LogState.D.rawValue {
                return .D
            } else if status == LogState.Y.rawValue {
                return .Y
            } else if status == LogState.PC.rawValue {
                return .PC
            }
            return LogState.NA
        }
        
        func getTotalTimeInString(value: Int) -> String {
            guard value>0 else {
                return "00:00"
            }
            let hours = value/60
            let min = value%60
            let strHr = (hours < 10) ? "0\(hours)" : "\(hours)"
            let strMin = (min < 10) ? "0\(min)" : "\(min)"
            let value = "\(strHr):\(strMin)"
            return value
        }
        
        func getRow(index: Int) -> LogsRow {
            if index == 0 {
                let lblTime = getTotalTimeInString(value: totalOFF)
                let row = LogsRow(id: index,
                                  lblStatus: LogStateName.OFF.rawValue,
                                  lblTotalTime: lblTime,
                                  cols: arrOFF)
                return row
            }
            else if index == 1 {
                let lblTime = getTotalTimeInString(value: totalSB)
                let row = LogsRow(id: index,
                                  lblStatus: LogStateName.SB.rawValue,
                                  lblTotalTime: lblTime,
                                  cols: arrSB)
                return row
            }
            else if index == 2 {
                let lblTime = getTotalTimeInString(value: totalD)
                let row = LogsRow(id: index,
                                  lblStatus: LogStateName.D.rawValue,
                                  lblTotalTime: lblTime,
                                  cols: arrD)
                return row
            }
            else  {
                let lblTime = getTotalTimeInString(value: totalON)
                let row = LogsRow(id: index,
                                  lblStatus: LogStateName.ON.rawValue,
                                  lblTotalTime: lblTime,
                                  cols: arrON)
                return row
            }
            
        }
        
        func startDrawing() {
            rows = [LogsRow]()
            for i in 0..<4 {
                let row = getRow(index: i)
                rows.append(row)
            }
        }
        
        func formatIn24Hrs(hours: Int, mins: Int) -> String {
            let strHrs = hours > 9 ? "\(hours)" : "0\(hours)"
            let strMins = mins > 9 ? "\(mins)" : "0\(mins)"
            return strHrs + ":" + strMins
        }
        
        func getColor(_ state: LogState) -> Color {
            switch state {
            case .ON:
                return Color("logsLightYellow")
            case .Y:
                return Color("logsYard")
            case .D:
                return Color("logsLightGreen")
            case .OFF:
                return Color("logsLightBlue")
            case .PC:
                return Color("logsPC")
            case .SB:
                return Color("logsLighGrey")
            case .NA:
                return Color.clear
            }
        }
    }
}
