namespace OracleTesting {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;

    function HamiltonX_classical(t : Double, x : Int) : Double
    {
        return IntAsDouble(x) * t;
    }

    function HamiltonX_BuildEqClasses(Nqs : Int) : EqClassSI[]
    {
        let len = 2 ^ Nqs;
        mutable ret = [BuildEqClassSIByRange(0 .. 0), size = len];
        for i in 0 .. len - 1
        {
            set ret w/= i <- BuildEqClassSIByRange(i .. i);
        }
        return ret;
    }

    function HamiltonX_Nqs() : Int { return 3; }       // Number of used qubits
    function HamiltonX_t() : Double { return 0.2; }     // evolution time t


    operation Test_HamiltonX(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = HamiltonX_Nqs();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = HamiltonX_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(HamiltonX(t, _), HamiltonX_classical(t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ1 ----------
    operation Test_HamiltonX_AddH(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = HamiltonX_Nqs();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = HamiltonX_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(HamiltonX_AddH(t, _), HamiltonX_classical(t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_HamiltonX_AddX(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = HamiltonX_Nqs();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = HamiltonX_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(HamiltonX_AddX(t, _), HamiltonX_classical(t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ2 ----------
    operation Test_HamiltonX_AddZ(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = HamiltonX_Nqs();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = HamiltonX_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(HamiltonX_AddZ(t, _), HamiltonX_classical(t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_HamiltonX_AddS(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = HamiltonX_Nqs();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = HamiltonX_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(HamiltonX_AddS(t, _), HamiltonX_classical(t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_HamiltonX_AddT(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = HamiltonX_Nqs();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = HamiltonX_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(HamiltonX_AddT(t, _), HamiltonX_classical(t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_HamiltonX_AddRz8(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = HamiltonX_Nqs();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = HamiltonX_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(HamiltonX_AddRz8(t, _), HamiltonX_classical(t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_HamiltonX_AddRz16(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = HamiltonX_Nqs();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = HamiltonX_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(HamiltonX_AddRz16(t, _), HamiltonX_classical(t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_HamiltonX_AddRz32(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = HamiltonX_Nqs();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = HamiltonX_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(HamiltonX_AddRz32(t, _), HamiltonX_classical(t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ3 ----------
    operation Test_HamiltonX_BE(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = HamiltonX_Nqs();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = HamiltonX_BuildEqClasses(Nqs);
        return TestPhaseOracleLE(HamiltonX_BE(t, _), HamiltonX_classical(t, _), Nqs, classes, pairfunc, Ncb, Ntv);
    }
}
