package org.crazyit.ball;

import java.io.IOException;

/**
 * ש����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class Brick extends BallComponent {

	// �������
	private Magic magic = null;
	// ����һ��boolean�������ñ����Ƿ���Ч
	private boolean disable = false;
	public static final int MAGIC_LONG_TYPE = 1;
	public static final int MAGIC_SHORT_TYPE = 2;

	/**
	 * ������
	 * 
	 * @return void
	 */
	public Brick(String path, int type, int x, int y) throws IOException {
		super(path);
		if (type == Brick.MAGIC_LONG_TYPE) {
			this.magic = new LongMagic("img/long.gif", x, y);
		} else if (type == Brick.MAGIC_SHORT_TYPE) {
			this.magic = new ShortMagic("img/short.gif", x, y);
		}
		if (this.magic != null) {
			this.magic.setX(x);
			this.magic.setY(y);
		}
	}

	/**
	 * ���ñ�����û��Ч
	 * 
	 * @param disable
	 *            boolean
	 * @return void
	 */
	public void setDisable(boolean disable) {
		this.disable = disable;
	}

	/**
	 * �鿴������û��Ч
	 * 
	 * @return boolean �Ƿ���Ч
	 */
	public boolean isDisable() {
		return this.disable;
	}

	/**
	 * ��ȡ����
	 * 
	 * @return String magic
	 */
	public Magic getMagic() {
		return this.magic;
	}

	/**
	 * ���õ���
	 * 
	 * @return String magic
	 */
	public void setMagic(Magic magic) {
		this.magic = magic;
	}
}
