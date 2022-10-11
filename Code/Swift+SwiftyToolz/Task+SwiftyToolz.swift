@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension Task where Success == Void
{
    func assumeSuccess() async throws { try await value }
}
