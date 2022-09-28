public extension Dictionary
{
    mutating func remove(where shouldRemove: (Value) -> Bool)
    {
        for (key, value) in self
        {
            if shouldRemove(value) { self[key] = nil }
        }
    }
    
    // MARK: - Merge Dictionaries
    
    static func + (left: [Key: Value], right: [Key: Value]) -> [Key: Value]
    {
        left.merging(right) { left, _ in left }
    }
    
    static func += (left: inout [Key: Value], right: [Key: Value])
    {
        left.merge(right) { $1 }
    }
}
