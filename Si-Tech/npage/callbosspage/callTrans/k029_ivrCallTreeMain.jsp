<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
String flag=request.getParameter("flag");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
%>
<html>

<head>
<title>人工转自动</title>
<script type="text/javascript" src="/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<%@ include file="/npage/include/public_hotkey.jsp" %>
<!--add it here to log in logfile -->
<script language="JavaScript" src="<%= request.getContextPath() %>/njs/csp/CCcommonTool.js"></script>

<script language=javascript>
function closettt()
{
  window.close();
}
var globalFlag = '<%=flag%>';/**yanghy添加定义全局flag.页面不刷新跳转.20091029*/
function transToIvr(){
     var TransType='';
     //取得随路数据
     var accessCode=document.getElementById("CalledNo").value;
     var DigitCode=document.getElementById("DigitCode").value;
     var typeId=document.getElementById("typeId").value;
     var userType=document.getElementById("userType").value;
     var UserClass=document.getElementById("UserClass").value;
     var ext2=document.getElementById("ext2").value;
     
     //取页面选中数据
     var servicename=document.getElementById("node_Name").value; 
     var serviceid=document.getElementById("node_Id").value;
     var callerNo=document.getElementById("CallerNo").value;
     var cityCode=document.getElementById("CityCode").value;
   
	//cCcommonTool.DebugLog("node_Name:"+node_Name+"CallerNo:"+callerNo+"CityCode:"+cityCode);
     //alert(servicename+"_"+serviceid+"_"+callerNo+"_"+cityCode);
     //转移方式
     var toIVRType = document.getElementById("toIVRType").checked;
     if(toIVRType==true){
          TransType=0;
     }
     else{
          TransType=1;
     }
     //分解ext2
     if(ext2==''){
     		rdShowMessageDialog("请选择语音节点",1);
     		return;
     }
     var Ext2=getHuaWeiExt2(ext2,typeId);
     
     /**
     var strShwoAlert = "node_Name:[" + document.getElementById("node_Name").value+"\nnode_Id:[\t"
     	+ document.getElementById("node_Id").value + "\next2分解:[\t"
     	+ Ext2 + "\next2:[\t"
     	+ document.getElementById("ext2").value + "\nshow_Name:[\t"
     	+ document.getElementById("show_Name").value + "\n";
     alert(strShwoAlert);
     //写数据库
     strShwoAlert = "callerNo:\t" + callerNo
     	+ "\nTransType:\t" + TransType
     	+ "\nDigitCode:\t" + DigitCode
     	+ "\ncityCode:\t" + cityCode
     	+ "\naccessCode:\t" + accessCode
     	+ "\nuserType:\t" + userType
     	+ "\nUserClass:\t" + UserClass
     	+ "\nservicename:\t" + servicename
     	+ "\nserviceid:\t" + serviceid 
     	+ "\nglobalFlag:\t" + globalFlag;
  	
     alert(strShwoAlert);
     */
     window.parent.parent.opener.top.insertAllIvr(callerNo,TransType,DigitCode,"",cityCode,accessCode,UserClass,servicename,serviceid,"N",globalFlag);
     //转IVR
     window.parent.parent.opener.top.cCcommonTool.toIvr(accessCode,TransType,DigitCode,userType,Ext2,UserClass);
     window.top.close();
}
/**删除全部选择select.*/
function deleteChecked(){
     myFrame.location.href = "javaScript:unCheckBoxBySelect();";
     document.form1.node_Id.value="";
     document.form1.node_Name.value="";
     document.form1.show_Name.value="";
     document.getElementById("select_Name").options.length=0;
     genValueByMoveOptions();/*重新生成数据.*/
}

function getHuaWeiExt2(ext2,typeId){
     var Ext2="";
     var temp="";
     if(ext2==''||typeId==''||ext2==undefined||typeId==undefined){return false;}
     if(ext2 && ext2 != "")
     			ext2 = ext2.substring(1,ext2.length);
     			
     var arrayStr=ext2.split(",");
     if(arrayStr.length==1){
          Ext2= typeId+arrayStr[0].substr(arrayStr[0].indexOf("~"));
     }else{
          for(var i=0;i<arrayStr.length;i++){
               temp+=arrayStr[i].substr(arrayStr[i].indexOf("~"));
          }
          Ext2="2000"+temp;
     }
     return Ext2;
}
/**双击取消的时候操作函数.*/
function right(value){
     var optionarr = value.options;
     if(value.selectedIndex!=-1){
          var node_id = optionarr[value.selectedIndex].value;
          /**当双击的时候取消选择树.*/
          var checkBoxItem = myFrame.document.getElementById("chk"+node_id);
          if(checkBoxItem!=null&&checkBoxItem!=undefined){
               checkBoxItem.checked = false;
          }
	   var myselect=document.form1.select_Name.options;
	   for(var i=0;i<myselect.length;i++){
                if(myselect[i].value==node_id){
                     myselect.remove(i);
                     break;
                }
	   }
     }
     genValueByMoveOptions();/*重新生成数据.*/
}


/**单击显示对应的短信.*/
function showMess(value){
 
     var optionarr = value.options;

     if(value.selectedIndex!=-1){   
     	  if(optionarr[value.selectedIndex].node_type==1);
      	{
      		  sendSMS.showMessage(optionarr[value.selectedIndex].msg_content);
      	}	
      } 
}
</script>
</head>
<body>
<style>
body
{
	margin:0;
	padding:0;
	font:12px Verdana, Arial, Helvetica, sans-serif,"宋体"，"黑体";
	line-height:1.8em;
	text-align:left;
	color:#003399;
	background-color: #eef2f7;
}
html {
	scrollbar-face-color:#d5e1f7;
	scrollbar-highlight-color:#FFFFFF;
	scrollbar-shadow-color:#DEEBF7;
	scrollbar-3dlight-color:#89b3e3;
	scrollbar-arrow-color: #121f54;
	scrollbar-track-color:#F4F0EB;
	scrollbar-darkshadow-color:#89b3e3;
	overflow:hidden;
}
</style>
<div id="Operation_Table" style="width: 100%; padding: 0px; height: 310px;"> 
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
	  <table  width="100%" height="350px" border="0" cellpadding="0" cellspacing="0">
		  	<tr><td colspan="3" width="65%">
		  		<iframe name="myFrame" src="" frameborder="0" width="99%" height="340px" 
		  		marginwidth="0" marginheight="0" scrolling="auto" src=""></iframe>	
		  	</td>
		  	<td width="35%"><!-- yanghy 添加短信发送功能使用K083模块下面的内容. -->
		  			<iframe name="sendSMS" src="../K083/K083_msgSend4CallTrans.jsp"
		  			 frameborder="0" width="99%" height="340px" marginwidth="0" 
		  			 marginheight="0" scrolling="auto" src=""></iframe>	
		  	</td>
		  	
		  	</tr>
		  	
		  	<tr>
				<td colspan="4"><!--所属地市按region_code来排序 liujied 20091026-->
				<div style="float: left;">
					流程类别
					<select id="searchType" name="searchType">
						<option value="1">转咨询语音</option>
						<option value="0">转业务办理</option>
					</select>
					所属地市
					<select id="city_code_2" name="city_code_2" style="width: 70px;">
					<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
						<wtc:sql>select CITY_CODE , region_name from scallregioncode  where valid_flag = 'Y' order by region_code</wtc:sql>
					</wtc:qoption>	
					</select>
				 	级别
					<select id="user_class_2" name="user_class_2" style="width: 160px;">
						<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
						<wtc:sql>select user_class_id , accept_name from scallgradecode order by user_class_id</wtc:sql>
						</wtc:qoption>
					</select>
		     		接入码
		     		<input type="text" id="accesscode_2" name="accesscode_2" value="" style="width: 40px;"  readonly/>
		     		节点名称:
		     		<input type="text" style="width: 80px;" id="searchName" name="searchName" value=""  onkeydown="onKeyDownSearch()"/>
		     		<input name="trans" type="button" class="b_foot" id="trans" value="查询 " style="border: 0px;margin: 0px;"
		     		onClick="searchCallTransTree();">
		     		</div>
				</td>
			</tr>
			
			
			<tr>
				<td colspan="4"><div style="width: 96%;float: left;">
					<input  type="hidden" id="show_Name" align="left">
					<select id="select_Name" name="select_Name" style="width:100%;height:80px;border: 0;" multiple="true" onDblClick ="right(this)" onClick="showMess(this)">
					</select>
					<input type="hidden" name="node_Id" id="node_Id" value="">
					<input type="hidden" name="node_Name" id="node_Name" value="">
					</div>
					<div style="float: right;width: 25px;">
						<div style="margin-left: 0">
						<a href="javaScript:moveUp();"><img src="moveUp.gif" border="0"></img></a>
						</div>
						<div>
						<a href="javaScript:moveDown();"><img src="moveDown.gif" border="0"></img></a>
						</div>
					</div>		  
				</td>
			</tr>	
			<tr>
				<td colspan="4"><!--所属地市按region_code来排序 liujied 20091026-->
				<div style="float: left;">
					所属地市
					<select id="city_code" name="city_code" onchange="getCityCodeTree();"  style="width: 70px;">
					<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
						<wtc:sql>select CITY_CODE , region_name from scallregioncode  where valid_flag = 'Y' order by region_code</wtc:sql>
					</wtc:qoption>
					</select>
				 	级别
					<select id="user_class" name="user_class" onchange="getUserClassTree();"  style="width: 160px;">
						<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
						<wtc:sql>select user_class_id , accept_name from scallgradecode order by user_class_id</wtc:sql>
						</wtc:qoption>	
					</select>
		     		接入码
		     		<input type="text"  id="accesscode" name="accesscode" style="width: 40px;" value="" readonly/>
					<input type="radio" name="toIVRType"  value="0" checked />
					释放转
					<input type="radio" name="toIVRType" value="1"/>
					挂起转
					<input name="trans" type="button" class="b_foot" style="border: 0px;margin: 0px;"
					 id="trans" value="转移 " onClick="transToIvr()">
					<input name="delete" type="button" class="b_foot" style="border: 0px;margin: 0px;"
					id="delete" value="取消 " onClick="deleteChecked()">	
					<input name="close" type="button" class="b_foot" style="border: 0px;margin: 0px;"
					id="delete" value="关闭 " onClick="javascript:parent.parent.window.close();">
				</div>
		    	</td>
			</tr>
		</table>
  </form>
</div>
</body>
<script type="text/javascript">
/**得到数据并解析下.将值保存.*/
function getCallData() {
	// add lijin 如果是受理号码，用户级别应为受理号码的
	var userBread = '';
	var huaWeiUserClass = window.parent.parent.opener.document
			.getElementById("huaWeiUserClass").value;
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
/***第一次进入页面的时候将select框的值设置.*/
function initCallData(){
	if(document.getElementById("CityCode").value != ''){
	    document.getElementById("city_code").value = document.getElementById("CityCode").value;
	    document.getElementById("city_code_2").value = document.getElementById("CityCode").value;
	    /**设置select选择下拉框.city_code_2 是查询的select选择框.*/
	}
	//if(window.parent.parent.opener.top.parPhone.RoutPackage_UserClass != ''){
	if(document.getElementById("UserClass").value != ''){
		// 直接获取华为数据.
		document.getElementById("user_class").value = document.getElementById("UserClass").value;
		document.getElementById("user_class_2").value = document.getElementById("UserClass").value;
		/**设置select选择下拉框.*/
	}
	if(document.getElementById("CalledNo").value != ''){
		document.getElementById("accesscode").value = document.getElementById("CalledNo").value;
		document.getElementById("accesscode_2").value = document.getElementById("CalledNo").value;
		/**accesscode_2为查询时候的参数.*/
	}
}
getCallData();
/**仅页面初始化时候使用,如果需要点击table的时候改变select.添加到getCallData()里面.*/
initCallData();

var selectTabBar = 0;
/**定义选择的TabBar标签是哪个 .*/
function doChangeTabBar(changeNo){
	getCallData();/**重新加载函数.*/
	/*将select选择框的状态记录.*/
	/**将select 再赋值给input.hidden*/
	document.getElementById("CityCode").value = document.getElementById("city_code").value;
	document.getElementById("UserClass").value = document.getElementById("user_class").value;
	
	if(changeNo == 0){
		globalFlag = 0;
		document.getElementById("inFlag").value = 0;
		window.open(<%=request.getContextPath()%>"/npage/callbosspage/callTrans/k029_ivrCallTree_new.jsp?flag=0","myFrame");
		selectTabBar = 0;
		document.getElementById("searchType").value = 0;
	}
	if(changeNo == 1){
		globalFlag = 1;
		document.getElementById("inFlag").value = 1;
		window.open(<%=request.getContextPath()%>"/npage/callbosspage/callTrans/k029_ivrCallTree_new.jsp?flag=1","myFrame");
		selectTabBar = 1;
		document.getElementById("searchType").value = 1;
	}
	if(changeNo == 2){
		searchCallTransTree();
		selectTabBar = 2;
	}
	/**alert(changeNo);*/
}

function searchCallTransTree(){/*yanghy新添加搜索功能.*/
	selectTabBar = 2;
	getCallData();/**重新加载函数.*/
	var searchName = document.getElementById("searchName").value;
	if(searchName == ''){
		//rdShowMessageDialog("请输入节点名称!",1);
		//return;
	}
	/*分别取查询时候的参数.*/
	var calledNo = document.getElementById("accesscode_2").value;
	var userClass = document.getElementById("user_class_2").value;
	var cityCode = document.getElementById("city_code_2").value;
	var searchTypeFlag = document.getElementById("searchType").value;
	window.parent.change_link3_style();/*调用父页面的方法.改变第3个标签的样式.*/
	var url = "k029_ivrCallTree_new.jsp?flag="+searchTypeFlag+"&calledNo="+
	calledNo+"&calledNo="+calledNo+"&userClass="+userClass+"&cityCode="+cityCode
	+"&searchName="+searchName+"&selectTabBar="+selectTabBar;
	window.open(url,"myFrame");
}
/**当按下回车的时候进行搜索.*/
function onKeyDownSearch(){
	if(event.keyCode==13){
		searchCallTransTree();
  	}
}
/***/
function getCityCodeTree(){
	/**清除选择项目.*/
	var citycode = document.getElementById("city_code").value;
	document.getElementById("CityCode").value= citycode;
	document.getElementById("city_code_2").value = citycode;/**select选择联动.*/
	if(selectTabBar == 0 || selectTabBar == 1 ){
		window.open(<%=request.getContextPath()%>"/npage/callbosspage/callTrans/k029_ivrCallTree_new.jsp?flag="+globalFlag,"myFrame");
	}else{
		searchCallTransTree();
	}
}
/**向上移动函数.*/
function moveUp(){
	/*Option移动.开始.*/
	var selectNameOptions = document.form1.select_Name.options;
	for( var i = 0 ; i < selectNameOptions.length; i ++){
		if(selectNameOptions[i].selected == true ){/*第一个节点不能向上移动.*/
			if( i == 0 )break;
			//alert(i);
			swapOption(selectNameOptions[i],selectNameOptions[new Number(i) - 1]);
			/*选择也上移.*/
			document.getElementById("select_Name").options[new Number(i) - 1].selected = true;
			document.getElementById("select_Name").options[i].selected = false;
		}
	}
	selectNameOptions = null;
	genValueByMoveOptions();/*重新生成node_Id,node_Name值.*/
}
/**向下移动函数.*/
function moveDown(){
	/*Option移动.开始.*/
	var selectNameOptions = document.form1.select_Name.options;
	for( var i = selectNameOptions.length - 1; i >= 0; i --){/*向下移动要倒着循,环判断最后一个是否可以移动.*/
		if(selectNameOptions[i].selected == true ){/*最后一个节点不能向上移动.*/
			if( i == (selectNameOptions.length - 1) )break;
			//alert(i);
			swapOption(selectNameOptions[i],selectNameOptions[new Number(i) + 1]);
			/*选择也下移.*/
			document.getElementById("select_Name").options[new Number(i) + 1].selected = true;
			document.getElementById("select_Name").options[i].selected = false;
		}
	}
	selectNameOptions = null;
	genValueByMoveOptions();/*重新生成node_Id,node_Name值.*/
}
/**设置临时变量,进行两个值的交换.*/
function swapOption( option1, option2){
	/*不可以用object直接等于,而是取value和text的值.*/
	var optionTempValue = option1.value;
	var optionTempText = option1.text;
	var optionTempNodeId = option1.node_id;
	var optionTempNodeName = option1.node_name;
	var optionTempNodeType = option1.node_type;
	var optionTempMsgContent = option1.msg_content;
	var optionTempDigitCode = option1.digit_code;
	var optionTempCityCode = option1.city_code;
	var optionTempUserClass = option1.user_class;
	/*交换值.*/
	option1.value = option2.value;
	option1.text = option2.text;
	option1.node_id = option2.node_id;
	option1.node_name = option2.node_name;
	option1.node_type = option2.node_type;
	option1.msg_content = option2.msg_content;
	option1.digit_code = option2.digit_code;
	option1.city_code = option2.city_code;
	option1.user_class = option2.user_class;
	/*交换值.*/
	option2.value = optionTempValue;
	option2.text = optionTempText;
	option2.node_id = optionTempNodeId;
	option2.node_name = optionTempNodeName;
	option2.node_type = optionTempNodeType;
	option2.msg_content = optionTempMsgContent;
	option2.digit_code = optionTempDigitCode;
	option2.city_code = optionTempCityCode;
	option2.user_class = optionTempUserClass;
	/**临时变量置null.*/
	optionTempValue = null;optionTempText = null;optionTempNodeId = null;
	optionTempNodeName = null;optionTempNodeType = null;optionTempMsgContent = null;
	optionTempDigitCode = null;optionTempCityCode = null;optionTempUserClass = null;
}
/*向上移动,向下移动之后重新生成node_Id,node_Name值.*/
function genValueByMoveOptions(){
	try{
		// document.form1.node_Id.value="";
		// document.form1.node_Name.value="";
		var selectNameOptions = document.form1.select_Name.options;
		var tempNodeId = "";
		var tempNodeName = "";
		var tempExt2_00 = "";
		var tempExt2_01 = "";
		/**先清空短信发送里面的数组.重新设置一个数组.*/
		sendSMS.messageArray = new Array();
		for( var i = 0 ; i < selectNameOptions.length; i ++){
			
			var type = selectNameOptions[i].node_type;
			var inReg = '';
			/**判断第一次不同.*/
			if (type == '0') {/**转业务办理.*/
				inReg = "00";
			}
			if (type == '1') {/**转业务咨询.*/
				inReg = "01";
			}
			/**获得ext2的数据.*/
			var tempExt2 = "," + selectNameOptions[i].node_id + "~" + inReg + "^" 
			+ selectNameOptions[i].city_code + "^"
			+ selectNameOptions[i].user_class + "^" 
			+ document.getElementById("userTypeBegin").value + "^" 
			+ selectNameOptions[i].digit_code+ "^" 
			+ document.getElementById("ServiceNo").value;
			/**alert(type);*/
			/**alert(tempExt2);*/
			/**判断第二次不同.两次不可以同时判断.因为.inReg要在tempExt2前用到.*/
			if (type == '0') {/**转业务办理.*/
				tempExt2_00 += tempExt2;
			}
			if (type == '1') {/**转业务咨询.*/
				tempExt2_01 += tempExt2;
			}
			if( i == 0 )
			{/*如果是第一个就取消逗号.*/
				tempNodeId += selectNameOptions[i].node_id;
				tempNodeName += selectNameOptions[i].node_name;
			}else{
				tempNodeId += "," + selectNameOptions[i].node_id;
				tempNodeName += "," + selectNameOptions[i].node_name;
			}
			inReg = null;type = null;tempExt2 = null;
			/**添加短信处理函数.*/
			if(selectNameOptions[i].msg_content != ''){
				/**如果里面包含短信内容就将短信内容存到数组里面.*/
				/**alert(i+"\t"+selectNameOptions[i].msg_content);*/
				sendSMS.messageArray.push(selectNameOptions[i].msg_content);
			}
		}
		/**重新生成短信连接并显示第一条短信.*/
		sendSMS.genHTMLByArray();
		/**将重新拼接node_id和node_name.*/
		document.form1.node_Id.value = tempNodeId;
		document.form1.node_Name.value = tempNodeName;
		/**转业务咨询放到前面.之后是转业务办理.*/
		/**alert(tempExt2_01 + tempExt2_00);*/
		document.getElementById("ext2").value = tempExt2_01 + tempExt2_00;
		tempNodeId = null;tempNodeName = null;tempExt2_01 = null;tempExt2_00 = null;
	}catch(err){
		alert(err.Message); 
	}
}
/**默认初始化的时候加载.*/
function getUserClassTree(){
	var userclass = document.getElementById("user_class").value;
	document.getElementById("UserClass").value = userclass;      
	document.getElementById("user_class_2").value = userclass;/**select选择联动.*/
	if(selectTabBar == 0 || selectTabBar == 1 ){
		window.open(<%=request.getContextPath()%>"/npage/callbosspage/callTrans/k029_ivrCallTree_new.jsp?flag="+globalFlag,"myFrame"); 
		window.parent.parent.opener.top.cCcommonTool.DebugLog("javascript *** getUserClassTree userclass:"+userclass);
	}else{
		searchCallTransTree();
	}
}
getUserClassTree();
</script>
</html>