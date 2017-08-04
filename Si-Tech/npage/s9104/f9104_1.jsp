<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
    String opCode = "9104";
    String opName = "自动校验规则配置";
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");	
	String op_name = "自动校验规则配置";
	String regionCode = (String)session.getAttribute("regCode");
    	//ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
    	//String[][] baseInfoSession = (String[][])arrSession.get(0);
    	//String[][] otherInfoSession = (String[][])arrSession.get(2);
	String orgCode = (String)session.getAttribute("orgCode");
	    //String[][] pass = (String[][])arrSession.get(4);
	String password  = (String)session.getAttribute("password");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!-- 
    //core.loadUnit("debug");
    //core.loadUnit("rpccore");
onload=function() {
	 self.status="";
	 showtbs1();
	    //core.rpc.onreceive = doProcess;
}
var numStr="0123456789";
  	function showtbs1()
	{	
			tbs1.style.display="";
			tbs2.style.display="none";
			document.all.font1.color='003399';
			document.all.font2.color='999999';
	}
		function showtbs2()
	{	
			tbs1.style.display="none";
			tbs2.style.display="";
			document.all.font1.color='999999';
			document.all.font2.color='003399';
	}
function doProcess(packet){
	var op_type = packet.data.findValueByName("op_type");
	if(op_type==0){
	var countNum = packet.data.findValueByName("countNum");
	document.frm1.check_id.value= countNum;

		}
		if(op_type==1){
			var check_rule = packet.data.findValueByName("check_rule");
			var localcode = packet.data.findValueByName("localcode");
			var err_code = packet.data.findValueByName("err_code");
			var err_desc = packet.data.findValueByName("err_desc");
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
			if( parseInt(errCode) == 0 ){
			document.frm2.check_rule.value= check_rule;
			document.frm2.err_code.value= err_code;
			document.frm2.err_desc.value= err_desc;
			document.frm2.local_flag.value= localcode;
				
							
		}else{
			rdShowMessageDialog("错误："+errMsg,0);
		}
			}
	}
	
function getCheckId(){
  var op_type = "0";
	var myPacket = new AJAXPacket("f9104_2.jsp","正在验证，请稍候......");
	
	myPacket.data.add("op_type",op_type);
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}
function isMadeOf(val,str)
{

	var jj;
	var chr;
	for (jj=0;jj<val.length;++jj){
		chr=val.charAt(jj);
		if (str.indexOf(chr,0)==-1)
			return false;			
	}
	
	return true;
}
function checkId(){
		getCheckId();
		document.frm1.submit1.disabled=false;
	}
 	function fsubmit1()
	{
    var checkId = document.frm1.check_id.value;
    var checkName = document.frm1.check_name.value;
    var func_code = document.frm1.func_code.value;
    var check_rule = document.frm1.check_rule.value;
    var err_code = document.frm1.err_code.value;
    var err_desc =document.frm1.err_desc.value;
    
    
    
    if(checkId.length != 6){
    	rdShowMessageDialog("校验编码为6位有效数字");
    	document.frm1.check_id.focus();
    	document.frm1.submit1.disabled=true;
      return false;
    	}
		if(checkId = ""){
			rdShowMessageDialog("请输入校验编码！");
			document.frm1.check_id.focus();
			document.frm1.submit1.disabled=true;
			return false;
			}
		if(checkName.length > 100){
			rdShowMessageDialog("校验规则名称最长为100个字符!");
    	document.frm1.checkName.focus();
    	document.frm1.submit1.disabled=true;
      return false;
			}	
		if(func_code.length > 6){
			rdShowMessageDialog("业务类别编码最长为6位!");
    	document.frm1.func_code.focus();
    	document.frm1.submit1.disabled=true;
      return false;
			}	
		if(check_rule.length > 1000){
			rdShowMessageDialog("验证规则长度不超过1000个字符!");
    	document.frm1.check_rule.focus();
    	document.frm1.submit1.disabled=true;
      return false;
			}	
		if(err_code.length > 6){
			rdShowMessageDialog("错误代码不超过6位!");
    	document.frm1.err_code.focus();
    	document.frm1.submit1.disabled=true;
      return false;
			}	
		if(err_desc.length > 128){
			rdShowMessageDialog("错误描述不超过128位字符!");
    	document.frm1.err_desc.focus();
    	document.frm1.submit1.disabled=true;
      return false;
			}	
			
		if(document.frm1.op_note.value==""){
			document.frm1.op_note.value="操作员：<%=workNo%>对自动校验规则："+document.frm1.check_id.value+"进行添加";
		}
		document.frm1.action="f9104_4.jsp"; 
		document.frm1.submit();
	} 
	 	function fsubmit2()
	{
		var checkId = document.frm2.check_id.value;
		var checkName = document.frm2.check_name.value;
    var func_code = document.frm2.func_code.value;
    var check_rule = document.frm2.check_rule.value;
    var err_code = document.frm2.err_code.value;
    var err_desc =document.frm2.err_desc.value;
		if (!isMadeOf(checkId,numStr)){
      flag = 1;
      rdShowMessageDialog("'" + checkId + "'的值不正确！请输入数字！");
	  document.frm2.check_id.focus();
	  return false;
    }
    if(checkId.length != 6){
    	rdShowMessageDialog("校验编码为6位有效数字");
    	document.frm2.check_id.focus();
   
      return false;
    	}		
    		if(checkName.length > 100){
			rdShowMessageDialog("校验规则名称最长为100个字符!");
    	document.frm2.checkName.focus();
    	
      return false;
			}	
		if(func_code.length > 6){
			rdShowMessageDialog("业务类别编码最长为6位!");
    	document.frm2.func_code.focus();
    
      return false;
			}	
		if(check_rule.length > 1000){
			rdShowMessageDialog("验证规则长度不超过1000个字符!");
    	document.frm2.check_rule.focus();
    	
      return false;
			}	
		if(err_code.length > 6){
			rdShowMessageDialog("错误代码不超过6位!");
    	document.frm2.err_code.focus();
    	
      return false;
			}	
		if(err_desc.length > 128){
			rdShowMessageDialog("错误描述不超过128位字符!");
    	document.frm2.err_desc.focus();
    	
      return false;
			}		
    	
		if(document.frm2.op_note.value==""){
			document.frm2.op_note.value="操作员：<%=workNo%>对自动校验规则："+document.frm1.check_id.value+"进行修改";
		}
		document.frm2.action="f9104_5.jsp"; 
		document.frm2.submit();
	} 
	
 function PubSimpSelBD(pageTitle,fieldName,sqlStr,varStr,selType,retQuence,retToField,serviceName,routerKey,routerValue)
	{
	    var path = "/npage/public/fPubSimpSelBD.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType;
	    path = path + "&serviceName=" + serviceName;
	    path = path + "&routerKey=" + routerKey;
	    path = path + "&routerValue=" + routerValue;
	    path = path + "&varStr=" + varStr;
		
		var params = document.frm2.check_id.value+"|";
		path = path + "&params="+params;
	
	    retInfo = window.showModalDialog(path);
		if(typeof(retInfo) == "undefined")     
	    {   return false;   }
	    else{
	    var chPos_field = retToField.indexOf("|");
	    var chPos_retStr;
	    var valueStr;
	    var obj;
	    while(chPos_field > -1)
	    {
	        obj = retToField.substring(0,chPos_field);
	        chPos_retInfo = retInfo.indexOf("|");
	        valueStr = retInfo.substring(0,chPos_retInfo);
	        document.frm2(obj).value = valueStr;
	        retToField = retToField.substring(chPos_field + 1);
	        retInfo = retInfo.substring(chPos_retInfo + 1);
	        chPos_field = retToField.indexOf("|");
	        
	    }
	    getrule();
	  }
	}
	
	/**查询校验代码**/
function getFlagCode()
{ 
	//调用公共js得到银行代码
	var check_id = document.frm2.check_id.value;
	var pageTitle = "校验编码查询";
	var fieldName = "校验编码|校验名称|业务类别编码|";

	var sqlStr = "90000264";	 
	
	var varStr="check_id="+check_id; 
	var selType = "S";    //'S'单选；'M'多选
	var retQuence = "3|0|1|2|";
	var retToField = "check_id|check_name|func_code|";
	var serviceName = "TlsPubSelCrm";
	var routerKey = "region";
	var routerValue = "<%=regionCode%>";
	PubSimpSelBD(pageTitle,fieldName,sqlStr,varStr,selType,retQuence,retToField,serviceName,routerKey,routerValue)
		
	
}
function 	getrule(){
		var checkId = document.frm2.check_id.value;
		var  op_type = "1";
		if (!isMadeOf(checkId,numStr)){
      flag = 1;
      rdShowMessageDialog("'" + checkId + "'的值不正确！请输入数字！");
	  document.frm2.check_id.focus();
	  return false;
    }
	  
	var myPacket = new AJAXPacket("f9104_3.jsp","正在验证，请稍候......");
	myPacket.data.add("checkId",document.frm2.check_id.value);
	myPacket.data.add("op_type",op_type);
	core.ajax.sendPacket(myPacket);
	myPacket = null;
	
	}

	
	
-->
</script>
</head>
<body>
	<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	<%@ include	file="/npage/include/header.jsp"%>
	<div class="title">
    	<div id="title_zi">自动校验规则配置</div>
    </div>

<table cellSpacing="0">
<tr>
    <TD  style="height=100%" width="5%" nowrap>
        <a id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs1()" value="1">&nbsp;&nbsp;<font id="font1" color='003399'>增加&nbsp;&nbsp;</font></a></TD>
    <TD  style="height=100%" width="5%" nowrap>
        <a id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs2()" value="1">&nbsp;&nbsp;<font id="font2" >修改&nbsp;&nbsp;</font></a></TD>
    <td width="80%">&nbsp;</td> 
</tr>  
</table>
  <!--添加-->
   <div id=tbs1 style='display:'>
		<table cellSpacing="0">
			 <form name="frm1" method="POST" action="">
					<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
					<input type="hidden" name="opCode" value="9104">
					<input type="hidden" name="loginNo" value="<%=workNo%>">
					<input type="hidden" name="loginPwd" value="<%=password%>">
					<input type="hidden" name="orgCode" value="<%=orgCode%>">
					<input type="hidden" name="systemNote" value="">
			<tr>
				<td class="blue">
					操作类型
				</td>
				<td align="left" colspan="3">
					<select name="opType">
						<option value='0' selected readonly>添加</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="blue">
					校验编码
				</td>
				<td align="left" colspan="3">
					<input type="text" readonly name="check_id">
					<input type="button" class="b_text" value="获取" onclick="checkId()">
				</td>
			</tr>
			<tr>
				<td class="blue">
					校验名称
				</td>
				<td align="left" colspan="3">
					<input type="text" name="check_name" maxlength="100">
				</td>
			</tr>
			<tr>
				<td class="blue">
					业务类别编码
				</td>
				<td align="left" colspan="3">
					<input type="text" name="func_code" maxlength="6">
				</td>
			</tr>
			<tr>
				<td class="blue">
					校验规则
				</td>
				<td align="left" colspan="3">
					<input type="text" name="check_rule" size="80" maxlength="1000">
				</td>
			</tr>
			<tr>
				<td class="blue">
					错误代码
				</td>
				<td align="left">
					<input type="text" name="err_code" maxlength="6">
				</td>
				<td class="blue">
					本地业务标志
				</td>
				<td align="left">
					<select name="local_flag">
						<option value='0'>本地</option>
						<option value='1'>全网</option>
					</select>
				</td>				
			</tr>
			<tr>
				<td class="blue">
					错误描述
				</td>
				<td align="left" colspan="3">
					<input type="text" name="err_desc" size="80" maxlength="128">
				</td>
			</tr>
			<tr>
				<td class="blue">
					备&nbsp;&nbsp;&nbsp;&nbsp;注
				</td>
				<td align="left" colspan="3">
					<input type="text" name="op_note" size="80" class="InputGrey" readOnly>
				</td>
			</tr>					
		</table>
		<table cellSpacing="0">
			<tr>
				<td id="footer">
					<div align="center">
						<input type="button" name="submit1" value="增加" class="b_foot" onclick="fsubmit1()" disabled/>
						<input type="reset" name="reset" value="重置" class="b_foot"/>
						<input type="button" name="goback" value="关闭" class="b_foot" onclick="removeCurrentTab()"/>
					</div>
				</td>
			</tr>
		</table>
			</form>	
	</div>
	<!--修改-->
	 <div id=tbs2 style='display:none'>
		<table cellSpacing="0">
			 <form name="frm2" method="POST" action="">
			 		<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
					<input type="hidden" name="opCode" value="9104">
					<input type="hidden" name="loginNo" value="<%=workNo%>">
					<input type="hidden" name="loginPwd" value="<%=password%>">
					<input type="hidden" name="orgCode" value="<%=orgCode%>">
					<input type="hidden" name="systemNote" value="">
			<tr>
				<td class="blue">
					操作类型
				</td>
				<td align="left" colspan="3">
					<select name=op_type>
						<option value='1'  selected readonly>修改</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="blue">
					校验编码
				</td>
				<td align="left" colspan="3">
					<input type="text" name="check_id">
					<input type="button" class="b_text" value="查询" onclick="getFlagCode()">
				</td>
			</tr>
			<tr>
				<td class="blue">
					校验名称
				</td>
				<td align="left" colspan="3">
					<input type="text" name="check_name" maxlength="100">
				</td>
			</tr>
			<tr>
				<td class="blue">
					业务类别编码
				</td>
				<td align="left" colspan="3">
					<input type="text" name="func_code" maxlength="6">
				</td>
			</tr>
			<tr>
				<td class="blue">
					校验规则
				</td>
				<td align="left" colspan="3">
					<input type="text" name="check_rule" size="80" maxlength="999">
				</td>
			</tr>
			<tr>
				<td class="blue">
					错误代码
				</td>
				<td align="left">
					<input type="text" name="err_code" maxlength="6">
				</td>
				<td class="blue">
					本地业务标志
				</td>
				<td align="left">
					<select name="local_flag">
						<option value='0'>本地</option>
						<option value='1'>全网</option>
					</select>
				</td>				
			</tr>
			<tr>
				<td class="blue">
					错误描述
				</td>
				<td align="left" colspan="3">
					<input type="text" name="err_desc" size="80" maxlength="128">
				</td>
			</tr>				
			<tr>
				<td class="blue">
					备&nbsp;&nbsp;&nbsp;&nbsp;注
				</td>
				<td align="left" colspan="3">
					<input type="text" name="op_note" size="80" class="InputGrey" readOnly>
				</td>
			</tr>						
		</table>
		<table cellSpacing="0">
			<tr>
				<td id="footer">
					<div align="center">
						<input type="button" name="submit2" value="修改" class="b_foot" onclick="fsubmit2()"/>
						<input type="reset" name="reset" value="重置" class="b_foot"/>
						<input type="button" name="goback" value="关闭" class="b_foot" onclick="removeCurrentTab()"/>
					</div>
				</td>
			</tr>
			</form>	
		</table>
	</div>
	<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>
