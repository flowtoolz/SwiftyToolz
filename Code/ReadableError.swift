public extension Error
{
    var readable: ReadableError
    {
        return self as? ReadableError ?? .message(self as? String ?? "\(self)")
    }
}

extension String: Error {}

public enum ReadableError: Error, CustomStringConvertible, CustomDebugStringConvertible
{
    public init(_ text: String) { self = .message(text) }
    
    public var description: String { return message }
    
    public var debugDescription: String { return message }
    
    public var message: String
    {
        switch self { case .message(let text): return text }
    }
    
    case message(_ text: String)
}
