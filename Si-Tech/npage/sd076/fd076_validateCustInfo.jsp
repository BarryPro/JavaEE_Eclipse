<%
/********************
 * version v2.0
 * 功能：验证用户信息
 * 开发商: si-tech
 * create by huangrong @ 2011-04-07
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%
    String errCode = "";
    String errMsg = "";  
    String result_long ="";
    String orgCode = (String) session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0, 2);
 		String custName = request.getParameter("custName");   
    String but = request.getParameter("but"); 		
    String custMobilePhone = request.getParameter("custMobilePhone");
    String sqlStr2 = " select count(*) from dcustmsg a, dcustdoc b where a.cust_id = b.cust_id  and substr(a.run_code, 2, 1) = 'A'  and a.phone_no = '"+custMobilePhone+"' --and Trim(b.cust_name) = '"+custName+"'";
		System.out.println("======sqlStr2==============jason====="+sqlStr2);
%>
    <wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1" >
    	<wtc:param value="<%=sqlStr2%>"/>
    </wtc:service>
    <wtc:array id="resultStr" scope="end"/>
<%
  errCode = retCode;
  errMsg = retMsg;
  if(errCode.equals("000000"))
  {
  	if(resultStr!=null && resultStr.length>0)
  	{
    	result_long=resultStr[0][0]+"";
  	}else
  		{
    	 result_long="0";  		
  		}
  }

%>

var result_long="<%=result_long%>";
var response = new AJAXPacket();
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>");
response.data.add("but","<%=but%>");  
response.data.add("result_long",result_long);
core.ajax.receivePacket(response);




