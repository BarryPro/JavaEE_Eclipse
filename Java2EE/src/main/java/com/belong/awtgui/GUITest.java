package com.belong.awtgui;

import javax.swing.*;
import java.awt.*;

/**
 * Created by belong on 2017/2/25.
 */
public class GUITest {
	public static void main(String args[]) {

		JTextArea jTextArea = new JTextArea();
		JFrame jFrame = new JFrame();
		JComboBox jComboBox = new JComboBox();
		JMenu menu = new JMenu();
		JButton button = new JButton();
		JMenuBar jMenuBar = new JMenuBar();
		JMenuItem item = new JMenuItem();
		JPanel jPanel = new JPanel();
		JScrollPane jScrollPane = new JScrollPane();

		item.setText("菜单");
		jMenuBar.add(item);
		jScrollPane.add(jTextArea);
		button.setVisible(true);
		button.setText("点击");

		jFrame.setLayout(new FlowLayout());

		jFrame.add(jPanel);
		jFrame.add(jMenuBar);
		jFrame.add(button);
		jTextArea.setText("belong");
		jFrame.add(jTextArea);
		jFrame.setBounds(100, 200, 500, 400);
		jFrame.setVisible(true);
		jFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

	}

}
