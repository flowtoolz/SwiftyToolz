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
        guard level.integer >= minimumLevel.integer else { return }
        
        let filename = filePath.fileNameFromPath.map(String.init) ?? filePath
        
        let entry = Entry(message: message,
                          title: title,
                          level: level,
                          forUser: forUser,
                          fileName: filename,
                          function: function,
                          line: line)
    
        print(entry.description + "\n")
        
        LogObservers.receive(entry)
    }
    
    func add(observer: LogObserver)
    {
        LogObservers.add(observer)
    }
    
    func remove(observer: LogObserver)
    {
        LogObservers.remove(observer)
    }
}

private struct LogObservers
{
    static func add(_ observer: LogObserver)
    {
        observers[observer.key] = WeakObserver(observer: observer)
    }
    
    static func remove(_ observer: LogObserver)
    {
        observers[observer.key] = nil
    }
    
    static func receive(_ entry: Log.Entry)
    {
        observers.remove { $0.observer == nil }
        observers.values.forEach { $0.observer?.receive(entry) }
    }
    
    static var observers = [LogObserver.Key : WeakObserver]()
    
    struct WeakObserver
    {
        weak var observer: LogObserver?
    }
}

extension LogObserver
{
    var key: Key { Key(self) }
    typealias Key = ObjectIdentifier
}

// TODO: why force the log observer to adopt a protocol, isn't it enought to require it's a class object? -> store receive closure in WeakObserver ...
public protocol LogObserver: AnyObject
{
    func receive(_ entry: Log.Entry)
}

public class Log
{
    // MARK: - Singleton Access
    
    public static let shared = Log()
    private init() {}
    
    // MARK: - Entry
    
    public struct Entry: Codable, Equatable
    {
        public var description: String
        {
            var prefix = Entry.prefix
            
            if level != .info
            {
                prefix += " " + level.rawValue.uppercased()
            }
            
            if prefix.count > 0 { prefix += ": " }
            
            return "\(prefix)\(message)\n    (\(context))"
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
        public static var prefix = ""
    }
    
    // MARK: - Levels
    
    public var minimumLevel: Level = .info
    
    public enum Level: String, Codable, Equatable
    {
        var integer: Int
        {
            switch self
            {
            case .info: return 0
            case .warning: return 1
            case .error: return 2
            case .off: return 3
            }
        }
        
        case info, warning, error, off
    }
}
