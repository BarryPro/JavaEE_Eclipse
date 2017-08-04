
<%
  /*
   * 功能: 质检工号群组导入
　 * 版本: 1.0
　 * 日期: 2008/10/17
　 * 作者:
　 * 版权: sitech
   *
 　*/
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page import="java.util.HashMap"%>
<html>
<head>
<title>质检工号组</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

String select_object_id=request.getParameter("select_object_id")==null?"":request.getParameter("select_object_id");
String select_object[]=select_object_id.split(",");
%>

<%
//modified by liujied 20090923
/*
String sqlForWorkNo= "SELECT DISTINCT t2.boss_login_no, t3.login_name " + 
                      "FROM dloginmsg t3, DQCCHECKGROUPLOGIN t1, dloginmsgrelation t2 " + 
                      "WHERE t2.boss_login_no = t3.login_no AND trim(t1.CHECK_GROUP_ID) IN('";
*/
String sqlForWorkNo= "SELECT DISTINCT t2.boss_login_no, t3.login_name " + 
                      "FROM dloginmsg t3, DQCCHECKGROUPLOGIN t1, dloginmsgrelation t2 " + 
                      "WHERE t2.boss_login_no = t3.login_no AND trim(t1.CHECK_GROUP_ID) IN('";
for(int i=0;i<select_object.length;i++)
{
if((i+1)==select_object.length)
{
sqlForWorkNo=sqlForWorkNo+select_object[i]+"') AND t1.CHECK_LOGIN_NO = t2.boss_login_no ";
}
else
{
sqlForWorkNo=sqlForWorkNo+select_object[i]+"','";
}
}
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
	<wtc:param value="<%=sqlForWorkNo%>"/>
</wtc:service>
<wtc:array id="rowWorkNo" scope="end" />

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script>


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

</script>

</head>
<body>

<form  name="formbar">

<input type="hidden" name="select_object_id" id="select_object_id" value="<%=select_object_id%>"/>
<input type="hidden" name="crete_login_no" id="crete_login_no" value="N"/>
<input type="hidden" name="left_select_object_id" id="left_select_object_id" value=""/>
</form>

<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top">
    <div id="Operation_Table">
      <table id="contentTable" width="100%" border="0" cellpadding="0" cellspacing="0">
       <tr>
      	<td width="100%" class="blue" colspan="4">质检工号群组
      		<input type="text" name="bqcname" disabled>
      		<input type="button" name="bqcname1" class="b_text" value="..." onclick="gettree();">
      			<input type="button" name="bqcname2" class="b_text" value="定位" onclick="showCheckItemWin();">
      	</td>
      </tr>
      <%
      int k=0;
      for(int i=0;i<rowWorkNo.length;i++){
      if(k%3==0){
      %>
			 <tr>
			<%
			}
			%>
      	
      		<td width='33%' >
      			<input type='checkbox' name='qc' value='<%=rowWorkNo[i][0]%>' checked >
      		  <%
      				out.print(rowWorkNo[i][0]);
      				out.println(rowWorkNo[i][1]);
      		  %>
      		</td> 
      	
      <%
			 k++;
			 if(k%3==0){
			 %>
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
</table>

</body>
</html>
 
 <script language="javascript">

function showCheckItemWin(){
	var time     = new Date();
	var winParam = 'dialogWidth=400px;dialogHeight=220px;toolbar=no;menubar=no;scrollbars=no;resizable=yes;location=no;status=no';
	window.showModalDialog("K310_selectCheckOrUnCheckWin.jsp?time="+time,window, winParam);
}

function gettree(){
	document.getElementById("left_select_object_id").value= window.parent.frames.leftFrame.document.getElementById("select_object_id").value;
	var tmpLeftSelectObjectId = document.getElementById("left_select_object_id").value;
	if(tmpLeftSelectObjectId==""||tmpLeftSelectObjectId==undefined){
		similarMSNPop("请先选择质检工号群组！");
		return false;
	}
	
	var selectedBefore = document.getElementById("select_object_id").value;
	var time     = new Date();
	var winParam = 'dialogWidth=400px;dialogHeight=280px;toolbar=no;menubar=no;scrollbars=no;resizable=yes;location=no;status=no';
	window.showModalDialog("K310bqcTree.jsp?time="+time+"&selectedBefore="+selectedBefore,window, winParam);
}


	/**
  *范围选择函数
  */
function selectRange(flag, start, end) {
    var el = document.getElementsByTagName('input');
    var len = el.length;
    /*modify by zhengjiang 20090927 start 加.substring(2)*/
    if(flag == '0'){
	    for (var i = 0; i < len; i++) {
	    	if(Math.floor(el[i].value.substring(2)) >= Math.floor(start) && Math.floor(el[i].value.substring(2)) <= Math.floor(end)){
	    		el[i].checked = true;
	    	}
	    }    	
    }else if(flag == '1'){
	    for (var i = 0; i < len; i++) {
	    	
	    	if(Math.floor(el[i].value.substring(2)) >= Math.floor(start) && Math.floor(el[i].value.substring(2)) <= Math.floor(end)){
	    		el[i].checked = false;
	    	}
	    } 
    }
    /*modify by zhengjiang 20090927 end*/
}

function   findInPage(str)     
  {     
    var   txt,   i,   found,n   =   0;     
    if   (str == "")     
    {     
      return   false;     
    }     
    txt   =   document.body.createTextRange();     
    for   (i   =   0;   i   <=   n   &&   (found   =   txt.findText(str))   !=   false;   i++)     
    {     
      txt.moveStart("character",   1);     
      txt.moveEnd("textedit");     
    }     
    if   (found)     
    {     
      txt.moveStart("character",   -1);     
      txt.findText(str);     
      txt.select();     
      txt.scrollIntoView();     
      n++;         
    }else{     
      if   (n   >   0){     
        n   =   0;     
        findInPage(str);     
      }else{     
    
      }     
    }     
    return   false;     
  }
  
  
  //范围选择定位功能
function selectCheckLoginNo(flag,loginNo) {
    var el = document.getElementsByTagName('input');
    var len = el.length;
    for (var i = 0; i < len; i++) {
        if ((el[i].type == "checkbox") && (el[i].name == 'qc')) {

            if(loginNo==el[i].value){
            	if(flag=='0'){
            	 el[i].checked = true;
            	}
            if(flag=='1'){
            	el[i].checked = false;
            	}	 
            	}
        }
    }
}
</script>
