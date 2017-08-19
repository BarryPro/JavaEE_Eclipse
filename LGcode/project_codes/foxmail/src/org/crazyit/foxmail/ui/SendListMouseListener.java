package org.crazyit.foxmail.ui;

import javax.swing.JOptionPane;

/**
 * д�ʼ�ʱ�ĸ����б������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class SendListMouseListener extends MainListMouseListener {

	@Override
	public void handle(FileObject file) {
		int result = JOptionPane.showOptionDialog(null, "��ѡ�����", "ѡ��",
				0, JOptionPane.QUESTION_MESSAGE, null, 
				new Object[]{"��", "ȡ��"}, null);
		if (result == 0) {
			//�򿪲���
			openFile(file);
		}
	}

}
