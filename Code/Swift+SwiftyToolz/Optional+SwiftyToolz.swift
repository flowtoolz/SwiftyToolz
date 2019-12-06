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
}
