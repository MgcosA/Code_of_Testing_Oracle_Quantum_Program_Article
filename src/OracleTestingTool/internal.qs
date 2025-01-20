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

    operation __ApplyOnQx(ObjProc : (Qubit[]) => Unit, Qx : Qubit[], Qy : Qubit[]) : Unit
    {
        ObjProc(Qx);
    }
    operation __ApplyOnQy(ObjProc : (Qubit[]) => Unit, Qx : Qubit[], Qy : Qubit[]) : Unit
    {
        ObjProc(Qy);
    }
    //Run quantum program with 1 qubit array parameter on |x>
    function OnX(ObjProc : (Qubit[]) => Unit) : (Qubit[], Qubit[]) => Unit
    {
        return __ApplyOnQx(ObjProc, _, _);
    }
    //Run quantum program with 1 qubit array parameter on |y>
    function OnY(ObjProc : (Qubit[]) => Unit) : (Qubit[], Qubit[]) => Unit
    {
        return __ApplyOnQy(ObjProc, _, _);
    }
    
    //Run input |x>|y> --> |x>|F(x,y)> Bigendian
    operation RunClassicalInputBE(ObjProc : (Qubit[], Qubit[]) => Unit,
                                   Case : TestCase, Qx : Qubit[], Qy : Qubit[]) : Unit
    {
        CreateQIntBE(Case::InputX, Qx);
        CreateQIntBE(Case::InputY, Qy);
        ObjProc(Qx, Qy);
        Adjoint CreateQIntBE(Case::InputX, Qx);
        Adjoint CreateQIntBE(Case::FXY, Qy);
    }

    //Run input |x>|y> --> |x>|F(x,y)> Littleendian
    operation RunClassicalInputLE(ObjProc : (Qubit[], Qubit[]) => Unit,
                                   Case : TestCase, Qx : Qubit[], Qy : Qubit[]) : Unit
    {
        CreateQIntLE(Case::InputX, Qx);
        CreateQIntLE(Case::InputY, Qy);
        ObjProc(Qx, Qy);
        Adjoint CreateQIntLE(Case::InputX, Qx);
        Adjoint CreateQIntLE(Case::FXY, Qy);
    }

    //Run two value superposition state in bigendian
    //  |x1>|y1>+|x2>|y2> --> e^{iG(x1,y1)}|x1>|F(x1,y1)>+e^{iG(x2,y2)}|x2>|F(x2,y2)>
    operation RunTwoValueInputBE(ObjProc : (Qubit[], Qubit[]) => Unit,
                                  Case1 : TestCase, Case2 : TestCase,
                                  Qx : Qubit[], Qy : Qubit[]) : Unit
    {
        let Nqx = Length(Qx);
        let Nqy = Length(Qy);
        let X1Array = IntAsBoolArrayBE(Case1::InputX, Nqx);
        let Y1Array = IntAsBoolArrayBE(Case1::InputY, Nqy);
        let X2Array = IntAsBoolArrayBE(Case2::InputX, Nqx);
        let Y2Array = IntAsBoolArrayBE(Case2::InputY, Nqy);
        let FX1Y1Array = IntAsBoolArrayBE(Case1::FXY, Nqy);
        let FX2Y2Array = IntAsBoolArrayBE(Case2::FXY, Nqy);

        let Input1Array = Flattened([X1Array, Y1Array]);
        let Input2Array = Flattened([X2Array, Y2Array]);
        let Output1Array = Flattened([X1Array, FX1Y1Array]);
        let Output2Array = Flattened([X2Array, FX2Y2Array]);
        let DiffG = Case2::GXY - Case1::GXY;
        let Qxy = Flattened([Qx, Qy]);

        CreateKetBits1PlusEIPhiKetBits2(Input1Array, Input2Array, 0.0, Qxy);
        ObjProc(Qx, Qy);
        Adjoint CreateKetBits1PlusEIPhiKetBits2(Output1Array, Output2Array, DiffG, Qxy);
    }

    //Run two value superposition state in littleendian
    //  |x1>|y1>+|x2>|y2> --> e^{iG(x1,y1)}|x1>|F(x1,y1)>+e^{iG(x2,y2)}|x2>|F(x2,y2)>
    operation RunTwoValueInputLE(ObjProc : (Qubit[], Qubit[]) => Unit,
                                  Case1 : TestCase, Case2 : TestCase,
                                  Qx : Qubit[], Qy : Qubit[]) : Unit
    {
        let Nqx = Length(Qx);
        let Nqy = Length(Qy);
        let X1Array = IntAsBoolArrayLE(Case1::InputX, Nqx);
        let Y1Array = IntAsBoolArrayLE(Case1::InputY, Nqy);
        let X2Array = IntAsBoolArrayLE(Case2::InputX, Nqx);
        let Y2Array = IntAsBoolArrayLE(Case2::InputY, Nqy);
        let FX1Y1Array = IntAsBoolArrayLE(Case1::FXY, Nqy);
        let FX2Y2Array = IntAsBoolArrayLE(Case2::FXY, Nqy);

        let Input1Array = Flattened([X1Array, Y1Array]);
        let Input2Array = Flattened([X2Array, Y2Array]);
        let Output1Array = Flattened([X1Array, FX1Y1Array]);
        let Output2Array = Flattened([X2Array, FX2Y2Array]);
        let DiffG = Case2::GXY - Case1::GXY;
        let Qxy = Flattened([Qx, Qy]);

        CreateKetBits1PlusEIPhiKetBits2(Input1Array, Input2Array, 0.0, Qxy);
        ObjProc(Qx, Qy);
        Adjoint CreateKetBits1PlusEIPhiKetBits2(Output1Array, Output2Array, DiffG, Qxy);
    }

    function ShowTestClsInputPass(Nx : Int, Ny : Int, x : Int, y : Int, result : Bool) : Unit
    {
        if (not SHOW_MESSAGE()) { return (); }
    
        mutable msg = "Test ";
        if (result)
        { set msg = msg + "PASS  "; }
        else
        { set msg = msg + "FAIL!!!  "; }

        if (Nx > 0)
        { set msg = msg + $"|x={x}>"; }
        if (Ny > 0)
        { set msg = msg + $"|y={y}>"; }
        Message(msg);
    }

    operation TestClassicalInputBE(ObjProc : (Qubit[], Qubit[]) => Unit,
                                   Nx : Int, Ny : Int, Case : TestCase, 
                                   Nrepeat : Int) : Bool
    {
        use Qx = Qubit[Nx];
        use Qy = Qubit[Ny];

        for i in 1 .. Nrepeat
        {
            ResetAll(Qx);
            ResetAll(Qy);
            RunClassicalInputBE(ObjProc, Case, Qx, Qy);
            let mx = MeasureInteger(Qx);
            let my = MeasureInteger(Qy);
            if (mx != 0 or my != 0)
            {
                ShowTestClsInputPass(Nx, Ny, Case::InputX, Case::InputY, false);
                ResetAll(Qx);
                ResetAll(Qy);
                return false;
            }
        }
        
        ShowTestClsInputPass(Nx, Ny, Case::InputX, Case::InputY, true);
        ResetAll(Qx);
        ResetAll(Qy);
        return true;
    }

    operation TestClassicalInputLE(ObjProc : (Qubit[], Qubit[]) => Unit,
                                   Nx : Int, Ny : Int, Case : TestCase, 
                                   Nrepeat : Int) : Bool
    {
        use Qx = Qubit[Nx];
        use Qy = Qubit[Ny];

        for i in 1 .. Nrepeat
        {
            ResetAll(Qx);
            ResetAll(Qy);
            RunClassicalInputLE(ObjProc, Case, Qx, Qy);
            let mx = MeasureInteger(Qx);
            let my = MeasureInteger(Qy);
            if (mx != 0 or my != 0)
            {
                ShowTestClsInputPass(Nx, Ny, Case::InputX, Case::InputY, false);
                ResetAll(Qx);
                ResetAll(Qy);
                return false;
            }
        }
        
        ShowTestClsInputPass(Nx, Ny, Case::InputX, Case::InputY, true);
        ResetAll(Qx);
        ResetAll(Qy);
        return true;
    }


    function ShowTestTVInputPass(Nx : Int, Ny : Int, x1 : Int, y1 : Int, x2 : Int, y2 : Int, result : Bool) : Unit
    {
        if (not SHOW_MESSAGE()) { return (); }

        mutable msg = "Test ";
        if (result)
        { set msg = msg + "PASS  "; }
        else
        { set msg = msg + "FAIL!!!  "; }

        if (Nx > 0)
        { set msg = msg + $"|x1={x1}>"; }
        if (Ny > 0)
        { set msg = msg + $"|y1={y1}>"; }
        set msg = msg + " + ";
        if (Nx > 0)
        { set msg = msg + $"|x2={x2}>"; }
        if (Ny > 0)
        { set msg = msg + $"|y2={y2}>"; }
        Message(msg);
    }

    operation TestTwoValueInputBE(ObjProc : (Qubit[], Qubit[]) => Unit,
                                   Nx : Int, Ny : Int, Case1 : TestCase, Case2 : TestCase, 
                                   Nrepeat : Int) : Bool
    {
        use Qx = Qubit[Nx];
        use Qy = Qubit[Ny];

        for i in 1 .. Nrepeat
        {
            ResetAll(Qx);
            ResetAll(Qy);
            RunTwoValueInputBE(ObjProc, Case1, Case2, Qx, Qy);
            let mx = MeasureInteger(Qx);
            let my = MeasureInteger(Qy);
            if (mx != 0 or my != 0)
            {
                ShowTestTVInputPass(Nx, Ny, Case1::InputX, Case1::InputY, Case2::InputX, Case2::InputY, false);
                ResetAll(Qx);
                ResetAll(Qy);
                return false;
            }
        }

        ShowTestTVInputPass(Nx, Ny, Case1::InputX, Case1::InputY, Case2::InputX, Case2::InputY, true);
        ResetAll(Qx);
        ResetAll(Qy);
        return true;
    }

    operation TestTwoValueInputLE(ObjProc : (Qubit[], Qubit[]) => Unit,
                                   Nx : Int, Ny : Int, Case1 : TestCase, Case2 : TestCase, 
                                   Nrepeat : Int) : Bool
    {
        use Qx = Qubit[Nx];
        use Qy = Qubit[Ny];

        for i in 1 .. Nrepeat
        {
            ResetAll(Qx);
            ResetAll(Qy);
            RunTwoValueInputLE(ObjProc, Case1, Case2, Qx, Qy);
            let mx = MeasureInteger(Qx);
            let my = MeasureInteger(Qy);
            if (mx != 0 or my != 0)
            {
                ShowTestTVInputPass(Nx, Ny, Case1::InputX, Case1::InputY, Case2::InputX, Case2::InputY, false);
                ResetAll(Qx);
                ResetAll(Qy);
                return false;
            }
        }

        ShowTestTVInputPass(Nx, Ny, Case1::InputX, Case1::InputY, Case2::InputX, Case2::InputY, true);
        ResetAll(Qx);
        ResetAll(Qy);
        return true;
    }


    function BoolFuncAsPhaseG(BoolFunc : Int -> Bool, x : Int, y : Int) : Double
    {
        if (BoolFunc(y))
        { return PI(); }
        return 0.0;
    }

    function WrapGyToGxy(G : Int -> Double, x : Int, y : Int) : Double
    {
        return G(y);
    }

    operation WrapOneYToTwo(ObjProc : Qubit[] => Unit, qx : Qubit[], qy : Qubit[]) : Unit
    {
        ObjProc(qy);
    }

    function BoolFuncAsQubitF(BoolFunc : Int -> Bool, x : Int, y : Int) : Int
    {
        if ( (BoolFunc(x) and y == 0) or (not BoolFunc(x) and y != 0) )
        { return 1; }
        return 0;
    }

    operation WrapQAQubitAsTwoQA(ObjProc : (Qubit[], Qubit) => Unit, qx : Qubit[], qy : Qubit[]) : Unit
    {
        ObjProc(qx, qy[0]);
    }
}