package com.belong.service;

import java.util.List;

import com.belong.dao.IMessage2DAO;
import com.belong.dao.Message2DAOImp;
import com.belong.vo.Message2;

public class Message2ServiceImp implements IMessage2Service {
	private IMessage2DAO dao = new Message2DAOImp();
	@Override
	public boolean addMessage(Message2 message) {
		// TODO Auto-generated method stub
		return dao.addMessage(message);
	}

	@Override
	public boolean delMessage(Message2 message) {
		// TODO Auto-generated method stub
		return dao.delMessage(message);
	}

	@Override
	public List<Message2> queryMessage() {
		// TODO Auto-generated method stub
		return dao.queryMessage();
	}

}
