import SwiftUI

struct LandscapeHour: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("OpenSans-Bold", size: 12))
            .foregroundColor(Color("iconography"))
    }
}

struct PortraitHour: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("OpenSans-Bold", size: 8))
            .foregroundColor(Color("iconography"))
    }
}

struct LandscapeLogsInnerTime: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("OpenSans-Bold", size: 12))
            .foregroundColor(Color("iconography"))
    }
}

struct LandscapeLogsTime: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("OpenSans-Bold", size: 12))
            .foregroundColor(Color("iconography"))
            .padding(4)
    }
}

struct StickTime: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("OpenSans-Bold", size: 10))
            .foregroundColor(Color("paragraphs"))
            .padding(2)
    }
}

struct LandscapeYardPC: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("OpenSans-Bold", size: 14))
            .foregroundColor(Color("paragraphs"))
            .padding(4)
    }
}

// MARK: Naming Convetion :- Heading + OpenSans Font + Color Name + Size
extension Text {
    func landscapeLogsInnerTime() -> some View {
        self.modifier(LandscapeLogsInnerTime())
    }
    func landscapeHour() -> some View {
        self.modifier(LandscapeHour())
    }
    func landscapeYardPC() -> some View {
        self.modifier(LandscapeYardPC())
    }
    func stickTime() -> some View {
        self.modifier(StickTime())
    }
    
    func fontLogHours(_ look: ChartOrientation) -> some View {
        self.modifier(FontLogHours(or: look))
    }
    
    func fontLogName(_ look: ChartOrientation) -> some View {
        self.modifier(FontLogName(or: look))
    }
    
}

struct FontLogHours: ViewModifier {
    var or: ChartOrientation
    init(or: ChartOrientation) {
        self.or = or
    }
    func body(content: Content) -> some View {
        content
            .font(.custom("OpenSans-Bold", size: ((self.or == .portraitLook) ? 8 : 14)))
            .foregroundColor(Color("iconography"))
            .padding(((self.or == .portraitLook) ? 0 : 4))
    }
}

struct FontLogName: ViewModifier {
    var or: ChartOrientation
    init(or: ChartOrientation) {
        self.or = or
    }
    func body(content: Content) -> some View {
        content
            .font(.custom("OpenSans-Bold", size: ((self.or == .portraitLook) ? 8 : 12)))
            .foregroundColor(Color("iconography"))
            .padding(((self.or == .portraitLook) ? 1 : 4))
    }
}
