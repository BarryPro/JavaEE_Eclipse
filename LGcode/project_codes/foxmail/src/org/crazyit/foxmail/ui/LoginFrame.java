package org.crazyit.foxmail.ui;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;

import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;

/**
 * ��¼����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class LoginFrame extends JFrame {

	
	//�û���
	private JLabel userLabel = new JLabel("�û�����");	
	private JTextField userField = new JTextField(20);
	//ȷ����ť
	private JButton confirmButton = new JButton("ȷ��");
	//ȡ����ť
	private JButton cancelButton = new JButton("ȡ��");
	//��ťBox
	private Box buttonBox = Box.createHorizontalBox();
	//�û�Box
	private Box userBox = Box.createHorizontalBox();
	//����Box
	private Box mainBox = Box.createVerticalBox();
	//ϵͳ������
	private MainFrame mainFrame;
	
	public LoginFrame() {
		this.userBox.add(Box.createHorizontalStrut(30));
		this.userBox.add(userLabel);
		this.userBox.add(Box.createHorizontalStrut(20));
		this.userBox.add(userField);
		this.userBox.add(Box.createHorizontalStrut(30));
		
		//��ť��Box
		this.buttonBox.add(Box.createHorizontalStrut(30));
		this.buttonBox.add(this.confirmButton);
		this.buttonBox.add(Box.createHorizontalStrut(20));
		this.buttonBox.add(this.cancelButton);
		this.buttonBox.add(Box.createHorizontalStrut(30));
		
		this.mainBox.add(this.mainBox.createVerticalStrut(20));
		this.mainBox.add(this.userBox);
		this.mainBox.add(this.mainBox.createVerticalStrut(20));
		this.mainBox.add(this.buttonBox);
		this.mainBox.add(this.mainBox.createVerticalStrut(20));
		this.add(mainBox);
		this.setLocation(300, 200);
		this.pack();
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setTitle("�ʼ��շ��ͻ���");
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
				System.exit(0);
			}
		});
	}
	
	private void confirm() {
		String user = this.userField.getText();
		if (user.trim().equals("")) {
			JOptionPane.showConfirmDialog(this, "�������û���", "����", 
					JOptionPane.OK_CANCEL_OPTION);
			return;
		}
		//�õ��û�����Ӧ��Ŀ¼
		File folder = new File(FileUtil.DATE_FOLDER + user);
		//���û���һ�ν���ϵͳ�� ����Ŀ¼
		if (!folder.exists()) {
			folder.mkdir();
		}
		//�õ������ļ�
		File config = new File(folder.getAbsolutePath() + FileUtil.CONFIG_FILE);
		try {
			//û�ж�Ӧ�������ļ����򴴽�
			if (!config.exists()) {
				config.createNewFile();
			}
			//��ȡ���ò�ת��ΪMailContext����
			MailContext ctx = PropertiesUtil.createContext(config);
			//����MailContext��user����
			ctx.setUser(user);
			//����ϵͳ����������
			this.mainFrame = new MainFrame(ctx);
			this.mainFrame.setVisible(true);
			this.setVisible(false);
		} catch (IOException e) {
			e.printStackTrace();
			throw new LoginException("�����ļ�����");
		}
	}
	

	

}
