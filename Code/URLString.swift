// Allow URLString as right operand
public func + (base: URLString, path: URLString) -> URLString {
   base + path.value
}

// Append path operator
public func + (base: URLString, path: String) -> URLString {
   // Handle empty path
   guard !path.isEmpty else { return base }
   
   // Get base without trailing slash
   let baseValue = base.value.hasSuffix("/")
       ? String(base.value.dropLast())
       : base.value
   
   // Get path without leading slash
   let pathValue = path.hasPrefix("/")
       ? String(path.dropFirst())
       : path
   
   // Combine with single slash
   return URLString(baseValue + "/" + pathValue)
}

public struct URLString: ExpressibleByStringLiteral, Sendable
{
    public init(stringLiteral value: String)
    {
        self.value = value
    }
    
    public init(_ value: String)
    {
        self.value = value
    }
    
    public let value: String
}
