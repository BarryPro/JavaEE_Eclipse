<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
    String retType = WtcUtil.repNull(request.getParameter("retType"));
    String caller = WtcUtil.repNull(request.getParameter("caller"));
    String sqlUserType ="select b.fav_brand, substr(a.ATTR_CODE, 3, 2) from dcustmsg a, ssmcode b where phone_no =:caller  and b.region_code = substr(a.belong_code, 1, 2) and a.sm_code = b.sm_code";
    myParams="caller="+caller;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
<wtc:param value="<%=sqlUserType%>"/>		
<wtc:param value="<%=myParams%>"/>		
</wtc:service>
<wtc:array id="row" scope="end" />

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
<%if(row.length>0){%>
response.data.add("userType","<%=row[0][0]%>");
response.data.add("userClass","<%=row[0][1]%>");
<%}else{%>
response.data.add("userType","200");
response.data.add("userClass","200");
<%}%>
core.ajax.receivePacket(response);




