# Assignment 3: Unit Commitment and Economic Dispatch Tasks

## [ ] Task 1: Baseline Execution and Data Fixes
- **Action**: Run the existing 4-unit system using the initial data provided in the sources.
- **Modification**: Update the 4-unit generator data in `DP_input_data.m` to include quadratic cost coefficients (`coef_a`, `coef_b`, `coef_c`), as these are currently set to `NaN`.
    > [!NOTE]
    > This fix is required because the program will fail to run the quadratic programming (`QUADPROG`) method without these values.
- **Execution**: Execute the program for each of the three built-in dispatch methods by changing the `DISPATCH_METHOD` flag:
    1. **Method 1**: Quadratic Programming (`QUADPROG`)
    2. **Method 2**: Linear Programming (`LINPROG`)
    3. **Method 3**: Quick Dispatch (a linear merit-order heuristic)
- **Reporting**: Record the **Total Cost** and the **Elapsed Time** for each method.

---

## [ ] Task 2: System Scaling and Data Expansion
- **Action**: Expand the 4-unit system's `DEMAND` vector from the provided 8 hours to a full 24-hour profile.
- **Modification**: Manually hypothesize the load for the additional 16 hours, ensuring the demand remains within the physical limits of the 4 generators:
    - The hourly demand must not exceed the total maximum capacity ($P_{max}$).
    - The hourly demand must not fall below the total minimum stable generation ($P_{min}$).
- **Action**: Switch the input data to one of the 10-unit system data sets provided in the sources (e.g., the Abdelaziz et al. or Benhamida et al. data).
- **Execution**: Execute the 10-unit system using all three dispatch methods mentioned in Task 1.
- **Reporting**: Document the **Total Cost** and **Elapsed Time** for both the 24-hour 4-unit system and the 10-unit system.

---

## [ ] Task 3: Metaheuristic Integration
- **Action**: Locate the section in the `DP_v8.m` code where the economic dispatch optimization functions (like `linprog` or `quadprog`) are called (typically around line 442).
- **Modification**: Replace the call to one of these classic optimizers with a metaheuristic optimization technique.
    - The **Genetic Algorithm (`ga`)** is highly recommended as it is a built-in MATLAB function.
    - **Bonus**: You may also explore other metaheuristics like **Particle Swarm Optimization (`particleswarm`)**.
- **Execution**: Execute the UC program using the new metaheuristic method on both the extended 4-unit system and the 10-unit system.

---

## [ ] Task 4: Comparison and Final Report
- **Action**: Compile all results into a comprehensive summary report.
- **Reporting**: Compare the performance of the **Classic Optimization Methods** (`QUADPROG` and `LINPROG`) against the **Metaheuristic Technique** (e.g., GA).
- **Justification**: Evaluate each method based on:
    - **Solution Quality**: Which method resulted in the lowest Total Cost?
    - **Computational Efficiency**: Which method was the fastest (Elapsed Time), and is it suitable for online applications?
- **Analysis**: Document and explain any failures encountered, such as instances where the program could not find a feasible solution due to strict constraints like ramp rates or minimum up/down times.
