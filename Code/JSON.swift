/// Case Access
extension JSON
{
    // MARK: - Case Values
    
    public func null(_ field: String? = nil) throws
    {
        if let field { return try at(field).null() }
        guard case .null = self else { throw "JSON is not null" }
    }
    
    public func bool(_ field: String? = nil) throws -> Bool
    {
        if let field { return try at(field).bool() }
        guard case .bool(let bool) = self else { throw "JSON is not a Bool" }
        return bool
    }
    
    public func int(_ field: String? = nil) throws -> Int
    {
        if let field { return try at(field).int() }
        guard case .int(let int) = self else { throw "JSON is not an Int" }
        return int
    }
    
    public func string(_ field: String? = nil) throws -> String
    {
        if let field { return try at(field).string() }
        guard case .string(let string) = self else { throw "JSON is not a String" }
        return string
    }
    
    public func array(_ field: String? = nil) throws -> [JSON]
    {
        if let field { return try at(field).array() }
        guard case .array(let array) = self else { throw "JSON is not an Array" }
        return array
    }
    
    public func object(_ field: String? = nil) throws -> [String: JSON]
    {
        if let field { return try at(field).object() }
        guard case .object(let dict) = self else { throw "JSON is not a Dictionary" }
        return dict
    }
    
    // MARK: - Array Elements
    
    public subscript(index: Int) -> JSON?
    {
        try? at(index)
    }
    
    public func at(_ index: Int) throws -> JSON?
    {
        guard case .array(let array) = self else
        {
            throw "JSON is not an array"
        }
        
        return array.at(index)
    }
    
    // MARK: - Dictionary Elements
    
    public subscript(key: String) -> JSON?
    {
        guard case .object(let dictionary) = self else { return nil }
        return dictionary[key]
    }
    
    // TODO: this should rather return nil when it IS an object/dictionary but does NOT contain the key ...
    public func at(_ key: String) throws -> JSON
    {
        guard case .object(let dictionary) = self else
        {
            throw "JSON is not a dictionary"
        }
        
        guard let json = dictionary[key] else
        {
            throw "JSON dictionary contains no field \"\(key)\""
        }
        
        return json
    }
}

public extension JSON
{
    /// JSON but restricted to containers
    enum Container: Equatable
    {
        public init(_ json: JSON) throws
        {
            switch json
            {
            case .object(let dictionary): self = .object(dictionary)
            case .array(let array): self = .array(array)
            default: throw "JSON container must be either an array or an object."
            }
        }
        
        public func json() -> JSON
        {
            switch self
            {
            case .object(let dictionary): return .object(dictionary)
            case .array(let array): return .array(array)
            }
        }
        
        case array([JSON])
        case object([String: JSON])
    }
}

/// JSON with Dynamic Lookup of Dictionary- and Array Elements
@dynamicMemberLookup
public enum JSON: Equatable
{
    public subscript(dynamicMember member: String) -> JSON?
    {
        guard case .object(let dictionary) = self else { return nil }
        return dictionary[member]
    }
    
    case null
    case bool(Bool)
    case int(Int)
    case string(String)
    case array([JSON])
    case object([String: JSON])
}
