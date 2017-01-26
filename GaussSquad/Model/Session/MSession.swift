import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    static let kFroobMaxRecords:Int = 3
    //private(set) var settings:DSettings?
    private let kTtlDelta:Int16 = 1
    
    private init()
    {
    }
    
    //MARK: private
    /*
    private func asyncLoadSettings()
    {
        DManager.sharedInstance.fetchManagedObjects(
            entityName:DSettings.entityName,
            limit:1)
        { (fetched) in
            
            guard
            
                let settings:DSettings = fetched?.first as? DSettings
            
            else
            {
                self.createSettings()
                
                return
            }
            
            settings.ttl += self.kTtlDelta
            DManager.sharedInstance.save()
            
            self.settingsReady(settings:settings)
        }
    }
    
    private func createSettings()
    {
        DManager.sharedInstance.createManagedObject(
            entityName:DSettings.entityName)
        { (created) in
            
            guard
                
                let settings:DSettings = created as? DSettings
                
            else
            {
                self.createSettings()
                
                return
            }
            
            DManager.sharedInstance.save()
            self.settingsReady(settings:settings)
        }
    }
    
    private func settingsReady(settings:DSettings)
    {
        self.settings = settings
    }*/
    
    //MARK: public
    
    func loadSettings()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
//            if self.settings == nil
//            {
//                self.asyncLoadSettings()
//            }
        }
    }
}
