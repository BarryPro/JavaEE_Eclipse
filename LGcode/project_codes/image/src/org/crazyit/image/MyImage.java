package org.crazyit.image;

import java.awt.image.BufferedImage;

/**
 * ͼƬ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class MyImage extends BufferedImage {
	// �Ƿ��Ѿ�����
	private boolean isSaved = true;

	/**
	 * @param width
	 *            int
	 * @param height
	 *            int
	 * @param type
	 *            int
	 */
	public MyImage(int width, int height, int type) {
		super(width, height, type);
		this.getGraphics().fillRect(0, 0, width, height);
	}

	/**
	 * �����Ƿ񱣴�
	 * 
	 * @param b
	 *            boolean
	 * @return void
	 */
	public void setIsSaved(boolean b) {
		this.isSaved = b;
	}

	/**
	 * �Ƿ��Ѿ�����
	 * 
	 * @return boolean
	 */
	public boolean isSaved() {
		return this.isSaved;
	}
}
