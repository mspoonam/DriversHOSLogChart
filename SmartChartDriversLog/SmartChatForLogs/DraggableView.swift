import SwiftUI

struct DraggableView: View {
    @State private var location1: CGPoint = CGPoint(x: 50, y: 50) // second rect location
    @State private var fingerLocation1: CGPoint? // 1
    @State private var location2: CGPoint = CGPoint(x: 100, y: 50) // second rect location
    @State private var fingerLocation2: CGPoint? // 1
    @State private var minX: CGFloat = 30// drag min left , start boundry
    @State private var maxX: CGFloat = UIScreen.main.bounds.size.width - 10// drag max right , end boundry
//    200 mins
//    500 mins
    var simpleDrag1: some Gesture {
        DragGesture()
            .onChanged { value in
                let location1x = value.location.x
                let location2x = self.location2.x
                
                if location1x < minX { // boundry check imp
                    self.location1.x = minX
                } else if (location1x + 20) < location2x {
                    self.location1.x = location1x
                } else {
                    self.location1.x = location2x - 3
                }
            }
    }
    
    var fingerDrag1: some Gesture { // 2
        DragGesture()
            .onChanged { value in
                let finger1x = value.location.x
                let finger2x = self.fingerLocation2?.x ?? 0
                
                if finger1x < minX {
                    self.fingerLocation1?.x = minX
                } else if (finger1x + 20) < finger2x {
                    self.fingerLocation1?.x = finger1x
                } else {
                    self.fingerLocation1?.x = finger2x - 20
                }
            }
            .onEnded { value in
                self.fingerLocation1 = nil
            }
    }
    
    var simpleDrag2: some Gesture {
        DragGesture()
            .onChanged { value in
                let location1x = self.location1.x
                let location2x = value.location.x
               
                if location2x > maxX {
                    self.location2.x = maxX
                } else if location2x > (location1x + 20) {
                    self.location2.x = location2x
                } else {
                    self.location2.x = location1x + 20
                }
            }
    }
    
    var fingerDrag2: some Gesture { // 2
        DragGesture()
            .onChanged { value in
                let finger1x = self.fingerLocation2?.x ?? 0
                let finger2x = value.location.x
                
                if finger2x > maxX {
                    self.fingerLocation2?.x = maxX
                } else if finger2x > (finger1x + 20) {
                    self.fingerLocation2?.x = finger2x
                } else {
                    self.fingerLocation2?.x = finger1x + 20
                }
            }
            .onEnded { value in
                self.fingerLocation2 = nil
            }
    }
    
    var body: some View {
        ZStack { // 3
            // ZStack Black REctangle
            ZStack {
                // Line
                Rectangle().frame(width: 2, height: 100).foregroundColor(.black)
                    .position(location1)
                    .gesture(
                        simpleDrag1.simultaneously(with: fingerDrag1) // 4
                    )
                VStack {
                    Spacer().frame(height: 60)
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.black)
                        .frame(width: 8, height: 8)
                        .position(location1)
                        .gesture(
                            simpleDrag1.simultaneously(with: fingerDrag1) // 4
                        )
                }
                    

            }
            Spacer().frame(width: 20)
            // ZStack Blue REctangle
            ZStack {
                // Line
                Rectangle().frame(width: 2, height: 100).foregroundColor(.blue)
                    .position(location2)
                    .gesture(
                        simpleDrag2.simultaneously(with: fingerDrag2) // 4
                    )
                VStack {
                    Spacer().frame(height: 60)
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.blue)
                        .frame(width: 8, height: 8)
                        .position(location2)
                        .gesture(
                            simpleDrag2.simultaneously(with: fingerDrag2) // 4
                        )
                }
            }
            
            Spacer()
        }
    }
}
