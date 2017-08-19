package org.crazyit.foxmail.system.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import foxmail.src.org.crazyit.foxmail.object.Mail;
import foxmail.src.org.crazyit.foxmail.object.MailComparator;
import foxmail.src.org.crazyit.foxmail.system.SystemLoader;
import foxmail.src.org.crazyit.foxmail.ui.MailContext;

/**
 * ����ϵͳ�ʼ�����ʵ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class SystemLoaderImpl implements SystemLoader {

	//ʵ�ֽӿڷ���, �õ���������ʼ�
	public List<Mail> getDeletedBoxMails(MailContext ctx) {
		//�ȴ����û���Ӧ��deletedĿ¼�еõ�ȫ����xml�ļ�
		return getMails(ctx, FileUtil.DELETED);
	}

	//ʵ�ֽӿڷ���, �õ��ݸ�����ʼ�
	public List<Mail> getDraftBoxMails(MailContext ctx) {
		//�ȴ����û���Ӧ��draft�еõ�ȫ����xml�ļ�
		return getMails(ctx, FileUtil.DRAFT);
	}

	@Override
	public List<Mail> getInBoxMails(MailContext ctx) {
		return getMails(ctx, FileUtil.INBOX);
	}
	
	//��xml�ļ�ת����Mail����, ������
	private List<Mail> convert(List<File> xmlFiles, MailContext ctx) {
		List<Mail> result = new ArrayList<Mail>();
		for (File file : xmlFiles) {
			//��xmlת����Mail����
			Mail mail = FileUtil.fromXML(ctx, file);
			result.add(mail);
		}
		sort(result);
		return result;
	}
	
	//����ʱ�併������
	private void sort(List<Mail> mails) {
		Collections.sort(mails, new MailComparator());
	}

	//ʵ�ֽӿڷ���, �õ��������е��ʼ�
	public List<Mail> getOutBoxMails(MailContext ctx) {
		return getMails(ctx, FileUtil.OUTBOX);
	}

	//ʵ�ֽӿڷ���, �õ��ѷ��͵��ʼ�
	public List<Mail> getSentBoxMails(MailContext ctx) {
		return getMails(ctx, FileUtil.SENT);
	}

	private List<Mail> getMails(MailContext ctx, String box) {
		List<File> xmlFiles = FileUtil.getXMLFiles(ctx, box);
		List<Mail> result = convert(xmlFiles, ctx);
		return result;
	}
}
