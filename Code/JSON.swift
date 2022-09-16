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
    
    public func dictionary(_ field: String? = nil) throws -> [String: JSON]
    {
        if let field { return try at(field).dictionary() }
        guard case .dictionary(let dict) = self else { throw "JSON is not a Dictionary" }
        return dict
    }
    
    // MARK: - Array Elements
    
    public subscript(index: Int) -> JSON?
    {
        guard case .array(let array) = self else { return nil }
        return array.indices.contains(index) ? array[index] : nil
    }
    
    public func at(_ index: Int) throws -> JSON
    {
        guard case .array(let array) = self else
        {
            throw "JSON is not an array"
        }
        
        guard array.indices.contains(index) else
        {
            throw "JSON array contains no index \(index)"
        }
        
        return array[index]
    }
    
    // MARK: - Dictionary Elements
    
    public subscript(key: String) -> JSON?
    {
        guard case .dictionary(let dictionary) = self else { return nil }
        return dictionary[key]
    }
    
    public func at(_ key: String) throws -> JSON
    {
        guard case .dictionary(let dictionary) = self else
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

/// JSON with Dynamic Lookup of Dictionary Elements
@dynamicMemberLookup
public enum JSON
{
    public subscript(dynamicMember member: String) -> JSON?
    {
        guard case .dictionary(let dictionary) = self else { return nil }
        return dictionary[member]
    }
    
    case null
    case bool(Bool)
    case int(Int)
    case string(String)
    case array([JSON])
    case dictionary([String: JSON])
}
