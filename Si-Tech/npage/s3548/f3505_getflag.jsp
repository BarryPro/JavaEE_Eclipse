   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-11
********************/
%>
      
<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<% 
String sm_code = request.getParameter("sm_code");
String retType = request.getParameter("retType");
String service_name = "";

String errCode = "";
String errMsg = "";

String createFlag = "";
String pay_flag = "";
String regionCode = (String)session.getAttribute("regCode");
			//得到create_flag
			String sql = 
			"select create_flag from sBusiTypeSmCode where busi_type='1000' and sm_code='"+sm_code+ "'";

			//retList = impl.callService(service_name, paraAray, "1");
			%>
			
		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
			
			<%
			if (code.equals("000000")) {
				   if ((result_t == null) || (result_t.length == 0)) {
					   errCode="1";
					   errMsg = "create_flag查询为空!";

				    }else{
				         createFlag = result_t[0][0];
				       }
			}else{
					   errCode="1";
					   errMsg = "create_flag查询失败!";
				  }
		System.out.println(">>>>>> createFlag="+createFlag);
		    //得到pay_flag
			sql = "select pay_flag from sGrpSmCode where sm_code='"+sm_code+ "'";
			//retList = impl.callService(service_name, paraAray, "1");
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>


<%
			errCode =code;
			errMsg = msg;

			if (errCode.equals("000000")) {
				   if ((result_t2 == null) || (result_t2.length == 0)) {
					   errCode="1";
					   errMsg = "pay_flag查询为空!";

				    }else{
				         pay_flag = result_t2[0][0];
				       }
			}else{
					   errCode="1";
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

response.data.add("retType",retType);
response.data.add("retCode",errCode);
response.data.add("retMsg",retMsg);
response.data.add("createFlag",createFlag);
response.data.add("pay_flag",pay_flag);

core.ajax.receivePacket(response);

<%System.out.println("-----------------------errCode-----------------------f3505_getflag.jsp"+errCode);%>