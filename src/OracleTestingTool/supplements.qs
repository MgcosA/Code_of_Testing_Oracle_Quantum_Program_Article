// Author: Peixun Long, Computing Center, Institute of High Energy Physics, CAS

namespace QSharpTester.supplements
{

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Random;

    // MULTI series for single qubit gates
    operation MULTI(Gate : (Qubit => Unit is Adj + Ctl), qs : Qubit[]) : Unit is Adj + Ctl
    {
        for i in 0 .. Length(qs) - 1
        { Gate(qs[i]); }
    }
    operation MultiH(qs : Qubit[]) : Unit is Adj + Ctl
    {
        MULTI(H, qs);
    }
    operation MultiX(qs : Qubit[]) : Unit is Adj + Ctl
    {
        MULTI(X, qs);
    }
    operation MultiY(qs : Qubit[]) : Unit is Adj + Ctl
    {
        MULTI(Y, qs);
    }
    operation MultiZ(qs : Qubit[]) : Unit is Adj + Ctl
    {
        MULTI(Z, qs);
    }
    operation MultiS(qs : Qubit[]) : Unit is Adj + Ctl
    {
        MULTI(S, qs);
    }
    operation MultiT(qs : Qubit[]) : Unit is Adj + Ctl
    {
        MULTI(T, qs);
    }

    // Bigendian version of ResultArrayAsInt
    function ResultArrayAsIntBE(results : Result[]) : Int
    {
        mutable ret = 0;
        let n = Length(results);
        for i in 0 .. n - 1
        {
            if (results[i] == One)
            {
                set ret = ret + 2 ^ (n - i - 1);
            }
        }
        return ret;
    }

    // Bigendian version of BoolArrayAsInt
    function BoolArrayAsIntBE(bits : Bool[]) : Int
    {
        mutable ret = 0;
        let n = Length(bits);
        for i in 0 .. n - 1
        {
            if (bits[i])
            {
                set ret = ret + 2 ^ (n - i - 1);
            }
        }
        return ret;
    }

    // Bigendian version of IntAsBoolArray
    function IntAsBoolArrayBE(number : Int, bits : Int) : Bool[]
    {
        //mutable ret = new Bool[bits];
        mutable ret = [false, size = bits];
        mutable temp = number;
        for i in bits - 1 .. -1 .. 0
        {
            if ((temp &&& 1) == 1)
            {
                set ret w/= i <- true;
            }
            else
            {
                set ret w/= i <- false;
            }
            set temp = temp >>> 1;
        }
        return ret;
    }

    // Littleendian version of IntAsBoolArray
    function IntAsBoolArrayLE(number : Int, bits : Int) : Bool[]
    {
        if (bits <= 0) { return []; }
        return IntAsBoolArray(number, bits);
    }


    // NaN of Double
    //function NaN() : Double
    //{
    //    return 1.797693134862e308;
    //}

    // Identity operation
    operation Oid(qs : Qubit[]) : Unit is Adj + Ctl {}

    // Identity function
    function Fid<'TYPE>(input : 'TYPE) : 'TYPE
    {
        return input;
    }

    // Given a number, return 
    function LengthOfBits(nBits : Int) : Int
    {
        if (nBits == 0) { return 0; }
        mutable len = 1;
        mutable temp = 2;
        while (temp < nBits)
        {
            set len = len + 1;
            set temp = temp <<< 1;
        }
        return len;
    }


    // RAD to DEG
    function RadAsDeg(rad : Double) : Double
    {
        return (rad * 180.0 / PI());
    }
    // DEG to RAD
    function DegAsRad(deg : Double) : Double
    {
        return (deg * PI() / 180.0);
    }
    // RAD to multiple of PI
    function RadAsMultipleOfPI(rad : Double) : Double
    {
        return (rad / PI());
    }
    // Multiple of PI to RAD
    function MultipleOfPIAsRad(kpi : Double) : Double
    {
        return (kpi * PI());
    }


    // BitString Version of AssertProbInt
    // operation AssertProbBitString(stateBitString : Bool[], expected : Double, qubits : Qubit[], tolerance : Double) : Unit
    // {
    //     use flag = Qubit();
    //     within
    //     {
    //         ControlledOnBitString(stateBitString, X)(qubits, flag);
    //     }
    //     apply
    //     {
    //         AssertMeasurementProbability([PauliZ], [flag], One, expected,
    //             $"AssertProbBoolArray failed on stateBitString {stateBitString}, expected probability {expected}.", tolerance);
    //     }
    // }


    // ReverseOrderOfQubits
    operation ReverseOrderOfQubits(qs : Qubit[]) : Unit
    {
        let n = Length(qs);
        if (n >= 2)
        {
            for i in 0 .. n / 2 - 1
            { SWAP(qs[i], qs[n - i - 1]); }
        }
    }

    // Return the number of integers of a range
    function RangeCount(rng : Range) : Int
    {
        return (RangeEnd(rng) - RangeStart(rng)) / RangeStep(rng) + 1;
    }

    operation DrawRandomIntFromRange(rng : Range) : Int
    {
        let N = RangeCount(rng);
        if (N <= 0) { return 0; }
        let step = RangeStep(rng);
        let rndidx = DrawRandomInt(0, N - 1);
        return RangeStart(rng) + rndidx * step;
    }
}
