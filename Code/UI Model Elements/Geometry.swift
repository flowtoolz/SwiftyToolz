import simd

public struct Rectangle: Equatable
{
    // MARK: - Convenience Getters
    
    public var maxX: Double { x + width }
    public var maxY: Double { y + height }
    
    public var midX: Double { centerX }
    public var midY: Double { centerY }
    
    public var center: Point { Point(centerX, centerY) }
    public var centerX: Double { x + (width / 2) }
    public var centerY: Double { y + (height / 2) }
    
    // MARK: - Initializers
    
    public init(center: Point, size: Size)
    {
        self.init(position: Point(center.x - (size.width / 2),
                                  center.y - (size.height / 2)),
                  size: size)
    }
    
    public static var zero: Rectangle { Rectangle() }
    
    public init(position: Point = .zero, size: Size = .zero)
    {
        self.position = position
        self.size = size
    }
    
    // MARK: - Position
    
    public var minX: Double { x }
    public var minY: Double { y }
    
    public var x: Double { position.x }
    public var y: Double { position.y }
    
    public let position: Point
    
    // MARK: - Size
    
    public var surface: Double { size.surface }
    
    public var width: Double { size.width }
    public var height: Double { size.height }
    
    public let size: Size
}

public extension Size
{
    init(width: Double, height: Double)
    {
        self.init(width, height)
    }
    
    var surface: Double { width * height }
    
    var width: Double { x }
    var height: Double { y }
}

public typealias Size = Vector2D
public typealias Point = Vector2D
public typealias Vector2D = SIMD2<Double>
