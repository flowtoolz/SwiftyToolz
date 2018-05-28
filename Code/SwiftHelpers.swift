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

public typealias HashValue = Int
