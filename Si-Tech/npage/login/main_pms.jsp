<%
   /*
   * 功能: 系统主框架
　 * 版本: v1.0
　 * 日期: 2010-11-11 
　 * 作者: hejwa
　 * 版权: sitech
   * 描述：电话经理系统跳转到boss购物车功能
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<script type="text/javascript">
	window.opener=undefined
    window.parent=undefined
</script>	
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	////防止直接输入URL进入模块页面
	String refererProxy=request.getHeader("referer");
	if(null==refererProxy||"".equals(refererProxy))
	{
	%>
			<script language="javascript">
				if(typeof(opener) == "undefined")
				{
				  //alert("禁止非法进入页面!");
				  //window.opener=null;
				  //window.open("","_self");
              	  //window.close();	
        		}
		</script>
	<%
	}
%>
<%
//取session值
ArrayList retArray = (ArrayList)session.getAttribute("allArr");
String[][] lastInfo = (String[][])retArray.get(2);
String login_no   = (String)session.getAttribute("workNo");
String login_name = (String)session.getAttribute("workName");
String workNo = login_no;
String regionCode = (String)session.getAttribute("regionCode");
String cssPath = (String)session.getAttribute("cssPath");
String hotkey = (String)session.getAttribute("hotkey")==null?"Y":(String)session.getAttribute("hotkey");
String layout = (String)session.getAttribute("layout")==null?"2":(String)session.getAttribute("layout");
String phoneNoPms = (String)session.getAttribute("phoneNoPms")==null?"":(String)session.getAttribute("phoneNoPms");

		
%>
<%@ include file="./getCssPath.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">		
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<title>黑龙江移动综合客户服务系统</title>
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/framework.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/rightmenu.css" rel="stylesheet" type="text/css" />
	<style>
		#imgLeftRight{
			position:absolute;
			left:0px;
			top:300px;
			height:50px;
			width:6px;	
			z-index:10000;
		}
	</style>
</head>
<body>		
	<!--topPanel begin-->
	<%@ include file="../module/topPanel.jsp"%>
	<!-- 存储ajax调用返回的html -->
	<div id="ajaxResult" style="display:none"></div>
	<!--topPanel end-->

	<!--searchPanel begin-->
<div style="display:none">
	<%@ include file="../module/searchPanel.jsp"%>
</div>
	<!--searchPanel end-->
	
	<!--ContentArea bengin-->
	<div id="contentPanel">
		
		<!--navPanel begin-->
	<div style="display:none">
		<%@ include file="../module/navPanel.jsp"%>
	</div>
		<!--navPanel end-->
		<div id="borderWorkAndNav"></div>
		<!--workPanel begin-->
		<%@ include file="../module/workPanel_pms.jsp"%> 
		<!--workPanel end-->
	</div>
	<!--footPanel begin-->
	<div style="display:none">
		<%@ include file="../module/footPanel.jsp"%>
	</div>
	<!--footPanel end-->
	<!--防止页面另存-->	
	<noscript>
	<iframe src=""></iframe>
	</noscript>
<div id="currUserId" style="display:none"></div>
<div id="currPhoneNo" style="display:none"></div>
<div id="currBrandId" style="display:none"></div>
<div id="currBrandName" style="display:none"></div>
<div id="currMasterServId" style="display:none"></div>
<div id="currMasterServName" style="display:none"></div>
<div id="currMainProdId" style="display:none"></div>
<div id="currMainProdName" style="display:none"></div>
<div id="userFinishFlag" style="display:none"></div>
<div id="contentArr" style="display:none"></div>
<div id="targetUrlDiv" style="display:none"></div>
<script src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/system/system.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/plugins/autocomplete.js"  type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/plugins/tabScript_jsa_pms.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/plugins/MzTreeView12.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/redialog/redialog.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">

var iCustId = "";
var iPhoneNo = "index";

//查询一级菜单
function loadFirstMenu(){
	var packet =  new AJAXPacket("ajax_queryFirstMenu.jsp");
	core.ajax.sendPacketHtml(packet,doLoadFirstMenu);
	packet = null;

}

function doLoadFirstMenu(data){
	$("#ajaxResult").html(data);//隐藏返回的Html
	
	var retCode = $("#divRetCode").html();
	var retMsg = $("#divRetMsg").html();

	if(retCode=="0"){

		$("#oli").html($("#divShowFirstMenu").html());//data中包含divShowFirstMenu
		$("#otherFirstMenu").html($("#divOtherFirstMenu").html());//data中包含divOtherFirstMenu

	}else{
		showDialog(retMsg,0);
	}
}

/**************来自原来framework.js的代码*********/
// 整体布局
function layoutSwitch(n){
		
	$("#layoutStatus").val(n);
	
	$("#a1").attr("class","aSpace");
	$("#a2").attr("class","bSpace");
	$("#a3").attr("class","cSpace");
	$("#a4").attr("class","dSpace");
	
	
	if (n==1){//工作区最大化
		$("#navPanel").hide();
		$("#topPanel").hide();	
		$("#workPanel").css("margin-left","4px");
		$("#a1").attr("class","aSpaceOn");
	}
	if(n==2){//恢复完整视图
		$("#topPanel").show();
		$("#navPanel").show();
		$("#workPanel").css("margin-left","201px");
		$("#a2").attr("class","bSpaceOn");
	}
	if(n==3){//隐藏topPanel面板
		$("#topPanel").hide();
		$("#navPanel").show();
		$("#workPanel").css("margin-left","201px");
		$("#a3").attr("class","cSpaceOn");
	}
	if(n==4){//隐藏navPanel面板
		$("#topPanel").show();
		$("#navPanel").hide();
		$("#workPanel").css("margin-left","4px");
		$("#a4").attr("class","dSpaceOn");
	}
	
	initPanel(n);
}

function initPanel(n){
	var marginHeight=9;
	if(n==1){
		$("#contentPanel").height($("body").height()-$("#searchPanel").height()-$("#footPanel").height()-marginHeight);	
	}else if(n==2){
		$("#contentPanel").height($("body").height()-$("#topPanel").height()-$("#searchPanel").height()-$("#footPanel").height()-marginHeight);	
	}else if(n==3){
		$("#contentPanel").height($("body").height()-$("#searchPanel").height()-$("#footPanel").height()-marginHeight);	
	}else if(n==4){
		$("#contentPanel").height($("body").height()-$("#topPanel").height()-$("#searchPanel").height()-$("#footPanel").height()-marginHeight);	
	}
	$("#contentArea").height($("#workPanel").height()-$("#tab").height()-3);
	setIframe();
	setNav("N");
}

//设置一级TAB内iframe高度、宽度
function setIframe()
{
	var workPanel=g("workPanel");
	var tab=g("tab");
	var workPanelHeight=workPanel.clientHeight;
	var workPanelWidth=workPanel.clientWidth;
	var tabHeight = tab.clientHeight;
	var iframe=workPanel.getElementsByTagName("iframe");
	for(var i=0;i<iframe.length;i++)
	{
		iframe[i].style.height=(workPanelHeight-tabHeight)+"px";
		iframe[i].style.width=(workPanelWidth)+"px";
	}
}

//设置导航区中内容的高度,flag:tree有模块搜索
function setNav(flag)
{
	var marginHeight=3;
	if(flag == "tree")
	{
		$(".search_bar").show();
		$(".dis").height($("#navPanel").height()-$(".title").height()-$(".search_bar").height()-marginHeight-14);
	}else{
		$(".search_bar").hide();
		$(".dis").height($("#navPanel").height()-$(".title").height()-marginHeight-14);
	}
}

/************************************ topPanel ************************************/

//一级栏目切换
function HoverMenu(object,subobject)
{
	var tag=g(object).getElementsByTagName(subobject);
	for(var i=0;i<tag.length;i++)
	{
		(function(j){
			tag[j].onclick=function()
			{
				for(var n=0;n<tag.length;n++)
				{
					tag[n].className="";
				}
				tag[j].className="on";
				HoverNav("tree",tag[j].opcode,tag[j].opname);
			}
		})(i);
	}
}
var isExit = "0"; //默认为直接关闭
 /*
   添加变量，在系统退出时关闭弹出窗口
 */
var winArray = new Array();
var nameArray = new Array();
function addWinName(obj,name){
	var flag = 0 ;
	var length = nameArray.length;
	for ( i=0; i<length; i++ ){
		if ( nameArray[i] == name ){
			flag = 1;
			break;
		}
	} 
	if ( flag == 0 ){
		winArray[length] = obj;
		nameArray[length] = name;
	}
	//alert("add done!");
}
//黑龙江退出系统
function closeWindow(){
	 var sendop_code = {};
	 sendop_code["workNo"] = "<%=login_no%>";
	 $.ajax({
			   url: 'sDCustOrder.jsp',
			   type: 'POST',
			   data: sendop_code
	 });
	 sendop_code=null;
	 for ( i=0; i<winArray.length; i++ ){
		try{
		     winArray[i].close();	
		    }catch(e){
		    	alert(e);
		    }
	 }
    var prop="dialogHeight:150px; dialogWidth:320px; status:no;unadorned:yes";
    window.showModalDialog("logout.jsp?loginNo=<%=login_no%>","",prop);
    window.opener=null;
    window.open('','_self');
    window.close();
}
/*
function doExit(){
	isExit = "1"; //点退出按钮 
	var prop="dialogHeight:122px; dialogWidth:402px; status:no;unadorned:yes";
	window.showModalDialog("logout2.jsp","",prop);
	window.opener=null;
	window.open('','_self');
	window.close();
}
*/

/************************************ searchPanel *********************************/
function chgLoginType()//控制用户登陆类型下拉框
{
	var select_panel = $(".select_panel");
	var select_panel_detail = $(".select_panel p");
	if(select_panel.css("display") == "none"){
		select_panel.css("display","block");
		select_panel_detail.hover(
			function(){
				$(this).css("background-color","#fefe9c");
				this.style.cursor = "hand";
			},
			function(){
			  $(this).css("background-color","");
				this.style.cursor = "point";
		  }
		);
		select_panel_detail.click(function(){
			$("#loginType").val(this.innerText);
			$("#loginType").attr("loginType",this.value);
			doChangeType(this);
			$("#phoneNo").val("请输入信息进行查询(Alt+1)");
			//二代身份证读卡图标显隐			
			if(this.value==="12"){
				$(".serverNum .ico_id").css("display","");
			}else{
				$(".serverNum .ico_id").css("display","none");
			}
		});
	}else{
		select_panel.css("display","none");
	}
}

function clearPhoneNo()//清空用户登陆号码
{
	$("#phoneNo").val("");
}
function clearCustName()
{
	$("#iCustName").val("");
}

//判断是否已经打开客户首页
function isTabExist()
{
	var tabSize = $("#contentArea iframe").size();
	for(var i=0;i<tabSize;i++)
	{
		if($("#contentArea iframe")[i].id.length>12)
		{
			if($("#contentArea iframe")[i].id.substring(0,12)=="iframecustid")
			{
				showDialog("请办理完当前客户再受理其他客户",1);
				return false;
			}
			if($("#contentArea iframe")[i].id.substring(0,15)=="iframecustLater")
			{
				showDialog("请办理完当前业务再受理其他客户",1);
				return false;
			}
		}
	}
	return true;
}

/*安徽
function addTabBySearch()
{
	if(!isTabExist()) return false;
		
	var phoneNo = $("#phoneNo").val();
	if(phoneNo=="请输入信息进行查询(Alt+1)"||phoneNo=="")
	{
		showDialog("请输入查询条件",1);
		return false;
	}
	
	var loginType = $("#loginType").attr("loginType");
	if(loginType==="11")
	{
		openDivWin("getUserList.jsp?phoneNo="+phoneNo+"&loginType="+loginType,'用户列表','600','400');
	}else{
		getCustId(phoneNo,loginType);		
	}
}
*/
	function addTabBySearch(enterType)
	{
		 //如果是按钮点击进入
  	 if(enterType=='button')
  	 {
  	 	 var phoneNo = $("#phoneNo2").val();
  	 	 $("#phoneNo2").val("");
  	 }
  	 //回车进入
  	 else
  	 {
  	 	 var phoneNo = $("#phoneNo").val();
  	 }

	 var patrn=/^((\(\d{3}\))|(\d{3}\-))?[12][03458]\d{9}$/;
     if(phoneNo!=""&&(phoneNo.search(patrn)!=-1))
     {
				var sendphone_no = {};
				sendphone_no["phone_no"] = phoneNo;

				 $.ajax({
				    url: 'check_phoneno.jsp',
				    type: 'POST',
				    data: sendphone_no,
				    error: function(data){
								if(data.status=="404")
								{
								  alert( "文件不存在!");
								}
								else if (data.status=="500")
								{
								  alert("文件编译错误!");
								}
								else{
								  alert("系统错误!");
								}
				    },
				    success: function(ret_code){
				      if(ret_code.trim()=="000000"){
								$("#phoneNo").val("");
								addTab(true,phoneNo,phoneNo,'childTab2.jsp?activePhone='+phoneNo);
						  }else{
								rdShowMessageDialog("手机号码信息不正确,打开Tab页出错!");
				      }
				      $("#phoneNo").val("请输入手机号码");
				    }
					});
					sendphone_no=null;
		 }
	}
	

function  getCustId(phoneNo,loginType,idNo){
	if(typeof(idNo)==="undefined") idNo = -1;
	var packet = new AJAXPacket("ajax_getcustid.jsp");
	packet.data.add("phoneNo" ,$.trim(phoneNo));
	packet.data.add("loginType" ,loginType);
	packet.data.add("idNo" ,idNo);
	core.ajax.sendPacket(packet,doGetCustId,true);
	packet =null;
}

function doGetCustId(packet)
{
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var detailMsg = packet.data.findValueByName("detailMsg");
	var custIdArr = packet.data.findValueByName("custIdArr");
	var custNameArr = packet.data.findValueByName("custNameArr");
	var custAddrArr = packet.data.findValueByName("custAddrArr");
	var staffArr = packet.data.findValueByName("staffArr");
	var contactArr = packet.data.findValueByName("contactArr");
	var loginType = packet.data.findValueByName("loginType");
	var phone_no = packet.data.findValueByName("phone_no");
	var signUserArr = packet.data.findValueByName("signUserArr");
	var id_no = packet.data.findValueByName("idNo");
	if(retCode!="0")
	{
		showDialog(retMsg,0,"detail="+detailMsg);
		return false;
	}else
	{
		if(custIdArr.length==1)
		{
			openCustMain(custIdArr,custNameArr,loginType,phone_no,signUserArr,id_no);
		}else if(custIdArr.length>1)
		{
			var phoneNo = $("#phoneNo").val();
			var loginType = $("#loginType").attr("loginType");
			var path="selectCustId.jsp?phone_no="+phoneNo+"&loginType="+loginType+"&idNo="+id_no;
			openDivWin(path,'选择客户','600','400');
		}else{
			showDialog("没有查询到符合条件的客户！",0);
		}
	}
	
	$("#phoneNo").val("请输入信息进行查询(Alt+1)");
}
//二代身份证读卡
function btnReadID2()
{
  try{		
	  if(IDCard1.Syn_ReadMsg(1001)!=0){
	       showDialog("读卡错误，请重新放卡!",0);
	       return false;
	  }
	  var cardNo = IDCard1.IDCardNo;//身份证号码
	  $("#phoneNo").val(cardNo);
		  
	 }catch(e){
	 	  showDialog("读卡错误，请联系管理员！",0);
	 }
}
//格式化客户名称
function formatString(sstr){
	var _temp = typeof(sstr)=="object"?sstr[0]:sstr;
	
	if(_temp===""||_temp.length===1){
		 return _temp;
	}else{
		var _first = _temp.substring(0,1);	
		_temp = _temp.substring(1);
		for(var i=0;i<_temp.length;i++){
			_temp = _temp.replace(_temp.charAt(i),"*");	
		}
		return (_first+_temp);
	}
}

function addTabBySearchCustName(phoneNo)
{
	var packet = new AJAXPacket("getCustId.jsp");
	packet.data.add("phoneNo" ,phoneNo);
	packet.data.add("loginType" ,"1");
	core.ajax.sendPacket(packet,doGetCustId,true);
	packet =null;
}
		
function doGetCustId(packet)
{
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var custIdArr = packet.data.findValueByName("custIdArr");
	var custNameArr = packet.data.findValueByName("custNameArr");
		
	var custIccidJ = packet.data.findValueByName("custIccid");
	var custCtimeJ = packet.data.findValueByName("custCtime");


	var loginType = packet.data.findValueByName("loginType");
	var phone_no = packet.data.findValueByName("phone_no");
	if(retCode!="0")
	{
		rdShowMessageDialog(retCode+","+retMsg,0);
		return false;
	}else
	{
		if(custIdArr.length==1)
		{
				parent.openCustMain(custIdArr,custNameArr,loginType,phone_no);
		}else
		{
				var path="selectCustId.jsp?opName=选择客户&custIdArr="+custIdArr+"&custNameArr="+custNameArr+"&custIccid="+custIccidJ+"&custCtime="+custCtimeJ+"&loginType="+loginType;
				//openDivWin(path,'选择客户','600','400');
				window.open(path,"newwindow","height=600, width=600,top=50,left=250,scrollbars=yes, resizable=no,location=no, status=yes");
		}
	}
			
	$("#phoneNo").val("请输入信息进行查询");
}
function openCustMain(custId,custName,loginType,phone_no)
{
	//alert("openCustMain#custId|"+custId+"\ncustName|"+custName+"\nloginType|"+loginType+"\nphone_no|"+phone_no);
    iCustId = custId;
	if($("#contentArea iframe").size() < 11){
		addTab(true,"custid"+custId,custName,'childTab2.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&activePhone='+phone_no);
		$("#phoneNo").val("请输入信息进行查询").blur();
		//document.all.phoneNo.blur();
		//layoutSwitch(1,$(".a1")[0]);
	}else{
		rdShowMessageDialog("只能打开10个一级tab");
	}
}
/* 安徽
function openCustMain(custId,custName,loginType,phone_no,signUser,id_no)
{
	showWinCover();
	if($("#contentArea iframe").size() < 11){
		addTab(true,"custid"+custId,formatString(custName),'childTab.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&signUser='+signUser+"&idNo="+id_no+"&isMarket=true");
		$("#phoneNo").val("请输入信息进行查询(Alt+1)");
		document.all.phoneNo.blur();
		bindRemoveTab("custid"+custId);
	}else{
		showDialog("只能打开10个一级tab",1);
	}
}
*/
//开户完成，打开客户首页
function openCustMainForNewUser(custId,custName,loginType,phone_no,contactId,idNo,opType)
{
	if(!isTabExist()) return false; //防止打开两个客户首页
	if(loginType==="PHONE_NO") loginType="11";  //由于引用此方法的地方都写死为PHONE_NO,为避免大量修改，转换为数据库中的数据
	showWinCover();
	if($("#contentArea iframe").size() < 11){
		addTab(true,"custid"+custId,formatString(custName),'childTab.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&contactId='+contactId+'&idNo='+idNo+'&opType='+opType);
		
		bindRemoveTab("custid"+custId);
	}else{
		showDialog("只能打开10个一级tab",1);
	}
}
//从待办任务过来，打开客户首页
function openCustMainForUnset(custId,custName,loginType,phone_no,signUser,unsetFrom,contentArr,idNo)
{	
	if(!isTabExist()) return false; //防止打开两个客户首页
	if(loginType==="PHONE_NO") loginType="11";  //由于引用此方法的地方都写死为PHONE_NO,为避免大量修改，转换为数据库中的数据
	showWinCover();
	$("#contentArr").val(contentArr);
	if($("#contentArea iframe").size() < 11){
		addTab(true,"custid"+custId,custName,'childTab.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&signUser='+signUser+'&unsetFrom='+unsetFrom+'&idNo='+idNo);
		
		bindRemoveTab("custid"+custId);
	}else{
		showDialog("只能打开10个一级tab",1);
	}
}

function openCustMainGetCar(custId,custName,custOrderId)
{
	/*
	var tabSize = $("#contentArea iframe").size();
	for(var i=0;i<tabSize;i++)
	{
		if($("#contentArea iframe")[i].id.length>12)
		{
			if(($("#contentArea iframe")[i].id.substring(0,12)=="iframecustid")&&($("#contentArea iframe")[i].id!="iframecustid"+custId))
			{
				rdShowMessageDialog("请办理完当前客户再受理其他客户");
				return false;
			}
		}
	}
	*/
	if($("#contentArea iframe").size() < 11){
		addTab(true,"custid"+custId,custName,'childTab2.jsp?gCustId='+custId+'&custOrderId='+custOrderId);
		$("#phoneNo").val("请输入信息进行查询");
		//document.all.phoneNo.blur();
		//layoutSwitch(1,$(".a1")[0]);
	}else{
		rdShowMessageDialog("只能打开10个一级tab");
	}
}

function doChangeType(obj){
    var type = obj.value;
    if(type == "0"){
        $("#iCustName").val("请输入客户ID进行查询");
    }else if(type == "1"){
        $("#iCustName").val("请输入手机号码查询");
    }else if(type == "2"){
        $("#iCustName").val("请输入帐户ID进行查询");
    }else if(type == "4"){
        $("#iCustName").val("请输入证件号码进行查询");
    }else if(type == "6"){
        $("#iCustName").val("请输入客户名称查询");
    }else{
        $("#iCustName").val("请输入信息进行查询");
    }
}

function newCustF(){
		L("1","1100","客户开户","sq100/sq100_1.jsp","000");
	}
function dnyCreatDiv(cust_id,phone_no){
    if(document.getElementById(cust_id)){
        document.getElementById(cust_id).parentNode.removeChild(document.getElementById(cust_id));
    }
    
	var newE = document.createElement("DIV");
    
    newE.id = cust_id;
    newE.phone_no=phone_no;
    //newE.innerHTML = "this is a test div " + new Date() + "<br/>";
    // newE.style.borderStyle = "solid";
    //newE.style.borderColor = "Red";
    newE.style.display = "none";

    //document.getElementById("div1").appendChild(newE);
    document.getElementById("borderWorkAndNav").insertBefore(newE,null);
    //document.body.appendChild(newE);
}

//BEGIN 快速转入
var quickFlag = true;	
var content_array;//快速导航 0: openWay 1:functionCode 2:functionName 3:url 4:passFlag 以空格隔开
var opStr_quick = ""; //系统模块搜索 格式"0121 签退 QT,...."

function initSearch(){
	
	//搜索模块
	$("#funcText").focus(function(){
		focusQuickNav(this)
	});
	$("#funcText").blur(function(){
		if($("#funcText").val() == ""){
			$("#funcText").val("搜索模块 (Alt+3)");
		}
	});
	
	//快速转入
	$("#tb").focus(function(){
		focusQuickNav(this)
	});
	$("#tb").blur(function(){
		if($("#tb").val() == ""){
			$("#tb").val("快速转入 (Alt+2)");
		}
	});
}

function focusQuickNav(obj)
{
	if(quickFlag){
		quickFlag = false;
		obj.value="数据加载中...";
		//getQuickNavData(obj);
	}else{
 		obj.value="";
	}
}

function getQuickNavData(obj)
{
	var packet = new AJAXPacket("getQuickNavData.jsp","请稍后...");
	packet.data.add("objId" ,obj.id);
	core.ajax.sendPacket(packet,doProcessNav,true);//异步
	packet = null;
}

function doProcessNav(packet)
{
  content_array = packet.data.findValueByName("contentStr");
  opStr_quick = packet.data.findValueByName("opStr");
  objId  = packet.data.findValueByName("objId");
  //actb(document.getElementById('tb'),document.getElementById('tb_h'),eval(opStr_quick));
  $("#"+objId).val("");
	$("#"+objId).blur();
	$("#"+objId).focus();
}

function initQuickNav()
{
 	document.getElementById('tb').value="快速转入 (Alt+2)";
}

function quicknav(arr)
{
	if(document.getElementById('tb_h').value!=-1)
	{
		L(arr[0],arr[1],arr[2],arr[3],arr[4]);
	}
}

function turnLock(obj)
{
	if(obj.className=="keyOn")
	{
		document.getElementById('tb').readOnly=true;
		obj.className="key";
		$('#tb').unbind('focus');
	}else{
		document.getElementById('tb').readOnly=false;
		obj.className="keyOn";
		
		quickFlag = true;
		$("#tb").focus(function(){
			focusQuickNav(this);
		});
	}
}
//END 快速转入

/************************************ navPanel ************************************/
// 搜索系统功能
function searchFunc(keyword){

  var keyword = $.trim(keyword).toUpperCase();
	if(keyword == ""){
		 return;
	}else if(keyword.length < 2){
		alert("请输入至少两个文字",0);
		return;	
	}
	
	var isFunctionExit = false;
	var htmlString = "";
	opStr_quick = eval(opStr_quick);
	for(i=0;i<opStr_quick.length-1;i++){
		var temp = opStr_quick[i].split(" ");
		if((temp[0]).indexOf(keyword) != -1 || (temp[1]).indexOf(keyword) != -1 || ($.trim(temp[2]).toUpperCase()).indexOf(keyword) != -1){
		isFunctionExit = true;
		htmlString += "<li><a href=javascript:L(\""+content_array[i][0]+"\",\"" + content_array[i][1] + "\",\"" + content_array[i][2] +"\",\"" + content_array[i][3] +  
		"\",\""+ content_array[i][4] + "\");>" + "["+ temp[0] + "]" + temp[1] + "</a></li>";
		}
	}
	
	if(!isFunctionExit){
		htmlString += "功能不存在";
	}

	$('#functionResult').html(htmlString);
	$('#wait').hide();
	$('#system_search_result').show();
}

//导航区切换;
function HoverNav(flag,parentNode,parentName){
	//隐藏
	$.each( $(".navMain > div"), function(i, n){
		  $(".navMain > div")[i].className="undis";
	});
	
	$("#wait").show();
	if(flag =="fav")
	{
		$("#getFavFunc").addClass("on");
		$("#getTree").removeClass("on");
		$("#getAllTree").removeClass("on");
		//$("#getAuthorizeTree").removeClass("on");
		getFavFunc(flag);
	}else if(flag =="tree"){
		$("#getTree").addClass("on");
		$("#getFavFunc").removeClass("on");
		$("#getAllTree").removeClass("on");
		//$("#getAuthorizeTree").removeClass("on");
		getTree(parentNode,parentName);
	}else if(flag =="alltree"){
		$("#getAllTree").addClass("on");
		$("#getTree").removeClass("on");
		$("#getFavFunc").removeClass("on");
		//$("#getAuthorizeTree").removeClass("on");
		getTree(parentNode,parentName);
	}else if(flag =="authorizetree"){
		//$("#getAuthorizeTree").addClass("on");
		$("#getTree").removeClass("on");
		$("#getAllTree").removeClass("on");
		$("#getFavFunc").removeClass("on");
		getAuthorize();
	}
		
}

function reloadFavFunc(){
    //$("#node_favfunc").empty();
	var packet = new AJAXPacket("getFavFunc.jsp");
	core.ajax.sendPacketHtml(packet,doReloadFavFunc);
	packet =null;
}

function doReloadFavFunc(data){
    $("#node_favfunc").empty();
    $('#node_favfunc').html(data);
}

function getFavFunc(nodename)
{
	var node_favfunc = document.getElementById("node_favfunc");
	//alert(node_favfunc);
	if(node_favfunc == null)
	{
		node_favfunc = document.createElement("div");
		node_favfunc.setAttribute("className","dis");
		node_favfunc.setAttribute("id","node_favfunc");
		$(".navMain")[0].appendChild(node_favfunc);
			
		var packet = new AJAXPacket("getFavFunc.jsp");
		core.ajax.sendPacketHtml(packet,doGetFavFunc);
		packet =null;
	}else{
		setNav("fav");
		$('#node_favfunc')[0].className="dis";
		$("#wait").hide();
	}
}
 
function doGetFavFunc(data)
{
	setNav("fav");
	$("#wait").hide();
	$('#node_favfunc').html(data);
}

function getTree(parentNode,parentName)
{
	var treenode = document.getElementById("node"+parentNode);
	if(treenode == null)
	{
		treenode = document.createElement("div");
		treenode.setAttribute("className","dis");
		treenode.setAttribute("id","node"+parentNode);
		$(".navMain")[0].appendChild(treenode);
		
		var packet = new AJAXPacket("getTree.jsp");
		packet.data.add("parentNode" ,parentNode);
		packet.data.add("parentName" ,parentName);
		core.ajax.sendPacketHtml(packet,doGetTree);
		packet =null;
	}else{
		setNav("tree");
		treenode.className="dis";
		$("#wait").hide();
	}
}
 
function doGetTree(data)
{
	setNav("tree");
	$("#wait").hide();
	var currnode ;
	$.each( $(".navMain > div"), function(i, n){
		  if($(".navMain > div")[i].className=="dis")
		  {
		  	currnode=$(".navMain > div")[i].id;
		  	return false;
		  }
	}); 
	$("#"+currnode)[0].className="dis";
	$("#"+currnode).html(data);
}

function getAuthorize()
{
	
	var node_authorize = document.getElementById("node_authorize");
	if(node_authorize == null)
	{
		node_authorize = document.createElement("div");
		node_authorize.setAttribute("className","dis");
		node_authorize.setAttribute("id","node_authorize");
		$(".navMain")[0].appendChild(node_authorize);
			
		var packet = new AJAXPacket("ajax_getAuthorizeTree.jsp");
		core.ajax.sendPacketHtml(packet,doAuthorize);
		packet =null;
	}else{
		setNav("tree");
		$('#node_authorize')[0].className="dis";
		$("#wait").hide();
	}
}
 
function doAuthorize(data)
{
	setNav("tree");
	$("#wait").hide();
	$('#node_authorize').html(data);
}

//BEGIN HotKey
function getHotKey()
{
	var packet = new AJAXPacket("getHotKey.jsp");
  core.ajax.sendPacketHtml(packet,doProcessHotKey,true);
  packet =null;
}

function doProcessHotKey(data)
{
    var hotKeyScript = document.createElement("div");
	hotKeyScript.setAttribute("id","hotKeyScript");
	document.body.appendChild(hotKeyScript);
	$('#hotKeyScript').html(data);
}
//END HotKey
	
/* 安徽
function getHotKey()
{
	var packet = new AJAXPacket("ajax_gethotkey.jsp");
	core.ajax.sendPacketHtml(packet,doGetHotKey,true);
	packet =null;
}
	
function doGetHotKey(data)
{
	var hotKeyScript = document.createElement("div");
	hotKeyScript.setAttribute("id","hotKeyScript");
	document.body.appendChild(hotKeyScript);
	$('#hotKeyScript').html(data);
}
*/

function showFavMenu(functionCode)  //展现常用模块右键菜单
{
	var favMenu = document.getElementById('favMenu');
	
	var  rightedge  =  document.body.clientWidth-event.clientX; 
	var  bottomedge  =  document.body.clientHeight-event.clientY; 
	if  (rightedge  <  favMenu.offsetWidth) 
		favMenu.style.left  =  document.body.scrollLeft  +  event.clientX  -  favMenu.offsetWidth; 
	else 
		favMenu.style.left  =  document.body.scrollLeft  +  event.clientX; 
	if  (bottomedge  <  favMenu.offsetHeight) 
		favMenu.style.top  =  document.body.scrollTop  +  event.clientY  -  favMenu.offsetHeight-45; 
	else 
		favMenu.style.top  =  document.body.scrollTop  +  event.clientY-65; 
	favMenu.style.display  =  "block"; 
	
	activateTab('index');
	
	$('#favMenu #delIcon').bind('click',function(){
		addFavfunc(functionCode,"d","0");
	});
	
	$('#favMenu #editIcon').bind('click',function(){
		//addTab(true,'index','工作空间','../portal/work/portal.jsp');
		//document.getElementById("ifram").contentWindow.openDivWin("/npage/portal/work/modifyHotKey.jsp","自定义快捷键","300","400");
		//hideFavMenu();
		});
		
	$('#favMenu #helpIcon').bind('click',function(){
		callHelp(functionCode)
	});
}
$(document).click(function(){
	hideFavMenu();
	
	})

function  hideFavMenu() //隐藏常用模块右键菜单
{
	favMenu.style.display  =  "none"; 
	
	$('#favMenu #delIcon').unbind('click');
	$('#favMenu #editIcon').unbind('click');
}

/*
*管理常用功能
*id ：模块代码(function_code)
*op_type:操作类型(a,增加常用功能;d,删除常用功能;u,修改排列顺序)
*/
function addFavfunc(function_code,op_type,show_order)
{
	var  f = function_code.indexOf("custLater");
	if(f>-1)function_code = function_code.substr(f+9);
	if(function_code.indexOf("custid")>-1||$.trim(function_code)==""){
		showDialog("当前功能不能加入常用功能！",1);
		return false;
	}
	var packet = new AJAXPacket("favfunc_cfm.jsp");
	packet.data.add("function_code",function_code);
	if(typeof(op_type)=="undefined"){
		packet.data.add("op_type","i");//a-增加常用功能时只会给方法传一个参数
	}else{
		packet.data.add("op_type",op_type);
	}
	core.ajax.sendPacket(packet,doFavfunc,true);
	packet =null;
}

function doFavfunc(packet)
{
	
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var detailMsg = packet.data.findValueByName("detailMsg");
	if(retCode=="000000"){
		
		showDialog("操作成功",2);


		//刷新左侧常用功能树
		$(".navMain")[0].removeChild(document.getElementById("node_favfunc"));
		HoverNav('fav');

		//刷新工作空间的常用功能
		document.frames["ifram"].loadLoginMdl();

		//刷新客户首页常用功能树
		var tabSize = $("#contentArea iframe").size();
		for(var i=0;i<tabSize;i++)
		{
			if($("#contentArea iframe")[i].id.length>12)
			{
				if($("#contentArea iframe")[i].id.substring(0,12)=="iframecustid")
				{
					var custIframeId = $("#contentArea iframe")[i].id;
					
					document.frames[custIframeId].frames["user_index"].getFavFunc();
				}
			}
		}

	}else{
		showDialog(retMsg,0,"detail="+detailMsg);
	}
}

function tempAuthorize(pop_type,function_code,function_name,jsp_name,auFlag){
    if(pop_type=="2")
    {
        if(g_activateTab.substr(0,6)=="custid"){
               top.openDivWin("/npage/login/tempGrant.jsp?pop_type="+pop_type+"&function_code="+function_code+"&function_name="+function_name+"&jsp_name="+jsp_name+"&auFlag="+auFlag,'临时授权','505','294');
		}else
		{
				showDialog("请选择要办理的客户!",1);
		}
    }else
    {
    	top.openDivWin("/npage/login/tempGrant.jsp?pop_type="+pop_type+"&function_code="+function_code+"&function_name="+function_name+"&jsp_name="+jsp_name+"&auFlag="+auFlag,'临时授权','505','294');
    }
}

/************************************ workPanel ************************************/
function callHelp(tabId)//帮助系统
{
	window.open("../help/h"+tabId+".html");
}

function comment(tabId)//模块评分
{
    /*模块评分更改为查询当天费用
	var path = "/npage/public/rating.jsp";
	openDivWin(path,'模块评分','405','194');
	*/
	L("1","1560","查询当天费用","../npage/s1300/s1560.jsp","000");
}

var g_activateTab = "index";//active tabId
function activateTab(id)
{
    g_activateTab = id;
	if(document.getElementById(g_activateTab.substring(6,g_activateTab.length))!=null){
	iPhoneNo = "";
	iPhoneNo = document.getElementById(g_activateTab.substring(6,g_activateTab.length)).phone_no;
   }
}

function destroyTab(id)
{
	//关闭客户Tab时清session
	if(id.substring(0,6)=="custid")
	{
		var sendop_code = {};
		sendop_code["phone_no"] = id.substring(6,id.length);
		$.ajax({
		   url: 'destroy.jsp',
		   type: 'POST',
		   data: sendop_code,
		   error: function(data){
				if(data.status=="404")
				{
				  alert( "文件不存在!");
				}else if (data.status=="500")
				{
				  alert("文件编译错误!");
				}else{
				  alert("系统错误!");  					
				}
		   },
		   success: function(retCode){
		   }
		});
		sendop_code=null; 
		}
}

/************************************ footPanel ************************************/

function openwindow(url,name,iWidth,iHeight)
{
  var url;                            //转向网页的地址;
  var name;                           //网页名称，可为空;
  var iWidth;                         //弹出窗口的宽度;
  var iHeight;                        //弹出窗口的高度;
  var iTop  = (window.screen.availHeight-30-iHeight)/2;       //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-10-iWidth)/2;           //获得窗口的水平位置;
  var winOP = window.open(url,name,'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=yes,location=no,status=no');
  winOP.focus();     
}
		
/*******************end***************************/	
 	window.onunload=function(){
 	  if(isExit!=="1"){
 			closeWindow();
 		}
 	}
 	
 	window.onresize = function(){
		initPanel($("#layoutStatus").val());
	}
	/*
	 * 对走客户首页的模块进行功能校验
	 * 	valideVal	 N_N,Y_N,N_Y,Y_Y,第一位表示是否强制验证，第二位表示是否需要验证
	 */
	function funcVerify(valideVal,opcode,custId,g_activateTab,title,targetUrl){
		var  valideArr = valideVal.split("_");
		//alert(valideVal+"-->"+opcode);
		//alert(valideArr[0]+"-->"+valideArr[1]);
		addUserToSession(opcode,custId);
		//return  true;
		
		var  urlStr = "cust_id="+custId+"&opcode="+opcode+"&g_activateTab="+g_activateTab+"&title="+title;
		urlStr += "&id_no="+$.trim(top.document.getElementById("currUserId").value);
		document.getElementById("targetUrlDiv").value = targetUrl; //把URL后缀暂存main.jsp,在验证页面取
		if(valideArr[0]==="Y"){
			top.openDivWin("ajax_forceVerify.jsp?isForce=Y&"+urlStr,"验证信息","400","200");
		}else{
			if(valideArr[1]==="Y"){
				top.openDivWin("ajax_verify.jsp?isForce=N&"+urlStr,"验证信息","400","200");
			}else{
				return  true;
			}			
		}
	}
	function  addUserToSession(opcode,custId){
		var sendop_code = {};
		sendop_code["id_no"] = $.trim(top.document.getElementById("currUserId").value);
		sendop_code["cust_id"] = custId;
		sendop_code["op_code"] = opcode;
		sendop_code["brand_id"] = $.trim(top.document.getElementById("currBrandId").value);
		sendop_code["master_serv_id"] = $.trim(top.document.getElementById("currMasterServId").value);
		sendop_code["service_no"] = $.trim(top.document.getElementById("currPhoneNo").value);
		$.ajax({
		   url: 'ajax_addSession.jsp',
		   type: 'POST',
		   data: sendop_code,
		   error: function(data){
				if(data.status=="404")
				{
				  alert( "文件不存在!");
				}else if (data.status=="500")
				{
				  alert("文件编译错误!");
				}else{
				  alert("系统错误!");  					
				}
		   },
		   success: function(retCode){
		   }
		});
		sendop_code=null; 
	}
	
  /*
	 * 	openflag	 1.first tab;2.second tab;other open
	 *	opcode
	 *	title			 tab show text
	 *	targetUrl  page url
	 *	valideVal	 
	 */
	var isValidateFlag = false;
	/* 安徽
	function L(openflag,opcode,title,targetUrl,valideVal,grantNo)
	{
		if($.trim(targetUrl)==""||targetUrl=="#")return  false;//屏蔽目录节点打开页面
		if(openflag=="1")//first tab
		{
			if(targetUrl!="#"){
				targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title,grantNo);
				if($("#contentArea iframe").size() < 11){
					addTab(true,opcode,title,targetUrl);	
				}else{
					showDialog("只能打开10个一级tab",1);
				}
			}
		}else if(openflag=="2")//second tab
		{
			if(g_activateTab.substr(0,6)	=="custid"){
				openSecondTab(g_activateTab,targetUrl,opcode,title,valideVal,grantNo);
			}else
			{
				showDialog("请选择要办理的客户!",1);
			}
		}else if(openflag=="3")//如果客户首页已经打开，则打开二级tab，否则打开一级tab
		{
			var  _hasCustOpen = false;
			$("#contentArea iframe").each(function(){
				if($(this)[0].id.length>12&&$(this)[0].id.substring(0,12)=="iframecustid"){
					_hasCustOpen = true;
				}
			});
			
			if(_hasCustOpen){//打开二级tab
				if(g_activateTab.substr(0,6)=="custid"){
					openSecondTab(g_activateTab,targetUrl,opcode,title,valideVal,grantNo);
				}else
				{
					showDialog("请选择要办理的客户!",1);
				}
			}else{  //打开一级tab
				if(targetUrl!="#"){
					targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title,grantNo);
					if($("#contentArea iframe").size() < 11){
						addTab(true,"custLater"+opcode,title,targetUrl);	////以第三种方式打开的时候对tab做下标记
					}else{
						showDialog("只能打开10个一级tab",1);
					}
				}
			}
		}else if(openflag=="4")//一级tab打开集成页面
		{
			if(targetUrl!="#"){
				if($("#contentArea iframe").size() < 11){
					addTab(true,opcode,title,targetUrl);	
				}else{
					showDialog("只能打开10个一级tab",1);
				}
			}
		}
		else//弹出方式
		{
	  	if(targetUrl!="#"){
	  		targetUrl = "/npage/"+changeUrl(targetUrl,opcode,title,grantNo);
	  		var win= window.open(targetUrl,"","width="+screen.availWidth+",height="+screen.availHeight+",top=0,left=0,scrollbars=yes,resizable=yes,status=yes");
	  		setTimeout(function(){win.focus();},1000);
	  	}
	  }
	}
	*/
/*
	 * 	openflag	 1.first tab;2.second tab;3.callcenter;4.asweb|jlnewsaleweb;other
	 *	opcode
	 *	title			 tab show text
	 *	targetUrl  page url
	 *	valideVal
	 */
	function L(openflag,opcode,title,targetUrl,valideVal)
	{
		//alert("openflag|"+openflag+"\nopcode|"+opcode+"\ntitle|"+title+"\ntargetUrl|"+targetUrl+"\nvalideVal|"+valideVal);

		//first tab
		if(openflag=="1")
		{
				targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title);
				addTab(true,opcode,title,targetUrl);
		}
		//second tab
		else if(openflag=="2")
		{  
		    if(iPhoneNo == "index"&&opcode!="1104"&&opcode!="q046"&&opcode!="4603"&&opcode!="4100"&&opcode!="7518"&&opcode!="4977"){
		        rdShowMessageDialog("请输入手机号码!");
				    $("#iCustName").select();
				    return;
		    }
		    if(iPhoneNo == "custMain"){
		        rdShowMessageDialog("请选择一个用户!");
				    return;
		    }
		    if(iPhoneNo==""&&opcode!="1104"&&opcode!="q046"&&opcode!="4603"&&opcode!="4100"&&opcode!="7518"&&opcode!="4977"){
		        rdShowMessageDialog("请输入手机号码!");
				    return;		    	
		    }
		    
			//var patrn=/^((\(\d{3}\))|(\d{3}\-))?[12][03458]\d{9}$/;
			//if(g_activateTab.search(patrn)!=-1){
		  		if(typeof(valideVal)!="undefined"&&(valideVal.indexOf("1")!=-1)){ //需要验证
                chkIsValidate(valideVal,iPhoneNo,opcode);
                //if(isValidateFlag!=false)
                if(isValidateFlag==false)
                {
                 var path = "<%=request.getContextPath()%>/npage/public/publicValidate.jsp";
                 path =  path + "?valideVal="   + valideVal;
                 path =  path + "&titleName="   + title;
                 path =  path + "&activePhone=" + iPhoneNo;
                 path =  path + "&opCode=" + opcode;
                 var validateResult = window.showModalDialog(path,"","dialogWidth=450px;dialogHeight=250px");
                 if((validateResult=="undefined")||(validateResult!="1")){
                    return;
                  }
                }
          }
          targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title);
          targetUrl = targetUrl+"&activePhone="+iPhoneNo;
          document.getElementById("iframe"+g_activateTab).contentWindow.addTab(false,opcode,title,targetUrl);
			//}
			//手机号码
			//else
			//{
				//rdShowMessageDialog("请输入手机号码!");
				//$("#iCustName").select();
			//}
		}
	  else if(openflag=="4")
	  {
	  	targetUrl = changeUrl(targetUrl,opcode,title);
	  	addTab(true,opcode,title,targetUrl);
	  }
	  //默认旧业务弹出方式
	  else
	  {
	  	if(targetUrl!="#"){
	  		//targetUrl = changeUrl(targetUrl,opcode,title);
	  		
	  	  //targetUrl = changeUrl1(targetUrl,opcode,title);
	  		var win= window.open(targetUrl,opcode,"width="+screen.availWidth+",height="+screen.availHeight+",top=0,left=0,scrollbars=yes,resizable=yes,status=yes");
        addWinName(win,opcode);
        self.blur();
        setTimeout(function(){try {win.focus();} catch (e) {}},1000);
	  	}
	  }
	}
	
	function openPage(openflag,opcode,title,targetUrl,valideVal){
        L(openflag,opcode,title,targetUrl,valideVal);
    }
/*	
	//打开二级TAB  
	function  openSecondTab(g_activateTab,targetUrl,opcode,title,valideVal,grantNo){
		var user_index = document.getElementById("iframe"+g_activateTab).contentWindow.document.frames("user_index");
		if((!user_index)||(!user_index.document.all))return  false;
		if(typeof(user_index.document.all.isUserLoading)=="undefined")return false;
	//	if($.trim(user_index.document.all.isUserLoading.value)=="N")return false; //等待客户首页的用户列表加载完毕
	//	if($.trim(top.document.getElementById("userFinishFlag").value)=="N")return false; //新建用户的资料未入库，需要等待入库
		var  g_activeCustId = g_activateTab.substring(6);
		targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title,grantNo);
		targetUrl = targetUrl+addCustInfoToUrl(g_activeCustId); 
		if(funcVerify(valideVal,opcode,g_activeCustId,g_activateTab,title,targetUrl)){
			document.getElementById("iframe"+g_activateTab).contentWindow.addTab(false,opcode,title,targetUrl);
		}
	}
	//二级tab打开，在URL后增加客户首页中的客户用户信息
	function  addCustInfoToUrl(custId){
		var appenUrl = "&activeCustId="+custId+"&activePhone="+document.getElementById("currPhoneNo").value
			appenUrl +="&activeIdNo="+document.getElementById("currUserId").value
			appenUrl +="&contactId="+document.getElementById("iframe"+g_activateTab).contentWindow.document.frames("user_index").document.all.contactId.value
			appenUrl +="&activeBrandId="+document.getElementById("currBrandId").value
			appenUrl +="&activeMasterServId="+document.getElementById("currMasterServId").value
			appenUrl +="&activeProdId="+document.getElementById("currMainProdId").value
			appenUrl +="&activeProdName="+document.getElementById("currMainProdName").value
			appenUrl +="&activeBrandName="+document.getElementById("currBrandName").value
			appenUrl +="&activeMasterServName="+document.getElementById("currMasterServName").value;
		return  appenUrl ;
	}
*/
	function changeUrl(targetUrl,opCode,title,grantNo)
	{
	  	var flag = targetUrl.indexOf("?");
	  	if(parseInt(flag)==-1)
	  	{
	  		targetUrl=targetUrl+"?opCode="+opCode+"&opName="+title+"&crmActiveOpCode="+opCode;
	  	}else
	  	{
	  		targetUrl=targetUrl+"&opCode="+opCode+"&opName="+title+"&crmActiveOpCode="+opCode;
	  	}
	  	if(grantNo!=undefined)
	  	{            
	  		targetUrl=targetUrl+"&grantNo="+grantNo;
	  	}
	  	return targetUrl;
	}
	
	function changeUrl1(targetUrl,opCode,title)
  {
        var flag = targetUrl.indexOf("?");
        if(parseInt(flag)==-1)
        {
          targetUrl=targetUrl+"?opCode="+opCode+"&opName="+title;
        }else
        {
          targetUrl=targetUrl+"&opCode="+opCode+"&opName="+title;
        }
        
        //alert(targetUrl);    
        targetUrl=strcat(targetUrl);
        targetUrl=targetUrl.replace(new RegExp("&","gm"),"%26");       
        var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/public/timeValidate.jsp","正在进行用户有效性验证,请稍候...");
        chkInfoPacket.data.add("retType" ,     "timeValidate"  );
        chkInfoPacket.data.add("targetUrl" ,  targetUrl);
        core.ajax.sendPacket(chkInfoPacket,doProcesspwd);
        chkInfoPacket =null;
        
        return oldjumpurl;

  }
	
	function strcat()
    {
    	var result = "";
    	for(var i = 0; i< arguments.length; i++)
    	{
    		result = result + replaceConnectChar(arguments[i]) + '#';
    	}
    	return result;
    }
    
    function replaceConnectChar(s)
    {
      //var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
      //str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
      //str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
      //str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
      //str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
      var str = s.replace(/#/g, "＃");
      return str;
    }
	
	function chkIsValidate(validateVal,activePhone,opcode)
	{
	  	isValidateFlag = false;
	  	var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/public/chkIsValidate.jsp","正在进行用户有效性验证,请稍候...");

	    chkInfoPacket.data.add("retType" ,     "chkIsValidate"  );
	    chkInfoPacket.data.add("verifyVal" ,  validateVal);
	    chkInfoPacket.data.add("phoneNo" ,  activePhone);
	    chkInfoPacket.data.add("opCode" ,  opcode);
	    core.ajax.sendPacket(chkInfoPacket,doProcesspwd);
	    chkInfoPacket =null;
	}
	
    function doProcesspwd(packet)
	{
	    var retType = packet.data.findValueByName("retType");

	    if(retType=="chkIsValidate")
      {
      	var retCode = packet.data.findValueByName("retCode");
      	if(retCode=="000000")
      	 {
	         isValidateFlag = true;
      	 }
      }
      
       if(retType=="timeValidate")
      {
        var retCode   = packet.data.findValueByName("retCode");
        var timestamp = packet.data.findValueByName("timestamp");
        var targetUrl = packet.data.findValueByName("targetUrl");
        if(retCode=="000000")
         {
         	   if(targetUrl.indexOf("chncard") != -1){
         	   	   //alert('chncard');
         	   	   oldjumpurl=targetUrl;
         	  }else{
         	    targetUrl=targetUrl.substring(0,targetUrl.indexOf("#"));
         	    oldjumpurl=targetUrl+"&v99="+timestamp+"#";
         	      //alert(oldjumpurl);
         	   }
              return true;
         }else{
         	    
         	    alert("时间加密失败");
         	    return false;
        }
      }
	}
	
   /********清理cookie函数begin*******/
    function Clearcookie()   //清理 COOKIE  
    {  
	    var temp=document.cookie.split("; ");  
	    var len;  
	    var ts;  
	    for (len=0;len<temp.length;len++){  
	        ts=temp[len].split("=")[0];  
	        if (ts.indexOf("rkName")!=-1||ts=="cookieNum"){  //如果 ts含"rkName"则进行删除
	            var exp = new Date();    
	            exp.setTime(exp.getTime()-100000);//时间
	            var cval=temp[len].split("=")[1]; 
	            document.cookie = ts + "=" + cval + "; expires=" + exp.toGMTString();  
	        }
	    }   
    }  
   /******清理cookie函数end*******/
	
	$(document).ready(
		function(){
			layoutSwitch(<%=layout%>);			//初始化页面各部分的大小;参数1,2,3,4
			loadFirstMenu();//加载一级菜单
			HoverMenu('oli','li');//初始化菜单,绑定一级菜单事件,调用getTree
			HoverNav("fav");
			<%if(hotkey.equals("Y"))
			{%>
			//getHotKey();					//获取快捷键菜单
			<%}%>
			initSearch();					//初始化快速入口数据
			/*
			$(".more_set").hover(function(){$(this).find(".more_panel").show()},function(){$(this).find(".more_panel").hide()})
		  	$(".menu_set").hover(function(){$(this).find(".more_panel").show()},function(){$(this).find(".more_panel").hide()})
		  	*/
		  	$(".more_set").hover(function(){$(this).find(".more_panel").show();$("#moresetIf").height($(this).find(".more_panel").height());},
				function(){$(this).find(".more_panel").hide()})
			$(".menu_set").hover(function(){$(this).find(".more_panel").show();$("#menusetIf").height($(this).find(".more_panel").height());},
				function(){$(this).find(".more_panel").hide()})
			Clearcookie();
			 
    		
    		layoutSwitch(1);
    		if("<%=phoneNoPms%>"!=""){
    			addTabBySearchCustName("<%=phoneNoPms%>");
    		}
		});
	
	function  bindRemoveTab(id){
		if(id.substring(0,6)=="custid")
		{
			var oldRemoveTab = removeTab;
			removeTab = function(id){
				try{
					if(id.substring(0,6)=="custid")
					{
						var user_index = document.getElementById("iframe"+id).contentWindow.document.frames("user_index");
						if(user_index){
							if(user_index.document.getElementById("shoppingCarList").rows.length>1){
								if(confirm("确定要退出客户首页吗？")){
									if(confirm("是否撤单？")){
										user_index.remOrderConfirm();
									}else{
										return  false;
									}
								}else{
									return  false;
								}
							}
						}
					}
				    oldRemoveTab(id);
				 }catch(e){}
		    }
	    }
	}
	function imgLeftRight(){
 
	}
</script>	
</body>
</html>