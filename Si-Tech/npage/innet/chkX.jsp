<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-22 页面改造,修改样式
*
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String ret_code  = "";				//错误代码 
    String ret_message  = "";      		//错误消息         
	  String retType = request.getParameter("retType");
		String retObj=request.getParameter("retObj");
		
		String x_idType=request.getParameter("x_idType");
		String x_idNo=request.getParameter("x_idNo");
		String x_chkKind=request.getParameter("x_chkKind");
		//retArray = callView.chkX(x_idType,x_idNo,x_chkKind);
%>
		<wtc:service name="sPubChkBlackOwe"  retCode="retCode1" retMsg="retMsg1" outnum="2" >
		<wtc:param value="<%=x_idType%>"/>
		<wtc:param value="<%=x_idNo%>"/>
		<wtc:param value="<%=x_chkKind%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%		
		if(result!=null&&result.length>0){
		  ret_code = (result[0][0]).trim(); 
			ret_message=(result[0][1]).trim(); 	
		}
		System.out.println("#############################retObj->"+retObj+"&ret_code->"+ret_code+"&retType->"+retType+"&retMessage->"+ret_message+"&retObj->"+retObj);
%>

		var response = new AJAXPacket();
		var retType = "";
		var retObj = "";
		var retMessage="";
		var retCode="";
		retType = "<%=retType%>";
		retCode = "<%=ret_code%>";
		retMessage = "<%=ret_message%>";
		retObj = "<%=retObj%>";
		response.data.add("retType",retType);
		response.data.add("retCode",retCode);
		response.data.add("retMessage",retMessage);
		response.data.add("retObj",retObj);
		core.ajax.receivePacket(response);