import Foundation

class MLinearEquationsProject
{
    var rows:[MLinearEquationsProjectRow]
    private weak var controller:CLinearEquationsProject?
    private var project:DProject?
    
    init(project:DProject?)
    {
        rows = []
        self.project = project
    }
    
    //MARK: private
    
    private func loadFinished()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.controller?.modelLoaded()
        }
    }
    
    //MARK: public
    
    func load(controller:CLinearEquationsProject)
    {
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            if self?.project == nil
            {
                self?.createProject()
            }
            else
            {
                self?.refreshRows()
            }
        }
    }
    
    private func createProject()
    {
        let timestamp:TimeInterval = Date().timeIntervalSince1970
        
        DManager.sharedInstance?.createManagedObject(
            entityName:DProject.entityName)
        { [weak self] (created) in
            
            self?.project = created as? DProject
            self?.project?.created = timestamp
            
            self?.createIndeterminate(
                symbol:NSLocalizedString("MLinearEquationsProject_defaultIndeterminate", comment:""))
            { [weak self] in
                
                self?.createEquation
                { [weak self] in
                    
                    DManager.sharedInstance?.save()
                    self?.refreshRows()
                }
            }
        }
    }
    
    private func createIndeterminate(
        symbol:String,
        completion:(() -> ())?)
    {
        DManager.sharedInstance?.createManagedObject(
            entityName:DIndeterminate.entityName)
        { [weak self] (created) in
            
            guard
            
                let project:DProject = self?.project,
                let indeterminate:DIndeterminate = created as? DIndeterminate
            
            else
            {
                return
            }
            
            indeterminate.symbol = symbol
            indeterminate.project = project
            
            completion?()
        }
    }
    
    private func createEquation(completion:(() -> ())?)
    {
        let timestamp:TimeInterval = Date().timeIntervalSince1970
        
        DManager.sharedInstance?.createManagedObject(
            entityName:DEquation.entityName)
        { [weak self] (created) in
            
            guard
            
                let project:DProject = self?.project,
                let indeterminatesSet:NSOrderedSet = project.indeterminates,
                let indeterminatesArray:[DIndeterminate] = indeterminatesSet.array as? [DIndeterminate],
                let equation:DEquation = created as? DEquation
            
            else
            {
                return
            }
            
            equation.created = timestamp
            equation.project = project
            
            self?.createPolynomials(
                equation:equation,
                indeterminates:indeterminatesArray,
                completion:completion)
        }
    }
    
    private func createPolynomials(
        equation:DEquation,
        indeterminates:[DIndeterminate],
        completion:(() -> ())?)
    {
        DManager.sharedInstance?.createManagedObject(
            entityName:DPolynomial.entityName)
        { [weak self] (created) in
            
            guard
            
                let polynomial:DPolynomial = created as? DPolynomial
            
            else
            {
                return
            }
            
            var indeterminates:[DIndeterminate] = indeterminates
            let indeterminate:DIndeterminate = indeterminates.removeFirst()
            polynomial.indeterminate = indeterminate
            polynomial.equation = equation
            
            if indeterminates.count > 0
            {
                self?.createPolynomials(
                    equation:equation,
                    indeterminates:indeterminates,
                    completion:completion)
            }
            else
            {
                completion?()
            }
        }
    }
    
    private func refreshRows()
    {
        guard
        
            let project:DProject = self.project,
            let equationSet:NSOrderedSet = project.equations,
            let equationArray:[DEquation] = equationSet.array as? [DEquation]
        
        else
        {
            return
        }
        
        var rows:[MLinearEquationsProjectRow] = []
        
        for equation:DEquation in equationArray
        {
            let row:MLinearEquationsProjectRow = MLinearEquationsProjectRow(
                equation:equation)
            rows.append(row)
        }
        
        self.rows = rows
        
        loadFinished()
    }
}
