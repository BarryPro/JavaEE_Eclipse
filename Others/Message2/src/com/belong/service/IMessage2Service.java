package com.belong.service;

import java.util.List;

import com.belong.vo.Message2;

public interface IMessage2Service {
	public boolean addMessage(Message2 message);
	public boolean delMessage(Message2 message);
	public List<Message2> queryMessage();
}
