public extension Copyable
{
    var copy: Self { Self(with: self) }
}

public protocol Copyable: AnyObject
{
    init(with original: Self)
}
