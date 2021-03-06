import UIKit

class MLinearEquationsProject
{
    var rows:[MLinearEquationsProjectRow]
    var project:DProject?
    private weak var controller:CLinearEquationsProject?
    
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
    
    private func createProject()
    {
        DManager.sharedInstance?.createData(
            entityName:DProject.entityName)
        { [weak self] (created) in
            
            self?.project = created as? DProject
            self?.project?.created = Date().timeIntervalSince1970
            
            let defaultSymbol:String = NSLocalizedString("MLinearEquationsProject_defaultIndeterminate", comment:"")
            
            self?.createIndeterminate(
                symbol:defaultSymbol)
            { [weak self] in
                
                self?.createRow()
            }
        }
    }
    
    private func createIndeterminate(
        symbol:String,
        completion:(() -> ())?)
    {
        DManager.sharedInstance?.createData(
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
        DManager.sharedInstance?.createData(
            entityName:DEquation.entityName)
        { [weak self] (created) in
            
            guard
            
                let project:DProject = self?.project,
                let indeterminatesArray:[DIndeterminate] = project.indeterminates?.array as? [DIndeterminate],
                let equation:DEquation = created as? DEquation
            
            else
            {
                return
            }
            
            equation.created = Date().timeIntervalSince1970
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
        DManager.sharedInstance?.createData(
            entityName:DPolynomial.entityName)
        { [weak self] (created) in
            
            guard
            
                let polynomial:DPolynomial = created as? DPolynomial
            
            else
            {
                return
            }
            
            if indeterminates.count > 0
            {
                var indeterminates:[DIndeterminate] = indeterminates
                let indeterminate:DIndeterminate = indeterminates.removeFirst()
                polynomial.indeterminate = indeterminate
                polynomial.equationPolynomials = equation
                
                self?.createPolynomials(
                    equation:equation,
                    indeterminates:indeterminates,
                    completion:completion)
            }
            else
            {
                self?.createResult(
                    equation:equation,
                    completion:completion)
            }
        }
    }
    
    private func createResult(
        equation:DEquation,
        completion:(() -> ())?)
    {
        DManager.sharedInstance?.createData(
            entityName:DPolynomial.entityName)
        { (created) in
            
            guard
            
                let result:DPolynomial = created as? DPolynomial
            
            else
            {
                return
            }
            
            result.equationResult = equation
            
            completion?()
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
        
        let lastRow:MLinearEquationsProjectRow = MLinearEquationsProjectRow.lastRow()
        rows.append(lastRow)
        self.rows = rows
        
        loadFinished()
    }
    
    private func saveAndRefresh()
    {
        DManager.sharedInstance?.save
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.refreshRows()
            }
        }
    }
    
    private func compareResult(
        equation:DEquation,
        polynomial:DPolynomial,
        result:DPolynomial)
    {
        if polynomial.indeterminate == result.indeterminate
        {
            guard
                
                let inversedResult:DPolynomial = result.inversed()
            
            else
            {
                return
            }
            
            polynomial.add(polynomial:inversedResult)
            equation.restartResult()
        }
    }
    
    private func comparePolynomials(
        equation:DEquation,
        polynomial:DPolynomial,
        compare:DPolynomial)
    {
        if polynomial.indeterminate == compare.indeterminate
        {
            polynomial.add(polynomial:compare)
            equation.deletePolynomial(polynomial:compare)
        }
    }
    
    private func indeterminatesToLeft()
    {
        guard
        
            let project:DProject = self.project,
            let equations:[DEquation] = project.equations?.array as? [DEquation]
        
        else
        {
            return
        }
        
        for equation:DEquation in equations
        {
            guard
            
                let result:DPolynomial = equation.result
            
            else
            {
                continue
            }
            
            if result.indeterminate != nil
            {
                equation.moveToLeft(polynomial:result)
            }
        }
    }
    
    private func constantsToRight()
    {
        guard
            
            let project:DProject = self.project,
            let equations:[DEquation] = project.equations?.array as? [DEquation]
            
        else
        {
            return
        }
        
        for equation:DEquation in equations
        {
            guard
                
                let polynomials:[DPolynomial] = equation.polynomials?.array as? [DPolynomial],
                let result:DPolynomial = equation.result
                
            else
            {
                continue
            }
            
            if result.indeterminate == nil
            {
                for polynomial:DPolynomial in polynomials
                {
                    if polynomial.indeterminate == nil
                    {
                        equation.moveToRight(polynomial:polynomial)
                    }
                }
            }
        }
    }
    
    private func addEverything()
    {
        guard
            
            let project:DProject = self.project,
            let equations:[DEquation] = project.equations?.array as? [DEquation]
            
        else
        {
            return
        }
        
        for equation:DEquation in equations
        {
            guard
                
                let polynomials:[DPolynomial] = equation.polynomials?.array as? [DPolynomial],
                let result:DPolynomial = equation.result
                
            else
            {
                continue
            }
            
            let countPolynomials:Int = polynomials.count
            
            if countPolynomials > 1
            {
                for indexPolynomial:Int in 0 ..< countPolynomials
                {
                    let polynomial:DPolynomial = polynomials[indexPolynomial]
                    
                    for indexComparison:Int in indexPolynomial + 1 ..< countPolynomials
                    {
                        let comparePolynomial:DPolynomial = polynomials[indexComparison]
                        
                        comparePolynomials(
                            equation:equation,
                            polynomial:polynomial,
                            compare:comparePolynomial)
                    }
                    
                    compareResult(
                        equation:equation,
                        polynomial:polynomial,
                        result:result)
                }
            }
            else if countPolynomials == 1
            {
                let polynomial:DPolynomial = polynomials[0]
                
                compareResult(
                    equation:equation,
                    polynomial:polynomial,
                    result:result)
            }
            else
            {
                project.deleteEquation(equation:equation)
            }
        }
    }
    
    private func removeZeros()
    {
        guard
            
            let project:DProject = self.project,
            let equations:[DEquation] = project.equations?.array as? [DEquation]
            
        else
        {
            return
        }
        
        for equation:DEquation in equations
        {
            guard
                
                let polynomials:[DPolynomial] = equation.polynomials?.array as? [DPolynomial]
                
            else
            {
                continue
            }
            
            var hasCoefficient:Bool = false
            
            for polynomial:DPolynomial in polynomials
            {
                let coefficient:Double = polynomial.coefficient()
                
                if coefficient != 0
                {
                    hasCoefficient = true
                    
                    break
                }
            }
            
            if !hasCoefficient
            {
                project.deleteEquation(equation:equation)
            }
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
    
    func createPolynomial(equation:DEquation)
    {
        DManager.sharedInstance?.createData(
            entityName:DPolynomial.entityName)
        { [weak self] (created) in
            
            guard
                
                let polynomial:DPolynomial = created as? DPolynomial
                
            else
            {
                return
            }
            
            polynomial.equationPolynomials = equation
            
            self?.saveAndRefresh()
        }
    }
    
    func createRow()
    {
        createEquation
        { [weak self] in
            
            self?.saveAndRefresh()
        }
    }
    
    func addIndeterminate(
        name:String,
        completion:(() -> ())?)
    {
        createIndeterminate(symbol:name)
        {   
            DManager.sharedInstance?.save()
            completion?()
        }
    }
    
    func removeIndeterminate(indeterminate:DIndeterminate)
    {
        project?.deleteIndeterminate(indeterminate:indeterminate)
        saveAndRefresh()
    }
    
    func removeEquation(index:Int)
    {
        guard
        
            let equation:DEquation = project?.equations?.array[index] as? DEquation
        
        else
        {
            return
        }
        
        project?.deleteEquation(equation:equation)
        saveAndRefresh()
    }
    
    func moveUp(index:Int)
    {
        guard
        
            var equations:[DEquation] = project?.equations?.array as? [DEquation]
        
        else
        {
            return
        }
        
        let equation:DEquation = equations[index]
        equations.insert(equation, at:index - 1)
        
        let orderedSet:NSOrderedSet = NSOrderedSet(array:equations)
        project?.equations = orderedSet
        saveAndRefresh()
    }
    
    func moveDown(index:Int)
    {
        guard
            
            var equations:[DEquation] = project?.equations?.array as? [DEquation]
            
            else
        {
            return
        }
        
        let equationBelow:DEquation = equations[index + 1]
        equations.insert(equationBelow, at:index)
        
        let orderedSet:NSOrderedSet = NSOrderedSet(array:equations)
        project?.equations = orderedSet
        saveAndRefresh()
    }
    
    func compress()
    {
        indeterminatesToLeft()
        addEverything()
        removeZeros()
        constantsToRight()
        
        saveAndRefresh()
    }
}
