namespace OracleTesting {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;

    function MixedProc_F(Nbits : Int, x : Int, y : Int) : Int
    {
        return QAdder_F(Nbits, x, y);
    }
    function MixedProc_G(t : Double, x : Int, y : Int) : Double
    {
        return HamiltonX_classical(t, y);
    }

    operation Test_MixedProc(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(MixedProc(t, _, _), MixedProc_F(N, _, _), MixedProc_G(t, _, _), N, N, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ1 ----------
    operation Test_MixedProc_AddH(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(MixedProc_AddH(t, _, _), MixedProc_F(N, _, _), MixedProc_G(t, _, _), N, N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_MixedProc_AddX(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(MixedProc_AddX(t, _, _), MixedProc_F(N, _, _), MixedProc_G(t, _, _), N, N, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ2 ----------
    operation Test_MixedProc_AddZ(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(MixedProc_AddZ(t, _, _), MixedProc_F(N, _, _), MixedProc_G(t, _, _), N, N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_MixedProc_AddS(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(MixedProc_AddS(t, _, _), MixedProc_F(N, _, _), MixedProc_G(t, _, _), N, N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_MixedProc_AddT(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(MixedProc_AddT(t, _, _), MixedProc_F(N, _, _), MixedProc_G(t, _, _), N, N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_MixedProc_AddRz8(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(MixedProc_AddRz8(t, _, _), MixedProc_F(N, _, _), MixedProc_G(t, _, _), N, N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_MixedProc_AddRz16(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(MixedProc_AddRz16(t, _, _), MixedProc_F(N, _, _), MixedProc_G(t, _, _), N, N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_MixedProc_AddRz32(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let t = HamiltonX_t();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(MixedProc_AddRz32(t, _, _), MixedProc_F(N, _, _), MixedProc_G(t, _, _), N, N, classes, pairfunc, Ncb, Ntv);
    }
}