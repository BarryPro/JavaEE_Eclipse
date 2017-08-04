<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-16
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.util.*"%>

<html xmlns="http//www.w3.org/1999/xhtml">
	
<%
  String opCode = "2951";
  String opName = "集团业务目录配置";
%> 
 


<%
	    String regionCode = (String)session.getAttribute("regCode");
	    
%>

<%
String region = request.getParameter("region");
/*String regionName2 = request.getParameter("regionName2");*/
String regionName2 = "哈尔滨";

String productCode = request.getParameter("productCode");
if(request.getParameter("productCode")==null){
	productCode = "1";
}


String action = "manage";
String denormLevel = request.getParameter("denormLevel")==null?
						"1":request.getParameter("denormLevel");
						
String dataJsp = "f5110_productXml.jsp?command="+action	
					+"&productCode="+productCode
					+"&denormLevel="+denormLevel
					+"&region="+region
					+"&regionName2="+regionName2
					+"&isRoot=true";
					
System.out.println("datajsp="+dataJsp);
%>

<head>
<title>集团业务目录配置</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript" src="xtree/script/loader.js"></script>
<link rel="stylesheet" type="text/css" href="xtree/css/xtree.css">
<style type="text/css">
a:link,a:visited { text-decoration: none; color: #111111 }
font { font-family: 宋体; font-size: 13px; }
</style>

<script FOR=window EVENT=onload LANGUAGE="javascript">
initAd();
</script>

<SCRIPT type=text/javascript>
//控制窗体的移动
function initAd() {
document.all.operate.style.posTop = -100;
document.all.operate.style.visibility = 'visible'
MoveLayer('operate');
}

function MoveLayer(layerName) {
var x = 10;
var y = 10;
var diff = (document.body.scrollTop + y - document.all.operate.style.posTop)*.40;
var y = document.body.scrollTop + y - diff;
eval("document.all." + layerName + ".style.posTop = y");
eval("document.all." + layerName + ".style.posLeft = x");
setTimeout("MoveLayer('operate');", 20);
}


//点击根结点
function clickProd0(parentProdDirect,prodDirect){
	document.all.operate.style.display="";
	document.all.addDiv.style.display="none";
	document.all.modDiv.style.display="none";
	document.all.modDiv2.style.display="none";
	document.all.add1.disabled=false;
	document.all.mod1.disabled=true;
	document.all.del1.disabled=true;
	document.all.add1.v_parentProdDirect=parentProdDirect;
	document.all.mod1.v_parentProdDirect=parentProdDirect;
	document.all.del1.v_parentProdDirect=parentProdDirect;
	document.all.add1.v_prodDirect=prodDirect;
	document.all.mod1.v_prodDirect=prodDirect;
	document.all.del1.v_prodDirect=prodDirect;
	document.all.mod1.v_flag="";
}
	
//点击目录结点
function clickProd1(parentProdDirect,prodDirect,regionCode,prodName){
	document.all.operate.style.display="";
	document.all.addDiv.style.display="none";
	document.all.modDiv.style.display="none";
	document.all.modDiv2.style.display="none";
	document.all.add1.disabled=false;
	document.all.mod1.disabled=false;
	document.all.del1.disabled=false;
	document.all.add1.v_parentProdDirect=parentProdDirect;
	document.all.mod1.v_parentProdDirect=parentProdDirect;
	document.all.del1.v_parentProdDirect=parentProdDirect;
	document.all.add1.v_prodDirect=prodDirect;
	document.all.mod1.v_prodDirect=prodDirect;
	document.all.del1.v_prodDirect=prodDirect;
	document.all.mod1.v_flag="";
	document.all.mod1.v_prodName=prodName;
	document.all.addDiv.all.regionCode2.value=regionCode;
	document.all.modDiv.all.regionCode2.value=regionCode;
	document.all.modDiv2.all.regionCode2.value=regionCode;
}


function clickProd3(parentProdDirect,prodDirect,regionCode,prodName){
	document.all.operate.style.display="";
	document.all.addDiv.style.display="none";
	document.all.modDiv.style.display="none";
	document.all.modDiv2.style.display="none";
	document.all.add1.disabled=true;
	document.all.mod1.disabled=false;
	document.all.del1.disabled=true;
	document.all.mod1.v_parentProdDirect=parentProdDirect;
	document.all.mod1.v_prodName=prodName;
	document.all.mod1.v_prodDirect=prodDirect;
	document.all.mod1.v_flag="1";
	document.all.addDiv.all.regionCode2.value=regionCode;
	document.all.modDiv.all.regionCode2.value=regionCode;
	document.all.modDiv2.all.regionCode2.value=regionCode;
}

//关闭图层
function divClose1(){
	document.all.operate.style.display="none";
	document.all.add1.v_prodDirect="";
	document.all.mod1.v_prodDirect="";
	document.all.del1.v_prodDirect="";
}

function divClose2(obj){
	obj.parentElement.parentElement.parentElement.parentElement.parentElement.style.display="none";
}

function addProd(obj){
	document.all.addDiv.style.display="";
	document.all.modDiv.style.display="none";
	document.all.modDiv2.style.display="none";
	var prod=obj.v_prodDirect;
	
	var parentProd=obj.v_parentProdDirect;
	document.all.addDiv.all.prodDirect.value=prod;
	document.all.addDiv.all.parentProdDirect.value=parentProd;
}

function modProd(obj){
	if(obj.v_flag=="1"){
		document.all.addDiv.style.display="none";
		document.all.modDiv.style.display="none";
		document.all.modDiv2.style.display="";
		var prod=obj.v_prodDirect;
		var parentProd=obj.v_parentProdDirect;
		var prodName=obj.v_prodName;
		document.all.modDiv2.all.prodDirect.value=prod;
		document.all.modDiv2.all.parentProdDirect.value=parentProd;
		document.all.modDiv2.all.parentProdDirect.value=parentProd;
		document.all.modDiv2.all.parentProdDirectMov.value=parentProd;
		document.all.modDiv2.all.prodName.value=prodName;
	}
	else{
		document.all.addDiv.style.display="none";
		document.all.modDiv.style.display="";
		document.all.modDiv2.style.display="none";
		var prod=obj.v_prodDirect;
		var parentProd=obj.v_parentProdDirect;
		var prodName=obj.v_prodName;
		document.all.modDiv.all.prodDirect.value=prod;
		document.all.modDiv.all.parentProdDirect.value=parentProd;
		document.all.modDiv.all.parentProdDirectMov.value=parentProd;
		document.all.modDiv.all.prodName.value=prodName;
		
	}
}

function addComm(){
	getAfterPrompt();
	if(!forString(document.all.addDiv.all.prodDirectNameAdd)){
			return false;
	}
	var prodDirect=document.all.addDiv.all.prodDirect.value;
	var prodDirectNameAdd=document.all.addDiv.all.prodDirectNameAdd.value;
	document.frm.action="f5110_addSub.jsp?prodDirect="+prodDirect+"&prodDirectNameAdd="+prodDirectNameAdd;
	document.frm.submit();
}

function modComm(flag){
	getAfterPrompt();
	if(flag=="D"){
		if(!forString(document.all.modDiv.all.parentProdDirectMov)||!forString(document.all.modDiv.all.prodName)){
			return false;
		}
		var prodDirect=document.all.modDiv.all.prodDirect.value;
		var parentProdDirectMov=document.all.modDiv.all.parentProdDirectMov.value;
		var regionCode2=document.all.modDiv.all.regionCode2.value
		var prodName=document.all.modDiv.all.prodName.value
		document.frm.action="f5110_modSub.jsp?prodDirect="+prodDirect+"&parentProdDirectMov="+parentProdDirectMov+"&flag="+flag+"&regionCode2="+regionCode2+"&prodName="+prodName;
		document.frm.submit();
	}
	else if(flag=="P"){
		if(!forString(document.all.modDiv2.all.parentProdDirectMov)||!forString(document.all.modDiv2.all.prodName)){
			return false;
		}
		var prodDirect=document.all.modDiv2.all.prodDirect.value;
		var parentProdDirectMov=document.all.modDiv2.all.parentProdDirectMov.value;
		var regionCode2=document.all.modDiv2.all.regionCode2.value
		var prodName=document.all.modDiv2.all.prodName.value
		document.frm.action="f5110_modSub.jsp?prodDirect="+prodDirect+"&parentProdDirectMov="+parentProdDirectMov+"&flag="+flag+"&regionCode2="+regionCode2+"&prodName="+prodName;
		document.frm.submit();
	}
}

function delProd(obj){
	getAfterPrompt();
	var aaa=rdShowConfirmDialog("您确定删除编号为["+obj.v_prodDirect+"]的业务目录结点吗？","1"); 
	if(aaa==1){
		delComm(obj.v_prodDirect);
	}
	else{
		return;
	}
}

function delComm(prodDirect){
	document.frm.action="f5110_delSub.jsp?prodDirect="+prodDirect;
	document.frm.submit();
}
</SCRIPT>
</head>
<body>
		<form name="frm" method="post" action="">
<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">集团业务目录配置</div>
	</div>

<table  cellspacing="0">
					<tr > 
	            <td colspan="2">
								<%=regionName2%>
	            </td>
	       	</tr>
	       	
	<tr > 
			<td height="300" valign="top" nowrap width=30% >
				<script>loader();</script>
					<div id="xtree"  XmlSrc="<%=dataJsp%>"></div>
					<script language="JavaScript">
					document.all.xtree.className="xtree";
					</script>
	    </td>
	   	<td width=50% valign="left" nowrap>
	   		<div id="operate" style="display:none;position:relative;width:300;left:10;top:10;border:1 dashed #e8e8e8" >
					<table cellspacing="0">
						<tr bgcolor="#e8e8e8"height="30"> 
							<td >
								<input type="button"  class="b_text" name="add1" value="增加" style="cursor:hand" onclick="addProd(this)" v_prodDirect="" v_parentProdDirect="" v_prodName="">
								&nbsp;
								<input type="button"  class="b_text"  name="mod1" value="修改" style="cursor:hand" onclick="modProd(this)" v_prodDirect="" v_parentProdDirect="" v_flag="" v_prodName="">
								&nbsp;
								<input type="button"  name="del1"  class="b_text" value="删除" style="cursor:hand" onclick="delProd(this)" v_prodDirect="" v_parentProdDirect="" v_prodName="">
								&nbsp;
							
								<input type="button"  name="clo" class="b_text"  style="cursor:hand" value="X" onclick="divClose1()">
							</td>
						</tr>
					</table>
					<div id="addDiv" style="display:none;position:relative">
						<table cellspacing="0">
							<tr > 
								<td class="blue">
									当前业务目录代码
								</td>
								<td >
									<input type="text"  name="prodDirect" value="" readOnly Class="InputGrey">
								</td>
							</tr>
							<tr > 
								<td  class="blue">
									当前父业务目录代码
								</td>
								<td >
									<input type="text"  name="parentProdDirect" value="" readOnly Class="InputGrey">
								</td>
							</tr>
							<tr > 
								<td  class="blue">
									增加子业务目录名称
								</td>
								<td >
									<input type="text"  name="prodDirectNameAdd" v_name="增加子业务/业务目录名称" v_type="string" v_must="1">
								</td>
							</tr>
							<tr > 
								<td colspan="2" align="center" height="30" id="footer">
									<input type="hidden" name="regionCode2">
									<input  onClick="addComm()" style="cursor:hand" type=button value="确定" class="b_foot">&nbsp;
									<input  onClick="divClose2(this)" style="cursor:hand" type=button class="b_foot"  value="关闭">
								</td>
							</tr>
						</table>
					</div>
					<div id="modDiv" style="display:none;position:relative">
						<table cellspacing="0">
							<tr > 
								<td  class="blue" >
									当前业务目录代码
								</td>
								<td >
									<input type="text"  name="prodDirect" value="" readOnly Class="InputGrey">
								</td>
							</tr>
							<tr  > 
								<td   class="blue">
									当前父业务目录代码
								</td>
								<td >
									<input type="text"  name="parentProdDirect" value="" readOnly Class="InputGrey">
								</td>
							</tr>
							<tr > 
								<td   class="blue">
									移动至父业务目录代码
								</td>
								<td >
									<input type="text"  name="parentProdDirectMov" v_name="移动至父业务目录代码" v_type="string" v_must="1">
								</td>
							</tr>
							<tr > 
								<td   class="blue">
									业务目录名称
								</td>
								<td >
									<input type="text"  name="prodName" v_name="业务名称" v_type="string" v_must="1">
								</td>
							</tr>
							<tr > 
								<td colspan="2" align="center" height="30" id="footer">
									<input type="hidden" name="regionCode2">
									<input  onClick="modComm('D')" style="cursor:hand" type=button value="确定" class="b_foot">&nbsp;
									<input  onClick="divClose2(this)" style="cursor:hand" type=button value="关闭" class="b_foot">
								</td>
							</tr>
						</table>
					</div>
					<div id="modDiv2" style="display:none;position:relative">
						<table cellspacing="0">
							<tr > 
								<td  class="blue">
									当前业务代码
								</td>
								<td >
									<input type="text"  name="prodDirect" value="" readOnly Class="InputGrey">
								</td>
							</tr>
							<tr  > 
								<td  class="blue">
									当前父业务目录代码
								</td>
								<td >
									<input type="text"  name="parentProdDirect" value="" readOnly Class="InputGrey">
								</td>
							</tr>
							<tr > 
								<td  class="blue">
									移动至父业务目录代码
								</td>
								<td >
									<input type="text"  name="parentProdDirectMov" v_name="移动至父业务代码" v_type="string" v_must="1">
								</td>
							</tr>

									<input type="hidden"  name="prodName" v_name="业务名称" v_type="string" >

							<tr > 
								<td colspan="2" align="center" height="30" id="footer">
									<input type="hidden" name="regionCode2">
									<input  onClick="modComm('P')" style="cursor:hand" type=button value="确定" class="b_foot">&nbsp;
									<input  onClick="divClose2(this)" style="cursor:hand" type=button value="关闭" class="b_foot">
								</td>
							</tr>
						</table>
					</div>
				</div>
	   	</td>
	  </tr>
   <tr> 
    <td colspan="4" id="footer"> 
    	<div align="center">          
        
        <input name="kk" type="button" onClick="removeCurrentTab()"  value="关闭" class="b_foot">
      </div>
    </td>
  </tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

<script language="javascript">

	
</script>

