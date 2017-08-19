package org.crazyit.transaction.ui.handler.impl;

import transaction.src.org.crazyit.transaction.ui.handler.TransactionHandler;

public class ForAWhileHandler implements TransactionHandler {


	public void handler(Comment comment) {
		//��������Ϊ��ʱ����״̬, ��Ҫ�����������״̬, ���������
		ApplicationContext.transactionService.forAWhile(comment.getTRANSACTION_ID(), 
				comment.getUSER_ID(), comment);
//		ApplicationContext.commentService.save(comment);
	}

}
