public enum UXColor
{
    case rgba(Color)
    case dynamic(DynamicColor)
    case system(SystemColor)
}

public enum SystemColor
{
    case text, label, secondaryLabel, red, orange, yellow, green, blue, purple, gray, teal, accent
}

public struct DynamicColor
{
    public static func `in`(light: Color,
                            darkness: Color) -> DynamicColor
    {
        .init(lightMode: light, darkMode: darkness)
    }
    
    public func mixed(with portion: Double,
                      of otherColor: DynamicColor) -> DynamicColor
    {
        .init(lightMode: lightMode.mixed(with: portion,
                                         of: otherColor.lightMode),
              darkMode: darkMode.mixed(with: portion,
                                       of: otherColor.darkMode))
    }
    
    public let lightMode: Color
    public let darkMode: Color
}

public extension Color
{
    static var random: Color
    {
        rgb(.random(in: 0 ... 1.0), .random(in: 0 ... 1.0), .random(in: 0 ... 1.0))
    }
    
    static var clear: Color { .black.with(alpha: 0) }
    static var black: Color { .gray(brightness: 0) }
    static var white: Color { .gray(brightness: 1) }

    static func gray(brightness: Double) -> Color
    {
        rgb(brightness, brightness, brightness)
    }
    
    static func bytes(_ r: Byte, _ g: Byte, _ b: Byte) -> Color
    {
        bytes(r, g, b, 255)
    }
    
    static func bytes(_ r: Byte, _ g: Byte, _ b: Byte, _ a: Byte) -> Color
    {
        self.init(Double(r) / 255.0,
                  Double(g) / 255.0,
                  Double(b) / 255.0,
                  Double(a) / 255.0)
    }
    
    func mixed(with portion: Double, of otherColor: Color) -> Color
    {
        let myPortion = 1.0 - portion
        
        return .init(red * myPortion + otherColor.red * portion,
                     green * myPortion + otherColor.green * portion,
                     blue * myPortion + otherColor.blue * portion,
                     alpha * myPortion + otherColor.alpha * portion)
    }
    
    static func rgb(_ r: Double, _ g: Double, _ b: Double) -> Color
    {
        rgba(r, g, b, 1.0)
    }
    
    static func rgba(_ r: Double, _ g: Double, _ b: Double, _ a: Double) -> Color
    {
        self.init(r, g, b, a)
    }
    
    func with(alpha: Double) -> Color
    {
        .init(red, green, blue, alpha)
    }
}

public struct Color: Codable, Equatable
{
    public init(_ r: Double, _ g: Double, _ b: Double, _ a: Double)
    {
        red = r
        green = g
        blue = b
        alpha = a
    }
    
    public var red, green, blue, alpha: Double
}
