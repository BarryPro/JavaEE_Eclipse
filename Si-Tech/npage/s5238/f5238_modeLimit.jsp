<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-20
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "个人产品配置";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.text.*"%>
<%
	//读取用户session信息
	
	//获取从上页得到的信息
	String login_accept = request.getParameter("login_accept");	
	String mode_code = request.getParameter("mode_code");
	String mode_name = request.getParameter("mode_name");	
	String region_code = request.getParameter("region_code");	
	String trans_type = request.getParameter("trans_type");   					 
%>

<html>
<head>
<base target="_self">
<title>产品互斥规则配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 
//------查询产品代码-------
function queryModeCode()
{
	document.form1.action="f5238_modeLimitFrame.jsp";
	document.form1.target="middle";
	document.form1.submit();
}   
//-------提交选择的产品代码--------
function submitAdd()
{
	document.form1.conmit.disabled=true;
	top.window.document.middle.commit();
}
//--------全部选中---------
function selectAll()
{
	top.window.document.middle.selectAll();
}

//----全部取消------
function selectNone()
{
	top.window.document.middle.selectNone();
}
/**查询帐户类型**/
function querySmCode()
{
    var pageTitle = "品牌查询";
    var fieldName = "品牌代码|品牌名称|";
    var sqlStr ="select sm_code,sm_name from sSmCode  where region_code='<%=region_code%>' order by sm_code ";
	
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "sm_code_new|smNameCond|";
    if(!PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)) return false;

	return true;
}
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
    if(retInfo ==undefined)      
    { 
		return false;  
	}
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
//选择资费类型代码
function queryModeType()
{
	if(document.all.sm_code_new.value=="")
	{
	    rdShowMessageDialog("请先选择品牌代码！");
		return ;
	}

    var retToField = "modeTypeCond|modeTypeNameCond|";
    var url = "f5238_queryModeType.jsp?clear_mode_use=1&region_code=<%=region_code%>"+"&smCodeCond="+document.all.sm_code_new.value+"&retToField="+retToField;
	window.open(url,'','height=600,width=600,scrollbars=yes');
}

function doReset()
{
    document.form1.sm_code_new.value="";
	document.form1.smNameCond.value="";
	document.form1.mode_code_new.value="";
	document.form1.modeTypeCond.value="";
	document.form1.modeTypeNameCond.value="";
	document.form1.mode_name_new.value="";
	document.form1.whereSql.value="";
	document.form1.defSendFlag.value="";
}
</script>
</head>

<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">

 
	  <form name="form1"  method="post">
	  		<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">该产品代码到其他产品代码的互斥关系配置</div>
	</div>
	  	<input type="hidden" name="login_accept" value="<%=login_accept%>">
	  	<input type="hidden" name="mode_code" value="<%=mode_code%>">
	  	<input type="hidden" name="mode_name" value="<%=mode_name%>">
	  	<input type="hidden" name="region_code" value="<%=region_code%>">
	  	<input type="hidden" name="select_type" value="1">
	  	<input type="hidden" name="trans_type" value="<%=trans_type%>">
	  		  	<TABLE  id="mainOne" cellspacing="0"  >
	  				<tr  height="23">
	  					<TD colspan="4"><font class="orange">请选择需要互斥的产品代码！</font></td>
	  				</tr>
	  				<tr  height="22">
	  					<TD width="16%" class="blue">业务品牌</TD>
	  					<TD width="34%" colspan=3>
	  						<input type=text  v_type="string"  size ="8" v_must=0 v_minlength=1 v_maxlength=8 v_name="业务品牌"  name=sm_code_new maxlength=8 readonly class="InputGrey"></input>
							<input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=20 v_name="业务品牌"  name=smNameCond value="" maxlength=20 readonly class="InputGrey">
		                    <input class="b_text" type="button" name="query_smcode" onclick="querySmCode()" value="选择">
	  					</TD>
	  				</tr>
					<tr  height="22">
	  					<TD width="16%"  class="blue">产品大类</TD>
	  					<TD width="34%" colspan=3>
	  						<input type=text  v_type="string" size=8 v_must=0 v_minlength=1 v_maxlength=8 v_name="产品大类"  name=modeTypeCond maxlength=8 readonly class="InputGrey"></input>
							<input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=20 v_name="产品大类"  name=modeTypeNameCond value="" maxlength=20 readonly class="InputGrey">
		                    <input class="b_text" type="button" name="query_modeType" onclick="queryModeType()" value="选择">
	  					</TD>
	  				</tr>
					<tr  height="22">
	  					<TD width="16%"  class="blue">产品代码</TD>
	  					<TD width="34%" >
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=8 v_name="产品代码"  name=mode_code_new maxlength=8 ></input>
	  					</TD>
						<TD width="16%"  class="blue">产品名称</TD>
	  					<TD width="34%" >
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=30 v_name="产品名称"  name=mode_name_new maxlength=30 ></input>
	  					</TD>
	  				</tr>
					<tr  height="22">
	  					<TD width="16%"  class="blue">SQL条件<font class="orange">( SQL条件必须以 AND 或 and 开头，且语法正确！)</font></TD>
	  					<TD width="34%" colspan=3 >
	  						<textarea name="whereSql" rows="10" cols="75"></textarea>
	  					</TD>
	  				</tr>
					<tr>
		                <td colspan=4 align="center">
		                   <input class="b_text" type="button" name="query_smcode" onclick="queryModeCode()" value="查询">
						   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		                   <input class="b_text" type="button" name="do_reset" onclick="doReset()" value="重置">
		                </td>
	                </tr>
	  			</table>
	  			<table id="mainThree"  cellspacing="0" >
	  				<tr height="24"  >
      		    <Th width="10%" >选择</Th>
	  					<Th width="25%">产品代码</Th>
	  					<Th width="55%">产品名称</Th>
	  					<Th width="10%">生效方式</Th>
      		  		</tr>
	  				<tr  height="22">
	  					<td colspan="4">
	  						<IFRAME src="f5238_modeLimitFrame.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>&trans_type=<%=trans_type%>" frameBorder=0 id=middle name=middle scrolling="yes" style="HEIGHT: 300; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
      		  	  			</IFRAME>
      		  	  		</td>
	  				</tr>
	          	</TABLE>
	          	<TABLE cellSpacing="0" >
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	  					<input name="selectall" type="button" class="b_foot_long" value="全部选中" onClick="selectAll();">
	          	 	    &nbsp;
	          	 	    <input name="selectnone" type="button" class="b_foot_long" value="全部取消" onClick="selectNone();">
	          	 	    &nbsp;
	          	 	    <input name="conmit" type="button" class="b_foot" value="确认" onClick="submitAdd();">
	          	 	    &nbsp;
	          	 	    <input name="cancel" type="button" class="b_foot" value="取消" onClick="window.opener.document.form1.modeTransOtherButton.disabled=false;window.close();">
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  	<%@ include file="/npage/include/footer_pop.jsp" %>
	  </form>
</body>
</html>

