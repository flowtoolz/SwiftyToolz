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
}
