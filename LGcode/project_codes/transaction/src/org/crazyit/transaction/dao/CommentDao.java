package org.crazyit.transaction.dao;

public interface CommentDao {

	/**
	 * ����һ����������
	 * @param comment
	 */
	Integer save(Comment comment);
	
	/**
	 * ����ID��������
	 * @param id
	 * @return
	 */
	Comment find(String id);
}
