package ball.src.org.crazyit.ball;

import java.io.IOException;

/**
 * С�����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class Ball extends BallComponent {
	// ������������ٶ�
	private int speedY = 10;
	// ���嵯��ĺ����ٶ�
	private int speedX = 8;
	// �����Ƿ����˶�
	private boolean started = false;
	// �����Ƿ�����˶�
	private boolean stop = false;

	/**
	 * m �в���������
	 * 
	 * @param panelWidth
	 *            int ������
	 * @param panelHeight
	 *            int ����߶�
	 * @param offset
	 *            int λ��
	 * @param path
	 *            String ͼƬ·��
	 */
	public Ball(int panelWidth, int panelHeight, int offset, String path)
			throws IOException {
		// ���ø�������
		super(panelWidth, panelHeight, path);
		// ����y����
		this.setY(panelHeight - super.getImage().getHeight(null) - offset);
	}

	/**
	 * ���ú����ٶ�
	 * 
	 * @param speed
	 *            int �ٶ�
	 * @return void
	 */
	public void setSpeedX(int speed) {
		this.speedX = speed;
	}

	/**
	 * ���������ٶ�
	 * 
	 * @param speed
	 *            int �ٶ�
	 * @return void
	 */
	public void setSpeedY(int speed) {
		this.speedY = speed;
	}

	/**
	 * �����Ƿ����˶�
	 * 
	 * @param b
	 *            boolean
	 * @return void
	 */
	public void setStarted(boolean b) {
		this.started = b;
	}

	/**
	 * �����Ƿ�����˶�
	 * 
	 * @param b
	 *            boolean
	 * @return void
	 */
	public void setStop(boolean b) {
		this.stop = b;
	}

	/**
	 * ���غ����ٶ�
	 * 
	 * @return int �ٶ�
	 */
	public int getSpeedX() {
		return this.speedX;
	}

	/**
	 * ���������ٶ�
	 * 
	 * @return int �ٶ�
	 */
	public int getSpeedY() {
		return this.speedY;
	}

	/**
	 * �Ƿ����˶�
	 * 
	 * @return boolean �Ƿ����˶�
	 */
	public boolean isStarted() {
		return this.started;
	}

	/**
	 * �Ƿ��Ѿ������˶�
	 * 
	 * @return boolean �Ƿ��Ѿ������˶�
	 */
	public boolean isStop() {
		return this.stop;
	}

}