package org.crazyit.transaction.ui.table;

import java.awt.Component;
import java.awt.Font;
import java.util.List;

import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;

import transaction.src.org.crazyit.transaction.model.Transaction;

public class TransactionTableCellRenderer extends DefaultTableCellRenderer {
	
	private Font hurryFont;
	
	public TransactionTableCellRenderer() {
		this.hurryFont = new Font("hurry", Font.BOLD, 12);
	}
	
	@Override
	public Component getTableCellRendererComponent(JTable table, Object value,
			boolean isSelected, boolean hasFocus, int row, int column) {
		JLabel c = (JLabel)super.getTableCellRendererComponent(table, value, 
				isSelected, hasFocus, row, column);
		c.setText("");
		//����ͼƬ
		if (value instanceof ImageIcon) {
			ImageIcon icon = (ImageIcon)value;
			c.setIcon(icon);
			c.setToolTipText(icon.getDescription());
		} else {
			c.setText(value.toString());
		}
		//���þ���
		c.setHorizontalAlignment(JLabel.CENTER);
		TransactionTableModel model = (TransactionTableModel)table.getModel();
		List<Transaction> datas = model.getDatas();
		if (datas != null) {
			//�ж��Ƿ���Ҫ��������
			if (datas.get(row).getIS_HURRY().equals("1")) {
				c.setFont(hurryFont);
			}
		}
		return c;
	}
}
