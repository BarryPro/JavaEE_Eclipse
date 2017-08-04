
<%
  /*
   * 功能: 常用网址维护页面
　 * 版本: 1.0
　 * 日期: 2013/03/06
　 * 作者: liuhaoa
　 * 版权: sitech
 　*/
 %>
 
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*,java.text.SimpleDateFormat,com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<html>
<head>
	<style>
		img{
				cursor:hand;
		}
		input{
			height: 1.6em;
			line-height: 1.6em;
			width: 10em;
			font-size: 1em;
		}
		.xxxxx{
			  color:#159ee4;
		}
	</style>
<title>常用网址维护页面</title>
<%!
	public String getCurrDateStr(String format){
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(format);
		return objSimpleDateFormat.format(new java.util.Date());
	}
%>
<%
	String id_no = request.getParameter("id_no") == null ? "0" : request.getParameter("id_no");
	Map pMap = new HashMap();
	pMap.put("id_no",id_no);
	List dataList = (List)KFEjbClient.queryForList("query_K850_ObjectByIdNo",pMap);
	Map dataMap = new HashMap();
	if(dataList.size() > 0){
		dataMap = (HashMap)dataList.get(0);
	}
%>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language="javascript">
	var reflush = false;
	$(function(){
		$("#updateAddressUrl").click(function(){
			var id_no = $("#id_no").val();
			var adress_url= $("#WUrl").val();
			var packet = new AJAXPacket('<%=request.getContextPath()%>/npage/callbosspage/K850/K850_chinaMobileHref_operate.jsp');
			packet.data.add("id_no",id_no);
			packet.data.add("adress_url",adress_url);
			core.ajax.sendPacket(packet,doProcess);
			packet = null;
		});
		$("#back").click(function(){
			window.close();
		});
		$(window).unload(function(){
			if(reflush){
				window.opener.submitInputCheck();
			}		
		});
		
	});
	function doProcess(packet){
		var retCode = packet.data.findValueByName("retCode");
		if(retCode == "000000"){
			reflush = true;
			$("#resultBack").html("操作成功");
		}else if(retCode == "999999"){
			$("#resultBack").html("操作失败");
		}
	}
	
</script>

</head>
<body>	
	<form id="sitechform" name="sitechform" action="" method="post">
		<div class="title">
			<div id="title_zi">修改后常用网址维护页面</div>
		</div>
		<div id="manual_div">
			<div id="Operation_Table" style="width:100%">
				<table cellspacing="0">
					<tr>
						<td nowrap >系统名称</td>
						<td><%=dataMap.get("SYSTEM_NAME")%></td>
					</tr>
					<tr>
						<td>地址</td>
						<td><input type="text" style="width:350px;height:22px;" name="WUrl" id="WUrl" value="<%=dataMap.get("ADRESS_URL")%>" /></td>
					</tr>
					<tr>
						<td align="center" colspan="2">
							<input type="button" class="b_foot" id="updateAddressUrl" name="updateAddressUrl" value="确定">
							<input type="button" class="b_foot" name="back" id="back" value="关闭">
							<input type="hidden" id="id_no" name="id_no" value="<%=id_no%>"
						</td>
						<tr>
							<td nowrap colspan="2" align="center"><font color="red" id="resultBack"></font></td>
						</tr>
					</tr>
				</table>
			</div>
		</div>
	</form>
</body>
</html>