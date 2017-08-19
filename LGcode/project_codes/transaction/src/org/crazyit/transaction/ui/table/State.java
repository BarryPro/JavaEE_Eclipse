package org.crazyit.transaction.ui.table;

import javax.swing.ImageIcon;

import transaction.src.org.crazyit.transaction.model.TransactionState;

/**
 * ����״̬������Ԫ�ض���
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class State {

	public final static String TRANSFER = "transfer";
	
	//״̬����
	public final static State PROCESS_STATE = new State("�����е�����", TransactionState.PROCESSING);
	public final static State FINISHED_STATE = new State("����ɵ�����", TransactionState.FINISHED);
	public final static State TRANSFER_STATE = new State("��ת��������", TRANSFER);
	public final static State FOR_A_WHILE_STATE = new State("��ʱ����������", TransactionState.FOR_A_WHILE);
	public final static State NOT_TO_DO_STATE = new State("����������", TransactionState.NOT_TO_DO);
	public final static State INVALID_STATE = new State("��Ч������", TransactionState.INVALID);
	
	//״̬ͼƬ
	public final static ImageIcon PROCESS_IMAGE = new ImageIcon("images/state/processing.gif", "������");
	public final static ImageIcon FINISHED_IMAGE = new ImageIcon("images/state/finished.gif", "�����");
	public final static ImageIcon FOR_A_WHILE_IMAGE = new ImageIcon("images/state/forAWhile.gif", "��ʱ����");
	public final static ImageIcon NOT_TO_DO_IMAGE = new ImageIcon("images/state/notToDo.gif", "����");
	public final static ImageIcon INVALID_IMAGE = new ImageIcon("images/state/invalid.gif", "��Ч");	
	
	public State(String text, String value) {
		this.text = text;
		this.value = value;
	}
	
	private String text;
	
	private String value;

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Override
	public String toString() {
		return this.text;
	}
	
	
}
