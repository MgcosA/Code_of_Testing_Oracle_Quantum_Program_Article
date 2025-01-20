namespace OracleTesting {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;

    function Is2Power_classical(num : Int) : Bool
    {
        mutable _2pow = 1;
        while (num >= _2pow)
        {
            if (num == _2pow)
            { return true; }
            set _2pow = _2pow * 2;
        }
        return false;
    }

    operation SampleIs2Power(Nqs : Int) : Int
    {
        let onebit = DrawRandomInt(0, Nqs - 1);
        return 1 <<< onebit;
    }

    operation SampleIsNot2Power(Nqs : Int) : Int
    {
        mutable ret = 0;
        repeat
        {
            set ret = DrawRandomInt(1, 2 ^ Nqs - 2);
        } until (not Is2Power_classical(ret));
        return ret;
    }

    function Is2Power_BuildEqClasses(Nqs : Int) : EqClassSI[]
    {
        let fis = () => SampleIs2Power(Nqs);
        let fisnot = () => SampleIsNot2Power(Nqs);
        let isclass = EqClassSI(fis, 2 ^ Nqs - 2);
        let isnotclass = EqClassSI(fisnot, 2 ^ Nqs - 2);
        return [BuildEqClassSIByRange(0 .. 0),
                isclass,
                isnotclass, 
                BuildEqClassSIByRange(2 ^ Nqs - 1 .. 2 ^ Nqs - 1)];
    }

    function Is2Power_Nqs() : Int { return 6; }       // Number of used qubits


    // --------- test correct ----------
    operation Test_Is2Power_phase(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Is2Power_phase, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Is2Power_qubit(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Is2Power_qubit, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ1 ----------
    operation Test_Is2Power_phase_AddH(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Is2Power_phase_AddH, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Is2Power_qubit_AddH(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Is2Power_qubit_AddH, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Is2Power_phase_AddX(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Is2Power_phase_AddX, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Is2Power_qubit_AddX(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Is2Power_qubit_AddX, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ2 ----------
    operation Test_Is2Power_phase_AddZ(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Is2Power_phase_AddZ, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Is2Power_qubit_AddZ(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Is2Power_qubit_AddZ, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Is2Power_phase_AddS(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Is2Power_phase_AddS, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Is2Power_qubit_AddS(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Is2Power_qubit_AddS, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Is2Power_phase_AddT(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Is2Power_phase_AddT, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Is2Power_qubit_AddT(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Is2Power_qubit_AddT, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Is2Power_phase_AddRz8(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Is2Power_phase_AddRz8, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Is2Power_qubit_AddRz8(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Is2Power_qubit_AddRz8, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Is2Power_phase_AddRz16(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Is2Power_phase_AddRz16, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Is2Power_qubit_AddRz16(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Is2Power_qubit_AddRz16, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Is2Power_phase_AddRz32(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Is2Power_phase_AddRz32, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Is2Power_qubit_AddRz32(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Is2Power_qubit_AddRz32, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ3 ----------
    operation Test_Is2Power_phase_FlipOut(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Is2Power_phase_FlipOut, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Is2Power_qubit_FlipOut(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Is2Power_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Is2Power_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Is2Power_qubit_FlipOut, Is2Power_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
}
