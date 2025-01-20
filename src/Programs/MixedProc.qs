namespace OracleTesting {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;
    open QSharpTester.supplements;

    // ---------- Correct program ----------
    operation MixedProc(t : Double, qx : Qubit[], qy : Qubit[]) : Unit
    {
        HamiltonX(t, qy);
        QAdder(qx, qy);
    }

    // ---------- for RQ1 ----------
    operation MixedProc_AddH(t : Double, qx : Qubit[], qy : Qubit[]) : Unit
    {
        MixedProc(t, qx, qy);
        H(qx[0]);
    }

    operation MixedProc_AddX(t : Double, qx : Qubit[], qy : Qubit[]) : Unit
    {
        MixedProc(t, qx, qy);
        X(qx[0]);
    }

    // ---------- for RQ2 ----------
    operation MixedProc_AddZ(t : Double, qx : Qubit[], qy : Qubit[]) : Unit
    {
        MixedProc(t, qx, qy);
        Z(qx[0]);
    }

    operation MixedProc_AddS(t : Double, qx : Qubit[], qy : Qubit[]) : Unit
    {
        MixedProc(t, qx, qy);
        S(qx[0]);
    }

    operation MixedProc_AddT(t : Double, qx : Qubit[], qy : Qubit[]) : Unit
    {
        MixedProc(t, qx, qy);
        T(qx[0]);
    }

    operation MixedProc_AddRz8(t : Double, qx : Qubit[], qy : Qubit[]) : Unit
    {
        MixedProc(t, qx, qy);
        Rz(PI() / 8.0, qx[0]);
    }

    operation MixedProc_AddRz16(t : Double, qx : Qubit[], qy : Qubit[]) : Unit
    {
        MixedProc(t, qx, qy);
        Rz(PI() / 16.0, qx[0]);
    }

    operation MixedProc_AddRz32(t : Double, qx : Qubit[], qy : Qubit[]) : Unit
    {
        MixedProc(t, qx, qy);
        Rz(PI() / 32.0, qx[0]);
    }
}