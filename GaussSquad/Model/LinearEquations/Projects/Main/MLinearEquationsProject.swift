import UIKit

class MLinearEquationsProject
{
    var rows:[MLinearEquationsProjectRow]
    var project:DProject?
    private weak var controller:CLinearEquationsProject?
    private let kDefaultDividend:Double = 0
    private let kDefaultDivisor:Double = 1
    private let kDefaultPositive:Bool = true
    private let kDefaultDivision:Bool = false
    
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
        let timestamp:TimeInterval = Date().timeIntervalSince1970
        
        DManager.sharedInstance?.createManagedObject(
            entityName:DProject.entityName)
        { [weak self] (created) in
            
            self?.project = created as? DProject
            self?.project?.created = timestamp
            
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
        DManager.sharedInstance?.createManagedObject(
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
        DManager.sharedInstance?.save()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.refreshRows()
        }
    }
    
    private func merge(polynomialA:DPolynomial, polynomialB:DPolynomial)
    {
        let aSign:Double
        let bSign:Double
        
        if polynomialA.isPositive
        {
            aSign = 1
        }
        else
        {
            aSign = -1
        }
        
        if polynomialB.isPositive
        {
            bSign = 1
        }
        else
        {
            bSign = -1
        }
        
        let aDividend:Double = polynomialA.coefficientDividend * aSign
        let aDivisor:Double = polynomialA.coefficientDivisor
        let bDividend:Double = polynomialB.coefficientDividend * bSign
        let bDivisor:Double = polynomialB.coefficientDivisor
        
        if aDivisor == bDivisor
        {
            let newDividend:Double = aDividend - bDividend
            polynomialA.coefficientDividend = abs(newDividend)
            
            if newDividend < 0
            {
                polynomialA.isPositive = false
            }
            else
            {
                polynomialA.isPositive = true
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
        DManager.sharedInstance?.createManagedObject(
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
        DManager.sharedInstance?.delete(object:indeterminate)
        { [weak self] in
            
            self?.saveAndRefresh()
        }
    }
    
    func compress()
    {
        guard
            
            let project:DProject = self.project,
            let equations:[DEquation] = project.equations?.array as? [DEquation]
        
        else
        {
            loadFinished()
            
            return
        }
        
        for equation:DEquation in equations
        {
            guard
            
                var polynomials:[DPolynomial] = equation.polynomials?.array as? [DPolynomial],
                let result:DPolynomial = equation.result
            
            else
            {
                continue
            }
            
            let countPolynomials:Int = polynomials.count
            
            if countPolynomials > 1
            {
                
            }
            else if countPolynomials == 1
            {
                let polynomial:DPolynomial = polynomials[0]
                
                if polynomial.indeterminate == result.indeterminate
                {
                    merge(
                        polynomialA:polynomial,
                        polynomialB:result)
                    
                    result.coefficientDividend = kDefaultDividend
                    result.coefficientDivisor = kDefaultDivisor
                    result.isPositive = kDefaultPositive
                    result.showAsDivision = kDefaultDivision
                    result.indeterminate = nil
                }
            }
            else
            {
                DManager.sharedInstance?.delete(object:equation)
            }
        }
        
        DManager.sharedInstance?.save()
        refreshRows()
    }
}
