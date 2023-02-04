@available(iOS 13.0.0, macOS 10.15.0, tvOS 13.0.0, watchOS 6.0.0, *)
@globalActor public actor BackgroundActor
{
    /// Execute the given closure on this actor
    public static func run<T: Sendable>(resultType: T.Type = T.self,
                              body: @BackgroundActor @Sendable () async throws -> T) async rethrows -> T
    {
        try await body()
    }
    
    public static let shared = BackgroundActor()
}
