<%
  /*
   * 功能: 总计划计划修改被质检组
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: tancf
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

String plan_id=request.getParameter("plan_id");
String content_id=request.getParameter("content_id");
String object_id=request.getParameter("object_id");
String getSLnoSql = "select t1.login_no from DQCLOGINPLAN t1 " +
		"where  t1.PLAN_ID = :plan_id and t1.content_id = :content_id and t1.object_id = :object_id" ;
myParams = "plan_id="+plan_id+",content_id="+content_id+",object_id="+object_id ;
String getFirstNo = "";	
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
	<wtc:param value="<%=getSLnoSql%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="rowWSNo"  scope="end"/>
<%
if(rowWSNo.length>0){
  	getFirstNo = rowWSNo[0][0];
}
String sqlbqc = null;
if(getFirstNo.startsWith("kf")){
		/*modify by zhengjiang 20090927 sqlbqc中显示字段和第二个条件t2.kf_login_no改为t2.boss_login_no*/
		sqlbqc = "select t2.boss_login_no, t3.login_name  from dloginmsg t3, DQCLOGINPLAN t1, dloginmsgrelation t2 " +
				"where t2.boss_login_no = t3.login_no  AND t1.LOGIN_NO = t2.boss_login_no " +
				"AND t1.PLAN_ID = :plan_id and  t1.content_id  = :content_id and  t1.object_id  = :object_id" ;	
		myParams = "plan_id="+plan_id+",content_id="+content_id+",object_id="+object_id;	
}else{
		sqlbqc = "select t1.login_no from DQCLOGINPLAN t1 " +
				"where  t1.PLAN_ID = :plan_id and t1.content_id = :content_id and t1.object_id = :object_id " ;
	  myParams = "plan_id="+plan_id+",content_id="+content_id+",object_id="+object_id;
}
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
			<wtc:param value="<%=sqlbqc%>"/>
			<wtc:param value="<%=myParams%>"/>
		</wtc:service>
<wtc:array id="rowWorkNo"  scope="end"/>
<html>
<head>
<title>被质检组</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<%
String select_object_id=request.getParameter("select_object_id")==null?"":request.getParameter("select_object_id");
String select_object[]=select_object_id.split(",");
%>

<script language="javascript">
	
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

function gettree()
{
	 	var height = 200;
		var width = 350;
		var top = screen.availHeight/2 - height/2;
		var left=screen.availWidth/2 - width/2;
		var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=no,menubar=no,scrollbars=no, resizable=yes,target=_blank,location=no, status=no";
		//alert(winParam);
	  window.open("../../../../npage/callbosspage/checkWork/K310/K310_callCauseSelectTree.jsp", "outHelp", winParam);
}
</script>

</head>
<body>

<form  name="formbar">

<input type="hidden" name="select_object_id" id="select_object_id" value="<%=select_object_id%>"/>
</form>
<!--zhengjiang 20091005
<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B>被质检组</B></div>
	-->
	<!--zhengjiang 20091005 start-->
	<form id="tmpForm" name="tmpForm">
    <div id="Operation_Table" style="width:410px">   
    <table style="width:390px" border="0" cellpadding="0" cellspacing="0">
    	<tr>
      	<td width="100%" class="blue" colspan="4" align="right">
      		<div class="title"><div id="title_zi" >被质检组</div></div>  
      	</td>
      </tr>
  <!--zhengjiang 20091005 end-->  	
      <tr>
      	<td width="100%" class="blue" colspan="4" align="right">
      		<input type="button" name="bqcname2" value="定位" class="b_text" onclick="showCheckItemWin();">
      	</td>
      </tr>
      <%
      int k=0;
    if(getFirstNo.startsWith("kf")){
      for(int i=0;i<rowWorkNo.length;i++){
		      if(k%3==0){
		      %>
					 <tr>
					<%
					}
					%>
		      	<td width="33%" nowrap >
		      		<input type="hidden" name="st" value="ststst"/>
		      		<input type="checkbox" name="bqc" value="<%=rowWorkNo[i][0]%>" checked>
		      		<%
		      				out.print(rowWorkNo[i][0]);
		      				out.print(rowWorkNo[i][1]);
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
   }else{
   		for(int i=0;i<rowWorkNo.length;i++){
		      if(k%3==0){
		      %>
					 <tr>
					<%
					}
					%>
		      	<td width="33%" nowrap >
		      		<input type="hidden" name="st" value="ststst"/>
		      		<input type="checkbox" name="bqc" value="<%=rowWorkNo[i][0]%>" checked>
		      		<%
		      				out.print(rowWorkNo[i][0]);
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
   }
    %>
      </table>
    </div>
  </form>
    <!--zhengjiang 20091005
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
-->

</body>
</html>

<script language="javascript">
	
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


	
function showCheckItemWin(){

	var time     = new Date();
	var winParam = 'dialogWidth=450px;dialogHeight=220px';
	window.showModalDialog("K310_selectCheckOrUnCheckWin.jsp?time="+time,window, winParam);
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
        if ((el[i].type == "checkbox") && (el[i].name == 'bqc')) {
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

//当被检组成员为流水号时，将定位按钮置为不可用 20091105
	function setButtType(){
			var getFirstNo = '<%=getFirstNo%>';
			if(getFirstNo.substr(0,2) == "kf"){
					document.tmpForm.bqcname2.disabled=false;
			}else{
					document.tmpForm.bqcname2.disabled=true;
			}
	}
	
	setButtType();
</script>
 

