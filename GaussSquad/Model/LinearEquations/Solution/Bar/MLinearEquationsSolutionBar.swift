import Foundation

class MLinearEquationsSolutionBar
{
    let items:[MLinearEquationsSolutionBarItem]
    
    init()
    {
        let itemBack:MLinearEquationsSolutionBarItemBack = MLinearEquationsSolutionBarItemBack()
        let itemBottom:MLinearEquationsSolutionBarItemBottom = MLinearEquationsSolutionBarItemBottom()
        let itemShare:MLinearEquationsSolutionBarItemShare = MLinearEquationsSolutionBarItemShare()
        
        items = [
            itemBack,
            itemBottom,
            itemShare
        ]
    }
}
