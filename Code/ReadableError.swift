public func log(_ error: Error,
                title: String? = nil,
                forUser: Bool = false,
                filePath: String = #file,
                function: String = #function,
                line: Int = #line)
{
    log(error: error.readable.message,
        title: title,
        forUser: forUser,
        filePath: filePath,
        function: function,
        line: line)
}

public extension Error
{
    static func readable(_ text: String) -> ReadableError { .init(text) }
    
    var readable: ReadableError
    {
        switch self
        {
        case let readableError as ReadableError:
            return readableError
        case let string as String:
            return .message(string)
        case let convertible as ReadableErrorConvertible:
            return .message(convertible.readableMessage)
        default:
            return .message(ReadableError.readableMessageForError?(self) ?? "\(self)")
        }
    }
}

public protocol ReadableErrorConvertible
{
    var readableMessage: String { get }
}

extension String: Error {}

public enum ReadableError: Error, CustomStringConvertible, CustomDebugStringConvertible
{
    public static var readableMessageForError: ((Error) -> String)?
    
    public init(_ text: String) { self = .message(text) }
    
    public var description: String { message }
    
    public var debugDescription: String { message }
    
    public var message: String
    {
        switch self { case .message(let text): return text }
    }
    
    case message(_ text: String)
}
