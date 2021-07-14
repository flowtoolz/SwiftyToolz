public struct BuildEnvironment {
    
    public static var isOfflineDevelopment: Bool = false
    
    public static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    public static var isDebugConfiguration: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
