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
import transaction.src.org.crazyit.transaction.ui.dialog.HandleTransactionDialog;
import transaction.src.org.crazyit.transaction.ui.dialog.TransferTransactionDialog;
import transaction.src.org.crazyit.transaction.ui.dialog.ViewTransactionDialog;
import transaction.src.org.crazyit.transaction.ui.handler.TransactionHandler;
import transaction.src.org.crazyit.transaction.ui.handler.impl.FinishHandler;
import transaction.src.org.crazyit.transaction.ui.handler.impl.ForAWhileHandler;
import transaction.src.org.crazyit.transaction.ui.handler.impl.NotToDoHandler;
import transaction.src.org.crazyit.transaction.ui.table.TransactionTable;
import transaction.src.org.crazyit.transaction.ui.table.TransactionTableModel;
import transaction.src.org.crazyit.transaction.util.ViewUtil;

/**
 * �ҵ��������
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class MyTransactionPanel extends BasePanel {
	
	private JScrollPane tableScrollPane;
	
	//�����б�
	private TransactionTable dataTable;
	private TransactionTableModel tableModel;
	
	//��������
	private Box handleBox = Box.createVerticalBox();
	
	//��ѯ
	private Box queryBox = Box.createHorizontalBox();
	private JComboBox stateSelect = new JComboBox();
	private JButton queryButton = new JButton("��ѯ");
	
	//����
	private Box operateBox = Box.createHorizontalBox();
	private JButton finishButton = new JButton("���");
	private JButton transferButton = new JButton("ת��");
	private JButton forAWhileButton = new JButton("��ʱ����");
	private JButton notToDoButton = new JButton("����");
	
	//�鿴�������
	private ViewTransactionDialog vtDialog;
	//�����������
	private HandleTransactionDialog htDialog;
	
	private String currentState = TransactionState.PROCESSING;

	public MyTransactionPanel() {
		this.vtDialog = new ViewTransactionDialog();
		this.htDialog = new HandleTransactionDialog(this);
		this.transferDialog = new TransferTransactionDialog(this);
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
	
	//��ʼ����ť������
	private void initListeners() {
		this.queryButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				query();
			}
		});
		this.finishButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				finish();
			}
		});
		this.transferButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				transfer();
			}
		});
		this.forAWhileButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				forAWhile();
			}
		});
		this.notToDoButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				notToDo();
			}
		});
	}
	
	private void query() {
		State state = (State)this.stateSelect.getSelectedItem();
		this.currentState = state.getValue();
		readData();
	}
	
	//ת������Ի���
	private TransferTransactionDialog transferDialog;
	
	//ת������
	private void transfer() {
		String id = ViewUtil.getSelectValue(this.dataTable, "id");
		if (id == null) {
			ViewUtil.showWarn("��ѡ����Ҫ����������", this);
			return;
		}
		//�õ��������
		Transaction t = ApplicationContext.transactionService.get(id);
		//��ʾ����Ի���		
		this.transferDialog.setTransaction(t);
		this.transferDialog.setVisible(true);
	}
	
	//��ʱ����������
	private TransactionHandler forAWhileHandler = new ForAWhileHandler();
	
	//��ʱ����
	private void forAWhile() {
		String id = ViewUtil.getSelectValue(this.dataTable, "id");
		if (id == null) {
			ViewUtil.showWarn("��ѡ����Ҫ����������", this);
			return;
		}
		//�õ��������
		Transaction t = ApplicationContext.transactionService.get(id);
		//��ʾ����Ի���
		this.htDialog.setTransaction(t);
		this.htDialog.setHandler(this.forAWhileHandler);
		this.htDialog.setVisible(true);
	}
	
	//��������������
	private TransactionHandler notToDoHandler = new NotToDoHandler();
	
	private void notToDo() {
		String id = ViewUtil.getSelectValue(this.dataTable, "id");
		if (id == null) {
			ViewUtil.showWarn("��ѡ����Ҫ����������", this);
			return;
		}
		//�õ��������
		Transaction t = ApplicationContext.transactionService.get(id);
		//��ʾ����Ի���
		this.htDialog.setTransaction(t);
		this.htDialog.setHandler(this.notToDoHandler);
		this.htDialog.setVisible(true);
	}
	
	//���������б�
	private void createTable() {
		this.tableModel = new TransactionTableModel();
		this.dataTable = new TransactionTable(this.tableModel);
		this.tableScrollPane = new JScrollPane(this.dataTable);		
		this.dataTable.addMouseListener(new MouseAdapter() {
			public void mouseClicked(MouseEvent e) {
				if (e.getClickCount() == 2) {
					view();
				}
			}
		});
		//�����ҵ��������������չ�ֵĽ���, �����Ҫ��ȡ����
		readData();
	}
	
	//�����ݿ��ж�ȡ����
	private List<Transaction> getDatas() {
		User loginUser = ApplicationContext.loginUser;
		List<Transaction> datas = ApplicationContext.transactionService.getHandlerTransaction(loginUser, currentState);
		return datas;
	}
	
	//�ҵ���������ȡ����, ʵ�ָ���ĳ��󷽷�
	public void readData() {
		List<Transaction> datas = getDatas();
		this.tableModel.setDatas(datas);
		this.dataTable.updateUI();
	}

	private void createOperateBox() {
		this.operateBox.add(Box.createHorizontalStrut(160));
		this.operateBox.add(new JLabel("ѡ�����: "));
		this.operateBox.add(Box.createHorizontalStrut(40));
		this.operateBox.add(this.finishButton);
		this.operateBox.add(Box.createHorizontalStrut(40));
		this.operateBox.add(this.transferButton);
		this.operateBox.add(Box.createHorizontalStrut(40));
		this.operateBox.add(this.forAWhileButton);
		this.operateBox.add(Box.createHorizontalStrut(40));
		this.operateBox.add(this.notToDoButton);
		this.operateBox.add(Box.createHorizontalStrut(160));
	}
	
	private TransactionHandler finishHandler = new FinishHandler();
	
	//��������Ϊ���״̬
	private void finish() {
		String id = ViewUtil.getSelectValue(this.dataTable, "id");
		if (id == null) {
			ViewUtil.showWarn("��ѡ����Ҫ����������", this);
			return;
		}
		//�õ��������
		Transaction t = ApplicationContext.transactionService.get(id);
		//��ʾ����Ի���
		this.htDialog.setTransaction(t);
		this.htDialog.setHandler(this.finishHandler);
		this.htDialog.setVisible(true);
	}
	
	//������ѯ����
	private void createQueryBox() {
		this.stateSelect.addItem(State.PROCESS_STATE);
		this.stateSelect.addItem(State.FINISHED_STATE);
		this.stateSelect.addItem(State.TRANSFER_STATE);
		this.stateSelect.addItem(State.FOR_A_WHILE_STATE);
		this.stateSelect.addItem(State.NOT_TO_DO_STATE);
		this.stateSelect.addItem(State.INVALID_STATE);
		this.queryBox.add(Box.createHorizontalStrut(320));
		this.queryBox.add(this.stateSelect);
		this.queryBox.add(Box.createHorizontalStrut(40));
		this.queryBox.add(this.queryButton);
		this.queryBox.add(Box.createHorizontalStrut(320));
	}
	
	private void view() {
		String id = ViewUtil.getSelectValue(this.dataTable, "id");
		Transaction t = ApplicationContext.transactionService.view(id);
		this.vtDialog.setTransaction(t);
		this.vtDialog.setVisible(true);
	}
		
}
