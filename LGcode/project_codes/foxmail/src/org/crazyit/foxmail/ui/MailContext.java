package org.crazyit.foxmail.ui;

import java.net.PasswordAuthentication;
import java.util.Properties;

import javax.mail.Session;
import javax.mail.Store;
import javax.mail.URLName;

import foxmail.src.org.crazyit.foxmail.exception.MailConnectionException;

/**
 * ����������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class MailContext {
	//ϵͳ�û�
	private String user;
	//�û��ʺ�
	private String account;
	//����
	private String password;
	//smtp�ʼ�������
	private String smtpHost;
	//smtp�˿�
	private int smtpPort;
	//pop3�ʼ�������
	private String pop3Host;
	//pop3�Ķ˿�
	private int pop3Port;
	//�Ƿ����������Ϣ
	private boolean reset = false;
	
	public MailContext(String user, String account, String password, String smtpHost,
			int smtpPort, String pop3Host, int pop3Port) {
		super();
		this.user = user;
		this.account = account;
		this.password = password;
		this.smtpHost = smtpHost;
		this.smtpPort = smtpPort;
		this.pop3Host = pop3Host;
		this.pop3Port = pop3Port;
	}
	
	public String getUser() {
		return user;
	}
	
	public void setUser(String user) {
		this.user = user;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSmtpHost() {
		return smtpHost;
	}

	public void setSmtpHost(String smtpHost) {
		this.smtpHost = smtpHost;
	}

	public int getSmtpPort() {
		return smtpPort;
	}

	public void setSmtpPort(int smtpPort) {
		this.smtpPort = smtpPort;
	}

	public String getPop3Host() {
		return pop3Host;
	}

	public void setPop3Host(String pop3Host) {
		this.pop3Host = pop3Host;
	}

	public int getPop3Port() {
		return pop3Port;
	}

	public void setPop3Port(int pop3Port) {
		this.pop3Port = pop3Port;
	}

	private Store store;
	
	public Store getStore() {
		//��������Ϣ, ����sessionΪnull
		if (this.reset) {
			this.store = null;
			this.session = null;
			this.reset = false;
		}
		if (this.store == null || !this.store.isConnected()) {
			try {
				Properties props = System.getProperties();
				if (isGmail()) {
					props.setProperty("mail.pop3.socketFactory.class", SSL_FACTORY);
				}
				//����mail��Session
				Session session = Session.getDefaultInstance(props, getAuthenticator());
				//ʹ��pop3Э������ʼ�
				URLName url = new URLName("pop3", getPop3Host(), getPop3Port(), null,   
						getAccount(), getPassword());
				//�õ�����Ĵ洢����
				Store store = session.getStore(url);
				store.connect();
				this.store = store;
			} catch (Exception e) {
				e.printStackTrace();
				throw new MailConnectionException("���������쳣����������");
			}
		}
		return this.store;
	}
	
	private Session session;
	
	private final static String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
	
	public Session getSession() {
		//��������Ϣ, ����sessionΪnull
		if (this.reset) {
			this.session = null;
			this.store = null;
			this.reset = false;
		}
		if (this.session == null) {
			Properties props = System.getProperties();
			if (isGmail()) {
				props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
			}
			System.out.println(this.getSmtpPort());
			props.put("mail.smtp.host", this.getSmtpHost());  
			props.put("mail.smtp.port", this.getSmtpPort());
			props.put("mail.smtp.auth", true);
			Session sendMailSession = Session.getDefaultInstance(props, getAuthenticator());
			this.session = sendMailSession;
		}
		return this.session;
	}
	
	private boolean isGmail() {
		if (this.account == null || this.account.trim().equals("")) return false;
		if (this.account.lastIndexOf("@gmail.com") != -1) {
			return true;
		}
		return false;
	}
	
	private Authenticator getAuthenticator() {
		return new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(getAccount(), getPassword());
			}
		};
	}

	public boolean isReset() {
		return reset;
	}

	public void setReset(boolean reset) {
		this.reset = reset;
	}
	
}
