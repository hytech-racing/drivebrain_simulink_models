## Estimators

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
 