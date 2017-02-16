import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    let kMinNumber:Double = 0.0001
    private(set) var settings:DSettings?
    private let numberFormatter:NumberFormatter
    private let kNumberFormatterStyle:NumberFormatter.Style = NumberFormatter.Style.decimal
    private let kEmpty:String = ""
    private let kMinIntegers:Int = 1
    private let kMaxIntegers:Int = 10
    private let kMinDecimals:Int = 0
    private let kTtlDelta:Int16 = 1
    
    private init()
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = kNumberFormatterStyle
        numberFormatter.minimumIntegerDigits = kMinIntegers
        numberFormatter.maximumIntegerDigits = kMaxIntegers
        numberFormatter.minimumFractionDigits = kMinDecimals
    }
    
    //MARK: private
    
    private func asyncLoadSettings()
    {
        DManager.sharedInstance?.fetchData(
            entityName:DSettings.entityName)
        { (data) in
            
            guard
            
                let settings:DSettings = data?.first as? DSettings
            
            else
            {
                self.createSettings()
                
                return
            }
            
            self.settingsReady(settings:settings)
            self.addTtl()
        }
    }
    
    private func createSettings()
    {
        DManager.sharedInstance?.createData(
            entityName:DSettings.entityName)
        { (data) in
            
            guard
            
                let settings:DSettings = data as? DSettings
            
            else
            {
                return
            }
            
            DManager.sharedInstance?.save()
            self.settingsReady(settings:settings)
        }
    }
    
    private func settingsReady(settings:DSettings)
    {
        self.settings = settings
        numberFormatter.maximumFractionDigits = Int(settings.maxFractionDigits)
    }
    
    //MARK: public
    
    func loadSettings()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            if self.settings == nil
            {
                self.asyncLoadSettings()
            }
        }
    }
    
    func addTtl()
    {
        guard
            
            let settings:DSettings = self.settings
            
        else
        {
            return
        }
        
        settings.ttl += kTtlDelta
        DManager.sharedInstance?.save()
    }
    
    func stringFrom(number:Double) -> String
    {
        let nsNumber:NSNumber = NSNumber(value:number)
        
        guard
        
            let string:String = numberFormatter.string(from:nsNumber)
        
        else
        {
            return kEmpty
        }
        
        return string
    }
    
    func numberFrom(string:String) -> Double
    {
        guard
        
            let number:NSNumber = numberFormatter.number(
                from:string)
        
        else
        {
            return 0
        }
        
        let scalar:Double = number.doubleValue
        
        return scalar
    }
}
