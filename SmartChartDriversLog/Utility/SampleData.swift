import Foundation

struct LogResponse: Codable {
    let sampleData: [SampleData]
}

// MARK: - LogDetail
struct SampleData: Codable {
    let fromTime: String?
    let toTime: String?
    let duration: String?
    let status: String?
    let location: String?
    let notes: String?
    let isEditable: Bool?
}

func readLocalFile(forName name: String) -> Data? {
    do {
        if let bundlePath = Bundle.main.path(forResource: name,
                                             ofType: "json"),
            let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            return jsonData
        }
    } catch {
        print(error)
    }
    
    return nil
}

func parse(jsonData: Data) -> LogResponse? {
    do {
        let decodedData = try JSONDecoder().decode(LogResponse.self,
                                                   from: jsonData)
        return decodedData
    } catch {
        print("decode error")
    }
    return nil
}

func getSampleData() -> [SampleData] {
    var array = [SampleData]()
    if let file = readLocalFile(forName: "sample8") {
        if let response = parse(jsonData: file) {
            array = response.sampleData
        }
    }
    return array
}
