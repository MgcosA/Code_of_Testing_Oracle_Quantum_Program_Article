namespace OracleTesting {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;
    open QSharpTester.Preparation;
    open QSharpTester.supplements;

    // Identity F()
    function FID(x : Int, y : Int) : Int
    {
        return y;
    }
    // Identity G()
    function GID(x : Int, y : Int) : Double
    {
        return 0.0;
    }

    // True-value list to boolean function
    function TrueValueListAsBoolFunc(list : Bool[]) : Int -> Bool
    {
        return index -> list[index];
    }

    // Boolean function to true value list
    function BoolFuncAsTrueValueList(Nbits : Int, BoolFunc : Int -> Bool) : Bool[]
    {
        mutable ret = [false, size = Nbits];
        for i in 0 .. Nbits - 1
        {
            set ret w/= i <- BoolFunc(i);
        }
        return ret;
    }
    

    // Test boolean qubit oracle (big-endian version)
    //    ObjProc : Qubit[] => Unit, representing the target program |y> ==> (-1)^G(y)|y>
    //              where Qubit[] represents |y>, Qubit represents |q>
    //    BoolFunc : give the f(y) : Int -> Bool
    operation TestPhaseBooleanOracleBE(ObjProc : Qubit[] => Unit,
                                       BoolFunc : Int -> Bool, Ninput : Int,
                                       EqClasses : EqClassSI[], PairFunc : EqClass[] -> EqClassPair[],
                                       NRepeatClassical : Int, NRepeatTwoValue : Int) : TestResult
    {
        let eqclsarr = Mapped(EqClassSI_To_EqClass_2nd, EqClasses);
        return TestOracleProgramBE(WrapOneYToTwo(ObjProc, _, _), FID, BoolFuncAsPhaseG(BoolFunc, _, _),
                             0, Ninput, eqclsarr, PairFunc, NRepeatClassical, NRepeatTwoValue);
    }

    // Test boolean qubit oracle (little-endian version)
    //    ObjProc : Qubit[] => Unit, representing the target program |y> ==> (-1)^G(y)|y>
    //              where Qubit[] represents |y>, Qubit represents |q>
    //    BoolFunc : give the f(y) : Int -> Bool
    operation TestPhaseBooleanOracleLE(ObjProc : Qubit[] => Unit,
                                       BoolFunc : Int -> Bool, Ninput : Int,
                                       EqClasses : EqClassSI[], PairFunc : EqClass[] -> EqClassPair[],
                                       NRepeatClassical : Int, NRepeatTwoValue : Int) : TestResult
    {
        let eqclsarr = Mapped(EqClassSI_To_EqClass_2nd, EqClasses);
        return TestOracleProgramLE(WrapOneYToTwo(ObjProc, _, _), FID, BoolFuncAsPhaseG(BoolFunc, _, _),
                             0, Ninput, eqclsarr, PairFunc, NRepeatClassical, NRepeatTwoValue);
    }


    // Test boolean qubit oracle (big-endian version)
    //    ObjProc : (Qubit[], Qubit) => Unit, representing the target program |x>|q> ==> |x>|q \oplus f(x)>
    //              where Qubit[] represents |x>, Qubit represents |q>
    //    BoolFunc : give the f(x) : Int -> Bool
    operation TestQubitBooleanOracleBE(ObjProc : (Qubit[], Qubit) => Unit,
                                       BoolFunc : Int -> Bool, Ninput : Int,
                                       EqClasses : EqClassSI[], PairFunc : EqClass[] -> EqClassPair[],
                                       NRepeatClassical : Int, NRepeatTwoValue : Int) : TestResult
    {
        let eqclsarr = Mapped(EqClassSI_To_EqClass_1st, EqClasses);
        return TestOracleProgramBE(WrapQAQubitAsTwoQA(ObjProc, _, _), BoolFuncAsQubitF(BoolFunc, _, _),
                             GID, Ninput, 1, eqclsarr, PairFunc, NRepeatClassical, NRepeatTwoValue);
    }

    // Test boolean qubit oracle (little-endian version)
    //    ObjProc : (Qubit[], Qubit) => Unit, representing the target program |x>|q> ==> |x>|q \oplus f(x)>
    //              where Qubit[] represents |x>, Qubit represents |q>
    //    BoolFunc : give the f(x) : Int -> Bool
    operation TestQubitBooleanOracleLE(ObjProc : (Qubit[], Qubit) => Unit,
                                       BoolFunc : Int -> Bool, Ninput : Int,
                                       EqClasses : EqClassSI[], PairFunc : EqClass[] -> EqClassPair[],
                                       NRepeatClassical : Int, NRepeatTwoValue : Int) : TestResult
    {
        let eqclsarr = Mapped(EqClassSI_To_EqClass_1st, EqClasses);
        return TestOracleProgramLE(WrapQAQubitAsTwoQA(ObjProc, _, _), BoolFuncAsQubitF(BoolFunc, _, _),
                             GID, Ninput, 1, eqclsarr, PairFunc, NRepeatClassical, NRepeatTwoValue);
    }


    // Test pure qubit oracle (big-endian version): |x>|y> -> |x>|F(x,y)>
    //    ObjProc : (Qubit[], Qubit[]) => Unit, representing the target program |x>|y> ==> |x>|F(x,y)>
    //              i.e., fix G(x,y) === 0 in general oracle testing procedure
    operation TestQubitOracleBE(ObjProc : (Qubit[], Qubit[]) => Unit,
                                  F : (Int, Int) -> Int, Nx : Int, Ny : Int, 
                                  EqClasses : EqClass[], PairFunc : EqClass[] -> EqClassPair[],
                                  NRepeatClassical : Int, NRepeatTwoValue : Int) : TestResult
    {
        return TestOracleProgramBE(ObjProc, F, GID, Nx, Ny, EqClasses, PairFunc, NRepeatClassical, NRepeatTwoValue);
    }

    // Test pure qubit oracle (little-endian version): |x>|y> -> |x>|F(x,y)>
    //    ObjProc : (Qubit[], Qubit[]) => Unit, representing the target program |x>|y> ==> |x>|F(x,y)>
    //              i.e., fix G(x,y) === 0 in general oracle testing procedure
    operation TestQubitOracleLE(ObjProc : (Qubit[], Qubit[]) => Unit,
                                  F : (Int, Int) -> Int, Nx : Int, Ny : Int, 
                                  EqClasses : EqClass[], PairFunc : EqClass[] -> EqClassPair[],
                                  NRepeatClassical : Int, NRepeatTwoValue : Int) : TestResult
    {
        return TestOracleProgramLE(ObjProc, F, GID, Nx, Ny, EqClasses, PairFunc, NRepeatClassical, NRepeatTwoValue);
    }


    // Test pure phase oracle (big-endian version): |y> -> e^{iG(y)}|y>
    //    ObjProc : Qubit[] => Unit, representing the target program |y> ==> e^{iG(y)}|y>
    //              i.e., fix Nx === 0 and F(x,y) === y in general oracle testing procedure
    operation TestPhaseOracleBE(ObjProc : Qubit[] => Unit,
                                  G : Int -> Double, Ny : Int, 
                                  EqClasses : EqClassSI[], PairFunc : EqClass[] -> EqClassPair[],
                                  NRepeatClassical : Int, NRepeatTwoValue : Int) : TestResult
    {
        let eqclsarr = Mapped(EqClassSI_To_EqClass_2nd, EqClasses);
        return TestOracleProgramBE(WrapOneYToTwo(ObjProc, _, _), FID, WrapGyToGxy(G, _, _),
                             0, Ny, eqclsarr, PairFunc, NRepeatClassical, NRepeatTwoValue);
    }

    // Test pure phase oracle (little-endian version): |y> -> e^{iG(y)}|y>
    //    ObjProc : Qubit[] => Unit, representing the target program |y> ==> e^{iG(y)}|y>
    //              i.e., fix Nx === 0 and F(x,y) === y in general oracle testing procedure
    operation TestPhaseOracleLE(ObjProc : Qubit[] => Unit,
                                  G : Int -> Double, Ny : Int, 
                                  EqClasses : EqClassSI[], PairFunc : EqClass[] -> EqClassPair[],
                                  NRepeatClassical : Int, NRepeatTwoValue : Int) : TestResult
    {
        let eqclsarr = Mapped(EqClassSI_To_EqClass_2nd, EqClasses);
        return TestOracleProgramLE(WrapOneYToTwo(ObjProc, _, _), FID, WrapGyToGxy(G, _, _),
                             0, Ny, eqclsarr, PairFunc, NRepeatClassical, NRepeatTwoValue);
    }
}
