public extension Array
{
    subscript(_ indexes: [Int]) -> [Element]
    {
        var result = [Element]()
        
        for index in indexes
        {
            guard isValid(index: index) else { continue }
            
            result.append(self[index])
        }
        
        return result
    }
    
    mutating func moveElement(from: Int, to: Int) -> Bool
    {
        guard from != to, isValid(index: from), isValid(index: to) else
        {
            return false
        }
        
        insert(remove(at: from), at: to)
        
        return true
    }
    
    mutating func limit(to maxCount: Int)
    {
        guard maxCount >= 0 else { return }
        
        removeLast(Swift.max(0, count - maxCount))
    }
    
    mutating func remove(where shouldRemove: (Element) -> Bool)
    {
        var index = count - 1
        
        while index >= 0
        {
            if shouldRemove(self[index]) { remove(at: index) }
            
            index -= 1
        }
    }
    
    func isValid(index: Int?) -> Bool
    {
        guard let index = index else { return false }
        
        return index >= 0 && index < count
    }
}
