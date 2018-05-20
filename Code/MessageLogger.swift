public func log(error: String, file: String = #file, line: Int = #line)
{
    Log.shared.log(message: error,
                   level: .error,
                   file: file,
                   line: line)
}

public func log(warning: String, file: String = #file, line: Int = #line)
{
    Log.shared.log(message: warning,
                   level: .warning,
                   file: file,
                   line: line)
}

public func log(_ message: String, file: String = #file, line: Int = #line)
{
    Log.shared.log(message: message,
                   level: .info,
                   file: file,
                   line: line)
}

public extension Logger
{
    func log(error: String, file: String = #file, line: Int = #line)
    {
        Log.shared.log(sender: self,
                       message: error,
                       level: .error,
                       file: file,
                       line: line)
    }
    
    func log(warning: String, file: String = #file, line: Int = #line)
    {
        Log.shared.log(sender: self,
                       message: warning,
                       level: .warning,
                       file: file,
                       line: line)
    }
    
    func log(_ message: String, file: String = #file, line: Int = #line)
    {
        Log.shared.log(sender: self,
                       message: message,
                       level: .info,
                       file: file,
                       line: line)
    }
}

public protocol Logger
{
    func log(error: String, file: String, line: Int)
    func log(warning: String, file: String, line: Int)
    func log(_ message: String, file: String, line: Int)
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
                    line: Int = #line)
    {
        var logString = sender != nil ? typeName(of: sender) : ""
        
        if level != .info
        {
            if logString.count > 0 { logString += " " }
            
            logString += level.rawValue.uppercased()
        }
        
        if logString.count > 0 { logString += ": " }
        
        logString += message
        
        let filename = file.components(separatedBy: "/").last ?? file
        
        logString += " (\(filename) at line \(line))"
        
        print(logString)
    }
    
    // MARK: - Log Levels
    
    public enum Level: String { case info, warning, error }
}
