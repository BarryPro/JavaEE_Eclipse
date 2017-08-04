<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-07 页面改造,修改样式
     *
     ********************/
%>
		<%@ page contentType= "text/html;charset=gb2312" %>
		<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String ret_code  = "";				//错误代码 
    String ret_message  = "";      		//错误消息         
    String sysAccept = "000000";
  	String retType = request.getParameter("retType");
    String sqlStr ="select to_char(sMaxSysAccept.nextval) from dual";
		String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);		    
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retCode="retCode1" retMsg="retMsg1" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
<%
    sysAccept = result.length>0?(result[0][0]).trim():sysAccept;
		System.out.println("sysAccept="+sysAccept);
    ret_code = retCode1; 
    ret_message = retMsg1;         
%>

		var response = new AJAXPacket();
		var retType = "";
		var sysAccept = "";
		retType = "<%=retType%>";
		retCode = "<%=ret_code%>";
		retMessage = "<%=ret_message%>";
		sysAccept = "<%=sysAccept%>";
		response.data.add("retType",retType);
		response.data.add("retCode",retCode);
		response.data.add("retMessage",retMessage);
		response.data.add("sysAccept",sysAccept);
		core.ajax.receivePacket(response);