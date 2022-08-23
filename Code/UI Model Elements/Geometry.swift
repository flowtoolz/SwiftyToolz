public struct Frame: Equatable
{
    public static var zero: Frame { .init(centerX: 0, centerY: 0, width: 0, height: 0) }
    
    public init(centerX: Double, centerY: Double, width: Double, height: Double)
    {
        self.centerX = centerX
        self.centerY = centerY
        self.width = width
        self.height = height
    }
    
    public init(x: Double, y: Double, width: Double, height: Double)
    {
        self.centerX = x + width / 2
        self.centerY = y + height / 2
        self.width = width
        self.height = height
    }
    
    public var x: Double { centerX - width / 2 }
    public var y: Double { centerY - height / 2 }
    
    public var maxX: Double { centerX + width / 2 }
    public var maxY: Double { centerY + height / 2 }
    
    public let centerX: Double
    public let centerY: Double
    public let width: Double
    public let height: Double
}

public struct Point
{
    public static let zero = Point(0, 0)
    
    public init(_ x: Double, _ y: Double)
    {
        self.x = x
        self.y = y
    }
    
    public let x, y: Double
}
