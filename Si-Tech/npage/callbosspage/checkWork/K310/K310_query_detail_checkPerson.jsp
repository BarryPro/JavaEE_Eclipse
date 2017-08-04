<%
  /*
   * 功能: 质检员信息
　 * 版本: 1.0
　 * 日期: 2008/10/17
　 * 作者:
　 * 版权: sitech
   *
 　*/
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
String plan_id=request.getParameter("plan_id");
String sqlqc="select CHECK_LOGIN_NO from DQCCHECKLOGINPLAN where PLAN_ID= :vplan_id ";
myParams="vplan_id="+plan_id;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
	<wtc:param value="<%=sqlqc%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="rowWorkNo"  scope="end"/>	
		
<html>
<head>
<title>质检组</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<%
String select_object_id=request.getParameter("select_object_id")==null?"":request.getParameter("select_object_id");
String select_object[]=select_object_id.split(",");
%>







<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>


<script  language="javascript">
function Map(){
	this.elements=new Array();
	this.size=function(){
	return this.elements.length;
	}
this.put=function(_key,_value){
this.elements.push({key:_key,value:_value});
	}
	this.remove=function(_key){
	var bln=false;
	try{
　　for (i=0;i<this.elements.length;i++){
 　if (this.elements[i].key==_key){
　　this.elements.splice(i,1);
　　return true;
　　}
　}
　}catch(e){
　bln=false;
　　}
　　return bln;
　　}
　　this.containsKey=function(_key){
　　var bln=false;
　　try{
　　for (i=0;i<this.elements.length;i++){
　　if (this.elements[i].key==_key){
　　bln=true;
　　}
　　}
　　}catch(e){
　　bln=false;
　　}
　　return bln;
　　}
　　this.get=function(_key){
　　try{
　　for (i=0;i<this.elements.length;i++){
　　if (this.elements[i].key==_key){
　　return this.elements[i];
　　}
　　}
　　}catch(e){
　　return null;
　}
　　}
　　}
　　//测试Map的调用方法
var testmap=new Map();
　　function testMap(){
	
　　testmap.put("01","michael");
　　testmap.put("02","michael2");
	  alert (testmap.size());
	  var key="02"
　　if (testmap.containsKey(key)){
　　var element=testmap.get(key);
　　alert (element.key+"|"+element.value);
　　}else{
　　alert ("不包含"+key);
　　}
　　testmap.remove("02");
　　if (testmap.containsKey(key)){
　　var element=testmap.get(key);
　　alert (element.key+"|"+element.value);
　　}else{
　　alert ("不包含"+key);
　　}
　　} 
</script>
<%
String sqlStr="select t1.kf_login_no,t2.login_no,t2.login_name  from dloginmsgrelation t1,dloginmsg t2 where t1.BOSS_LOGIN_NO=t2.LOGIN_NO";
String retMessage="";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="row" scope="end" />
<%
	for(int i=0;i<row.length;i++)
	{
%>
<!-- 将keyValue改为boss工号值 modified by liujied 20090923 -->
<script  language="javascript">
	var keyValue='<%=row[i][1]%>';
	var valueValue='<%=row[i][2]%>';
	testmap.put(keyValue,valueValue);
</script>
<%
}
%>	
	


<script>

/*对返回值进行处理*/
function doProcessAddQcContent(packet)
{
	alert("Begin call doProcessAddQcContent()......");
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var content_id = packet.data.findValueByName("content_id");
	if(retType=="submitQcContent"){
		if(retCode=="000000"){
			alert("成功添加考评内容");
			insertTable(content_id);
			
		}else{
			alert("添加考评内容失败!");
			return false;
		}
	}
	alert("End call doProcessAddQcContent()......");
}

/**
  *
  *将考评内容插入到父页面的表格之中
  *
  */
function insertTable(content_id){
	
	var content_name   = document.getElementById("content_name").value;
	var source_id   = document.getElementById("source_id").value;
    var weight         = document.getElementById("weight").value;
    var auto_get       = document.getElementById("auto_get").value;
    var formula        = document.getElementById("formula").value;	
	var table = window.opener.document.getElementById("contentTable");
	var tr = table.insertRow();
	tr.insertCell().innerHTML = "<input type='radio' name='check_content' value='"+content_id+"'/>";
	tr.insertCell().innerHTML = content_name;
	tr.insertCell().innerHTML = source_id;
	tr.insertCell().innerHTML = weight;
	tr.insertCell().innerHTML = auto_get;
	tr.insertCell().innerHTML = formula;
}

/**
  *
  *添加考评内容
  *
  */
function submitQcContent()
{
	alert("Begin call submitQcContent()....");
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_add_qc_content.jsp","请稍后...");
    var object_id      = document.getElementById("object_id").value;
    var source_id      = document.getElementById("source_id").value;
    var content_name   = document.getElementById("content_name").value;
    var weight         = document.getElementById("weight").value;
    var auto_get       = document.getElementById("auto_get").value;
    var formula        = document.getElementById("formula").value;
    var note           = document.getElementById("note").value;
    var crete_login_no = "01";
    
    chkPacket.data.add("retType","submitQcContent");
    chkPacket.data.add("object_id", object_id);
    chkPacket.data.add("source_id", source_id);
    chkPacket.data.add("content_name", content_name);
    chkPacket.data.add("weight", weight);
    chkPacket.data.add("auto_get", auto_get);
    chkPacket.data.add("formula", formula);
    chkPacket.data.add("note", note);
    chkPacket.data.add("crete_login_no", crete_login_no);
    core.ajax.sendPacket(chkPacket,doProcessAddQcContent,true);
		chkPacket =null;
	alert("End call submitQcContent()....");
}


function gettree()
{
	 	var height = 200;
		var width = 350;
		var top = screen.availHeight/2 - height/2;
		var left=screen.availWidth/2 - width/2;
		var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no";
		//alert(winParam);
	  window.open("../../../../npage/callbosspage/checkWork/K310/K310bqcTree.jsp", "outHelp", winParam);
}
</script>

</head>
<body>

<form  name="formbar">

<input type="hidden" name="select_object_id" id="select_object_id" value="<%=select_object_id%>"/>
<input type="hidden" name="crete_login_no" id="crete_login_no" value="N"/>

<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B>质检工号群组</B></div>
    <div id="Operation_Table" style="width:100%;">
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    	

      <%
      int k=0;
      for(int i=0;i<rowWorkNo.length;i++){
      if(k%1==0){
      %>
           <tr>
                <%
                }
      %>
      	
      		
           <script language="javascript">
							if (testmap.containsKey('<%=rowWorkNo[i][0]%>')){
							var element=testmap.get('<%=rowWorkNo[i][0]%>');
							document.write("<td width='33%' class='blue' >");
							document.write('<%=rowWorkNo[i][0]%>');
							document.write("</td>");
							document.write("<td width='33%' class='blue'>");
							document.write(element.value);
							document.write("</td>");
						}
      		</script>
      	
      	<% 
			 k++;
			 if(k%1==0){
			 %>
			 </tr>
			 <%      
      }
    }
    %>
      </table>
        
       <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align="center"> 
          
        	
       		<input class="b_foot" name="deletOne" type="button"  value="退出" onclick="window.close();" >
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
 

