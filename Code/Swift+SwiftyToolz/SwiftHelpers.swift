public typealias JSON = [String : Any]
public typealias Action = () -> Void

public func address(_ object: AnyObject) -> String
{
    String(describing: Unmanaged.passUnretained(object).toOpaque())
}

public func typeName<T>(_ anything: T) -> String
{
    String(describing: type(of: anything))
}
