package org.crazyit.flashget.state;

import java.io.Serializable;

import javax.swing.ImageIcon;

/**
 * ���������״̬�ӿ� 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface TaskState extends Serializable {

	/**
	 * ���ظ�״̬�µ�ͼƬ
	 * @return
	 */
	ImageIcon getIcon();
	
	/**
	 * ����״̬���ַ���
	 * @return
	 */
	String getState();
	
	/**
	 * ��״̬��ʼ��ִ�еķ���
	 */
	void init(Resource resource);
	
	/**
	 * ��״̬����ʱִ�еķ���
	 */
	void destory(Resource resouse);
}
