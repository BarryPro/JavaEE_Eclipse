<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 考评计划制定-》由被质检组确定的考评内容列表
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: tancf
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K310";
	String opName = "考评内容列表";
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>考评内容列表</title>
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
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

/**********************获取被质检组关联的考评内容开始****************************/
String checkGroupNo = request.getParameter("checkGroupNo") == null ? "" : request.getParameter("checkGroupNo");

String sqlTemp = "select contect_id, object_id, name, source_id "+
                 "from dqccheckcontect "+
                 "where bak1='Y' and " + 
                 "object_id in (select object_id from dqclogingroup where login_group_id in (" + checkGroupNo + "))";                             
%>	

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="4">
<wtc:param value="<%=sqlTemp%>"/>
</wtc:service>
<wtc:array id="queryList" start="0" length="4" scope="end"/>	
<%
/**********************获取被质检组关联的考评内容结束****************************/
%>
</head>
<body>

<form  name="formbar">
	<input type="hidden" name="contect_num" id="contect_num" value="<%=queryList.length%>"/>
	<input type="hidden" name="checkGroupNo" id="checkGroupNo" value="<%=checkGroupNo%>"/>
	<input type="hidden" name="tt" id="checkGroupNo" value="tttt"/>



    <div id="Operation_Table">
      <table id="contentTable" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
      	<th align="center" class="blue"> 考评内容 </th>
      	<th align="center" class="blue"> 考评内容来源 </th>
      	<th align="center" class="blue"> 计划质检次数 </th>
      	<th align="center" class="blue"> 质检次数最低门限 </th>
      	<th align="center" class="blue"> 质检次数最高门限 </th>
      	<!--th align="center" class="blue"> 报警间隔 </th-->
      	<!--th align="center" class="blue"> 报警值 </th-->
      </tr>
      <%for(int i=0;i<queryList.length;i++){%> 
		<tr>
		<td align="center"><%=(queryList[i][2].length()!=0)?queryList[i][2]:"&nbsp;"%></td>
		<td align="center">
        	<%if(queryList[i][3].equals("0")){
        	  	out.println("通话记录");	
        	  }else if(queryList[i][3].equals("1")){
        	  	out.println("工单记录");
        	  }else if(queryList[i][3].equals("2")){
        	  	out.println("质检结果");
        	  }else if(queryList[i][3].equals("3")){
        	  	out.println("统计数据");
        	  }
        	%>&nbsp;
		</td>
		<td align="center"><script>
			 var planTime = window.parent.document.getElementById("PLAN_TIME").value;
			document.write(planTime);</script>&nbsp;
		</td>
		<td align="center"><script>
			var minTime = window.parent.document.getElementById("MIN_TIME").value ;
			document.write(minTime);</script>&nbsp;
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

