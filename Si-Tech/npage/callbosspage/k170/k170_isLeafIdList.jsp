<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!
	public String returnStrSql(String strNodeIdList){
		String [] strTempArr = new String[0];
		if(strNodeIdList!=null){
			strTempArr=strNodeIdList.split(",");
		}
	     String strTemp="";
	     for (int i=0;i<strTempArr.length;i++){
	    	strTemp+="'"+strTempArr[i];
	    	if(i==strTempArr.length-1){
	    		strTemp+="'";
	    	}else{
	    		strTemp+="',";
	    	} 
	     }
	     return strTemp;
	}
%>
<%
/*midify by yinzx 20091113 公共查询服务替换*/
 
 		String org_code = (String)session.getAttribute("orgCode");
 		String regionCode = org_code.substring(0,2);
String selectNodeIDList = request.getParameter("selectNodeIDList");
System.out.println("selectNodeIDList_______________:"+selectNodeIDList);
String sqlStr="select t.callcause_id,t.super_id,t.caption,t.is_leaf,t.fullname from DCALLCAUSECFG t where t.is_leaf='1'and t.callcause_id in("+returnStrSql(selectNodeIDList)+") order by t.callcause_id";
System.out.println("sqlStr___:"+sqlStr);
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%> outnum="5">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="5">
<%
//System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
//for(int i = 0; i < resultList.length; i++){
//	for(int j = 0; j < resultList[i].length; j++){
//		System.out.println(resultList[i][j]);
//	}
//}
//System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
%>
var ieafList = new Array();
<%for(int i = 0; i < resultList.length; i++){%>
    var tmpArr = new Array();
	<%for(int j = 0; j < resultList[i].length; j++){%>
		tmpArr[<%=j%>] = '<%=resultList[i][j]%>';
	<%}%>
	ieafList[<%=i%>] = tmpArr;
<%}%>
var response = new AJAXPacket();
response.data.add("ieafList",ieafList);
core.ajax.receivePacket(response);

</wtc:array>
