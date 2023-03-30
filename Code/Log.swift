public func log(error: String,
                title: String? = nil,
                forUser: Bool = false,
                filePath: String = #file,
                function: String = #function,
                line: Int = #line)
{
    Log.shared.log(message: error,
                   title: title,
                   level: .error,
                   forUser: forUser,
                   filePath: filePath,
                   function: function,
                   line: line)
}

public func log(warning: String,
                title: String? = nil,
                forUser: Bool = false,
                filePath: String = #file,
                function: String = #function,
                line: Int = #line)
{
    Log.shared.log(message: warning,
                   title: title,
                   level: .warning,
                   forUser: forUser,
                   filePath: filePath,
                   function: function,
                   line: line)
}

public func log(_ message: String = "",
                title: String? = nil,
                forUser: Bool = false,
                filePath: String = #file,
                function: String = #function,
                line: Int = #line)
{
    Log.shared.log(message: message,
                   title: title,
                   level: .info,
                   forUser: forUser,
                   filePath: filePath,
                   function: function,
                   line: line)
}

public func log(verbose message: String = "",
                title: String? = nil,
                forUser: Bool = false,
                filePath: String = #file,
                function: String = #function,
                line: Int = #line)
{
    Log.shared.log(message: message,
                   title: title,
                   level: .verbose,
                   forUser: forUser,
                   filePath: filePath,
                   function: function,
                   line: line)
}

public extension Log
{
    func log(message: String,
             title: String? = nil,
             level: Level = .info,
             forUser: Bool = false,
             filePath: String = #file,
             function: String = #function,
             line: Int = #line)
    {
        let filename = filePath.fileNameFromPath.map(String.init) ?? filePath
        
        let entry = Entry(message: message,
                          title: title,
                          level: level,
                          forUser: forUser,
                          fileName: filename,
                          function: function,
                          line: line)
    
        if level >= minimumPrintLevel { print(entry.description) }
        
        LogObservers.receive(entry)
    }
    
    func add(observer: AnyObject,
             receiveEntry: @escaping (Log.Entry) -> Void)
    {
        LogObservers.add(observer,
                         receiveEntry: receiveEntry)
    }
    
    func remove(observer: AnyObject)
    {
        LogObservers.remove(observer)
    }
}

private struct LogObservers
{
    static func add(_ observer: AnyObject,
                    receiveEntry: @escaping (Log.Entry) -> Void)
    {
        observers[ObjectIdentifier(observer)] = WeakObserver(observer: observer,
                                                             receiveEntry: receiveEntry)
    }
    
    static func remove(_ observer: AnyObject)
    {
        observers[ObjectIdentifier(observer)] = nil
    }
    
    static func receive(_ entry: Log.Entry)
    {
        observers.remove { $0.observer == nil }
        observers.values.forEach { $0.receiveEntry(entry) }
    }
    
    static var observers = [ObjectIdentifier : WeakObserver]()
    
    struct WeakObserver
    {
        weak var observer: AnyObject?
        let receiveEntry: (Log.Entry) -> Void
    }
}

public class Log
{
    // MARK: - Singleton Access
    
    public static let shared = Log()
    private init() {}
    
    // MARK: - Entry
    
    public struct Entry: Codable, Equatable, Sendable, Identifiable, Comparable
    {
        public static func < (lhs: Entry, rhs: Entry) -> Bool
        {
            lhs.id < rhs.id
        }
        
        public var description: String
        {
            var result = ""
            
            switch level
            {
            case .verbose: break
            case .info: result += "ℹ️ "
            case .warning: result += "⚠️ "
            case .error: result += "🛑 "
            }
            
            result += message
            
            if level >= Level.warning
            {
                result += "\n(\(context))"
            }
             
            return result
        }
        
        public var context: String
        {
            return "\(fileName), \(function), line \(line)"
        }
        
        public var message = ""
        public var title: String?
        public var level = Level.info
        public var forUser = false
        public var fileName = ""
        public var function = ""
        public var line = 0
        
        public var id: Int =
        {
            let newID = nextID
            nextID += 1
            return newID
        }()
        
        private static var nextID = 0
    }
    
    // MARK: - Levels
    
    public var minimumPrintLevel: Level = .info
    
    public enum Level: Int, Codable, Equatable, Comparable, Sendable, CaseIterable, Identifiable
    {
        public var displayName: String
        {
            switch self
            {
            case .verbose: return "Verbose"
            case .info: return "Info"
            case .warning: return "Warning"
            case .error: return "Error"
            }
        }
        
        public var id: Int { rawValue }
        
        public static func < (lhs: Level, rhs: Level) -> Bool
        {
            lhs.rawValue < rhs.rawValue
        }
        
        case verbose, info, warning, error
    }
}
