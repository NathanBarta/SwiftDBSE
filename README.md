# SwiftDBSE
D.B Steinman's (n) degree polynomial root estimator "engineer's shortcut," developed in Swift. 

## Usage
Add the following to your pod file:
`
pod 'SwiftDBSE', '~> 1.0.0'
`

Sample use:
`
let estimatedRoot: Double = SwiftDBSE.calculate(nPolynomial("-1x^3+5x^2+2x+3"))
`

Notes:
* nPolynomial is a class that comes with SwiftDBSE. It does not represent a real polynomial, because coefficients and constants are both stored to the list coefficients. Modifications should be made before using it as an actual representation of a polynomial. 

* Variables do not have to have leading 1. Ex: -1x^3 & -x^3 are both acceptable. 

* Do not include "y=", or any other mathematical symbols (except "^,+,-"). Division should be calculated before entering. 

* Sort and simplify polynomial before entering

## History, method & limitations
D.B Steinman was a world renowned civil engineer, specializing in bridge design. His most notable works mainly focus around oscillations in suspension bridges, however in the 1950's he released a paper called "I—ENGINEER'S SHORTCUT SOLVES CUBIC AND HIGHER EQUATIONS AND ROOTS" in a naval journal. The paper contained a novel method of solving polynomials to the nth degree using only addition, multiplication, and devision. The technique gives a root of the polynomial to 4 significant figures - and can be continued for further accuracy. The technique was met with much criticism, mostly from mathematicians who viewed the technique as cheap and inappropriate, noting that the technique has limitations. The scientists did have a point about limitations, since the method does return a false root for certain polynomials. However, D.B Steinman included a method to test polynomials before computation to mitigate this problem. A masters thesis "A historical survey of methods of solving cubic equations" by Minna Burgess Connor in 1956 includes extra commentary on the testing method and proposes special cases for the technique. 
The method is not as useful as commonly used techniques such as: Newton's method (Newton-Raphson), and bisection. However, it is very interesting, and deserves being brought into the modern world. I admit that I am somewhat of a romantic, and I love the idea of bringing an old thing that never got anywhere, and reviving it with one of the newest programming languages. As for when the technique tends to fail, it seems to work less often when there are polynomials with mostly negative terms. Also, it seems to fail when the function does not have a point y where a horizontal line could pass through as many parts of the function as allowed by the degree of the polynomial.

## How the code works 
The polynomial is sorted into terms, coefficients, and other information. This is done by flipping the polynomial string backwards, and mapping through it looking for (+ or -), which indicates separation between the terms.

The calculate() function creates the R values as described in the method. 

R values for a cubic function look like this:

```
r[0] = c[0]
r[1] = (r[0] * c[0]) + c[1]
r[2] = (r[1] * c[0]) + (r[0] * c[1]) + c[2]
r[3] = (r[2] * c[0]) + (r[1] * c[1]) +(r[0] * c[2])
r{4} = (r[3] * c[0]) + (r[2] * c[1]) + (r[1] * c[2]) —Gets easy after here for extra points
r{5} = (r[4] * c[0]) + (r[3] * c[1]) + (r[2] * c[2])
```

Generalized: 

`
r[n] for cubic = (r[n-1] * c[0]) + (r[n-2] * c[1]) + (r[n-3] * c[2]) where r[-1] = 1, and r[-2…] = 0
`

R Values for a quartic function look like this:

```
r[0] = c[0]
r[1] = (r[0] * c[0]) + c[1]
r[2] = (r[1] * c[0]) + (r[0] * c[1])  + c[2]
r[3] = (r[2] * c[0]) + (r[1] * c[1]) +(r[0] * c[2]) + c[3]
r{4} = (r[3] * c[0]) + (r[2] * c[1]) + (r[1] * c[2]) + (r[0] * c[3])
```

Generalized:

`
r[n] for quartic = (r[n-1] * c[0]) + (r[n-2] * c[1]) + (r[n-3] * c[2]) + (r[n-4] * c[3]) where r[-1] = 1, and r[-2…] = 0
`

The equation for (n) terms can be modeled in swift like the following:
```
for i in 0...nPoly.power + precision {
  //Base Equation for Cubic: (r[mGet: i-1] * c[0]) + (r[mGet: i-2] * c[1]) + (r[mGet: i-3] * c[2])
  var tempR = 0.0
  
  for p in 0..<nPoly.power {
    tempR += (r[mGet: i-(p+1)] as! Double * c[p])
  }
  r.append(tempR)
}
```

Note that custom subscript mGet gives the behavior "where r[-1] = 1, and r[-2…] = 0" 

## Future work
* Test convergence or implement test from paper to determine if root is good
* Expand functionality of nPolynomial to include unordered terms & fractions
* Implement in new languages

## Tech used & what I learned
* Swift one-liners and higher order functions, including compactMap 
* How to distribute with cocoapods
* Subscripting and extending a collection type
* Working with Strings in Swift 

## Troubleshooting
If something does not work, it is probably because I set something to private. Feel free to grab the source code and add it to your project manualy, as long as you stay within the GNU v3.0 license terms.

## Final note
SwiftDBSE has nothing to do with databases. I feel like I should say that just to make it clear.

Star this project if you liked it!
