public extension Optional
{
    func forSome(_ do: ((Wrapped) throws -> Void)?) rethrows
    {
        if case .some(let wrapped) = self { try `do`?(wrapped) }
    }
    
    func forSome(_ do: (Wrapped) throws -> Void) rethrows
    {
        if case .some(let wrapped) = self { try `do`(wrapped) }
    }
    
    func unwrap(file: String = #file, line: Int = #line) throws -> Wrapped
    {
        switch self
        {
        case .some(let wrapped): return wrapped
        case .none: throw "Failed to unwrap \(Wrapped.self) (\(file):\(line))"
        }
    }
}
