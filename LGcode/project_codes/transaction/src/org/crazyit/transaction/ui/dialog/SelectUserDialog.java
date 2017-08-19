package org.crazyit.transaction.ui.dialog;

import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;

import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.JTextField;

import transaction.src.org.crazyit.transaction.ui.handler.UserSelectHandler;
import transaction.src.org.crazyit.transaction.ui.table.UserTableModel;
import transaction.src.org.crazyit.transaction.util.ViewUtil;

/**
 * �û�ѡ��Ի���
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class SelectUserDialog extends JDialog {

	private JScrollPane tableScrollPane;
	//�û���ѯ
	private JLabel realNameLabel = new JLabel("��ʵ����: ");
	private JTextField realName = new JTextField(10);
	private JButton queryButton = new JButton("��ѯ");
	
	//�û��б�
	private UserTable userTable;
	private UserTableModel tableModel;
	
	//��ť
	private JButton confirmButton = new JButton("ȷ��");
	private JButton cancelButton = new JButton("ȡ��");
	
	//�û�ѡ������
	private UserSelectHandler selectHandler;
	
	public SelectUserDialog(UserSelectHandler selectHandler) {
		this.selectHandler = selectHandler;
		Box queryBox = Box.createHorizontalBox();
		queryBox.add(Box.createHorizontalStrut(130));
		queryBox.add(this.realNameLabel);
		queryBox.add(this.realName);
		queryBox.add(Box.createHorizontalStrut(30));
		queryBox.add(this.queryButton);
		queryBox.add(Box.createHorizontalStrut(130));
		createTable();
		Box buttonBox = Box.createHorizontalBox();
		buttonBox.add(this.confirmButton);
		buttonBox.add(Box.createHorizontalStrut(50));
		buttonBox.add(this.cancelButton);
		
		Box mainBox = Box.createVerticalBox();
		mainBox.add(Box.createVerticalStrut(20));
		mainBox.add(queryBox);
		mainBox.add(Box.createVerticalStrut(20));
		mainBox.add(this.tableScrollPane);
		mainBox.add(Box.createVerticalStrut(20));
		mainBox.add(buttonBox);
		mainBox.add(Box.createVerticalStrut(20));
		this.add(mainBox);
		this.pack();
		this.setResizable(false);
		this.setTitle("ѡ���û�");
		Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
		this.setLocation((int)screen.getWidth()/4, (int)screen.getHeight()/5);
		initListeners();
	}
	
	//��ʼ����ť������
	private void initListeners() {
		this.queryButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				query();
			}
		});
		this.confirmButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				confirm();
			}
		});
		this.cancelButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				setVisible(false);
			}
		});
	}
	
	
	@Override
	public void setVisible(boolean b) {
		super.setVisible(b);
		if (!b) return;
		//�����ݿ��в�ѯȫ�����û�
		List<User> users = ApplicationContext.userService.getUsers();
		refreshDate(users);
	}

	//��ѯ����
	private void query() {
		String realName = this.realName.getText();
		//�����û�ҵ��ӿڽ����û�ģ����ѯ
		List<User> users = ApplicationContext.userService.query(realName);
		refreshDate(users);
	}
	
	//���ȷ��ִ�еķ���
	private void confirm() {
		String id = ViewUtil.getSelectValue(this.userTable, "id");
		if (id == null) {
			ViewUtil.showWarn("��ѡ��һ���û�", this);
			return;
		}
		//�õ���ʵ����
		String realName = ViewUtil.getSelectValue(this.userTable, UserTableModel.REAL_NAME);
		//�����û�ѡ������ķ���
		this.selectHandler.confirm(id, realName);
		this.setVisible(false);
	}
	
	//���߷���, ����ˢ���б�
	private void refreshDate(List<User> users) {
		this.tableModel.setDatas(users);
		this.userTable.updateUI();
	}

	//���������б�
	private void createTable() {
		this.tableModel = new UserTableModel();
		this.userTable = new UserTable(this.tableModel);
		this.userTable.setPreferredScrollableViewportSize(new Dimension(500, 280)); 
		this.tableScrollPane = new JScrollPane(this.userTable);
	}
}
