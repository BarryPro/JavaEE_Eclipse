<%
  /*
   * 功能: 添加考评项页面
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K230";
	String opName = "添加考评项";
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
/*---------------获得页面传递参数开始-------------------*/
String object_id      = WtcUtil.repNull(request.getParameter("object_id"));
String content_id     = WtcUtil.repNull(request.getParameter("content_id"));
String father_node_id = WtcUtil.repNull(request.getParameter("father_node_id"));
String current_node_id= WtcUtil.repNull(request.getParameter("current_node_id"));
/*---------------获得页面传递参数结束-------------------*/
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
String tmpSelect = "";
String tmp = "";

if("0".equals(current_node_id)){
	tmpSelect = "disabled";
	tmp = "selected";
	father_node_id="0";
}
%>
<%
	String tmpSql = "select is_scored from dqccheckitem where item_id=:current_node_id ";
	myParams = "current_node_id="+current_node_id;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
<wtc:param value="<%=tmpSql%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="tmpList" scope="end"/>
	
<%
		String tmpVal = "";
		if(tmpList.length>0){
	  		tmpVal = tmpList[0][0];
		}
%>	
<%
/*zhengjiang 20091004 add start*/
String countNum = "0";
//if("0".equals(current_node_id)){
	String countSql = "select to_char(nvl(sum(high_score),0)) from dqccheckitem "
										+" where parent_item_id=:father_node_id "
										+" and object_id=:object_id "
										+" and contect_id=:content_id "//;	//查询出当前父节点对应的分数和		
										+" and bak1<>'N'";//此处需要确认是否添加
	myParams = "father_node_id="+father_node_id+",object_id="+object_id+",content_id="+content_id;		
	
	System.out.println("-------------countSql: "+countSql);							
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
<wtc:param value="<%=countSql%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="countList" scope="end"/>
<%
	if(countList.length>0){
		countNum = countList[0][0];
	}
//}	
%>
<%
	String currentCountNum = "0";
	String sumCurrent = "0";
	if(!"0".equals(current_node_id)){//判断当前节点是否为根节点
		String sumCurrentSql = "select to_char(nvl(sum(high_score),0)) from dqccheckitem "
										+" where parent_item_id=:current_node_id "
										+" and object_id=:object_id "
										+" and contect_id=:content_id "//;	//已当前节点为父节点的最高分总和
										+" and bak1<>'N'";//此处需要确认是否添加
	  
		String currentCountSql = "select to_char(high_score) from dqccheckitem where " 
														+" item_id=:current_node_id "
														+" and object_id=:object_id "
														+" and contect_id=:content_id ";//查询当前节点的分数上限
		myParams = "current_node_id="+current_node_id+",object_id="+object_id+",content_id="+content_id;
		
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
			<wtc:param value="<%=sumCurrentSql%>"/>
			<wtc:param value="<%=myParams%>"/>
		</wtc:service>
		<wtc:array id="sumCurrentSqlList" scope="end"/>
<%
		if(sumCurrentSqlList.length>0){
			sumCurrent = sumCurrentSqlList[0][0];
		}
%>		
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
			<wtc:param value="<%=currentCountSql%>"/>
			<wtc:param value="<%=myParams%>"/>
		</wtc:service>
		<wtc:array id="currentCountList" scope="end"/>
<%
		
		if(currentCountList.length>0){
			currentCountNum = currentCountList[0][0];
		}
	}
	/*zhengjiang 20091004 add end*/
%>
<html>
<head>
<title>添加考评项</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script>
	
function grpClose(){
		window.opener = null;
		window.close();
}
//清除表单记录
function clearValue(){
		var e = document.forms[0].elements;
		for(var i=0;i<e.length;i++){
				var tid = e[i].id;
			  if(e[i].type!="select-one"&&e[i].type=="text"&&tid!=""){
				  	if(!(document.getElementById(tid).disabled)&&!(document.getElementById(tid).readOnly)){
					  		e[i].value="";
					  }
				}
				if(e[i].type=="select-one"&&tid!=""){
						document.getElementById(e[i].id).options[0].selected = true;
				}
		 }
}
//判断最高分最低分
function check_score(low_score,high_score)
{
    var notANumber = 2;
    var notLogic   = -1;
    var success    = 0;
    var re = /^[-]?\d+[.]?\d*$/;
    if(!((re.test(low_score))&&re.test(high_score)))
    {
        return notANumber;
    }else
         //if((parseInt(low_score) < 0)||(parseInt(high_score) < 0)||(parseInt(low_score) > parseInt(high_score)))
         if((parseInt(high_score) < 0)||(parseInt(low_score) > parseInt(high_score)))
    {
        return notLogic;
    }
    notANumber = null;
    notLogic   = null;
    return success
}


//判断是否是数字
function isNumber(ee){
	if(!ee) return false;
	
  if(isNaN(ee)){
	  	similarMSNPop("权重必须为数字！");
	  	document.getElementById("weight").value="";
	  	document.getElementById("weight").focus();
  }
  
  if(ee<=0){
	  	similarMSNPop("权重必须大于零！");
	  	document.getElementById("weight").value="";
	    document.getElementById("weight").focus();
  }
  
  var tmpPos = ee.lastIndexOf('.');
  var subWeightLength = ee.substr(tmpPos).length;
  
  if(subWeightLength>3){
	    similarMSNPop("权重最多只能有两个小数位！");
	    document.getElementById("weight").value="";
	    document.getElementById("weight").focus();
  }	
  return true;
}

/*对返回值进行处理*/
function doProcessAddQcItem(packet){
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var item_id = packet.data.findValueByName("item_id");
		if(retType=="submitQcItem" && retCode == "000000"){
				var parWin          = window.dialogArguments;
				var itemName        = document.getElementById("item_name").value;		    
				var isScore         = document.getElementById("isScore").value;
				var parent_item_id  = document.getElementById("parent_item_id").value;
				var nodeType        = document.getElementById("nodeType").value;
				var father_node_id  = document.getElementById("father_node_id").value;
				var current_node_id = document.getElementById("current_node_id").value;
				
				if(parent_item_id!=0){
						parWin.tree.setUserData(parent_item_id.trim(),"isleaf",'N');
			  }
			  
				parWin.tree.insertNewItem(parent_item_id.trim(), item_id.trim(), itemName.trim(), 0, 0, 0, 0, 'SELECT');
				parWin.tree.setUserData(item_id.trim(),"isleaf",'Y');
				parWin.tree.setUserData(item_id.trim(),"isscored",isScore);
				parWin.tree.setUserData(item_id.trim(),"object_id",'<%=object_id%>');
					        
				/*
				if(rdShowConfirmDialog("添加考评项成功，是否继续添加",2) != 1){
						window.close();
				}	
				*/
				similarMSNPop("添加考项成功！");
        //added by liujied 
        //setTimeout("grpClose()",2500);
        grpClose();
		}else{
				similarMSNPop("添加考项失败！");
				return false;
		}
}

/**
  *
  *添加考评项
  *
  */
function submitQcItem()
{
		var weight          = document.getElementById("weight").value;
    var low_score       = document.getElementById("low_score").value;
    var high_score      = document.getElementById("high_score").value;
    var item_name       = document.getElementById("item_name").value;
    var formula         = document.getElementById("formula").value;
    
    if(weight == ''){
			similarMSNPop("没有输入考评项权重！");
			return false;
		}
		
		if( low_score== ''){
				similarMSNPop("没有输入考评项最低分！");
				return false;
		}
	
		if( high_score== ''){
				similarMSNPop("没有输入考评项最高分！");
				return false;
		}
                if( check_score(low_score,high_score) == 2){
                                similarMSNPop("最高分和最低分必须是数字！");
				return false;
                }
                if( check_score(low_score,high_score) == -1){
                                similarMSNPop("最高分必须大于最低分且最高分不能小于零！");
				return false;
                }
		
		if( item_name== ''){
				similarMSNPop("没有输入考评项名称！");
				return false;
		}
		
		//added by tangsong 20100409 验证名称
		var flag = checkElement(document.all("item_name"));
		if (!flag) {
			similarMSNPop("输入值非法！");
			return false;
		}
		
		if(formula == ''&&""==document.getElementById("forId").style.display){
				similarMSNPop("没有输入考评项计算公式！");
				return false;
		}
		//zhengjiang 20091004 start
		var tempCount = '<%=countNum%>';
		var sumCurrent = '<%=sumCurrent%>';
		var currentNodeId = '<%=current_node_id%>';
		var parentid = '<%=father_node_id%>';
		//var currentParentId = document.getElementById("parent_item_id").value;
		var nodeType = document.getElementById("nodeType").value;//节点类型
		var totalCount = parseInt(tempCount)+parseInt(high_score);//当前节点对应的父节点下分数上限的总和+新增节点分数上限
		/*	guozw2010-01-26
		if(0==currentNodeId){
			if(totalCount>100){
				similarMSNPop("分数总和超出了分项规定的分数！");
				return false;
			}
		}else if(0==parentid && "1"==nodeType){
			if(totalCount>100){
				similarMSNPop("分数总和超出了分项规定的分数！");
				return false;
			}
		}else{
		  totalCount = parseInt(sumCurrent) + parseInt(high_score);
			var currentCountNum = '<%=currentCountNum%>';
			if(totalCount>currentCountNum){
				similarMSNPop("分数总和超出了分项规定的分数！");
				return false;
			}
		}
		*/
		//zhengjiang 20091004 end
    var chkPacket       = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_add_qc_item.jsp","请稍后...");
    var parent_item_id  = document.getElementById("parent_item_id").value;
    var object_id       = document.getElementById("object_id").value;
    var content_id      = document.getElementById("content_id").value;
    var is_leaf         = document.getElementById("is_leaf").value;
    var note            = document.getElementById("note").value;
    var isDefault       = document.getElementById("isDefault").value;
    var isScore         = document.getElementById("isScore").value;
    //added by liujied 过滤掉考评项描述中的空格
    note = note.replace(/\s/g,"");
   
    chkPacket.data.add("retType","submitQcItem");
    chkPacket.data.add("parent_item_id", parent_item_id);
    chkPacket.data.add("object_id", object_id);
    chkPacket.data.add("contect_id", content_id);
    chkPacket.data.add("is_leaf", is_leaf);
    chkPacket.data.add("item_name", item_name);
    chkPacket.data.add("low_score", low_score);
    chkPacket.data.add("high_score", high_score);
    chkPacket.data.add("weight", weight);
    chkPacket.data.add("formula", formula.split("+").join("%2B"));
    chkPacket.data.add("note", note);
		chkPacket.data.add("isDefault", isDefault);
		chkPacket.data.add("isScore", isScore);
		chkPacket.data.add("crete_login_no", "<%=(String)session.getAttribute("kfWorkNo")%>");	
    core.ajax.sendPacket(chkPacket,doProcessAddQcItem,true);
		chkPacket =null;
}

/**
  *
  *改变节点类型随动函数
  */
function changeNodeType(nodeType){
		var parent_item_id  = document.getElementById("parent_item_id");
		var father_node_id  = document.getElementById("father_node_id").value;
		var current_node_id = document.getElementById("current_node_id").value;
		
		if(nodeType == 1){
				parent_item_id.value = father_node_id;
		}
		
		if(nodeType == 2){
				parent_item_id.value = current_node_id;
		}	
}

/**
  *判断是否显示计算公式
  */
function formulaJudge(){
		var tmpVal = document.getElementById("isScore").value;
		
		if("N"==tmpVal){
				document.getElementById("forId").style.display="";
				document.getElementById("formula").value="x+y";
				//document.getElementById("formula").disabled=false;
		}
		if("Y"==tmpVal){
				document.getElementById("forId").style.display="none";
				document.getElementById("formula").value="";
				//document.getElementById("formula").disabled=true;
		}
}

/**
  *校验计算公式
  */
function verify(){
	var time =new Date();
	var formula = document.getElementById('formula').value;
	window.showModalDialog("K230_verify_formula.jsp?time=" + time+"&formula="+formula.split("+").join("%2B"),"","");
}
</script>

</head>

<body>
<form  name="formbar">
<input type="hidden" name="father_node_id" id="father_node_id" value="<%=father_node_id%>"/>
<input type="hidden" name="current_node_id" id="current_node_id" value="<%=current_node_id%>"/>
<input type="hidden" name="object_id" id="object_id" value="<%=object_id%>"/>
<input type="hidden" name="contect_id" id="content_id" value="<%=content_id%>"/>
<input type="hidden" name="is_leaf" id="is_leaf" value="Y"/>

<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top">
	<div id="Operation_Title"><B>添加考评项</B></div>
    <div id="Operation_Table" style="width: 100%;"><!-- guozw20090828 -->
    <div class="title"></div>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td width=16% class="blue">上层节点编号</td>
        <td width="34%"> 
        <input name="parent_item_id" id="parent_item_id" value="<%=father_node_id%>" size="8" disabled/>
        </td>
         <td width=16% class="blue">编号</td>
         <td width="34%">
		<input id="item_id" value="系统自动生成" disabled/>
         </td>        
      </tr>   
      <tr>
      	<td width="16%" class="blue">节点类别</td>
        <td width="34%">
         	<select name="nodeType" onchange="changeNodeType(this.value)"  <%=tmpSelect%> <%if("Y".equals(tmpVal.trim())){out.print("disabled");}%> >
        		<option value="1">同层节点</option>
         		<option value="2" <%=tmp%> >子结点</option>
        	</select>
        </td>
         <td width=16% class="blue">名称</td>
         <td width="34%">
		<input id="item_name" value="" v_must="1" v_type="string" onBlur="checkElement(this)" ><font class="orange">*</font>
         </td>
      </tr>      
      <tr>
        <td width=16% class="blue">是否评分项</td>
        <td width="34%">
	 	    <select name="isScore" id="isScore" onChange="javascript:formulaJudge(this.value);">
	 		<option value="Y">是</option>
	 		<option value="N">否</option>
        	</select>    
        </td>
        <td width=16% class="blue">是否默认项</td>
        <td width="34%">
         	<select name="isDefault" id="isDefault">
         		<option value="1">是</option>
         		<option value="0">否</option>
        	</select>         	
        </td>      	
      </tr>
      <tr>
         <td width=16% class="blue">最低分</td>
         <td width="34%">
         	<!--zhengjiang 20091005 最低分和最高分添加整数限制onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"-->
		<input id="low_score" value="" v_must="1" v_type="string" onkeyup="value=value.replace(/[^-?\d+$]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" onBlur="checkElement(this)" /><font class="orange">*</font>
         </td>
        <td width=16% class="blue">最高分</td>
        <td width="34%"> 
        <input id="high_score" value="" v_must="1" v_type="string" onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" onBlur="checkElement(this)" /><font class="orange">*</font>
        </td>
      </tr>
      <tr>
        <td width=16% class="blue">权重</td>
        <td width="34%"> 
        <!--zhengjiang 20091004 add value="1" readonly="true"-->
        <input id="weight" name="weight" value="1" readonly="true" v_must="1" v_type="string" onBlur="checkElement(this);isNumber(this.value);" /><font class="orange">*</font>
        </td>
        <td width=16% class="blue">描述</td>
        <td width="34%"> 
        <input id="note" />
        </td>        
      </tr>      
      <tr id="forId" style="display:none;">
         <td width=16% class="blue">计算公式</td>
         <td width="34%">
		<input id="formula"  value="" v_must="1" v_type="string" onBlur="checkElement(this)" readonly /><font class="orange">*</font>
        <!--input type="button" name="confirmBtn" class="b_text" value="校验" onClick="verify();"/-->
         </td>
        <td width=16% class="blue">&nbsp;</td>
        <td width="34%"> &nbsp;
        </td>
      </tr>                                      
      </table>
      
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_foot" name="submit" type="button" value="确认" onclick="submitQcItem()">
        	<!--input class="b_foot" name="reset1" type="button"  onclick="history.go(0);" value="清除"-->
       		<input class="b_foot" name="reset1" type="button"  onclick="clearValue();return false;" value="清除">
       		<input class="b_foot" name="back" type="button" onclick="grpClose();" value="关闭"  >
        </td>
       </tr>  
     </table>
     
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

</form>

</body>
</html>