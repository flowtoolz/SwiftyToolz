@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
public func withTimeout<Result>
(
    afterSeconds seconds: Double,
    startLongOperation: @escaping () async throws -> Result
)
async throws -> Result
{
    try await withThrowingTaskGroup(of: Result.self)
    {
        tasks in
        
        tasks.addTask
        {
            try await startLongOperation()
        }
        
        tasks.addTask
        {
            // TODO: use type Duration and Task.sleep(for: duration) as soon as we can require Ventura-level OS
            try await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
            throw TimeoutError(seconds: seconds)
        }
        
        guard let result = try await tasks.next() else
        {
            /// will never happen since `tasks` is not empty
            throw CancellationError()
        }
        
        tasks.cancelAll()
        return result
    }
}

public struct TimeoutError: Error
{
    public let seconds: Double
}
