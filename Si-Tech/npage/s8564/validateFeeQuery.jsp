<%
/********************
 * version v2.0
 * 功能：验证用户信息信息（对045*，046*等铁通号码的限制）
 * 开发商: si-tech
 * update by huangrong @ 2011-4-20
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%
    String errCode = "";
    String errMsg = "";
    String no_type= "";
    String work_no = (String)session.getAttribute("workNo");
    String orgCode = (String) session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0, 2);
		String phoneNo = request.getParameter("phoneNo");
		String sqlStr1="select NO_TYPE  from dcustres where phone_no='"+phoneNo+"' ";
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1" retcode="retCode" retmsg="retMsg">
   <wtc:sql><%=sqlStr1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>

<%
	errCode = retCode;
  errMsg = retMsg;
  if(errCode.equals("000000"))
  {
		if(result!=null && result.length>0)
		{
			no_type= result[0][0];
		}
	}	
%>

var response = new AJAXPacket();
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>");
response.data.add("no_type","<%=no_type%>");
core.ajax.receivePacket(response);



