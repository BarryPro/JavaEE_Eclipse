package com.belong.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.util.Streams;

import com.belong.dao.BBSUserDAOImpl;
import com.belong.dao.IBBSUserDAO;
import com.belong.vo.BBSUser;

public class BBSUserServiceImpl implements IBBSUserService {
	private IBBSUserDAO dao = new BBSUserDAOImpl();
	private Map<String ,String > types = new HashMap<String ,String> ();
	private static final String FILESEPARATOR = "file.separator";
	private static final String UPLOAD = "upload";
	private static final String REUSERNAME = "reusername";
	private static final String REPASSWORD = "repassword";
	public BBSUserServiceImpl(){
		types.put("image/jpeg", ".jpg");
		types.put("image/png", ".png");
		types.put("image/gif", ".gif");
		types.put("image/x-ms-bmp", ".bmp");
	}
	@Override
	public BBSUser ligin(BBSUser user) {
		// TODO Auto-generated method stub
		return dao.login(user);
	}
	@Override
	public boolean register(BBSUser user) {
		// TODO Auto-generated method stub
		return dao.register(user);
	}
	@Override
	public BBSUser upload(FileItemIterator fii, String tpath) {
		// TODO Auto-generated method stub
		BBSUser user = new BBSUser();
		try {			
			while(fii.hasNext()){
				FileItemStream fis = fii.next();
				InputStream is = fis.openStream();				
				if(!fis.isFormField()&&fis.getName().length()>0){//说名图片不是空的
					String postfix = fis.getContentType();
					if(!types.containsKey(postfix)){
						break;
					}
					//把输入流转换成带缓冲的字节流
					BufferedInputStream bis = new BufferedInputStream(is);
					//上传路径/upload
					String upload = System.getProperty(FILESEPARATOR)+UPLOAD;
					UUID id = UUID.randomUUID();
					String fileName = id+types.get(postfix);
					String upath = tpath+upload+fileName;
					File upFile = new File(upath);
					BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(upFile));
					Streams.copy(bis, bos, true);
					user.setPath(upath);
				} else {//为键直对
					String fieldname = fis.getFieldName();
					switch (fieldname) {
					case REUSERNAME:
						String username = Streams.asString(is,"utf-8");
						user.setUsername(username);
						break;
					case REPASSWORD:
						String password = Streams.asString(is,"utf-8");
						user.setPassword(password);
						break;
					default:
						break;
					}
				}
			}
		} catch (FileUploadException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}
	@Override
	public byte[] getPic(int id) {
		// TODO Auto-generated method stub
		return dao.getPic(id);
	}
	@Override
	public boolean editPagenum(int id, int pagenum) {
		// TODO Auto-generated method stub
		return dao.editPagenum(id, pagenum);
	}

}
