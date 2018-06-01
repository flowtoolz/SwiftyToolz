public struct WeakArray<T: AnyObject>
{
    public init() {}
    
    public var count: Int { return array.count }
    
    public var elements: [T?]
    {
        get { return array.map { $0.object } }
        
        set { array = newValue.map { Weak($0) } }
    }
    
    public subscript(index: Int) -> T?
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
    
    public mutating func remove(at index: Int) -> T?
    {
        guard isValid(index: index) else { return nil }
        
        return array.remove(at: index).object
    }
    
    public func isValid(index: Int?) -> Bool
    {
        return array.isValid(index: index)
    }
    
    public mutating func insert(_ object: T, at index: Int)
    {
        guard index >= 0 && index <= array.count else { return }
        
        array.insert(Weak(object), at: index)
    }
    
    public mutating func removeAll() { array.removeAll() }
    
    private var array = [Weak<T>]()
}

public struct Weak<T: AnyObject>
{
    public init(_ object: T?)
    {
        self.object = object
    }
    
    public weak var object: T?
}
