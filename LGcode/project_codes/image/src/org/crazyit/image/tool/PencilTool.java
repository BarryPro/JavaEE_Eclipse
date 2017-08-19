package org.crazyit.image.tool;

import java.awt.Graphics;
import java.awt.event.MouseEvent;

/**
 * Ǧ�ʹ���
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class PencilTool extends AbstractTool {
	private static Tool tool = null;

	private PencilTool(ImageFrame frame) {
		super(frame, "img/pencilcursor.gif");
	}

	public static Tool getInstance(ImageFrame frame) {
		if (tool == null) {
			tool = new PencilTool(frame);
		}
		return tool;
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
		// ��ȡͼƬ��Graphics����
		Graphics g = getFrame().getBufferedImage().getGraphics();
		if (getPressX() > 0 && getPressY() > 0) {
			g.setColor(AbstractTool.color);
			g.drawLine(getPressX(), getPressY(), e.getX(), e.getY());
			setPressX(e.getX());
			setPressY(e.getY());
			getFrame().getDrawSpace().repaint();
		}
	}
}
