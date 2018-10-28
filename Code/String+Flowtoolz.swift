public extension String
{
    init?(withNonEmpty string: String?)
    {
        guard let string = string, string != "" else
        {
            return nil
        }
        
        self = string
    }

    init(unicode: Int)
    {
        var unicodeCharacter = unichar(unicode)
        
        self = String(utf16CodeUnits: &unicodeCharacter, count: 1)
    }
    
    public static var uuid: String
    {
        // create random bytes
        
        var bytes = [Byte]()
        
        for _ in 0 ..< 16 { bytes.append(Byte.random()) }
        
        // indicate UUID version and variant
        
        bytes[6] = (bytes[6] & 0x0f) | 0x40 // version 4
        bytes[8] = (bytes[8] & 0x3f) | 0x80 // variant 1
        
        // create string representation
        
        let ranges = [0 ..< 4, 4 ..< 6, 6 ..< 8, 8 ..< 10, 10 ..< 16]
        
        return ranges.map
        {
            range in
            
            var string = ""
            
            for i in range
            {
                string += String(bytes[i], radix: 16, uppercase: false)
            }
            
            return string
        }.joined(separator: "-")
    }
}
