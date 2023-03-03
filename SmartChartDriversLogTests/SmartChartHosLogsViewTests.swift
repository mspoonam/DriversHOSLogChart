import XCTest
@testable import SmartChartDriversLog

class SmartChartHosLogsViewTests: XCTestCase {
    var sut: SmartChartHosLogsView.SmartChartHosLogsViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let detail1 = SampleData(fromTime: "11/01/2021 02:51 AM", toTime: "11/01/2021 05:23 AM", duration: "02:32", status: "onDriving", location: "", notes: "", isEditable: false)
        let detail2 = SampleData(fromTime: nil, toTime: nil, duration: "02:32", status: nil, location: "", notes: "", isEditable: false)
        var logDetails: [SampleData] = []
        logDetails.append(detail1)
        logDetails.append(detail2)
        sut = SmartChartHosLogsView.SmartChartHosLogsViewModel(showTotalTime: true,
                                                               logs: logDetails,
                                                               chartOrientation: ChartOrientation.portraitLook,
                                                               opacity: 1)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitLogicProps() {
        sut.initLogicProps()
        XCTAssertEqual(sut.arrON.count, 0)
        XCTAssertEqual(sut.arrOFF.count, 0)
        XCTAssertEqual(sut.arrSB.count, 0)
        XCTAssertEqual(sut.arrD.count, 0)
    }
    
    func testInitUiProps() {
        sut.initUiProps(sut.chartOrientation)
        XCTAssertTrue(sut.cW>0)
        XCTAssertTrue(sut.cH>0)
        XCTAssertTrue(sut.w>0)
        XCTAssertTrue(sut.h>0)
        XCTAssertTrue(sut.line>0)
    }

    func testCalculateData() {
        sut.calculateData()
    }
    
    func testGetStateWiseArr() {
        var value = sut.getStateWiseArr(state: .D, fMin: 171, tMin: 323)
        XCTAssertTrue(value)
        value = sut.getStateWiseArr(state: .D, fMin: -1, tMin: 323)
        XCTAssertFalse(value)
        value = sut.getStateWiseArr(state: .D, fMin: 10, tMin: 10)
        XCTAssertFalse(value)
    }
    
    func testGetTotal() {
        
        sut.setTotal(state: .ON, value: 10)
        XCTAssertEqual(sut.totalON, 10)
        sut.setTotal(state: .ON, value: 20)
        XCTAssertEqual(sut.totalON, 30)
        
        sut.setTotal(state: .D, value: 10)
        XCTAssertEqual(sut.totalD, 10)
        sut.setTotal(state: .D, value: 20)
        XCTAssertEqual(sut.totalD, 30)
        
        sut.setTotal(state: .OFF, value: 10)
        XCTAssertEqual(sut.totalOFF, 10)
        sut.setTotal(state: .OFF, value: 20)
        XCTAssertEqual(sut.totalOFF, 30)
        
        sut.setTotal(state: .SB, value: 10)
        XCTAssertEqual(sut.totalSB, 10)
        sut.setTotal(state: .SB, value: 20)
        XCTAssertEqual(sut.totalSB, 30)
        
        sut.setTotal(state: .NA, value: 10) // Nothing happens
        XCTAssertEqual(sut.totalON, 30)
        XCTAssertEqual(sut.totalD, 30)
        XCTAssertEqual(sut.totalOFF, 30)
        XCTAssertEqual(sut.totalSB, 30)
    }
    
    func testGetMin() {
        var value = sut.getMin(str: "11/01/2021 00:00:00")
        XCTAssertEqual(value, 0)
        value = sut.getMin(str: "11/01/2021 02:00:00")
        XCTAssertEqual(value, 120)
        value = sut.getMin(str: "11/01/2021 04:00:00")
        XCTAssertEqual(value, 240)
        value = sut.getMin(str: "11/01/2021 06:00:00")
        XCTAssertEqual(value, 360)
        value = sut.getMin(str: "2021/01/11 07:00:00")
        XCTAssertEqual(value, -1)
        value = sut.getMin(str: "11/01/2021 08:00:00")
        XCTAssertEqual(value, 480)
    }
    
    func testGetState() {
        var value = sut.getState(status: "OnDuty")
        XCTAssertTrue(value.rawValue == LogState.ON.rawValue)
        value = sut.getState(status: "Sleeper")
        XCTAssertTrue(value.rawValue == LogState.SB.rawValue)
        value = sut.getState(status: "offduty")
        XCTAssertTrue(value.rawValue == LogState.OFF.rawValue)
        value = sut.getState(status: "Driving")
        XCTAssertTrue(value.rawValue == LogState.D.rawValue)
        value = sut.getState(status: "PowerOn")
        XCTAssertTrue(value.rawValue == LogState.NA.rawValue)
    }
    
    func testGetTotalTimeInString() {
        var value = sut.getTotalTimeInString(value: 1200)
        XCTAssertEqual(value, "20:00")
        value = sut.getTotalTimeInString(value: -1)
        XCTAssertEqual(value, "00:00")
        value = sut.getTotalTimeInString(value: 10)
        XCTAssertEqual(value, "00:10")
    }
    
    func testGetRow() {
        var row = sut.getRow(index: 0)
        XCTAssertNotNil(row)
        row = sut.getRow(index: 1)
        XCTAssertNotNil(row)
        row = sut.getRow(index: 2)
        XCTAssertNotNil(row)
        row = sut.getRow(index: 3)
        XCTAssertNotNil(row)
    }
    
    func testStartDrawing() {
        sut.startDrawing()
        XCTAssertNotNil(sut.rows)
        XCTAssertEqual(sut.rows.count, 4)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
