namespace OracleTesting {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;
    open QSharpTester.supplements;

    operation CRk(qctrl: Qubit, k: Int, qtarget: Qubit) : Unit is Adj
    {
        body(...)
        {
            let theta = 2.0 * PI() / IntAsDouble(2^k);
            Controlled R1([qctrl], (theta, qtarget));
        }
        adjoint auto;
    }

    operation Reverse(qs : Qubit[]) : Unit is Adj
    {
        body(...)
        {
            let n = Length(qs);
            for i in 0 .. n / 2 - 1
            {
                SWAP(qs[i], qs[n - i - 1]);
            }
        }
        adjoint auto;
    }

    operation QAdder(qx : Qubit[], qy : Qubit[]) : Unit
    {
        let N = Length(qx);
        if (Length(qy) != N)
        { fail("Different length!"); }

        within
        {
            ApplyQFT(qy);
            Reverse(qy);        // "ApplyQFT" function does not contain "Reverse" at the end
        }
        apply
        {
            for i in 0 .. N - 1
            {
                for j in 0 .. N - i - 1
                { CRk(qx[j], N - i - j, qy[i]); }
            }
        }
    }

    // ---------- for RQ1 ----------
    operation QAdder_AddH(qx : Qubit[], qy : Qubit[]) : Unit
    {
        QAdder(qx, qy);
        H(qx[0]);
    }

    operation QAdder_AddX(qx : Qubit[], qy : Qubit[]) : Unit
    {
        QAdder(qx, qy);
        X(qx[0]);
    }

    // ---------- for RQ2 ----------
    operation QAdder_AddZ(qx : Qubit[], qy : Qubit[]) : Unit
    {
        QAdder(qx, qy);
        Z(qx[0]);
    }

    operation QAdder_AddS(qx : Qubit[], qy : Qubit[]) : Unit
    {
        QAdder(qx, qy);
        S(qx[0]);
    }

    operation QAdder_AddT(qx : Qubit[], qy : Qubit[]) : Unit
    {
        QAdder(qx, qy);
        T(qx[0]);
    }

    operation QAdder_AddRz8(qx : Qubit[], qy : Qubit[]) : Unit
    {
        QAdder(qx, qy);
        Rz(PI() / 8.0, qx[0]);
    }

    operation QAdder_AddRz16(qx : Qubit[], qy : Qubit[]) : Unit
    {
        QAdder(qx, qy);
        Rz(PI() / 16.0, qx[0]);
    }

    operation QAdder_AddRz32(qx : Qubit[], qy : Qubit[]) : Unit
    {
        QAdder(qx, qy);
        Rz(PI() / 32.0, qx[0]);
    }


    // ---------- for RQ3 ----------
    operation QAdder_BE(qx : Qubit[], qy : Qubit[]) : Unit
    {
        Reverse(qx);
        Reverse(qy);
        QAdder(qx, qy);
        Reverse(qx);
        Reverse(qy);
    }

    // change the value of 0+0
    //    let 0 + 0 == 1
    operation QAdder_change0p0(qx : Qubit[], qy : Qubit[]) : Unit
    {
        QAdder(qx, qy);

        MultiX(qx);
        Controlled X(qx, qy[0]);        //let 0+0 == 1
        MultiX(qx);
    }
}
