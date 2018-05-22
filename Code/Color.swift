public extension Color
{
    static let black = gray(brightness: 0)
    static let white = gray(brightness: 1)
    
    static func gray(brightness: Float) -> Color
    {
        return Color(brightness, brightness, brightness)
    }
}

public struct Color: Codable, Equatable
{
    public init(_ r: Int, _ g: Int, _ b: Int)
    {
        self.init(r, g, b, 255)
    }
    
    public init(_ r: Int, _ g: Int, _ b: Int, _ a: Int)
    {
        self.init(Float(r) / 255.0,
                  Float(g) / 255.0,
                  Float(b) / 255.0,
                  Float(a) / 255.0)
    }
    
    public init(_ r: Float, _ g: Float, _ b: Float)
    {
        self.init(r, g, b, 1.0)
    }
    
    public init(_ r: Float, _ g: Float, _ b: Float, _ a: Float)
    {
        red = r
        green = g
        blue = b
        alpha = a
    }
    
    public var red, green, blue, alpha: Float
}
