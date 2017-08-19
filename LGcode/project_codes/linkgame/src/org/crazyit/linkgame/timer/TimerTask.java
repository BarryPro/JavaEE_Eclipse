package org.crazyit.linkgame.timer;

import javax.swing.JLabel;


/**
 * ��ʱ�������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class TimerTask extends java.util.TimerTask {
	// ��ǰ�õ���ʱ��
	private long time;

	private GamePanel gamePanel;

	private long gameTime;

	private JLabel timeLabel;

	public TimerTask(GamePanel gamePanel, long gameTime, JLabel timeLabel) {
		this.time = 0;
		this.gamePanel = gamePanel;
		this.gameTime = gameTime;
		this.timeLabel = timeLabel;
	}

	public void run() {
		// ��Ϸʱ���ѵ�
		if (this.gameTime - this.time <= 0) {
			// ������ϷͼƬΪʧ��
			this.gamePanel.setOverImage(ImageUtil.getImage("images/lose.gif"));
			// ȡ���������
			this.cancel();
			this.gamePanel.repaint();
		}
		// �����Ϸ��Ȼ����, ����ʱ��
		this.timeLabel.setText(String.valueOf(this.gameTime - this.time));
		this.timeLabel.repaint();
		// ʹ�õ�ʱ��+1
		this.time += 1;
	}
}
