import Foundation

class MLinearEquationsSolutionStrategyRemoveCoefficients:MLinearEquationsSolutionStrategy
{
    class func coefficientPivot(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyRemoveCoefficients?
    {
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            let pivotIndex:Int = equation.pivotIndex()
            
            guard
            
                let pivotItem:MLinearEquationsSolutionEquationItemPolynomial = equation.items[pivotIndex] as? MLinearEquationsSolutionEquationItemPolynomial
            
            else
            {
                continue
            }
            
            let coefficient:Double = pivotItem.coefficient
            
            if coefficient != 1
            {
                let scalar:Double = 1 / coefficient
                let strategy:MLinearEquationsSolutionStrategyRemoveCoefficients = MLinearEquationsSolutionStrategyRemoveCoefficients(
                    step:step,
                    indexRow:indexEquation,
                    scalar:scalar)
                
                return strategy
            }
            
            indexEquation += 1
        }
        
        return nil
    }
    
    private let indexRow:Int
    private let scalar:Double
    
    private init(
        step:MLinearEquationsSolutionStep,
        indexRow:Int,
        scalar:Double)
    {
        self.indexRow = indexRow
        self.scalar = scalar
        super.init(step:step)
    }
    
    override func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        super.process(delegate:delegate)
        
        addRows()
    }
    
    //MARK: private
    
    private func addRows()
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        let scalarString:String = MSession.sharedInstance.stringFrom(number:scalar)
        let descr:String = String(
            format:NSLocalizedString("MLinearEquationsSolutionStrategyRowAddition_descr", comment:""),
            "\(indexRow + 1)",
            "\(indexRow + 1)",
            "\((indexRow))",
            scalarString)
        
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in self.step.equations
        {
            let newEquation:MLinearEquationsSolutionEquation
            
            if indexEquation == indexRow
            {
                let previousEquation:MLinearEquationsSolutionEquation = self.step.equations[indexEquation - 1]
                let scaledPrevious:MLinearEquationsSolutionEquation = previousEquation.multiplyScalar(
                    scalar:scalar)
                
                newEquation = equation.addEquation(
                    equation:scaledPrevious)
            }
            else
            {
                newEquation = equation
            }
            
            equations.append(newEquation)
            
            indexEquation += 1
        }
        
        let step:MLinearEquationsSolutionStepProcess = MLinearEquationsSolutionStepProcess(
            equations:equations,
            descr:descr)
        completed(step:step)
    }
}
