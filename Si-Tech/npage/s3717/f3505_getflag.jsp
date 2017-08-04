<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<% 
String sm_code = request.getParameter("sm_code");
String retType = request.getParameter("retType");
String service_name = "";
int errCode = 0;
String errMsg = "";

String createFlag = "";
String pay_flag = "";

			String[] paraAray = new String[1];
			String[] retList = new String[] {  };
			SPubCallSvrImpl impl = new SPubCallSvrImpl();
			//得到create_flag
			String sql = 
			"select create_flag from sBusiTypeSmCode where busi_type='1000' and sm_code='"+sm_code+ "'";

			service_name = "sPubSelect";
			paraAray[0] = sql;
			retList = impl.callService(service_name, paraAray, "1");
			
			if (errCode == 0) {
				   if ((retList == null) || (retList.length == 0)) {
					   errCode=1;
					   errMsg = "create_flag查询为空!";

				    }else{
				         createFlag = retList[0];
				       }
			}else{
					   errCode=1;
					   errMsg = "create_flag查询失败!";
				  }
		System.out.println(">>>>>> createFlag="+createFlag);
		    //得到pay_flag
			sql = "select pay_flag from sGrpSmCode where sm_code='"+sm_code+ "'";
			service_name = "sPubSelect";
			paraAray[0] = sql;
			retList = impl.callService(service_name, paraAray, "1");

			errCode = impl.getErrCode();
			errMsg = impl.getErrMsg();

			if (errCode == 0) {
				   if ((retList == null) || (retList.length == 0)) {
					   errCode=1;
					   errMsg = "pay_flag查询为空!";

				    }else{
				         pay_flag = retList[0];
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

