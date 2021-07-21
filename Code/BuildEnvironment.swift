public struct BuildEnvironment
{
    public static var isOfflineDevelopment: Bool
    {
        get { isDebugConfiguration ? prefersOfflineDevelopment : false }
        set { prefersOfflineDevelopment = newValue }
    }
    
    private static var prefersOfflineDevelopment = false
    
    public static var isSimulator: Bool
    {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    public static var isDebugConfiguration: Bool
    {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
