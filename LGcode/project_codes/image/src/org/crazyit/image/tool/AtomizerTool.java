package org.crazyit.image.tool;

import java.awt.Graphics;
import java.awt.event.MouseEvent;
import java.util.Random;

/**
 * ��ī����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class AtomizerTool extends AbstractTool {
	private static Tool tool = null;

	private AtomizerTool(ImageFrame frame) {
		super(frame, "img/atomizercursor.gif");
	}

	public static Tool getInstance(ImageFrame frame) {
		if (tool == null) {
			tool = new AtomizerTool(frame);
		}
		return tool;
	}

	/**
	 * �������
	 * 
	 * @param e
	 *            MouseEvent
	 * @return void
	 */
	public void mousePressed(MouseEvent e) {
		if (e.getX() > 0 && e.getX() < AbstractTool.drawWidth && e.getY() > 0
				&& e.getY() < AbstractTool.drawHeight) {
			setPressX(e.getX());
			setPressY(e.getY());
			Graphics g = getFrame().getBufferedImage().getGraphics();
			draw(e, g);
		}
	}

	/**
	 * �϶����
	 * 
	 * @param e
	 *            MouseEvent
	 * @return void
	 */
	public void mouseDragged(MouseEvent e) {
		super.mouseDragged(e);
		Graphics g = getFrame().getBufferedImage().getGraphics();
		draw(e, g);
	}

	/**
	 * ��ͼ
	 * 
	 * @param e
	 *            MouseEvent
	 * @param g
	 *            Graphics
	 * @return void
	 */
	public void draw(MouseEvent e, Graphics g) {
		int x = 0;
		int y = 0;
		// ��ǹ��С
		int size = 8;
		// ��ǹ����
		int count = 10;
		if (getPressX() > 0 && getPressY() > 0
				&& e.getX() < AbstractTool.drawWidth
				&& e.getY() < AbstractTool.drawHeight) {
			g.setColor(AbstractTool.color);
			for (int i = 0; i < count; i++) {
				x = new Random().nextInt(size) + 1;
				y = new Random().nextInt(size) + 1;
				g.fillRect(e.getX() + x, e.getY() + y, 1, 1);
			}

			setPressX(e.getX());
			setPressY(e.getY());
			getFrame().getDrawSpace().repaint();
		}
	}

}
