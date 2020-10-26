//
//  SwiftDBSE.swift
//  SwiftDBSE
//  "Swift D.B Steinman Estimation"
//  Created by Nathan Barta on 10/20/20.
//  GNU General Public License v3.0

import Foundation

public class nPolynomial {
    
    public let nPolyString: String
    
    var terms: [String] = []
    
    var coffeciants: [Double] = []
    
    var power: Int = 0
    
    init(nPolyString: String) {
        self.nPolyString = nPolyString
        create()
    }
    
    func create() {
        getTerms()
        coffeciants = terms.map { Double($0.components(separatedBy: CharacterSet(charactersIn: "x"))[0]) ?? ($0.prefix(1) == "-" ? -1 : 1) } ; print("Coefficiants: \(coffeciants)") //Also includes constants
        power = Int(terms[0].components(separatedBy: CharacterSet(charactersIn: "^"))[1])! ; print("Power: \(power)")
    }

    func getTerms() { //Go through string backwards. Where there is a + or -, take the array stubstring and put it into terms, inclusive last, or devfault +.
        let op: [Character] = String(nPolyString.trimmingCharacters(in: .whitespaces).reversed()).map { $0 } //Reversed string as array
        let opIndices: [Int] = op.enumerated().compactMap { if $1 == "+" || $1 == "-" { //Indices of + or -
            return $0
            }
            return nil
        }
        
        terms.append(String(op[op.index(op.startIndex, offsetBy: 0) ... op.index(op.startIndex, offsetBy: opIndices[0])])) //Begining term
        
        for r in 0 ..< opIndices.count - 1 { //Inner terms
            terms.append(String(
                op[op.index(op.startIndex, offsetBy: opIndices[r] + 1) ... op.index(op.startIndex, offsetBy: opIndices[r+1])]
            
            ))
        }
        
        
        let endTerm: String = String(op[op.index(op.startIndex, offsetBy: opIndices.last! + 1) ..< op.index(op.endIndex, offsetBy: 0)]) //Ending term (start of nPoly)
        if endTerm != "" {
            terms.append(endTerm)
        }
         
        
        terms = terms.map { String($0.reversed()) } //Terms elements un-reversed
        terms = terms.reversed() //Terms in correct order
        
        print(terms)
    }
}

public struct SwiftDBSE { //1x^3 + 3x^2 - 7x + 1
    
    public let nPoly: nPolynomial
    
    public func calculate(precision: Int = 0) -> Double? {
        let c = Array(nPoly.coffeciants[1...(nPoly.coffeciants.count - 1)]).map { $0 / -1*nPoly.coffeciants[0] } ; print("Moved Coefficiants: \(c)") //Moves highest term to left side of "="
        var r: [Double] = []
        
        for i in 0...nPoly.power + precision {
//            Base Equation for Cubic: (r[mGet: i-1] * c[0]) + (r[mGet: i-2] * c[1]) + (r[mGet: i-3] * c[2])

            var tempR = 0.0
            for p in 0..<nPoly.power {
                tempR += (r[mGet: i-(p+1)] as! Double * c[p])
            }
            r.append(tempR)
        }
        
        print("R-values: \(r)")
        
        print("Estimation: \(r.last!/r[r.endIndex-2])")
        
        return r.last!/r[r.endIndex-2]
    }
}

extension Array {
    
    subscript (mGet index: Index) -> Any {
        if index == -1 {
            return 1.0
        }
        if index <= -2 {
            return 0.0
        }
        else {
            return self[index]
        }
    }
}
