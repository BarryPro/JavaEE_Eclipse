package org.crazyit.transaction.service.impl;

import transaction.src.org.crazyit.transaction.dao.CommentDao;
import transaction.src.org.crazyit.transaction.dao.TransactionDao;
import transaction.src.org.crazyit.transaction.service.CommentService;

public class CommentServiceImpl implements CommentService {

	private CommentDao commentDao;
	
	private TransactionDao transactionDao;
	
	private UserDao userDao;
	
	public CommentServiceImpl(CommentDao commentDao, TransactionDao transactionDao, 
			UserDao userDao) {
		this.commentDao = commentDao;
		this.transactionDao = transactionDao;
		this.userDao = userDao;
	}
	
	public void save(Comment comment) {
		this.commentDao.save(comment);
	}

}
