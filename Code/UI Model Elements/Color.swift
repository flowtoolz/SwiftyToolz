public enum UXColor
{
    case rgba(Color)
    case dynamic(Color, Color)
    case system(System)
    
    public enum System
    {
        case text, label, secondaryLabel, red, orange, yellow, green, blue, purple, gray, teal
    }
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
    
    static func rgb(_ r: Double, _ g: Double, _ b: Double) -> Color
    {
        self.init(r, g, b, 1.0)
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
