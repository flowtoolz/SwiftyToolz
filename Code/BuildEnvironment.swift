public struct BuildEnvironment
{
    public static var isSimulator: Bool
    {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    /// TODO: it is still unclear whether this really works as part of an external package. the package seems to receive its own build configuration. just removing "DEBUG" from the project or target build configs does not effect this here. testing it is also difficult, i couldn't run run a macos client locally with release configuration ... so i haven't verified yet that this will return false when compiled with a client app for release ...
    public static var isDebugConfiguration: Bool
    {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
