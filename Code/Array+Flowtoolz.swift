public extension Array
{
    mutating func remove(where shouldRemove: (Element) -> Bool)
    {
        self = self.filter { !shouldRemove($0) }
    }
    
    mutating func limit(toCount limit: Int)
    {
        guard limit > -1 else { return }

        let toRemove = count - limit
        
        if toRemove > 0
        {
            removeFirst(toRemove)
        }
    }
    
    mutating func moveElement(from: Int, to: Int) -> Bool
    {
        guard isValid(index: from), isValid(index: to) else
        {
            return false
        }

        insert(remove(at: from), at: to)
        
        return true
    }
    
    func isValid(index: Int?) -> Bool
    {
        guard let index = index else { return false }
        
        return index >= 0 && index < count
    }
}
