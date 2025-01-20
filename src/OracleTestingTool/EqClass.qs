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

    // Type to record equivalence class for classical input
    //     SampleFunction : () => (Int, Int), the sample function of this eqivalence class
    //     ElementCount : Int, the number of inputs in this equivalence class
    struct EqClass
    {
        SampleFunction : () => (Int, Int),
        ElementCount : Int
    }
    struct EqClassPair
    {
        class1 : EqClass,
        class2 : EqClass
    }

    // Type to record equivalence class for single classical input
    //     SI means single input
    struct EqClassSI
    {
        SampleFunction : () => Int,
        ElementCount : Int
    }
    // Convert EqClassSI to general EqClass, acting on the first input variable
    function EqClassSI_To_EqClass_1st(cls : EqClassSI) : EqClass
    {
        let sf2 = () => (cls.SampleFunction(), 0);
        return EqClass(sf2, cls.ElementCount);
    }
    // Convert EqClassSI to general EqClass, acting on the second input variable
    function EqClassSI_To_EqClass_2nd(cls : EqClassSI) : EqClass
    {
        let sf2 = () => (0, cls.SampleFunction());
        return EqClass(sf2, cls.ElementCount);
    }

    // Type to record equivalence class for classical input using range
    struct EqClassRange
    {
        Xrange : Range,
        Yrange : Range
    }

    // count the number of elements in EqClassRange
    function CountEqClassRange(class : EqClassRange) : Int
    {
        let rcx = RangeCount(class.Xrange);
        let rcy = RangeCount(class.Yrange);
        if (rcx <= 0 and rcy <= 0) { return 0; }
        if (rcx <= 0) { return rcy; }
        if (rcy <= 0) { return rcx; }
        return rcx * rcy;
    }
    // is the EqClassRange object empty?
    function IsEmptyClass(class : EqClassRange) : Bool
    {
        if (CountEqClassRange(class) <= 0)
        { return true; }
        return false;
    }
    // is the EqClassRange object contains only one element?
    function ContainsOnlyOne(class : EqClassRange) : Bool
    {
        if (CountEqClassRange(class) == 1)
        { return true; }
        return false;
    }

    // sample (x, y) function from EqClassRange
    operation RandomSampleFromEqClass(class : EqClassRange) : (Int, Int)
    {
        let rx = DrawRandomIntFromRange(class.Xrange);
        let ry = DrawRandomIntFromRange(class.Yrange);
        return (rx, ry);
    }

    // Convert EqClassRange to general EqClass, adding the sample function
    function EqClassRange_To_EqClass(class : EqClassRange) : EqClass
    {
        let sf = () => RandomSampleFromEqClass(class);
        return EqClass(sf, CountEqClassRange(class));
    }

    // Build EqClass by range
    function BuildEqClassByRange(Xrange : Range, Yrange : Range) : EqClass
    {
        let temp = EqClassRange(Xrange, Yrange);
        return EqClassRange_To_EqClass(temp);
    }
    function BuildEqClassByXRange(Xrange : Range) : EqClass
    {
        let temp = EqClassRange(Xrange, 0 .. -1);
        return EqClassRange_To_EqClass(temp);
    }
    function BuildEqClassByYRange(Yrange : Range) : EqClass
    {
        let temp = EqClassRange(0 .. -1, Yrange);
        return EqClassRange_To_EqClass(temp);
    }

    // Build EqClassSI by range
    function BuildEqClassSIByRange(range : Range) : EqClassSI
    {
        let sf = () => DrawRandomIntFromRange(range);
        return EqClassSI(sf, RangeCount(range));
    }
}
