package org.crazyit.foxmail.mail;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.BodyPart;
import javax.mail.Folder;
import javax.mail.Multipart;
import javax.mail.Store;

import com.sun.xml.internal.messaging.saaj.packaging.mime.internet.MimeUtility;

import foxmail.src.org.crazyit.foxmail.object.Mail;
import foxmail.src.org.crazyit.foxmail.object.MailComparator;
import foxmail.src.org.crazyit.foxmail.ui.MailContext;
import jdk.nashorn.internal.ir.Flags;

/**
 * ��ȡ�ʼ�ʵ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class MailLoaderImpl implements MailLoader {
	
	
	@Override
	public List<Mail> getMessages(MailContext ctx) {
		//�õ�INBOX��Ӧ��Folder
		Folder inbox = getINBOXFolder(ctx);
		try {
			inbox.open(Folder.READ_WRITE);
			//�õ�INBOX���������Ϣ
			Message[] messages = inbox.getMessages();
			//��Message�����װ��Mail����
			List<Mail> result = getMailList(ctx, messages);
			//����ʱ�併������
			sort(result);
			//ɾ��������ȫ�����ʼ�, ��ôÿ��ʹ���ʼ�ϵͳ, ֻ�������յ����ʼ�
			deleteFromServer(messages);
			//ɾ���ʼ����ύɾ��״̬
			inbox.close(true);
			return result;
		} catch (Exception e) {
			throw new LoadMailException(e.getMessage());
		}
	}

	//��javamail�е�Message����ת���ɱ���Ŀ�е�Mail����
	private List<Mail> getMailList(MailContext ctx, Message[] messages) {
		List<Mail> result = new ArrayList<Mail>();
		try {
			//���õ���Message�����װ��Mail����
			for (Message m : messages) {
				//����UUID���ļ���
				String xmlName = UUID.randomUUID().toString() + ".xml"; 
				//�������
				String content = getContent(m, new StringBuffer()).toString();
				//�õ��ʼ��ĸ���ֵ
				Mail mail = new Mail(xmlName, getAllRecipients(m), getSender(m), 
						m.getSubject(), getReceivedDate(m), Mail.getSize(m.getSize()), hasRead(m), 
						content, FileUtil.INBOX);
				//Ϊmail�������ó���
				mail.setCcs(getCC(m));
				//���ø�������
				mail.setFiles(getFiles(ctx, m));
				result.add(mail);
			}
			return result;
		} catch (Exception e) {
			throw new LoadMailException("�õ��ʼ�����Ϣ����: " + e.getMessage());
		}
	}
	
	//�õ����յ�����, ���ȷ��ط�������, ��η�����������
	private Date getReceivedDate(Message m) throws Exception {
		if (m.getSentDate() != null) return m.getSentDate();
		if (m.getReceivedDate() != null) return m.getReceivedDate();
		return new Date();
	}
	

	
	//�õ����͵ĵ�ַ
	private List<String> getCC(Message m) throws Exception {
		Address[] addresses = m.getRecipients(Message.RecipientType.CC);
		return getAddresses(addresses);
	}
	
	//����ʼ��ĸ���
	private List<FileObject> getFiles(MailContext ctx, Message m) throws Exception {
		List<FileObject> files = new ArrayList<FileObject>();
		//�ǻ������, �ͽ��д���
		if (m.isMimeType("multipart/mixed")) {
			Multipart mp = (Multipart)m.getContent();
			//�õ��ʼ����ݵ�Multipart���󲢵õ�������Part������
			int count = mp.getCount();
			for (int i = 1; i < count; i++) {
				Part part = mp.getBodyPart(i);
				//�ڱ��ش����ļ�����ӵ������
				files.add(FileUtil.createFileFromPart(ctx, part));
			}
		}
		return files;
	}
	
	
	//�����ʼ�����
	private StringBuffer getContent(Part part, StringBuffer result) throws Exception {
		if (part.isMimeType("multipart/*")) {
			Multipart p = (Multipart)part.getContent();
			int count = p.getCount();
			//Multipart�ĵ�һ������text/plain, �ڶ�������text/html�ĸ�ʽ, ֻ��Ҫ������һ���ּ���
			if (count > 1) count = 1; 
			for(int i = 0; i < count; i++) {
				BodyPart bp = p.getBodyPart(i);
				//�ݹ����
				getContent(bp, result);
			}
		} else if (part.isMimeType("text/*")) {
			//�����ı���ʽ����html��ʽ, ֱ�ӵõ�����
			result.append(part.getContent());
		}
		return result;
	}	
	
	//�ж�һ���ʼ��Ƿ��Ѷ�, true��ʾ�Ѷ�ȡ, false��ʾû�ж�ȡ
	private boolean hasRead(Message m) throws Exception {
		Flags flags = m.getFlags();
		if (flags.contains(Flags.Flag.SEEN)) return true;
		return false;
	}
	
	//�õ�һ���ʼ��������ռ���
	private List<String> getAllRecipients(Message m) throws Exception {
		Address[] addresses = m.getAllRecipients();
		return getAddresses(addresses);
	}
	
	//���߷���, �������ĵ�ַ�ַ�����װ�ɼ���
	private List<String> getAddresses(Address[] addresses) {
		List<String> result = new ArrayList<String>();
		if (addresses == null) return result;
		for (Address a : addresses) {
			result.add(a.toString());
		}
		return result;
	}
	
	//�õ������˵ĵ�ַ
	private String getSender(Message m) throws Exception  {
		Address[] addresses = m.getFrom();
		return MimeUtility.decodeText(addresses[0].toString());
	}
	
	
	/*
	 * �õ�����INBOX
	 */
	private Folder getINBOXFolder(MailContext ctx) {
		Store store = ctx.getStore();
		try {
			return store.getFolder("INBOX");
		} catch (Exception e) {
			throw new LoadMailException("�������������������");
		}
	}
	
	//���ʼ���������Ϊɾ��״̬
	private void deleteFromServer(Message[] messages) throws Exception {
		for (Message m : messages) {
			m.setFlag(Flags.Flag.DELETED, true);
		}
	}
	
	//����ʱ������
	private void sort(List<Mail> mails) {
		Collections.sort(mails, new MailComparator());
	}

}
