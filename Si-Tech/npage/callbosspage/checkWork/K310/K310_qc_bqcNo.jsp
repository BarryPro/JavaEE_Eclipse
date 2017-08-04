<%
  /**
   * 功能: 质检权限管理->质检计划管理->被质检组
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: tancf
　 * 版权: sitech
   * update:	mixh 	20090506  性能优化
　 */
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<html>
<head>
<title>被质检组</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">

<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

String sqlForWorkNo = null;
/*获得选中被质检组ID*/
String select_object_id = request.getParameter("select_object_id")==null?"":request.getParameter("select_object_id");
String tmpSel_obj_id = null;
if(!"".equals(select_object_id)){
		tmpSel_obj_id = select_object_id.replaceAll(",","','");
}
String getCountSql = "select to_char(count(*)) from DqcCheckedSerialNos where login_group_id in('" + tmpSel_obj_id + "')";
String tmpCount = "0";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:param value="<%=getCountSql%>"/>
	</wtc:service>
	<wtc:array id="getCount" scope="end"/>
<%

if(getCount.length>0){
  	tmpCount=getCount[0][0];
}
if(Integer.parseInt(tmpCount)>0){ 	
		sqlForWorkNo = "select t.serialNo from DqcCheckedSerialNos t where 1=1 and t.VALID_FLAG='Y' AND trim(t.login_group_id) in('"+tmpSel_obj_id + "')";
}else{
		/*获取被质检组中所有工号、工号姓名信息*/
		/* modified by liujied 20090923 kf_login_no 改为 boss_login_no*/   
		sqlForWorkNo = "SELECT DISTINCT t2.boss_login_no, t3.login_name " + 
		    "FROM dloginmsg t3, dqclogingrouplogin t1, dloginmsgrelation t2 " + 
		    "WHERE t2.boss_login_no = t3.login_no AND t1.login_no = t2.boss_login_no AND trim(t1.login_group_id) IN('"+tmpSel_obj_id+"')";
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

<script language="javascript">
function gettree(){
	document.getElementById("right_select_object_id").value= window.parent.frames.rightFrame.document.getElementById("select_object_id").value;
	var selectedBefore = document.getElementById("select_object_id").value;
	var time     = new Date();
	var winParam = 'dialogWidth=400px;dialogHeight=280px;toolbar=no;menubar=no;scrollbars=no;resizable=yes;location=no;status=no';
	window.showModalDialog("K310_callCauseSelectTree.jsp?time="+time+"&selectedBefore="+selectedBefore,window, winParam);
}

</script>

</head>
<body>

<form  name="formbar">

<input type="hidden" name="select_object_id" id="select_object_id" value="<%=select_object_id%>"/>
<input type="hidden" name="right_select_object_id" id="right_select_object_id" value=""/>

</form>
<form  id="tmpForm" name="tmpForm">
<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top">
    <div id="Operation_Table">
      <table id="contentTable" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td width="100%" class="blue" colspan="4">被检工号群组
      		<input type="text" name="bqcname" disabled>
      		<input type="button" name="bqcname1" class="b_text" value="..." onclick="gettree();">
      		<input type="button" id="bqcname2" name="bqcname2" class="b_text" value="定位" onclick="showCheckItemWin();">
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
			if(Integer.parseInt(tmpCount)>0){
			%>
			<td width="33%" nowrap >
      		<input type="checkbox" name="bqc" value="<%=rowWorkNo[i][0]%>" checked/>
			<% 	
							out.println(rowWorkNo[i][0]);
			}else{
			%>
      	<td width="33%" nowrap >
      		<input type="checkbox" name="bqc" value="<%=rowWorkNo[i][0]%>" checked/>
      		<%
      				out.println(rowWorkNo[i][0]);
      				out.println(rowWorkNo[i][1]);
      		
      }
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
</form>


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
	var winParam = 'dialogWidth=400px;dialogHeight=220px;toolbar=no;menubar=no;scrollbars=no;resizable=yes;location=no;status=no';
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

	var select_object_id = document.getElementById("select_object_id").value;
	if(parent!=undefined&&""!=parent){
			if(""!=parent.parent&&parent.parent!=undefined){
					var tmpFrame = parent.parent.frames["frameCheckContent"];
					if(tmpFrame!=undefined&&""!=tmpFrame){
							if(tmpFrame.document.getElementById("checkGroupNo")!=undefined&&""!=tmpFrame.document.getElementById("checkGroupNo")){
									tmpFrame.document.getElementById("checkGroupNo").value = select_object_id;
									tmpFrame.formbar.submit();
							}
					}
			}
	}
	//在新增计划页面设置标识字段，判定被检组成员是流水号还是工号 20091105
	function returnSerialType(){
			var tmpCount = '<%=tmpCount%>';
			if(parseInt(tmpCount) > 0){
				//bqc_no_ser_Type值为0表示导入被检组的成员为工号，为1标识被检组成员为流水号
					parent.parent.document.getElementById("bqc_no_ser_Type").value = "1";
					document.tmpForm.bqcname2.disabled=true;
			}else{
					document.tmpForm.bqcname2.disabled=false;
			}
	}
	
	returnSerialType();
</script>
