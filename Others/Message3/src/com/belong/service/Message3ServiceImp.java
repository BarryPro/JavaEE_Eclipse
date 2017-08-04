package com.belong.service;

import java.util.List;
import java.util.regex.Pattern;

import com.belong.dao.IMessage3DAO;
import com.belong.dao.Message3DAOImp;
import com.belong.vo.Message3;

public class Message3ServiceImp implements IMessage3Service {
	IMessage3DAO dao = new Message3DAOImp();
	@Override
	public boolean addMessage(Message3 message) {
		// TODO Auto-generated method stub
		return dao.addMessage(message);
	}

	@Override
	public boolean delMessage(Message3 message) {
		// TODO Auto-generated method stub
		return dao.delMessage(message);
	}

	@Override
	public List<Message3> queryMessage() {
		// TODO Auto-generated method stub
		return dao.queryMessage();
	}

	@Override
	public boolean check(String email) {
		// TODO Auto-generated method stub
		return Pattern.matches("^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$", email);
	}

}
