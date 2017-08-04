<%
   /*
   * 功能: 系统主框架
　 * 版本: v1.0
　 * 日期: 2009-11-05
　 * 作者: wuln/hujie 
　 * 版权: sitech
   * 修改历史
   * 修改日期:2010-04-27      	修改人:liubo      修改目的:部署黑龙江
   * 修改日期:2010-08-19		修改人:songjia    修改目的:黑龙江客服系统框架整合
   * 修改日期:2011-08-03		修改人:hejwa      修改目的:黑龙江多op
   * 修改日期:2012-12-25		修改人:hejwa      修改目的:黑龙江ng3.5项目页面标准化满足规范
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page errorPage="../common/errorpage.jsp" %>

<!--(1)客服 songjia add 2010/08/19 begin -->
<%@ page import="java.net.InetAddress"%>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<!-- (1)客服 songjia add 2010/08/19 end -->

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	////防止直接输入URL进入模块页面
	String refererProxy=request.getHeader("referer");
	String password = (String)session.getAttribute("password");
	String kfLoginNo = (String)session.getAttribute("kf_login_no");
	if(null==refererProxy||"".equals(refererProxy))
	{
	%>

			<script language="javascript">
				if(typeof(opener) == "undefined")
				{
				  alert("禁止非法进入页面!");
				  window.opener=null;
				  window.open("","_self");
              	  window.close();
        }
		</script>
	<%
	}
%>
<%
//签入状态字段值
String state=request.getParameter("state");

//取session值
ArrayList retArray = (ArrayList)session.getAttribute("allArr");
String[][] lastInfo = (String[][])retArray.get(2);
String login_no   = (String)session.getAttribute("workNo");
String login_name = (String)session.getAttribute("workName");
String workNo = login_no;
String regionCode = (String)session.getAttribute("regionCode");
//String cssPath = (String)session.getAttribute("cssPath");
String cssPath = (String)session.getAttribute("themePath")==null?"default":(String)session.getAttribute("themePath");
String hotkey = (String)session.getAttribute("hotkey")==null?"Y":(String)session.getAttribute("hotkey");
String layout = (String)session.getAttribute("layout")==null?"1":(String)session.getAttribute("layout");

session.setAttribute("ccno",(String)request.getParameter("ccno"));
//(21)客服 songjia add 2010/08/20 begin 获取session值
String workName = (String)session.getAttribute("workName");
String orgName = (String)session.getAttribute("orgName");
String deptCode = (String)session.getAttribute("deptCode");
String orgId = (String)session.getAttribute("orgId");
String groupId = (String)session.getAttribute("groupId");
String powerCode = (String)session.getAttribute("powerCode");
String powerRight = (String)session.getAttribute("powerRight");
String orgCode = (String)session.getAttribute("orgCode");
String shomeflag=(String)session.getAttribute("shomeflag"); 
String limitCodeRows=(String)session.getAttribute("limitCodeRows"); 
String limitLoginFlag=(String)session.getAttribute("limitLoginFlag"); 



//(21)客服 songjia add 2010/08/20 end

//add by hucw,20110214,添加来电原因版本号,放入到session中
session.setAttribute("local.callcause.version",(Integer)application.getAttribute("callcause.tree.version"));
%>


<%-- /**  modified by hejwa in 20110714 多OP改造--最多打开tab页  begin **/ --%>
<%
String tabSql = "select to_char(open_max) from dwkspace where login_no=:workNo";
String tabParam = "workNo="+workNo;
//登录后第一次工作区设置，会记录多OP登录日志。
String duoOPLoginAccept = session.getAttribute("duoOPLoginAccept")==null?"":(String)session.getAttribute("duoOPLoginAccept");

	if("".equals(duoOPLoginAccept)){
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String ismopRoleSql = "select m_rolecode from DMOPROLERELA where b_rolecode='"+powerCode+"'";
	%>
	<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=ismopRoleSql%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_isRole" scope="end"/>
	<%
		System.out.println("---------result_isRole.length----------"+result_isRole.length);
		if(result_isRole.length>0){
	%>
		<wtc:service name="sInSystem" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
		  <wtc:param value="<%=workNo%>"/>
		  <wtc:param value="0000"/>	
		  <wtc:param value="<%=ip_Addr%>"/>	
		  <wtc:param value="<%=powerCode%>"/>
		  <wtc:param value="多OP登录日志"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
		<%
		if("000000".equals(retCode)){
			if(result.length>0){
				session.setAttribute("duoOPLoginAccept",result[0][0]);
			}
		}
		}
	}
	%>
<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeTab" retmsg="retMsgTab">
    <wtc:param value="<%=tabSql%>"/>
    <wtc:param value="<%=tabParam%>"/>
</wtc:service>
<wtc:array id="tabReturn" scope="end"/>
	
<%
		String tabOpenMax = "10";//打开最多TAB页的数量,默认是10
		
		
		if("000000".equals(retCodeTab)){
			if(tabReturn.length>0){
				tabOpenMax = tabReturn[0][0];
			}
		}
		if(tabOpenMax==null||"".equals(tabOpenMax.trim())){
			tabOpenMax = "10";
		}
String taskTcSql = "select count(*) from dTaskmsg where login_no='"+login_no+"' and to_char(seldate,'yyyyMMdd') = to_char(sysdate,'yyyyMMdd')";		
%>
<%-- /**  modified by hejwa in 20110714 多OP改造--最多打开tab页  end **/ --%>

	<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=taskTcSql%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_task" scope="end"/>
 
<%
String taskFlag = "";
if(result_task.length>0){
	taskFlag = result_task[0][0];
}
%>
<%-- /**  modified by hejwa in 20110714 多OP改造--最多打开tab页  end **/ --%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<title>中国移动客户关系管理系统</title>
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/framework_kf.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/rightmenu.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/rightKey.css" rel="stylesheet" type="text/css" />
	<!--(21)客服 songjia begin-->
		<link href="<%=request.getContextPath()%>/nresources/default/css/addnew_kf.css" rel="stylesheet" type="text/css" />
	<!--(21)客服 songjia end-->
	<%-- /**  modified by hejwa in 20110714 多OP改造--业务向导  begin **/ --%>
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/busiguide.css" rel="stylesheet"type="text/css">
	<%-- /**  modified by hejwa in 20110714 多OP改造--业务向导  end **/ --%>
	<!--hejwa 增加 ng3.5样式-->
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/ng35_kf.css" rel="stylesheet" type="text/css" />
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
	<!--
		客服暂时离开遮罩层 (26) add by songjia 20100823
	-->
	<div id="kf_loading" style='display:none'>
		<div id='Waiting' style='z-index:102333;left:40%;top:40%;width:20%; height:10%;'>
			<img src='<%=request.getContextPath()%>/nresources/default/images/wait_loading.gif'><br>请输入密码<input type='password' name="checkPW" value="" size="8" maxlength=6><input class="b_text" type="button"  name="subit" value="确定" onclick="checkPassWord();"><img src='<%=request.getContextPath()%>/nresources/default/images/wait_loading_1.gif'>
		</div>

	</div>

	<!--topPanel begin-->
	<%@ include file="../module/topPanel_kf.jsp"%>
	<!-- 存储ajax调用返回的html -->
	<div id="ajaxResult" style="display:none"></div>
	<!--topPanel end-->

	<!--searchPanel begin-->
	<%@ include file="../module/searchPanel_kf.jsp"%>
	<!--searchPanel end-->

	<!--ContentArea bengin-->
	<div id="contentPanel">

		<!--navPanel begin-->
		<%@ include file="../module/navPanel_kf.jsp"%>
		<!--navPanel end-->
		<div id="borderWorkAndNav"></div>
		<!--workPanel begin-->
		<%@ include file="../module/callPanel_kf.jsp"%>
		<%@ include file="../module/workPanel_kf.jsp"%>
		<!--workPanel end-->
	</div>
	<!--footPanel begin-->
	<%@ include file="../module/footPanel_kf.jsp"%>
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
<div id="msg_win" style="display:none;top:490px;visibility:visible;opacity:1;">
<div class="icos"><a id="msg_close" title="关闭" href="javascript:void 0">×</a></div>
<div id="msg_title">待办任务提示窗口</div>
<div id="msg_content">您今天有<%=taskFlag%>个待办任务，请查看待办任务</div>
</div>
<!--客服密码验证变量songjia(25)-->

	<input type="hidden" id="targetUrl_ps" value="">
	<input type='hidden' name='handleNo_townHi' id='handleNo_townHi'>
	<input type='hidden' name='run_nameHi' id='run_nameHi'>
	<input type="hidden" id="title_ps" value="">
	<input type="hidden" id="opcode_ps" value="">
	<input type="hidden" id="activephone_ps" value="">

	<input type="hidden" id="telNo_ps" value="" >
	<input type="hidden" id="telNo_oth" value="" >
	<input type="hidden" id="telId_oth" value="" >
	<input type="hidden" id="verifyTypec" value="" >
	<input type="hidden" id="ispmsuser1" value="" >
<!---->

<!--来电原因树最后一次点击时的id值-->
	<input type="hidden" id="lastCallCauseId" value="">
	<input type="hidden" id="lastCallCauseHeight" value="">
<!--->
<!--(3)客服 songjia add 2010/08/19 begin 修改为客服使用的jquery版本时出错。先使用这个版本-->
<script src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js" type="text/javascript"></script>
<!--(3)客服 songjia add 2010/08/19 end -->
<script src="<%=request.getContextPath()%>/njs/system/system.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/plugins/autocomplete.js"  type="text/javascript"></script>
<!-- 客服 tangsong update 2010/08/25 begin 由于客服比营业多了callpanel，故工作区的iframe高度要重新计算-->
<script src="<%=request.getContextPath()%>/njs/plugins/tabScript_jsa.js" type="text/javascript"></script>
<!--
<script src="<%=request.getContextPath()%>/njs/plugins/tabScript_jsa_kf.js" type="text/javascript"></script>
客服 tangsong update 2010/08/25 end -->
<script src="<%=request.getContextPath()%>/njs/plugins/MzTreeView12.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/redialog/redialog.js" type="text/javascript"></script>

<!--(4)客服 songjia add 2010/08/19 begin 引入客服xml加载帮助类、处理按钮明暗关系函数-->
<script src="/njs/csp/xmlHelper.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/csp/mutualArray.js" type="text/javascript"></script>


<!--(4)客服 songjia add 2010/08/19 end -->

<script language="javascript" type="text/javascript">
/*(5)客服 全局变量放置处 songjia add 2010/08/19 begin*/
var vlflag;
var xmlHelper = new XmlHelper();
var xmlSeach = new XmlHelper();
var openTabFlag = "1";
/*(5)客服 songjia add 2010/08/19 end*/

var iCustId = "";
var iPhoneNo = "index";

/*(6)客服 退出前验证 songjia add 2010/08/19 begin*/
window.onbeforeunload=function(){
	
	
	
}
/*(6)客服 songjia add 2010/08/19 */


//查询一级菜单
function loadFirstMenu(){
	//update by songjia ,提交页面修改为ajax_queryFirstMenuKf.jsp;
	var packet =  new AJAXPacket("ajax_queryFirstMenuKf.jsp");
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
	//updated by tangsong 20100825 修改以使导航区的横向滚动条完全展示并处于最底部
	//var marginHeight=9;
		$("#workPanel").css("height","90%");
	var marginHeight=5;
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
		//updated by tangsong 20100825 修改"我的信息"页面的高度，使竖向滚动条能完全展示
		iframe[i].style.height=(workPanelHeight-tabHeight)+"px";
		//iframe[i].style.height=(workPanelHeight-tabHeight-60)+"px";
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
//(12)客服 songjia add 2010/08/19 级联关闭弹出窗口变量 begin
//tancf 整合201003098
	var popupWin;
	var canLoopAlertPopupWin = true;
//(12)客服 songjia add 2010/08/19 级联关闭弹出窗口变量 end
//黑龙江退出系统
function closeWindow(){
	//add wanghong 为了在接续时点击退出时限制其退出
	if(window.top.current_CurState ==5||window.top.current_CurState ==4){
		      rdShowMessageDialog("通话状态无法退出工号!"); 
		      return false;
	}
	//(12)客服 songjia add 2010/08/19 级联关闭弹出窗口 begin
	//tancf 整合20100630
	
	
	if(rdShowConfirmDialog("确认要关闭么?")==1)
		{
	try
	{
				
			     signOutFromIE();
			 
	}
	catch(e)
	{
	}
	//tancf 整合20100630完成
	canLoopAlertPopupWin = false;
	if (popupWin != null && !popupWin.closed){popupWin.close();}
	//(12)客服 songjia add 2010/08/19 级联关闭弹出窗口 end

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
	  isExit = "1";
    var prop="dialogHeight:150px; dialogWidth:320px; status:no;unadorned:yes";
    window.showModalDialog("logout.jsp","",prop);
    window.opener=null;
    window.open('','_self');
    window.close();
  }
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
								//(9)客服 songjia add 2010/08/19 修改childTab2.jsp为客服childTab2_kf.jsp begin
								//addTab(true,phoneNo,phoneNo,'childTab2.jsp?activePhone='+phoneNo);
								addTab(true,phoneNo,phoneNo,'childTab2_kf.jsp?activePhone='+phoneNo);
								//(9)客服 songjia end 2010/08/19
						  }else{
								rdShowMessageDialog("手机号码信息不正确,打开Tab页出错!");
				      }
				      $("#phoneNo").val("请输入手机号码");
				    }
					});
					sendphone_no=null;
		 }
	}
//(10)客服 songjia 密码验证 begin 2010/08/19
 /*
	 * 	openflag	 1.first tab;2.second tab;3.callcenter;4.asweb|jlnewsaleweb;other
	 *	opcode
	 *	title			 tab show text
	 *	targetUrl  page url
	 *	valideVal
	 */


	var kfFlagOc = "";  // opcode 是否需要 密码校验标志 hejwa add
	function ajaxOpcodeLimit(opCodev){
	  var chkInfoPacket = new AJAXPacket("ajaxOcLimit.jsp","正在获取opCode密码校验状态,请稍候...");
        chkInfoPacket.data.add("opCode" ,     opCodev);
        core.ajax.sendPacket(chkInfoPacket,doAjaxOpcodeLimit);
		    chkInfoPacket =null;
	}
	function doAjaxOpcodeLimit(packet){
		kfFlagOc = packet.data.findValueByName("kfFlagOc");
		//alert("kfFlagOc|"+kfFlagOc)
	}
	 function doProcess1(packet){

	 }
	function ajaxSetSession(phoneNo,flag){
		var phstuPacket = new AJAXPacket("ajaxSetSession.jsp","请稍候...");
        phstuPacket.data.add("phoneNo" ,phoneNo);
        phstuPacket.data.add("flag" ,flag);
        core.ajax.sendPacket(phstuPacket,doProcess1);
		    phstuPacket =null;
	}
	function ajaxGetSession(g_activateTab){
		var phstuPacket = new AJAXPacket("ajaxGetSession.jsp","请稍候...");
				phstuPacket.data.add("phoneNo" ,g_activateTab);
        core.ajax.sendPacket(phstuPacket,doAjaxGetSession);
		    phstuPacket =null;
	}
	var phone_kf_check = "";
  var phone_kf_flag  = "";
 function doAjaxGetSession(packet){
 	phone_kf_check = packet.data.findValueByName("phone_kf_check");
 	phone_kf_flag  = packet.data.findValueByName("phone_kf_flag");
 }
 
 var g_checkPwdOth;//1为他机密码验证,他机密码验证时,用户信息页不做主叫、受理号码一致性判断
 function toOpenTab(){
 //	alert("document.all.acceptPhoneNo.value|"+document.all.acceptPhoneNo.value+"\ndocument.all.telNo_oth.value|"+document.all.telNo_oth.value);

 	if(document.all.telNo_oth.value!=document.all.acceptPhoneNo.value){//他机验证 返回
 		//alert("他机验证 返回");
 		openTabFlag = "0";
 		g_checkPwdOth = 1;
 		addTabBySearchCustName(document.all.telNo_oth.value,'kf');//相当于输入手机号打开验证成功的tab

 	}else{                                                                //本机验证返回
 		//alert("本机验证 返回");
 		  var targetUrl=document.getElementById("targetUrl_ps").value;
		  var title=document.getElementById("title_ps").value;
		  var opcode =document.getElementById("opcode_ps").value;
		  var g_activateTab=document.getElementById("activephone_ps").value;
		  var telNo_pss=document.getElementById("telNo_ps").value;
		  //alert("targetUrl|"+targetUrl+"\ntitle|"+title+"\nopcode|"+opcode+"\ng_activateTab|"+g_activateTab+"\ntelNo_pss|"+telNo_pss);
			document.getElementById("iframe"+g_activateTab).contentWindow.addTab(false,opcode,title,targetUrl);

 	}
}
//验证是否打特服办理界面
function toOpenTFTab(){
	if (document.getElementById("iframe5556")) {
		document.frames["iframe5556"].doToTF();
	}
}
 function checkPasswd(){
//	cCcommonTool.DebugLog("javascript  显示密码验证开始");
//
//	var height = 150;
//	var width = 260;
//	var top = screen.availHeight/2 - height/2;
//	var left = screen.availWidth/2 - width/2;
//	var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=yes";
//	window.open("../../npage/callbosspage/K086/otherPhoneCheck.html", "checkPasswd", winParam);
//  cCcommonTool.DebugLog("javascript  显示密码验证结束");
//  height = null;
//  width = null;
//  top = null;
//  left = null;
//  winParam = null;

	var acceptPNo = document.getElementById("acceptPhoneNo").value;

	if(acceptPNo==""||acceptPNo==null){
		var caller_phone1 = cCcommonTool.getCaller();
		if(cCcommonTool.getOp_code()=="K025"){
			document.getElementById("acceptPhoneNo").value = cCcommonTool.getCalled();
		}else{
			document.getElementById("acceptPhoneNo").value = caller_phone1;
		}
	}
	acceptPNo = document.getElementById("acceptPhoneNo").value;
	var path = "../../npage/public/publicValidate_kf.jsp";
	path =  path + "?valideVal="   + "";
	path =  path + "&titleName="   + "";
	path =  path + "&activePhone=" + acceptPNo;
	path =  path + "&opCode=" + ""+"&opeFlag=1";
	path =  path + "&acceptPNo=" + acceptPNo;

	var h = 250;
	var w = 450;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	//var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; ";
	var validateResult = window.showModalDialog(path,window,prop);
	if((validateResult=="undefined")||(validateResult!="1")){  // 校验失败
		ajaxSetSession(document.all.telNo_oth.value,"0");
	  return;
	}else if((validateResult=="undefined")||(validateResult=="kf_ivr")){
		//转入ivr流程
	}else{
		similarMSNPop("密码校验正确");
		ajaxSetSession(document.all.telNo_oth.value,"1");
	}
}

//(10)客服 songjia end 2010/08/19
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

//(14)客服 songjia begin 2010/08/19
/*
function addTabBySearchCustName(custType,enterType)
{
		 //如果是按钮点击进入
  	 if(enterType=='button')
  	 {
  	 	 var phoneNo = $("#iCustName2").val();
  	 	 $("#iCustName2").val("");
  	 	 $("#iCustName").val("请输入手机号码查询");
  	 }
  	 //回车进入
  	 else
  	 {
  	 	 var phoneNo = $("#iCustName2").val();
  	 	 $("#iCustName2").val("");
  	 	 $("#iCustName").val("请输入手机号码查询");
  	 }

			//var phoneNo = $("#iCustName").val();
			if(phoneNo=="请输入信息进行查询"||phoneNo=="")
			{
				rdShowMessageDialog("请输入查询条件");
				return false;
			}

			var loginType = custType;
			var packet = new AJAXPacket("getCustId.jsp");
			packet.data.add("phoneNo" ,phoneNo);
			packet.data.add("loginType" ,loginType);
			core.ajax.sendPacket(packet,doGetCustId,true);
			packet =null;
		}
*/
var enterTypeAll="";
var wlancallcause="";
//快速登录函数
function addTabBySearchCustName(custType,enterType)
{
	//alert("addTabBySearchCustName#\ncustType|"+custType+"\nenterType|"+enterType);
	  enterTypeAll=enterType;
	  cCcommonTool.DebugLog("enterTypeAll"+enterTypeAll);
	  //add by songjia 20101109 清空呼叫技能
		 /*if(enterType!='kf')
		 {
		 		document.getElementById('callSkill').value="";
		 }*/
		 //如果是按钮点击进入
  	 if(enterType=='button')
  	 {
  	 	 var phoneNo = $("#iCustName2").val();
  	 	 $("#iCustName2").val("");
  	 	 //$("#iCustName").val("请输入手机号码查询");
  	 }
  	 //20100309 tancf 客服渠道
  	 else if (enterType=='kf')
  	 	{
  	 		var phoneNo = custType;
  	 		// update by songjia 客服(25) begin
  	 		//custType=document.all.loginType.value;
  	 		custType=document.all.cust_type.value;
  	 		//end
  	 	}
  	 	else if (enterType=='addBut')//点受理号码时进入，记录的手机号码
  	 	{
  	 		var phoneNo = document.getElementById("acceptPhoneNo").value;
  	 		$("#iCustName2").val("");
  	 		custType="1";
  	 	}
  	 	else if (enterType=='addLink')//点受理号码时进入，记录的手机号码
  	 	{
  	 		var phoneNo = custType;
  	 		$("#iCustName2").val("");
  	 		custType="1";
  	 	}
  	 else
  	 {
  	 	 var phoneNo = $("#iCustName2").val();
  	 	 $("#iCustName2").val("");
  	 	 //$("#iCustName").val("请输入手机号码查询");
  	 }

			//var phoneNo = $("#iCustName").val();
			if(phoneNo=="请输入信息进行查询"||phoneNo=="")
			{
				rdShowMessageDialog("请输入查询条件");
				return false;
			}
			var loginType = custType;
			var packet = new AJAXPacket("getCustId.jsp");
			packet.data.add("phoneNo" ,phoneNo);
			packet.data.add("enterType" ,enterType);
			packet.data.add("loginType" ,loginType);
			core.ajax.sendPacket(packet,doGetCustId,true);
			packet =null;
		}
	//(14)客服 songjia end 2010/08/19

		/*
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
		}*/
		function doGetCustId(packet)
		{
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var custIdArr = packet.data.findValueByName("custIdArr");
			var custNameArr = packet.data.findValueByName("custNameArr");

			var custIccidJ = packet.data.findValueByName("custIccid");
			var custCtimeJ = packet.data.findValueByName("custCtime");

			var loginType = packet.data.findValueByName("loginType");
			
			var phoneNo = packet.data.findValueByName("phone_no");
			var phone_no ="";
			if(phoneNo.length==1){
				phone_no=phoneNo[0];
			}
			var callerPhone_New="";
			    
			
			
			//added by tangsong 20110304 查询客户信息时自动切换到用户信息界面
			HoverNav('userinfo');
			//(15)客服 songjia begin  暂时注释掉。修改完成后打开注释2010/08/19
	  cCcommonTool.DebugLog("retCode"+retCode);
			if(retCode=="0"||retCode=="1000"){
					//tancf 20100308
				var workNum=cCcommonTool.getWorkNo();
				var currentState=0;
				if(parPhone.QueryAgentStatusEx(workNum)==0){
					currentState=parPhone.AgentInfoEx_CurState;
				}
          if(currentState==5)
            {
                updatePhoneNo(phone_no);  //modify by yinzx 0811  替换 $("#phoneNo").val() 为 phoneNo;
            }
        /*    
// add wanghong  增加弹出用户信息页判断主叫号码,查询用户来话信息 20110711
					if(currentState==5||currentState==4){
					if(window.cCcommonTool.getOp_code()=="K025"){    
          callerPhone_New = window.cCcommonTool.getCalled();
	        }else{    
          callerPhone_New = window.cCcommonTool.getCaller();
           $('#caller_phone_no').html(callerPhone_New);
	        }
         $('#phone_no1').html(callerPhone_New);
				if(phone_no!=callerPhone_New&&enterTypeAll=='kf'){
		      phone_no=callerPhone_New;
				}
			  }*/
           //tancf20090321修改受理号码结束
        lastphoneflag=lastphoneflag + 1;
           		//tancf 20110601
           	if(enterTypeAll!='kf')
           	{
		       	callCome(phone_no,document.getElementById("contactId").value);
		     		}		     			
		       	if(phone_no.indexOf("请输入")==-1){
		       		document.getElementById("acceptPhoneNo").value =phone_no;
		      	}
				//add by chenhr.20100525,此参数是为了向客户挽留页面传参
				var contactId =	document.getElementById("contactId").value;
				//alert(phone_no);
				//add by songjia 增加技能参数 20101109
				var callSkill = document.getElementById("callSkill").value;
			  try{
						parent.removeTab("5556");
					}
				catch(e){}		
				//主叫号码
				var kfcaller = window.cCcommonTool.getCaller();
			   if(callSkill != "")
			   {
				   var sit = callSkill.lastIndexOf(',');
				   if(sit != -1)
				   {
				   		callSkill = callSkill.substring(sit+1)
				   }
				 }
				//end
				//alert("caller_phone_no|"+document.getElementById("caller_phone_no").value);
				var pathTemp = "login/callCustInfo.jsp?custIdArr="+custIdArr+"&custNameArr="+custNameArr+"&loginType="+loginType+"&phone_no="+phone_no+"&loginType="+document.all.cust_type.value+"&contactId="+contactId+"&callSkill="+callSkill+"&kfcaller="+kfcaller+"&enterTypeAll="+enterTypeAll+"&checkPwdOth="+g_checkPwdOth;
     		if (enterTypeAll=='kf')
     		{					
     			enterTypeAll='';
     		}
			  cCcommonTool.DebugLog("phone_no in L"+phone_no);
			  L("1","5556","用户信息",pathTemp,"000");
			   cCcommonTool.DebugLog("phone_no in L pathTemp"+pathTemp);
			  return;
			}else{
				try{
						parent.removeTab("5556");
					}
				catch(e)
				{}
				//tancf 20100308
				lastphoneflag=lastphoneflag + 1;
				//tancf 20110601
				if(enterTypeAll!='kf')
        {
				callCome(phone_no,document.getElementById("contactId").value);
			  }
		  	else if (enterTypeAll=='kf')
     		{					
     			enterTypeAll='';
     		}
				if(phone_no.indexOf("请输入")==-1){
					document.getElementById("acceptPhoneNo").value = phone_no;
				}
				return;
			}
			//(15)客服 songjia end 2010/08/19
			if(retCode!="0")
			{
				rdShowMessageDialog(retCode+","+retMsg,0);
				return false;
			}else
			{
				//alert("custIdArr.length|"+custIdArr.length);
					if(custIdArr.length==1)
					{
						parent.openCustMain(custIdArr,custNameArr,loginType,phone_no);
					}else
					{
						var path="selectCustId.jsp?opName=选择客户&custIdArr="+custIdArr+"&custNameArr="+custNameArr+"&custIccid="+custIccidJ+"&custCtime="+custCtimeJ;
						//openDivWin(path,'选择客户','600','400');
						window.open(path,"newwindow","height=600, width=600,top=50,left=250,scrollbars=yes, resizable=no,location=no, status=yes");
					}
			}

			$("#phoneNo").val("请输入信息进行查询");
		}
//(16)客服 songjia begin  2010/08/19
/*
function openCustMain(custId,custName,loginType,phone_no)
{
    iCustId = custId;
	if($("#contentArea iframe").size() < 11){
		addTab(true,"custid"+custId,custName,'childTab2_kf.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&activePhone='+phone_no);
		$("#phoneNo").val("请输入信息进行查询").blur();
		//document.all.phoneNo.blur();
		//layoutSwitch(1,$(".a1")[0]);
	}else{
		rdShowMessageDialog("只能打开10个一级tab");
	}
}*/
function openCustMain(custId,custName,loginType,phone_no)
{
  
	//alert("openCustMain|"+"\n\n\n"+"custId|"+custId+"\ncustName|"+"\nloginType|"+loginType+"\nphone_no|"+phone_no);
    iCustId = custId;
    //(17)客服 songjia begin  修改完成后取消注释2010/08/19
    //tancf 20100310 增加
    document.getElementById("last_caller_phone").value="custid"+custId;
    //(17)客服 songjia end  2010/08/19
	if($("#contentArea iframe").size() <= <%=tabOpenMax%>){
		//added by tangsong 20110527 iPhoneNo在这里赋值，取消在activateTab函数里赋值(避免有时取到上一个客户的电话号码)
		iPhoneNo = phone_no;
		addTab(true,"custid"+custId,custName,'childTab2_kf.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&activePhone='+phone_no);
		$("#phoneNo").val("请输入信息进行查询");
		//document.all.phoneNo.blur();
		//layoutSwitch(1,$(".a1")[0]);

		if(openTabFlag=="0"){
        setTimeout("addTabOp()",3000);
        openTabFlag = "1";
     	}
	}else{
		rdShowMessageDialog("只能打开<%=tabOpenMax%>个一级tab");
	}
}
function addTabOp(){

	  var targetUrl=document.getElementById("targetUrl_ps").value;
	  var title=document.getElementById("title_ps").value;
	  var opcode =document.getElementById("opcode_ps").value;
	  var g_activateTab=document.getElementById("telId_oth").value;
	  var telNo_pss=document.getElementById("telId_oth").value;
	  //alert("targetUrl|"+targetUrl+"\ntitle|"+title+"\nopcode|"+opcode+"\ng_activateTab|"+g_activateTab+"\ntelNo_pss|"+telNo_pss);

	 document.getElementById("iframe"+g_activateTab).contentWindow.addTab(false,opcode,title,targetUrl);
}
//(16)客服 songjia end  2010/08/19
/* 安徽
function openCustMain(custId,custName,loginType,phone_no,signUser,id_no)
{
	showWinCover();
	if($("#contentArea iframe").size() < 11){
		addTab(true,"custid"+custId,formatString(custName),'childTab_kf.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&signUser='+signUser+"&idNo="+id_no+"&isMarket=true");
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
	if($("#contentArea iframe").size() <= <%=tabOpenMax%>){
		addTab(true,"custid"+custId,formatString(custName),'childTab_kf.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&contactId='+contactId+'&idNo='+idNo+'&opType='+opType);

		bindRemoveTab("custid"+custId);
	}else{
		showDialog("只能打开<%=tabOpenMax%>个一级tab",1);
	}
}
//从待办任务过来，打开客户首页
function openCustMainForUnset(custId,custName,loginType,phone_no,signUser,unsetFrom,contentArr,idNo)
{
	if(!isTabExist()) return false; //防止打开两个客户首页
	if(loginType==="PHONE_NO") loginType="11";  //由于引用此方法的地方都写死为PHONE_NO,为避免大量修改，转换为数据库中的数据
	showWinCover();
	$("#contentArr").val(contentArr);
	if($("#contentArea iframe").size() <= <%=tabOpenMax%>){
		addTab(true,"custid"+custId,custName,'childTab_kf.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&signUser='+signUser+'&unsetFrom='+unsetFrom+'&idNo='+idNo);

		bindRemoveTab("custid"+custId);
	}else{
		showDialog("只能打开<%=tabOpenMax%>个一级tab",1);
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
	if($("#contentArea iframe").size() <= <%=tabOpenMax%>){
		addTab(true,"custid"+custId,custName,'childTab2_kf.jsp?gCustId='+custId+'&custOrderId='+custOrderId);
		$("#phoneNo").val("请输入信息进行查询");
		//document.all.phoneNo.blur();
		//layoutSwitch(1,$(".a1")[0]);
	}else{
		rdShowMessageDialog("只能打开<%=tabOpenMax%>个一级tab");
	}
}

function doChangeType(obj){
    var type = obj.value;
    //客服添加 songjia (24) begin
    $("#cust_type").val(type);
    //end
    if(type == "0"){
        $("#iCustName").val("请输入客户ID进行查询");
    }else if(type == "1"){
        //$("#iCustName").val("请输入手机号码查询");
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

//hejwa增加受理号码功能b  newCustAddBut
		function newCustAddBut(){
				var phoNeNo = document.getElementById("acceptPhoneNo").value;
				if(phoNeNo==""){
					rdShowMessageDialog("请先输入手机号码");
					return false;
				}
				addTabBySearchCustName(phoNeNo,'addBut');//相当于输入手机号打开验证成功的tab
		}

function newCustF(){
		L("1","1100","客户开户","sq100/sq100_1.jsp","000");
	}
//(18)客服 songjia begin 暂时离开验证密码  2010/08/19
	//ccs tancf 暂时离开 20090305
function checkPassWord(){
	btn_More();
	var pwValue=document.getElementById("checkPW").value;
	var packet = new AJAXPacket("../../../npage/callbosspage/checkPW/check.jsp", "\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("retType", "chkExample");
	packet.data.add("checkpw", pwValue);
	core.ajax.sendPacket(packet, doProcesspp, false);
	packet = null;
}
//tancf 暂时离开20090305
function doProcesspp(packet){
  var retType = packet.data.findValueByName("retType");
  var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
      var strmsg = packet.data.findValueByName("strmsg");
  if(retType=="chkExample"){
  	if(retCode=="000000"){
  		document.getElementById("kf_loading").style.display='none';
  	}
  	/*add by hucw 20110107,密码将要过期判断*/
  	else if(retCode == "900099"){
  		rdShowMessageDialog(strmsg,0);
  		document.getElementById("kf_loading").style.display='none';
  	}else{
      rdShowMessageDialog(strmsg,0);
			return false;
		}
   }
}
//(18)客服 songjia end 暂时离开验证密码  2010/08/19
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
		getQuickNavData(obj);
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
  actb(document.getElementById('tb'),document.getElementById('tb_h'),eval(opStr_quick));
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
//(19)客服 songjia add 2010/08/19 begin 添加用户信息tab
function HoverNav(flag,parentNode,parentName){
	//隐藏
	$.each( $(".navMain > div"), function(i, n){
		  $(".navMain > div")[i].className="undis";
	});
if(flag!="buGu"){
		hideBusiguideHead(1);
	}else{
		hideBusiguideHead(2);
	}
	$("#wait").show();
	if(flag =="fav")
	{
		$("#getFavFunc").addClass("on");
		$("#getTree").removeClass("on");
		$("#getAllTree").removeClass("on");
		$("#getUserInfo").removeClass("on");
		$("#buGu").removeClass("on");
		//$("#getAuthorizeTree").removeClass("on");
		getFavFunc(flag);
	}else if(flag =="tree"){
		$("#getTree").addClass("on");
		$("#getFavFunc").removeClass("on");
		$("#getAllTree").removeClass("on");
		$("#getUserInfo").removeClass("on");
		//$("#getAuthorizeTree").removeClass("on");
		$("#buGu").removeClass("on");
		getTree(parentNode,parentName);
	}else if(flag =="alltree"){
		$("#getAllTree").addClass("on");
		$("#getTree").removeClass("on");
		$("#getFavFunc").removeClass("on");
		$("#getUserInfo").removeClass("on");
		//$("#getAuthorizeTree").removeClass("on");
		$("#buGu").removeClass("on");
		getTree(parentNode,parentName);
	}else if(flag =="buGu"){
		$("#buGu").addClass("on");
		$("#getTree").removeClass("on");
		$("#getAllTree").removeClass("on");
		$("#getFavFunc").removeClass("on");
		$("#getUserInfo").removeClass("on");
		//getAuthorize();//业务向导函数
		setNav('N');
		$("#wait").hide();
	}else if(flag =="authorizetree"){
		//$("#getAuthorizeTree").addClass("on");
		$("#getTree").removeClass("on");
		$("#getAllTree").removeClass("on");
		$("#getFavFunc").removeClass("on");
		$("#getUserInfo").removeClass("on");
		$("#buGu").removeClass("on");
		getAuthorize();
	}else if(flag =="userinfo"){//新增
		//$("#getAuthorizeTree").addClass("on");
		$("#getTree").removeClass("on");
		$("#getAllTree").removeClass("on");
		$("#getFavFunc").removeClass("on");
		$("#buGu").removeClass("on");
		$("#getUserInfo").addClass("on");
		getUserInfo();
	}

}

//客服  add by chenhr.2010/10/14 end 点击左侧栏中受理号码添加用户信息tab
function newCustCall(obj){
	var phone=obj.innerText;
	if(phone==""||phone=="10086"){
			return false;
	}else{
		addTabBySearchCustName(phone,'addLink');
	}
}
//(19)客服 songjia add 2010/08/19 end 添加用户信息tab
//(20)客服 songjia add 2010/08/19 begin 用户信息tab函数
function getUserInfo()
{
	var node_userinfo = document.getElementById("node_userinfo");

	if(node_userinfo == null)
	{
		node_userinfo = document.createElement("div");
		node_userinfo.setAttribute("className","dis");
		node_userinfo.setAttribute("id","node_userinfo");
		$(".navMain")[0].appendChild(node_userinfo);
		$('#node_userinfo').html("<li><div id='tbc_01'><div  class='functitle'  style='color:#000000;background:url(../../nresources/default/images/icon_titleO.gif) no-repeat 1px 7px;padding:3px 0 0 16px;font-weight:bold;'>用户呼入流水</div><table style='color:#009000;width:99%;'><tr><td colspan='3' id='contactIdnew'  style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>主叫号码</th><td colspan='2' id='caller_phone_no' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='newCustCall(this);copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>受理号码</th><td colspan='2' id='phone_no1' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='newCustCall(this);copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>被叫号码</th><td colspan='2' id='called_phone_no' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>主叫归属地</th><td colspan='2' id='town' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>客户姓名</th><td colspan='2' id='cust_name' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td>				</tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>客户级别</th><td colspan='2'  id='card_name' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>客户品牌</th><td colspan='2' id='sm_name' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>受理方式</th><td colspan='2' id='handleType' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr id='handleNo_town_tr' style='display:none'><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>受理归属地</th><td colspan='2' id='handleNo_town' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>运行状态</th><td colspan='2' id='run_name' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>预存款</th><td colspan='2' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' id='prepay_fee1' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>当月可用预存款总额</th> <td colspan='2' id='hasMoney' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>欠费</th><td colspan='2' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' id='prepay_fee2' onclick='copyToClipBoard(this)'></td></tr><tr id='speciallight' style='display:none' ><th  style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'><img  src='/nresources/default/images/ico_16/009i.gif' /></th> <td style='text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' colspan='2' id='specialcontent'  value='' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>呼叫轨迹</th><td colspan='2' id='call_track' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>呼叫技能</th><td colspan='2' id='call_skill' style='color:#ff0000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:120px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>密码验证错误次数</th><td colspan='2' id='password_error_num' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:120px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>不良骚扰</th><td colspan='2' id='blUserNum' style='color:#F00;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'></td></tr></table></div></li>");
	}
 
	setNav("N");
	$('#node_userinfo')[0].className="dis";
	$("#wait").hide();


}


//(20)客服 songjia add 2010/08/19 end 用户信息tab函数

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
		addTab(true,'index','工作空间','../portal/work/portal.jsp');
		document.getElementById("ifram").contentWindow.openDivWin("/npage/portal/work/modifyHotKey.jsp","自定义快捷键","300","400");
		hideFavMenu();
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
	/** modified by hejwa in 20110718 多OP改造--收藏夹功能 begin**/
	if(typeof(op_type)=="undefined"){
		op_type = "i"
	}
	
	//alert("addFavfunc->\nfunction_code|"+function_code+"\nop_type|"+op_type);
	
	if(op_type=="i"){
		var pro = "scroll:yes;dialogHeight:140px;dialogWidth:330px;dialogTop:158px;dialogLeft:300px";
		window.showModalDialog("addFavFunc.jsp?function_code="+function_code,window,pro);
	}else{
		var packet = new AJAXPacket("favfunc_cfm.jsp");
		packet.data.add("function_code",function_code);
		packet.data.add("op_type",op_type);
		core.ajax.sendPacket(packet,doFavfunc,true);
		packet =null;
	}
	
}

function doFavfuncshow(retCode,retMsg,detailMsg)
{
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
		showDialog(retMsg,0,"detail=操作失败："+retMsg);
	}
}
/** modified by hejwa in 20110718 多OP改造--收藏夹功能 begin**/

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
	if (tabId.length != 4) {
		rdShowMessageDialog("此功能不提供在线帮助！", 1);
		return false;
	}
	
	var getFuncNamePacket = new AJAXPacket("ajaxGetFuncName.jsp","正在进行号码校验，请稍候......");
	getFuncNamePacket.data.add("functionId", tabId);
	core.ajax.sendPacket(getFuncNamePacket, doCallHelp);
	getFuncNamePacket = null;
}

function doCallHelp(packet) {
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var functionId = packet.data.findValueByName("functionId");
	var functionName = packet.data.findValueByName("functionName");
	
	if (retCode != "000000") {
		rdShowMessageDialog("sql执行错误:"+retCode+","+retMsg+".", 0);
	} else {
		var targetUrl = "http://10.110.0.100:52000/npage/login/Accept.jsp?workNo=<%=workNo%>&pass=<%=password%>&kfLoginNo=<%=kfLoginNo%>&dPage=/npage/funcBusiMgr/funcApplication.jsp&functionId=" + functionId + "&functionName=" + functionName;	//生产
		//var targetUrl = "http://10.110.0.206:26001/npage/login/Accept.jsp?workNo=<%=workNo%>&pass=<%=password%>&kfLoginNo=<%=kfLoginNo%>&dPage=/npage/funcBusiMgr/funcApplication.jsp&functionId=" + functionId + "&functionName=" + functionName;	//测试
		L("h", "h"+functionId, "业务库在线帮助 "+functionId+functionName, targetUrl, "000");
		//window.open("../help/h"+functionId+".html");
	}
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
	//commented by tangsong 20110527 iPhoneNo不在这里赋值，而在openCustMain函数赋值
	//iPhoneNo = "";
	//iPhoneNo = document.getElementById(g_activateTab.substring(6,g_activateTab.length)).phone_no;
   }
}


function destroyOnhook(){
		var sendop_code = {};
		sendop_code["phone_no"] = "";
		$.ajax({
		   url: 'destroyOnhook.jsp',
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
		//(8)客服 songjia add 2010/08/19 begin 密码验证清session,质检状态验证。
		/**hejwa 开始
		这段代码点击关闭时清除手机号么session内容的 不要屏蔽或修改。改前请通知hejwa （上线前）*/
		if(id!="index")
		{
			var sendphone_no = {};
		 	sendphone_no["phone_no"]= id ;
		  $.ajax({
		  		url: 'destroy.jsp',
			    type: 'POST',
			    data: sendphone_no,
			    async: true//async
			});
			sendphone_no = null;
		}
		/**hejwa 结束 */
		/*add yinzx begin*/
		if(id!="index")
		{
			if(id!=''&& id!=undefined&&id.length>=4){
			var tempId=id.substring(0,4);

	       //计划外
	       if(tempId=='K217'||tempId=='K218'||tempId=='K219'){
				var currentTab = document.getElementById(id);
				var frameObj   = currentTab.document.frames['iframe'+id];
				var isSaved    = frameObj.window.document.getElementById("isSaved").value;
	        }
	        if(tempId=='K214'){
	          var currentTab = document.getElementById(id);
	          var frameObj   = currentTab.document.frames['iframe'+id];
	          var isSaved    = frameObj.window.document.getElementById("isSaved").value;
	        }
			if(tempId=='K217'||tempId=='K218'||tempId=='K219'){
				if(isSaved=='false'){
					var isSaved    = frameObj.window.document.getElementById("isSaved").value;
					frameObj.saveQcInfo('0');
					rdShowMessageDialog("考评结果已被临时保存！",2);	//guozw05
		        }
	        }
			if(tempId=='K214'){
				if(isSaved=='false'){
					if(rdShowConfirmDialog("你是否要保存当前质检结果？",3)=='1'){
	           		frameObj.window.document.getElementById("isClosed").value='true';
	             	frameObj.window.saveQcInfo("1");
					}
				}
			}
		}
	}
	//(8)客服 songjia end 2010/08/19
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
 	//(2)客服 songjia add 2010/08/19 begin 注释掉。测试方便。完成后需要改回

 		window.onunload=function(){
 			
 			if(isExit!=1){
 			try
	{
				
			     signOutFromIE();
			 
	}
	catch(e)
	{
	}
	//tancf 整合20100630完成
	canLoopAlertPopupWin = false;
	if (popupWin != null && !popupWin.closed){popupWin.close();}
	//(12)客服 songjia add 2010/08/19 级联关闭弹出窗口 end

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
	  isExit = "1";
    var prop="dialogHeight:150px; dialogWidth:320px; status:no;unadorned:yes";
    window.showModalDialog("logout.jsp","",prop);
    window.opener=null;
    window.open('','_self');
    window.close();
}
 	}
 	//(2)客服 songjia add 2010/08/19 begin
 		window.onload=function(){
 			
 		
 			if('<%=state%>'==1){
 				try
			{
			  iniOnclick();
			  SignInEx();
			}catch(e)
			{} 
	  }else{
	  	//初始化所有图片的点击事件
	  		iniOnclick();
	  		//将所有图标智亮
		    btn_able();
		    //将接续条按钮按照签出方式置暗
		    btn_Gray(arr_K006);
		    //将提示灯置暗
		    changeLight(0);
	  	}
	  	initcallreason();

		//added by tangsong 20110604 质检员计划执行情况提醒
		<%@ include file="/npage/callbosspage/public/constants.jsp" %>
		<%
			String powerCodekf = (String)session.getAttribute("powerCodekf");
			String[] powerCodeArr = powerCodekf.split(",");
			boolean is_zhijianyuan = false; //是否质检员，质检员只能查询自己的计划执行情况
			for (int i = 0; i < powerCodeArr.length; i++) {
				for (int j = 0; j < ZHIJIANYUAN_ID.length; j++) {
					if (ZHIJIANYUAN_ID[j].equals(powerCodeArr[i])) {
						is_zhijianyuan = true;
						break;
					}
				}
			}
			if (is_zhijianyuan) {
		%>
				reportQcplanOprResult();
		<%
			}
		%>
}

	function reportQcplanOprResult() {
		var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K216/K216_report.jsp","...");
		core.ajax.sendPacket(chkPacket,doProcessReport,true);
		chkPacket =null;
	}

	function doProcessReport(packet) {
		var reportText = packet.data.findValueByName("reportText");
		if (reportText == "") {
			return;
		}
		var reg = /@#/g;
		reportText = reportText.replace(reg,"\n");
		if (confirm(reportText) == true) {
			var reportURL = "<%=request.getContextPath()%>/npage/callbosspage/checkWork/K216/K216_Main.jsp";
			addTab(true,"K216",'质检员计划执行情况',reportURL);
		}
	}

 	window.onresize = function(){
 		try{
		initPanel($("#layoutStatus").val());
		//(6)客服 songjia add 2010/08/19 begin
		var more_btn2iframe =document.getElementById("more_btn2iframe");
		var btnMore=document.getElementById("more_btn");
		more_btn2iframe.style.width = btnMore.clientWidth;
		more_btn2iframe.style.height  = btnMore.clientHeight;
		}catch(e)
		{
			alert(e);
		}
		//客服 songjia add 2010/08/19 begin
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
	//tancf 20110420
		<%if("1".equals(shomeflag)){%>
				var workNum=cCcommonTool.getWorkNo();
				var currentState=0;
				if(parPhone.QueryAgentStatusEx(workNum)==0){
					currentState=parPhone.AgentInfoEx_CurState;
				}
          if(currentState!=5&&currentState!=4)
            {
                rdShowMessageDialog("只能在接续状态下打开");               
                return false;
            }
		<%}%>
		//判断工号界面：用户信息页和opcode限制 
	 	<%if("1".equals(limitLoginFlag)){%>
	 		var limitCodeRows = "<%=limitCodeRows%>";
	 		var limitCodeArr = limitCodeRows.split(",");
	 		for(i=0;i<limitCodeArr.length;i++){
	 			 if(opcode==limitCodeArr[i])
	 			 {	
	 			 			var currentState ;
	 			 		 	var workNum=cCcommonTool.getWorkNo();
							if(parPhone.QueryAgentStatusEx(workNum)==0){
								currentState=parPhone.AgentInfoEx_CurState;
							}
          		if(currentState!=5&&currentState!=4)
           	  {
                rdShowMessageDialog("非通话状态无法查询\受理");               
                return false;
              }
	 			 }
	 		}
	 		
	 	<%}%>
		
		if(openflag=="1")
		{

			/** modified by hejwa in 20110802 多OP改造--最多一级tab begin**/
			if($("#contentArea iframe").size() <= <%=tabOpenMax%>){
			}else{
				rdShowMessageDialog("只能打开<%=tabOpenMax%>个一级tab",1);
				return;
			}
			/** modified by hejwa in 20110802 多OP改造--收藏夹功能 end**/

				//(13)客服 songjia add 2010/08/19 报表公告便签跳转修改 begin
				/*targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title);
				addTab(true,opcode,title,targetUrl);*/
				if(targetUrl.indexOf("report/XlsRep") != -1){
						//上线要做修改。 songjia 20110902
						 targetUrl = changeUrl("http://10.110.0.121:16000/"+targetUrl,opcode,title);
						
						//targetUrl = changeUrl("<%=request.getContextPath()%>/"+targetUrl,opcode,title);
						addTab(true,opcode,title,targetUrl);
				}
				else if(targetUrl.indexOf("notices/npage/notices") != -1){
						//targetUrl = changeUrl("http://10.110.0.124:17400/"+targetUrl,opcode,title);
						targetUrl = changeUrl("<%=request.getContextPath()%>/"+targetUrl,opcode,title);
						//alert(targetUrl);
						addTab(true,opcode,title,targetUrl);
				}
				else{
						targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title);
						addTab(true,opcode,title,targetUrl);
				}
				//(13)客服 songjia add 2010/08/19 end
		}
		//second tab
		else if(openflag=="2")
		{

			if(g_activateTab.indexOf("custid")==-1){
				if(g_activateTab=="5556"){
					rdShowMessageDialog("请点击特服办理按钮!");
					$("#iCustName").select();
				    return;
				}else{
					rdShowMessageDialog("请输入手机号码后点击特服办理!");
				    $("#iCustName").select();
				    return;
				}
			}
		    if(iPhoneNo == "index"&&opcode!="1104"&&opcode!="q046"&&opcode!="4603"&&opcode!="4100"&&opcode!="7518"&&opcode!="4977"){
		        rdShowMessageDialog("请输入手机号码!");
				    $("#iCustName").select();
				    return;
		    }
		    if(iPhoneNo == "custMain"){
		        rdShowMessageDialog("请选择一个用户!");
				    return;
		    }
		    if(iPhoneNo=="5556"&&opcode!="1104"&&opcode!="q046"&&opcode!="4603"&&opcode!="4100"&&opcode!="7518"&&opcode!="4977"){
		        rdShowMessageDialog("请输入手机号码!");
				    return;
		    }

			//var patrn=/^((\(\d{3}\))|(\d{3}\-))?[12][03458]\d{9}$/;
			//if(g_activateTab.search(patrn)!=-1){

			//(11)客服 songjia add 2010/08/19 密码验证修改
			/*
		  		if(typeof(valideVal)!="undefined"&&(valideVal.indexOf("1")!=-1)){ //需要验证
                chkIsValidate(valideVal,iPhoneNo,opcode);
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
          }*/
             /**客服密码验证 hejwa*/
			var temp =changeUrl("/npage/"+targetUrl,opcode,title);
			temp = temp+"&activePhone="+iPhoneNo;
			document.getElementById("targetUrl_ps").value=temp;
			document.getElementById("title_ps").value=title;
			document.getElementById("opcode_ps").value=opcode;
			document.getElementById("activephone_ps").value=g_activateTab;

		  	openTabFlag = "1";
		  	ajaxGetSession(g_activateTab);
				if(phone_kf_check==g_activateTab&&phone_kf_flag=="1"){
				//if(true){
				}else{

		   if(g_activateTab == "index"&&opcode!="1104"&&opcode!="q046"&&opcode!="4603"&&opcode!="4100"&&opcode!="7518"&&opcode!="4977"){
		        rdShowMessageDialog("请输入手机号码!");
				    $("#iCustName").select();
				    return;
		    }

		    if(g_activateTab == "5556"&&opcode!="1104"&&opcode!="q046"&&opcode!="4603"&&opcode!="4100"&&opcode!="7518"&&opcode!="4977"){
		        rdShowMessageDialog("请输入手机号码!");
				    $("#iCustName").select();
				    return;
		    }


 					ajaxOpcodeLimit(opcode); 
 					if(kfFlagOc!="1"){

 						var acceptPNo = document.getElementById("acceptPhoneNo").value;

                 var path = "<%=request.getContextPath()%>/npage/public/publicValidate_kf.jsp";
                 path =  path + "?valideVal="   + valideVal;
                 path =  path + "&titleName="   + title;
                 path =  path + "&activePhone=" + iPhoneNo;
                 path =  path + "&opCode=" + opcode;
                 path =  path + "&acceptPNo=" + acceptPNo;

                 var h = 250;
                 var w = 450;
                 var t=screen.availHeight/2-h/2;
                 var l=screen.availWidth/2-w/2;
                 //var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
                 var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; ";
                 var validateResult = window.showModalDialog(path,window,prop);
                 if((validateResult=="undefined")||(validateResult!="1")){  // 校验失败
                 		ajaxSetSession(document.all.telNo_oth.value,"0");
                    return;
                  }else if((validateResult=="undefined")||(validateResult=="kf_ivr")){
                  	//转入ivr流程
                  }else{
                  	similarMSNPop("密码校验正确");
                  	ajaxSetSession(document.all.telNo_oth.value,"1");
                  }
          	}
         }
         //(11)客服 songjia add 2010/08/19 密码验证修改 end

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
	  	/** modified by hejwa in 20110802 多OP改造--最多一级tab begin**/
			if($("#contentArea iframe").size() <= <%=tabOpenMax%>){
			}else{
				rdShowMessageDialog("只能打开<%=tabOpenMax%>个一级tab",1);
				return;
			}
			/** modified by hejwa in 20110802 多OP改造--收藏夹功能 end**/
			
	   
	  	targetUrl = changeUrl(targetUrl,opcode,title);
	  	addTab(true,opcode,title,targetUrl);
	  }
	  else if(openflag=="h") {	//2011/8/9 wanghfa添加 在线帮助展示判断
  		var win= window.open(targetUrl,"","width=800,height=400,top="+(screen.availHeight/2-400/2)+",left="+(screen.availWidth/2-800/2)+",scrollbars=yes,resizable=yes,status=yes");
      addWinName(win,opcode);
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
			loadFirstMenu();//加载一级菜单
			HoverMenu('oli','li');//初始化菜单,绑定一级菜单事件,调用getTree
			//(19)客服 songjia add 2010/08/19 begin 用户信息默认显示
			//HoverNav('fav');
			HoverNav("userinfo");
			//(19)客服 songjia add 2010/08/19 end
			<%if(hotkey.equals("Y"))
			{%>
			getHotKey();					//获取快捷键菜单
			<%}%>
			initSearch();					//初始化快速入口数据
			
			/** modified by hejwa in 20110718 多OP改造--页面设置 begin**/
			layoutSwitch(parseInt("<%=layout%>")+1);			//初始化页面各部分的大小;参数1,2,3,4
			setNav('N');
			$("#wait").hide();
			/** modified by hejwa in 20110718 多OP改造--页面设置 end**/
			
			/*
			$(".more_set").hover(function(){$(this).find(".more_panel").show()},function(){$(this).find(".more_panel").hide()})
		  	$(".menu_set").hover(function(){$(this).find(".more_panel").show()},function(){$(this).find(".more_panel").hide()})
		  	*/
		  	$(".more_set").hover(function(){$(this).find(".more_panel").show();$("#moresetIf").height($(this).find(".more_panel").height());},
				function(){$(this).find(".more_panel").hide()})
			$(".menu_set").hover(function(){$(this).find(".more_panel").show();$("#menusetIf").height($(this).find(".more_panel").height());},
				function(){$(this).find(".more_panel").hide()})
			Clearcookie();

			$.hotkeys.add('Alt+1', function(){
			    $("#iCustName").focus();
			});
			$.hotkeys.add('Alt+2', function(){
			    $("#tb").focus();
			});
			$.hotkeys.add('Alt+3', function(){
    			    $("#funcText").focus();
			});

    		$.hotkeys.add('Ctrl+n', function(){
    			rdShowMessageDialog("欢迎您使用黑龙江移动综合客户服务系统！");
    			});
    		$.hotkeys.add('Ctrl+r', function(){
    			rdShowMessageDialog("欢迎您使用黑龙江移动综合客户服务系统！");
    			});
    		$.hotkeys.add('f5', function(){
    				rdShowMessageDialog("欢迎您使用黑龙江移动综合客户服务系统！");
    				window.event.keyCode = 0;
    				return;
    			});
    		$.hotkeys.add('f11', function(){
    			rdShowMessageDialog("欢迎您使用黑龙江移动综合客户服务系统！");
    			window.event.keyCode = 0;
    			return;
    		});

    		$.hotkeys.add('Ctrl+0', function(){doCtrl('Ctrl+0');});
    		$.hotkeys.add('Ctrl+1', function(){doCtrl('Ctrl+1');});
    		$.hotkeys.add('Ctrl+2', function(){doCtrl('Ctrl+2');});
    		$.hotkeys.add('Ctrl+3', function(){doCtrl('Ctrl+3');});
    		$.hotkeys.add('Ctrl+4', function(){doCtrl('Ctrl+4');});
    		$.hotkeys.add('Ctrl+5', function(){doCtrl('Ctrl+5');});
    		$.hotkeys.add('Ctrl+6', function(){doCtrl('Ctrl+6');});
    		$.hotkeys.add('Ctrl+7', function(){doCtrl('Ctrl+7');});
    		$.hotkeys.add('Ctrl+8', function(){doCtrl('Ctrl+8');});
    		$.hotkeys.add('Ctrl+9', function(){doCtrl('Ctrl+9');});
    		$.hotkeys.add('Alt+F4', function(){closeWindow();});
    		//(7)客服 初始化签入 ,初始化来电原因 暂时注释掉签入，songjia add 2010/08/19 begin
			 	 $("b").hide();
	     	 var packet = new AJAXPacket("../login/getPanlePdom.jsp","请稍后...");
	  		 core.ajax.sendPacket(packet,doProcessPanPdom);//异步
			 	 packet =null;

    		//(7)客服 songjia add 2010/08/19 end

		    window.setInterval(function() {
		    	//showMessageDialog();
		    	if(canLoopAlertPopupWin){
		    	  //以前的代码
		    	  //queryMaxIdAjax();
		    	  //add by chenhr.20101103.为了实现公告如果选择弹出时，应该弹出的问题。
		    	 	//queryMaxPopPubilicNotice();
		    	}
		    }, 60000);

      	 /* window.setInterval(function() {//add by chenhr.20101115.为了实现公告2分钟之内弹出。
				    if(canLoopAlertPopupWin){
				     queryMaxPopPubilicNotice();
				    }
          }, 120000);*/
setTimeout("timefunc()",20000);
		});
		function doProcessPanPdom(packet)
	{
		 var panlebutton = packet.data.findValueByName("nodes");


		  var xin=0;
	    $("b").each(function(i){

		 		       if (this.id==panlebutton[this.id])
		 		 		   {

		 		 		   	  $(eval("\"#"+panlebutton[this.id]+"\"")).show();
		 		 		   	  xin=xin+1;
	             }

					 //modify by hucw,20100615
					 if(xin > 12)
					 {

					 			$(eval("\"#"+panlebutton[this.id]+"\"")).clone().appendTo( $("#more_btn"));
					 			$(eval("\"#"+panlebutton[this.id]+"\"")).remove();
					 }

 				});

 				if (xin <= 12)
 				{
 					  $("#moreCall").remove();
 				}

 			$(eval("\"#K101\"")).clone().appendTo( $("#more_btn"));
			$(eval("\"#K101\"")).remove();
			//(22)接续条显示，新增，songjia add 2010/08/19 begin
				 $("#bn_status_first_1").show();
		     $("#bn_status_second_1").show();
		     $("#bn_status_third_1").show();
		     //$("#K073").show();
		     $("#K101").show();
		    $("#callSearch").show();
		    //(22)接续条显示，新增，songjia end 2010/08/19 begin
	}

<%
//added by tangsong 20101124 取得当前服务器的工程路径
String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath();
%>
	//(7)客服 来电原因初始化函数 songjia add 2010/08/19 begin
	function initcallreason()
	{
		var ret1 = xmlHelper.loadXml('<%=basePath%>/file/callcenter/callreson.xml');
		if(ret1==false)
			alert(xmlHelper.getLoadXmlErrDesc());

		var ret2 = xmlSeach.loadXml('<%=basePath%>/file/callcenter/callresonseach.xml');
		if(ret2==false)
			alert(xmlSeach.getLoadXmlErrDesc());
		return (ret1 && ret2);
	}
	//(7)客服 songjia add 2010/08/19 end
	
	//add by licl at 20120706 后台刷新来电原因 begin	
	
	var xmlDocTemp,xmlDocSeachTemp;
	var xmlHelperUp,xmlSeachUp;
	var oldxmlHelper,oldxmlSeach;
	var oldXmlMark = true;
	function updatecallreason(){		
		//alert("updatecallreason");
		xmlHelperUp = null;//据说能让对象回收
		xmlDocTemp = null;
		xmlHelperUp = new XmlHelper();		
		xmlDocTemp = xmlHelperUp.loadXmlByAsync(checkState,"<%=basePath%>/file/callcenter/callreson.xml");
	}
	
	function checkState(){		
		if (xmlDocTemp){
			var state = xmlDocTemp.readyState;
			if (state == 4){
				var err = xmlDocTemp.parseError;
				if (err.errorCode == 0){
					//加载成功					
					xmlSeachUp = null;
					xmlDocSeachTemp = null;
					xmlSeachUp = new XmlHelper();
					xmlDocSeachTemp = xmlSeachUp.loadXmlByAsync(checkStateSeach,'<%=basePath%>/file/callcenter/callresonseach.xml');
				}
				else
				{					
					//加载失败					
				}
			} 
		}
	}
	
	function checkStateSeach(){
		if (xmlDocSeachTemp){
			var state = xmlDocSeachTemp.readyState;
			if (state == 4){
				var err = xmlDocSeachTemp.parseError;
				if (err.errorCode == 0){
					//加载成功
					setXmlHelper(xmlHelperUp,xmlSeachUp);
					cleanCallCauseNodeStatus();
					//alert("更新成功");
				}
				else
				{					
					//加载失败					
				}
			} 
		}
	}
	
	function setXmlHelper(axml,sxml)
	{		
		if (oldXmlMark){
			oldxmlHelper = xmlHelper;
			oldxmlSeach = xmlSeach;
			oldXmlMark = false;
		}
		xmlHelper = axml;
		xmlSeach = sxml;
	}
	function rollbackXmlHelper(){
		if (!oldXmlMark){
			xmlHelper = oldxmlHelper;
			xmlSeach = oldxmlSeach;
		}
	}
	//add by licl at 20120706 后台刷新来电原因 end

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
		var imgLeftRight=document.getElementById("imgLeftRight");
		var navPanel=document.getElementById("navPanel");
		if(navPanel.currentStyle.display=="none"){
			imgLeftRight.src="<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/to-left_2.gif";
			layoutSwitch(2);
		}else{
			imgLeftRight.src="<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/to-left_1.gif";
			layoutSwitch(4);
		}

	}
	
	
		/** modified by hejwa in 20110714 多OP改造--新增业务向导 begin**/
	
	//var has_busiGuide = false;//是否存在业务向导,
	
	
	//查询向导。第一步进行查询
	function getBusiguide(opcode){	
		busiGuide_opcode = opcode;
		var packet = new AJAXPacket("getBusiguide.jsp");
		packet.data.add("opCode",opcode);
		core.ajax.sendPacketHtml(packet,doGetBusiguide);
		packet =null;
	}
	
	function doGetBusiguide(data)
	{
		$('#tbc_04').append(data);
		if($('#tbc_04').children('#busiguide_'+busiGuide_opcode)[0]){
			$('#tbc_04').children('#busiguide_'+busiGuide_opcode).css("display","");
			$('#tbc_04').children('#busiguide_'+busiGuide_opcode).siblings("div").css("display","none");
			$('#busiguide_4').css("display","");
			$('#tbc_04').css("display","");
			$("#tbc_04").height("79%");
			HoverNav('buGu');	
		}
	}
	
	//当业务退出时隐藏左侧业务向导
	function hideBusiguide(opcode){
		//alert("hideBusiguide->opcode|"+opcode);
		if($('#tbc_04').children('#busiguide_'+opcode)[0]){
			//alert("size|"+$('#tbc_04>div').size());
				if($('#tbc_04>div').size()>1){//若有多个向导，只删除关闭的向导内容
					$('#tbc_04').children('#busiguide_'+opcode).remove();
				}else{//若只有一个则关闭业务操作向导菜单
					$('#tbc_04').empty();
					$('#tbc_04').css("display","none");
					$('#busiguide_4').css("display","none");
				}		
				 
			}
	}
	function hideBusiguideHead(val){
		if(val==1){
			$('#tbc_04').css("display","none");
		}else{
			$('#tbc_04').css("display","");
		}
	}
	/*******************************************************
	 *复杂多步业务可增加业务操作向导功能，按照步骤去改造业务
	 *如：家庭业务parent.showBusiGuideStep("6385",1)代表第一步，
	 *在相应的节目加入上面这段代码。
	 *******************************************************/
	function showBusiGuideStep(opcode,step){
		HoverNav('buGu');	
		if(step==1||step=="1"){//第一步查询所有步骤
				//调用 getBusiguide.jsp，若有值 has_busiGuide =true  
				if($('#busiguide_'+busiGuide_opcode).size()==0)
			 		getBusiguide(opcode);
		}
		
		//根据步骤进行导航
		$("#step_"+opcode).children("div").each(
	      function(i){
          if((i+1)==Number(step)){//选中步骤变为正在进行状态
         	 	 $(this).removeClass();
         	 	 if($(this).children("img").size()>=2){
         	 	 		$(this).children("img:last").remove();
         	 	 }
         		 $(this).addClass('running');
         		 $(this).children("img:first").attr("src","<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/icon_nav.gif");
          }  

         	if((i+1)>Number(step)){//选中步骤后的变为未完成状态
             //下一个全部变为fresh--未进行时
						 $(this).children("img:first").attr("src","<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/arrow_link_blue.gif");
	           $(this).removeClass();
	           $(this).addClass('fresh');
	           if($(this).children("img").size()>=2){
	           			$(this).children("img:last").remove();
	           }
					}
					
					if((i+1)<Number(step)){//选中之前的步骤变为完成状态
						 //之前的都变成--finish
						 $(this).removeClass();
	           $(this).addClass('finish');
	           $(this).children("img:first").attr("src","<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/arrow_link_blue.gif");

						 if($(this).children("img").size()<2){
						 	  $(this).append("<img src=\"<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/icon_ok.gif\" style=\" margin-left:10px\" width=\"15\" height=\"15\"/>");
	         	 }
     		  }
       }
    );
  	//监听TAB页是否关闭，若关闭则调用hideBusiguide隐藏左侧业务向导
  	$("#tabtag").children("#"+opcode).children("span").children("img").bind('click', function() {
 			 hideBusiguide(opcode);
		});
		
		//TAB页切换时，只显示当前tab向导
  	$("#tabtag").children("#"+opcode).bind('click', function() {
 			 $('#tbc_04').children('#busiguide_'+opcode).css("display","");
			 $('#tbc_04').children('#busiguide_'+opcode).siblings("div").css("display","none");
			 $('#busiguide_4').css("display","");
			 $('#tbc_04').css("display","");
			 $("#tbc_04").height("79%");
			 HoverNav('buGu');	
		});
	}

	/** modified by hejwa in 20110714 多OP改造--新增业务向导 end**/
	/** modified by hejwa in 20110916 多OP改造--待办任务弹窗 begin**/
var Message={
set: function() {//最小化与恢复状态切换
var set=this.minbtn.status == 1?[0,1,'block',this.char[0],'最小化']:[1,0,'none',this.char[1],'展开'];
this.minbtn.status=set[0];
this.win.style.borderBottomWidth=set[1];
this.content.style.display =set[2];
this.minbtn.innerHTML =set[3]
this.minbtn.title = set[4];
this.win.style.top = this.getY().top;
},
close: function() {//关闭
this.win.style.display = 'none';
window.onscroll = null;
},
setOpacity: function(x) {//设置透明度
var v = x >= 100 ? '': 'Alpha(opacity=' + x + ')';
this.win.style.visibility = x<=0?'hidden':'visible';//IE有绝对或相对定位内容不随父透明度变化的bug
this.win.style.filter = v;
this.win.style.opacity = x / 100;
},//欢迎来到站长特效网，我们的网址是www.zzjs.net，很好记，zz站长，js就是js特效，本站收集大量高质量js代码，还有许多广告代码下载。
show: function() {//渐显
clearInterval(this.timer2);
var me = this,fx = this.fx(0, 100, 0.1),t = 0;
this.timer2 = setInterval(function() {
t = fx();
me.setOpacity(t[0]);
if (t[1] == 0) {clearInterval(me.timer2) }
},10);
},//欢迎来到站长特效网，我们的网址是www.zzjs.net，很好记，zz站长，js就是js特效，本站收集大量高质量js代码，还有许多广告代码下载。
fx: function(a, b, c) {//缓冲计算
var cMath = Math[(a - b) > 0 ? "floor": "ceil"],c = c || 0.1;
return function() {return [a += cMath((b - a) * c), a - b]}
},
getY: function() {//计算移动坐标
var d = document,b = document.body, e = document.documentElement;
var s = Math.max(b.scrollTop, e.scrollTop);
var h = /BackCompat/i.test(document.compatMode)?b.clientHeight:e.clientHeight;
var h2 = this.win.offsetHeight;
return {foot: s + h + h2 + 2+'px',top: s + h - h2 - 2+'px'}
},
moveTo: function(y) {//移动动画
clearInterval(this.timer);
var me = this,a = parseInt(this.win.style.top)||0;
var fx = this.fx(a, parseInt(y));
var t = 0 ;
this.timer = setInterval(function() {
t = fx();
me.win.style.top = t[0]+'px';
if (t[1] == 0) {
clearInterval(me.timer);
me.bind();
}//欢迎来到站长特效网，我们的网址是www.zzjs.net，很好记，zz站长，js就是js特效，本站收集大量高质量js代码，还有许多广告代码下载。
},10);
},
bind:function (){//绑定窗口滚动条与大小变化事件
var me=this,st,rt;
window.onscroll = function() {
clearTimeout(st);
clearTimeout(me.timer2);
me.setOpacity(0);
st = setTimeout(function() {
me.win.style.top = me.getY().top;
me.show();
},600);
};
window.onresize = function (){
clearTimeout(rt);
rt = setTimeout(function() {me.win.style.top = me.getY().top},100);
}
},
init: function() {//创建HTML
function $(id) {return document.getElementById(id)};
this.win=$('msg_win');
var set={minbtn: 'msg_min',closebtn: 'msg_close',title: 'msg_title',content: 'msg_content'};
for (var Id in set) {this[Id] = $(set[Id])};
var me = this;
 
this.closebtn.onclick = function() {me.close()};
this.char=navigator.userAgent.toLowerCase().indexOf('firefox')+1?['_','::','×']:['0','2','r'];//FF不支持webdings字体
this.closebtn.innerHTML=this.char[2];
setTimeout(function() {//初始化最先位置
me.win.style.display = 'block';
me.win.style.top = me.getY().foot;
me.moveTo(me.getY().top);
},0);
return this;
}
};

function timefunc(){
	if(<%=taskFlag%>>0){
		$("#msg_win").show();
		Message.init();
	}else{
		$("#msg_win").hide();
	}
}

/** modified by hejwa in 20110916 多OP改造--待办任务弹窗 end**/
</script>
</body>
</html>
