<%
  /*
   * 功能: 对质检结果进行复核
　 * 版本: 1.0.0
　 * 日期: 2008/12/31
　 * 作者: hanjc
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K219";
	String opName = "对质检结果进行复核";
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
String plan_id         = WtcUtil.repNull(request.getParameter("plan_id"));
String serialnum       = WtcUtil.repNull(request.getParameter("serialnum"));//质检单流水
String contact_id     = request.getParameter("contact_id");//通话流水
String login_no        = request.getParameter("staffno");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
//String check_login_no  = (String)session.getAttribute("kfWorkNo");
String check_login_no  = (String)session.getAttribute("workNo");//改为boss工号
String sqlStr          = "";

if(plan_id == null || plan_id.equals("")){
    //以下SQL语句已经加上了权限校验 check_kind = '1'人工考评  0为自动考评计划
    sqlStr = "select (select a.name from dqccheckcontect a where a.object_id = t1.object_id and a.contect_id = t1.content_id), " +
             "(select b.object_name from dqcobject b where b.object_id = t1.object_id), " +
             "t4.source_id, to_char(t4.weight), t4.auto_get, t4.formula, t4.object_id || '_' || t4.contect_id || '_' || t1.plan_id || '_' || t1.group_flag,t1.plan_id " + 
             "from dqcplan t1, dqcloginplan t2, dqccheckloginplan t3, dqccheckcontect t4 " +
             "where t1.object_id = t4.object_id and t1.content_id = t4.contect_id and t1.plan_id = t2.plan_id and t1.plan_id = t3.plan_id and t2.login_no = :login_no and " +
             "t3.check_login_no = :check_login_no and  t1.check_kind = '1' and " +
             "sysdate >= t1.begin_date and sysdate <= t1.end_date order by t1.plan_id";
  	myParams ="login_no="+login_no+",check_login_no="+check_login_no;
}else{
	//以下SQL语句已经加上了权限校验
    sqlStr = "select (select a.name from dqccheckcontect a where a.object_id = t1.object_id and a.contect_id = t1.content_id), " +
             "(select b.object_name from dqcobject b where b.object_id = t1.object_id), " +
             "t4.source_id, to_char(t4.weight), t4.auto_get, t4.formula, t4.object_id || '_' || t4.contect_id || '_' || t1.plan_id || '_' || t1.group_flag,t1.plan_id " + 
             "from dqcplan t1, dqcloginplan t2, dqccheckloginplan t3, dqccheckcontect t4 " +
             "where t1.object_id = t4.object_id and t1.content_id = t4.contect_id and t1.plan_id = t2.plan_id and t1.plan_id = t3.plan_id and t2.login_no = :login_no and " +
             "t3.check_login_no =:check_login_no and t1.check_kind = '1' and t1.plan_id = :plan_id and " +
             "sysdate >= t1.begin_date and sysdate<=t1.end_date order by t1.plan_id";
    myParams ="login_no="+login_no+",check_login_no="+check_login_no+",plan_id="+plan_id;
}
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="9">
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
<script language="JavaScript"  src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script>
	
function goto(){
		var content_ids = document.getElementsByName("check_content");
		var content_id_checked = "";
		var object_id = "";
		var plan_id = "";
		var group_flag = "";
		var plan_id = document.formbar.plan_id.value;
		
		for(var i = 0; i < content_ids.length; i++){
				if(content_ids[i].checked){
						content_id_checked = content_ids[i].value;
				}
		}
		
		if(content_id_checked == ""){
				similarMSNPop("请选择一项考评内容！");
				return false;
		}
		var arr = content_id_checked.split('_');
		object_id = arr[0];
		content_id_checked = arr[1];
		plan_id = arr[2];;
		group_flag = arr[3];
		document.formbar.plan_id.value = plan_id;
		document.formbar.group_flag.value = group_flag;
		var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K217/K217_checkTimes_rpc.jsp","正在进行计划阈值校验，请稍候......");
		mypacket.data.add("plan_id",plan_id);
	  mypacket.data.add("object_id",object_id);
	  mypacket.data.add("content_id_checked",content_id_checked);
	  core.ajax.sendPacket(mypacket,doProcessGetTimes,true);
		mypacket=null;
}

function doProcessGetTimes(packet){
		var toCheck = packet.data.findValueByName("toCheck");
		var object_id = packet.data.findValueByName("object_id");
		var content_id = packet.data.findValueByName("content_id");
		
	  if(parseInt(toCheck)>0){
	  		similarMSNPop("对不起，当前质检计划已达最大次数！");
		}else{
				openQcTab(object_id,content_id);
		}
}

function openQcTab(object_id,content_id_checked){
		var serialnum='<%=serialnum%>';
		var opCode='<%=opCode%>';	
		var plan_id = document.formbar.plan_id.value;
		var group_flag = document.formbar.group_flag.value;
		var path = '/npage/callbosspage/checkWork/K219/K219_check_plan_qc_form.jsp?serialnum=' + '<%=serialnum%>'+'&object_id='+object_id+'&opCode=K218&opName=对流水质检&content_id=' + content_id_checked +'&isOutPlanflag=0&staffno=<%=login_no%>&contact_id=<%=contact_id%>&plan_id=' + plan_id + '&group_flag=' + group_flag ;
		var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
		
		//zengzq start 090520
		//增加选择，在同一时间只能打开一个质检操作窗口（计划内，计划外，临时保存，修改，复核窗口）
		/*var tabtag = top.document.getElementById("tabtag");
		var getElements = tabtag.getElementsByTagName("li");
		for(var i = 0; i<getElements.length; i++){
				var singleElement = getElements[i].getAttribute("id");
				if(singleElement.length > 4 ){
					var partElement = singleElement.substr(0,4);
						if('K217' == partElement||'K218' == partElement||'K219' == partElement||'K214' == partElement||'K216' == partElement){
								similarMSNPop("已打开一个质检操作窗口！");
								return false;
						}
				} else if('K214'==singleElement){
						similarMSNPop("已打开一个质检操作窗口！");
						return false;
				}
		}
		*/
		//zengzq end 
		
		
		var tabId = opCode+serialnum;
		if(!parent.parent.document.getElementById(tabId)){
				path = path+'&tabId='+tabId;
		    parent.parent.addTab(true,tabId,'质检复核',path);
		    parent.parent.removeTab(serialnum+0);
		}else{
				similarMSNPop("此流水质检复核窗口已打开！");
		}
}
</script>

</head>

<body>
<form  name="formbar">
<input type='hidden' name='group_flag' id='group_flag' value='1'>
<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top">
    <div id="Operation_Table">
      <table id="contentTable" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td class="blue">选择</td>
        <td class="blue">考评内容</td>
        <td class="blue">质检对象类别</td>
        <td class="blue">考评内容来源</td>
        <td class="blue">权重</td>
        <td class="blue">是否自动获取</td>
        <td class="blue">公式</td>
      </tr>

<%
      if(queryList != null && queryList.length >= 0){
      	for(int i = 0; i< queryList.length; i++){%>
      <tr>
        <td class="blue"><input type="radio" name="check_content" <%if(i==0){out.println("checked");}%> value="<%=queryList[i][6]%>"/></td>
        <td class="blue"><%=queryList[i][0]%>&nbsp;</td>
        <td class="blue"><%=queryList[i][1]%>&nbsp;</td>
        <td class="blue">
        	<%if(queryList[i][2].equals("0")){
        	  	out.println("通话记录");	
        	  }else if(queryList[i][1].equals("1")){
        	  	out.println("工单记录");
        	  }else if(queryList[i][1].equals("2")){
        	  	out.println("质检结果");
        	  }else if(queryList[i][1].equals("3")){
        	  	out.println("统计数据");
        	  }
%>&nbsp;        
        &nbsp;</td>
        <td class="blue"><%=queryList[i][3]%>&nbsp;</td>
        <td class="blue">
<%
		if(queryList[i][4].equals("Y")){out.println("是");}else{out.println("否");}%>
        &nbsp;
        </td>
        <td class="blue"><%=queryList[i][5]%>&nbsp;</td>
      </tr>
<%
      }
   }
%>
      </table>
    </div>
    <br/>
    </td>
  </tr>
  <tr>
  	<td>
  	</td>
</tr>
</table>

    <div id="Operation_Table">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" id="footer">
				<input name="confirm" onClick="goto();" type="button" class="b_foot" value="确定">
				<input name="back" onClick="window.history.go(0);" type="button" class="b_foot" value="刷新">
			</td>
		</tr>
	</table>
</div>
<input type='hidden' name='plan_id' id='plan_id' value='<%=(queryList.length>0)?queryList[0][7]:""%>'>
</form>
</body>
</html>