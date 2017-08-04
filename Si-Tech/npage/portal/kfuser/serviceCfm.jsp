<%
  /*
   * 功能: 服务开通  
　 * 版本: 2.0
　 * 日期: 2006/06/05
　 * 作者: kouwb
　 * 版权: sitech
　 * 修改历史
   * 修改日期 2009-05-19     修改人  libina     修改目的  增加业务点击统计（报表）
   * 修改日期 2009-05-21     修改人  libina     修改目的  增加开通或取消特服时互斥校验
 　*/
%>
<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
	String retType = request.getParameter("retType");
	String phone_no = request.getParameter("phone_no");
	String login_no = request.getParameter("login_no");
	String passwd = request.getParameter("passwd");
	String op_code = request.getParameter("op_code");
	String op_note = request.getParameter("op_note");
	
	String op_rflag = request.getParameter("op_rflag");/*报表数据@操作方式@libina@20090519*/
	String servicedes = request.getParameter("servicedes");/*报表数据@业务ID@libina@20090519*/
	String SQL1 = "select to_char(sysdate,'yyyymm') from dual";/*报表数据@年月表@libina@20090519*/
	
	String service_str = request.getParameter("service_str");
	String parm1 = "1";
	
	String Strsql = "select to_char(sysdate,'yyyymmdd hh24:mi:ss') from dual";
	
	%>
	 var response = new AJAXPacket(); 
	 <wtc:pubselect name="sPubSelect" outnum="1">
  	 <wtc:sql><%=Strsql%></wtc:sql> 	
   </wtc:pubselect>
	 <wtc:array id="result" scope="end"/> 
	<%
	System.out.println(phone_no+"特服互斥校验开始");
	%>
	  <wtc:service name="sProdCond"  routerKey="region"  routerValue="<%=regionCode%>"  outnum="2">	  	
	  	<wtc:param value="<%=login_no%>"/>
	  	<wtc:param value="<%=phone_no%>"/>
	  	<wtc:param value="1270"/>
	  	<wtc:param value=""/>
	  	<wtc:param value="<%=servicedes%>"/>
	  	<wtc:param value="S"/>
	 <%
	   if("1".equals(op_rflag)){	
	 %>
	  	<wtc:param value="I"/>
	 <%
	   }else{
	 %>
	    <wtc:param value="D"/>
	 <%
	   }
	 %> 	
	    </wtc:service>
	 <%
	    System.out.println(phone_no+"特服互斥校验结束:"+retCode+"/"+retMsg);
      if("000000".equals(retCode) || "999999".equals(retCode)){
	     if("999999".equals(retCode)){
	 %>
	   response.data.add("retCode1","<%=retCode%>" );  
	   response.data.add("retMsg1","<%=retMsg%>" );   
	  <%   }
	 %>
 	     <wtc:service name="sHW_SpeOprt"  routerKey="region"  routerValue="<%=regionCode%>"  outnum="3">
	     	<wtc:param value="<%=phone_no%>"/>
	     	<wtc:param value="<%=login_no%>"/>
	     	<wtc:param value="<%=passwd%>"/>
	     	<wtc:param value="<%=op_code%>"/>
	     	<wtc:param value="<%=result[0][0]%>"/>
	     	<wtc:param value="<%=op_note%>"/>
	     	<wtc:param value="<%=parm1%>"/>
	     	<wtc:param value="<%=parm1%>"/>
	     	<wtc:param value="<%=service_str%>"/>
	     </wtc:service>
	     <wtc:array id="rs1"  scope="end"/>
	<%   
	    }

	  System.out.println(result[0][0]+" 报表记录开始@libina@20090519");
	  System.out.println("服务调用结果："+retCode+"/"+retMsg);
	  int successFlag = 1;
	  if("000000".equals(retCode)){
	     successFlag = 0;
	    }
	%>
	
	response.data.add("retType","<%=retType%>"); 
	response.data.add("retCode","<%=retCode%>" );  
	response.data.add("retMsg","<%=retMsg%>" );   
	
	<wtc:pubselect name="sPubSelect" outnum="1">
  	<wtc:sql><%=SQL1%></wtc:sql> 	
  </wtc:pubselect>
	<wtc:array id="result1" scope="end"/> 	
<%
  String SQL2 = "insert into DLOGMANOPR"+result1[0][0]+" values(sysdate,'"+phone_no+"','"+login_no+"','"+op_code+"',"+successFlag+",'"+servicedes+"','"+op_rflag+"','"+op_note+"')";
%>  
    <wtc:service name="sPubModify" outnum="3">
			<wtc:param value="<%=SQL2%>"/>
			<wtc:param value="dbcall"/>
		</wtc:service>
<%
  System.out.println("报表记录结束@libina@20090519");
%>    
                                                                                                                                                                                                             
	core.ajax.receivePacket(response);	 
