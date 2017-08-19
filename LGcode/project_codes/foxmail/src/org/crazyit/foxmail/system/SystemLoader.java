package org.crazyit.foxmail.system;

import java.util.List;

import foxmail.src.org.crazyit.foxmail.object.Mail;
import foxmail.src.org.crazyit.foxmail.ui.MailContext;

/**
 * ���ر��ص��ʼ��Ľӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface SystemLoader {

	/**
	 * ����MailContext�õ���Ӧ���ռ����ʼ�(�ڱ���ϵͳ�л�ȡ)
	 * @param ctx
	 * @return
	 */
	List<Mail> getInBoxMails(MailContext ctx);
	
	/**
	 * ����MailContext�õ���Ӧ�ķ������ʼ�(�ڱ���ϵͳ�л�ȡ)
	 * @param ctx
	 * @return
	 */
	List<Mail> getOutBoxMails(MailContext ctx);
	
	/**
	 * ����MailContext�õ���Ӧ���ѷ��͵��ʼ�(�ڱ���ϵͳ�л�ȡ)
	 * @param ctx
	 * @return
	 */
	List<Mail> getSentBoxMails(MailContext ctx);
	
	/**
	 * ����MailContext�õ���Ӧ�Ĳݸ�����ʼ�(�ڱ���ϵͳ�л�ȡ)
	 * @param ctx
	 * @return
	 */
	List<Mail> getDraftBoxMails(MailContext ctx);
	
	/**
	 * ����MailContext�õ���Ӧ����������ʼ�(�ڱ���ϵͳ�л�ȡ)
	 * @param ctx
	 * @return
	 */
	List<Mail> getDeletedBoxMails(MailContext ctx);
}
