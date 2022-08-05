import XCTest
import FLog


@available(iOS 14.0, *)
class ClassToLog {
    static let log = FLog<ClassToLog>.make()
}

@available(iOS 14.0, *)
final class FLogAPITests: XCTestCase {
    
    func test_FLog_is_logger() throws {
        let logger = FLog<FLogTests>.make()
        logger.debug("Test")
        XCTAssertEqual(String(describing: type(of: logger.logger)), "FLogger")
    }
    
    func test_FLog_make_subsystem() throws {
        let logger = FLog<FLogTests>.make()
        let subsystem = Bundle.main.bundleIdentifier
        XCTAssertEqual(type(of: logger).subsystem, subsystem)
    }
    
    func test_FLog_make_category() throws {
        let logger = FLog<FLogTests>.make()
        let category = "FLog"
        XCTAssertEqual(type(of: logger).category, category)
    }
}
