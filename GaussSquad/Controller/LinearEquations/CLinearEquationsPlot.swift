import UIKit

class CLinearEquationsPlot:CController
{
    private weak var viewPlot:VLinearEquationsPlot!
    
    override func loadView()
    {
        let viewPlot:VLinearEquationsPlot = VLinearEquationsPlot(controller:self)
        self.viewPlot = viewPlot
        view = viewPlot
    }
}
