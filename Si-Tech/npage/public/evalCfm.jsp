<%
 /**
 * 作者:zhaohaitao
 * 日期:2008.12.2
 * 模块:积分兑换
 **/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String [] inPubParams= new String [6];

	inPubParams[0] = request.getParameter("vLoginNo");
	inPubParams[1] = request.getParameter("vOpCoce");
	inPubParams[2] = request.getParameter("vPhoneNo");
	inPubParams[3] = request.getParameter("vEvalValue");
	inPubParams[4] = request.getParameter("vLoginAccept");
	inPubParams[5] = "0";
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//String [] backInfo = impl.callService("sCommEvalCfm", inPubParams, "3", "phoneno", inPubParams[5]);
	
%>
	<wtc:service name="sCommEvalCfm" routerKey="phone" routerValue="<%=inPubParams[2]%>" retcode="retCode" retmsg="retMsg" outnum="3" >
	<wtc:param value="<%=inPubParams[0]%>"/>
    <wtc:param value="<%=inPubParams[1]%>"/>
	<wtc:param value="<%=inPubParams[2]%>"/>
	<wtc:param value="<%=inPubParams[3]%>"/>
	<wtc:param value="<%=inPubParams[4]%>"/>
	<wtc:param value="<%=inPubParams[5]%>"/>
	</wtc:service>
	//<wtc:array id="tempArr" scope="end"/>
<%								   
	String  errCode = retCode;
	String  errMsg = retMsg;
	System.out.println("errCode=============" + errCode);
	System.out.println("errMsg=============" + errMsg);
%>

var response = new RPCPacket();

//response.guid = '<%= request.getParameter("guid") %>';
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
core.rpc.receivePacket(response);

