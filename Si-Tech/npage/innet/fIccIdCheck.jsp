<%
/********************
version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String loginNo =(String)session.getAttribute("workNo");
    	String ret_code  = "";				//错误代码 
    	String ret_message  = "";      		//错误消息      
    	String retType = request.getParameter("retType");
		String idIccid = request.getParameter("idIccid");
		String custName = request.getParameter("custName");
		String IccIdAccept = request.getParameter("IccIdAccept");	
		String opCode = request.getParameter("opCode");
		String phoneNo = request.getParameter("phoneNo");
		System.out.println("loginNo======================"+loginNo);
		System.out.println("idIccid======================"+idIccid);
		System.out.println("custName======================"+custName);
		System.out.println("IccIdAccept======================"+IccIdAccept);
		System.out.println("opCode======================"+opCode);
		System.out.println("phoneNo======================"+phoneNo);
%>
		<wtc:service name="sIccIdCheck"  retCode="retCode1" retMsg="retMsg1" outnum="2" >
		<wtc:param value="<%=IccIdAccept%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=idIccid%>"/>
		<wtc:param value="<%=custName%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%		
		if(result!=null&&result.length>0){
		  ret_code = (result[0][0]).trim(); 
			ret_message=(result[0][1]).trim(); 	
		}
		System.out.println("&ret_code->"+ret_code+"&ret_message->"+ret_message);
%>

		var response = new AJAXPacket();
		var retType = "";
		var retMessage="";
		var retCode="";
		retType = "<%=retType%>";
		retCode = "<%=ret_code%>";
		retMessage = "<%=ret_message%>";
		response.data.add("retType",retType);
		response.data.add("retCode",retCode);
		response.data.add("retMessage",retMessage);
		core.ajax.receivePacket(response);
		<%
		System.out.println("+++++++++++++++"+retType+"++++++++++++++++++");
		System.out.println("+++++++++++++++"+ret_code+"++++++++++++++++++");
		System.out.println("+++++++++++++++"+ret_message+"++++++++++++++++++");
		%>