# Code_of_Testing_Oracle_Quantum_Program_Article
Dear readers and reviewers,

Please find the source code of the prototype testing tool and the experimental evaluations in this repository. They are associated with the article entitled "A Black-box Testing Framework for Oracle Quantum Programs". To run the source code, it is necessary to install Azure Quantum Development Kit first.

    - /src is the sourcecode
        - /OracleTestingTool : the source code of prototype testing tool implemented by Q\# language.
        - /Programs : the benchmark programs for evaluation implemented by Q\# language.
        - /Tests : the Q\# scripts for executing evaluation.
        Experiment.py : Python code for analyzing the execution results.
        RQ1.py ~ RQ4.py : Python scripts for evaluating RQ1 ~ RQ4 in the article, the results will be saved in /results.
    - /results is to save the execution results of RQ*.py

Best regards,
All authors
