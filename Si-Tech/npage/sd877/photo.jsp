<%
  /*
   * 功能: 关于与浦发银行合作实现手机钱包联名卡产品业务支撑系统改造需求
   * 版本: 1.0
   * 日期: 20110524
   * 作者: 王怀峰wanghfa
   * 版权: si-tech
  */
%>

<%
	String photo = request.getParameter("photo");
	System.out.println("====wanghfa====photo.jsp====photo = " + photo);
	
	response.reset();
	OutputStream os = response.getOutputStream();
	
	os.write( new sun.misc.BASE64Decoder().decodeBuffer(photo));
	os.flush();
	os.close();
%>
