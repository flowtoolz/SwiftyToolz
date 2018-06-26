public class Clipboard<Object: Copyable>
{
    public init() {}
    
    public var count: Int { return storedObjects.count }
    
    public func removeAll()
    {
        storedObjects.removeAll()
    }
    
    public func storeCopies(of objects: [Object])
    {
        storedObjects = objects.map { $0.copy }
    }
    
    public var copiesOfStoredObjects: [Object]
    {
        return storedObjects.map { $0.copy }
    }
    
    private var storedObjects = [Object]()
}
