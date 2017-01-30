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
        DManager.sharedInstance?.fetchManagedObjects(
            entityName:DProject.entityName)
        { [weak self] (fetched) in
            
            if let fetched:[DProject] = fetched as? [DProject]
            {
                var items:[MLinearEquationsItem] = []
                
                for project:DProject in fetched
                {
                    let item:MLinearEquationsItem = MLinearEquationsItem(
                        project:project)
                    items.append(item)
                }
                
                self?.items = items
                self?.sortItems()
            }
            else
            {
                self?.items = []
            }
            
            self?.finishLoading()
        }
    }
    
    private func sortItems()
    {
        items.sort
        { (itemA:MLinearEquationsItem, itemB:MLinearEquationsItem) -> Bool in
            
            let before:Bool = itemA.project.created > itemB.project.created
            
            return before
        }
    }
    
    private func finishLoading()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.controller?.modelLoaded()
        }
    }
}
