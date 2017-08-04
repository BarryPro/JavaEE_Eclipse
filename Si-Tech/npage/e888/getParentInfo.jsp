<%
  /*
   * 功能: 用户信誉度修改2308
   * 版本: 1.0
   * 日期: 2009/1/15
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
	String workNo = (String)session.getAttribute("workNo");
	String phoneNo = request.getParameter("phoneNo");
	String childNo = request.getParameter("childNo");
	String pwd = request.getParameter("pwd");
	String[] inParas2 = new String[2];
	String flag1="";
	String flag2="";
	String pay_money="";
	String child_no="";
	String s_accept="";
    //再查家长的表
	String[] inParas1 = new String[2];
	inParas1[0]="select to_char(pay_money),child_no,to_char(sMaxPayAccept.Nextval) from WFAMPAYOPR where father_no=:phoneNo and child_no=:child_no";
	inParas1[1]="phoneNo="+phoneNo+",child_no="+childNo;
	%>
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="3">
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val2" scope="end" />
	<%
	String[][] result2  = null ;
	result2=ret_val2;
	if(result2!=null && result2.length>0)
	{
		flag1="0";
		pay_money=result2[0][0];
		child_no=result2[0][1];
		s_accept=result2[0][2];
	}
	else
	{
		flag1="1";
		pay_money="0";
		child_no="0";
		s_accept="0";
	}
%>
	
	 
 
		
 
	var response = new AJAXPacket();
	response.data.add("flag1","<%=flag1%>");
	response.data.add("pay_money","<%=pay_money%>");
	response.data.add("child_no","<%=child_no%>");
	response.data.add("s_accept","<%=s_accept%>");
	core.ajax.receivePacket(response);
 