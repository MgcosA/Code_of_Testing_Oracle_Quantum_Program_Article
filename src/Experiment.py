import qsharp
import time
qsharp.init(project_root='.')
DefaultShots = 100

def CalcProportion(total : int, part : int) -> str:
    if total <= 0:
        return "N/A"
    prop = float(part) / float(total) * 100.0
    return str(prop) + " %"


# Analyze a testing result
def AnalyzeResult(resultlist : tuple, RQindex : int) -> None:
    Nshots = len(resultlist)
    Npassshots = 0
    Sum_CB_input = 0
    Sum_TVsame_input = 0
    Sum_TVdiff_input = 0
    Sum_CB_pass = 0
    Sum_TVsame_pass = 0
    Sum_TVdiff_pass = 0

    for res in resultlist:
        Sum_CB_input     += res[0]
        Sum_TVsame_input += res[1]
        Sum_TVdiff_input += res[2]
        Sum_CB_pass      += res[3]
        Sum_TVsame_pass  += res[4]
        Sum_TVdiff_pass  += res[5]
        if (Sum_CB_pass == Sum_CB_input and Sum_TVsame_pass == Sum_TVsame_input and Sum_TVdiff_pass == Sum_TVdiff_input):
            Npassshots += 1

    if RQindex == 1:
        print("Number of PASS shots: ", Npassshots)
        print("Total tested inputs: ", Sum_CB_input)
        print("PASS  tested inputs: ", Sum_CB_pass)
    elif RQindex == 2:
        print("Number of PASS shots: ", Npassshots)
        print("Total tested inputs: ", Sum_TVsame_input + Sum_TVdiff_input)
        print("PASS  tested inputs: ", Sum_TVsame_pass + Sum_TVdiff_pass)
    elif RQindex >= 3:
        print("Number of shots: ", Nshots)
        print("Number of PASS shots: ", Npassshots)
        print("   For computational-basis input")
        print("      - Total tested inputs: ", Sum_CB_input)
        print("      - PASS  tested inputs: ", Sum_CB_pass)
        print("      - Proportion of PASS : ", CalcProportion(Sum_CB_input, Sum_CB_pass))
        print("   For two-value-superposition input for same equivalence class")
        print("      - Total tested inputs: ", Sum_TVsame_input)
        print("      - PASS  tested inputs: ", Sum_TVsame_pass)
        print("      - Proportion of PASS : ", CalcProportion(Sum_TVsame_input, Sum_TVsame_pass))
        print("   For two-value-superposition input for difference two equivalence classes")
        print("      - Total tested inputs: ", Sum_TVdiff_input)
        print("      - PASS  tested inputs: ", Sum_TVdiff_pass)
        print("      - Proportion of PASS : ", CalcProportion(Sum_TVdiff_input, Sum_TVdiff_pass))


def RQ1_RunTest(programname, Nshots) -> None:
    temp = qsharp.run(programname, shots=Nshots)
    AnalyzeResult(temp, 1)

def RQ2_RunTest(programname, Nshots) -> None:
    temp = qsharp.run(programname, shots=Nshots)
    AnalyzeResult(temp, 2)

def RQ3_RunTest(programname, Nshots) -> None:
    temp = qsharp.run(programname, shots=Nshots)
    AnalyzeResult(temp, 3)

# Run testing for a program
def RQ4_RunTest(programname, Nshots) -> None:
    # Run each test case and record the result
    t0 = time.time()
    temp = qsharp.run(programname, shots=Nshots)
    t1 = time.time()
    runtime = (t1 - t0) * 1000
    print('Program name: ', programname)
    print('Total running time: ', runtime, 'ms')
    print('Average running time for each shot: ', float(runtime) / float(Nshots), 'ms')
    AnalyzeResult(temp, 4)
