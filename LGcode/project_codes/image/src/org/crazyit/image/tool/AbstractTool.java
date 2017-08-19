package org.crazyit.image.tool;

import java.awt.Color;
import java.awt.Cursor;
import java.awt.Graphics;
import java.awt.event.MouseEvent;
import java.awt.image.BufferedImage;

import image.src.org.crazyit.image.ImageService;
import image.src.org.crazyit.image.MyImage;

/**
 * ���߳�����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public abstract class AbstractTool implements Tool {
	// ����ImageFrame
	private ImageFrame frame = null;
	// ���廭��Ŀ�
	public static int drawWidth = 0;
	// ���廭��ĸ�
	public static int drawHeight = 0;
	// ����Ĭ�����ָ��
	private Cursor defaultCursor = new Cursor(Cursor.DEFAULT_CURSOR);
	// ��������x����
	private int pressX = -1;
	// ��������y����
	private int pressY = -1;
	// ��ɫ
	public static Color color = Color.BLACK;

	/**
	 * ������
	 * 
	 * @param frame
	 *            Image Frame
	 */
	public AbstractTool(ImageFrame frame) {
		this.frame = frame;
		AbstractTool.drawWidth = frame.getBufferedImage().getWidth();
		AbstractTool.drawHeight = frame.getBufferedImage().getHeight();
	}

	public AbstractTool(ImageFrame frame, String path) {
		this(frame);
		// �����������ͼ��
		this.defaultCursor = ImageService.createCursor(path);
	}

	/**
	 * ��ȡImageFrame
	 * 
	 * @return ImageFrame
	 */
	public ImageFrame getFrame() {
		return this.frame;
	}

	/**
	 * ��ȡĬ�����ָ��
	 * 
	 * @return Cursor
	 */
	public Cursor getDefaultCursor() {
		return this.defaultCursor;
	}

	/**
	 * ����Ĭ�����ָ��
	 * 
	 * @param cursor
	 *            Cursor
	 * @return void
	 */
	public void setDefaultCursor(Cursor cursor) {
		this.defaultCursor = cursor;
	}

	/**
	 * ����x����
	 */
	public void setPressX(int x) {
		this.pressX = x;
	}

	/**
	 * ����y����
	 */
	public void setPressY(int y) {
		this.pressY = y;
	}

	/**
	 * ��ȡx����
	 */
	public int getPressX() {
		return this.pressX;
	}

	/**
	 * ��ȡy����
	 */
	public int getPressY() {
		return this.pressY;
	}

	/**
	 * �϶����
	 * 
	 * @param e
	 *            MouseEvent
	 * @return void
	 */
	public void mouseDragged(MouseEvent e) {
		// �϶�ͼ�α߽�
		dragBorder(e);
		// ��ͼ
		Graphics g = getFrame().getDrawSpace().getGraphics();
		createShape(e, g);

	}

	/**
	 * �ƶ����
	 * 
	 * @param e
	 *            MouseEvent
	 * @return void
	 */
	public void mouseMoved(MouseEvent e) {
		// ��ȡ������ڵ�x��y����
		int x = e.getX();
		int y = e.getY();
		// ��ȡĬ�����ָ��
		Cursor cursor = getDefaultCursor();
		// ������ָ�������½�
		if (x > AbstractTool.drawWidth - 4 && x < AbstractTool.drawWidth + 4
				&& y > AbstractTool.drawHeight - 4
				&& y < AbstractTool.drawHeight + 4) {
			// �����ָ��ı�Ϊ�����϶���״
			cursor = new Cursor(Cursor.NW_RESIZE_CURSOR);
		}
		// ������ָ��������
		if (x > AbstractTool.drawWidth - 4 && x < AbstractTool.drawWidth + 4
				&& y > (int) AbstractTool.drawHeight / 2 - 4
				&& y < (int) AbstractTool.drawHeight / 2 + 4) {
			// �����ָ��ı�Ϊ���϶���״
			cursor = new Cursor(Cursor.W_RESIZE_CURSOR);
		}
		// ������ָ��������
		if (y > AbstractTool.drawHeight - 4 && y < AbstractTool.drawHeight + 4
				&& x > (int) AbstractTool.drawWidth / 2 - 4
				&& x < (int) AbstractTool.drawWidth / 2 + 4) {
			// �����ָ��ı�Ϊ���϶���״
			cursor = new Cursor(Cursor.S_RESIZE_CURSOR);
		}
		// �������ָ������
		getFrame().getDrawSpace().setCursor(cursor);
	}

	/**
	 * �ɿ����
	 * 
	 * @param e
	 *            MouseEvent
	 * @return void
	 */
	public void mouseReleased(MouseEvent e) {
		// ��ͼ
		Graphics g = getFrame().getBufferedImage().getGraphics();
		createShape(e, g);
		// ��pressX��pressY����Ϊ��ʼֵ
		setPressX(-1);
		setPressY(-1);
		// �ػ�
		getFrame().getDrawSpace().repaint();
	}

	/**
	 * ��ͼ��
	 * 
	 * @param e
	 *            MouseEvent
	 * @param g
	 *            Graphics
	 */
	private void createShape(MouseEvent e, Graphics g) {
		// ���λ���ڻ�����
		if (getPressX() > 0 && getPressY() > 0 && e.getX() > 0
				&& e.getX() < AbstractTool.drawWidth && e.getY() > 0
				&& e.getY() < AbstractTool.drawHeight) {
			// ������ͼƬ�ػ�
			g.drawImage(getFrame().getBufferedImage(), 0, 0,
					AbstractTool.drawWidth, AbstractTool.drawHeight, null);
			// ������ɫ
			g.setColor(AbstractTool.color);
			getFrame().getBufferedImage().setIsSaved(false);
			// ��ͼ��
			draw(g, getPressX(), getPressY(), e.getX(), e.getY());
		}
	}

	/**
	 * �������
	 * 
	 * @param e
	 *            MouseEvent
	 * @return void
	 */
	public void mousePressed(MouseEvent e) {
		// ���λ����ͼƬ��Χ�ڣ����ð��µ�����
		if (e.getX() > 0 && e.getX() < AbstractTool.drawWidth && e.getY() > 0
				&& e.getY() < AbstractTool.drawHeight) {
			setPressX(e.getX());
			setPressY(e.getY());
		}
	}

	/**
	 * ���
	 * 
	 * @param e
	 *            MouseEvent
	 * @return void
	 */
	public void mouseClicked(MouseEvent e) {
	}

	/**
	 * ��ͼ��
	 * 
	 * @param g
	 *            Graphics
	 * @param x1
	 *            ���x����
	 * @param y1
	 *            ���y����
	 * @param x2
	 *            �յ�x����
	 * @param y2
	 *            �յ�y����
	 * @return void
	 */
	public void draw(Graphics g, int x1, int y1, int x2, int y2) {
	}

	/**
	 * �϶�ͼ�α߽�
	 * 
	 * @param e
	 *            MouseEvent
	 * @return void
	 */
	private void dragBorder(MouseEvent e) {
		getFrame().getBufferedImage().setIsSaved(false);
		// ��ȡ������ڵ�x��y����
		int cursorType = getFrame().getDrawSpace().getCursor().getType();
		int x = cursorType == Cursor.S_RESIZE_CURSOR ? AbstractTool.drawWidth
				: e.getX();
		int y = cursorType == Cursor.W_RESIZE_CURSOR ? AbstractTool.drawHeight
				: e.getY();
		MyImage img = null;
		// ������ָ�����϶�״̬
		if ((cursorType == Cursor.NW_RESIZE_CURSOR
				|| cursorType == Cursor.W_RESIZE_CURSOR || cursorType == Cursor.S_RESIZE_CURSOR)
				&& (x > 0 && y > 0)) {
			// getFrame().getDrawSpace().setSize( x + 4, y + 4 );
			// �ı�ͼ���С
			img = new MyImage(x, y, BufferedImage.TYPE_INT_RGB);
			Graphics g = img.getGraphics();
			g.setColor(Color.WHITE);
			g.drawImage(getFrame().getBufferedImage(), 0, 0,
					AbstractTool.drawWidth, AbstractTool.drawHeight, null);
			getFrame().setBufferedImage(img);
			// ���û����Ĵ�С
			AbstractTool.drawWidth = x;
			AbstractTool.drawHeight = y;
			// ����viewport
			ImageService.setViewport(frame.getScroll(), frame.getDrawSpace(),
					x, y);
		}
	}
}