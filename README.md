## Estimators

### fz_estimator inputs:  
- non-param-inputs:  
   1. ax_m_s2
   2. ay_m_s2
   3. loadcell_fl
   4. loadcell_fr
   5. loadcell_rl
   6. loadcell_rr
- foxglove params:
  1. static_fz_N_fl (suggested default: 640 N, ~260 kg total mass, same for fr, rl, and rr)
  2. static_fz_N_fr
  3. static_fz_N_rl
  4. static_fz_N_rr
  5. cgz_m (suggested default: 0.27 m)
  6. Q (suggested default: 120)
  7. R (suggested default: 70)
 
### amk_eff_estimator inputs:
- non-param_inputs:
  1. torq_Nm_fl (actual torque value from inverters)
  2. torq_Nm_fr
  3. torq_Nm_rl
  4. torq_Nm_rr
  5. speed_rpm_fl (actual rpm from inverters)
  6. speed_rpm_fr
  7. speed_rpm_rl
  8. speed_rpm_rr
