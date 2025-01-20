// This file defines the index of each pairing function.

namespace OracleTesting
{
    function PAIRFUNC(index : Int) : EqClass[] -> EqClassPair[]
    {
        if (index == 1)
        { return AllCoveragePairing; }
        elif (index == 2)
        { return TreeCoveragePairing; }
        elif (index == 3)
        { return EachChoicePairing; }
        else
        { fail "Invalid index of pairing function!"; }
    }
}