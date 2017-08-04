<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-19
 ********************/
%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% 
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String sm_code = request.getParameter("sm_code");
    String retType = request.getParameter("retType");
    String service_name = "";
    int errCode = 0;
    String errMsg = "";
    
    String createFlag = "";
    String pay_flag = "";

	String[] paraAray = new String[1];
	String [] paraIn = new String[2];
	String[] retList = new String[] {  };
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//得到create_flag
	String sql = 
	"select create_flag from sBusiTypeSmCode where busi_type='1000' and sm_code=:sm_code";

	//service_name = "sPubSelect";
	//paraAray[0] = sql;
	//retList = impl.callService(service_name, paraAray, "1");
	
	
	paraIn[0] = sql;    
    paraIn[1]="sm_code="+sm_code;
    %>
    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
    	<wtc:param value="<%=paraIn[0]%>"/>
    	<wtc:param value="<%=paraIn[1]%>"/> 
    </wtc:service>
    <wtc:array id="retArr1" scope="end"/>
    <%
    
	if (errCode == 0) {
		   if (!(retCode1.equals("000000")) || (retArr1.length == 0)) {
			   errCode=1;
			   errMsg = "create_flag查询为空!";

		    }else{
		         createFlag = retArr1[0][0];
		    }
	}else{
			   errCode=1;
			   errMsg = "create_flag查询失败!";
		  }
System.out.println(">>>>>> createFlag="+createFlag);
    //得到pay_flag
	sql = "select pay_flag from sGrpSmCode where sm_code=:sm_code";
	
	//service_name = "sPubSelect";
	//paraAray[0] = sql;
	//retList = impl.callService(service_name, paraAray, "1");

    paraIn[0] = sql;    
    paraIn[1]="sm_code="+sm_code;
    %>
    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1" >
    	<wtc:param value="<%=paraIn[0]%>"/>
    	<wtc:param value="<%=paraIn[1]%>"/> 
    </wtc:service>
    <wtc:array id="retArr2" scope="end"/>
    <%
    
	errCode = Integer.parseInt(retCode2);
	errMsg = retMsg2;

	if (errCode == 0) {
		   if (!(retCode2.equals("000000")) || (retArr2.length == 0)) {
			   errCode=1;
			   errMsg = "pay_flag查询为空!";

		    }else{
		         pay_flag = retArr2[0][0];
		       }
	}else{
			   errCode=1;
			   errMsg = "pay_flag查询失败!";
		  }

%>

var response = new AJAXPacket();
var retType = "";
var errCode = "";
var retMsg = "";
var createFlag = "";
var pay_flag = "";

retType = "<%=retType%>";
errCode = "<%=errCode%>";
retMsg = "<%=errMsg%>";
createFlag = "<%=createFlag%>";
pay_flag = "<%=pay_flag%>";

response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType",retType);
response.data.add("retCode",errCode);
response.data.add("retMsg",retMsg);
response.data.add("createFlag",createFlag);
response.data.add("pay_flag",pay_flag);

core.ajax.receivePacket(response);

