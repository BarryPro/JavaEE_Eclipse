package org.crazyit.foxmail.mail;

import java.util.Date;
import java.util.List;

import javax.mail.BodyPart;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.sun.xml.internal.messaging.saaj.packaging.mime.internet.MimeBodyPart;
import com.sun.xml.internal.messaging.saaj.packaging.mime.internet.MimeMultipart;
import com.sun.xml.internal.messaging.saaj.packaging.mime.internet.MimeUtility;

import foxmail.src.org.crazyit.foxmail.exception.SendMailException;
import foxmail.src.org.crazyit.foxmail.object.Mail;
import foxmail.src.org.crazyit.foxmail.ui.MailContext;
import sun.rmi.transport.Transport;

/**
 * �ʼ�����ʵ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class MailSenderImpl implements MailSender {

	@Override
	public Mail send(Mail mail, MailContext ctx) {
		try {
			Session session = ctx.getSession();
			Message mailMessage = new MimeMessage(session);
			//���÷����˵�ַ
			Address from = new InternetAddress(ctx.getUser() + " <" + ctx.getAccount() + ">");
			mailMessage.setFrom(from);
			//���������ռ��˵ĵ�ַ
			Address[] to = getAddress(mail.getReceivers());
			mailMessage.setRecipients(Message.RecipientType.TO, to);
			//���ó����˵�ַ
			Address[] cc = getAddress(mail.getCcs());
			mailMessage.setRecipients(Message.RecipientType.CC, cc);
			//��������
			mailMessage.setSubject(mail.getSubject());
			//��������
			mailMessage.setSentDate(new Date());
			//���������ʼ�������
			Multipart main = new MimeMultipart();
			//���ĵ�body
			BodyPart body = new MimeBodyPart();
			body.setContent(mail.getContent(), "text/html; charset=utf-8");
			main.addBodyPart(body);
			//������
			for (FileObject f : mail.getFiles()) {
				//ÿ��������body
				MimeBodyPart fileBody = new MimeBodyPart();
				fileBody.attachFile(f.getFile());
				//Ϊ�ļ�������ת��
				fileBody.setFileName(MimeUtility.encodeText(f.getSourceName()));
				main.addBodyPart(fileBody);
			}
			//�����ĵ�Multipart��������Message��
			mailMessage.setContent(main);
			Transport.send(mailMessage);
			return mail;
		} catch (Exception e) {
			e.printStackTrace();
			throw new SendMailException("�����ʼ�����, �����������ü��ʼ��������Ϣ");
		}
	}
	//������е��ռ��˵�ַ���߳��͵ĵ�ַ
	private Address[] getAddress(List<String> addList) throws Exception {
		Address[] result = new Address[addList.size()];
		for (int i = 0; i < addList.size(); i++) {
			if (addList.get(i) == null || "".equals(addList.get(i))) {
				continue;
			}
			result[i] = new InternetAddress(addList.get(i));
		}
		return result;
	}
}
