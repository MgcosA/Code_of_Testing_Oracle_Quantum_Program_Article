namespace OracleTesting {

    import QSharpTester.supplements.IntAsBoolArrayLE;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;

    function Ising_classical(Nbits : Int, J : Double, B : Double, t : Double, statestr : Int) : Double
    {
        let bits = IntAsBoolArrayLE(statestr, Nbits);
        mutable res = 0.0;
        if (Nbits > 1)
        {
            for i in 0 .. Nbits - 1
            {
                if (bits[i] == bits[(i + 1) % Nbits])
                { set res = res + J; }
                else
                { set res = res - J; }
            }
        }
        for i in 0 .. Nbits - 1
        {
            if (bits[i])
            { set res = res - B; }
            else
            { set res = res + B; }
        }
        return res * t;
    }

    @EntryPoint()
    operation TestIsingCls() : Unit
    {
        let res = Ising_classical(7, 1.0, 1.0, 0.2, 3);
        Message($"{res}");
    }

    operation SampleOne1(Nqs : Int) : Int
    {
        let onebit = DrawRandomInt(0, Nqs - 1);
        return 1 <<< onebit;
    }

    operation SampleTwoAdj1(Nqs : Int) : Int
    {
        if (Nqs <= 2) { return 3; }
        let onebit = DrawRandomInt(0, Nqs - 1);
        if (onebit == 0)
        { return (1 <<< (Nqs - 1)) + 1; }
        return (1 <<< onebit) + (1 <<< (onebit - 1));
    }

    operation SampleTwoSep1(Nqs : Int) : Int
    {
        if (Nqs <= 3) { return 0; }
        let i1 = DrawRandomInt(0, Nqs - 1);
        mutable i2 = 0;
        repeat
        {
            set i2 = DrawRandomInt(0, Nqs - 1);
        } until (AbsI(i2 - i1) % Nqs >= 2);
        return (1 <<< i1) + (1 <<< i2);
    }

    function NumberOf1(x : Int) : Int
    {
        mutable temp = x;
        mutable count = 0;
        while (temp > 0)
        {
            if ((temp &&& 1) == 1)
            { set count = count + 1; }
            set temp = temp >>> 1;
        }
        return count;
    }

    operation SampleMoreThanTwo1(Nqs : Int) : Int
    {
        if (Nqs <= 3) { return 7; }
        mutable s = 7;
        repeat
        {
            set s = DrawRandomInt(7, 2 ^ Nqs - 1);
        } until (NumberOf1(s) >= 3)
        return s;
    }

    function Ising_BuildEqClasses(Nqs : Int) : EqClassSI[]
    {
        let fone1 = () => SampleOne1(Nqs);
        let ftwoadj1 = () => SampleTwoAdj1(Nqs);
        let ftwosep1 = () => SampleTwoSep1(Nqs);
        let fmorethantwo1 = () => SampleMoreThanTwo1(Nqs);

        let one1class = EqClassSI(fone1, Nqs);
        let twoadj1class = EqClassSI(ftwoadj1, Nqs);
        let twosep1class = EqClassSI(ftwosep1, Nqs * (Nqs - 3));
        let morthantwo1class = EqClassSI(fmorethantwo1, 2 ^ Nqs - Nqs * (Nqs + 1) / 2 - 1);

        return [BuildEqClassSIByRange(0 .. 0),
                one1class,
                twoadj1class,
                twosep1class,
                morthantwo1class];
    }

    function Ising_Nqs() : Int { return 7; }        // Number of used qubits
    function Ising_t() : Double { return 0.2; }     // evolution time t
    function Ising_J() : Double { return 1.0; }     // interaction energy J
    function Ising_B() : Double { return 1.0; }     // external magnetic B


    operation Test_Ising(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Ising_Nqs();
        let t = Ising_t();
        let J = Ising_J();
        let B = Ising_B();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Ising_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(IsingEvolution(J, B, t, _), Ising_classical(Nqs, J, B, t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }


    // ---------- for RQ1 ----------
    operation Test_Ising_AddH(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Ising_Nqs();
        let t = Ising_t();
        let J = Ising_J();
        let B = Ising_B();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Ising_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(IsingEvolution_AddH(J, B, t, _), Ising_classical(Nqs, J, B, t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Ising_AddX(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Ising_Nqs();
        let t = Ising_t();
        let J = Ising_J();
        let B = Ising_B();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Ising_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(IsingEvolution_AddX(J, B, t, _), Ising_classical(Nqs, J, B, t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ2 ----------
    operation Test_Ising_AddZ(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Ising_Nqs();
        let t = Ising_t();
        let J = Ising_J();
        let B = Ising_B();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Ising_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(IsingEvolution_AddZ(J, B, t, _), Ising_classical(Nqs, J, B, t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Ising_AddS(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Ising_Nqs();
        let t = Ising_t();
        let J = Ising_J();
        let B = Ising_B();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Ising_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(IsingEvolution_AddS(J, B, t, _), Ising_classical(Nqs, J, B, t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Ising_AddT(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Ising_Nqs();
        let t = Ising_t();
        let J = Ising_J();
        let B = Ising_B();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Ising_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(IsingEvolution_AddT(J, B, t, _), Ising_classical(Nqs, J, B, t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Ising_AddRz8(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Ising_Nqs();
        let t = Ising_t();
        let J = Ising_J();
        let B = Ising_B();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Ising_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(IsingEvolution_AddRz8(J, B, t, _), Ising_classical(Nqs, J, B, t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Ising_AddRz16(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Ising_Nqs();
        let t = Ising_t();
        let J = Ising_J();
        let B = Ising_B();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Ising_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(IsingEvolution_AddRz16(J, B, t, _), Ising_classical(Nqs, J, B, t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Ising_AddRz32(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Ising_Nqs();
        let t = Ising_t();
        let J = Ising_J();
        let B = Ising_B();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Ising_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(IsingEvolution_AddRz32(J, B, t, _), Ising_classical(Nqs, J, B, t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }
}
