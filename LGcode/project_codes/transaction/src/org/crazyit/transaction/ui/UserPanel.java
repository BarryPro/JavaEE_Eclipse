package org.crazyit.transaction.ui;

import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;

import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.JTextField;

import transaction.src.org.crazyit.transaction.ui.dialog.AddUserDialog;
import transaction.src.org.crazyit.transaction.ui.table.UserTableModel;
import transaction.src.org.crazyit.transaction.util.ViewUtil;

public class UserPanel extends BasePanel {
	
	private JScrollPane tableScrollPane;
	
	//�����б�
	private UserTable dataTable;
	private UserTableModel tableModel;
	
	//��������
	private Box handleBox = Box.createVerticalBox();
	
	//��ѯ
	private Box queryBox = Box.createHorizontalBox();
	private JLabel userNameLabel = new JLabel("�û�����: ");
	private JTextField realName = new JTextField(10);
	private JButton queryButton = new JButton("��ѯ");
	
	//����
	private Box operateBox = Box.createHorizontalBox();
	private JButton newButton = new JButton("�½��û�");
	private JButton deleteButton = new JButton("ɾ���û�");
	
	private AddUserDialog addUserDialog;
	
	public UserPanel() {
		this.addUserDialog = new AddUserDialog(this);
		BoxLayout mainLayout = new BoxLayout(this, BoxLayout.Y_AXIS);
		this.setLayout(mainLayout);
		createTable();
		createQueryBox();
		createOperateBox();
		this.handleBox.add(Box.createVerticalStrut(20));
		this.handleBox.add(this.queryBox);
		this.handleBox.add(Box.createVerticalStrut(20));
		this.handleBox.add(this.operateBox);
		this.handleBox.add(Box.createVerticalStrut(20));
		this.add(this.handleBox);
		this.add(this.tableScrollPane);
		initListeners();
	}
	
	private void initListeners() {
		this.queryButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				query();
			}
		});
		this.newButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				addUser();
			}
		});
		this.deleteButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				deleteUser();
			}
		});
	}
	
	//��ѯ����
	private void query() {
		String realName = this.realName.getText();
		List<User> users = ApplicationContext.userService.query(realName);
		this.tableModel.setDatas(users);
		this.dataTable.updateUI();
	}
	
	//���������û��ĶԻ��򴥷��ķ���
	private void addUser() {
		this.addUserDialog.setVisible(true);
	}
	
	//ɾ���û�
	private void deleteUser() {
		String userId = ViewUtil.getSelectValue(this.dataTable, "id");
		if (userId == null) {
			ViewUtil.showWarn("��ѡ����Ҫ�������û�", this);
			return;
		}
		int result = ViewUtil.showConfirm("�Ƿ�Ҫɾ��?", this);
		if (result == 0) {
			try {
				ApplicationContext.userService.delete(userId);
				this.readData();
			} catch (Exception e) {
				ViewUtil.showWarn(e.getMessage(), this);
			}
		}
	}
	
	//���������б�
	private void createTable() {
		this.tableModel = new UserTableModel();
		this.dataTable = new UserTable(this.tableModel);
		this.dataTable.setPreferredScrollableViewportSize(new Dimension(500, 300));
		this.tableScrollPane = new JScrollPane(this.dataTable);
	}
	
	//������������Box
	private void createOperateBox() {
		this.operateBox.add(this.newButton);
		this.operateBox.add(Box.createHorizontalStrut(30));
		this.operateBox.add(this.deleteButton);
		this.handleBox.add(this.operateBox);
	}
	
	//ʵ�ָ���ĳ��󷽷�, ��ȡ����
	public void readData() {
		List<User> users = ApplicationContext.userService.getUsers();
		this.tableModel.setDatas(users);
		this.dataTable.updateUI();
	}

	//������ѯ����
	private void createQueryBox() {
		this.queryBox.add(Box.createHorizontalStrut(100));
		this.queryBox.add(this.userNameLabel);
		this.queryBox.add(this.realName);
		this.queryBox.add(Box.createHorizontalStrut(20));
		this.queryBox.add(this.queryButton);
		this.queryBox.add(Box.createHorizontalStrut(100));
		this.handleBox.add(this.queryBox);
	}
}
