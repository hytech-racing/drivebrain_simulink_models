data = parseTableAsDouble('data/2024-07-06_11-16-41_rec.h5');

dat_fixed = convTable2Array(data);

str = resampleStruct(dat_fixed, dat_fixed, 0:0.01:351);


%%
% Initial state [Vx=0; omeg=; ax_filt=0]

initialState=[0,0,0];

dt = 0.01;
stateFcn = @(x, u) stateTransition(x, u, dt);
ekf = extendedKalmanFilter(stateFcn, @measFunc, initialState);
ekf.StateCovariance = 1e-2;
ekf.MeasurementNoise = diag([0.1, 0.1]); % Initial guess

vx_est = zeros(size(str.globalTime));
for i = 1:length(str.globalTime)

    
    ax_IMU = str.VNData.vn_linear_accel_m_ss.x(i);

    [pred_state, pred_state_cov] = ekf.predict(ax_IMU);  % use dt internally or pass dt if needed
    
    vx_est(i) = pred_state(1);
    % --- measurement update ---
    v_INS = str.VNData.vn_vel_m_s.x(i);  % from INS

    v_wheels = estimateVxTwoWheels(str.inv3_dynamics.actual_speed_rpm(i), str.inv4_dynamics.actual_speed_rpm(i), 0.2);  % from wheel speed estimator
    yaw_rate_IMU = str.VNData.vn_angular_rate_rad_s.z(i);
    
    
    % --- adaptive noise tuning ---
    if abs(v_INS) < 0.5
        R_INS = 0.5;
        R_wheels = 0.01;
    else
        R_INS = 0.002;
        R_wheels = 0.2;
    end



    if v_INS <= 0
        R_INS = 0.5;
        R_wheels = 0.01;
    end

    ekf.MeasurementNoise = diag([
        R_INS;   % INS Vx noise
        R_wheels;   % Wheel speed Vx noise
        0.02^2;  % Yaw rate IMU noise
        0.7^2    % Accelerometer noise
    ]);
    
    % --- correct ---
    z_meas = [v_INS; v_wheels; yaw_rate_IMU; ax_IMU];
    ekf.correct(z_meas);
end

close all;
hold on; grid on;
plot(vx_est)
plot(str.VNData.vn_vel_m_s.x)