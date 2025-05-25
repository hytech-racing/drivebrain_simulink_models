function z = measFunc(x)
    % x = [Vx; omega; ax_filt]

    Vx = x(1);
    omega = x(2);
    ax_filt = x(3);

    % Measurements: [INS_Vx; Wheel_Vx; IMU_omega; Accelerometer_ax]
    z = [Vx; Vx; omega; ax_filt];
end