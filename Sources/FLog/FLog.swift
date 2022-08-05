import Foundation
import os.log

public protocol FLoggable {
    init(subsystem: String, category: String)
    func debug(_ s:String)
    func info(_ s:String)
    func notice(_ s:String)
    func warning(_ s:String)
    func error(_ s:String)
}

// wrapper around Logger to conform to Loggable
// FLoggable allows us to use different logging implementations (and mocking for tests)
@available(iOS 14.0, *)
struct FLogger: FLoggable {
    let logger: Logger
    
    init(subsystem: String, category: String) {
        self.logger = Logger(subsystem: subsystem, category: category)
    }
    
    func debug(_ s: String) { logger.debug("\(s)")}
    func info(_ s: String) { logger.info("\(s)")}
    func notice(_ s: String) { logger.notice("\(s)")}
    func warning(_ s: String) { logger.warning("\(s)")}
    func error(_ s: String) { logger.error("\(s)")}
}

enum FLogLevel: String {
    case debug = "🔵[debug] "
    case info = "🟢[info] "
    case notice = "🟡[notice] "
    case warning = "🟠[warning] "
    case error = "🔴[error] "
    
    func pretty(_ message: String) -> String {
        return "\(self.rawValue)\(message)"
    }
}


/**
  See ``FLog`` for the typical usage.
 */
@available(iOS 14.0, *)
public struct FLogBase {
    public static let subsystem = Bundle.main.bundleIdentifier ?? "FLog"
    public static let category = "FLog"
    
    public let logger: FLoggable
    
    
    public func debug(_ message: String) {
        logger.debug(FLogLevel.debug.pretty(message))
    }
    
    public func info(_ message: String) {
        logger.info(FLogLevel.info.pretty(message))
    }
    
    public func notice(_ message: String) {
        logger.notice(FLogLevel.notice.pretty(message))
    }
    
    public func warning(_ message: String) {
        logger.warning(FLogLevel.warning.pretty(message))
    }
    
    public func error(_ message: String) {
        logger.error(FLogLevel.error.pretty(message))
    }


    public init(subsystem: String = subsystem, category: String = category) {
        self.init(subsystem: subsystem, category: category, loggerType: FLogger.self)
    }
    
    public init(subsystem: String = subsystem, category: String = category, loggerType: FLoggable.Type) {
        self.logger = loggerType.init(subsystem: subsystem, category: category)
    }
}

/**
Extending Logger so we can format the messages
 
Typical Usage
 
```
class MyClass {
    let log = FLog<MyClass>.make()
 
        // ... then to log
        Self.log.debug("LogMe")
}
```
*/
@available(iOS 14.0, *)
public struct FLog<T>{
    public static func make() -> FLogBase {
        let logName = String(describing: T.self as Any)
        return FLogBase(category: logName)
    }
}
