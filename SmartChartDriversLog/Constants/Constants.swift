import SwiftUI

enum ChartOrientation: Int {
    case portraitLook = 1
    case landscapeLook = 2
}

enum LogState: String {
    case D = "driving", ON = "onduty", OFF = "offduty", SB = "sleeper", NA = "", Y = "yardmoves", PC = "personalconveyance"
}

enum LogStateName: String {
    case D = "D", ON = "ON", OFF = "OFF", SB = "SB"
}

enum LogColor: String {
    case D = "logsLightGreen"
    case ON = "logsLightYellow"
    case OFF = "logsLightBlue"
    case SB = "logsLighGrey"
    case B = "logsChartBorder"
    case EditD = "logsGreen"
    case EditON = "logsYellow"
    case EditOFF = "logsBlue"
    case EditSB = "logsGrey"
    case Y = "logsYard"
    case PC = "logsPC"
}


struct DesignChart: Identifiable {
    var id: Int
    var lblStatus: String
    var lblTotalTime: String
    var totalTimeInMinutes: Int
    var cols: [Int]
    var color: String
    var logState: LogState
}

struct LogsRow: Identifiable {
    var id: Int
    var lblStatus: String
    var lblTotalTime: String
    var cols: [LogsBlock]
}

struct LogsBlock: Identifiable {
    var id: Int
    var width: CGFloat
    var minutes: Int
    var color1: Color
    var color2: Color
    var log: LogState
    var isTwoLayered: Bool
}

struct EditChart: Identifiable {
    var id: Int
    var lblStatus: String
    var lblTotalTime: String
    var totalTimeInMinutes: Int
    var color: Color
    var logState: LogState
}


