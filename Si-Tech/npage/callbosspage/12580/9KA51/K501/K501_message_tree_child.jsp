<%
  /*
   * 功能: 预定义短信界面树形数据生成页面
　 * 版本: 1.0.0
　 * 日期: 2009/01/15
　 * 作者: fengliang
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%

String parent_item_id = request.getParameter("parent_item_id");
if(parent_item_id == null){
	parent_item_id = "0";
}

 String sqlStr="select a.msg_mod_id,a.msg_mod_par_id,a.msg_mod_name,a.msg_leaf_flag, b.msg_mod_content from DMESSAGEMODEL a, DMESSAGEMODELCONTENT b "+
               "where a.is_del = 'N' and a.msg_mod_id = b.msg_mod_id(+) and trim(a.msg_mod_par_id)='" + parent_item_id.trim() + "' " +
               "order by a.msg_mod_id";
%>

<wtc:service name="s151Select" outnum="5">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="5" >

var worknos = new Array();
<%for(int i = 0; i < resultList.length; i++){%>
    var tmpArr = new Array();
	<%for(int j = 0; j < resultList[i].length; j++){%>
		tmpArr[<%=j%>] = '<%=resultList[i][j]%>'+'<%=resultList[resultList.length-1][j]%>';
	<%}%>
	worknos[<%=i%>] = tmpArr;
<%}%>

var response = new AJAXPacket();
response.data.add("worknos",worknos);
response.data.add("nodeId","<%=parent_item_id%>");
core.ajax.receivePacket(response);

</wtc:array>

