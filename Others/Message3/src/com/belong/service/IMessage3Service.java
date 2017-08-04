package com.belong.service;

import java.util.List;

import com.belong.vo.Message3;

public interface IMessage3Service {
	public boolean addMessage(Message3 message);
	public boolean delMessage(Message3 message);
	public List<Message3> queryMessage();
	public boolean check(String email);
}
