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
    operation Parity_phase(qs : Qubit[]) : Unit
    {
        MultiZ(qs);
    }

    operation Parity_qubit(qs : Qubit[], qtarget : Qubit) : Unit
    {
        for i in 0 .. Length(qs) - 1
        {
            CNOT(qs[i], qtarget);
        }
    }


    // ---------- bug programs by mutations ----------

    operation Parity_phase_AddH(qs : Qubit[]) : Unit
    {
        MultiZ(qs);
        H(qs[0]);       // add H gate on the first qubit
    }
    operation Parity_phase_AddX(qs : Qubit[]) : Unit
    {
        MultiZ(qs);
        X(qs[0]);       // add X
    }
    operation Parity_phase_AddZ(qs : Qubit[]) : Unit
    {
        MultiZ(qs);
        Z(qs[0]);       // add Z
    }
    operation Parity_phase_AddS(qs : Qubit[]) : Unit
    {
        MultiZ(qs);
        S(qs[0]);       // add S
    }
    operation Parity_phase_AddT(qs : Qubit[]) : Unit
    {
        MultiZ(qs);
        T(qs[0]);       // add T
    }
    operation Parity_phase_AddRz8(qs : Qubit[]) : Unit
    {
        MultiZ(qs);
        Rz(PI() / 8.0, qs[0]);       // add Rz(pi/8)
    }
    operation Parity_phase_AddRz16(qs : Qubit[]) : Unit
    {
        MultiZ(qs);
        Rz(PI() / 16.0, qs[0]);       // add Rz(pi/16)
    }
    operation Parity_phase_AddRz32(qs : Qubit[]) : Unit
    {
        MultiZ(qs);
        Rz(PI() / 32.0, qs[0]);       // add Rz(pi/32)
    }

    operation Parity_qubit_AddH(qs : Qubit[], qtarget : Qubit) : Unit
    {
        for i in 0 .. Length(qs) - 1
        {
            CNOT(qs[i], qtarget);
        }
        H(qs[0]);       // add H gate on the first qubit
    }
    operation Parity_qubit_AddX(qs : Qubit[], qtarget : Qubit) : Unit
    {
        for i in 0 .. Length(qs) - 1
        {
            CNOT(qs[i], qtarget);
        }
        X(qs[0]);       // add X
    }
    operation Parity_qubit_AddZ(qs : Qubit[], qtarget : Qubit) : Unit
    {
        for i in 0 .. Length(qs) - 1
        {
            CNOT(qs[i], qtarget);
        }
        Z(qs[0]);       // add Z
    }
    operation Parity_qubit_AddS(qs : Qubit[], qtarget : Qubit) : Unit
    {
        for i in 0 .. Length(qs) - 1
        {
            CNOT(qs[i], qtarget);
        }
        S(qs[0]);       // add S
    }
    operation Parity_qubit_AddT(qs : Qubit[], qtarget : Qubit) : Unit
    {
        for i in 0 .. Length(qs) - 1
        {
            CNOT(qs[i], qtarget);
        }
        T(qs[0]);       // add T
    }
    operation Parity_qubit_AddRz8(qs : Qubit[], qtarget : Qubit) : Unit
    {
        for i in 0 .. Length(qs) - 1
        {
            CNOT(qs[i], qtarget);
        }
        Rz(PI() / 8.0, qs[0]);       // add Rz(pi/8)
    }
    operation Parity_qubit_AddRz16(qs : Qubit[], qtarget : Qubit) : Unit
    {
        for i in 0 .. Length(qs) - 1
        {
            CNOT(qs[i], qtarget);
        }
        Rz(PI() / 16.0, qs[0]);       // add Rz(pi/16)
    }
    operation Parity_qubit_AddRz32(qs : Qubit[], qtarget : Qubit) : Unit
    {
        for i in 0 .. Length(qs) - 1
        {
            CNOT(qs[i], qtarget);
        }
        Rz(PI() / 32.0, qs[0]);       // add Rz(pi/32)
    }


    // ---------- bug programs from eq class ----------

    // Flip the output of true/false
    operation Parity_phase_FlipOut(qs : Qubit[]) : Unit
    {
        for i in 0 .. Length(qs) - 1
        {
            Rz(2.0 * PI(), qs[i]);      // * diag{ -1, -1 }
            Z(qs[i]);
        }
    }
    operation Parity_qubit_FlipOut(qs : Qubit[], qtarget : Qubit) : Unit
    {
        Parity_qubit(qs, qtarget);
        X(qtarget);
    }

    // Flip the output of all-one input
    operation Parity_phase_FlipAll1(qs : Qubit[]) : Unit
    {
        let n = Length(qs);
        MultiZ(qs);
        Controlled Z(qs[0 .. n - 2], qs[n - 1]);    // Flip
    }
    operation Parity_qubit_FlipAll1(qs : Qubit[], qtarget : Qubit) : Unit
    {
        for i in 0 .. Length(qs) - 1
        {
            CNOT(qs[i], qtarget);
        }
        Controlled X(qs, qtarget);      // Flip
    }
}
