package org.crazyit.transaction.ui;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.List;

import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JScrollPane;

import transaction.src.org.crazyit.transaction.model.Transaction;
import transaction.src.org.crazyit.transaction.model.TransactionState;
import transaction.src.org.crazyit.transaction.ui.dialog.NewTransactionDialog;
import transaction.src.org.crazyit.transaction.ui.dialog.ViewTransactionDialog;
import transaction.src.org.crazyit.transaction.ui.table.TransactionTable;
import transaction.src.org.crazyit.transaction.ui.table.TransactionTableModel;
import transaction.src.org.crazyit.transaction.util.ViewUtil;

/**
 * ����������
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class TransactionManagePanel extends BasePanel {
	
	private JScrollPane tableScrollPane;
	
	//�����б�
	private TransactionTable dataTable;
	private TransactionTableModel tableModel;
	
	//��������
	private Box handleBox = Box.createVerticalBox();
	
	//��ѯ
	private Box queryBox = Box.createHorizontalBox();
	private JLabel stateLabel = new JLabel("״̬: ");
	private JComboBox stateSelect = new JComboBox();
	private JButton queryButton = new JButton("��ѯ");
	
	//����
	private Box operateBox = Box.createHorizontalBox();
	private JButton newButton = new JButton("�½�����");
	private JButton hurryButton = new JButton("�߰�");
	private JButton invalidButton = new JButton("��Ϊ��Ч");
	
	private NewTransactionDialog newTransactionDialog;
	
	//��¼��ǰ����״̬(����״̬)
	private String currentState = TransactionState.PROCESSING;
	
	//�鿴�������
	private ViewTransactionDialog vtDialog;
	
	public TransactionManagePanel() {
		this.vtDialog = new ViewTransactionDialog();
		this.newTransactionDialog = new NewTransactionDialog(this);
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
	
	//���������б�
	private void createTable() {
		this.tableModel = new TransactionTableModel();
		this.dataTable = new TransactionTable(this.tableModel);
		this.tableScrollPane = new JScrollPane(this.dataTable);
	}
	
	private void initListeners() {
		this.queryButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				query();
			}
		});
		this.newButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				newTransactionDialog.setVisible(true);
			}
		});
		this.hurryButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				hurry();
			}
		});
		this.invalidButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				invalid();
			}
		});
		this.dataTable.addMouseListener(new MouseAdapter() {
			public void mouseClicked(MouseEvent e) {
				if (e.getClickCount() == 2) {
					view();
				}
			}
		});
	}
	
	//�鿴����
	private void view() {
		String id = ViewUtil.getSelectValue(this.dataTable, "id");
		Transaction t = ApplicationContext.transactionService.view(id);
		this.vtDialog.setTransaction(t);
		this.vtDialog.setVisible(true);
	}
	
	//�߰�����
	private void hurry() {
		String id = ViewUtil.getSelectValue(this.dataTable, "id");
		if (id == null) {
			ViewUtil.showWarn("��ѡ����Ҫ�߰������", this);
			return;
		}
		try {
			ApplicationContext.transactionService.hurry(id);
			readData();
		} catch (Exception e) {
			ViewUtil.showWarn(e.getMessage(), this);
		}
	}
	
	//��������Ϊ��Ч
	private void invalid() {
		String id = ViewUtil.getSelectValue(this.dataTable, "id");
		if (id == null) {
			ViewUtil.showWarn("��ѡ����Ҫ����������", this);
			return;
		}
		try {
			ApplicationContext.transactionService.invalid(id);
			readData();
		} catch (Exception e) {
			ViewUtil.showWarn(e.getMessage(), this);
		}
	}
	
	//��ѯ
	private void query() {
		State state = (State)this.stateSelect.getSelectedItem();
		this.currentState = state.getValue();
		readData();
	}
	
	//��������Box
	private void createOperateBox() {
		this.operateBox.add(Box.createHorizontalStrut(220));
		this.operateBox.add(new JLabel("ѡ�����: "));
		this.operateBox.add(Box.createHorizontalStrut(40));
		this.operateBox.add(this.newButton);
		this.operateBox.add(Box.createHorizontalStrut(40));
		this.operateBox.add(this.hurryButton);
		this.operateBox.add(Box.createHorizontalStrut(40));
		this.operateBox.add(this.invalidButton);
		this.operateBox.add(Box.createHorizontalStrut(220));
	}
	
	//�����ݿ��ж�ȡ����
	private List<Transaction> getDatas() {
		User loginUser = ApplicationContext.loginUser;
		List<Transaction> datas = ApplicationContext.transactionService
		.getInitiatorTransaction(loginUser, currentState);
		return datas;
	}
	
	//�����������ȡ����, ʵ�ָ���ĳ��󷽷�
	public void readData() {
		List<Transaction> datas = getDatas();
		this.tableModel.setDatas(datas);
		this.dataTable.updateUI();
	}
	
	//������ѯ����
	private void createQueryBox() {
		this.stateSelect.addItem(State.PROCESS_STATE);
		this.stateSelect.addItem(State.FINISHED_STATE);
		this.stateSelect.addItem(State.FOR_A_WHILE_STATE);
		this.stateSelect.addItem(State.NOT_TO_DO_STATE);
		this.stateSelect.addItem(State.INVALID_STATE);
		this.queryBox.add(Box.createHorizontalStrut(250));
		this.queryBox.add(Box.createHorizontalStrut(20));
		this.queryBox.add(this.stateLabel);
		this.queryBox.add(this.stateSelect);
		this.queryBox.add(Box.createHorizontalStrut(40));
		this.queryBox.add(this.queryButton);
		this.queryBox.add(Box.createHorizontalStrut(250));
	}
}
