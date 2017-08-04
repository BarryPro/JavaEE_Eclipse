<%/**
	* 功能: 
	* 版本: 1.8.2
	* 日期: 2010/12/1
	* 作者: wanglm
	* 版权: sitech
	*/
	%>
<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String dingdanType = request.getParameter("dingdanType");
    System.out.println(".................................... dingdanType    " + dingdanType);
    String dingdanSel = request.getParameter("dingdanSel");
    String dtime = request.getParameter("dtime");
    String fl = "";
    System.out.println(".................................... dingdanSel    " + dingdanSel);
    if(dingdanSel.equals("1")){
        fl = request.getParameter("dingdanNum");
    }else if(dingdanSel.equals("2")){
    	fl = request.getParameter("kuandaiNum");
    }else if(dingdanSel.equals("0")){
    	fl = request.getParameter("gonghao");
    }else{
        fl = request.getParameter("phoneNum");	
    }
    System.out.println(".................................... fl    " + fl);
    
%>
    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
    	
  <wtc:service name="sQryOrderInfo" routerKey="regioncode" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="12">
    <wtc:param value="<%=seq%>"/>
    <wtc:param value="0"/>
    <wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=dingdanType%>"/>
		<wtc:param value="<%=dingdanSel%>"/>
		<wtc:param value="<%=fl%>"/>
		<wtc:param value="<%=dtime%>"/>
	</wtc:service>
    <wtc:array id="result1" start="0" length="2" scope="end"/>
		<wtc:array id="result2" start="2" length="10" scope="end"/>	
	<%
	
		
	for(int iii=0;iii<result2.length;iii++){
		for(int jjj=0;jjj<result2[iii].length;jjj++){
			System.out.println("---------------------result2["+iii+"]["+jjj+"]=-----------------"+result2[iii][jjj]);
		}
	}
	   String[][] res = result2;
	   if("000000".equals(retCode)){
	      request.setAttribute("result",res);
	      request.getRequestDispatcher("fd008_show.jsp").forward(request, response);
	   }else{
	   	%>
	   	    <script language="javascript">
	   	    	rdShowMessageDialog("错误信息  <%=retMsg%>  错误代码 <%=retCode%> ");
	        	window.location = "fd008.jsp";
	        </script> 
	   	<%
	   	}
	%>
    
