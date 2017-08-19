package org.crazyit.transaction.ui.handler.impl;

import transaction.src.org.crazyit.transaction.ui.handler.TransactionHandler;

/**
 * ���������Ĵ�����
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class NotToDoHandler implements TransactionHandler {

	public void handler(Comment comment) {
		//ѡ������״̬�ı�Ϊ����, ���������
		ApplicationContext.transactionService.notToDo(comment.getTRANSACTION_ID(), 
				comment.getUSER_ID(), comment);
//		ApplicationContext.commentService.save(comment);
	}

}
