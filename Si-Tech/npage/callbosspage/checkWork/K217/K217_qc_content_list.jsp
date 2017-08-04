<%
  /*
   * 功能: 计划外质检-》选择考评内容
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K217";
	//String opName = "选择考评内容";
%>

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
String object_id = WtcUtil.repNull(request.getParameter("object_id"));
String sqlStr = "select name, source_id, to_char(weight), auto_get, formula, contect_id from dqccheckcontect where object_id = :object_id and trim(bak1)='Y'";
myParams = "object_id="+object_id;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>	

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

<script>
function getCheckItem(content_id, qc_content){
		var content_id = content_id;
		var qc_content = qc_content;
		
		if(parent.topFrame.document.readyState == "complete")  { 
				var content_id_obj = parent.topFrame.document.getElementById("content_id");
				content_id_obj.value = content_id;
				var qc_content_obj = parent.topFrame.document.getElementById("qc_content");
				qc_content_obj.value = qc_content;
		} else{
			 	setTimeout(function(){
				    getCheckItem(content_id, qc_content);
				},100);
		}
}
</script>

</head>

<body>
<form  name="formbar">
<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top">
    <div id="Operation_Table">
      <table id="contentTable" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td class="blue">选择</td>
        <td class="blue">名称</td>
        <td class="blue">考评内容来源</td>
        <td class="blue">权重</td>
        <td class="blue">是否自动获取</td>
        <td class="blue">公式</td>
      </tr>
      
<%
      if(queryList != null && queryList.length > 0){
      	for(int i = 0; i< queryList.length; i++){%>
      <tr>     	
        <td class="blue"><input type="radio" id='<%=i%>' name="check_content" onclick="getCheckItem(this.value,'<%=queryList[i][0]%>');" value="<%=queryList[i][5]%>"/></td>
        <td class="blue"><%=queryList[i][0]%>&nbsp;</td>
        <td class="blue">
<%
				
        	if(queryList[i][1].equals("0")){
        	  	out.println("通话记录");	
        	  }else if(queryList[i][1].equals("1")){
        	  	out.println("工单记录");
        	  }else if(queryList[i][1].equals("2")){
        	  	out.println("质检结果");
        	  }else if(queryList[i][1].equals("3")){
        	  	out.println("统计数据");
        	  }
%>&nbsp;
        </td>
        <td class="blue"><%=queryList[i][2]%>&nbsp;</td>
        <td class="blue">
        	<%if("Y".equals(queryList[i][3])){out.println("是");}else{out.println("否");}%>&nbsp;
        </td>
        <td class="blue"><%=queryList[i][4]%>&nbsp;</td>
      </tr>
<%
      }
%>
			 <script>
						//默认选择第一个考评内容					
								document.getElementById("0").click();
			</script>
<%
   }else{
%>
		<script>
					getCheckItem("","");
		</script>
<%
   	
   }
%>                                
      </table>
    </div>
    <br/>          
    </td>
  </tr>
</table>

</FORM>
</BODY>
</HTML>