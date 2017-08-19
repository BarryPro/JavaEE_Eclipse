package org.crazyit.foxmail.system;

import foxmail.src.org.crazyit.foxmail.object.Mail;
import foxmail.src.org.crazyit.foxmail.ui.MailContext;

/**
 * �ڱ���ϵͳ�д����ʼ��Ľӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface SystemHandler {

	/**
	 * ɾ��һ���ʼ�(�ŵ�����վ)
	 * @param mail
	 * @param ctx ���������ĵõ���ص�Ŀ¼
	 */
	void delete(Mail mail, MailContext ctx);
	
	/**
	 * ���ʼ��������ѷ���
	 * @param mail
	 * @param ctx ���������ĵõ���ص�Ŀ¼
	 */
	void saveSent(Mail mail, MailContext ctx);
	
	/**
	 * ���ʼ�������������
	 * @param mail
	 * @param ctx ���������ĵõ���ص�Ŀ¼
	 */
	void saveOutBox(Mail mail, MailContext ctx);
	
	/**
	 * �������ݸ���
	 * @param mail
	 * @param ctx ���������ĵõ���ص�Ŀ¼
	 */
	void saveDraftBox(Mail mail, MailContext ctx);
	
	/**
	 * ����ɾ���ʼ�
	 * @param mail
	 * @param ctx ���������ĵõ���ص�Ŀ¼
	 */
	void realDelete(Mail mail, MailContext ctx);
	
	/**
	 * �����InBoxĿ¼
	 * @param mail
	 * @param ctx
	 */
	void saveInBox(Mail mail, MailContext ctx);
	
	/**
	 * ����һ���ʼ������ʼ��Ѿ������ڱ��ص�Ŀ¼��
	 * @param mail
	 * @param ctx
	 */
	void saveMail(Mail mail, MailContext ctx);
	
	/**
	 * �����������е��ʼ���ԭ
	 * @param mail
	 * @param ctx
	 */
	void revert(Mail mail, MailContext ctx);
}
