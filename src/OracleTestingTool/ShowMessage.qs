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

    function SHOW_MESSAGE() : Bool
    {
        // Whether to show the state checking message in Test***Input**()
        return false;
    }

}