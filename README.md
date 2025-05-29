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
   - ax_m_s2
   - ay_m_s2
   - loadcell_fl
   - loadcell_fr
   - loadcell_rl
   - loadcell_rr
- foxglove params:
  - static_fz_N_fl (suggested default: 640 N, ~260 kg total mass, same for fr, rl, and rr)
  - static_fz_N_fr
  - static_fz_N_rl
  - static_fz_N_rr
  - cgz_m (suggested default: 0.27 m)
  - Q (suggested default: 120)
  - R (suggested default: 70)
 
### amk_eff_estimator inputs:
- non-param-inputs:
  - torq_Nm_fl (actual torque value from inverters)
  - torq_Nm_fr
  - torq_Nm_rl
  - torq_Nm_rr
  - speed_rpm_fl (actual rpm from inverters)
  - speed_rpm_fr
  - speed_rpm_rl
  - speed_rpm_rr

### vel_estimator inputs:
- non-param-inputs:
  - speed_rpm_fl (actual rpm from inverters)
  - speed_rpm_fr
  - speed_rpm_rl
  - speed_rpm_rr
  - delta_deg (raw steering input data)
  - brake (braking val from pedals system)
  - ins_mode (ins_mode_int)
  - wz_rad_s (yaw rate in rad/s)
  - ins_vel_u (Vectornav's velocity estimate uncertainty)
  - vx_m_s (velocity in m/s)
  - ax_m_s2
- foxglove params: (disclaimer, almost all of these have been pulled out of my ass except for the steer offset)
  - process_noise_vx: 0.2
  - process_noise_yaw_rate: 0.2
  - process_noise_ax: 0.2
  - percent_wheel_diff_noise_gain: 2
  - steer_sensor_offset suggested of 33.575
  - accel_noise_coef: 0.1
  - yaw_rate_noise_coef: 0.07

 
### amk_eff_estimator inputs:
- non-param_inputs:
  - torq_Nm_fl (actual torque value from inverters)
  - torq_Nm_fr
  - torq_Nm_rl
  - torq_Nm_rr
  - speed_rpm_fl (actual rpm from inverters)
  - speed_rpm_fr
  - speed_rpm_rl
  - speed_rpm_rr


### intent_estimator
- estimator_output:
  - vel_estimator_vx_est_m_s
  - wheel_steer_estimator_wheel_steer_deg
- non-param-inputs:
  - accel
  - brake
  - wz_rad_s
- foxglove-params:
  - ay_cap_m_s2 (23)
  - des_Mz_gain (1)
  - drive_motor_torq_lim (21)
  - regen_motor_torq_lim (-21)
  - elec_p_lim_kW (80)
  - motor_rpm_lim (20000)
  - brake_deadzone (0.02)
  - accel_deadzone (0.02)
 
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
      
