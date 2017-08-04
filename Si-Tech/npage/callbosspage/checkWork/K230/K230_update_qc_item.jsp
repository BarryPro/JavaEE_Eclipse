<%
  /*
   * 功能: 更新考评项页面
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update: 	mixh 2009/02/23   修正是否计分项字段无法更新问题
　 */
%>
<%
	String opCode = "K230";
	String opName = "更新考评项";
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

String item_id       = WtcUtil.repNull(request.getParameter("item_id"));
String parentItem_id = WtcUtil.repNull(request.getParameter("parentItem_id"));
String object_id     = WtcUtil.repNull(request.getParameter("object_id"));
String content_id    = WtcUtil.repNull(request.getParameter("content_id"));

String sqlStr = "select item_name, to_char(weight), to_char(low_score), to_char(high_score), note, formula, bak2, is_scored " + 
                "from dqccheckitem where trim(item_id) = :item_id and trim(object_id)= :object_id and trim(contect_id)= :content_id";
myParams = "item_id="+item_id+",object_id="+object_id+",content_id="+content_id ;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="8">
<wtc:param value="<%=sqlStr%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>

<%
/*zhengjiang 20091004 add start*/
	String countSql = "select to_char(nvl(sum(high_score),0)) from dqccheckitem "
										+" where parent_item_id= :parentItem_id "
										+" and object_id= :object_id "
										+" and contect_id= :content_id "//;//查询出当前父节点对应的分数和								
										+" and bak1<>'N' ";//此处需要确认是否添加
myParams="";
myParams = "parentItem_id="+parentItem_id+",object_id="+object_id+",content_id="+content_id ;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
<wtc:param value="<%=countSql%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="countList" scope="end"/>
<%
	String countNum = "";
	if(countList.length>0){
		countNum = countList[0][0];
	}
%>
<%
	String currentCountNum = "0";
	if(!"0".equals(parentItem_id)){
		String currentCountSql = "select to_char(high_score) from dqccheckitem where "
													+" item_id= :parentItem_id "
													+" and object_id= :object_id "
													+" and contect_id= :content_id ";//查询当前节点的分数上限
myParams="";
myParams = "parentItem_id="+parentItem_id+",object_id="+object_id+",content_id="+content_id ;
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
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
<title>更新考评项</title>
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


//判断是否是数字
function isNumber(e){
	if(!e) return false;
  if(isNaN(e)){
  	similarMSNPop("权重必须为数字！");
  	document.getElementById("weight").value="";
  	document.getElementById("weight").focus();
  }
  if(e<=0){
  	similarMSNPop("权重必须大于零！");
  	document.getElementById("weight").value="";
    document.getElementById("weight").focus();
  }
  
  var tmpPos = e.lastIndexOf('.');
  var subWeightLength = e.substr(tmpPos).length;
  if(subWeightLength>3){
    similarMSNPop("权重最多只能有两个小数位！");
    document.getElementById("weight").value="";
    document.getElementById("weight").focus();
  }	
  return true;
}

/*对返回值进行处理*/
function doProcessupdateQcItem(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var object_id = packet.data.findValueByName("object_id");
	if(retType=="updateQcItem"){
		if(retCode=="000000"){
			similarMSNPop("更新考评项成功！");
			var parWin = window.dialogArguments;
			parWin.tree.setItemText("<%=item_id%>",document.getElementById("item_name").value,document.getElementById("item_name").value);
      //setTimeout("grpClose()",2500);
			grpClose();
		}else{
			similarMSNPop("更新考评项失败！");
			return false;
		}
	}
}

/**
  *
  *更新考评项
  *
  */
function updateQcItem()
{
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_update_qc_item.jsp","请稍后...");
    var object_id       = document.getElementById("object_id").value;
    var contect_id      = document.getElementById("contect_id").value;
    var is_leaf         = document.getElementById("is_leaf").value;
    var item_name       = document.getElementById("item_name").value;
    var low_score       = document.getElementById("low_score").value;
    var high_score      = document.getElementById("high_score").value;
    var weight          = document.getElementById("weight").value;
    var formula         = document.getElementById("formula").value; 
    var note            = document.getElementById("note").value;
    var is_scored       = document.getElementById("is_scored").value;
    var isDefault       = document.getElementById("isDefault").value;
    
    //added by liujied 过滤掉考评项描述中的空格
    note = note.replace(/\s/g,"");
    
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
	
	if(formula == ''&&(document.getElementById("forId").style.display!="none")){
		similarMSNPop("没有输入考评项计算公式！");
		return false;
	}
    //zhengjiang 20091004 start
	
		var tempCount = '<%=countNum%>';
		var parentid = '<%=parentItem_id%>';
		var beforeUpdateHScore = '<%=queryList[0][3]%>';//修改前本节点的分数上限
		//修改上限时需要在总数中减去修改前的分数上限再加上修改后的分数上限
		var totalCount = parseInt(tempCount)-parseInt(beforeUpdateHScore)+parseInt(high_score);
		/*	guozw2010-01-26
		if(0==parentid){
			if(totalCount>100){
				similarMSNPop("分数总和超出了分项规定的分数！");
				return false;
			}
		}else{
			var currentCountNum = '<%=currentCountNum%>';
			if(totalCount>currentCountNum){
				similarMSNPop("分数总和超出了分项规定的分数！");
				return false;
			}
		}
		*/
		//zhengjiang 20091004 end
    chkPacket.data.add("retType","updateQcItem");
    chkPacket.data.add("item_id", "<%=item_id%>");
    chkPacket.data.add("object_id", object_id);
    chkPacket.data.add("contect_id", contect_id);
    chkPacket.data.add("is_leaf", is_leaf);
    chkPacket.data.add("is_scored", is_scored);
    chkPacket.data.add("item_name", item_name);
    chkPacket.data.add("low_score", low_score);
    chkPacket.data.add("high_score", high_score);
    chkPacket.data.add("weight", weight);
    chkPacket.data.add("formula", formula.split("+").join("%2B"));
    chkPacket.data.add("note", note);
     chkPacket.data.add("isDefault", isDefault);
    chkPacket.data.add("update_login_no", "<%=(String)session.getAttribute("kfWorkNo")%>");

    core.ajax.sendPacket(chkPacket,doProcessupdateQcItem,true);
	chkPacket =null;
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
<input type="hidden" name="current_node_id" id="current_node_id" value="<%=request.getParameter("current_node_id")%>"/>
<input type="hidden" name="object_id" id="object_id" value="<%=object_id%>"/>
<input type="hidden" name="contect_id" id="contect_id" value="<%=content_id%>"/>
<input type="hidden" name="is_leaf" id="content_id" value="N"/>

<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B><font face="Arial"></font>更新考评项</B></div>
    <div id="Operation_Table" style="width: 100%;"><!-- guozw20090828 -->
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      
      <tr>
      	<td width=16% class="blue">上层节点编号</td>
        <td width="34%"> 
        	<input id="object_type" maxlength=8 index="27"  v_must=1 v_maxlength=8 v_type="date"   value='<%=parentItem_id%>' disabled/>
        </td>
        <td width=16% class="blue">编号</td>
        <td width="34%">
			<input id="object_name" value="系统自动生成" disabled/>
        </td>                 
      </tr>
      
      <tr>
      	<td width="16%" class="blue">节点类别</td>
        <td width="34%">
         	<select name="nodeType" disabled>
         		<option value="1">同层节点</option>
         		<option value="2">子结点</option>
        	</select>
        </td>
        <td width=16% class="blue">名称</td>
        <td width="34%">
			<input id="item_name" value="<%=queryList[0][0]%>" v_must="1" v_type="string" onBlur="checkElement(this)" ><font class="orange">*</font>
        </td>             
      </tr>
    	
      <tr>
        <td width=16% class="blue">是否评分项</td>
        <td width="34%">
	 	    <select name="is_scored" id="is_scored" disabled>
	 		<option value="Y" <%if("Y".equals(queryList[0][7].trim())){out.print("selected");}%>>是</option>
	 		<option value="N" <%if("N".equals(queryList[0][7].trim())){out.print("selected");}%>>否</option>
        	</select>    
        </td>        
        
        <td width=16% class="blue">是否默认项</td>
        <td width="34%">
         	<select name="isDefault" id="isDefault">
         		<option value="1" <%if("1".equals(queryList[0][6].trim())){out.print("selected");}%>>是</option>
         		<option value="0" <%if("0".equals(queryList[0][6].trim())){out.print("selected");}%>>否</option>
        	</select>         	
        </td>
      </tr>
      <tr>
         <td width=16% class="blue">最低分</td>
         <td width="34%">
         	<!--zhengjiang 20091005 最低分和最高分添加整数限制onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"-->
		<input id="low_score" value="<%=queryList[0][2]%>"  v_must="1" v_type="string" onkeyup="value=value.replace(/[^-?\d+$]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" onBlur="checkElement(this)" ><font class="orange">*</font>
         </td>
        <td width=16% class="blue">最高分</td>
        <td width="34%"> 
        <input id="high_score" value="<%=queryList[0][3]%>"  v_must="1" v_type="string" onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" onBlur="checkElement(this)" ><font class="orange">*</font>
        </td>
      </tr>
      <tr>
        <td width=16% class="blue">权重</td>
        <td width="34%"> 
        <!--zhengjiang 20091004 add readonly="true"-->	
        <input id="weight" name="weight" readonly="true" value="<%=(queryList[0][1].startsWith(".")?("0"+queryList[0][1]):queryList[0][1])%>" v_must="1" v_type="string" onBlur="checkElement(this);isNumber(this.value);" ><font class="orange">*</font>
        </td>
        <td width=16% class="blue">描述</td>
        <td width="34%"> 
        <input id="note" name="note" value="<%=queryList[0][4]%>"><font class="orange"></font>
        </td>
      </tr>
      
      <tr id='forId' style='<%if("Y".equals(queryList[0][7].trim())){out.print("display:none");}%>'>
         <td width=16% class="blue">计算公式</td>
         <td width="34%">
		 <input id="formula" name="formula" value="<%=queryList[0][5]%>"  v_must="1" v_type="string" onBlur="checkElement(this)" readonly ><font class="orange">*</font>
         <!--input type="button" name="confirmBtn" class="b_text" value="校验" onClick="verify();"/-->
         </td>
        <td width=16% class="blue" colspan='2'>&nbsp;</td>
      </tr>                                      
			

      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_foot" name="submit" type="button" value="确认" onclick="updateQcItem()">
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