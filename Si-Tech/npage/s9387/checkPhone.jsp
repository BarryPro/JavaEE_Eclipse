<%
  /*
   * 模块: WLAN静态密码修改
　 * 版本: v1.00
　 * 日期: 2010-11-4
　 * 作者: haoyy
　 * 版权: sitech
   * 功能：用户号码验证
   * 修改历史
   * 修改日期      修改人      修改目的
   *
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% request.setCharacterEncoding("GBK");%>


<%@ page import="com.sitech.boss.pub.util.*" %>

<%
	String phone = request.getParameter("phone");
	String sqlStr="select count(*) from dcustmsg where phone_no='"+phone+"'";
	System.out.println("=========================================================");
	System.out.println("sqlStr====="+sqlStr);
	String orgCode = (String)session.getAttribute("orgCode");
   	String regionCode = orgCode.substring(0,2);
	String count1="0";

		%>
		    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result1" scope="end" />
		<%


		  if(retCode1.equals("0")||retCode1.equals("000000"))
		  {
		  	System.out.println("调用服务sPubSelect in .jsp 成功!");
			count1=result1[0][0];

 	      }else{
 	         System.out.println(retCode1+"    retCode1");
 	     	 System.out.println(retMsg1+"    retMsg1");
 			 System.out.println("验证用户号码调用服务sPubSelect失败!");
 		  }
 		  System.out.println("==================count1====="+count1);
%>


var response = new AJAXPacket();
response.data.add("count","<%=count1 %>");
core.ajax.receivePacket(response);
