@available(macOS 10.15, *)
public extension Task where Success == Void
{
    func assumeSuccess() async throws { try await value }
}
