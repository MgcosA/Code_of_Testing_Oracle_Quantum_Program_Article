namespace OracleTesting {

    import Std.Convert.IntAsDouble;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;
    open QSharpTester.supplements;

    // ---------- Correct program ----------
    // Implement transform exp(-iHt), where H = diag{0, 1, 2, ..., 2^n-1}
    operation HamiltonX(t : Double, qs : Qubit[]) : Unit
    {
        let n = Length(qs);
        for i in 0 .. n - 1
        {
            Rz(t * IntAsDouble(2 ^ i), qs[i]);          // Little-endian code
        }
    }

    // ---------- bug programs by mutation ----------
    operation HamiltonX_AddH(t : Double, qs : Qubit[]) : Unit
    {
        HamiltonX(t, qs);
        H(qs[0]);
    }
    operation HamiltonX_AddX(t : Double, qs : Qubit[]) : Unit
    {
        HamiltonX(t, qs);
        X(qs[0]);
    }
    operation HamiltonX_AddZ(t : Double, qs : Qubit[]) : Unit
    {
        HamiltonX(t, qs);
        Z(qs[0]);
    }
    operation HamiltonX_AddS(t : Double, qs : Qubit[]) : Unit
    {
        HamiltonX(t, qs);
        S(qs[0]);
    }
    operation HamiltonX_AddT(t : Double, qs : Qubit[]) : Unit
    {
        HamiltonX(t, qs);
        T(qs[0]);
    }
    operation HamiltonX_AddRz8(t : Double, qs : Qubit[]) : Unit
    {
        HamiltonX(t, qs);
        Rz(PI() / 8.0, qs[0]);
    }
    operation HamiltonX_AddRz16(t : Double, qs : Qubit[]) : Unit
    {
        HamiltonX(t, qs);
        Rz(PI() / 16.0, qs[0]);
    }
    operation HamiltonX_AddRz32(t : Double, qs : Qubit[]) : Unit
    {
        HamiltonX(t, qs);
        Rz(PI() / 32.0, qs[0]);
    }

    // ---------- bug programs from eq class ----------
    operation HamiltonX_BE(t : Double, qs : Qubit[]) : Unit
    {
        let n = Length(qs);
        for i in 0 .. n - 1
        {
            Rz(t * IntAsDouble(2 ^ (n - i)) / 2.0, qs[i]);        // Big-endian code
        }
    }
}
