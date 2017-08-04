<%
  /*
   * 功能: 获得指定节点下的所有子节点
　 * 版本: 1.0.0
　 * 日期: 2009/04/07
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%

String object_id = WtcUtil.repNull(request.getParameter("object_id"));
if("".equals("object_id")){
	object_id = "01";
}
String content_id = WtcUtil.repNull(request.getParameter("content_id"));
if("".equals("content_id")){
	content_id = "02";
}
String parent_item_id = WtcUtil.repNull(request.getParameter("parent_item_id"));
if("".equals("parent_item_id")){
	parent_item_id = "0";
}

String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
	
String sqlStr = "select t.item_id, t.parent_item_id, t.item_name, t.is_leaf, t.is_scored,t.object_id " +
                "from dqccheckitem t "+
                "where trim(t.parent_item_id)=:parent_item_id and object_id = :object_id and contect_id = :content_id  and bak1='Y' " +
                "order by t.item_id desc";
myParams = "parent_item_id="+parent_item_id.trim()+",object_id="+object_id+",content_id="+content_id;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="6">

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
response.data.add("nodeId","<%=parent_item_id%>");
core.ajax.receivePacket(response);

</wtc:array>