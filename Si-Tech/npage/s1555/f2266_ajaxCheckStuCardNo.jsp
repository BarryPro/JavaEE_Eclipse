<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
*
*create:wanglma@2011-05-25
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>

<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode = (String)session.getAttribute("regCode");
  String stuCardNo = request.getParameter("stuCardNo");
  String sql = " select count(*) from DNORMALSTUDENTID where YIKATONG_COUTRACTNO= '"+stuCardNo+"' and COLLEGE_NO='0001' ";
  String sql1 = " select count(*)   from WAWARDADD where FIELD_VALUE='"+stuCardNo+"'  and	FIELD_CODE='00003'";
  String flag = "0"; 
	%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1" >
        <wtc:sql><%=sql%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="result"  scope="end"/>
        
        <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
        <wtc:sql><%=sql1%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="result1"  scope="end"/>
	<%
	if(retCode.equals("000000") && result.length > 0 ) {
	    flag = result[0][0];
	}
	if(retCode1.equals("000000") && result1.length > 0){
	    if("1".equals(result1[0][0])){
	       flag = "2";
	    }
	}
%>

var response = new AJAXPacket();
response.data.add("retCode", "<%=retCode%>");
response.data.add("retMsg", "<%=retMsg%>");
response.data.add("flag", "<%=flag%>");
core.ajax.receivePacket(response);
