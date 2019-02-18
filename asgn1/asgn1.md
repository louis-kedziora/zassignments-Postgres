# Assignment 1, CSC-370, Daniel German
#### Louis Kedziora, V00820695, September 13th, 2018

## Q1(3.2.2)
### i)
FDs: $A \to D, B \to C, B \to D$
**b)**
$\{A\}$
**c)**
$\{A,B\}$,$\{A,C\}$,$\{A,D\}$,$\{A,B,C\}$,$\{A,B,D\}$,$\{A,C,D\}$,$\{A,B,C,D\}$
### ii)
FDs:  $AB \to C, BC \to D, CD \to A, AD \to B$
**b)**
$\{AB\}$,$\{BC\}$,$\{CD\}$,$\{AD\}$
**c)**
$\{ABCD\}$,$\{ABC\}$,$\{ABD\}$,$\{ACD\}$$\{BCD\}$
### iii)
FDs: $A \to B, B \to C, C \to D, D \to A$
**b)**
$\{A\}$,$\{B\}$,$\{C\}$,$\{D\}$

**c)**
$\{AB\}$,$\{AC\}$,$\{AD\}$,$\{BC\}$,$\{BD\}$,$\{CD\}$,$\{ABC\}$,$\{ACD\}$,$\{ABD\}$,$\{BCD\}$,$\{ABCD\}$
## Q2(3.2.4)

#### a)
$R(A,B,C)$
FDs: $A \to B, B \to C$
The closure of $\{B\}^+$ = $BC$, therefore given  $A \to B$ does not imply $B \to A$
**Example:** $A$ = Monkeys, $B$ = Mammals, $C$ = Animals.
- Monkeys imply mammals, and mammals imply animals but mammals do not imply monkeys.
#### b)
$R(A,B,C)$
FDs: $AB \to C, A \to C, C \to D, B \to C$
The closure of $\{B\}^+$ = $B$, therefore given  $AB \to C$ and $A \to C$, does not imply $B \to C$
**Example:** $A$ = SIN number, $B$ = Last Name, $C$ = First Name.
- A SIN number and a last name or just a SIN number will give me a first name, but a last name on its own does not imply a first name.
## Q3(3.2.10)

#### a)
$R(A,B,C,D,E)$ to $S(A,B,C)$
FDs in $R$: $ AB \to DE, C \to E, D \to C, E \to A$
$\{A\}^+=\{A\}$
$\{B\}^+=\{B\}$
$\{C\}^+=\{C,E,A\}$ add $C\to A$ to $R_1$
$\{AB\}^+=\{A,B,D,E\}$ add $AB\to C$ to $R_1$
$\{AC\}^+=\{A,C,E\}$
$\{BC\}^+=\{B,C,E\}$
$R_1=\{C \to A, AB \to C\}$
#### b)
$R(A,B,C,D,E)$ to $S(A,B,C)$
FDs in $R$: $ A \to D, BD \to E, AC \to E, DE \to B$
$\{A\}^+=\{A,D\}$
$\{B\}^+=\{B\}$
$\{C\}^+=\{C\}$
$\{AB\}^+=\{A,B,D,E\}$
$\{AC\}^+=\{A,C,E,D,B\}$ add $AC\to B$ to $R_1$
$\{BC\}^+=\{B,C\}$
$R_1=\{AC \to B\}$
#### c)
$R(A,B,C,D,E)$ to $S(A,B,C)$
FDs in $R:  AB \to D, AC \to E, BC \to D, D \to A, E \to B$
$\{A\}^+=\{A\}$
$\{B\}^+=\{B\}$
$\{C\}^+=\{C\}$
$\{AB\}^+=\{A,B,D\}$
$\{AC\}^+=\{A,C,E,B\}$  add $AC\to B$ to $R_1$
$\{BC\}^+=\{B,C,D,A\}$  add $BC\to A$ to $R_1$
$R_1=\{AC \to B, BC \to A\}$

## Q4(3.3.1)

#### a)
$R(A,B,C,D)$ with FDs $AB \to C, C \to D, D\to A$
$\{A\}^+=\{A\}$
$\{B\}^+=\{B\}$
$\{C\}^+=\{C,D,A\}$
$\{D\}^+=\{D,A\}$
$\{AB\}^+=\{A,B,C,D\}$ Candidate Key
$\{BC\}^+=\{A,B,C,D\}$ Candidate Key
$\{BD\}^+=\{A,B,C,D\}$ Candidate Key
$\{AC\}^+=\{A,D,C\}$
$\{AD\}^+=\{D,A\}$
$\{DC\}^+=\{D,A,C\}$
**i)** The FD $C \to D$ is a violation because $C$ is not a Super Key.
**ii)** $(ABC)(CD)$

#### b)
$R(A,B,C,D)$ with FDs $B \to C,B \to D$
$\{A\}^+=\{A\}$
$\{B\}^+=\{B,C,D\}$
$\{C\}^+=\{C\}$
$\{D\}^+=\{D\}$
$\{AB\}^+=\{A,B,C,D\}$ Candidate Key
$\{BC\}^+=\{B,C,D\}$
$\{BD\}^+=\{B,D,C\}$
$\{AC\}^+=\{A,C\}$
$\{AD\}^+=\{A,D\}$
$\{DC\}^+=\{D,C\}$
**i)** The FD $B \to C$ is a violation because $B$ is not a Super Key.
**ii)** $(BCD)(AB)$
#### c)
$R(A,B,C,D)$ with FDs $AB \to C, BC \to D, CD\to A,  AD \to B$
$\{A\}^+=\{A\}$
$\{B\}^+=\{B\}$
$\{C\}^+=\{C\}$
$\{D\}^+=\{D\}$
$\{AB\}^+=\{A,B,C,D\}$ Candidate Key
$\{BC\}^+=\{B,C,D,A\}$ Candidate Key
$\{BD\}^+=\{B,D\}$
$\{AC\}^+=\{A,C\}$
$\{AD\}^+=\{A,D,B,C\}$ Candidate Key
$\{DC\}^+=\{D,C,A,B\}$ Candidate Key
**i)** There are no violations.
**ii)**$(ABCD)$
