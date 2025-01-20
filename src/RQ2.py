import Experiment
import sys
TestNtv = [1, 2, 5, 10, 20, 50, 100, 200, 500, 1000]

def RQ2_EvaluateWithNtv(programname : str) -> None:
    print('--------- Evaluate RQ2 ----------')
    print('Program Name :  ', programname)
    for i in TestNtv:
        tempstr = programname + '(1, ' + str(i) + ', 1)'
        print(' -- Ntv = ', i)
        Experiment.RQ2_RunTest(tempstr, Experiment.DefaultShots)

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
SuffixList = [ "_AddZ", "_AddS", "_AddT", "_AddRz8", "_AddRz16", "_AddRz32" ]

def EvaluateRQ2(plist, slist) -> None:
    for prog in plist:
        for suff in slist:
            pname = prog + suff
            RQ2_EvaluateWithNtv(pname)


with open("results/RQ2.txt", "w") as f:
    sys.stdout = f
    EvaluateRQ2(ProgramList, SuffixList)
