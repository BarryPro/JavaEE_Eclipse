<%
  /*
   * 功能: 选号释放
　 * 版本: 2.0
　 * 日期: 2007-07-05 16:12
　 * 作者: wangxz
　 * 版权: sitech
　*/
%> 
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>



<%
  	String errCode_1="444444";    //对服务080002
 	 	String errMessage_1="系统错误，请与系统管理员联系，谢谢!!";   
		String retType=request.getParameter("retType");	
		String NUM=request.getParameter("NUM");
		String[] number=NUM.split("~");
		String CITY_ID=request.getParameter("CITY_ID");
		String BRANCH_ID=request.getParameter("BRANCH_ID");
		String OBJECT_TYPE=request.getParameter("OBJECT_TYPE");
		String STAFF_ID=request.getParameter("STAFF_ID");
		String SITE_ID=request.getParameter("SITE_ID");
		String NUM_TYPE=request.getParameter("NUM_TYPE");
%>
  	<wtc:service name="MRM_YZ_0001" outnum="0">
		<wtc:param  value="<%=NUM%>"/>
		<wtc:param  value="<%=BRANCH_ID%>"/>
		<wtc:param  value="1"/>
		<wtc:param  value="<%=STAFF_ID%>"/>
		<wtc:param  value="<%=SITE_ID%>"/>
		<wtc:param  value="<%=NUM_TYPE%>"/>
		<wtc:param  value=""/>
		<wtc:param  value="<%=CITY_ID%>"/>
		<wtc:param  value=""/>
		<wtc:param  value=""/>
		<wtc:param  value=""/>
		<wtc:param  value=""/>
		<wtc:param  value=""/>
		<wtc:param  value=""/>
		<wtc:param  value=""/>
		<wtc:param  value=""/>
	</wtc:service>
		
	<%if(retCode.equals("000000"))
	{
		errCode_1="000000";
		errMessage_1=retMsg;		
	}
	else
	{
		errCode_1=retCode;
		errMessage_1=retMsg;
	}%>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("errCode_1","<%= errCode_1 %>");
response.data.add("errMessage_1","<%= errMessage_1 %>");

core.ajax.receivePacket(response);