public extension Error
{
    var readable: ReadableError
    {
        return self as? ReadableError ?? .message(self as? String ?? "\(self)")
    }
}

public enum ReadableError: Error, CustomDebugStringConvertible
{
    public init(_ message: String) { self = .message(message) }
    
    public var localizedDescription: String
    {
        return message
    }
    
    public var debugDescription: String
    {
        return message
    }
    
    public var message: String
    {
        switch self
        {
        // TODO: can we make this more readable with https://github.com/mxcl/LegibleError ?
        case .message(let text): return text
        }
    }
    
    case message(_ text: String)
}
