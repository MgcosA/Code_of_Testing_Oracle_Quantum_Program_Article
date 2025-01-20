namespace OracleTesting {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;

    // ---------- Running parameters ----------

    // Corresponding classical function of Parity
    //   true : ODD
    //   false : even
    function Parity_classical(num : Int) : Bool
    {
        mutable temp = num;
        mutable ret = false;
        while (temp != 0)
        {
            if (temp &&& 1 == 1)
            {
                set ret = not ret;
            }
            set temp = temp >>> 1;
        }
        return ret;
    }

    // Sample function for odd output
    operation SampleOdd(Nqs : Int) : Int
    {
        mutable ret = DrawRandomInt(1, 2 ^ Nqs - 2);
        if (Parity_classical(ret))
        {
            let flipindex = DrawRandomInt(0, Nqs - 1);
            set ret = ret ^^^ (1 <<< flipindex);
        }
        return ret;
    }

    // Sample function for even output
    operation SampleEven(Nqs : Int) : Int
    {
        mutable ret = DrawRandomInt(1, 2 ^ Nqs - 2);
        if (not Parity_classical(ret))
        {
            let flipindex = DrawRandomInt(0, Nqs - 1);
            set ret = ret ^^^ (1 <<< flipindex);
        }
        return ret;
    }

    function Parity_BuildEqClasses(Nqs : Int) : EqClassSI[]
    {
        let fseven = () => (SampleEven(Nqs));
        let fsodd = () => (SampleOdd(Nqs));
        let evenclass = EqClassSI(fseven, 2 ^ Nqs - 2);
        let oddclass = EqClassSI(fsodd, 2 ^ Nqs - 2);
        return [BuildEqClassSIByRange(0 .. 0),
                evenclass,
                oddclass, 
                BuildEqClassSIByRange(2 ^ Nqs - 1 .. 2 ^ Nqs - 1)];
    }

    function Parity_Nqs() : Int { return 6; }       // Number of used qubits


    // ---------- test correct ----------
    operation Test_Parity_phase(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Parity_phase, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Parity_qubit(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Parity_qubit, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ1 ----------
    operation Test_Parity_phase_AddH(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Parity_phase_AddH, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Parity_qubit_AddH(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Parity_qubit_AddH, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Parity_phase_AddX(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Parity_phase_AddX, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Parity_qubit_AddX(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Parity_qubit_AddX, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }


    // ---------- for RQ2 ----------
    operation Test_Parity_phase_AddZ(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Parity_phase_AddZ, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Parity_qubit_AddZ(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Parity_qubit_AddZ, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Parity_phase_AddS(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Parity_phase_AddS, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Parity_qubit_AddS(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Parity_qubit_AddS, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Parity_phase_AddT(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Parity_phase_AddT, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Parity_qubit_AddT(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Parity_qubit_AddT, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Parity_phase_AddRz8(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Parity_phase_AddRz8, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Parity_qubit_AddRz8(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Parity_qubit_AddRz8, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Parity_phase_AddRz16(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Parity_phase_AddRz16, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Parity_qubit_AddRz16(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Parity_qubit_AddRz16, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Parity_phase_AddRz32(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Parity_phase_AddRz32, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Parity_qubit_AddRz32(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Parity_qubit_AddRz32, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    // ---------- for RQ3 ----------
    operation Test_Parity_phase_FlipOut(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Parity_phase_FlipOut, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Parity_qubit_FlipOut(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Parity_qubit_FlipOut, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }

    operation Test_Parity_phase_FlipAll1(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestPhaseBooleanOracleLE(Parity_phase_FlipAll1, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
    operation Test_Parity_qubit_FlipAll1(Ncb : Int, Ntv : Int, Ipair : Int) : TestResult
    {
        let Nqs = Parity_Nqs();
        let pairfunc = PAIRFUNC(Ipair);
        let classes = Parity_BuildEqClasses(Nqs);
        return TestQubitBooleanOracleLE(Parity_qubit_FlipAll1, Parity_classical, Nqs, classes, pairfunc, Ncb, Ntv);
    }
}
