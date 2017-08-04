<%
/********************
 version v2.0
开发商: si-tech
*
*create:wanglma@2011-05-18 
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>

<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode = (String)session.getAttribute("regCode");
  String phoneNo = request.getParameter("phoneNo");
  System.out.println("-----------------------------phoneNo------------------------------------------------------"+phoneNo);
  String sql = "select a.member_role_id from group_instance_member a,dcustmsg b "+
               "where  a.member_role_id in (11100,11101) "+
               "and a.serv_id = b.id_no "+
               "and b.phone_no ='"+phoneNo+"' "+
               "AND add_months(sysdate, 1) < a.exp_date";
  String flag = ""; 
  System.out.println("-----------------------------phoneNo------------------------------------------------------"+phoneNo);
	%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1" >
        <wtc:sql><%=sql%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="result"  scope="end"/>
	<%
	if(retCode.equals("000000") && result.length > 0) {
	    if("11100".equals(result[0][0])){
	       flag = "1"; // 家长
	    }else if("11101".equals(result[0][0])){
	       flag = "0"; //成员
	    }
	}else if(retCode.equals("000000") && (result.length < 1)){
		flag = "2"; //其它群组
	}
	System.out.println("-----------------------------------------------------------------------------------");
%>

var response = new AJAXPacket();
response.data.add("retCode", "<%=retCode%>");
response.data.add("retMsg", "<%=retMsg%>");
response.data.add("flag", "<%=flag%>");
core.ajax.receivePacket(response);
