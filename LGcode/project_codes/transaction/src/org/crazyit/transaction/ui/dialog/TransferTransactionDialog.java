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
import transaction.src.org.crazyit.transaction.ui.MyTransactionPanel;
import transaction.src.org.crazyit.transaction.ui.handler.UserSelectHandler;
import transaction.src.org.crazyit.transaction.ui.handler.impl.TransferUserSelectHandler;
import transaction.src.org.crazyit.transaction.util.ViewUtil;

/**
 * ת���������
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class TransferTransactionDialog extends JDialog {

	//����
	private JLabel titleLabel = new JLabel("����: ");
	private JTextField title = new JTextField(10);
	//ID
	private JTextField transationId = new JTextField();
	
	//ѡ��ת��Ŀ���û�
	private JLabel targetUserLabel = new JLabel("ת��: ");
	private JTextField targetRealName = new JTextField(10);
	private JTextField targetUserId = new JTextField(10);
	//������ѡ��ť
	private JButton handlerSelectButton = new JButton("ѡ���û�");
	private SelectUserDialog userDialog;
	
	//����
	
	private JLabel contentLabel = new JLabel("˵��: ");
	private JTextArea content = new JTextArea(10, 40);
	private JScrollPane contentPane = new JScrollPane(content);
	
	//��ť
	private JButton confirmButton = new JButton("����");
	private JButton cancelButton = new JButton("ȡ��");
	
	private Transaction t;
	
	private MyTransactionPanel myPanel;
	
	//�û�ѡ������
	private UserSelectHandler selectHandler;
	
	public TransferTransactionDialog(MyTransactionPanel myPanel) {
		this.targetUserId.setVisible(false);
		this.myPanel = myPanel;
		this.targetRealName.setEditable(false);
		//�û�ѡ������
		this.selectHandler = new TransferUserSelectHandler(this);
		//�û�ѡ��Ի���
		this.userDialog = new SelectUserDialog(this.selectHandler);
		this.title.setEditable(false);
		this.transationId.setVisible(false);
		//����
		Box titleBox = Box.createHorizontalBox();
		titleBox.add(Box.createHorizontalStrut(30));
		titleBox.add(this.titleLabel);
		titleBox.add(this.title);
		titleBox.add(Box.createHorizontalStrut(30));
		//ѡ���û�
		Box userBox = Box.createHorizontalBox();
		userBox.add(Box.createHorizontalStrut(30));
		userBox.add(this.targetUserLabel);
		userBox.add(this.targetRealName);
		userBox.add(this.targetUserId);
		userBox.add(Box.createHorizontalStrut(230));
		//ѡ���û���ť
		Box selectButtonBox = Box.createHorizontalBox();
		selectButtonBox.add(Box.createHorizontalStrut(30));
		selectButtonBox.add(this.handlerSelectButton);
		selectButtonBox.add(Box.createHorizontalStrut(355));
		//����
		Box contentBox = Box.createHorizontalBox();
		contentBox.add(Box.createHorizontalStrut(30));
		contentBox.add(this.contentLabel);
		contentBox.add(this.contentPane);
		contentBox.add(Box.createHorizontalStrut(30));
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
		mainBox.add(userBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(selectButtonBox);
		mainBox.add(Box.createVerticalStrut(10));
		mainBox.add(buttonBox);
		mainBox.add(Box.createVerticalStrut(20));
		this.add(mainBox);	
		this.pack();
		this.setResizable(false);
		this.setTitle("��������");
		Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
		this.setLocation((int)screen.getWidth()/4, (int)screen.getHeight()/5);
		initListeners();
	}
	
	//�����������Ӧ���������
	public void setTransaction(Transaction t) {
		this.t = t;
	}
	
	public void setVisible(boolean b) {
		super.setVisible(b);
		if (!b) return;
		if (this.t != null) {
			this.transationId.setText(t.getID());
			this.title.setText(t.getTS_TITLE());
		}
	}

	//��ʼ����ť������
	private void initListeners() {
		this.confirmButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				confirm();
			}
		});
		this.cancelButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				setVisible(false);
			}
		});
		this.handlerSelectButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				userDialog.setVisible(true);
			}
		});
	}
	
	public JTextField getUserIdText() {
		return this.targetUserId;
	}
	
	public JTextField getRealNameText() {
		return this.targetRealName;
	}
	
	//ȷ������������
	private void confirm() {
		String targetUserId = this.targetUserId.getText();
		String sourceUserId = ApplicationContext.loginUser.getID();
		if (targetUserId.equals("")) {
			ViewUtil.showWarn("��������������Ϣ", this);
			return;
		}
		if (targetUserId.equals(sourceUserId)) {
			ViewUtil.showWarn("�����԰��Լ���Ϊת����", this);
			return;
		}
		//�������۶���
		Comment comment = new Comment();
		comment.setCM_CONTENT(this.content.getText());
		comment.setCM_DATE(ViewUtil.formatDate(new Date()));
		comment.setTRANSACTION_ID(this.transationId.getText());
		comment.setUSER_ID(sourceUserId);
		try {
			//����ҵ��ӿڽ�������ת��
			ApplicationContext.transactionService.transfer(targetUserId, sourceUserId, 
					comment);
			this.myPanel.readData();
			this.setVisible(false);
		} catch (Exception e) {
			e.printStackTrace();
			ViewUtil.showWarn(e.getMessage(), this);
		}
	}
	
	
}
