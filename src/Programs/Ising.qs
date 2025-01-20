namespace OracleTesting {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;
    open QSharpTester.supplements;

    // ---------- Correct Program ----------
    operation IsingEvolution(J : Double, B : Double, t : Double, qs : Qubit[]) : Unit
    {
        let Nqs = Length(qs);
        if (Nqs > 1)
        {
            for i in 0 .. Nqs - 1
            {
                Rzz(-2.0 * J * t, qs[i], qs[(i + 1) % Nqs]);
            }
        }
        for i in 0 .. Nqs - 1
        {
            Rz(-2.0 * B * t, qs[i]);
        }
    }

    // ---------- for RQ1 ----------
    operation IsingEvolution_AddH(J : Double, B : Double, t : Double, qs : Qubit[]) : Unit
    {
        IsingEvolution(J, B, t, qs);
        H(qs[0]);
    }

    operation IsingEvolution_AddX(J : Double, B : Double, t : Double, qs : Qubit[]) : Unit
    {
        IsingEvolution(J, B, t, qs);
        X(qs[0]);
    }

    // ---------- for RQ2 ----------
    operation IsingEvolution_AddZ(J : Double, B : Double, t : Double, qs : Qubit[]) : Unit
    {
        IsingEvolution(J, B, t, qs);
        Z(qs[0]);
    }

    operation IsingEvolution_AddS(J : Double, B : Double, t : Double, qs : Qubit[]) : Unit
    {
        IsingEvolution(J, B, t, qs);
        S(qs[0]);
    }

    operation IsingEvolution_AddT(J : Double, B : Double, t : Double, qs : Qubit[]) : Unit
    {
        IsingEvolution(J, B, t, qs);
        T(qs[0]);
    }

    operation IsingEvolution_AddRz8(J : Double, B : Double, t : Double, qs : Qubit[]) : Unit
    {
        IsingEvolution(J, B, t, qs);
        Rz(PI() / 8.0, qs[0]);
    }

    operation IsingEvolution_AddRz16(J : Double, B : Double, t : Double, qs : Qubit[]) : Unit
    {
        IsingEvolution(J, B, t, qs);
        Rz(PI() / 16.0, qs[0]);
    }
    
    operation IsingEvolution_AddRz32(J : Double, B : Double, t : Double, qs : Qubit[]) : Unit
    {
        IsingEvolution(J, B, t, qs);
        Rz(PI() / 32.0, qs[0]);
    }
}
