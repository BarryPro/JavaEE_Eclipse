<%
  /*
   * 功能: 预定义短信界面树形数据生成页面
　 * 版本: 1.0.0
　 * 日期: 2009/01/19
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0);

String object_id = request.getParameter("object_id");
if(object_id == null){
	object_id = "01";
}
String content_id = request.getParameter("content_id");
if(content_id == null){
	content_id = "02";
}
String parent_item_id = request.getParameter("parent_item_id").split("_")[0];
if(parent_item_id == null){
	parent_item_id = "0";
}

 String sqlStr="select a.msg_mod_id || '_' || b.msg_mod_content_id,a.msg_mod_par_id,a.msg_mod_name || '--' || b.msg_mod_content,a.msg_leaf_flag from DMESSAGEMODEL a, DMESSAGEMODELCONTENT b "+
               "where a.is_del = 'N' and trim(a.msg_mod_par_id)='" + parent_item_id.trim() + "' and a.msg_mod_id = b.msg_mod_id(+) " +
               "order by a.msg_mod_id";
 
%>

<wtc:service name="s151Select" outnum="6">
	<wtc:param value="<%=sqlStr %>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="6" >

var worknos = new Array();
<%
	for(int i = 0; i < resultList.length; i++){%>
    var tmpArr = new Array();
	<%for(int j = 0; j < resultList[i].length; j++){%>
		tmpArr[<%=j%>] = '<%=resultList[i][j] %>';
	<%}%>
	worknos[<%=i%>] = tmpArr;
<%}%>

var response = new AJAXPacket();
response.data.add("worknos",worknos);
response.data.add("nodeId","<%=parent_item_id %>");
core.ajax.receivePacket(response);

</wtc:array>

