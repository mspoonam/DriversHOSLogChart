import SwiftUI
struct YardPCView: View {
    var lblYard = "Yard Moves"
    var lblPC = "Personal Conveyance"
    var showLblYard = false
    var showLblPC = false
    var spaceAtStart: CGFloat = 0
    var colorYard = Color("logsYard")
    var colorPC = Color("logsPC")
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 50)
            HStack(spacing: 0) {
                Spacer().frame(width: spaceAtStart)
                if showLblYard {
                    HStack {
                        Rectangle()
                            .fill(colorYard)
                            .frame(width: 16, height: 4)
                        Text(lblYard)
                            .landscapeYardPC()
                    }
                    Spacer().frame(width: 20)
                }
                if showLblPC {
                    HStack {
                        Rectangle()
                            .fill(colorPC)
                            .frame(width: 16, height: 4)
                        Text(lblPC)
                            .landscapeYardPC()
                    }
                }
            }
        }
    }
}
