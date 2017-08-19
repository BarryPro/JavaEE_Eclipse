package org.crazyit.image.tool;

import java.awt.Graphics;

/**
 * ��Բ�ι���
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class RoundTool extends AbstractTool {
	private static Tool tool = null;

	private RoundTool(ImageFrame frame) {
		super(frame);
	}

	public static Tool getInstance(ImageFrame frame) {
		if (tool == null) {
			tool = new RoundTool(frame);
		}
		return tool;
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
		int x = x2 > x1 ? x1 : x2;
		int y = y2 > y1 ? y1 : y2;
		// ����Բ
		g.drawOval(x, y, Math.abs(x1 - x2), Math.abs(y1 - y2));
	}
}
