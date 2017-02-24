import Foundation

class MCalculator
{
    let functions:[MCalculatorFunctions]
    let steps:MCalculatorSteps
    weak var currentFunction:MCalculatorFunctions?
    
    init()
    {
        let functionTrigonometry:MCalculatorFunctionsTrigonometry = MCalculatorFunctionsTrigonometry()
        
        functions = [
            functionTrigonometry]
        steps = MCalculatorSteps()
        currentFunction = functions.first
    }
}
