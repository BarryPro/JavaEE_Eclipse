<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-16
 ********************/
%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% 
String cust_id = request.getParameter("cust_id");
String retType = request.getParameter("retType");
String service_name = "";
int errCode = 0;
String errMsg = "";

String custAddress = "";

			String[] paraAray = new String[2];
			String[] retList = new String[] {  };
			//SPubCallSvrImpl impl = new SPubCallSvrImpl();

			String sql = "select cust_address from dCustDoc where cust_id =:cust_id";

			//service_name = "spubqrycode32";
			//service_name = "sPubSelect";
			
			paraAray[0] = sql;
			paraAray[1]="cust_id="+cust_id;

			//retList = impl.callService(service_name, paraAray, "1");
%>
<wtc:service name="TlsPubSelCrm" retcode="retCode2" retmsg="retMsg2" outnum="1" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/> 
</wtc:service>
<wtc:array id="retArr2" scope="end"/>
<%
    errCode = Integer.parseInt(retCode2);
    errMsg = retMsg2;		
			
	if (errCode == 0) {
		   if ((retArr2 == null) || (retArr2.length == 0)) {
			   errCode=1;
			   errMsg = "客户地址不存在!";

		    }else{
		         custAddress = retArr2[0][0];
		       }
	}else{
			   errCode=1;
			   errMsg = "获取客户地址失败!";
		  }

%>

var response = new AJAXPacket();
var retType = "";
var errCode = "";
var retMsg = "";
var custAddress = "";

retType = "<%=retType%>";
errCode = "<%=errCode%>";
retMsg = "<%=errMsg%>";
custAddress = "<%=custAddress%>";

response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType",retType);
response.data.add("retCode",errCode);
response.data.add("retMsg",retMsg);
response.data.add("custAddress",custAddress);

core.ajax.receivePacket(response);

