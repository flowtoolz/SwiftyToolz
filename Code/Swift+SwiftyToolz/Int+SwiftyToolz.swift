public extension Int
{
    func times(_ do: () throws -> Void) rethrows
    {
        guard self > 0 else { return }
        for _ in 0 ..< self { try `do`() }
    }
    
    static func random(max: Int = .max) -> Int
    {
        .random(in: 0 ... max)
    }
}

public extension UInt8
{
    static var random: UInt8 { .random(in: 0 ... .max) }
}

public typealias Byte = UInt8
