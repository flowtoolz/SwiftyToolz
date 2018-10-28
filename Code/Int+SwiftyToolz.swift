public extension Int
{
    public static func random(max: UInt32 = UInt32.max - 1) -> Int
    {
        return Int(arc4random_uniform(max + 1))
    }
}

public extension UInt8
{
    public static func random(max: UInt8 = .max) -> UInt8
    {
        return UInt8(arc4random_uniform(UInt32(max) + 1))
    }
}

public typealias Byte = UInt8
