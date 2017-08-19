package org.crazyit.flashget.ui;

import java.awt.Component;

import javax.swing.Icon;
import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;

public class DownloadTableCellRenderer extends DefaultTableCellRenderer {

	@Override
	public Component getTableCellRendererComponent(JTable table, Object value,
			boolean isSelected, boolean hasFocus, int row, int column) {
		//�ж��Ƿ���Ҫ��ʾͼƬ
		if (value instanceof Icon) this.setIcon((Icon)value);
		else this.setText(value.toString());
		//�ж��Ƿ�ѡ��
		if (isSelected) super.setBackground(table.getSelectionBackground());
		else setBackground(table.getBackground());
		//���þ���
		this.setHorizontalAlignment(JLabel.CENTER);
		this.setToolTipText(value.toString());
		return this;
	}

	
}
