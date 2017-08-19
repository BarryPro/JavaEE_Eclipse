package org.crazyit.transaction.ui.dialog;

import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;

import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

import transaction.src.org.crazyit.transaction.ui.UserPanel;
import transaction.src.org.crazyit.transaction.util.ViewUtil;

/**
 * ����û�����
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class AddUserDialog extends JDialog {

	//�û���
	private JLabel userNameLabel = new JLabel("�û���: ");
	private JTextField userName = new JTextField(10);
	
	//��ʵ����
	private JLabel realNameLabel = new JLabel("��ʵ����: ");
	private JTextField realName = new JTextField(10);
	
	//����
	private JLabel passwordLabel = new JLabel("����: ");
	private JPasswordField password = new JPasswordField(20);
	
	private JLabel roleLabel = new JLabel("��ɫ: ");
	private JComboBox roleSelect = new JComboBox();
	
	//��ť
	private JButton confirmButton = new JButton("ȷ��");
	private JButton cancelButton = new JButton("ȡ��");
	
	private UserPanel userPanel;
	
	public AddUserDialog(UserPanel userPanel) {
		this.userPanel = userPanel;
		//�û���
		Box userNameBox = Box.createHorizontalBox();
		userNameBox.add(Box.createHorizontalStrut(30));
		userNameBox.add(this.userNameLabel);
		userNameBox.add(this.userName);
		userNameBox.add(Box.createHorizontalStrut(30));
		//��ʵ����
		Box realNameBox = Box.createHorizontalBox();
		realNameBox.add(Box.createHorizontalStrut(17));
		realNameBox.add(this.realNameLabel);
		realNameBox.add(this.realName);
		realNameBox.add(Box.createHorizontalStrut(30));
		//����
		Box passwdBox = Box.createHorizontalBox();
		passwdBox.add(Box.createHorizontalStrut(43));
		passwdBox.add(this.passwordLabel);
		passwdBox.add(this.password);
		passwdBox.add(Box.createHorizontalStrut(30));
		//��ɫѡ��
		Box roleSelectBox = Box.createHorizontalBox();
		roleSelectBox.add(Box.createHorizontalStrut(43));
		roleSelectBox.add(this.roleLabel);
		roleSelectBox.add(this.roleSelect);
		roleSelectBox.add(Box.createHorizontalStrut(30));
		//��ť
		Box buttonBox = Box.createHorizontalBox();
		buttonBox.add(this.confirmButton);
		buttonBox.add(Box.createHorizontalStrut(40));
		buttonBox.add(this.cancelButton);
		
		Box mainBox = Box.createVerticalBox();
		mainBox.add(Box.createVerticalStrut(20));
		mainBox.add(userNameBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(realNameBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(passwdBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(roleSelectBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(buttonBox);
		mainBox.add(Box.createVerticalStrut(20));
		this.add(mainBox);	
		this.pack();
		this.setResizable(false);
		this.setTitle("�½��û�");
		Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
		this.setLocation((int)screen.getWidth()/4, (int)screen.getHeight()/5);
		initListeners();
	}
	
	//������ɫ����
	private void createRoleSelect() {
		this.roleSelect.removeAllItems();
		List<Role> roles = ApplicationContext.roleService.getRoles();
		for (Role r : roles) {
			this.roleSelect.addItem(r);
		}
	}
	
	@Override
	public void setVisible(boolean b) {
		super.setVisible(b);
		if (b) createRoleSelect();
	}

	private void initListeners() {
		this.confirmButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				add();
			}
		});
		this.cancelButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				setVisible(false);
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
	
	//����û�
	private void add() {
		if (this.userName.getText().equals("") || this.realName.getText().equals("")
				|| getPassword().equals("")) {
			ViewUtil.showWarn("��������ɵ��û���Ϣ", this);
			return;
		}
		try {
			//����ҵ��ӿ�����û�
			ApplicationContext.userService.addUser(getUser());
			this.setVisible(false);
			this.userPanel.readData();
			clean();
		} catch (Exception e) {
			e.printStackTrace();
			ViewUtil.showWarn(e.getMessage(), this);
		}
	}
	
	//��ս���Ԫ��
	private void clean() {
		this.userName.setText("");
		this.realName.setText("");
		this.password.setText("");
	}
	
	//�ӽ���Ԫ���еõ�����ֵ, ������User����
	private User getUser() {
		String userName = this.userName.getText();
		String realName = this.realName.getText();
		String passwd = getPassword();
		Role role = (Role)this.roleSelect.getSelectedItem();
		User user = new User();
		user.setUSER_NAME(userName);
		user.setREAL_NAME(realName);
		user.setPASS_WD(passwd);
		user.setROLE_ID(role.getID());
		return user;
	}
}
