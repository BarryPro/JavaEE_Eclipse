package org.crazyit.foxmail.mail;

import java.util.List;

import foxmail.src.org.crazyit.foxmail.object.Mail;
import foxmail.src.org.crazyit.foxmail.ui.MailContext;

/**
 * ��ȡ�ʼ���Ϣ�Ľӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface MailLoader {
	
	/**
	 * �õ�INBOX�������ʼ�
	 * @param ctx �����������
	 * @return
	 */
	List<Mail> getMessages(MailContext ctx);
	
}
