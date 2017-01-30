import Foundation

class MLinearEquations
{
    private(set) var items:[MLinearEquationsItem]
    private weak var controller:CLinearEquations?
    
    init(controller:CLinearEquations)
    {
        self.controller = controller
        items = []
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadFromDb()
        }
    }
    
    //MARK: private
    
    private func loadFromDb()
    {
        finishLoading()
    }
    
    private func finishLoading()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.controller?.modelLoaded()
        }
    }
}
