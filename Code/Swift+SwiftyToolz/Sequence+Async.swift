public extension Sequence
{
    @available(iOS 13.0.0, macOS 10.15.0, tvOS 13.0.0, watchOS 6.0.0, *)
    func asyncMap<Mapped>(_ transform: @Sendable (Element) async throws -> Mapped) async rethrows -> [Mapped]
    {
        // TODO: parallelize this using task group but maintaining order ... or is this rather an application of AsyncSequence???
        
        var result = [Mapped]()
        
        for element in self
        {
            result += try await transform(element)
        }
        
        return result
    }
}
