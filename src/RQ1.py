import Experiment
import sys
TestNcb = range(1, 11)

def RQ1_EvaluateWithNcb(programname : str) -> None:
    print('--------- Evaluate RQ1 ----------')
    print('Program Name :  ', programname)
    for i in TestNcb:
        tempstr = programname + '(' + str(i) + ', 1, 1)'
        print(' -- Ncb = ', i)
        Experiment.RQ1_RunTest(tempstr, Experiment.DefaultShots)


ProgramList = ["OracleTesting.Test_Parity_phase",
               "OracleTesting.Test_Parity_qubit",
               "OracleTesting.Test_Is2Power_phase",
               "OracleTesting.Test_Is2Power_qubit",
               "OracleTesting.Test_LessThanM_phase",
               "OracleTesting.Test_LessThanM_qubit",
               "OracleTesting.Test_QAdder",
               "OracleTesting.Test_HamiltonX",
               "OracleTesting.Test_Ising",
               "OracleTesting.Test_MixedProc"]
SuffixList = [ "_AddH", "_AddX" ]

def EvaluateRQ1(plist, slist) -> None:
    for prog in plist:
        for suff in slist:
            pname = prog + suff
            RQ1_EvaluateWithNcb(pname)


with open("results/RQ1.txt", "w") as f:
    sys.stdout = f
    EvaluateRQ1(ProgramList, SuffixList)
