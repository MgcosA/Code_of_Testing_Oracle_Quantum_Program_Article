import Experiment
import sys

Ncb = 1
Ntv = 100
Cpair = 1

def RQ4_Evaluate(programname : str) -> None:
    print('--------- Evaluate RQ4 ----------')
    print('Program Name :  ', programname)
    tempstr = programname + '(' + str(Ncb) +  ',' + str(Ntv) + ',' + str(Cpair) + ')'
    Experiment.RQ4_RunTest(tempstr, Experiment.DefaultShots)

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
SuffixList = [ "", "_AddH", "_AddX", 
               "_AddZ", "_AddS", "_AddT", "_AddRz8", "_AddRz16", "_AddRz32" ]
ProgramList_nosuffix = ["OracleTesting.Test_Parity_phase_FlipOut",
               "OracleTesting.Test_Is2Power_phase_FlipOut",
               "OracleTesting.Test_GreaterThanEqM_phase",
               "OracleTesting.Test_Parity_qubit_FlipOut",
               "OracleTesting.Test_Is2Power_qubit_FlipOut",
               "OracleTesting.Test_GreaterThanEqM_qubit",
               "OracleTesting.Test_LessThanM_phase_BE",
               "OracleTesting.Test_LessThanM_qubit_BE",
               "OracleTesting.Test_QAdder_BE",
               "OracleTesting.Test_HamiltonX_BE",
               "OracleTesting.Test_Parity_phase_FlipAll1",
               "OracleTesting.Test_Parity_qubit_FlipAll1",
               "OracleTesting.Test_LessThanEqM_phase",
               "OracleTesting.Test_LessThanEqM_qubit",
               "OracleTesting.Test_QAdder_change0p0"
            ]


def EvaluateRQ4(plist, slist) -> None:
    for prog in plist:
        for suff in slist:
            pname = prog + suff
            RQ4_Evaluate(pname)
def EvaluateRQ4_nosuffix(plist) -> None:
    for prog in plist:
        RQ4_Evaluate(prog)


with open("results/RQ4.txt", "w") as f:
    sys.stdout = f
    EvaluateRQ4(ProgramList, SuffixList)
    EvaluateRQ4_nosuffix(ProgramList_nosuffix)
