import Foundation
import CoreData

extension DProject
{
    //MARK: public
    
    func deleteEquation(equation:DEquation)
    {
        removeFromEquations(equation)
        DManager.sharedInstance?.delete(object:equation)
    }
    
    func deleteIndeterminate(indeterminate:DIndeterminate)
    {
        removeFromIndeterminates(indeterminate)
        DManager.sharedInstance?.delete(object:indeterminate)
    }
}
