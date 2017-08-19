package org.crazyit.foxmail.ui;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

import foxmail.src.org.crazyit.foxmail.exception.ValidateException;

/**
 * �������ý���
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class SetupFrame extends JFrame {

	//�ʺŵ�JLabel
	private JLabel accountLabel = new JLabel("�����ַ��");
	//����Jabel
	private JLabel passwordLabel = new JLabel("�������룺");
	//�ʼ���ַ�����
	private JTextField accountField = new JTextField(20);
	//���������
	private JPasswordField passwordField = new JPasswordField(20);
	//ȷ����ť
	private JButton confirmButton = new JButton("ȷ��");
	//ȡ����ť
	private JButton cancelButton = new JButton("ȡ��");
	//�����ʺ�Box
	private Box accountBox = Box.createHorizontalBox();
	//�����Box
	private Box passwordBox = Box.createHorizontalBox();
	//�����ʼ���������Box
	private Box smtpBox = Box.createHorizontalBox();
	//�����ʼ���������Box
	private Box pop3Box = Box.createHorizontalBox();
	//��ťBox
	private Box buttonBox = Box.createHorizontalBox();
	//���뵽JFrame��Box
	private Box main = Box.createVerticalBox();
	//�ʼ�ϵͳ������
	private MainFrame mainFrame;
	//�����ʼ�������(SMTP)
	private JLabel smtpLabel = new JLabel("�����ʼ���������SMTP����");
	private JTextField smtpField = new JTextField(10);
	private JLabel smtpPortLabel = new JLabel("�˿ڣ�");
	private JTextField smtpPortField = new JTextField(5);
	//�����ʼ���������POP3��
	private JLabel pop3Label = new JLabel("�����ʼ���������POP3����");
	private JTextField pop3Field = new JTextField(10);
	private JLabel pop3PortLabel = new JLabel("�˿ڣ�");
	private JTextField pop3PortField = new JTextField(5);
	
	public SetupFrame(MainFrame mainFrame) {
		this.mainFrame = mainFrame;
		//��ʼ���������
		initFrame(this.mainFrame.getMailContext());
		//��ʼ��������
		initListener();
	}
	
	//��ʼ��������
	private void initListener() {
		this.confirmButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				confirm();
			}
		});
		this.cancelButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				hideFrame();
			}
		});
	}
	
	/*
	 * ����
	 */
	private void hideFrame() {
		this.setVisible(false);
	}
	
	/*
	 * ���������ַ���
	 */
	private String getPassword() {
		char[] passes = this.passwordField.getPassword();
		StringBuffer password = new StringBuffer();
		for (char c : passes) {
			password.append(c);
		}
		return password.toString();
	}
	
	//ȷ����ť
	private void confirm() {
		try {
			//��������ϵͳ�����ĵ���Ϣ
			MailContext ctx = getMailContext(this.mainFrame.getMailContext());
			//�����Ѿ�����Ϣ�����������趨
			ctx.setReset(true);
			//���µ�������д�������ļ���
			PropertiesUtil.store(ctx);
			//�����������MailContext����
			this.mainFrame.setMailContext(ctx);
			//��������ʼ���Ŀ¼(�����û���Ŀ¼, һ���û������ж�������ַ)
			FileUtil.createFolder(ctx);
			this.setVisible(false);
		} catch (Exception e) {
			JOptionPane.showConfirmDialog(this, e.getMessage(), "����", 
					JOptionPane.OK_CANCEL_OPTION);
			return;
		}
	}
	
	/*
	 * ���ݽ����ֵ��װMailContext
	 */
	private MailContext getMailContext(MailContext ctx) {
		String account = this.accountField.getText();
		String password = getPassword();
		String smtpHost = this.smtpField.getText();
		String smtpPortStr = this.smtpPortField.getText();
		String pop3Host = this.pop3Field.getText();
		String pop3PortStr = this.pop3PortField.getText();
		String[] values = new String[]{account, password, smtpHost, smtpPortStr, 
				pop3Host, pop3Host, pop3PortStr};
		//��֤��������
		validateRequire(values);
		//��֤�˿�����
		validateLegal(new String[]{smtpPortStr, pop3PortStr});
		Integer smtpPort = Integer.valueOf(smtpPortStr);
		Integer pop3Port = Integer.valueOf(pop3PortStr);
		ctx.setAccount(account);
		ctx.setPassword(password);
		ctx.setSmtpHost(smtpHost);
		ctx.setSmtpPort(smtpPort);
		ctx.setPop3Host(pop3Host);
		ctx.setPop3Port(pop3Port);
		//��������������������Ϣ, �������MailContext��resetֵΪtrue
		ctx.setReset(true);
		return ctx;
	}
	
	
	/*
	 * ��֤�����Ƿ�Ϸ�
	 */
	private void validateLegal(String[] values) {
		try {
			for (String s : values) {
				Integer.valueOf(s);
			}
		} catch (NumberFormatException e) {
			throw new ValidateException("��������ȷ������");
		}
	}
	
	/*
	 * ��֤��������
	 */
	private void validateRequire(String[] values) {
		for (String s :values) {
			if (s.trim().equals("")) {
				throw new ValidateException("��������������Ϣ");
			}
		}
	}
	
	
	//��ʼ��JFrame
	private void initFrame(MailContext ctx) {
		//�����ʺŵ�Box
		this.accountBox.add(Box.createHorizontalStrut(30));
		this.accountBox.add(this.accountLabel);
		this.accountBox.add(Box.createHorizontalStrut(13));
		this.accountBox.add(this.accountField);
		this.accountBox.add(Box.createHorizontalStrut(30));
		//���������Box
		this.passwordBox.add(Box.createHorizontalStrut(30));
		this.passwordBox.add(this.passwordLabel);
		this.passwordBox.add(Box.createHorizontalStrut(13));
		this.passwordBox.add(this.passwordField);
		this.passwordBox.add(Box.createHorizontalStrut(30));
		//�����ʼ���������Box
		this.smtpBox.add(Box.createHorizontalStrut(30));
		this.smtpBox.add(this.smtpLabel);
		this.smtpBox.add(this.smtpField);
		this.smtpBox.add(Box.createHorizontalStrut(5));
		this.smtpBox.add(this.smtpPortLabel);
		this.smtpBox.add(this.smtpPortField);
		this.smtpBox.add(Box.createHorizontalStrut(30));
		//�����ʼ���������Box
		this.pop3Box.add(Box.createHorizontalStrut(31));
		this.pop3Box.add(this.pop3Label);
		this.pop3Box.add(this.pop3Field);
		this.pop3Box.add(Box.createHorizontalStrut(5));
		this.pop3Box.add(this.pop3PortLabel);
		this.pop3Box.add(this.pop3PortField);
		this.pop3Box.add(Box.createHorizontalStrut(30));
		//��ť��Box
		this.buttonBox.add(Box.createHorizontalStrut(30));
		this.buttonBox.add(this.confirmButton);
		this.buttonBox.add(Box.createHorizontalStrut(20));
		this.buttonBox.add(this.cancelButton);
		this.buttonBox.add(Box.createHorizontalStrut(30));
		//������JFrame�е�Box
		this.main.add(Box.createVerticalStrut(20));
		this.main.add(this.accountBox);
		this.main.add(Box.createVerticalStrut(10));
		this.main.add(this.passwordBox);
		this.main.add(Box.createVerticalStrut(10));
		this.main.add(this.smtpBox);
		this.main.add(Box.createVerticalStrut(10));
		this.main.add(this.pop3Box);
		this.main.add(Box.createVerticalStrut(10));
		this.main.add(this.buttonBox);
		this.main.add(Box.createVerticalStrut(20));
		//��ʼ����������
		this.accountField.setText(ctx.getAccount());
		this.passwordField.setText(ctx.getPassword());
		this.smtpField.setText(ctx.getSmtpHost());
		this.pop3Field.setText(ctx.getPop3Host());
		this.smtpPortField.setText(String.valueOf(ctx.getSmtpPort()));
		this.pop3PortField.setText(String.valueOf(ctx.getPop3Port()));
		//����JFrame�ĸ�������
		this.setTitle("�ʼ��շ��ͻ���");
		this.setLocation(300, 200); 
		this.setResizable(false);
		this.add(this.main);
		this.pack();
	}
	
	
}
