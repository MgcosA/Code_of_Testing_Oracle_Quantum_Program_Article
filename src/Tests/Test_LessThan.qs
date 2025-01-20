namespace OracleTesting {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;

    function LessThanM_classical(m : Int, y : Int) : Bool
    {
        if (y < m) { return true; }
        else { return false; }
    }

    function LessThanM_BuildEqClasses(m : Int, Nqs : Int) : EqClassSI[]
    {
        return [BuildEqClassSIByRange(0 .. 0),
                BuildEqClassSIByRange(1 .. m - 2),
                BuildEqClassSIByRange(m - 1 .. m - 1),
                BuildEqClassSIByRange(m .. m),
                BuildEqClassSIByRange(m + 1 .. m + 1),
                BuildEqClassSIByRange(m + 2 .. 2 ^ Nqs - 1),
                BuildEqClassSIByRange(2 ^ Nqs - 1 .. 2 ^ Nqs - 1)];
    }

    function LessThan_N() : Int { return 5; }       // Number of used qubits
    function LessThan_m() : Int { return 10; }        // set compared number = 10


    // ---------- test correct ----------
    operation Test_LessThanM_phase(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestPhaseBooleanOracleLE(LessThanM_phase(m, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_LessThanM_qubit(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestQubitBooleanOracleLE(LessThanM_qubit(m, _, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ1 ----------
    operation Test_LessThanM_phase_AddH(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestPhaseBooleanOracleLE(LessThanM_phase_AddH(m, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_LessThanM_qubit_AddH(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestQubitBooleanOracleLE(LessThanM_qubit_AddH(m, _, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_LessThanM_phase_AddX(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestPhaseBooleanOracleLE(LessThanM_phase_AddX(m, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_LessThanM_qubit_AddX(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestQubitBooleanOracleLE(LessThanM_qubit_AddX(m, _, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ2 ----------
    operation Test_LessThanM_phase_AddZ(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestPhaseBooleanOracleLE(LessThanM_phase_AddZ(m, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_LessThanM_qubit_AddZ(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestQubitBooleanOracleLE(LessThanM_qubit_AddZ(m, _, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_LessThanM_phase_AddS(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestPhaseBooleanOracleLE(LessThanM_phase_AddS(m, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_LessThanM_qubit_AddS(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestQubitBooleanOracleLE(LessThanM_qubit_AddS(m, _, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_LessThanM_phase_AddT(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestPhaseBooleanOracleLE(LessThanM_phase_AddT(m, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_LessThanM_qubit_AddT(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestQubitBooleanOracleLE(LessThanM_qubit_AddT(m, _, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_LessThanM_phase_AddRz8(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestPhaseBooleanOracleLE(LessThanM_phase_AddRz8(m, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_LessThanM_qubit_AddRz8(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestQubitBooleanOracleLE(LessThanM_qubit_AddRz8(m, _, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_LessThanM_phase_AddRz16(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestPhaseBooleanOracleLE(LessThanM_phase_AddRz16(m, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_LessThanM_qubit_AddRz16(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestQubitBooleanOracleLE(LessThanM_qubit_AddRz16(m, _, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_LessThanM_phase_AddRz32(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestPhaseBooleanOracleLE(LessThanM_phase_AddRz32(m, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_LessThanM_qubit_AddRz32(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestQubitBooleanOracleLE(LessThanM_qubit_AddRz32(m, _, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ3 ----------
    operation Test_GreaterThanEqM_phase(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestPhaseBooleanOracleLE(GreaterThanEqM_phase_LE(m, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_GreaterThanEqM_qubit(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestQubitBooleanOracleLE(GreaterThanEqM_qubit_LE(m, _, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_LessThanM_phase_BE(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestPhaseBooleanOracleLE(LessThanM_phase_BE(m, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_LessThanM_qubit_BE(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestQubitBooleanOracleLE(LessThanM_qubit_BE(m, _, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_LessThanEqM_phase(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestPhaseBooleanOracleLE(LessThanEqM_phase_LE(m, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_LessThanEqM_qubit(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = LessThan_N();
        let m = LessThan_m();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = LessThanM_BuildEqClasses(m, N);
        return TestQubitBooleanOracleLE(LessThanEqM_qubit_LE(m, _, _), LessThanM_classical(m, _), N, classes, pairfunc, Ncb, Ntv);
    }
}
