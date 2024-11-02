@available(macOS 14.0, iOS 16.0, *)
public func withTimeout<Result>
(
    after duration: Duration,
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
            try await Task.sleep(for: duration)
            throw TimeoutError(duration: duration)
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

@available(macOS 13.0, iOS 16.0, *)
public struct TimeoutError: Error
{
    public let duration: Duration
}
