package org.crazyit.image.tool;

import java.awt.AWTException;
import java.awt.Color;
import java.awt.Robot;
import java.awt.event.MouseEvent;

/**
 * ʰɫ��
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class ColorPickedTool extends AbstractTool {
	private static Tool tool = null;

	private ColorPickedTool(ImageFrame frame) {
		super(frame, "img/colorcursor.gif");
	}

	public static Tool getInstance(ImageFrame frame) {
		if (tool == null) {
			tool = new ColorPickedTool(frame);
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
		if (e.getX() > 0 && e.getY() > 0) {
			if (e.getX() < AbstractTool.drawWidth
					&& e.getY() < AbstractTool.drawHeight) {
				setPressX(e.getX());
				setPressY(e.getY());
				/**
				 * ������ɫ getRGB()����Ĭ�� sRGB ColorModel �б�ʾ��ɫ�� RGB ֵ 24-31 λ��ʾ
				 * alpha��16-23 λ��ʾ��ɫ�� 8-15 λ��ʾ��ɫ��0-7 λ��ʾ��ɫ
				 */
				int rgb = getFrame().getBufferedImage().getRGB(e.getX(),
						e.getY());
				// ǰ8λ
				int int8 = (int) Math.pow(2, 8);
				// ǰ16λ
				int int16 = (int) Math.pow(2, 16);
				// ǰ24λ
				int int24 = (int) Math.pow(2, 24);
				// �ֱ�ȡ0-7λ,8-15λ,16-23λ
				int r = (rgb & (int24 - int16)) >> 16;
				int g = (rgb & (int16 - int8)) >> 8;
				int b = (rgb & (int8 - 1));
				// ������ɫ
				AbstractTool.color = new Color(r, g, b);
			} else {
				try {
					AbstractTool.color = new Robot().getPixelColor(e.getX(), e
							.getY());
				} catch (AWTException ae) {
					ae.printStackTrace();
				}
			}
			// ����Ŀǰ��ʾ����ɫ
			getFrame().getCurrentColorPanel().setBackground(AbstractTool.color);
		}
	}
}
