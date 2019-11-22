public extension Array
{
    init(count: Int, make: () -> Element)
    {
        self.init()
        count.times { append(make()) }
    }
    
    func splitIntoSlices(ofSize size: Int) -> [ArraySlice<Element>]
    {
        guard size > 0 else { return [] }
        
        var result = [ArraySlice<Element>]()
        
        var sliceStart = -1
        var sliceEnd = -1
        
        while sliceEnd < count - 1
        {
            sliceStart = sliceEnd + 1
            sliceEnd = Swift.min(sliceEnd + size, count - 1)
            
            result.append(self[sliceStart ... sliceEnd])
        }
        
        return result
    }
    
    func forEachIndex(_ body: (_ element: Element,
                               _ index: Int) throws -> Void) rethrows
    {
        for index in 0 ..< count
        {
            try body(self[index], index)
        }
    }
    
    subscript(_ indexes: [Int]) -> [Element]
    {
        indexes.compactMap(at)
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
    
    func isValid(index: Int?) -> Bool
    {
        indices.contains(index ?? -1)
    }
    
    func at(_ index: Int?) -> Element?
    {
        guard let index = index else { return nil }
        return isValid(index: index) ? self[index] : nil
    }
}

extension Array where Element: Comparable
{    
    @discardableResult
    mutating func insertSorted(_ newElement: Element) -> Int
    {
        // TODO: use binary search to improve performance from O(n) to O(log2(n))
        let insertionIndex = firstIndex(where: { $0 > newElement }) ?? count
        insert(newElement, at: insertionIndex)
        return insertionIndex
    }
}
