package ball.src.org.crazyit.ball;

import java.awt.Image;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

/**
 * ���浯����Ϸ�������ĸ���
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class BallComponent {
	// ����x����
	private int x = -1;
	// ����y����
	private int y = -1;
	// ����ͼƬ
	private Image image = null;
	// ����ͼƬ�ٶ�
	private int speed = 5;

	/**
	 * ������
	 * 
	 * @param path
	 *            String ͼƬ·��
	 */
	public BallComponent(String path) throws IOException {
		super();
		this.image = ImageIO.read(new File(path));
	}

	/**
	 * ������
	 * 
	 * @param panelWidth
	 *            int ������
	 * @param panelHeight
	 *            int ����߶�
	 * @param path
	 *            String ͼƬ·��
	 */
	public BallComponent(int panelWidth, int panelHeight, String path)
			throws IOException {
		super();
		// ��ȡͼƬ
		this.image = ImageIO.read(new File(path));
		// ����x����
		this.x = (int) ((panelWidth - image.getWidth(null)) / 2);
	}

	/**
	 * ������
	 * 
	 * @param x
	 *            int ͼ���x����
	 * @param y
	 *            int ͼ���y����
	 * @param path
	 *            String ͼƬ·��
	 */
	public BallComponent(String path, int x, int y) throws IOException {
		super();
		// ��ȡͼƬ
		this.image = ImageIO.read(new File(path));
		this.x = x;
		this.y = y;
	}

	/**
	 * ��ȡx����
	 * 
	 * @return int x����
	 */
	public int getX() {
		return this.x;
	}

	/**
	 * ��ȡy����
	 * 
	 * @return int y����
	 */
	public int getY() {
		return this.y;
	}

	/**
	 * ��ȡͼƬ�ٶ�
	 * 
	 * @return int ͼƬ�ٶ�
	 */
	public int getSpeed() {
		return this.speed;
	}

	/**
	 * ����x����
	 * 
	 * @param x
	 *            int x����
	 * @return void
	 */
	public void setX(int x) {
		this.x = x;
	}

	/**
	 * ����y����
	 * 
	 * @param y
	 *            int y����
	 * @return void
	 */
	public void setY(int y) {
		this.y = y;
	}

	/**
	 * ����ͼƬ
	 * 
	 * @return Image ͼƬ
	 */
	public Image getImage() {
		return this.image;
	}
}