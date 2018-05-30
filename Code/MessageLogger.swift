public func log(error: String,
                file: String = #file,
                function: String = #function,
                line: Int = #line)
{
    Log.shared.log(message: error,
                   level: .error,
                   file: file,
                   function: function,
                   line: line)
}

public func log(warning: String,
                file: String = #file,
                function: String = #function,
                line: Int = #line)
{
    Log.shared.log(message: warning,
                   level: .warning,
                   file: file,
                   function: function,
                   line: line)
}

public func log(_ message: String,
                file: String = #file,
                function: String = #function,
                line: Int = #line)
{
    Log.shared.log(message: message,
                   level: .info,
                   file: file,
                   function: function,
                   line: line)
}

public extension Logger
{
    func log(error: String,
             file: String = #file,
             function: String = #function,
             line: Int = #line)
    {
        Log.shared.log(sender: self,
                       message: error,
                       level: .error,
                       file: file,
                       function: function,
                       line: line)
    }
    
    func log(warning: String,
             file: String = #file,
             function: String = #function,
             line: Int = #line)
    {
        Log.shared.log(sender: self,
                       message: warning,
                       level: .warning,
                       file: file,
                       function: function,
                       line: line)
    }
    
    func log(_ message: String,
             file: String = #file,
             function: String = #function,
             line: Int = #line)
    {
        Log.shared.log(sender: self,
                       message: message,
                       level: .info,
                       file: file,
                       function: function,
                       line: line)
    }
}

public protocol Logger
{
    func log(error: String, file: String, function: String, line: Int)
    func log(warning: String, file: String, function: String, line: Int)
    func log(_ message: String, file: String, function: String, line: Int)
}

public class Log
{
    // MARK: - Singleton Access
    
    public static let shared = Log()
    
    private init() {}
    
    // MARK: - Logging
    
    public func log(sender: Any? = nil,
                    message: String,
                    level: Level = .info,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line)
    {
        guard level.integer >= minimumLevel.integer else { return }
        
        var logString = sender != nil ? typeName(of: sender) : ""
        
        if level != .info
        {
            if logString.count > 0 { logString += " " }
            
            logString += level.rawValue.uppercased()
        }
        
        if logString.count > 0 { logString += ": " }
        
        logString += message
        
        let filename = file.components(separatedBy: "/").last ?? file
        
        logString += " (\(filename), \(function), line \(line))"
        
        print(logString)
    }
    
    // MARK: - Log Levels
    
    public var minimumLevel: Level = .info
    
    public enum Level: String
    {
        var integer: Int
        {
            switch self
            {
            case .info: return 0
            case .warning: return 1
            case .error: return 2
            }
        }
        case info, warning, error
    }
}
