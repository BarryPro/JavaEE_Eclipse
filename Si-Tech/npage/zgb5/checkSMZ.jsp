<%
  /*
   * ����: У���������Ƿ�Ϊ�������
   * �汾: 1.0
   * ����: 2014/8/20
   * ����: huangqi
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
 

<%
	String u_pass = request.getParameter("u_pass").trim();
	String in_pass = request.getParameter("in_pass").trim();//���Ӧ�þ������������ Ҫ���ĵ�
	String id_no = request.getParameter("id_no").trim();
	String custPass = Encrypt.encrypt(in_pass);
	System.out.println("fffffffffffffffffffffffffffffff testttttttttttttttttttttttt zgb5 test u_pass is "+u_pass+" and ������������ǰ in_pass is "+in_pass+" and �����������ܺ�custPass is "+custPass);
	//�ж��û������Ƿ���ȷ �ж�ʵ������Ϣ
	//1. У������ ��jiangleiȷ����sql
	String s_flag_mm="";
	String workNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String[] inParam_pass = new String[8];
	String phoneno = request.getParameter("phoneno").trim();
	inParam_pass[0]="0";
	inParam_pass[1]="01";
	inParam_pass[2]="zgb5";
	inParam_pass[3]=workNo;
	inParam_pass[4]=nopass;
	inParam_pass[5]=phoneno;
	inParam_pass[6]=in_pass;
	%>
	<wtc:service name="sPinUserCheck"  outnum="1" >
		<wtc:param value="<%=inParam_pass[0]%>"/>
		<wtc:param value="<%=inParam_pass[1]%>"/>
		<wtc:param value="<%=inParam_pass[2]%>"/>
		<wtc:param value="<%=inParam_pass[3]%>"/>
		<wtc:param value="<%=inParam_pass[4]%>"/>
		<wtc:param value="<%=inParam_pass[5]%>"/>
		<wtc:param value="<%=inParam_pass[6]%>"/> 
	</wtc:service>
	<wtc:array id="result_pass" scope="end" />
	<%
	System.out.println("fffffffffffffffffffffffff testttttttttttttt result_pass is "+result_pass.length);
	if(result_pass.length>0)
	{
		System.out.println("gggggggggggggggggggggggggggggggggggggg [0][0] is "+result_pass[0][0]);
		if(result_pass[0][0]=="000000" ||result_pass[0][0].equals("000000"))
		{
			s_flag_mm="Y";
		}
	}

	//end of У������ s_flag_mm="Y";

	String[] inParam_mm = new String[2];
	inParam_mm[0] = "select to_char(true_code) from dtruenamemsg where id_no=:s_id_no";
	inParam_mm[1]="s_id_no="+id_no;
	
	String s_flag_smz="";
	
	 
	
%>
	<wtc:service name="TlsPubSelBoss"  outnum="1" >
		<wtc:param value="<%=inParam_mm[0]%>"/>
		<wtc:param value="<%=inParam_mm[1]%>"/>
	</wtc:service>
	<wtc:array id="result_smz" scope="end" />
<%
	String checkResult="0";
	String[][] result_name  = null ;
	result_name=result_smz;
	String s_smz="";
	if(result_name!=null&&result_name.length>0)
	{
		s_smz=result_name[0][0].trim();
		if(s_smz=="2" ||s_smz=="3"||s_smz.equals("2")||s_smz.equals("3"))
		{
			s_flag_smz="Y";
		}
		
		 
		
	}
	//У��ʵ����

%>
		
 
	var response = new AJAXPacket();
	response.data.add("checkResult","<%=checkResult%>");
	response.data.add("s_flag_mm","<%=s_flag_mm%>");
	response.data.add("s_flag_smz","<%=s_flag_smz%>");
	core.ajax.receivePacket(response);
 