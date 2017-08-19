package org.crazyit.foxmail.mail;

import foxmail.src.org.crazyit.foxmail.object.Mail;
import foxmail.src.org.crazyit.foxmail.ui.MailContext;

/**
 * �����ʼ��ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface MailSender {

	/**
	 * ����һ���ʼ������ظ��ʼ�����
	 * @param mail
	 * @param ctx
	 * @return
	 */
	Mail send(Mail mail, MailContext ctx);
}
