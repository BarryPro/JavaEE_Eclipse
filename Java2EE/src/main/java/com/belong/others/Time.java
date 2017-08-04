package com.belong.others;

/**
 * Created by belong on 2016/12/19.
 */

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Time {
    Date now;
    Timer timer;
    JTextField lbl;

    public Time(JTextField l) {
        lbl = l;
        timer = new Timer(1000, new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                now = new Date(now.getTime() - 1000);

                SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
                lbl.setText(formatter.format(now));
            }
        });
    }

    @SuppressWarnings("deprecation")
    public void time_start() {
        // lbl.setText("00:00:10");
        now = new Date();
        now.setHours(0);
        now.setMinutes(0);
        now.setSeconds(10);
        timer.start();

    }

    public void time_stop() {
        timer.stop();

        lbl.setText("00:00:10");

    }

    public void time_restart() {
        timer.stop();
        this.time_start();
    }

}

