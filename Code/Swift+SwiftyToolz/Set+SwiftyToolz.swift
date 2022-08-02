public extension Set
{
    static func + (left: Set<Element>,
                   right: Element) -> Set<Element>
    {
        left + Set<Element>([right])
    }
    
    static func + (left: Element,
                   right: Set<Element>) -> Set<Element>
    {
        Set<Element>([left]) + right
    }
    
    static func + (left: Set<Element>,
                   right: Set<Element>) -> Set<Element>
    {
        left.union(right)
    }
    
    static func - (left: Set<Element>,
                   right: Element) -> Set<Element>
    {
        left - Set<Element>([right])
    }
    
    static func - (left: Set<Element>,
                   right: Set<Element>) -> Set<Element>
    {
        left.subtracting(right)
    }
    
    static func -= (left: inout Set<Element>,
                    right: Element)
    {
        left.remove(right)
    }
    
    static func -= (left: inout Set<Element>,
                    right: Set<Element>)
    {
        left.subtract(right)
    }
    
    static func * (left: Set<Element>,
                   right: Set<Element>) -> Set<Element>
    {
        left.intersection(right)
    }
    
    static func += (left: inout Set<Element>,
                    right: Set<Element>)
    {
        left.formUnion(right)
    }
    
    static func += (left: inout Set<Element>,
                    right: Element)
    {
        left.insert(right)
    }
}
