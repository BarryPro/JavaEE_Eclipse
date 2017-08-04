package QQ;
/**
 *这是一个定时器的任务类，用于刷新并显示当前时间
 */
import java.text.*;
import java.util.*;
import javax.swing.*;

class showTimeTask extends java.util.TimerTask{
    private JLabel showTime = null;

    showTimeTask(JLabel showTime) {
        this.showTime= showTime;
    }
    public void run() {
        //GregorianCalendar time = new GregorianCalendar();
        Date time = new java.util.Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
        String timeInfo = format.format(time);
        showTime.setText("现在时间：" + timeInfo + "    ");
    }
    }
