package com.belong.service;

import org.apache.commons.fileupload.FileItemIterator;

import com.belong.vo.BBSUser;

public interface IBBSUserService {
	public BBSUser login(BBSUser user);
	public boolean register(BBSUser user);
	public BBSUser upload(String tpath,FileItemIterator fi);
	public byte[] getPic(int id);
	public boolean editPageNum(int pagenum,int userid);
}
