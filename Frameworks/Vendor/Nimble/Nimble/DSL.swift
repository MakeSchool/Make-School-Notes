/// Make an expectation on a given actual value. The value given is lazily evaluated.
public func expect<T>(expression: () -> T?, file: String = __FILE__, line: UInt = __LINE__) -> Expectation<T> {
    return Expectation(
        expression: Expression(
            expression: expression,
            location: SourceLocation(file: file, line: line),
            isClosure: true))
}

public func expect<T>(value: T?, file: String = __FILE__, line: UInt = __LINE__) -> Expectation<T> {
    return Expectation(
        expression: Expression(
            expression: { value },
            location: SourceLocation(file: file, line: line),
            isClosure: false))
}

/// Make an expectation on a given actual value. The closure is lazily invoked.
public func expect<T>(file: String = __FILE__, line: UInt = __LINE__, expression: () -> T?) -> Expectation<T> {
    return Expectation(
        expression: Expression(
            expression: expression,
            location: SourceLocation(file: file, line: line),
            isClosure: true))
}

/// Always fails the test with a message and a specified location.
public func fail(message: String, #location: SourceLocation) {
    NimbleAssertionHandler.assert(false, message: message, location: location)
}

/// Always fails the test with a message.
public func fail(message: String, file: String = __FILE__, line: UInt = __LINE__) {
    fail(message, location: SourceLocation(file: file, line: line))
}

/// Always fails the test.
public func fail(file: String = __FILE__, line: UInt = __LINE__) {
    fail("fail() always fails")
}