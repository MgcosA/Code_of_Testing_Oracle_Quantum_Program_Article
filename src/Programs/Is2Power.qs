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
    operation Is2Power_phase(qs : Qubit[]) : Unit
    {
        let N = Length(qs);
        MultiX(qs);
        for i in 0 .. N - 1
        {
            X(qs[i]);
            Controlled Z(qs[0 .. N - 2], qs[N - 1]);
            X(qs[i]);
        }
        MultiX(qs);
    }

    operation Is2Power_qubit(qs : Qubit[], qtarget : Qubit) : Unit
    {
        let N = Length(qs);
        MultiX(qs);
        for i in 0 .. N - 1
        {
            X(qs[i]);
            Controlled X(qs, qtarget);
            X(qs[i]);
        }
        MultiX(qs);
    }


    // ---------- bug programs by mutation ----------
    operation Is2Power_phase_AddH(qs : Qubit[]) : Unit
    {
        Is2Power_phase(qs);
        H(qs[0]);
    }
    operation Is2Power_qubit_AddH(qs : Qubit[], qtarget : Qubit) : Unit
    {
        Is2Power_qubit(qs, qtarget);
        H(qs[0]);
    }

    operation Is2Power_phase_AddX(qs : Qubit[]) : Unit
    {
        Is2Power_phase(qs);
        X(qs[0]);
    }
    operation Is2Power_qubit_AddX(qs : Qubit[], qtarget : Qubit) : Unit
    {
        Is2Power_qubit(qs, qtarget);
        X(qs[0]);
    }

    operation Is2Power_phase_AddZ(qs : Qubit[]) : Unit
    {
        Is2Power_phase(qs);
        Z(qs[0]);
    }
    operation Is2Power_qubit_AddZ(qs : Qubit[], qtarget : Qubit) : Unit
    {
        Is2Power_qubit(qs, qtarget);
        Z(qs[0]);
    }

    operation Is2Power_phase_AddS(qs : Qubit[]) : Unit
    {
        Is2Power_phase(qs);
        S(qs[0]);
    }
    operation Is2Power_qubit_AddS(qs : Qubit[], qtarget : Qubit) : Unit
    {
        Is2Power_qubit(qs, qtarget);
        S(qs[0]);
    }

    operation Is2Power_phase_AddT(qs : Qubit[]) : Unit
    {
        Is2Power_phase(qs);
        T(qs[0]);
    }
    operation Is2Power_qubit_AddT(qs : Qubit[], qtarget : Qubit) : Unit
    {
        Is2Power_qubit(qs, qtarget);
        T(qs[0]);
    }

    operation Is2Power_phase_AddRz8(qs : Qubit[]) : Unit
    {
        Is2Power_phase(qs);
        Rz(PI() / 8.0, qs[0]);
    }
    operation Is2Power_qubit_AddRz8(qs : Qubit[], qtarget : Qubit) : Unit
    {
        Is2Power_qubit(qs, qtarget);
        Rz(PI() / 8.0, qs[0]);
    }

    operation Is2Power_phase_AddRz16(qs : Qubit[]) : Unit
    {
        Is2Power_phase(qs);
        Rz(PI() / 16.0, qs[0]);
    }
    operation Is2Power_qubit_AddRz16(qs : Qubit[], qtarget : Qubit) : Unit
    {
        Is2Power_qubit(qs, qtarget);
        Rz(PI() / 16.0, qs[0]);
    }

    operation Is2Power_phase_AddRz32(qs : Qubit[]) : Unit
    {
        Is2Power_phase(qs);
        Rz(PI() / 32.0, qs[0]);
    }
    operation Is2Power_qubit_AddRz32(qs : Qubit[], qtarget : Qubit) : Unit
    {
        Is2Power_qubit(qs, qtarget);
        Rz(PI() / 32.0, qs[0]);
    }

    // ---------- bug programs from eq class ----------
    operation Is2Power_phase_FlipOut(qs : Qubit[]) : Unit
    {
        Is2Power_phase(qs);
        Rz(2.0 * PI(), qs[0]);
    }
    operation Is2Power_qubit_FlipOut(qs : Qubit[], qtarget : Qubit) : Unit
    {
        Is2Power_qubit(qs, qtarget);
        X(qtarget);
    }
}
