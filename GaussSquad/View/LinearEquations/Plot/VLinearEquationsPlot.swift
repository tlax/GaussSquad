import Foundation

class VLinearEquationsPlot:VView
{
    private weak var controller:CLinearEquationsPlot!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLinearEquationsPlot
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
