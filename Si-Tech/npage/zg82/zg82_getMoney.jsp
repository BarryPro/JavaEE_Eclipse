<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
		String regionCode= (String)session.getAttribute("regCode"); 
	
	  String card_no = request.getParameter("card_no");
	  String printAccept = request.getParameter("printAccept");
		//String remark = request.getParameter("remark");	  
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa card_no is "+card_no);	  	  	  	  

		String[] inParas2 = new String[2];
		inParas2[0]="select to_char(sMaxSysAccept.nextval),to_char(card_money) from dchncardres where card_no =:s_no";
		inParas2[1]="s_no="+card_no;
		String card_money="";
		String loginAccept="";
		String s_flag="";//0=ok 1=无值
%>
 
	<wtc:service name="TlsPubSelCrm"  outnum="2" >
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>
	</wtc:service>
	<wtc:array id="resuleArr" scope="end" />
<%
		if(resuleArr!=null&&resuleArr.length>0){
			s_flag="0";
			loginAccept=printAccept;
			card_money=resuleArr[0][1];
		}
		else
		{
			s_flag="1";
		}
	%>
var response = new AJAXPacket();
var s_flag =   "<%=s_flag%>";
var loginAccept =   "<%=loginAccept%>";
var card_money =   "<%=card_money%>";
response.data.add("loginAccept",loginAccept); 
response.data.add("s_flag",s_flag); 
response.data.add("card_money",card_money);
core.ajax.receivePacket(response);



 
