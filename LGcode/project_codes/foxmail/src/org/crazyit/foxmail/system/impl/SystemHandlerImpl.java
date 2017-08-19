package org.crazyit.foxmail.system.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import foxmail.src.org.crazyit.foxmail.object.Mail;
import foxmail.src.org.crazyit.foxmail.system.SystemHandler;
import foxmail.src.org.crazyit.foxmail.ui.MailContext;

/**
 * ����ϵͳ�ʼ�������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class SystemHandlerImpl implements SystemHandler {

	@Override
	public void delete(Mail mail, MailContext ctx) {
		//�ҵ���Ӧ��xml�ļ�
		File file = getMailXmlFile(mail.getXmlName(), ctx);
		//ɾ���ļ�, ����deletedĿ¼�д����µ��ļ�
		file.delete();
		//�����µ�xml�ļ�
		FileUtil.writeToXML(ctx, mail, FileUtil.DELETED);
	}

	@Override
	public void realDelete(Mail mail, MailContext ctx) {
		//�ҵ���Ӧ��xml�ļ�
		File xmlFile = getMailXmlFile(mail.getXmlName(), ctx);
		//�õ����еĸ�����ɾ��
		List<FileObject> files = mail.getFiles();
		//ɾ������
		for (FileObject f : files) f.getFile().delete();
		//ɾ��xml�ļ�
		if (xmlFile.exists()) xmlFile.delete();
	}

	/*
	 * ���ʼ����󱣴浽�ݸ����Ŀ¼��
	 * @see org.crazyit.foxmail.system.SystemHandler#saveDraftBox(org.crazyit.foxmail.object.Mail, org.crazyit.foxmail.ui.MailContext)
	 */
	public void saveDraftBox(Mail mail, MailContext ctx) {
		//����Mail�ĸ���
		saveFiles(mail, ctx);
		FileUtil.writeToXML(ctx, mail, FileUtil.DRAFT);
	}

	@Override
	public void saveInBox(Mail mail, MailContext ctx) {
		FileUtil.writeToXML(ctx, mail, FileUtil.INBOX);
	}

	/*
	 * ����Mail���󵽷�����
	 * @see org.crazyit.foxmail.system.SystemHandler#saveOutBox(org.crazyit.foxmail.object.Mail, org.crazyit.foxmail.ui.MailContext)
	 */
	public void saveOutBox(Mail mail, MailContext ctx) {
		//����Mail�ĸ���
		saveFiles(mail, ctx);
		FileUtil.writeToXML(ctx, mail, FileUtil.OUTBOX);
	}

	/*
	 * ���浽���ͳɹ����ʼ�, ֻ������д�ʼ���ʱ�����, ��˸�Mail�����е����и���, 
	 * ���ڱ���ϵͳ������Ŀ¼��, ��Ҫ����Щ�������浽����Ŀ¼��
	 * @see org.crazyit.foxmail.system.SystemHandler#saveSent(org.crazyit.foxmail.object.Mail, org.crazyit.foxmail.ui.MailContext)
	 */
	public void saveSent(Mail mail, MailContext ctx) {
		saveFiles(mail, ctx);
		//ΪMail��������xml�ļ�
		FileUtil.writeToXML(ctx, mail, FileUtil.SENT);
	}
	
	//����Mail�����еĸ���
	private void saveFiles(Mail mail, MailContext ctx) {
		List<FileObject> files = mail.getFiles();
		List<FileObject> newFiles = new ArrayList<FileObject>();
		int byteSize = mail.getContent().getBytes().length;
		for (FileObject f : files) {
			String sentBoxPath = FileUtil.getBoxPath(ctx, FileUtil.FILE);
			//ʹ��UUID�����µ��ļ���(���ļ�������fileĿ¼��)
			String fileName = UUID.randomUUID().toString();
			//�õ��ļ��ĺ�׺
			String sufix = FileUtil.getFileSufix(f.getFile().getName());
			File targetFile = new File(sentBoxPath + fileName + sufix);
			//���Ƶ�fileĿ¼��
			FileUtil.copy(f.getFile(), targetFile);
			//����Mail�����и������ϵ��ļ�����Ϊ�µ��ļ�����(��fileĿ¼��)
			newFiles.add(new FileObject(f.getSourceName(), targetFile));
			byteSize += targetFile.length();
		}
		mail.setSize(Mail.getSize(byteSize));
		mail.setFiles(newFiles);
	}

	@Override
	public void saveMail(Mail mail, MailContext ctx) {
		//��ҪѰ�Ҹ�Mail��������Ӧ��xml�ļ�������idȥ���ļ�
		File xmlFile = getMailXmlFile(mail.getXmlName(), ctx);
		FileUtil.writeToXML(xmlFile, mail);
	}
	
	@Override
	public void revert(Mail mail, MailContext ctx) {
		//�ҵ���Ӧ��xml�ļ�
		File xmlFile = getMailXmlFile(mail.getXmlName(), ctx);
		//ɾ�����ļ�, �ٻ�ԭ��ԭ����Ŀ¼��
		xmlFile.delete();
		FileUtil.writeToXML(ctx, mail, mail.getFrom());
	}

	//�����е��ʼ��в�������ΪxmlName��xml�ļ�
	private File getMailXmlFile(String xmlName, MailContext ctx) {
		List<File> allXMLFiles = getAllFiles(ctx);
		for (File f : allXMLFiles) {
			if (f.getName().equals(xmlName)) return f;
		}
		return null;
	}

	//�õ�ȫ�����ʼ����ռ��䡢�����䡢�ݸ��䡢�����䡢�ѷ��ͣ���xml�ļ�����
	private List<File> getAllFiles(MailContext ctx) {
		List<File> inboxXmls = FileUtil.getXMLFiles(ctx, FileUtil.INBOX);
		List<File> outboxXmls = FileUtil.getXMLFiles(ctx, FileUtil.OUTBOX);
		List<File> draftXmls = FileUtil.getXMLFiles(ctx, FileUtil.DRAFT);
		List<File> sentXmls = FileUtil.getXMLFiles(ctx, FileUtil.SENT);
		List<File> deletedXmls = FileUtil.getXMLFiles(ctx, FileUtil.DELETED);
		List<File> result = new ArrayList<File>();
		result.addAll(inboxXmls);
		result.addAll(outboxXmls);
		result.addAll(draftXmls);
		result.addAll(sentXmls);
		result.addAll(deletedXmls);
		return result;
	}
}
