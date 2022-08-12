public extension Array
{
    static func + (array: Self, element: Element) -> Self
    {
        array + [element]
    }
    
    static func + (element: Element, array: Self) -> Self
    {
        [element] + array 
    }
    
    static func += (array: inout Self, element: Element)
    {
        array.append(element)
    }
    
    static func += (array: inout Self, elements: [Element])
    {
        array.append(contentsOf: elements)
    }
        
    init(count: Int, make: () throws -> Element) rethrows
    {
        self.init()
        try count.times { try append(make()) }
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
        guard let index = index else { return false }
        return indices.contains(index)
    }
    
    func at(_ index: Int?) -> Element?
    {
        guard let index = index else { return nil }
        return isValid(index: index) ? self[index] : nil
    }

    @discardableResult
    mutating func insertSorted(_ newElement: Element) -> Int where Element: Comparable
    {
        // TODO: use binary search to improve performance from O(n) to O(log2(n))
        let insertionIndex = firstIndex(where: { $0 > newElement }) ?? count
        insert(newElement, at: insertionIndex)
        return insertionIndex
    }
    
    @inlinable func withoutDuplicates() -> [Element] where Element: Hashable
    {
        Array(Set(self))
    }
    
    func average() -> Double? where Element: BinaryInteger
    {
        isEmpty ? nil : Double(reduce(0, +)) / Double(count)
    }
    
    func average() -> Double?  where Element: BinaryFloatingPoint
    {
        isEmpty ? nil : Double(reduce(0, +)) / Double(count)
    }
}
