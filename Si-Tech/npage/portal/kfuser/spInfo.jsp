<%
  /*
   * ����: ����ҵ���ѯ�˶�  
�� * �汾: 2.0
�� * ����: 2008/11/04
�� * ����: kouwb
�� * ��Ȩ: sitech
�� * �޸���ʷ
   * �޸����� 2009-05-19     �޸���  libina     �޸�Ŀ��  ����ҵ����ͳ�ƣ�����
 ��*/
%>
<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
	String retType = request.getParameter("retType");
	String phone_no = request.getParameter("phone_no");
	String login_no = request.getParameter("login_no");
	String sp_code = request.getParameter("sp_code");
	String sp_bizcode = request.getParameter("sp_bizcode");
	
	//System.out.println("sp_bizcode="+sp_bizcode);
	String SQL1 = "select to_char(sysdate,'yyyymm') from dual";/*��������@���±�@libina@20090519*/
%> 
 	<wtc:service name="sHW_SpCanclBiz"  routerKey="region"  routerValue="<%=regionCode%>"  outnum="3">
		<wtc:param value="<%=login_no%>"/>
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=sp_code%>"/>
		<wtc:param value="<%=sp_bizcode%>"/>
	</wtc:service>
	<wtc:array id="rs1"  scope="end"/>

<%
	  System.out.println("�����¼��ʼ@libina@20090519");
	  System.out.println("������ý����"+retCode+"/"+retMsg);
	  int successFlag = 1;
	  if("000000".equals(retCode)){
	     successFlag = 0;
	  }
	%>
	
  var response = new AJAXPacket(); 
	response.data.add("retType","<%=retType%>"); 
	response.data.add("retCode","<%=retCode%>" );  
	response.data.add("retMsg","<%=retMsg%>" );  
	response.data.add("sp_bizcode","<%=sp_bizcode%>" );
	
	<wtc:pubselect name="sPubSelect" outnum="1">
  <wtc:sql><%=SQL1%></wtc:sql> 	
  </wtc:pubselect>
	<wtc:array id="result1" scope="end"/> 	
<%
  String SQL2 = "insert into DLOGMANOPR"+result1[0][0]+" values(sysdate,'"+phone_no+"','"+login_no+"','03001',"+successFlag+",'"+sp_bizcode+"','2','SPҵ���˶�')";
%>  
    <wtc:service name="sPubModify" outnum="3">
			<wtc:param value="<%=SQL2%>"/>
			<wtc:param value="dbcall"/>
		</wtc:service>
<%
  System.out.println("�����¼����@libina@20090519");
%>    
	                                                                                                                                                                                                                  
	core.ajax.receivePacket(response);	
	 