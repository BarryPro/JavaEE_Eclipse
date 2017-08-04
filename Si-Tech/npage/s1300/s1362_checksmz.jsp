<%
  /*
   * 功能: 校验服务号码是否为宽带号码
   * 版本: 1.0
   * 日期: 2014/8/20
   * 作者: huangqi
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
	String id_no = request.getParameter("id_no").trim();
	String[] inParam = new String[2];
 
 
	inParam[0]="select to_char(true_code) from dtruenamemsg where id_no=:s_id_no";
	inParam[1]="s_id_no="+id_no;
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA inParam[0] is "+inParam[0]);
	String s_flag="";
%>
	<wtc:service name="TlsPubSelBoss"  outnum="1" >
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%
	String checkResult="0";
	String[][] result1  = null ;
	result1=result;
	if(result1!=null&&result1.length>0)
	{
		if(result1[0][0]=="1" ||result1[0][0].equals("1"))
		{
			s_flag="1";
		}
		
		System.out.println("ccccccccccccccccccccccccccc result1 is "+result1[0][0]);
	}
	else
	{
		s_flag="1";//无值说明是实名
	}
	System.out.println("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB s_flag is "+s_flag);
%>
		
 
	var response = new AJAXPacket();
	response.data.add("s_flag1","<%=s_flag%>");
	core.ajax.receivePacket(response);
 