<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%

String nodeId = request.getParameter("nodeId");
/*midify by yinzx 20091113 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
 String sqlStr="select t.callcause_id,t.super_id,t.caption,t.is_leaf,t.fullname from DCALLCAUSECFG t where 1=1 and t.super_id=:nodeId  and t.is_del='N'and visible='1' order by t.callcause_id";
 myParams="nodeId="+nodeId;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="5" >
//<%
//System.out.println("$$$$$$$$$$$$$2222222$$$$$$$$$$$$$$$$$");
//for(int i = 0; i < resultList.length; i++){
//	for(int j = 0; j < resultList[i].length; j++){
//	System.out.println(resultList[i][j]);
//	}
//}
//System.out.println("$$$$$$$$$$$$$$2222222$$$$$$$$$$$$$$$$");
//%>
var worknos = new Array();
<%for(int i = 0; i < resultList.length; i++){%>
    var tmpArr = new Array();
	<%for(int j = 0; j < resultList[i].length; j++){%>
		tmpArr[<%=j%>] = '<%=resultList[i][j]%>';
	<%}%>
	worknos[<%=i%>] = tmpArr;
<%}%>
var response = new AJAXPacket();
response.data.add("worknos",worknos);
response.data.add("nodeId","<%=nodeId%>");
core.ajax.receivePacket(response);

</wtc:array>
