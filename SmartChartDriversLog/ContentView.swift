import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0 ) {
                VStack(alignment: .leading ) {
                    Spacer().frame(height: 50)
                    SmartChartHosLogsView(vm: SmartChartHosLogsView.SmartChartHosLogsViewModel(logs: getSampleData(), chartOrientation: .landscapeLook, opacity: 1))
                    
                    Spacer()
                }
            }
        }
    }
}
