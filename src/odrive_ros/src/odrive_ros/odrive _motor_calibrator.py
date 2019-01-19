import sys
import os
import time
import keyboard
import odrive
from odrive.enums import *

pos_gain_factor = .5
vel_gain_factor = .0005
integrator_gain_factor = .0005


def main():
    odrv = odrive.find_any()

    print("running calibration sequence...")
    print('make sure motor in on m0')
    print()

    odrv.axis0.config.startup_motor_calibration = True
    odrv.axis0.config.startup_encoder_offset_calibration = True
    odrv.axis0.config.startup_closed_loop = True
    odrv.axis0.request_state = AXIS_STATE_STARTUP_SEQUENCE
    
    active_state = 1 #1 = pos_gain, 2 = vel_gain, 3 = integrator
    while odrv.axis0.current_state != AXIS_STATE_CLOSED_LOOP_CONTROL:
       time.sleep(.01)
    print('ready to tune the motor')
    print('controls:')
    print('option             how to select         increase         decrease')
    print('Position gain            8                   9                 7')
    print('Velocity gain            5                   6                 4')
    print('Integrator gain          2                   3                 1')
    print()
    print('rotate motor: r (in degrees)')
    print('change speed: v (in RPM)')
    print('exit: 0')
    print()
    while not(keyboard.is_pressed(0)):
        #screen update
        sel_pos = " "
        sel_vel = " "
        sel_int = " "
        if active_state == 1:
            sel_pos = "0"
        elif active_state == 2:
            sel_vel = "0"
        elif active_state == 3:
            sel_int = "0"
        print('option                selected           increase         decrease', end='\r')
        print('Position gain            ',sel_pos,'                   9                 7', end='\r')
        print('Velocity gain            ',sel_vel,'                    6                 4', end='\r')
        print('Integrator gain          ',sel_int,'                    3                 1', end='\r')
        print()
        print('rotate motor: r (in degrees)')
        print('change speed: v (in RPM)')
        print('exit: 0')
        print()
        print('position gain: ' + str(odrv.axis0.controller.config.pos_gain), end='\r')
        print('velocity gain: ' + str(odrv.axis0.controller.config.vel_gain), end='\r')
        print('integrator gain: ' + str(odrv.axis0.controller.config.vel_integrator_gain), end='\r')


        #control loop
        if keyboard.is_pressed(8):
            active_state = 1
        if keyboard.is_pressed(5):
            active_state = 2
        if keyboard.is_pressed(2):
            active_state = 3
        if keyboard.is_pressed('up'):
            active_state -= 1
            if active_state <= 0:
                active_state = 3
        if keyboard.is_pressed('down'):
            active_state += 1
            if active_state > 3:
                active_state = 1

        if active_state == 1:
            if keyboard.is_pressed(9) or keyboard.is_pressed('right'):
                odrv.axis0.controller.config.pos_gain = odrv.axis0.controller.config.pos_gain + pos_gain_factor
            if keyboard.is_pressed(7) or keyboard.is_pressed('left'):
                odrv.axis0.controller.config.pos_gain = odrv.axis0.controller.config.pos_gain - pos_gain_factor

        if active_state == 2:
            if keyboard.is_pressed(6) or keyboard.is_pressed('right'):
                odrv.axis0.controller.config.vel_gain = odrv.axis0.controller.config.vel_gain + vel_gain_factor
            if keyboard.is_pressed(4) or keyboard.is_pressed('left'):
                odrv.axis0.controller.config.vel_gain = odrv.axis0.controller.config.vel_gain - vel_gain_factor

        if active_state == 3:
            if keyboard.is_pressed(3) or keyboard.is_pressed('right'):
                odrv.axis0.controller.config.vel_integrator_gain = odrv.axis0.controller.config.vel_integrator_gain + integrator_gain_factor
            if keyboard.is_pressed(1) or keyboard.is_pressed('left'):
                odrv.axis0.controller.config.vel_integrator_gain = odrv.axis0.controller.config.vel_integrator_gain - integrator_gain_factor

        if keyboard.is_pressed('r'):
            angle = input('enter the angle you would to rotate to (degres): ')
            odrv.axis0.controller.pos_setpoint = int(angle) * 254 #get the counts per rotation later
        elif keyboard.is_pressed('v'):
            speed = input('enter the speed you want (RPM): ')
            rps = float(speed)/60
            odrv.axis0.controller.vel_setpoint = rps * 1024 #get the counts per rotation later

    save = input('would you like to save config y/n')
    if save != 'n':
        odrv.axis0.motor.config.pre_calibrated = True
        odrv.save_configutaion()

    save = input('would you like to precalibrate the encoder for future use (only yes if encoder has a index(Z) signal) y/n')
    if save != 'n':
        odrv.axis0.encoder.config.pre_calibrated = True
        odrv.save_configutaion()
        

if __name__ == '__main__':
    main()