package org.crazyit.editor.tree;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JTree;
import javax.swing.tree.DefaultTreeCellRenderer;
import javax.swing.tree.TreePath;

import editor.src.org.crazyit.editor.EditorFrame;

/**
 * ������ʵ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class TreeCreatorImpl implements TreeCreator {

	
	@Override
	public JTree createTree(EditorFrame editorFrame) {
		File spaceFolder = editorFrame.getWorkSpace().getFolder();
		ProjectTreeNode root = new ProjectTreeNode(spaceFolder, true);
		ProjectTreeModel treeModel = new ProjectTreeModel(root);
		JTree tree = new JTree(treeModel);
		//��ȡ�����ռ��������е�Ŀ¼��������projectName.project���Ӧ��Ŀ¼����Ҳ������ĿĿ¼
		List<File> projectFolders = getProjectFolders(spaceFolder);
		//������ĿĿ¼���ϣ���Ϊ�䴴���ӽڵ�
		for (int i = 0; i < projectFolders.size(); i++) {
			//��ȡѭ���е�Ŀ¼
			File projectFolder = projectFolders.get(i);
			//����createNode���������е��ӽڵ�
			ProjectTreeNode node = createNode(projectFolder);
			//����ڵ�����ӽڵ㣨��ĿĿ¼��
			root.add(node);
		}

		//���ƽڵ�ͼƬ
		DefaultTreeCellRenderer renderer = new DefaultTreeCellRenderer();
		//Ŀ¼��ʱ��ͼƬ
		renderer.setOpenIcon(ImageUtil.getImageIcon(ImageUtil.FOLDER_OPEN));
		//�ڵ�û���ӽڵ��ͼƬ
		renderer.setLeafIcon(ImageUtil.getImageIcon(ImageUtil.FILE));
		//Ŀ¼�ر�ʱ��ͼƬ
		renderer.setClosedIcon(ImageUtil.getImageIcon(ImageUtil.FOLDER_CLOSE));
		//�������Ĳ���������Ϊ�����renderer
		tree.setCellRenderer(renderer);
		//Ϊ��Ŀ�����һ����ѡ�������
		tree.addMouseListener(new ProjectTreeSelectionListener(editorFrame));
		//����������Ŀ���е�·��
		TreePath path = new TreePath(root);
		//����Ĭ��չ�����ڵ�
		tree.expandPath(path);
		//�������ĸ��ڵ㲻�ɼ�
		tree.setRootVisible(false);
		return tree;
	}
	
	/*
	 * ����һ��Ŀ¼������������ֱ�ӽڵ�
	 */
	private List<ProjectTreeNode> createNodes(File folder) {
		//��ȡ��Ŀ¼�µ������ļ�
		File[] files = folder.listFiles();
		List<ProjectTreeNode> result = new ArrayList<ProjectTreeNode>();
		//�Ը�Ŀ¼�µ������ļ�������������α���
		for (File file : files) {
			//��һ�α����������Ŀ¼�Ļ����ͼ��뵽���������
			if (file.isDirectory()) {
				result.add(new ProjectTreeNode(file, true));
			}
		}
		for (File file : files) {
			//�ڶ��α����������Ŀ¼�Ļ����ͼ��뵽���������
			if (!file.isDirectory()) {//�ټ���ͨ�ļ�
				result.add(new ProjectTreeNode(file, false));
			}
		}
		return result;
	}
	
	//����һ��Ŀ¼ȥ������Ŀ¼����Ӧ�Ľڵ���󣬸ö�������е��ӽڵ㶼�Ѿ�����
	public ProjectTreeNode createNode(File folder) {
		//����һ�����ڵ㣬���������������صĽڵ����
		ProjectTreeNode parent = null;
		//�������foler����һ��Ŀ¼�Ļ�������һ��ProjectTreeNode���󲢷��أ�������������ӵ���ӽڵ�
		if (!folder.isDirectory()) {
			return new ProjectTreeNode(folder, false);
		} else {
			//�����һ��Ŀ¼�Ļ����򴴽������parent����������һ��Ŀ¼������ӵ���ӽڵ�
			parent = new ProjectTreeNode(folder, true);
		}
		//���������parent�ڵ�ȥ�������������е�ֱ�ӽڵ�
		List<ProjectTreeNode> nodes = createNodes(parent.getFile());
		//��ȡ��parent���������ֱ���ӽڵ����ȥѭ���ݹ���ñ�����
		for (ProjectTreeNode node : nodes) {
			//�ݹ鴴���ӽڵ㣬�������صĽڵ���ӵ�parent��
			parent.add(createNode(node.getFile()));
		}
		return parent;
	}
	
	
	/**
	 * ��ȡ�����ռ�Ŀ¼�����е���Ŀ����
	 * @return
	 */
	private List<String> getProjectNames(File spaceFolder) {
		List<String> result = new ArrayList<String>();
		for (File file : spaceFolder.listFiles()) {
			if (file.getName().endsWith(".project")) {//ȡ��.project��β���ļ�
				result.add(file.getName().substring(0, file.getName().indexOf(".project")));
			}
		}
		return result;
	}
	
	/*
	 * ��ȡ�����ռ�Ŀ¼�����е���ĿĿ¼
	 */
	private List<File> getProjectFolders(File spaceFolder) {
		List<String> projectNames = getProjectNames(spaceFolder);
		List<File> result = new ArrayList<File>();
		//��ȡ�����ռ��������е��ļ�
		File[] files = spaceFolder.listFiles();
		for (String projectName : projectNames) {
			for (File file : files) {
				if (file.isDirectory()) {//��������ռ�������ļ���Ŀ¼����ȥ�ж��Ƿ�����ĿĿ¼
					if (projectName.equals(file.getName())) {
						result.add(file);
					}
				}
			}
		}
		return result;
	}
}


