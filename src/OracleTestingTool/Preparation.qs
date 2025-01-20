// Author: Peixun Long, Computing Center, Institute of High Energy Physics, CAS
// This package provides some operations to generate states which are typical and useful in testing from |0>.

namespace QSharpTester.Preparation
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arrays as Arrays;
    open Microsoft.Quantum.Math as Math;
    open Microsoft.Quantum.Convert as Convert;
    open Microsoft.Quantum.Random as Random;
    open QSharpTester.supplements as supplements;

    // Generate State by applying GFalse or GTrue gate to each qubit according to a Bool array.
    // bits : Bool[], the format of applying gate
    // GFalse : Single qubit gate applying on qubits whose corresponding bits are False
    // GTrue : Single qubit gate applying on qubits whose corresponding bits are True
    // qs : Qubit[], applied qubits
    // Example: if we chose bits = [true, true, false, true, false], GFalse = I, GTrue = X, and apply
    //          the function on |00000>, then it generates state |11010> (Big endian representation)
    operation ApplyGateByBoolArray(bits : Bool[], GFalse : Qubit => Unit, GTrue : Qubit => Unit, qs : Qubit[]) : Unit
    {
        let n = Length(qs);
        if (n != Length(bits))
        {
            fail "Qubit array and bool array have different length!";
        }
        for i in 0 .. n - 1
        {
            if (bits[i])
            { GTrue(qs[i]); }
            else
            { GFalse(qs[i]); }
        }
    }

    // Generate State according to a Bool array, where each gate is adjoint.
    // bits : Bool[], the format of applying gate
    // GFalse : Single qubit gate applying on qubits whose corresponding bits are False
    // GTrue : Single qubit gate applying on qubits whose corresponding bits are True
    // qs : Qubit[], applied qubits
    operation ApplyGateByBoolArrayA(bits : Bool[],
                                    GFalse : Qubit => Unit is Adj,
                                    GTrue : Qubit => Unit is Adj,
                                    qs : Qubit[]) : Unit is Adj
	{
        body (...)
        {
            let n = Length(qs);
            if (n != Length(bits))
            {
                fail "Qubit array and bool array have different length!";
            }
            for i in 0 .. n - 1
            {
                if (bits[i])
                { GTrue(qs[i]); }
                else
                { GFalse(qs[i]); }
            }
        }
        adjoint auto;
    }

    // Generate State according to a Bool array, where each gate is controlled.
    // bits : Bool[], the format of applying gate
    // GFalse : Single qubit gate applying on qubits whose corresponding bits are False
    // GTrue : Single qubit gate applying on qubits whose corresponding bits are True
    // qs : Qubit[], applied qubits
    operation ApplyGateByBoolArrayC(bits : Bool[],
                                    GFalse : Qubit => Unit is Ctl,
                                    GTrue : Qubit => Unit is Ctl,
                                    qs : Qubit[]) : Unit is Ctl
	{
        body (...)
        {
            let n = Length(qs);
            if (n != Length(bits))
            {
                fail "Qubit array and bool array have different length!";
            }
            for i in 0 .. n - 1
            {
                if (bits[i])
                { GTrue(qs[i]); }
                else
                { GFalse(qs[i]); }
            }
        }
        controlled auto;
    }

    // Generate State according to a Bool array, where each gate is both adjoint and controlled.
    // bits : Bool[], the format of applying gate
    // GFalse : Single qubit gate applying on qubits whose corresponding bits are False
    // GTrue : Single qubit gate applying on qubits whose corresponding bits are True
    // qs : Qubit[], applied qubits
    operation ApplyGateByBoolArrayCA(bits : Bool[],
                                    GFalse : Qubit => Unit is Adj + Ctl,
                                    GTrue : Qubit => Unit is Adj + Ctl,
                                    qs : Qubit[]) : Unit is Adj + Ctl
	{
        body (...)
        {
            let n = Length(qs);
            if (n != Length(bits))
            {
                fail "Qubit array and bool array have different length!";
            }
            for i in 0 .. n - 1
            {
                if (bits[i])
                { GTrue(qs[i]); }
                else
                { GFalse(qs[i]); }
            }
        }
        adjoint auto;
        controlled auto;
        controlled adjoint auto;
    }


    // Generate State from a given Bool array, |0> with FLASE and |1> with TRUE.
    // bits : Bool[], the format of state
    // qs : Qubit[], applied qubits
    operation CreateStateFromBoolArray(bits : Bool[], qs : Qubit[]) : Unit is Adj + Ctl
    {
        body (...)
        {
            ApplyGateByBoolArrayCA(bits, I, X, qs);
        }
        adjoint auto;
        controlled auto;
        controlled adjoint auto;
    }


    // Apply a series of operations successively
    // OpArray : Array of operations
    // qs : Qubit array, applied qubits
    operation ApplySeriesOfOps(OpArray : (Qubit[] => Unit)[], qs : Qubit[]) : Unit
    {
        for i in 0 .. Length(OpArray) - 1
        { OpArray[i](qs); }
    }

    // ApplySeriesOfOps with Adj and Ctl
    operation ApplySeriesOfOpsCA(OpArray : (Qubit[] => Unit is Adj + Ctl)[], qs : Qubit[]) : Unit is Adj + Ctl
    {
        body (...)
        {
            for i in 0 .. Length(OpArray) - 1
            { OpArray[i](qs); }
        }
        adjoint auto;
        controlled auto;
        controlled adjoint auto;
    }

    // ApplySeriesOfOps just Adj Version
    operation ApplySeriesOfOpsA(OpArray : (Qubit[] => Unit is Adj)[], qs : Qubit[]) : Unit is Adj
    {
        body (...)
        {
            for i in 0 .. Length(OpArray) - 1
            { OpArray[i](qs); }
        }
        adjoint auto;
    }

    // ApplySeriesOfOps just Ctl Version
    operation ApplySeriesOfOpsC(OpArray : (Qubit[] => Unit is Ctl)[], qs : Qubit[]) : Unit is Ctl
    {
        body (...)
        {
            for i in 0 .. Length(OpArray) - 1
            { OpArray[i](qs); }
        }
        controlled auto;
    }


    // Repeat Apply an operation successively for several times
    // Op : Operation
    // n : Int, times of applying, n >= 0
    // qs : Qubit[], target qubits
    operation OpPower(Op : Qubit[] => Unit, n : Int, qs : Qubit[]) : Unit
    {
        if (n < 0)
        {
            fail "General operation's Power should be >= 0!";
        }
        for i in 1 .. n
        { Op(qs); }
    }

    // OpPower with Adj and Ctl
    // n could be < 0
    operation OpPowerCA(Op : Qubit[] => Unit is Adj + Ctl, n : Int, qs : Qubit[]) : Unit is Adj + Ctl
    {
        body (...)
        {
            if (n > 0)
            {
                for i in 1 .. n
                { Op(qs); }
            }
            elif (n < 0)
            {
                for i in 1 .. -n
                { Adjoint Op(qs); }
            }
        }
        adjoint auto;
        controlled auto;
        controlled adjoint auto;
    }

    // OpPower with just Adj
    // n could be < 0
    operation OpPowerA(Op : Qubit[] => Unit is Adj, n : Int, qs : Qubit[]) : Unit is Adj
    {
        body (...)
        {
            if (n > 0)
            {
                for i in 1 .. n
                { Op(qs); }
            }
            elif (n < 0)
            {
                for i in 1 .. -n
                { Adjoint Op(qs); }
            }
        }
        adjoint auto;
    }

    // OpPower with just ctl
    // n must >= 0
    operation OpPowerC(Op : Qubit[] => Unit is Ctl, n : Int, qs : Qubit[]) : Unit is Ctl
    {
        body (...)
        {
            if (n < 0)
            {
                fail "General operation's Power should be >= 0!";
            }
            for i in 1 .. n
            { Op(qs); }
        }
        controlled auto;
    }


    // Wrap single qubit-operation as multi-qubits operation
    operation WrapGate(OP : Qubit => Unit, qs : Qubit[]) : Unit
    {
        OP(qs[0]);
    }

    // Wrap single qubit-operation as multi-qubits operation, adjoint version
    operation WrapGateA(OP : Qubit => Unit is Adj, qs : Qubit[]) : Unit is Adj
    {
        body (...)
        {
            OP(qs[0]);
        }
        adjoint auto;
    }

    // Wrap single qubit-operation as multi-qubits operation, controlled version
    operation WrapGateC(OP : Qubit => Unit is Ctl, qs : Qubit[]) : Unit is Ctl
    {
        body (...)
        {
            OP(qs[0]);
        }
        controlled auto;
    }

    // Wrap single qubit-operation as multi-qubits operation, adjoint + controlled version
    operation WrapGateCA(OP : Qubit => Unit is Adj + Ctl, qs : Qubit[]) : Unit is Adj + Ctl
    {
        body (...)
        {
            OP(qs[0]);
        }
        adjoint auto;
        controlled auto;
        controlled adjoint auto;
    }


    // Combine two operations as one
    operation CombineOPs(OP1 : (Qubit[] => Unit), NqsOP1 : Int, OP2 : (Qubit[] => Unit), NqsOP2 : Int, qs : Qubit[]) : Unit
    {
        OP1(qs[0 .. NqsOP1 - 1]);
        OP2(qs[NqsOP1 .. NqsOP1 + NqsOP2 - 1]);
    }


    // Create State |bits>+e^(iφ)|~bits> from |0..0>
    // bits : Bool[], specifying |bits>
    // phi : Double, specifying the angle φ
    // qs : Qubit[], applied qubits
    operation CreateKetBitsPlusEIPhiNegation(bits : Bool[], phi : Double, qs : Qubit[]) : Unit is Adj
    {
        body (...)
        {
            let n = Length(qs);
            if (n != Length(bits))
            {
                fail "Qubit array and bool array have different length!";
            }

            H(qs[0]);
            //Consider the first bit equals 0 or 1
            if (bits[0])    //first bit equals 1
            {
                Rz(-phi, qs[0]);
                for i in 1 .. n - 1
                {
                    if (not bits[i])    //bits[i] == 0
                    { X(qs[i]); }
                    CNOT(qs[0], qs[i]);
                }
            }
            else    //first bit equals 0
            {
                Rz(phi, qs[0]);
                for i in 1 .. n - 1
                {
                    if (bits[i])    //bits[i] == 1
                    { X(qs[i]); }
                    CNOT(qs[0], qs[i]);
                }
            }
		}

        adjoint auto;
    }

    // Create State |bits1>+e^(iφ)|bits2> from |0..0>
    // bits1 : Bool[], specifying |bits1>
    // bits2 : Bool[], specifying |bits2>
    // phi : Double, specifying the angle φ
    // qs : Qubit[], applied qubits
    operation CreateKetBits1PlusEIPhiKetBits2(bits1 : Bool[], bits2 : Bool[], phi : Double, qs : Qubit[]) : Unit is Adj
    {
        body (...)
        {
            let n = Length(qs);
            if (n != Length(bits1) or n != Length(bits2))
            {
                fail "Qubit array and bool array have different length!";
            }

            mutable DiffCount = 0;
            mutable DiffIndex = [0, size = n];
            for i in 0 .. n - 1
            {
                if (bits1[i] == bits2[i])
                {
                    if (bits1[i])
                    { X(qs[i]); }
                }
                else
                {
                    set DiffIndex w/= DiffCount <- i;
                    set DiffCount = DiffCount + 1;
                }
            }

            if (DiffCount == 0) { return (); }
            H(qs[DiffIndex[0]]);
            if (bits1[DiffIndex[0]])
            {
                Rz(-phi, qs[DiffIndex[0]]);
                for i in 1 .. DiffCount - 1
                {
                    if (not bits1[DiffIndex[i]])
                    { X(qs[DiffIndex[i]]); }
                    CNOT(qs[DiffIndex[0]], qs[DiffIndex[i]]);
                }
            }
            else
            {
                Rz(phi, qs[DiffIndex[0]]);
                for i in 1 .. DiffCount - 1
                {
                    if (bits1[DiffIndex[i]])
                    { X(qs[DiffIndex[i]]); }
                    CNOT(qs[DiffIndex[0]], qs[DiffIndex[i]]);
                }
            }
		}

        adjoint (...)
        {
            let n = Length(qs);
            if (n != Length(bits1) or n != Length(bits2))
            {
                fail "Qubit array and bool array have different length!";
            }

            mutable DiffCount = 0;
            mutable DiffIndex = [0, size = n];
            for i in 0 .. n - 1
            {
                if (bits1[i] == bits2[i])
                {
                    if (bits1[i])
                    { X(qs[i]); }
                }
                else
                {
                    set DiffIndex w/= DiffCount <- i;
                    set DiffCount = DiffCount + 1;
                }
            }

            if (DiffCount == 0) { return (); }
            if (bits1[DiffIndex[0]])
            {
                for i in 1 .. DiffCount - 1
                {
                    CNOT(qs[DiffIndex[0]], qs[DiffIndex[i]]);
                    if (not bits1[DiffIndex[i]])
                    { X(qs[DiffIndex[i]]); }
                }
                Rz(phi, qs[DiffIndex[0]]);
            }
            else
            {
                for i in 1 .. DiffCount - 1
                {
                    CNOT(qs[DiffIndex[0]], qs[DiffIndex[i]]);
                    if (bits1[DiffIndex[i]])
                    { X(qs[DiffIndex[i]]); }
                }
                Rz(-phi, qs[DiffIndex[0]]);
            }
            H(qs[DiffIndex[0]]);
        }
    }


    // Create Qubit with given θ, φ on Bloch sphere from |0>
    // theta : Double, the angle θ
    // phi : Double, the angle φ
    // q : Qubit, applied qubit
    operation CreateQubitOnBlochSphere(theta : Double, phi : Double, q : Qubit) : Unit is Adj + Ctl
    {
        body (...)
        {
            H(q);
            R1(theta, q);
            H(q);
            S(q);
            R1(phi, q);
        }
        adjoint auto;
        controlled auto;
        controlled adjoint auto;
    }

    // Create Qubit a|0>+be^(iφ)|1> from |0>, where |a|^2+|b|^2=1, so b is not necessary to specify
    // a : Double
    // phi : Double, the angle φ
    // q : Qubit, applied qubit
    operation CreateAKet0PlusEIPhiBKet1(a : Double, phi : Double, q : Qubit) : Unit is Adj + Ctl
    {
        body (...)
        {
            if (a < 0.0 or a > 1.0)
            {
                fail "The parameter a must in [0,1]";
            }
            let angle = 2.0 * Math.ArcCos(a);
            CreateQubitOnBlochSphere(angle, phi, q);
        }
        adjoint auto;
        controlled auto;
        controlled adjoint auto;
    }


    // Swap amplitudes of two given kets
    // ket1 : Bool[], user-specified ket1
    // ket2 : Bool[], user-specified ket2
    // qs : Qubit[], applied qubits
    // Example : if ket1 = [true, true, false, true] and ket2 = [false, true, false, false], then
    //           the function swaps the amplitude of |1101> and |0100> (Big endian representation)
    operation SwapAmplitudeOfTwoKets(ket1 : Bool[], ket2 : Bool[], qs : Qubit[]) : Unit
    {
        let n = Length(qs);
        if (n != Length(ket1) or n != Length(ket2))
        {
            fail "Qubit array and bool array have different length!";
        }

        use qaux = Qubit()
        {
            ApplyControlledOnBitString(ket1, X, qs, qaux);
            ApplyControlledOnBitString(ket2, X, qs, qaux);

            for i in 0 .. n - 1
            {
                if (ket1[i] != ket2[i])
                { CNOT(qaux, qs[i]); }
            }

            //Uncomputing
            ApplyControlledOnBitString(ket1, X, qs, qaux);
            ApplyControlledOnBitString(ket2, X, qs, qaux);
        }
    }


    // Give a phase shift e^(iφ) to a ket
    // ket : Bool[], specifying which ket needs to be operated
    // phi : Double, angle φ
    // qs : Qubit[], applied qubits
    // Example : if we set ket = [true, false], i.e. binary 10, phi = 0.5 * PI, and apply this function on
    //         state 1/2(|00>+|01>+|10>+|11>), then the state will change into 1/2(|00>+|01>+i|10>+|11>)
    operation PhaseShiftForKet(ket : Bool[], phi : Double, qs : Qubit[]) : Unit
    {
        let n = Length(qs);
        if (n != Length(ket))
        {
            fail "Qubit array and bool array have different length!";
        }
        use qaux = Qubit()
        {
            ApplyControlledOnBitString(ket, X, qs, qaux);
            R1(phi, qaux);
            ApplyControlledOnBitString(ket, X, qs, qaux);
        }
    }


    // Give a classical binary quantum state by an integer from |0>
    // number : Int, the integer
    // qs : Qubit[], applied qubits
    operation CreateQIntLE(number : Int, qs : Qubit[]) : Unit is Adj + Ctl
    {
        body (...)
        {
            let N = Length(qs);
            let barr = supplements.IntAsBoolArrayLE(number, N);
            CreateStateFromBoolArray(barr, qs);
        }
        adjoint auto;
        controlled auto;
        controlled adjoint auto;
    }

    // Give a classical binary quantum state by an integer from |0>
    // Bigendian version
    operation CreateQIntBE(number : Int, qs : Qubit[]) : Unit is Adj + Ctl
    {
        body (...)
        {
            let N = Length(qs);
            let barr = supplements.IntAsBoolArrayBE(number, N);
            CreateStateFromBoolArray(barr, qs);
        }
        adjoint auto;
        controlled auto;
        controlled adjoint auto;
    }


    // Create State |number1>+e^(iφ)|number2> from |0..0>
    // number1 : Int, specifying |number1>
    // number2 : Int, specifying |number2>
    // phi : Double, specifying the angle φ
    // qs : Qubit[], applied qubits. The cutoff of numbers is determined by Length(qs)
    operation CreateQInt1PlusEIPhiQInt2LE(number1 : Int, number2 : Int, phi : Double, qs : Qubit[]) : Unit is Adj
    {
        body (...)
        {
            let N = Length(qs);
            let barr1 = supplements.IntAsBoolArrayLE(number1, N);
            let barr2 = supplements.IntAsBoolArrayLE(number2, N);
            CreateKetBits1PlusEIPhiKetBits2(barr1, barr2, phi, qs);
        }
        adjoint auto;
    }


    // Create State |number1>+e^(iφ)|number2> from |0..0>
    // Bigendian version
    operation CreateQInt1PlusEIPhiQInt2BE(number1 : Int, number2 : Int, phi : Double, qs : Qubit[]) : Unit is Adj
    {
        body (...)
        {
            let N = Length(qs);
            let barr1 = supplements.IntAsBoolArrayBE(number1, N);
            let barr2 = supplements.IntAsBoolArrayBE(number2, N);
            CreateKetBits1PlusEIPhiKetBits2(barr1, barr2, phi, qs);
        }
        adjoint auto;
    }


    // Create mixed single qubit by given distribution
    // probs : Double[], the probabilities of each elements
    // opArray : Operation array, corrosponding to probs.
    // q : Qubit, target qubit
    // Example : If we set probs = [0.5, 0.5] and opArray = [I, X], we will get mixed state
    //           1/2|0><0|+1/2|1><1|
    operation CreateMixedQubit(probs : Double[], opArray : (Qubit => Unit)[], q : Qubit) : Unit
    {
        let rnd = Random.DrawRandomDouble(0.0, 1.0);
        mutable temp = 0.0;
        mutable i = -1;
        repeat
        {
            set i = i + 1;
            set temp = temp + probs[i];
        } until (temp >= rnd or i >= Length(probs) - 1);
        opArray[i](q);
    }

    // Create mixed state by given distribution
    // probs : Double[], the probabilities of each elements
    // opArray : Operation array, corrosponding to probs.
    // qs : Qubit[], target qubits
    // Example : If we set probs = [0.5, 0.5] and opArray = [I, X], we will get mixed state
    //           1/2|0><0|+1/2|1><1|
    operation CreateMixedState(probs : Double[], opArray : (Qubit[] => Unit)[], qs : Qubit[]) : Unit
    {
        let rnd = Random.DrawRandomDouble(0.0, 1.0);
        mutable temp = 0.0;
        mutable i = -1;
        repeat
        {
            set i = i + 1;
            set temp = temp + probs[i];
        } until (temp >= rnd or i >= Length(probs) - 1);
        opArray[i](qs);
    }

}
