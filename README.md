## Estimators
Default values for foxglove params are marked in parentheses. Estimators that depend on estimators are placed at the end.

### Estimators Order
1. wheel_steer_estimator
2. fz_estimator
3. amk_eff_estimator
4. vel_estimator
5. intent_estimator
6. tire_estimator

### wheel_steer_estimator
- non-param-inputs:
  1. steer_sensor_raw
- foxglove params:
  1. steer_sensor_offset (33.575)

### fz_estimator inputs:  
- non-param-inputs:  
   1. ax_m_s2
   2. ay_m_s2
   3. loadcell_fl
   4. loadcell_fr
   5. loadcell_rl
   6. loadcell_rr
- foxglove params:
  1. static_fz_N_fl (640, ~260 kg total mass, same for fr, rl, and rr)
  2. static_fz_N_fr
  3. static_fz_N_rl
  4. static_fz_N_rr
  5. cgz_m (0.27)
  6. Q (120)
  7. R (70)
 
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

### vel_estimator 
(TODO)

### intent_estimator
- estimator_output:
  1. vel_estimator_vx_est_m_s
  2. wheel_steer_estimator_wheel_steer_deg
- non-param-inputs:
  1. accel
  2. brake
  3. wz_rad_s
- foxglove-params:
  1. ay_cap_m_s2 (23)
  2. des_Mz_gain (1)
  3. drive_motor_torq_lim (21)
  4. regen_motor_torq_lim (-21)
  5. elec_p_lim_kW (80)
  6. motor_rpm_lim (20000)
  7. brake_deadzone (0.02)
  8. accel_deadzone (0.02)
 
### tire_estimator
- estimator_output:
  1. wheel_steer_estimator_wheel_steer_deg
  2. vel_estimator_vx_est_m_s
  3. vel_estimator_vy_est_m_s
- non-param-inputs:
  1. motor_rpm_fl
  2. motor_rpm_fr
  3. motor_rpm_rl
  4. motor_rpm_rr
  5. wz_rad_s

## Controllers
Default values for foxglove params are marked in parentheses.

### qp_torq_allocator
- estimator-output:
  1. intent_estimator_intent
  2. intent_estimator_max_tot_motor_torq_Nm
  3. intent_estimator_intent_elec_powerlimit_kW
  4. intent_estimator_intent_drive_motor_torq_lim
  5. intent_estimator_intent_regen_motor_torq_lim
  6. intent_estimator_intent_motor_rpm_lim
  7. intent_estimator_des_Mz_Nm
  8. amk_eff_estimator_amk_eff_fl
  9. amk_eff_estimator_amk_eff_fr
  10. amk_eff_estimator_amk_eff_rl
  11. amk_eff_estimator_amk_eff_rr
  12. tire_estimator_kappas_fl
  13. tire_estimator_kappas_fr
  14. tire_estimator_kappas_rl
  15. tire_estimator_kappas_rr
  16. fz_estimator_fz_est_N_fl
  17. fz_estimator_fz_est_N_fr
  18. fz_estimator_fz_est_N_rl
  19. fz_estimator_fz_est_N_rr
  20. vel_estimator_vx_est_m_s
 - non-param-inputs:
   1. motor_torq_Nm_fl (actual torque from inverters)
   2. motor_torq_Nm_fr
   3. motor_torq_Nm_rl
   4. motor_torq_Nm_rr
   5. motor_rpm_fl (actual rpm from inverters)
   6. motor_rpm_fr
   7. motor_rpm_rl
   8. motor_rpm_rr
- foxglove params:
  1. mux (1.9)
  2. high_axle_alpha (0.001)
  3. high_axle_beta (150000)
  4. high_axle_lambda (2)
  5. low_axle_alpha (0.00085)
  6. low_axle_beta (400000)
  7. low_axle_lambda (4)
  8. k_opt (0.1)
  9. torq_side_delta (10)
  10. torq_long_delta (15)
  11. w (1, values below 0.08 are set to 0.08)
  12. coast_brake_torq (-5, always negative)
      
