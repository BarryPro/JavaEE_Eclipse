
<%
  /*
   * 功能: 考评项等级维护页面
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
 
	String opCode="";
	String opName="考评项等级管理";
%>

<%
String content_id = request.getParameter("content_id");
if(content_id == null || content_id == ""){
	content_id = "02";
}
String object_id = request.getParameter("object_id");
if(object_id == null || object_id == ""){
	object_id = "01";
}
String item_id = WtcUtil.repNull(request.getParameter("selectedItemId"));
item_id = item_id.split("_")[0];
String sqlStr  = "select to_char(serialno), level_name, decode(substr(to_char(trim(score)),0,1),'.','0'||to_char(trim(score)),to_char(score)), is_def_level, note,decode(substr(to_char(trim(low_score)),0,1),'.','0'||to_char(trim(low_score)),to_char(low_score)) " + 
                 "from dqcckectitemlevel where item_id = :item_id and object_id= :object_id and content_id= :content_id order by level_id";
myParams = "item_id="+item_id+",object_id="+object_id+",content_id="+content_id ;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="8">
<wtc:param value="<%=sqlStr%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>

<html>
<head>
	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script>

function grpClose(){
window.opener = null;
window.close();
}
/**
  *
  *弹出新增考评项等级窗口
  *
  */
function show_add_item_level_win(){
	var object_id = document.getElementById("object_id").value;
	var content_id = document.getElementById("content_id").value;
	var item_id = document.getElementById("item_id").value;
	var height = 250;
	var width  = 800;
	var top    = (screen.availHeight - height)/2;
	var left   = (screen.availWidth - width)/2;
	var param  = 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,' +
	             'width=' + width + ',height=' + height + ',left= ' + left + ',top=' + top;
	window.open('K230_add_item_level.jsp?item_id=' + item_id + "&object_id=" +object_id + "&content_id=" + content_id, '', param);
}

/**
  *
  *弹出修改考评项等级窗口
  *
  */
function show_upd_item_level_win(){
	var  serialnos = document.getElementsByName("serialno");
	/*zhengjiang 20091004 add start*/
	var object_id = document.getElementById("object_id").value;
	var content_id = document.getElementById("content_id").value;
	var item_id = document.getElementById("item_id").value;
	/*zhengjiang 20091004 add end*/
	var  serialno  = "";
	for(var i = 0; i < serialnos.length; i++){
		if(serialnos[i].checked){
			serialno = serialnos[i].value;
		}
	}
	if(serialno == ""){
		similarMSNPop("请选择想要修改的考评项等级！");
		return false;
	}

	var height = 250;
	var width  = 800;
	var top    = (screen.availHeight - height)/2;
	var left   = (screen.availWidth - width)/2;
	var param  = 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,' +
	             'width=' + width + ',height=' + height + ',left= ' + left + ',top=' + top;
	/*zhengjiang 20091004 增加"&item_id=" + item_id + "&object_id=" +object_id + "&content_id=" + content_id,*/
	window.open('K230_upd_item.level.jsp?serialno=' + serialno+"&item_id=" + item_id + "&object_id=" +object_id + "&content_id=" + content_id, '', param);
}

/*对返回值进行处理*/
function doProcessDelItemLevel(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if(retType=="del_qc_item_level"){
		if(retCode=="000000"){
                     
			similarMSNPop("成功删除考评项等级！");
			var item_id    = "<%=item_id%>";
			var object_id  = "<%=object_id%>";
			var content_id = "<%=content_id%>";
			var url = "<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_qc_item_level_list.jsp?selectedItemId="+item_id+"&object_id="+object_id+"&content_id="+content_id;
                        
			window.location.href = url;
                        
		}else{
			similarMSNPop("删除考评项等级失败！");
		}
	}
}

/**
  *
  *删除考评项等级
  *
  */
function del_qc_item_level(){
  var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_del_item_level.jsp","请稍后...");
	var  serialnos = document.getElementsByName("serialno");
	var  serialno  = "";
	for(var i = 0; i < serialnos.length; i++){
		if(serialnos[i].checked){
			serialno = serialnos[i].value;
		}
	}
	if(serialno == ""){
		similarMSNPop("请选择想要删除的考评项等级！");
		return false;
	}
    chkPacket.data.add("retType","del_qc_item_level");
    chkPacket.data.add("serialno", serialno);
    core.ajax.sendPacket(chkPacket,doProcessDelItemLevel,true);
		chkPacket =null;
}

function refreshThisPage(){
	var item_id    = "<%=item_id%>";
	var object_id  = "<%=object_id%>";
	var content_id = "<%=content_id%>";
	var url = "<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_qc_item_level_list.jsp?item_id="+item_id+"&object_id="+object+"&content_id="+content_id;
	window.location.href = url;
}

function test(){
	window.location.reload();
}
</script>
</head>
<body>
<form name="form1">
<input type="hidden" name="object_id" id="object_id" value="<%=object_id%>"/>
<input type="hidden" name="content_id" id="content_id" value="<%=content_id%>"/>
<input type="hidden" name="item_id" id="item_id" value="<%=item_id%>"/>
<!--
<%@ include file="/npage/include/header.jsp" %>
-->
<!--add by zhengjiang 20090930 start-->
<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top">
	<div id="Operation_Title"><B>考评项等级管理</B></div>
<!--add by zhengjiang 20090930 end-->
<div id="Operation_Table" style="width: 100%;"><!-- guozw20090829 -->
<!--modify by zhengjiang 20090930 增加<div id="title_zi"></div> -->
	<div class="title"><div id="title_zi">查询结果</div></div>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr> 
    	 <th nowrap >选择</th>
    	 <th nowrap >编号</th>
       <th nowrap >名称</th>
       <th nowrap >最低分</th>
       <th nowrap >最高分</th>
       <th nowrap >是否为默认得分</th>
       <th nowrap >描述</th>
    </tr>
    <%
    for(int i = 0; i < queryList.length; i++){
    %>
    <tr>
    	<td class='blue' >
    	<input type="radio" name="serialno" value="<%=queryList[i][0]%>"/>
    	</td>
			<td class='blue' ><%=queryList[i][0]%>&nbsp;</td>
			<td class='blue' ><%=queryList[i][1]%>&nbsp;</td>
			<td class='blue' ><%=queryList[i][5]%>&nbsp;</td>
			<td class='blue' ><%=queryList[i][2]%>&nbsp;</td>
			<td class='blue' ><%if(queryList[i][3].equals("N")){out.println("否");}else{out.println("是");}%>&nbsp;</td>
			<td class='blue' ><%=queryList[i][4]%>&nbsp;</td>
    </tr>
    <%
    }
    %>
	</table>

	<TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
	  <tr>
	    <td align="center" id="footer">
	      <input name="confirm" onClick="show_add_item_level_win();" type="button" class="b_foot" value="新增">
	      <input name="confirm" onClick="show_upd_item_level_win();" type="button" class="b_foot" value="修改">
              <!--added by liujied 添加删除当前考评项等级认证过程-->
	      <input name="confirm" onClick="if(rdShowConfirmDialog('确认删除当前考评项等级么？') == 1){del_qc_item_level();}else{}" type="button" class="b_foot" value="删除">
	      <input class="b_foot" name="back" type="button" onclick="grpClose();" value="关闭">
	    </td>
	  </tr>
	</TABLE>
<!--add by zhengjiang 20090930 start-->
</div>
    <br/>
    </td>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
  </tr>

  <tr>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
    <td valign="bottom">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
      <tr>
        <td height="1"></td>
      </tr>
    </table>
    </td>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
  </tr>
</table>

</div>
<!--add by zhengjiang 20090930 end-->
<!--modify by zhengjiang 20090930
<%@ include file="/npage/include/footer.jsp" %>
-->
</form>
</body>
</html>
<script language="javascript">
function cfm(){
	if(check(document.form1)){
		form1.action="sample2.jsp";
		form1.submit();
	}
}

function ccc(){
	if(rdShowConfirmDialog("是否确定提交？")){
	}
}
</script>