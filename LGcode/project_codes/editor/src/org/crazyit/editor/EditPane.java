package org.crazyit.editor;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Insets;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

import javax.swing.JTextPane;
import javax.swing.text.Element;
import javax.swing.text.SimpleAttributeSet;
import javax.swing.text.StyleConstants;
import javax.swing.text.StyledDocument;

/**
 * �༭����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class EditPane extends JTextPane {

	//��ʽ�ĵ�����
	protected StyledDocument doc;
	//����һ���ı���ʽ��
	protected SyntaxFormatter formatter = new SyntaxFormatter("java.stx");
	private SimpleAttributeSet quotAttr = new SimpleAttributeSet();
	//�����ĵ��ı�Ŀ�ʼλ��
	private int docChangeStart = 0;
	//�����ĵ��ı�ĳ���
	private int docChangeLength = 0;
	//�����ĵ��������ı����������
	private SimpleAttributeSet lineAttr = new SimpleAttributeSet();
	
	public EditPane(File file) {
		this.setText(FileUtil.readFile(file));
		this.doc = getStyledDocument();
		//���ø��ĵ���ҳ�߾�
		this.setMargin(new Insets(3, 40, 0, 0));
		syntaxParse();
		//��Ӱ������������������ɿ�ʱ�����﷨����
		this.addKeyListener(new KeyAdapter() {
			public void keyReleased(KeyEvent ke)
			{
				syntaxParse();
			}
		});
	}
//	
//	//��д���෽����ʹJTextPane�����Զ�����
//	public boolean getScrollableTracksViewportWidth() { 
//		return (getSize().width < getParent().getSize().width - 100); 
//	} 
//
//	//��д���෽����ʹJTextPane�����Զ�����
//	public void setSize(Dimension d) { 
//		if (d.width < getParent().getSize().width) { 
//		   d.width = getParent().getSize().width; 
//		} 
//		d.width += 100; 
//		super.setSize(d); 
//	} 
	
	public void syntaxParse() {
		try {
			//��ȡ�ĵ��ĸ�Ԫ�أ����ĵ��ڵ�ȫ������
			Element root = doc.getDefaultRootElement();
			//��ȡ�ĵ��й��������λ��
			int cursorPos = this.getCaretPosition();
			int line = root.getElementIndex(cursorPos);
			//��ȡ�������λ�õ���
			Element para = root.getElement(line);
			//�����������е���ͷ���ĵ���λ��
			int start = para.getStartOffset();
			//����ĵ��޸�λ�ñȵ�ǰ�л�ǰ
			if (start > docChangeStart)	{
				start = docChangeStart;
			}
			//���屻�޸Ĳ��ֵĳ���
			int length = para.getEndOffset() - start;
			if (length < docChangeLength) {
				length = docChangeLength + 1;
			}
			//ȡ�����б��޸ĵ��ַ���
			String s = doc.getText(start, length);
			//�Կո񡢵�ŵ���Ϊ�ָ���
			String[] tokens = s.split("\\s+|\\.|\\(|\\)|\\{|\\}|\\[|\\]");
			//���嵱ǰ�������ʵ���s�ַ����еĿ�ʼλ��
			int curStart = 0;
			boolean isQuot = false;
			for (String token : tokens) {
				//�ҳ���ǰ����������s�ַ�������λ��
				int tokenPos = s.indexOf(token , curStart);
				if (isQuot && (token.endsWith("\"") || token.endsWith("\'"))) {
					doc.setCharacterAttributes(start + tokenPos, token.length(), quotAttr, false);
					isQuot = false;
				}
				else if (isQuot && !(token.endsWith("\"") || token.endsWith("\'"))) {
					doc.setCharacterAttributes(start + tokenPos, token.length(), quotAttr, false);
				}
				else if ((token.startsWith("\"") || token.startsWith("\'"))
					&& (token.endsWith("\"") || token.endsWith("\'"))) {
					doc.setCharacterAttributes(start + tokenPos, token.length(), quotAttr, false);
				}
				else if ((token.startsWith("\"") || token.startsWith("\'"))
					&& !(token.endsWith("\"") || token.endsWith("\'"))) {
					doc.setCharacterAttributes(start + tokenPos, token.length(), quotAttr, false);
					isQuot = true;
				}
				else {
					//ʹ�ø�ʽ���Ե�ǰ����������ɫ
					formatter.setHighLight(doc , token , start + tokenPos, token.length());
				}
				//��ʼ������һ������
				curStart = tokenPos + token.length();
			}
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	//�ػ�������������к�
	public void paint(Graphics g){
		super.paint(g);
		Element root = doc.getDefaultRootElement(); 
		//����к�
		int line = root.getElementIndex(doc.getLength());
		//������ɫ
		g.setColor(new Color(230, 230, 230));
		//�����������ο�
		g.fillRect(0, 0, this.getMargin().left - 10, getSize().height);
		//�����кŵ���ɫ
		g.setColor(new Color(40, 40, 40));
		//ÿ�л���һ���к�
		for (int count = 0, j = 1; count <= line; count++, j++) {
			g.drawString(String.valueOf(j), 3, 
						(int)((count + 1) * 1.5020 * StyleConstants.getFontSize(lineAttr)));
		}
	}
}
class SyntaxFormatter {
	//��һ��Map����ؼ��ֺ���ɫ�Ķ�Ӧ��ϵ
	private Map<SimpleAttributeSet , ArrayList> attMap
		= new HashMap<SimpleAttributeSet , ArrayList>();
	//�����ĵ��������ı����������
	SimpleAttributeSet normalAttr = new SimpleAttributeSet();
	public SyntaxFormatter(String syntaxFile) {
		//���������ı�����ɫ����С
		StyleConstants.setForeground(normalAttr, Color.BLACK);
		//StyleConstants.setFontSize(normalAttr, 14);
		//����һ��Scanner���󣬸�������﷨�ļ�������ɫ��Ϣ
		Scanner scaner = null;
		try	{
			scaner = new Scanner(new File(syntaxFile));
		}
		catch (FileNotFoundException e)	{
			throw new RuntimeException("��ʧ�﷨�ļ���" + e.getMessage());
		}
		int color = -1;
		ArrayList<String> keywords = new ArrayList<String>();
		//���϶�ȡ�﷨�ļ���������
		while(scaner.hasNextLine())	{
			String line = scaner.nextLine();
			//�����ǰ����#��ͷ
			if (line.startsWith("#")) {
				if (keywords.size() > 0 && color > -1) {
					//ȡ����ǰ�е���ɫֵ������װ��SimpleAttributeSet����
					SimpleAttributeSet att = new SimpleAttributeSet();
					StyleConstants.setForeground(att, new Color(color));
					//StyleConstants.setFontSize(att, 14);
					//����ǰ��ɫ�͹ؼ���List��Ӧ����
					attMap.put(att , keywords);
				}
				//���´����µĹؼ���List��Ϊ��һ���﷨��ʽ׼��
				keywords = new ArrayList<String>();
				color = Integer.parseInt(line.substring(1) , 16);
			} else {
				//������ͨ�У�ÿ��������ӵ��ؼ���List��
				if (line.trim().length() > 0) {
					keywords.add(line.trim());
				}
			}
		}
		//�����Ĺؼ��ֺ���ɫ��Ӧ����
		if (keywords.size() > 0 && color > -1) {
			SimpleAttributeSet att = new SimpleAttributeSet();
			StyleConstants.setForeground(att, new Color(color));
			attMap.put(att , keywords);
		}
	}
	//���ظø�ʽ���������ı����������
	public SimpleAttributeSet getNormalAttributeSet() {
		return normalAttr;
	}
	//�����﷨����
	public void setHighLight(StyledDocument doc , String token , 
		int start , int length)	{
		//������Ҫ�Ե�ǰ���ʶ�Ӧ���������
		SimpleAttributeSet currentAttributeSet = null;
		outer :
		for (SimpleAttributeSet att : attMap.keySet())
		{
			//ȡ����ǰ��ɫ��Ӧ�����йؼ���
			ArrayList keywords = attMap.get(att);
			//�������йؼ���
			for (Object keyword : keywords)
			{
				//����ùؼ����뵱ǰ������ͬ
				if (keyword.toString().equals(token))
				{
					//����ѭ���������õ�ǰ���ʶ�Ӧ���������
					currentAttributeSet = att;
					break outer;
				}
			}
		}
		//�����ǰ���ʶ�Ӧ��������Բ�Ϊ��
		if (currentAttributeSet != null){
			//���õ�ǰ���ʵ���ɫ
			doc.setCharacterAttributes(start, length, currentAttributeSet, false);
		} else {//����ʹ����ͨ��������øõ���
			doc.setCharacterAttributes(start, length, normalAttr, false);
		}
	}
}