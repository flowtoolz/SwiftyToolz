public extension Int
{
    public static func random(max: UInt32 = UInt32.max - 1) -> Int
    {
        return Int(arc4random_uniform(max + 1))
    }
}
