public struct WeakArray<Element: AnyObject>: Collection, RangeReplaceableCollection
{
    public init() {}
    
    public var startIndex: Int { array.startIndex }
    public var endIndex: Int { array.endIndex }
    public func index(after i: Int) -> Int { array.index(after: i) }
    public var count: Int { array.count }
    
    public var elements: [Element?]
    {
        get { array.map { $0.object } }
        
        set { array = newValue.map { Weak($0) } }
    }
    
    public subscript(index: Int) -> Element?
    {
        get
        {
            guard isValid(index: index) else { return nil }
            
            return array[index].object
        }
        
        set
        {
            guard isValid(index: index) else { return }
            
            array[index] = Weak(newValue)
        }
    }
    
    public mutating func remove(at index: Int) -> Element?
    {
        guard isValid(index: index) else { return nil }
        
        return array.remove(at: index).object
    }
    
    public func isValid(index: Int?) -> Bool
    {
        array.isValid(index: index)
    }
    
    public mutating func insert(_ object: Element, at index: Int)
    {
        guard index >= 0 && index <= array.count else { return }
        
        array.insert(Weak(object), at: index)
    }
    
    public mutating func removeAll() { array.removeAll() }
    
    private var array = [Weak<Element>]()
}

public struct Weak<Object: AnyObject>
{
    public init(_ object: Object?)
    {
        self.object = object
    }
    
    public weak var object: Object?
}
