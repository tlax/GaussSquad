import Foundation

class MLinearEquations
{
    private(set) var projects:[DProject]
    private weak var controller:CLinearEquations?
    
    init(controller:CLinearEquations)
    {
        self.controller = controller
        projects = []
        
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
