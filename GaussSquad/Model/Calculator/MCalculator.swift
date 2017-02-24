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
    
    //MARK: public
    
    func addStepWithKeyboardState(keyboardState:MKeyboardState)
    {
        let item:MCalculatorStepsItem = MCalculatorStepsItem(
            itemDescr:keyboardState.commitingDescription)
        steps.items.append(item)
    }
}
