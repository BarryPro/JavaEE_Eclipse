package org.crazyit.book.ui;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

/**
 * ��¼��JFrame
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class LoginFrame extends JFrame {
	
	//����"�ʺ�"��"����"�ı�ǩ
	private JLabel acc = new JLabel("�ʺ� ");
	private JLabel pass = new JLabel("���� ");
	
	//�������û��ʺź�������ı���
	private JTextField accText = new JTextField();
	private JPasswordField passText = new JPasswordField();

	//�����¼�����Box�������Ա�ʹ��BoxLayout������
	private Box up = Box.createHorizontalBox();
	private Box center = Box.createHorizontalBox();
	private Box upCenter = Box.createVerticalBox();
	private Box down = Box.createHorizontalBox();
	
	UserService userService;
    
	//�����¼��ť
	private JButton login = new JButton("��¼");
	
	public LoginFrame(UserService userService)
	{
		this.userService = userService;
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		//���ָ������������ø�������ˮƽ�ʹ�ֱ���
		up.add(Box.createHorizontalStrut(50));
		up.add(acc);
		up.add(Box.createHorizontalStrut(10));
		up.add(accText);
		up.add(Box.createHorizontalStrut(100));
				
		center.add(Box.createHorizontalStrut(50));
		center.add(pass);
		center.add(Box.createHorizontalStrut(10));
		center.add(passText);
		center.add(Box.createHorizontalStrut(100));

		upCenter.add(Box.createVerticalStrut(20));
		upCenter.add(up);
		upCenter.add(Box.createVerticalStrut(20));
		upCenter.add(center);
		upCenter.add(Box.createVerticalStrut(20));

		down.add(Box.createHorizontalStrut(270));
		down.add(login, BorderLayout.EAST);
		down.add(Box.createHorizontalStrut(30));
		down.add(Box.createVerticalStrut(50));

		this.add(upCenter, BorderLayout.CENTER);
		this.add(down, BorderLayout.SOUTH);
		this.setBounds(300, 250, 350, 200);
		this.pack();
		this.setVisible(true);
		initListeners();
	}
	
	public void initListeners() {
		this.login.addActionListener(new ActionListener(){

			public void actionPerformed(ActionEvent e) {
				login();
			}
			
		});
	}
	
	public void login() {
		String name = this.accText.getText().trim();
		char[] passes = this.passText.getPassword();
		StringBuffer password = new StringBuffer();
		for (char c : passes) {
			password.append(c);
		}
		try {
			userService.login(name, password.toString());
			new MainFrame();
			this.setVisible(false);
		} catch (Exception e) {
			showWarn(e.getMessage());
		}
		
	}
	
	
	
	//��ʾ����
	protected int showWarn(String message) {
		return JOptionPane.showConfirmDialog(this, message, "����", 
				JOptionPane.OK_CANCEL_OPTION);
	}
}
