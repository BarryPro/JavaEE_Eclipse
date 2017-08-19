package org.crazyit.image;

import java.io.File;

import javax.swing.JFileChooser;
import javax.swing.filechooser.FileFilter;

/**
 * �ļ��Ի���
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class ImageFileChooser extends JFileChooser {
	/**
	 * ʹ���û�Ĭ��·������һ��ImageFileChooser
	 * 
	 * @return void
	 */
	public ImageFileChooser() {
		super();
		setAcceptAllFileFilterUsed(false);
		addFilter();
	}

	/**
	 * ʹ���Զ����·��·������һ��ImageFileChooser
	 * 
	 * @param currentDirectoryPath
	 *            String �Զ���·��
	 * @return void
	 */
	public ImageFileChooser(String currentDirectoryPath) {
		super(currentDirectoryPath);
		setAcceptAllFileFilterUsed(false);
		addFilter();
	}

	/**
	 * ��ȡ��׺��
	 * 
	 * @return String
	 */
	public String getSuf() {
		// ��ȡ�ļ����˶���
		FileFilter fileFilter = this.getFileFilter();
		String desc = fileFilter.getDescription();
		String[] sufarr = desc.split(" ");
		String suf = sufarr[0].equals("����ͼ���ļ�") ? "" : sufarr[0];
		return suf.toLowerCase();
	}

	/**
	 * �����ļ�������
	 * 
	 * @return void
	 */
	private void addFilter() {
		this.addChoosableFileFilter(new MyFileFilter(new String[] { ".BMP" },
				"BMP (*.BMP)"));
		this
				.addChoosableFileFilter(new MyFileFilter(new String[] { ".JPG",
						".JPEG", ".JPE", ".JFIF" },
						"JPEG (*.JPG;*.JPEG;*.JPE;*.JFIF)"));
		this.addChoosableFileFilter(new MyFileFilter(new String[] { ".GIF" },
				"GIF (*.GIF)"));
		this.addChoosableFileFilter(new MyFileFilter(new String[] { ".TIF",
				".TIFF" }, "TIFF (*.TIF;*.TIFF)"));
		this.addChoosableFileFilter(new MyFileFilter(new String[] { ".PNG" },
				"PNG (*.PNG)"));
		this.addChoosableFileFilter(new MyFileFilter(new String[] { ".ICO" },
				"ICO (*.ICO)"));
		this.addChoosableFileFilter(new MyFileFilter(new String[] { ".BMP",
				".JPG", ".JPEG", ".JPE", ".JFIF", ".GIF", ".TIF", ".TIFF",
				".PNG", ".ICO" }, "����ͼ���ļ�"));
	}

	class MyFileFilter extends FileFilter {
		// ��׺������
		String[] suffarr;
		// ����
		String decription;

		public MyFileFilter() {
			super();
		}

		/**
		 * �ð�����׺������������������һ��MyFileFilter
		 * 
		 * @param suffarr
		 *            String[]
		 * @param decription
		 *            String
		 * @return void
		 */
		public MyFileFilter(String[] suffarr, String decription) {
			super();
			this.suffarr = suffarr;
			this.decription = decription;
		}

		/**
		 * ��дboolean accept( File f )����
		 * 
		 * @paream f File
		 * @return boolean
		 */
		public boolean accept(File f) {
			// ����ļ��ĺ�׺���Ϸ�������true
			for (String s : suffarr) {
				if (f.getName().toUpperCase().endsWith(s)) {
					return true;
				}
			}
			// �����Ŀ¼������true,���߷���false
			return f.isDirectory();
		}

		/**
		 * ��ȡ������Ϣ
		 * 
		 * @return String
		 */
		public String getDescription() {
			return this.decription;
		}
	}

}