import Foundation
import CoreData

extension DSettings
{
    //MARK: public
    
    func newMaxFractionDigits(maxFractionDigits:Double)
    {
        self.maxFractionDigits = maxFractionDigits
        MSession.sharedInstance.updateFractionDigits()
        DManager.sharedInstance?.save()
    }
    
    func addTtl()
    {
        ttl += 1
        DManager.sharedInstance?.save()
    }
    
    func purchasePlus()
    {
        plus = true
        DManager.sharedInstance?.save()
    }
}
