<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
String flag = ( null == request.getParameter("flag") ? "" : request.getParameter("flag") );
String searchName = ( null == request.getParameter("searchName") ? "" : request.getParameter("searchName") );
String calledNo = ( null == request.getParameter("calledNo") ? "" : request.getParameter("calledNo") );
String userClass = ( null == request.getParameter("userClass") ? "" : request.getParameter("userClass") );
String cityCode = ( null == request.getParameter("cityCode") ? "" : request.getParameter("cityCode") );
System.out.println("呼叫转移参数测试.\tsearchName="+searchName+"\tflag="+flag+"\t&calledNo="+calledNo+"\t&calledNo="+calledNo+"\t&userClass="+userClass+"\t&cityCode="+cityCode);
String sqlStr = "";
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
StringBuffer searchStr = new StringBuffer();
if(!"".equals(searchName)){
if(flag.equals("0")){
    sqlStr = " select a.id,a.superid ,a.typeid,a.servicename,a.ttansfercode,a.digitcode,a.userclass,a.usertype from DSCETRANSFERTAB a where 1=1 ";
    if(!calledNo.equals("")){
    	sqlStr += " and a.accesscode = :calledNo ";
	    myParams = "calledNo="+calledNo;
    }
    if(!userClass.equals("")){
    	sqlStr +=" and a.userclass = :userClass ";
	    myParams = myParams + ",userClass="+userClass;
    }
    if(!cityCode.equals("")){
    sqlStr += " and a.citycode = :cityCode ";
    }
    sqlStr += " and a.servicename like '%:searchName%'  ";
    sqlStr += " and a.typeid not in('0','1','2','3') and not exists( select 1 from DSCETRANSFERTAB b where b.id=a.superid) order by a.id" ;
    myParams = myParams + ",cityCode="+cityCode+",searchName="+searchName;
   }
   }
   else{
     sqlStr = " select a.id,a.superid ,a.typeid,a.servicename,a.transfercode,a.digitcode,a.userclass,a.usertype from DZXSCETRANSFERTAB a where 1=1 ";
     if(!calledNo.equals("")){
    	sqlStr += " and a.accesscode = :calledNo ";
	    myParams = "calledNo="+calledNo;
    }
    if(!userClass.equals("")){
    	sqlStr +=" and a.userclass = :userClass ";
	    myParams = myParams + ",userClass="+userClass;
    }
    if(!cityCode.equals("")){
      sqlStr += " and a.citycode = :cityCode ";
     }
     sqlStr += " and a.servicename like '%"+searchName+"%' ";
     myParams = myParams + ",cityCode="+cityCode+",searchName="+searchName;
     sqlStr += " and not exists( select 1 from DZXSCETRANSFERTAB b where b.id=a.superid) order by a.id" ;
   }
System.out.println("呼叫转移.sql.");
System.out.println(sqlStr);
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
<wtc:param value="<%=sqlStr%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>	
<% 

for (int i = 0; i < queryList.length; i++) {
	searchStr.append("<item text= \"" + queryList[i][3]+ "\"");    
    searchStr.append("  id= \"" + queryList[i][0] + "\"");    
  if(queryList[i][2].equals("2001")||queryList[i][2].equals("2003")){
	  searchStr.append(" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">");
        //xml.append(" child=\"1\">");   
    }else {    
    	searchStr.append(" im0=\"leaf.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">"); 
        //xml.append(" child=\"0\">");     
    }
  searchStr.append("<userdata name='typeid'>"+queryList[i][2]+"</userdata>");  
  searchStr.append("<userdata name='super_id'>"+queryList[i][1]+"</userdata>");   
  searchStr.append("<userdata name='servicename'>"+queryList[i][3]+"</userdata>");
  searchStr.append("<userdata name='ttansfercode'>"+queryList[i][4]+"</userdata>"); 
  searchStr.append("<userdata name='digitcode'>"+queryList[i][5]+"</userdata>"); 
  searchStr.append("<userdata name='userclass'>"+queryList[i][6]+"</userdata>"); 
  searchStr.append("<userdata name='usertype'>"+queryList[i][7]+"</userdata>"); 
  searchStr.append("</item>"); 
   }
searchStr.append("</tree>");
}
%>

<html>
<head>
<title>人工转自动</title>
<script language="JavaScript" src="<%= request.getContextPath() %>/njs/csp/CCcommonTool.js"></script>
</head>
<body>
<style>
body {
	margin: 0;
	padding: 0;
	font: 12px Verdana, Arial, Helvetica, sans-serif, "宋体" ， "黑体";
	line-height: 1.8em;
	text-align: left;
	color: #003399;
	background-color: #eef2f7;
}
html {
	scrollbar-face-color: #d5e1f7;
	scrollbar-highlight-color: #FFFFFF;
	scrollbar-shadow-color: #DEEBF7;
	scrollbar-3dlight-color: #89b3e3;
	scrollbar-arrow-color: #121f54;
	scrollbar-track-color: #F4F0EB;
	scrollbar-darkshadow-color: #89b3e3;
	overflow: hidden;
}
</style>
<div id="Operation_Table"
	style="width: 100%; padding: 0px; height: 310px;">
<form name="form1" method="POST" style="padding: 0;" action="">
<!-- 接入码 -->
		<input type="hidden" id="CalledNo" name="CalledNo" value=""/>	
		 <!--地市代码 -->
		<input type="hidden" id="CityCode" name="CityCode" value=""/>
		<!--用户级别 -->
		<input type="hidden" id="UserClass" name="UserClass" value=""/>
		<!--按键路由 -->
		<input type="hidden" id="DigitCode" name="DigitCode" value=""/>
		<!--按键 -->
		<input type="hidden" id="ttansfercode" name="ttansfercode" value=""/>
		<!--枝叶 -->
		<input type="hidden" id="typeId" name="typeId" value=""/>
		<!--用户品牌 -->
		<input type="hidden" id="userType" name="userType" value=""/>
		<!--服务号码-->
		<input type="hidden" id="ServiceNo" name="ServiceNo" value=""/>
		<!--咨询办理标志-->
		<input type="hidden" id="inFlag" name="inFlag" value="<%=flag%>"/>
		<!--主叫号码-->
		<input type="hidden" id="CallerNo" name="CallerNo" value=""/>
		<!--开始用户品牌-->
		<input type="hidden" id="userTypeBegin" name="userTypeBegin" value=""/>
		<!--传出的ext2-->
		<input type="hidden" id="ext2" name="ext2" value=""/>
<table width="100%" height="350px" border="0" cellpadding="0"
	cellspacing="0">
	<tr>
		<td colspan="3" width="65%">
			<div style="height: 340px;width: 99%;margin: 0;border: 0;overflow: auto;background-color: white;">
				<%=searchStr%>
			</div>
			</td>
		<td width="35%"><!-- yanghy 添加短信发送功能使用K083模块下面的内容. --> <iframe name="sendSMS"
			src="../K083/K083_msgSend4CallTrans.jsp" frameborder="0" width="99%"
			height="340px" marginwidth="0" marginheight="0" scrolling="auto"
			src=""></iframe></td>

	</tr>
	
	<td colspan="4"><!--所属地市按region_code来排序 liujied 20091026-->
					<div style="float: left;">
					所属地市
					<select id="city_code_2" name="city_code_2">
					<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
						<wtc:sql>select CITY_CODE , region_name from scallregioncode  where valid_flag = 'Y' order by region_code</wtc:sql>
					</wtc:qoption>	
					</select>
				 	级别
					<select id="user_class_2" name="user_class_2">
					<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
					<wtc:sql>select user_class_id , accept_name from scallgradecode order by user_class_id</wtc:sql>
					</wtc:qoption>	
					</select>
		     		接入码
		     		<input type="text" id="accesscode_2" name="accesscode_2" value=""   readonly/>
		     		节点名称:
		     		<input type="text" id="searchName" name="searchName" value=""  />
		     		<input name="trans" type="button" class="b_foot" id="trans" value="查询 " 
		     		onClick="searchCallTransTree();">
		     		</div>
	</td>
	
	
	<tr>
		<td colspan="4">
		<div style="width: 99%;"><input type="hidden" id="show_Name"
			align="left"> <select id="select_Name" name="select_Name"
			style="width: 100%; height: 80px; border: 0;" multiple="true"
			onDblClick="right(this)">
		</select> <input type="hidden" name="node_Id" id="node_Id" value=""> <input
			type="hidden" name="node_Name" id="node_Name" value=""></div>
		</td>
	</tr>
	<tr>
		<td colspan="4"  ><!--所属地市按region_code来排序 liujied 20091026-->
		<div style="float: left;">
		所属地市
		<select id="city_code" name="city_code" onchange="getCityCodeTree();"  >
			<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				<wtc:sql>select CITY_CODE , region_name from scallregioncode  where valid_flag = 'Y' order by region_code</wtc:sql>
			</wtc:qoption>	
			</select>
		 	级别
			<select id="user_class" name="user_class" onchange="getUserClassTree();"  >
			<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
			<wtc:sql>select user_class_id , accept_name from scallgradecode order by user_class_id</wtc:sql>
			</wtc:qoption>	
			</select>
     		接入码
     		<input type="text" id="accesscode" name="accesscode" value="" readonly/>
     	</div>
		<div style="float: right;">
		
			<input type="radio" name="toIVRType"  value="0" checked />
			释放转
			<input type="radio" name="toIVRType" value="1"/>
			挂起转
			<input name="trans" type="button" class="b_foot" 
			 id="trans" value="转移 " onClick="transToIvr()">
			<input name="delete" type="button" class="b_foot" 
			id="delete" value="取消 " onClick="deleteChecked()">	
			<input name="close" type="button" class="b_foot" 
			id="delete" value="关闭 " onClick="javascript:parent.parent.window.close();">
		</div>
		</td>
	</tr>
</table>
</form>
<script language="javascript" type="text/javascript">
function getCallData() {

	// add lijin 如果是受理号码，用户级别应为受理号码的
	var userBread = '';
	var huaWeiUserClass = window.parent.parent.opener.document.getElementById("huaWeiUserClass").value;
	// alert("huaWeiUserClass"+huaWeiUserClass);
	if (huaWeiUserClass == '' || huaWeiUserClass == undefined) {
		huaWeiUserClass = '';
	}
	if (huaWeiUserClass != '') {
		userBread = huaWeiUserClass;
	}
	// modifide by liujied :该函数要传一个整型参数:媒体类型
	var callData = window.parent.parent.opener.top.cCcommonTool.QueryCallDataEx(5);
	// alert("callData:"+callData);
	if (callData == '' || callData == undefined) {
		rdShowMessageDialog('对不起，没有查到对应的数据', 0);
	} else {
		var str = callData.split(",");
		var i = 0;
		if (str[i] != '' && str[i].substr(4) == '12580') {
			document.getElementById("CalledNo").value = str[i].substr(4);
		} else {
			document.getElementById("CalledNo").value = '10086';
		}
		document.getElementById("CityCode").value = str[i + 1];
		if (huaWeiUserClass == '') {
			huaWeiUserClass = str[i + 2];
		}
		document.getElementById("UserClass").value = huaWeiUserClass;
		document.getElementById("ServiceNo").value = str[i + 3];
		document.getElementById("DigitCode").value = str[i + 4];
		document.getElementById("CallerNo").value = str[i + 5];
		document.getElementById("userTypeBegin").value = str[i + 6];
		/***********************************************************************
		 * if(str[i+5] == ''||str[i+5] == undefined) {
		 * document.getElementById("CallerNo").value= "10086"; }
		 **********************************************************************/
	}
}
getCallData();


function searchCallTransTree(){/*yanghy新添加搜索功能.*/
	var searchName = document.getElementById("searchName").value;
	if(searchName == ''){
		rdShowMessageDialog("请输入节点名称!",1);
		return;
	}
	var flag = '<%=flag%>';
	var calledNo = document.getElementById("CalledNo").value;
	var userClass = window.parent.parent.opener.top.parPhone.RoutPackage_UserClass;
	var cityCode = document.getElementById("CityCode").value;
	window.parent.change_link3_style();/*调用父页面的方法.改变第3个标签的样式.*/
	window.location.href = "k029_ivrCallSearch.jsp?flag="+flag+"&calledNo="+
	calledNo+"&calledNo="+calledNo+"&userClass="+userClass+"&cityCode="+cityCode+"&searchName="+searchName;
}
</script>
</div>
</body>
</html>