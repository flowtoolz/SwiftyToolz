public typealias JSON = [String : Any]

public typealias Action = () -> Void

public func typeName<T>(_ anything: T) -> String
{
    return String(describing: type(of: anything))
}

public func address(_ object: AnyObject) -> String
{
    return String(describing: Unmanaged.passUnretained(object).toOpaque())
}

public func hashValue(_ object: AnyObject) -> HashValue
{
    return ObjectIdentifier(object).hashValue
}

public typealias HashValue = Int
