<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 总计划计划修改右侧
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: tancf
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

String plan_id=request.getParameter("plan_id");
String content_id=request.getParameter("content_id");
String object_id=request.getParameter("object_id");
%>
<html>
<head>
<title>考评内容</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
<%
String checkGroupNo=request.getParameter("checkGroupNo")==null?"":request.getParameter("checkGroupNo");
String sqlTemp = "select dqccontect.contect_id,dqccontect.OBJECT_ID,dqccontect.name,dcqsouce.source_name  from DQCCHECKCONTECT dqccontect ,DQCCHECKSOURCE dcqsouce where trim(dqccontect.source_id)=trim(dcqsouce.source_id) and trim(dqccontect.contect_id)= :content_id and trim(dqccontect.object_id)= :object_id ";
myParams = "content_id="+content_id.trim()+",object_id="+object_id.trim() ;
%>	
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="4">
	<wtc:param value="<%=sqlTemp%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" start="0" length="4" scope="end"/>	

<script>


/**
  *
  *添加考评内容
  *
  */
function submitQcContent()
{
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_add_qc_content.jsp","请稍后...");

    var object_id      = document.getElementById("object_id").value;
    var source_id      = document.getElementById("source_id").value;
    var content_name   = document.getElementById("content_name").value;
    var weight         = document.getElementById("weight").value;
    var auto_get       = document.getElementById("auto_get").value;
    var formula        = document.getElementById("formula").value;
    var note           = document.getElementById("note").value;
    var crete_login_no = "01";   
    chkPacket.data.add("retType","submitQcContent");
    chkPacket.data.add("object_id", object_id);
    chkPacket.data.add("source_id", source_id);
    chkPacket.data.add("content_name", content_name);
    chkPacket.data.add("weight", weight);
    chkPacket.data.add("auto_get", auto_get);
    chkPacket.data.add("formula", formula);
    chkPacket.data.add("note", note);
    chkPacket.data.add("crete_login_no", crete_login_no);
    core.ajax.sendPacket(chkPacket,doProcessAddQcContent,true);
	chkPacket =null;
}
</script>

</head>
<body>

<form  name="formbar">
	<input type="hidden" name="contect_num" id="contect_num" value="<%=queryList.length%>"/>
	<input type="hidden" name="checkGroupNo" id="checkGroupNo" value="<%=checkGroupNo%>"/>

    <div id="Operation_Table">
    <table id="contentTable" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<th align="center" class="blue" nowrap > 考评内容 </th>
      	<th align="center" class="blue" nowrap > 考评内容来源 </th>
      	<th align="center" class="blue" nowrap > 计划质检次数 </th>
      	<th align="center" class="blue" nowrap > 质检次数最低门限 </th>
      	<th align="center" class="blue" nowrap > 质检次数最高门限 </th>
      	<!--th align="center" class="blue" width="80" > 报警间隔 </th-->
      	<!--th align="center" class="blue" width="80" > 报警值 </th-->
      </tr>
      <%for(int i=0;i<queryList.length;i++){%> 
      <tr> 
       
        <td align="center"><%=(queryList[i][2].length()!=0)?queryList[i][2]:"&nbsp;"%></td>
				<td align="center"><%=(queryList[i][3].length()!=0)?queryList[i][3]:"&nbsp;"%></td>
				<td align="center"><script>
					var planTime = window.parent.document.getElementById("PLAN_TIME").value;
					document.write(planTime);</script>&nbsp;
				</td>
				<td align="center"><script>
			 		var planTime = window.parent.document.getElementById("MIN_TIME").value;
					document.write(planTime);</script>&nbsp;
				</td>
				<td align="center"><script>
					var maxTime = window.parent.document.getElementById("MAX_TIME").value ;
					document.write(maxTime);</script>&nbsp;
				</td>
				<!--td align="center">&nbsp;</td-->
				<!--td align="center">&nbsp;</td-->
				<input type="hidden" name ="content_id<%=i%>" value="<%=queryList[i][0]%>">
    		<input type="hidden" name ="object_id<%=i%>" value="<%=queryList[i][1]%>">
    </tr>
      <%}%>
      </table>
    </div>

</form>
</body>
</html>
 






