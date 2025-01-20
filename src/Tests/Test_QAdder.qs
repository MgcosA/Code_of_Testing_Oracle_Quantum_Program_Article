namespace OracleTesting {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;

    function QAdder_F(Nbits : Int, x : Int, y : Int) : Int
    {
        return (x + y) % (2 ^ Nbits);
    }

    function QAdder_BuildEqClasses(Nqs : Int) : EqClass[]
    {
        let MAX = 2 ^ Nqs - 1;
        return [BuildEqClassByRange(0 .. 0, 0 .. 0), 
                BuildEqClassByRange(0 .. 0, 1 .. MAX),
                BuildEqClassByRange(1 .. MAX, 0 .. 0),
                BuildEqClassByRange(1 .. MAX / 2, 1 .. MAX / 2),
                BuildEqClassByRange(1 .. MAX / 2, MAX / 2 + 1 .. MAX),
                BuildEqClassByRange(MAX / 2 + 1 .. MAX, 1 .. MAX / 2),
                BuildEqClassByRange(MAX / 2 + 1 .. MAX, MAX / 2 + 1 .. MAX) ];
    }

    function QAdder_N() : Int { return 5; }        // Number of used qubits in one array; so the total number qubits is 10

    operation Test_QAdder(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(QAdder(_, _), QAdder_F(N, _, _), GID, N, N, classes, pairfunc, Ncb, Ntv);
    }


    // ---------- for RQ1 ----------
    operation Test_QAdder_AddH(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(QAdder_AddH(_, _), QAdder_F(N, _, _), GID, N, N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_QAdder_AddX(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(QAdder_AddX(_, _), QAdder_F(N, _, _), GID, N, N, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ2 ----------
    operation Test_QAdder_AddZ(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(QAdder_AddZ(_, _), QAdder_F(N, _, _), GID, N, N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_QAdder_AddS(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(QAdder_AddS(_, _), QAdder_F(N, _, _), GID, N, N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_QAdder_AddT(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(QAdder_AddT(_, _), QAdder_F(N, _, _), GID, N, N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_QAdder_AddRz8(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(QAdder_AddRz8(_, _), QAdder_F(N, _, _), GID, N, N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_QAdder_AddRz16(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(QAdder_AddRz16(_, _), QAdder_F(N, _, _), GID, N, N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_QAdder_AddRz32(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(QAdder_AddRz32(_, _), QAdder_F(N, _, _), GID, N, N, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ3 ----------
    operation Test_QAdder_BE(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(QAdder_BE(_, _), QAdder_F(N, _, _), GID, N, N, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_QAdder_change0p0(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let N = QAdder_N();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = QAdder_BuildEqClasses(N);
        return TestOracleProgramLE(QAdder_change0p0(_, _), QAdder_F(N, _, _), GID, N, N, classes, pairfunc, Ncb, Ntv);
    }
}
