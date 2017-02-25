import Foundation

class MCalculator
{
    let functions:[MCalculatorFunctions]
    let steps:MCalculatorSteps
    weak var currentFunction:MCalculatorFunctions?
    
    init()
    {
        let functionTrigonometry:MCalculatorFunctionsTrigonometry = MCalculatorFunctionsTrigonometry()
        let functionExponents:MCalculatorFunctionsExponents = MCalculatorFunctionsExponents()
        
        functions = [
            functionTrigonometry,
            functionExponents]
        steps = MCalculatorSteps()
    }
}
