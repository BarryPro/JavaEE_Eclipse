<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.24
 模块: 到期资费代码配置
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

	
<%
  	response.setDateHeader("Expires", 0);
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%		
  
	String opCode  =request.getParameter("opCode");
	String opName  =request.getParameter("opName");
	
	String regionCode = (String)session.getAttribute("regCode");
	String regionName = "";
	String loginNo=(String)session.getAttribute("workNo");
	String[] inParams = new String[2];
	inParams[0] = "select region_name from sregioncode where region_code=:regionCode";
	inParams[1] = "regionCode="+regionCode;
	
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>	
	</wtc:service>	
	<wtc:array id="regionNameOut"  scope="end"/>
<%
    if(regionNameOut.length>0)
    	regionName = regionNameOut[0][0];  
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>到期资费代码配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

 
<script language="JavaScript">
<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";	 	//根据营业系统定义而修改

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  onload=function()
  {		
  }
  
  //***
  function frmCfm(){
	frm.action="f5025Cfm.jsp";
 	frm.submit();
	return true;
  }
  //***//校验
  function check(){
    var  iOpType = document.frm.opType.value;
	with(document.frm)
	{
	  if(iOpType=="0")//增加
	  {
		  if(mode_code.value==""){
			rdShowMessageDialog("请选择资费代码!");
			mode_code.focus();
			return false;
		  }
		  if(next_mode_code.value==""){
			rdShowMessageDialog("请输入到期资费代码!");
			next_mode_code.focus();
			return false;
		  }
	  }else if(iOpType=="1")//删除
	  {
		  if(mode_code.value==""){
			rdShowMessageDialog("请选择资费代码!");
			mode_code.focus();
			return false;
		  }
		  if(next_mode_code.value==""){
			rdShowMessageDialog("请输入到期资费代码!");
			next_mode_code.focus();
			return false;
		  }
	  }else if(iOpType=="2")//修改
	  {
		  if(mode_code.value==""){
			rdShowMessageDialog("请选择资费代码!");
			mode_code.focus();
			return false;
		  }
		  if(next_mode_code.value==""){
			rdShowMessageDialog("请输入到期资费代码!");
			next_mode_code.focus();
			return false;
		  }
		  if(new_next_mode_code.value==""){
			rdShowMessageDialog("请输入新到期资费代码!");
			new_next_mode_code.focus();
			return false;
		  }
	  }
	}
	return true;
  }

  function printCommit(){
  	getAfterPrompt();
	document.frm.confirm.disabled = true;
	//校验
	if(!check())
	{
	    document.frm.confirm.disabled = false;
		return false;
	}
	setOpNote();
    //提交表单
    frmCfm();	
	return true;
  }

/**查询资费代码**/
function getModeCode()
{ 
  	//调用公共js得到银行代码
    var pageTitle = "资费代码查询";
    var	iOpType = document.frm.opType.value;
	if(iOpType=="0")
	{    
	    var fieldName = "资费代码|资费名称|品牌代码|";//弹出窗口显示的列、列名
		var sqlStr ="select a.mode_code,a.mode_name,a.sm_code from sBillModeCode a,sBillModeDetail b where a.region_code=b.region_code and a.mode_code=b.mode_code and b.mode_time='Y' and b.time_flag='1' and a.region_code='<%=regionCode%>' and a.mode_flag='0' and a.mode_code like '" + codeChg("%"+(document.all.mode_code.value).trim()+"%") + "' and a.mode_name like '" + codeChg("%"+(document.all.mode_name.value).trim()+"%") + "' order by a.mode_code" ;
		//	alert(sqlStr); 
	    var selType = "S";    //'S'单选；'M'多选
	    var retQuence = "3|0|1|2|";//返回字段
	    var retToField = "mode_code|mode_name|sm_code|";//返回赋值的域
	}
	else
	{
	    var fieldName = "资费代码|资费名称|品牌代码|到期代码|到期名称|";//弹出窗口显示的列、列名
		var sqlStr ="select a.mode_code,a.mode_name,a.sm_code,c.next_mode,d.mode_name from sBillModeCode a,sBillModeMature c,sBillModeCode d where a.region_code=c.region_code and a.mode_code=c.mode_code and a.region_code=d.region_code and c.next_mode=d.mode_code and a.region_code='<%=regionCode%>' and a.mode_flag='0' and a.mode_code like '" + codeChg("%"+(document.all.mode_code.value)+"%").trim() + "' and a.mode_name like '" + codeChg("%"+(document.all.mode_name.value).trim()+"%") + "' order by a.mode_code" ;
		//alert(sqlStr);
	    var selType = "S";    //'S'单选；'M'多选
	    var retQuence = "5|0|1|2|3|4|";//返回字段
	    var retToField = "mode_code|mode_name|sm_code|next_mode_code|next_mode_name|";//返回赋值的域
	}   
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

/**查询到期资费代码**/
function getNextModeCode()
{ 
	var	iOpType = document.frm.opType.value;
    var	sqlStr="";
	with(document.frm)
	{
	  if(iOpType=="0")//增加
	  {
		sqlStr ="select '" + (document.all.mode_code.value).trim()+ "',mode_code,mode_name,'Y' from sBillModeCode where region_code='<%=regionCode%>'  and mode_code like '" + codeChg("%"+(document.all.next_mode_code.value).trim()+"%") + "' and sm_code='"+(document.all.sm_code.value).trim()+"' and mode_code!='"+(document.all.mode_code.value).trim()+"' and mode_flag='0' order by mode_code" ;
	  	//alert(sqlStr);
	  }
	  else
	  {
		sqlStr ="select a.mode_code,a.next_mode,b.mode_name,a.use_flag from sBillModeMature a, sBillModeCode b where a.region_code=b.region_code and a.next_mode=b.mode_code and  a.region_code='<%=regionCode%>'  and  a.mode_code like '" + codeChg("%"+(document.all.mode_code.value).trim()+"%") + "' and a.next_mode like '" + codeChg("%"+(document.all.next_mode_code.value).trim()+"%") + "' order by a.mode_code,a.next_mode" ;
	  }
	}
  	//调用公共js得到银行代码
    var pageTitle = "到期资费代码查询";
    var fieldName = "当前资费|到期资费|到期资费名称|有效标志|";//弹出窗口显示的列、列名
	
	//alert(sqlStr); 
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|1|2|";//返回字段
    var retToField = "next_mode_code|next_mode_name|";//返回赋值的域
    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
/**查询新资费代码**/
function getNewNextModeCode()
{ 
  	//调用公共js得到银行代码
    var pageTitle = "资费代码查询";
    var fieldName = "资费代码|资费名称|";//弹出窗口显示的列、列名
	var sqlStr ="select a.mode_code,a.mode_name from sBillModeCode a,sBillModeDetail b where a.region_code=b.region_code and a.mode_code=b.mode_code and b.time_flag='0' and b.mode_time='Y' and a.region_code='<%=regionCode%>'  and a.mode_code like '" + codeChg("%"+(document.all.new_next_mode_code.value).trim()+"%") + "' and a.mode_name like '" + codeChg("%"+(document.all.new_next_mode_name.value).trim()+"%") + "' and a.sm_code='"+(document.all.sm_code.value).trim()+"' and a.mode_code!='"+codeChg(document.all.mode_code.value).trim()+"' and a.mode_code!='"+codeChg(document.all.next_mode_code.value).trim()+"' and a.mode_flag='0' order by mode_code" ;
		//alert(sqlStr); 
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";//返回字段
    var retToField = "new_next_mode_code|new_next_mode_name|";//返回赋值的域
    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel_m.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
    if(retInfo ==undefined)      
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
	return true;
}
/****由opCode动态改变各个控件的状态*****/
function controlObj()
{
	var opType = document.frm.opType.value;
    if(opType=="0")//增加
	{
	    document.all.newFlagCodeTd.style.display="none";
		document.all.newFlagCodeTextTd.style.display="none";
		document.all.useFlagTd.colSpan="3";
	}else if(opType=="1")//删除
	{
	    document.all.newFlagCodeTd.style.display="none";
		document.all.newFlagCodeTextTd.style.display="none";
		document.all.useFlagTd.colSpan="3";
	}else if(opType=="2")//修改
	{
	    document.all.newFlagCodeTd.style.display="";
		document.all.newFlagCodeTextTd.style.display="";
		document.all.useFlagTd.colSpan="1";
	}
	return true;
}
/****拷贝源于js/common/common_check.js******/
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
/******为备注赋值********/
function setOpNote(){
	var opType = document.frm.opType.value;
	if(opType=="0")
		document.frm.op_note.value = "工号 "+(document.all.login_no.value).trim()+" 新增到期资费代码："+(document.all.mode_code.value).trim()+"->"+(document.all.next_mode_code.value).trim();
	else if(opType=="1")
		document.frm.op_note.value = "工号 "+(document.all.login_no.value).trim()+" 删除到期资费代码："+(document.all.mode_code.value).trim()+"->"+(document.all.next_mode_code.value).trim();
	else if(opType=="2")
		document.frm.op_note.value = "工号 "+(document.all.login_no.value).trim()+" 修改 "+(document.all.mode_code.value).trim()+" 到期资费代码:"+(document.all.next_mode_code.value).trim()+"改为"+(document.all.new_next_mode_code.value).trim();
	return true;
}
//-->
</script>

</head>


<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		
      <table id="mainOne" cellspacing="0">
		  <tr> 
            <td class="blue">操作类型</td>
            <td>
                <select name="opType" id="opType" onChange="controlObj();">
				   <option value="0">增加 </option>
				   <option value="1">删除 </option>
				   <option value="2">修改 </option>
			  	</select>	
				<font color="orange">*</font>
            </td>
            <td class="blue">地市代码</td>
            <td>
			  <input name="region_code_1" type="text" class="InputGrey" id="region_code_1" value='<%=regionCode+"--"+regionName%>' readonly> 
			  <input type="hidden" class="button" name="sm_code" size="25" v_must=1 v_name=原资费品牌  onclick="">
			  <input type="hidden" class="button" name="login_no" size="25" v_must=1 v_name=工号 value="<%=loginNo%>">
			</td>  
          </tr>
          <tr> 
		    <td class="blue">当前资费</td>
            <td>
			  <input type="text"  name="mode_code" size="8" maxlength="8" v_must=1  onclick="">
			  <input type="text"  name="mode_name" size="25" v_must=1 onclick=""> 
			  <font color="orange">*</font>
			  <input name=modeCodeQuery type=button class="b_text"  style="cursor:hand" onClick="getModeCode()" value=查询>
			</td>
            <td class="blue">到期资费</td>
            <td>
			  <input type="text"  name="next_mode_code" size="8" maxlength="8" v_must=1  onclick="">
			  <input type="text"  name="next_mode_name" size="25" v_must=1 onclick="">
			  <font color="orange">*</font>
			  <input name=nextModeCodeQuery type=button class="b_text"  style="cursor:hand" onClick="getNextModeCode()" value=查询>
			</td>   			
          </tr>
		  <tr> 		    
			<td class="blue">有效标志</td>
            <td  id="useFlagTd" colspan="3">
                <select name="useFlag" id="useFlag" class="button" >
				   <option value="Y">是</option>
				   <option value="N">否</option>
			  	</select>	
				<font color="orange">*</font>
            </td> 
            <td id="newFlagCodeTextTd" style="display:none" class="blue">新到期资费</td>
            <td id="newFlagCodeTd" style="display:none">
			  <input type="text"  name="new_next_mode_code" size="8" maxlength="8" v_must=1  onclick="">
			  <input type="text"  name="new_next_mode_name" size="25" v_must=1  onclick=""> 
			  <font color="orange">*</font>
			  <input name=newNextModeCodeQuery type=button class="b_text"  style="cursor:hand" onClick="getNewNextModeCode()" value=查询>
			</td> 
          </tr>
		  <tr> 
            <td class="blue">备注</td>
            <td colspan="4">
             <input name="op_note" type="text" class="InputGrey" readOnly id="op_note" size="60" maxlength="60" onFocus="setOpNote();"> 
            </td>
          </tr>
		  <tr> 
            <td colspan="4" id="footer"> <div align="center"> 
                &nbsp; 
				<input name="confirm" id="confirm" type="button" class="b_foot"   value="确定" onClick="printCommit()">
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="清除" >
                &nbsp; 
                <input name="close" onClick="removeCurrentTab()" type="button" class="b_foot" value="关闭">
                &nbsp; 
				
				</div>
			</td>
          </tr>
      </table>
 <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>

