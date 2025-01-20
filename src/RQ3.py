import Experiment
import sys

def CriterionName(index : int) -> str:
    if index == 1:
        return 'AllCoveragePairing'
    elif index == 2:
        return 'TreeCoveragePairing'
    elif index == 3:
        return 'EachChoicePairing'
    return 'Unknown'

TestCriterion = [1, 2, 3]
TestNcb = 1
TestNtv = 100

def RQ3_Evaluate(programname : str) -> None:
    print('--------- Evaluate RQ3 ----------')
    print('Program Name :  ', programname)
    for i in TestCriterion:
        tempstr = programname + '(' + str(TestNcb) + ', ' + str(TestNtv) + ', ' + str(i) + ')'
        print(' -- Pairing Criterion : ', CriterionName(i))
        Experiment.RQ3_RunTest(tempstr, Experiment.DefaultShots)

ProgramList = ["OracleTesting.Test_Parity_phase_FlipOut",
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

def EvaluateRQ3(plist) -> None:
    for prog in plist:
        RQ3_Evaluate(prog)

with open("results/RQ3.txt", "w") as f:
    sys.stdout = f
    EvaluateRQ3(ProgramList)
