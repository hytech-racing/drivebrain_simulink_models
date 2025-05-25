function Vx = estimateVxTwoWheels(rpm_FL, rpm_FR, rpm_RL, rpm_RR, r)

gearboxRatio = 11.83;
    % No compensation: straight or small delta
    rads_FL = rpm_FL * 0.10472;
    rads_FR = rpm_FR * 0.10472;

    rads_RL = rpm_RL * 0.10472;
    rads_RR = rpm_RR * 0.10472;
    
    Vx = 0.5 * r * (rads_RL/gearboxRatio + rads_RR/gearboxRatio);
end

