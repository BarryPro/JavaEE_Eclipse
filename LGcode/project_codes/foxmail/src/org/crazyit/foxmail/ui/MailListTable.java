package org.crazyit.foxmail.ui;

import javax.swing.JTable;
import javax.swing.ListSelectionModel;
import javax.swing.table.TableModel;

/**
 * �ʼ��б����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class MailListTable extends JTable {
	public MailListTable(TableModel dm) {
		super(dm);
		//ֻ��ѡ��һ��
		getSelectionModel().setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		//ȥ��������
		setShowHorizontalLines(false);
		setShowVerticalLines(false);
	}
	//���б��ɱ༭
	public boolean isCellEditable(int row, int column) {
		return false;
	}
}
