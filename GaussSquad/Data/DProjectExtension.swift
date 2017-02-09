import Foundation
import CoreData

extension DProject
{
    //MARK: public
    
    func deleteEquation(equation:DEquation)
    {
        removeFromEquations(equation)
        DManager.sharedInstance?.deleteAndWait(data:equation)
    }
    
    func deleteIndeterminate(indeterminate:DIndeterminate)
    {
        removeFromIndeterminates(indeterminate)
        DManager.sharedInstance?.deleteAndWait(data:indeterminate)
    }
}
