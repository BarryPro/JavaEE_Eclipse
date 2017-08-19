package org.crazyit.image.tool;

import java.awt.Graphics;
import java.awt.event.MouseEvent;

/**
 * ����ι���
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class PolygonTool extends AbstractTool {
	private int firstX = -1;
	private int firstY = -1;
	private int lastX = -1;
	private int lastY = -1;

	private static Tool tool = null;

	private PolygonTool(ImageFrame frame) {
		super(frame);
	}

	public static Tool getInstance(ImageFrame frame) {
		if (tool == null) {
			tool = new PolygonTool(frame);
		}
		return tool;
	}

	/**
	 * �ɿ����
	 * 
	 * @param e
	 *            MouseEvent
	 * @return void
	 */
	public void mouseReleased(MouseEvent e) {
		int pressX = getPressX();
		int pressY = getPressY();
		// ���ø�������ֱ��
		super.mouseReleased(e);
		// ���õ�һ�������һ������
		if (firstX == -1) {
			firstX = pressX;
			firstY = pressY;
		}
		lastX = e.getX();
		lastY = e.getY();
	}

	/**
	 * ���
	 * 
	 * @param e
	 *            MouseEvent
	 * @return void
	 */
	public void mouseClicked(MouseEvent e) {
		Graphics g = getFrame().getBufferedImage().getGraphics();
		if (e.getClickCount() == 2 && firstX > 0 && e.getX() > 0
				&& e.getX() < AbstractTool.drawWidth && e.getY() > 0
				&& e.getY() < AbstractTool.drawHeight) {
			g.setColor(AbstractTool.color);
			g.drawImage(getFrame().getBufferedImage(), 0, 0,
					AbstractTool.drawWidth, AbstractTool.drawHeight, null);
			draw(g, 0, 0, firstX, firstY);
			draw(g, 0, 0, lastX, lastY);
			setPressX(-1);
			setPressY(-1);
			firstX = -1;
			firstY = -1;
			lastX = -1;
			lastY = -1;
			getFrame().getDrawSpace().repaint();
		}
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
		// �������
		int x = lastX > 0 ? lastX : getPressX();
		int y = lastY > 0 ? lastY : getPressY();
		// ����Բ
		g.drawLine(x, y, x2, y2);
	}
}
