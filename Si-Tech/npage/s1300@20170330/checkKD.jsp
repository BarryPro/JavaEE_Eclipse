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
	String phoneNo = request.getParameter("phoneNo").trim();
	String[] inParam = new String[2];
	String s_flag="";
	//取phone_no的前5位 看是否是10648
	if(phoneNo.substring(0,5)=="10648" ||phoneNo.substring(0,5).equals("10648"))
	{
		System.out.println("fffffffffffffffffffffffffffffffffff 物联网的退费操作~~~~~~~~~~~~~~");
		inParam[0] = "select to_char(new_phoneno) from dbbillprg.s_rs_iot_phonenoswitch_info where old_phoneno=:phoneNo ";
		inParam[1]="phoneNo="+phoneNo;
		s_flag="w";//物联网
	}
	else
	{
		inParam[0] = "select to_char(phone_no) from dbroadbandmsg where phone_no=:phoneNo ";
		inParam[1]="phoneNo="+phoneNo;
		s_flag="t";//铁通
	}
	
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA inParam[0] is "+inParam[0]);
%>
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
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
		checkResult=result1[0][0];
		System.out.println("ccccccccccccccccccccccccccc result1 is "+result1[0][0]);
	}
	System.out.println("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB checkResult is "+checkResult);
%>
		
 
	var response = new AJAXPacket();
	response.data.add("checkResult","<%=checkResult%>");
	response.data.add("s_flag","<%=s_flag%>");
	core.ajax.receivePacket(response);
 