import Foundation
import CoreData

extension DEquation
{
    //MARK: public
    
    func restartResult()
    {
        DManager.sharedInstance?.createManagedObject(
            entityName:DPolynomial.entityName)
        { [weak self] (created) in
            
            guard
                
                let newResult:DPolynomial = created as? DPolynomial,
                let oldResult:DPolynomial = self?.result
                
            else
            {
                return
            }
            
            self?.result = newResult
            DManager.sharedInstance?.delete(object:oldResult)
        }
    }
}
