<%
  /*
   * ����: ��ӱ���������
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	//String opCode = "K230";
	//String opName = "��ӱ���������";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("############################################");

	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String object_name = WtcUtil.repNull(request.getParameter("object_name"));
	String object_type = WtcUtil.repNull(request.getParameter("object_type"));
	String modify_flag = WtcUtil.repNull(request.getParameter("modify_flag"));
	String note = WtcUtil.repNull(request.getParameter("note"));
	String create_login_no = WtcUtil.repNull(request.getParameter("create_login_no"));
	if(create_login_no.equals("null")){
		create_login_no = "";
	}

   System.out.println("############################################");
   
%>

<wtc:service name="sK230ist" outnum="3">
	<wtc:param value="<%=object_name%>"/>
	<wtc:param value="<%=object_type%>"/>
	<wtc:param value="<%=note%>"/>
	<wtc:param value="<%=create_login_no%>"/>
</wtc:service>

<wtc:row id="row" start="0" length="3">

<%
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");

System.out.println(row[0]);
System.out.println(row[1]);
System.out.println(row[2]);
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");

%>


var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
response.data.add("object_id","<%=row[2]%>");
core.ajax.receivePacket(response);

</wtc:row>