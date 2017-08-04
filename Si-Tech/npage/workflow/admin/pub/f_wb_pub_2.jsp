<%
/********************
 version v2.0
开发商: si-tech
********************/
%>

<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%  
		//response.setContentType("text/html;charset=gb2312");
    String wono=(String)request.getAttribute("wono");
		String wano=(String)request.getAttribute("wano");
		String xmlstr=(String)request.getAttribute("xmlStr");
 %>

<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=GBK">
			<script type="text/javascript" src="js/jquery.js"></script>
		 <base target="_self">
<title>工单处理</title>
<script language="javascript" src="/public/common.js"></script>
<link href="/css/jl.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
<!--

function insertNote(){
	return;
}

//-->
</SCRIPT>
</head>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" background="/images/jl_background_2.gif">
<form method="post" name="form1" >
<table width="767" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
  <tr>
      <td background="/images/jl_background_1.gif" bgcolor="#E8E8E8">
		  <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
			 <tr>
				<td align="right" width="45%">
				  <p><img src="/images/jl_chinamobile.gif" width="226" height="26"></p>
				</td>
				<td width="55%" align="right"><img src="/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">工号：<%=loginNo%><img src="/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">操作员：<%=workname%></td>
			 </tr>
		   </table>
		  <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
			<tr>
				<td align="right" background="/images/jl_background_3.gif" height="69">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td><img src="/images/jl_logo.gif"></td>
					<td align="right"><img src="/images/jl_head_1.gif"></td>
				  </tr>
				</table>
			  </td>
			</tr>
		  </table>
		  <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
			<tr>
			  <td align="right" width="73%">
				<table width="535" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					 <td width="42"><img src="/images/jl_ico_2.gif" width="42" height="41"></td>
					 <td valign="bottom" >
					  <table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
						<td width="335" background="/images/jl_background_4.gif"><font color="FFCC00"><b><span id="titlename">(工单编号:<%=wono%>)</span></b></font></td>
						 <td width="200"><img src="/images/jl_ico_3.gif" width="200" height="30"></td>
						</tr>
					  </table>
					</td>
				  </tr>
				</table>
			  </td>
			  <td width="27%">
				<table border="0" cellspacing="0" cellpadding="4" align="right">
				  <tr>
					<td><img src="/images/jl_ico_4.gif" width="60" height="50"></td>
					<td><img src="/images/jl_ico_5.gif" width="60" height="50"></td>
					<td><img src="/images/jl_ico_6.gif" width="60" height="50"></td>
				  </tr>
				</table>
			  </td>
			</tr>
	 </td>
	</tr> 
  </table> 
  <% System.out.println("ok here"); %> 
	<xsl:apply xmlstr="<%=xmlstr%>" xsl="/page/workflow/xml/worksheet.xsl"/>
  
  	<%--请选择组织:&nbsp;&nbsp;&nbsp;<input id='_treebutton' type=button onclick='diplaytree()' value='显示组织树'>--%>
	<div id='_tree'>
		
  <!--iframe name='treeframe' scrolling="yes"  border="0" vspace="0" hspace="0" marginwidth="0" marginheight="0" 
  	framespacing="0" frameborder="0"  width="100%" height='500'
  src="/page/common/wbgrouptree.jsp" ></iframe-->
  
	</div>
	
 <table width=98%  border=0 align="center"  cellSpacing=1 bgcolor="#FFFFFF">
  <tr class="button" align='center' width='98%'> 
  	<td ><input class="button" name="tijiao"  onClick="save(document.forms[0])" type='button' value="保存">
  		<input class="button" name="cacel1"  type='reset' value="重置">
  	  <input class="button" name="button3" type='button' onClick="saveAndSubmit(document.forms[0])" value="提交并保存"> 
  	 </td>
  </tr>
</table> 
<input type="hidden" name="wono" value="<%=wono%>">
<input type="hidden" name="wano" value="<%=wano%>">

</form>
</table>
</BODY>
</HTML>

<script>


var _region='';
function _check()
{
	/*_region=window.frames["treeframe"].document.getElementById("nullform_groupid").value;
	//验证区域是否合法
	if(_region=='')
	{
		alert('请选择组织');
		return false;
	}*/
	//如果验证回调函数存在，则调用
	if(typeof _validateForm!='undefined')
	{
		return _validateForm();
	}
	return true;
}


	function comm1(obj,url)
	{
	 var para='&_region='+_region;
		with(obj)
		{
		  for (var i=0;i<elements.length;i++){
		  	if(elements[i].type!='button')
		   	para+='&'+elements[i].name+'='+elements[i].value;
		   	
		  }
	  }
				$.ajax({
    url: url,
    type: 'POST',
    dataType: 'html',
    data:para,
    timeout: 10000,
    error: function(){
        alert('操作错误');
        window.close();
    },
    success: function(html){
			  eval(html.replace('/\r/g','').replace('/\n/g',''));
    		window.close();
    }
	});
}

function save(obj)
{
	if(_check()==false) return;
	var url='pub/f_wb_pub_3.jsp';
	comm1(obj,url);
	
}

function saveAndSubmit(obj){
	if(_check()==false) return;
	var url='pub/f_wb_pub_4.jsp';
	comm1(obj,url);
}


var _treeDisplayFlag=0;
function diplaytree()
{
	if(_treeDisplayFlag==0)
	{
		//隐藏树
		var treeid = document.getElementById("_tree");
		treeid.style.display='none';
		var treebutt = document.getElementById("_treebutton");
		treebutt.value='显示组织树';
		_treeDisplayFlag=1;
		return;
	}else
	{
		var treeid = document.getElementById("_tree");
		treeid.style.display='block';
		var treebutt = document.getElementById("_treebutton");
		treebutt.value='隐藏组织树';
		_treeDisplayFlag=0;
		return;
	}
}

</script>


