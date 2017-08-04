<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
/*modify by yinzx 0922 合并山西版本*/
 /*midify by yinzx 20091113 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
String nodeId = request.getParameter("nodeId");
 String manage=request.getParameter("manage");
    	if(manage==null||manage.equals("")){
         manage ="0";
      }
String sqlStrPlus ="";
if(manage.equals("0")){
	sqlStrPlus = "and visible='1'";
}
 String sqlStr="select t.callcause_id,t.super_id,t.caption,t.is_leaf,t.fullname,t.cityid,t.causedes,to_char(t.visible) from DCALLCAUSECFG t where 1=1 and t.super_id=:nodeId  and t.is_del='N' "+sqlStrPlus+"  order by t.callcause_id";
 myParams="nodeId="+nodeId;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="8" >
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
