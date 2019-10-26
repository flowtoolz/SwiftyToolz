public typealias JSON = [String : Any]

public typealias Action = () -> Void

public extension Optional {
    func forSome(_ do: ((Wrapped) -> Void)?) {
        if case .some(let wrapped) = self { `do`?(wrapped) }
    }
    
    func forSome(_ do: (Wrapped) -> Void) {
        if case .some(let wrapped) = self { `do`(wrapped) }
    }
}

// MARK: - Object Identity

public func address(_ object: AnyObject) -> String
{
    return String(describing: Unmanaged.passUnretained(object).toOpaque())
}

public func hashValue(_ object: AnyObject) -> HashValue
{
    return ObjectIdentifier(object).hashValue
}

public typealias HashValue = Int

// MARK: - Type Inspection

public func typeName<T>(_ anything: T) -> String
{
    return String(describing: type(of: anything))
}
