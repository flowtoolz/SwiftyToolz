public extension String
{
    static func enumerating(names: [String],
                            stringForAnd and: String = "and") -> String {
        var result = ""
        
        for index in 0 ..< names.count {
            if !result.isEmpty {
                if index == names.count - 1 {
                    result += " \(and) "
                } else {
                    result += ", "
                }
            }
            result += names[index]
        }
        
        return result
    }
    
    var fileExtensionFromName: Substring?
    {
        guard let dotIndex = lastIndex(of: ".") else { return nil }
        let lastPart = self[index(after: dotIndex) ..< endIndex]
        guard (1 ... 4).contains(lastPart.count) else { return nil }
        return lastPart
    }
    
    var fileNameFromPath: Substring?
    {
        guard let pathEnd = lastIndex(of: "/") else { return nil }
        return self[index(after: pathEnd) ..< endIndex]
    }
    
    init?(withNonEmpty string: String?)
    {
        guard let string = string, string != "" else { return nil }
        
        self = string
    }
    
    static func makeUUID() -> String
    {
        // create random bytes
        
        var bytes = [Byte]()
        
        16.times { bytes.append(Byte.random) }
        
        // indicate UUID version and variant
        
        bytes[6] = (bytes[6] & 0x0f) | 0x40 // version 4
        bytes[8] = (bytes[8] & 0x3f) | 0x80 // variant 1
        
        // create string representation
        
        let ranges = [0 ..< 4, 4 ..< 6, 6 ..< 8, 8 ..< 10, 10 ..< 16]
        
        return ranges.map
        {
            var string = ""
            
            for i in $0
            {
                string += String(bytes[i], radix: 16, uppercase: false)
            }
            
            return string
        }.joined(separator: "-")
    }
}
