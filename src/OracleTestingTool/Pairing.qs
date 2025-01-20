namespace OracleTesting {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;
    open QSharpTester.Preparation;
    open QSharpTester.supplements;

    function DEFAULT_EQCLASSPAIR() : EqClassPair
    {
        let sf = () => (0, 0);
        return EqClassPair(EqClass(sf, 0), EqClass(sf, 0))
    }

    // All coverage pairing
    function AllCoveragePairing(classes : EqClass[]) : EqClassPair[]
    {
        let N = Length(classes);
        mutable ret = [DEFAULT_EQCLASSPAIR(), size = N * (N - 1) / 2];
        mutable k = 0;
        for i in 0 .. N - 2
        {
            for j in i + 1 .. N - 1
            {
                set ret w/= k <- EqClassPair(classes[i], classes[j]);
                set k = k + 1;
            }
        }
        return ret;
    }

    // Tree coverage pairing
    function TreeCoveragePairing(classes : EqClass[]) : EqClassPair[]
    {
        let N = Length(classes);
        mutable ret = [DEFAULT_EQCLASSPAIR(), size = N - 1];
        for i in 0 .. N - 2
        {
            set ret w/= i <- EqClassPair(classes[i], classes[i + 1]);
        }
        return ret;
    }

    function SizeOfEachChoice(N : Int) : Int
    {
        if (N % 2 == 1)
        { return N / 2 + 1; }
        else
        { return N / 2; }
    }

    // Each-choice pairing
    function EachChoicePairing(classes : EqClass[]) : EqClassPair[]
    {
        let N = Length(classes);
        mutable ret = [DEFAULT_EQCLASSPAIR(), size = SizeOfEachChoice(N)];
        for i in 0 .. 2 .. N - 1
        {
            let j = i / 2;
            if (i == N - 1)
            {
                set ret w/= j <- EqClassPair(classes[i], classes[0]);
            }
            else
            {
                set ret w/= j <- EqClassPair(classes[i], classes[i + 1]);
            }
        }
        return ret;
    }
}
