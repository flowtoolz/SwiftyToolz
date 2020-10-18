/**
 For accessing ("decoding") JSON objects created via `JSONSerialization`
 */

public extension JSONObject
{
    func obj(_ key: String) throws -> JSONObject { try (self[key] as? JSONObject).unwrap() }
    func arr(_ key: String) throws -> JSONArray  { try (self[key] as? JSONArray ).unwrap() }
    func str(_ key: String) throws -> String     { try (self[key] as? String    ).unwrap() }
    func int(_ key: String) throws -> Int        { try (self[key] as? Int       ).unwrap() }
    func boo(_ key: String) throws -> Bool       { try (self[key] as? Bool      ).unwrap() }
    func any(_ key: String) throws -> JSON       { try  self[key]                .unwrap() }
}

public extension JSONArray
{
    func obj() throws -> [JSONObject] { try (self as? [JSONObject]).unwrap() }
    func arr() throws -> [JSONArray]  { try (self as? [JSONArray] ).unwrap() }
    func str() throws -> [String]     { try (self as? [String]    ).unwrap() }
    func int() throws -> [Int]        { try (self as? [Int]       ).unwrap() }
    func boo() throws -> [Bool]       { try (self as? [Bool]      ).unwrap() }
}

public typealias JSONObject = [String : JSON]
public typealias JSONArray = [JSON]
public typealias JSON = Any
