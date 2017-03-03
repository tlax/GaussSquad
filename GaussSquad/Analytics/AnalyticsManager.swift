import Foundation
import Google
import FirebaseAnalytics

class AnalyticsManager
{
    enum FroobAction:String
    {
        case plusClose = "Plus/Close"
        case plusStore = "Plus/Store"
    }
    
    enum StoreAction:String
    {
        case purchase = "Purchase"
        case restore = "Restore"
    }
    
    enum ShareAction:String
    {
        case solutionImageComplete = "Solution/Image/Complete"
        case solutionImageStep = "Solution/Image/Step"
        case solutionTextComplete = "Solution/Text/Complete"
        case solutionTextStep = "Solution/Text/Step"
        case plot = "Plot"
        case app = "App"
    }
    
    static let sharedInstance:AnalyticsManager? = AnalyticsManager()
    private let kEventShare:String = "Share"
    private let kEventFroob:String = "Froob"
    private let kEventStore:String = "Store"
    private let kEventValue:NSNumber = 1
    private let kDispatchInterval:TimeInterval = 30
    
    private init?()
    {
        #if DEBUG
            
            return nil
            
        #endif
        
        var configurationError:NSError?
        
        GGLContext.sharedInstance().configureWithError(&configurationError)
        
        if let configurationError:NSError = configurationError
        {
            print(configurationError.localizedDescription)
            
            return nil
        }
    }
    
    //MARK: public
    
    func startAnalytics()
    {
        guard
            
            let gai:GAI = GAI.sharedInstance()
            
        else
        {
            return
        }
        
        gai.trackUncaughtExceptions = true
        gai.logger.logLevel = GAILogLevel.none
        gai.dispatchInterval = kDispatchInterval
    }
    
    func trackScreen(screen:UIViewController)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            guard
                
                let tracker:GAITracker = GAI.sharedInstance().defaultTracker
                
            else
            {
                return
            }
            
            let screenName:String = String(describing:type(of:screen))
            tracker.set(kGAIScreenName, value:screenName)
            let screenBuild:[NSObject:AnyObject] = GAIDictionaryBuilder.createScreenView().build() as [NSObject:AnyObject]
            tracker.send(screenBuild)
        }
    }
    
    func trackShare(action:ShareAction)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            guard
                
                let tracker:GAITracker = GAI.sharedInstance().defaultTracker
                
            else
            {
                return
            }
            
            let eventBuild:[NSObject:AnyObject] = GAIDictionaryBuilder.createEvent(
                withCategory:self.kEventShare,
                action:action.rawValue,
                label:nil,
                value:self.kEventValue).build() as [NSObject:AnyObject]
            tracker.send(eventBuild)
        }
    }
    
    func trackFroob(action:FroobAction)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            guard
                
                let tracker:GAITracker = GAI.sharedInstance().defaultTracker
                
            else
            {
                return
            }
            
            let eventBuild:[NSObject:AnyObject] = GAIDictionaryBuilder.createEvent(
                withCategory:self.kEventFroob,
                action:action.rawValue,
                label:nil,
                value:self.kEventValue).build() as [NSObject:AnyObject]
            tracker.send(eventBuild)
        }
    }
    
    func trackStore(action:StoreAction, purchase:String?)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            guard
                
                let tracker:GAITracker = GAI.sharedInstance().defaultTracker
                
            else
            {
                return
            }
            
            let eventBuild:[NSObject:AnyObject] = GAIDictionaryBuilder.createEvent(
                withCategory:self.kEventStore,
                action:action.rawValue,
                label:purchase,
                value:self.kEventValue).build() as [NSObject:AnyObject]
            tracker.send(eventBuild)
        }
    }
}
