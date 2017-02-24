import Foundation

class MCalculator
{
    let functions:[MCalculatorFunctions]
    let steps:MCalculatorSteps
    
    init()
    {
        functions = []
        steps = MCalculatorSteps()
    }
}
