package org.crazyit.transaction.ui.dialog;

import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Date;

import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import transaction.src.org.crazyit.transaction.model.Transaction;
import transaction.src.org.crazyit.transaction.model.TransactionState;
import transaction.src.org.crazyit.transaction.ui.TransactionManagePanel;
import transaction.src.org.crazyit.transaction.ui.handler.impl.NewTransactionUserSelectHandler;
import transaction.src.org.crazyit.transaction.util.ViewUtil;

public class NewTransactionDialog extends JDialog {

	//����
	private JLabel titleLabel = new JLabel("����: ");
	private JTextField title = new JTextField(10);
	
	//����
	
	private JLabel contentLabel = new JLabel("����: ");
	private JTextArea content = new JTextArea(10, 40);
	private JScrollPane contentPane = new JScrollPane(content);
	
	//Ŀ�����ʱ��
	private JLabel targetDateLabel = new JLabel("���ʱ��: ");
	private JTextField targetDate = new JTextField(10);
	
	//������
	private JLabel handlerLabel = new JLabel("������: ");
	private JTextField handler = new JTextField(10);
	//������id(����)
	private JTextField handlerId = new JTextField();
	//������ѡ��ť
	private JButton handlerSelectButton = new JButton("ѡ������");
	
	//������(ϵͳ)
	private JLabel initiatorLabel = new JLabel("������: ");
	private JTextField initiator = new JTextField(ApplicationContext.loginUser.getREAL_NAME());
	
	//��ť
	private JButton confirmButton = new JButton("ȷ��");
	private JButton cancelButton = new JButton("ȡ��");
	
	//ѡ���û��ĶԻ���
	private SelectUserDialog userDialog;
	
	private TransactionManagePanel managePanel;
	
	//ѡ���û�������
	private NewTransactionUserSelectHandler selectHandler;
	
	public NewTransactionDialog(TransactionManagePanel managePanel) {
		this.managePanel = managePanel;
		this.selectHandler = new NewTransactionUserSelectHandler(this);
		//�����û�ѡ��Ի���
		this.userDialog = new SelectUserDialog(this.selectHandler);
		this.handlerId.setVisible(false);
		this.handler.setEditable(false);
		this.initiator.setEditable(false);
		this.content.setLineWrap(true);
		//����
		Box titleBox = Box.createHorizontalBox();
		titleBox.add(Box.createHorizontalStrut(30));
		titleBox.add(this.titleLabel);
		titleBox.add(this.title);
		titleBox.add(Box.createHorizontalStrut(30));
		//����
		Box contentBox = Box.createHorizontalBox();
		contentBox.add(Box.createHorizontalStrut(30));
		contentBox.add(this.contentLabel);
		contentBox.add(this.contentPane);
		contentBox.add(Box.createHorizontalStrut(30));
		//���ʱ��
		Box targetDateBox = Box.createHorizontalBox();
		targetDateBox.add(Box.createHorizontalStrut(4));
		targetDateBox.add(this.targetDateLabel);
		targetDateBox.add(this.targetDate);
		targetDateBox.add(Box.createHorizontalStrut(230));
		//������
		Box handlerBox = Box.createHorizontalBox();
		handlerBox.add(Box.createHorizontalStrut(17));
		handlerBox.add(this.handlerLabel);
		handlerBox.add(this.handler);
		handlerBox.add(this.handlerId);
		handlerBox.add(Box.createHorizontalStrut(230));
		Box selectButtonBox = Box.createHorizontalBox();
		selectButtonBox.add(this.handlerSelectButton);
		selectButtonBox.add(Box.createHorizontalStrut(312));
		//������
		Box initiatorBox = Box.createHorizontalBox();
		initiatorBox.add(Box.createHorizontalStrut(17));
		initiatorBox.add(this.initiatorLabel);
		initiatorBox.add(this.initiator);
		initiatorBox.add(Box.createHorizontalStrut(312));
		//��ť
		Box buttonBox = Box.createHorizontalBox();
		buttonBox.add(this.confirmButton);
		buttonBox.add(Box.createHorizontalStrut(40));
		buttonBox.add(this.cancelButton);
		
		Box mainBox = Box.createVerticalBox();
		mainBox.add(Box.createVerticalStrut(20));
		mainBox.add(titleBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(contentBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(targetDateBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(handlerBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(selectButtonBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(initiatorBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(buttonBox);
		mainBox.add(Box.createVerticalStrut(20));
		this.add(mainBox);	
		this.pack();
		this.setResizable(false);
		this.setTitle("����������");
		Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
		this.setLocation((int)screen.getWidth()/4, (int)screen.getHeight()/5);
		initListeners();
	}
	
	//Ϊ�������ı����ṩgetter����, ��ѡ���û��Ľ������
	public JTextField getHandlerField() {
		return this.handler;
	}
	
	//Ϊ������ID�ı����ṩgetter����, ��ѡ���û��Ľ������
	public JTextField getHandlerIdField() {
		return this.handlerId;
	}
	
	private void initListeners() {
		this.handlerSelectButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				userDialog.setVisible(true);
			}
		});
		this.confirmButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				save();
			}
		});
	}
	
	//ȷ������, ����
	private void save() {
		//��֤��Ϣ
		if (this.title.getText().equals("") || this.targetDate.getText().equals("")
				|| this.handler.getText().equals("")) {
			ViewUtil.showWarn("��������������Ϣ", this);
			return;
		}
		Transaction t = getTransaction();
		ApplicationContext.transactionService.save(t);
		this.setVisible(false);
		this.managePanel.readData();
	}
	
	//������Ԫ��ֵ��װ��һ��Transaction����
	private Transaction getTransaction() {
		//�õ�����ĸ���ֵ
		String title = this.title.getText();
		String content = this.content.getText();
		String targetDate = this.targetDate.getText();
		String handlerId = this.handlerId.getText();
		String initiatorId = ApplicationContext.loginUser.getID();
		String createDate = ViewUtil.formatDate(new Date());
		//����Transaction����
		Transaction t = new Transaction();
		t.setTS_TITLE(title);
		t.setTS_CONTENT(content);
		t.setTS_CREATEDATE(createDate);
		t.setTS_TARGETDATE(targetDate);
		t.setHANDLER_ID(handlerId);
		t.setINITIATOR_ID(initiatorId);
		t.setTS_STATE(TransactionState.PROCESSING);
		return t;
	}
	
	
}
