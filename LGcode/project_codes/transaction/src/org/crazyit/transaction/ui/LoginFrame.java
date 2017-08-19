package org.crazyit.transaction.ui;

import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

import transaction.src.org.crazyit.transaction.util.ViewUtil;

public class LoginFrame extends JFrame {

	//�û���
	private JLabel userNameLabel = new JLabel("�û���: ");
	private JTextField userName = new JTextField(20);
	//����
	private JLabel passwordLabel = new JLabel("����: ");
	private JPasswordField password = new JPasswordField(20);
	//��ť
	private JButton confirmButton = new JButton("ȷ��");
	private JButton cancelButton = new JButton("ȡ��");
	
	public LoginFrame() {
		//�û���
		Box userNameBox = Box.createHorizontalBox();
		userNameBox.add(Box.createHorizontalStrut(50));
		userNameBox.add(this.userNameLabel);
		userNameBox.add(this.userName);
		userNameBox.add(Box.createHorizontalStrut(50));
		//����
		Box passwordBox = Box.createHorizontalBox();
		passwordBox.add(Box.createHorizontalStrut(50));
		passwordBox.add(this.passwordLabel);
		passwordBox.add(Box.createHorizontalStrut(13));
		passwordBox.add(this.password);
		passwordBox.add(Box.createHorizontalStrut(50));
		//��ť
		Box buttonBox = Box.createHorizontalBox();
		buttonBox.add(this.confirmButton);
		buttonBox.add(Box.createHorizontalStrut(40));
		buttonBox.add(this.cancelButton);
		//��Box
		Box mainBox = Box.createVerticalBox();
		mainBox.add(Box.createVerticalStrut(30));
		mainBox.add(userNameBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(passwordBox);
		mainBox.add(Box.createVerticalStrut(20));
		mainBox.add(buttonBox);
		mainBox.add(Box.createVerticalStrut(20));
		//�����Ļ��С
		Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
		this.add(mainBox);
		this.setLocation((int)screen.getWidth()/3, (int)screen.getHeight()/3);
		this.pack();
		this.setTitle("��¼�������ϵͳ");
		this.setVisible(true);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		initListeners();
	}
	
	//��ʼ��������
	private void initListeners() {
		this.confirmButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				login();
			}
		});
		this.cancelButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				System.exit(0);
			}
		});
	}
	
	//���������ַ���
	private String getPassword() {
		char[] passes = this.password.getPassword();
		StringBuffer password = new StringBuffer();
		for (char c : passes) {
			password.append(c);
		}
		return password.toString();
	}
	
	//���ȷ����ť�����ķ���
	private void login() {
		//�õ��û���
		String userName = this.userName.getText();
		//�õ�����
		String passwd = getPassword();
		//���е�¼
		try {
			ApplicationContext.userService.login(userName, passwd);
			this.setVisible(false);
			MainFrame mf = new MainFrame();
		} catch (Exception e) {
			e.printStackTrace();
			ViewUtil.showWarn(e.getMessage(), this);
		}
	}
	

}
