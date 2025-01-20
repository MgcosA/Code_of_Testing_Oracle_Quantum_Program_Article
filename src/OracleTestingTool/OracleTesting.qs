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

    //Test case type
    //  |x>|y> --> e^{iG(x,y)}|x>|f(x,y)>
    struct TestCase
    {
        InputX : Int,
        InputY : Int,
        FXY : Int,
        GXY : Double
    }

    //Type for recording testing results
    struct TestResult
    {
        N_case_CB :            Int,     // the number of tested computational-basis input states
        N_case_TV_in_same_ec : Int,     // the number of tested two-value states in same eq class
        N_case_TV_in_diff_ec : Int,     // the number of tested two-value states in different eq class
        N_pass_CB :            Int,     // the number of PASS computational-basis input states
        N_pass_TV_in_same_ec : Int,     // the number of PASS two-value states in same eq class
        N_pass_TV_in_diff_ec : Int      // the number of PASS two-value states in different eq class
    }

    //Generate test cases by classical functions and inputs
    function GetTestCase(InputX : Int, InputY : Int,
                         F : (Int, Int) -> Int,
                         G : (Int, Int) -> Double) : TestCase
    {
        return TestCase(InputX, InputY, F(InputX, InputY), G(InputX, InputY));
    }


    // sample (x1, y1, x2, y2)
    operation RandomSampleTwoDiffInOneClass(class : EqClass) : (Int, Int, Int, Int)
    {
        let (rx1, ry1) = class::SampleFunction();
        if (class::ElementCount <= 1)
        { return (rx1, ry1, rx1, ry1); }
        mutable rx2 = 0;
        mutable ry2 = 0;
        repeat {
            set (rx2, ry2) = class::SampleFunction();
        } until (rx2 != rx1 or ry2 != ry1);
        return (rx1, ry1, rx2, ry2);
    }


    // Main function (big-endian version) of oracle testing
    //    ObjProc : the target program to be tested
    //    F : function F(x,y)
    //    G : Function G(x,y)
    //    Nx : the number of qubits of parameter x
    //    Ny : the number of qubits of parameter y
    //    EqClasses : equivalence classes for the testing task
    //    PairFunc : pairing function to be used in testing task
    //    NRepeatClassical : repetition times for CB states 
    //    NRepeatTwoValue  : repetition times for TV states
    // Return TestResult
    operation TestOracleProgramBE(ObjProc : (Qubit[], Qubit[]) => Unit,
                                  F : (Int, Int) -> Int, G : (Int, Int) -> Double, Nx : Int, Ny : Int, 
                                  EqClasses : EqClass[], PairFunc : EqClass[] -> EqClassPair[],
                                  NRepeatClassical : Int, NRepeatTwoValue : Int) : TestResult
    {
        let Neqs = Length(EqClasses);
        mutable Ntvsame = 0;
        mutable Ntvdiff = 0;
        mutable Pcb = 0;
        mutable Ptvsame = 0;
        mutable Ptvdiff = 0;

        for i in 0 .. Neqs - 1
        {
            // Test classical input for EqClasses[i];
            let (x, y) = EqClasses[i]::SampleFunction();
            let casexy = GetTestCase(x, y, F, G);
            if (TestClassicalInputBE(ObjProc, Nx, Ny, casexy, NRepeatClassical))
            { set Pcb = Pcb + 1; }

            // If the Eq class has more than one input, test superposition state on it.
            if (EqClasses[i]::ElementCount > 1)
            {
                let (x1, y1, x2, y2) = RandomSampleTwoDiffInOneClass(EqClasses[i]);
                let casex1y1 = GetTestCase(x1, y1, F, G);
                let casex2y2 = GetTestCase(x2, y2, F, G);
                set Ntvsame = Ntvsame + 1;
                if (TestTwoValueInputBE(ObjProc, Nx, Ny, casex1y1, casex2y2, NRepeatTwoValue))
                { set Ptvsame = Ptvsame + 1; }
            }
        }

        // Pairing Eq classes using PairFunc
        let pairs_of_eqcls = PairFunc(EqClasses);
        
        // Test superposition over paired different Eq classes.
        for i in 0 .. Length(pairs_of_eqcls) - 1
        {
            let (x1, y1) = pairs_of_eqcls[i]::class1::SampleFunction();
            let (x2, y2) = pairs_of_eqcls[i]::class2::SampleFunction();
            let casex1y1 = GetTestCase(x1, y1, F, G);
            let casex2y2 = GetTestCase(x2, y2, F, G);
            set Ntvdiff = Ntvdiff + 1;
            if (TestTwoValueInputBE(ObjProc, Nx, Ny, casex1y1, casex2y2, NRepeatTwoValue))
            { set Ptvdiff = Ptvdiff + 1; }
        }

        return TestResult(Neqs, Ntvsame, Ntvdiff, Pcb, Ptvsame, Ptvdiff);
    }


    // Main function (little-endian version) of oracle testing
    //    ObjProc : the target program to be tested
    //    F : function F(x,y)
    //    G : Function G(x,y)
    //    Nx : the number of qubits of parameter x
    //    Ny : the number of qubits of parameter y
    //    EqClasses : equivalence classes for the testing task
    //    PairFunc : pairing function to be used in testing task
    //    NRepeatClassical : repetition times for CB states 
    //    NRepeatTwoValue  : repetition times for TV states
    // Return TestResult
    operation TestOracleProgramLE(ObjProc : (Qubit[], Qubit[]) => Unit,
                                  F : (Int, Int) -> Int, G : (Int, Int) -> Double, Nx : Int, Ny : Int, 
                                  EqClasses : EqClass[], PairFunc : EqClass[] -> EqClassPair[],
                                  NRepeatClassical : Int, NRepeatTwoValue : Int) : TestResult
    {
        let Neqs = Length(EqClasses);
        mutable Ntvsame = 0;
        mutable Ntvdiff = 0;
        mutable Pcb = 0;
        mutable Ptvsame = 0;
        mutable Ptvdiff = 0;

        for i in 0 .. Neqs - 1
        {
            // Test classical input for EqClasses[i];
            let (x, y) = EqClasses[i]::SampleFunction();
            let casexy = GetTestCase(x, y, F, G);
            if (TestClassicalInputLE(ObjProc, Nx, Ny, casexy, NRepeatClassical))
            { set Pcb = Pcb + 1; }

            // If the Eq class has more than one input, test superposition state on it.
            if (EqClasses[i]::ElementCount > 1)
            {
                let (x1, y1, x2, y2) = RandomSampleTwoDiffInOneClass(EqClasses[i]);
                let casex1y1 = GetTestCase(x1, y1, F, G);
                let casex2y2 = GetTestCase(x2, y2, F, G);
                set Ntvsame = Ntvsame + 1;
                if (TestTwoValueInputLE(ObjProc, Nx, Ny, casex1y1, casex2y2, NRepeatTwoValue))
                { set Ptvsame = Ptvsame + 1; }
            }
        }

        // Pairing Eq classes using PairFunc
        let pairs_of_eqcls = PairFunc(EqClasses);
        
        // Test superposition over paired different Eq classes.
        for i in 0 .. Length(pairs_of_eqcls) - 1
        {
            let (x1, y1) = pairs_of_eqcls[i]::class1::SampleFunction();
            let (x2, y2) = pairs_of_eqcls[i]::class2::SampleFunction();
            let casex1y1 = GetTestCase(x1, y1, F, G);
            let casex2y2 = GetTestCase(x2, y2, F, G);
            set Ntvdiff = Ntvdiff + 1;
            if (TestTwoValueInputLE(ObjProc, Nx, Ny, casex1y1, casex2y2, NRepeatTwoValue))
            { set Ptvdiff = Ptvdiff + 1; }
        }

        return TestResult(Neqs, Ntvsame, Ntvdiff, Pcb, Ptvsame, Ptvdiff);
    }

}
