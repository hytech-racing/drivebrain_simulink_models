function x_next = stateTransition(x, u)
    % State: [Vx; omega; ax_filt]
    % Input: u(1) = raw ax
    dt = 0.004;
    Vx = x(1);
    omega = x(2);
    ax_filt = x(3);
    ax_raw = u(1);

    tau = 0.2;  % low-pass filter time constant

    % Dynamics (dx = f(x, u))
    dVx = ax_filt;
    domega = 0;
    dax_filt = (1/tau) * (ax_raw - ax_filt);

    % Euler integration
    x_next = zeros(3,1);
    x_next(1) = Vx + dt * dVx;
    x_next(2) = omega + dt * domega;
    x_next(3) = ax_filt + dt * dax_filt;
end