public func typeName<T>(of anything: T) -> String
{
    return String(describing: type(of: anything))
}

public typealias JSON = [String : Any]

public typealias Action = () -> Void

public func hash(_ object: AnyObject) -> HashValue
{
    return ObjectIdentifier(object).hashValue
}

public func address(of object: AnyObject) -> String
{
    return String(describing: Unmanaged.passUnretained(object).toOpaque())
}

public typealias HashValue = Int
