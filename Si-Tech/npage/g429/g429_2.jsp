<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 投诉退费查询-根据界面查询信息
　 * 版本: v3.0
　 * 日期: 2009-08-10
　 * 作者: zhangshuaia
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
		<%@ page contentType="text/html;charset=GBK"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/public/checkPhone.jsp" %>

<%
		/**需要清楚缓存.如果是新页面,可删除**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "g429";
 		String opName = "银行卡签约客户解约";
		 
		/**需要regionCode来做服务的路由**/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
 
		//xl add for 用户密码
  
	String custPass = request.getParameter("custPass");
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAaa custPass is "+custPass);
	custPass = Encrypt.encrypt(custPass);
	

%>
	 
<%
		 					
		
		String op_code = WtcUtil.repNull(request.getParameter("op_code"));
		String begin_time = WtcUtil.repNull(request.getParameter("begin_time"));
		String end_time = WtcUtil.repNull(request.getParameter("end_time"));	
		String login_no = (String)session.getAttribute("workNo");
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		String phone_no = WtcUtil.repNull(request.getParameter("phone_no"));			
		String nopass = (String)session.getAttribute("password"); 
		System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbb custPass is "+custPass+" and nopass is "+nopass);  
		 
		String[][] result1  = null ;
%>
		<wtc:service name="sg429Cfm"  routerKey="region"  routerValue="<%=regionCode%>" retcode="retCode5" retmsg="retMsg5" outnum="16"> 
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value="<%=custPass%>"/>
			<wtc:param value="<%=login_no%>"/>
			<wtc:param value="<%=nopass%>"/>
		</wtc:service> 
		<wtc:array id="sVerifyTypeArr1" start="0" length="2" scope="end"/> 
 
<%	
result1 = sVerifyTypeArr1;
System.out.println("retCode===="+retCode5);
System.out.println("retMsg===="+retMsg5);
System.out.println("SSSSSSSSSSSSSSSSSSSSSSSSSS result1.length=" + result1.length);
	if(retCode5=="000000" ||retCode5.equals("000000") )
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("用户解约成功!");
				window.location="g429_1.jsp";
			</script>
		<%
		
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("用户解约失败!"+"错误代码："+"<%=retCode5%>"+"，错误原因："+"<%=retMsg5%>");
				window.location="g429_1.jsp";
			</script>
		<%
	}
	
%>
 
 