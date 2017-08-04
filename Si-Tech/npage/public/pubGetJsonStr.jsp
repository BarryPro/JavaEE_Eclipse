<%
  /*
   * 功能: JSON解析公共页面
   * 版本: 1.0
   * 日期: 2011-11-8 8:15:06
   * 作者: zhangyan
   * 版权: si-tech
   * update:
  */	
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String jsonStr=	request.getParameter("jsonStr");
%>

<script>
	var jsonStr = '<%=jsonStr%>';
	var jsonObj = eval ("(" + jsonStr + ")");
	$(document).ready(function(){
		var where = "";
		for (var i in jsonObj )
		{
			where = where + "'"+i+"',"
		}	
		where = where.substring(0,where.length-1);
		var sql = "select param_key ,param_keydesc from smsgkeycfg "
			+"where param_key in ("+where+")";
		var myPacket = new AJAXPacket("/npage/public/pubParseJsonKey.jsp"
			,"获取预约信息......");
		myPacket.data.add("sql",sql);
		core.ajax.sendPacket(myPacket);
		myPacket = null;
	});
	
function doProcess(packet)
{
	self.status="";
	var jsonKeyNameStr=	packet.data.findValueByName("jasonKeyNames");
	var jsonKeyNames = eval ("(" + jsonKeyNameStr + ")");

	var jsonTab = $("#jsonTab");

	for (var i in jsonObj )
	{
		for ( var j in  jsonKeyNames  )
		{
			if ( i==j )
			{
				jsonTab.append("<tr><th class = blue>"+jsonKeyNames[j]+"</th><td>"+jsonObj[i]+"</td></tr>");
			}
		}
	}		
}


</script>

<body>
<table  id  = "jsonTab">
	
</table>
</body>