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
	 					//操作工号
	//String phoneNo = request.getParameter("phoneNo").trim();					//用户号码
	//String opCode = request.getParameter("opCode");						//操作代码
	String opCode = "e470";	
	String orgCode = request.getParameter("orgCode");					//归属代码
	String regionCode = (String)session.getAttribute("regCode");		//地市代码
	String iLoginAccept ="0";
	//String iChnSource  =request.getParameter("channelId");
	String iChnSource  ="01";
	String workno = (String)session.getAttribute("workNo");
	//String pwd = request.getParameter("pwd");
	String pwd ="";
	String nopass = (String)session.getAttribute("password");
	String[] inParas1 =new String[2];
	inParas1[0] = "select to_char(count(*)) from shighlogin_boss where login_no=:workno and op_code='e470' ";
	inParas1[1]="workno="+workno;

%>
	<wtc:service name="TlsPubSelBoss" retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/>
	</wtc:service>
	<wtc:array id="resultCount" scope="end" />
<%
	String errCode2 = retCode2;
	String errMsg2 = retMsg2;
	String count_1 = "";
	String i1="";
	if(resultCount!=null&&resultCount.length>0)
	{
		i1=resultCount[0][0];
		if(Integer.parseInt(i1)>=1)
		{
			count_1="0";
		}
		else
		{
			count_1="1";
		}
		
	}
	else
	{
		count_1="2";
	}
%>	
 
 
	var response = new AJAXPacket();
			
	response.data.add("flag1","<%=count_1%>");
	
 
	core.ajax.receivePacket(response);
 