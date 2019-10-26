public extension Error
{
    var readable: ReadableError
    {
        self as? ReadableError ?? .message(self as? String ?? "\(self)")
    }
}

extension String: Error {}

public enum ReadableError: Error, CustomStringConvertible, CustomDebugStringConvertible
{
    public init(_ text: String) { self = .message(text) }
    
    public var description: String { message }
    
    public var debugDescription: String { message }
    
    public var message: String
    {
        switch self { case .message(let text): return text }
    }
    
    case message(_ text: String)
}
