namespace OracleTesting {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;
    open QSharpTester.supplements;

    // ---------- Correct programs ----------
    // phase version
    operation LessThanM_phase(m : Int, qs : Qubit[]) : Unit
    {
        let n = Length(qs);
        let mb = IntAsBoolArray(m, n);
        if (mb[n - 1])
        {
            X(qs[n - 1]);
            Z(qs[n - 1]);
            X(qs[n - 1]);
        }
        else
        {
            X(qs[n - 1]);
        }

        for i in n - 2 .. -1 .. 0
        {
            if (mb[i])
            {
                X(qs[i]);
                Controlled Z(qs[i + 1 .. n - 1], qs[i]);
                X(qs[i]);
            }
            else
            {
                X(qs[i]);
            }
        }

        for i in 0 .. n - 1
        {
            if (not mb[i])
            {
                X(qs[i]);
            }
        }
    }

    // qubit version
    operation LessThanM_qubit(m : Int, qs : Qubit[], qtarget : Qubit) : Unit
    {
        let n = Length(qs);
        let mb = IntAsBoolArray(m, n);
        if (mb[n - 1])
        {
            X(qs[n - 1]);
            CNOT(qs[n - 1], qtarget);
            X(qs[n - 1]);
        }
        else
        {
            X(qs[n - 1]);
        }

        for i in n - 2 .. -1 .. 0
        {
            if (mb[i])
            {
                X(qs[i]);
                Controlled CNOT(qs[i + 1 .. n - 1], (qs[i], qtarget));
                X(qs[i]);
            }
            else
            {
                X(qs[i]);
            }
        }

        for i in 0 .. n - 1
        {
            if (not mb[i])
            {
                X(qs[i]);
            }
        }
    }


    // ---------- bug programs by mutations ----------
    operation LessThanM_phase_AddH(m : Int, qs : Qubit[]) : Unit
    {
        LessThanM_phase(m, qs);
        H(qs[0]);
    }
    operation LessThanM_qubit_AddH(m : Int, qs : Qubit[], qtarget : Qubit) : Unit
    {
        LessThanM_qubit(m, qs, qtarget);
        H(qs[0]);
    }

    operation LessThanM_phase_AddX(m : Int, qs : Qubit[]) : Unit
    {
        LessThanM_phase(m, qs);
        X(qs[0]);
    }
    operation LessThanM_qubit_AddX(m : Int, qs : Qubit[], qtarget : Qubit) : Unit
    {
        LessThanM_qubit(m, qs, qtarget);
        X(qs[0]);
    }

    operation LessThanM_phase_AddZ(m : Int, qs : Qubit[]) : Unit
    {
        LessThanM_phase(m, qs);
        Z(qs[0]);
    }
    operation LessThanM_qubit_AddZ(m : Int, qs : Qubit[], qtarget : Qubit) : Unit
    {
        LessThanM_qubit(m, qs, qtarget);
        Z(qs[0]);
    }

    operation LessThanM_phase_AddS(m : Int, qs : Qubit[]) : Unit
    {
        LessThanM_phase(m, qs);
        S(qs[0]);
    }
    operation LessThanM_qubit_AddS(m : Int, qs : Qubit[], qtarget : Qubit) : Unit
    {
        LessThanM_qubit(m, qs, qtarget);
        S(qs[0]);
    }

    operation LessThanM_phase_AddT(m : Int, qs : Qubit[]) : Unit
    {
        LessThanM_phase(m, qs);
        T(qs[0]);
    }
    operation LessThanM_qubit_AddT(m : Int, qs : Qubit[], qtarget : Qubit) : Unit
    {
        LessThanM_qubit(m, qs, qtarget);
        T(qs[0]);
    }

    operation LessThanM_phase_AddRz8(m : Int, qs : Qubit[]) : Unit
    {
        LessThanM_phase(m, qs);
        Rz(PI() / 8.0, qs[0]);
    }
    operation LessThanM_qubit_AddRz8(m : Int, qs : Qubit[], qtarget : Qubit) : Unit
    {
        LessThanM_qubit(m, qs, qtarget);
        Rz(PI() / 8.0, qs[0]);
    }

    operation LessThanM_phase_AddRz16(m : Int, qs : Qubit[]) : Unit
    {
        LessThanM_phase(m, qs);
        Rz(PI() / 16.0, qs[0]);
    }
    operation LessThanM_qubit_AddRz16(m : Int, qs : Qubit[], qtarget : Qubit) : Unit
    {
        LessThanM_qubit(m, qs, qtarget);
        Rz(PI() / 16.0, qs[0]);
    }

    operation LessThanM_phase_AddRz32(m : Int, qs : Qubit[]) : Unit
    {
        LessThanM_phase(m, qs);
        Rz(PI() / 32.0, qs[0]);
    }
    operation LessThanM_qubit_AddRz32(m : Int, qs : Qubit[], qtarget : Qubit) : Unit
    {
        LessThanM_qubit(m, qs, qtarget);
        Rz(PI() / 32.0, qs[0]);
    }


    // --------- bug programs from eq class ----------
    // Big endian
    operation LessThanM_phase_BE(m : Int, qs : Qubit[]) : Unit
    {
        Reverse(qs);
        LessThanM_phase(m, qs);
        Reverse(qs);
    }
    operation LessThanM_qubit_BE(m : Int, qs : Qubit[], qtarget : Qubit) : Unit
    {
        Reverse(qs);
        LessThanM_qubit(m, qs, qtarget);
        Reverse(qs);
    }

    // Less than --> Less than equal (i.e., let m --> m + 1)
    operation LessThanEqM_phase_LE(m : Int, qs : Qubit[]) : Unit
    {
        LessThanM_phase(m + 1, qs);
    }
    operation LessThanEqM_qubit_LE(m : Int, qs : Qubit[], qtarget : Qubit) : Unit
    {
        LessThanM_qubit(m + 1, qs, qtarget);
    }

    // Less than --> Greater than Eq
    operation GreaterThanEqM_phase_LE(m : Int, qs : Qubit[]) : Unit
    {
        LessThanM_phase(m, qs);
        Rz(2.0 * PI(), qs[0]);
    }
    operation GreaterThanEqM_qubit_LE(m : Int, qs : Qubit[], qtarget : Qubit) : Unit
    {
        LessThanM_qubit(m, qs, qtarget);
        X(qtarget);
    }
}
