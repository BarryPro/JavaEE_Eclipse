<%
  /*
   * ����: �������ַ����к���ʵ���ֻ�Ǯ����������Ʒҵ��֧��ϵͳ��������
   * �汾: 1.0
   * ����: 20110524
   * ����: ������wanghfa
   * ��Ȩ: si-tech
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
