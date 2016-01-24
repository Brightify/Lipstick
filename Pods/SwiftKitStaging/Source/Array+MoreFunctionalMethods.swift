public extension Array {

    public func arrayByAppending(elements: Element...) -> Array<Element> {
        return arrayByAppending(elements)
    }
    
    public func arrayByAppending(elements: [Element]) -> Array<Element> {
        var mutableCopy = self
        mutableCopy.appendContentsOf(elements)
        return mutableCopy
    }
    
    public func product<U>(other: [U]) -> Array<(Element, U)> {
        return flatMap { t in
            other.map { u in (t, u) }
        }
    }
}