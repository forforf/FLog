import XCTest
@testable import FLog

struct LoggerAssert {
    var debug: (_ s: String) -> Void = { s in XCTAssert(true) }
    var info: (_ s: String) -> Void = { s in XCTAssert(true) }
    var notice: (_ s: String) -> Void = { s in XCTAssert(true) }
    var warning: (_ s: String) -> Void = { s in XCTAssert(true) }
    var error: (_ s: String) -> Void = { s in XCTAssert(true) }
}

struct LoggerMock: FLoggable {
    
    static var assert = LoggerAssert()
    let subsystem: String
    let category: String
    
    
    init(subsystem: String, category: String) {
        self.subsystem = subsystem
        self.category = category
    }
    
    func debug(_ s: String) { LoggerMock.assert.debug(s) }
    func info(_ s: String) { LoggerMock.assert.info(s) }
    func notice(_ s: String) { LoggerMock.assert.notice(s) }
    func warning(_ s: String) { LoggerMock.assert.warning(s) }
    func error(_ s: String) { LoggerMock.assert.error(s) }
}

@available(iOS 14.0, *)
final class FLogTests: XCTestCase {
    
    // TODO: Figure out a way to test formatting that doesn't complicate the base class
    func test_FLog_debug_format() throws {
        let message = "Test debug message."
        let logEntry = "🔵[debug] \(message)"
        // override the debug assert
        let loggerAssert = LoggerAssert(debug: {s in XCTAssertEqual(s, logEntry) })
        LoggerMock.assert = loggerAssert
        let flogger = FLogBase(subsystem: "Subsystem", category: "Category", loggerType: LoggerMock.self)
        // Uncomment when modifying code to be sure to catch false positives
        // XCTExpectFailure("Expected failure to prevent false positives") {
        //    flogger.debug("blah")
        // }
        flogger.debug(message)
    }
    
    func test_FLog_info_format() throws {
        let message = "Test info message."
        let logEntry = "🟢[info] \(message)"
        let loggerAssert = LoggerAssert(info: {s in XCTAssertEqual(s, logEntry) })
        LoggerMock.assert = loggerAssert
        let flogger = FLogBase(subsystem: "Subsystem", category: "Category", loggerType: LoggerMock.self)
        // Uncomment when modifying code to be sure to catch false positives
        // XCTExpectFailure("Expected failure to prevent false positives") {
        //     flogger.info("blah")
        // }
        flogger.info(message)
    }
    
    func test_FLog_notice_format() throws {
        let message = "Test notice message."
        let logEntry = "🟡[notice] \(message)"
        let loggerAssert = LoggerAssert(notice: {s in XCTAssertEqual(s, logEntry) })
        LoggerMock.assert = loggerAssert
        let flogger = FLogBase(subsystem: "Subsystem", category: "Category", loggerType: LoggerMock.self)
        // Uncomment when modifying code to be sure to catch false positives
        // XCTExpectFailure("Expected failure to prevent false positives") {
        //     flogger.notice("blah")
        // }
        flogger.notice(message)
    }
    
    func test_FLog_warning_format() throws {
        let message = "Test warning message."
        let logEntry = "🟠[warning] \(message)"
        let loggerAssert = LoggerAssert(warning: {s in XCTAssertEqual(s, logEntry) })
        LoggerMock.assert = loggerAssert
        let flogger = FLogBase(subsystem: "Subsystem", category: "Category", loggerType: LoggerMock.self)
        // Uncomment when modifying code to be sure to catch false positives
        // XCTExpectFailure("Expected failure to prevent false positives") {
        //     flogger.warning("blah")
        // }
        flogger.warning(message)
    }
    
    func test_FLog_error_format() throws {
        let message = "Test info message."
        let logEntry = "🔴[error] \(message)"
        let loggerAssert = LoggerAssert(error: {s in XCTAssertEqual(s, logEntry) })
        LoggerMock.assert = loggerAssert
        let flogger = FLogBase(subsystem: "Subsystem", category: "Category", loggerType: LoggerMock.self)
        // Uncomment when modifying code to be sure to catch false positives
        // XCTExpectFailure("Expected failure to prevent false positives") {
        //     flogger.error("blah")
        // }
        flogger.error(message)
    }
}
