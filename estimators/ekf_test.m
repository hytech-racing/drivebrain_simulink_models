data = parseTableAsDouble('data/2024-07-07_13-04-37_rec.h5');
% data = parseTableAsDouble('data/2024-07-07_12-42-59_rec.h5');

dat_fixed = convTable2Array(data);

str = resampleStruct(dat_fixed, dat_fixed, 0:0.01:200);



load('erm.mat')

%%
% Initial state [Vx=0; omeg=; ax_filt=0]

steering_offset = 33.575;

str.steering_data.steering_analog_raw(str.steering_data.steering_analog_raw < min(steer_sensor))=min(steer_sensor);
str.steering_data.steering_analog_raw(str.steering_data.steering_analog_raw > max(steer_sensor))=max(steer_sensor);
rack_mm_mov = interp1(steer_sensor, rack_mm, (str.steering_data.steering_analog_raw - steering_offset), 'linear','extrap');

rack_mm_mov(rack_mm_mov < min(mbd_rack_movement))=min(mbd_rack_movement);
rack_mm_mov(rack_mm_mov > max(mbd_rack_movement))=max(mbd_rack_movement);
str.steering_data.steering_analog_raw(str.steering_data.steering_analog_raw > max(steer_sensor))=max(steer_sensor);
fl_delta = interp1(mbd_rack_movement, wheel_steer_left, rack_mm_mov, 'linear','extrap');
fr_delta = interp1(mbd_rack_movement, wheel_steer_right, rack_mm_mov, 'linear','extrap')
delta_deg = (fl_delta + fr_delta) / 2;

%%
initialState=[0,0,0];

dt = 0.01;
stateFcn = @(x, u) stateTransition(x, u, dt);
ekf = extendedKalmanFilter(stateFcn, @measFunc, initialState);
ekf.StateCovariance = 1e-2;
ekf.MeasurementNoise = diag([0.1, 0.1]); % Initial guess

vx_est = zeros(size(str.globalTime));
v_wheels_arr = zeros(size(str.globalTime));

slip_est = zeros(size(str.globalTime));
for i = 1:length(str.globalTime)

    
    ax_IMU = str.VNData.vn_linear_accel_m_ss.x(i);

    [pred_state, pred_state_cov] = ekf.predict(ax_IMU);  % use dt internally or pass dt if needed
    
    vx_est(i) = pred_state(1);
    
    % --- measurement update ---
    v_INS = str.VNData.vn_vel_m_s.x(i);  % from INS

    target = data.VNData.status.ins_mode.Timestamp;
    [~, idx] = min(abs(str.globalTime(i) - target));  % Find index of closest value
    
    tr = 1.2;
    yaw_rate_IMU = str.VNData.vn_angular_rate_rad_s.z(i);
    [v_wheels, perc_diff] = estimateVxTwoWheels(str.inv3_dynamics.actual_speed_rpm(i), str.inv4_dynamics.actual_speed_rpm(i), 0.2, yaw_rate_IMU, tr);  % from wheel speed estimator
    v_wheels_arr(i) = v_wheels;
    
    if(v_wheels > 0.2)
        slip_est(i) = min(abs((v_wheels- vx_est(i))) / v_wheels, 1.0);
        slip_est(i) = max(slip_est(i), 0.0);
    else
        slip_est(i)=0;
    end
    

    %yaw_rate_IMU = str.VNData.vn_angular_rate_rad_s.z(i);
    
    %delta_rad = deg2rad(delta_deg(i));
    %v_wheels, perc_diff = estimateVx4Wheels(str.inv1_dynamics.actual_speed_rpm(i), ...
    %   str.inv2_dynamics.actual_speed_rpm(i), ...
    %    str.inv3_dynamics.actual_speed_rpm(i), ...
    %    str.inv4_dynamics.actual_speed_rpm(i), ...
    %    0.2, ...
    %    delta_rad, ...
    %    yaw_rate_IMU, ...
    %    tr); 
   
    
    
    % --- adaptive noise tuning ---

    ekf.MeasurementNoise = diag([
        0.1;   % INS Vx noise
        abs(perc_diff);   % Wheel speed Vx noise
        0.02^2;  % Yaw rate IMU noise
        0.3^2    % Accelerometer noise
    ]);

    
    % --- correct ---
    z_meas = [v_INS; v_wheels; yaw_rate_IMU; ax_IMU];
    ekf.correct(z_meas);
end

close all;
hold on;
grid on;
% Create subplots
figure;
ax1 = subplot(3,1,1);
plot(str.globalTime, vx_est, str.globalTime, str.VNData.vn_vel_m_s.x, str.globalTime, v_wheels_arr);
xlabel(ax1, 'Time (s)');
ylabel(ax1, 'Vx m/s');
title(ax1, 'velocity estimate');
legend(ax1, {'vx\_est', 'VN Vx', 'Vx wheels est'});

ax2 = subplot(3,1,2);
plot(str.globalTime, str.inv3_dynamics.actual_speed_rpm, str.globalTime, str.inv4_dynamics.actual_speed_rpm);
xlabel(ax2, 'Time (s)');
ylabel(ax2, 'RPM');
title(ax2, 'wheel RPMs');
legend(ax2, {'RL RPM', 'RR RPM'});
% Link x-axes


ax3 = subplot(3, 1, 3);
plot(str.globalTime, slip_est);
xlabel(ax3, 'Time (s)');
ylabel(ax3, 'slip ratio');
title(ax3, 'slip');
legend(ax3, {'slip'});
% Link x-axes
linkaxes([ax1, ax2, ax3], 'x');

