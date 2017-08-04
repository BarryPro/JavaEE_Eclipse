package com.belong.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.util.Streams;

import com.belong.dao.BBSUserDAOImpl;
import com.belong.dao.IBBSUserDAO;
import com.belong.vo.BBSUser;

public class BBSUserServiceImpl implements IBBSUserService {
	private IBBSUserDAO dao = new BBSUserDAOImpl();
	private Map<String,String> types = new HashMap<String,String>();
	private File saveFile;
	public BBSUserServiceImpl(){
		types.put("image/jpeg", ".jpg");
		types.put("image/gif", ".gif");
		types.put("image/x-ms-bmp", ".bmp");
		types.put("image/png", ".png");
	}
	@Override
	public BBSUser login(BBSUser user) {
		// TODO Auto-generated method stub
		return dao.login(user);
	}

	@Override
	public boolean register(BBSUser user) {
		// TODO Auto-generated method stub
		return dao.register(user);
	}

	@Override
	public byte[] getPic(int id) {
		// TODO Auto-generated method stub
		return dao.getPic(id);
	}

	@Override
	public boolean editPagenum(int pagenum, int userid) {
		// TODO Auto-generated method stub
		return dao.editPagenum(pagenum, userid);
	}

	@Override
	public BBSUser upload(String tpath, FileItemIterator fii) {
		// TODO Auto-generated method stub
		BBSUser user = new BBSUser();
		try {
			while(fii.hasNext()){
				FileItemStream fis = fii.next();
				InputStream is = fis.openStream();//把文件流转换成输入流(所有的注册信息都在这里)
				if(!fis.isFormField()&&fis.getName().length()>0){//说明是图片且图片不空
					String filetype = fis.getContentType();//得到图片的后缀名
					if(!types.containsKey(filetype)){//看文件后缀是否匹配允许的类型（不满足直接结束）
						break;
					}					
					BufferedInputStream bis = new BufferedInputStream(is);
					//定义上传文件名('/upload')
					String upload = System.getProperty("file.separator")+"upload";
					//得到图片的随机名（128位）
					UUID id = UUID.randomUUID();
					//组成文件名(名.后缀)
					String filename = id+types.get(filetype);
					//组成完整的上传路径
					String upath = tpath+upload+System.getProperty("file.separator")+filename;
					saveFile = new File(upath);
					//把文件上传到tomcat的路径下
					BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(saveFile));
					//把本地上传的图片copy到输出流的路径下
					Streams.copy(bis, bos, true);
					//把上传完的路径赋给用户来保存（从服务器中读取图片用）
					user.setPath(upath);
				} else {
					String fieldname = fis.getFieldName();//得到区域名
					switch (fieldname) {
					case "reusername":
						String username = Streams.asString(is,"utf-8");//找到对应的用户名
						user.setUsername(username);
						break;
					case "repassword":
						String password = Streams.asString(is,"utf-8");
						user.setPassword(password);
						break;
					default:
						break;
					}
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
		}
		//组合出tomcat下存图片的路径
		return user;
	}

}
