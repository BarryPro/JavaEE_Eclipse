<%
   /*
   * ����: ϵͳ�����
�� * �汾: v1.0
�� * ����: 2009-11-05
�� * ����: wuln/hujie 
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����:2010-04-27      	�޸���:liubo      �޸�Ŀ��:���������
   * �޸�����:2010-08-19		�޸���:songjia    �޸�Ŀ��:�������ͷ�ϵͳ�������
   * �޸�����:2011-08-03		�޸���:hejwa      �޸�Ŀ��:��������op
   * �޸�����:2012-12-25		�޸���:hejwa      �޸�Ŀ��:������ng3.5��Ŀҳ���׼������淶
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page errorPage="../common/errorpage.jsp" %>

<!--(1)�ͷ� songjia add 2010/08/19 begin -->
<%@ page import="java.net.InetAddress"%>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<!-- (1)�ͷ� songjia add 2010/08/19 end -->

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	////��ֱֹ������URL����ģ��ҳ��
	String refererProxy=request.getHeader("referer");
	String password = (String)session.getAttribute("password");
	String kfLoginNo = (String)session.getAttribute("kf_login_no");
	if(null==refererProxy||"".equals(refererProxy))
	{
	%>

			<script language="javascript">
				if(typeof(opener) == "undefined")
				{
				  alert("��ֹ�Ƿ�����ҳ��!");
				  window.opener=null;
				  window.open("","_self");
              	  window.close();
        }
		</script>
	<%
	}
%>
<%
//ǩ��״̬�ֶ�ֵ
String state=request.getParameter("state");

//ȡsessionֵ
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
//(21)�ͷ� songjia add 2010/08/20 begin ��ȡsessionֵ
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



//(21)�ͷ� songjia add 2010/08/20 end

//add by hucw,20110214,�������ԭ��汾��,���뵽session��
session.setAttribute("local.callcause.version",(Integer)application.getAttribute("callcause.tree.version"));
%>


<%-- /**  modified by hejwa in 20110714 ��OP����--����tabҳ  begin **/ --%>
<%
String tabSql = "select to_char(open_max) from dwkspace where login_no=:workNo";
String tabParam = "workNo="+workNo;
//��¼���һ�ι��������ã����¼��OP��¼��־��
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
		  <wtc:param value="��OP��¼��־"/>
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
		String tabOpenMax = "10";//�����TABҳ������,Ĭ����10
		
		
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
<%-- /**  modified by hejwa in 20110714 ��OP����--����tabҳ  end **/ --%>

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
<%-- /**  modified by hejwa in 20110714 ��OP����--����tabҳ  end **/ --%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<title>�й��ƶ��ͻ���ϵ����ϵͳ</title>
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/framework_kf.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/rightmenu.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/rightKey.css" rel="stylesheet" type="text/css" />
	<!--(21)�ͷ� songjia begin-->
		<link href="<%=request.getContextPath()%>/nresources/default/css/addnew_kf.css" rel="stylesheet" type="text/css" />
	<!--(21)�ͷ� songjia end-->
	<%-- /**  modified by hejwa in 20110714 ��OP����--ҵ����  begin **/ --%>
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/busiguide.css" rel="stylesheet"type="text/css">
	<%-- /**  modified by hejwa in 20110714 ��OP����--ҵ����  end **/ --%>
	<!--hejwa ���� ng3.5��ʽ-->
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
		�ͷ���ʱ�뿪���ֲ� (26) add by songjia 20100823
	-->
	<div id="kf_loading" style='display:none'>
		<div id='Waiting' style='z-index:102333;left:40%;top:40%;width:20%; height:10%;'>
			<img src='<%=request.getContextPath()%>/nresources/default/images/wait_loading.gif'><br>����������<input type='password' name="checkPW" value="" size="8" maxlength=6><input class="b_text" type="button"  name="subit" value="ȷ��" onclick="checkPassWord();"><img src='<%=request.getContextPath()%>/nresources/default/images/wait_loading_1.gif'>
		</div>

	</div>

	<!--topPanel begin-->
	<%@ include file="../module/topPanel_kf.jsp"%>
	<!-- �洢ajax���÷��ص�html -->
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
	<!--��ֹҳ�����-->
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
<div class="icos"><a id="msg_close" title="�ر�" href="javascript:void 0">��</a></div>
<div id="msg_title">����������ʾ����</div>
<div id="msg_content">��������<%=taskFlag%>������������鿴��������</div>
</div>
<!--�ͷ�������֤����songjia(25)-->

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

<!--����ԭ�������һ�ε��ʱ��idֵ-->
	<input type="hidden" id="lastCallCauseId" value="">
	<input type="hidden" id="lastCallCauseHeight" value="">
<!--->
<!--(3)�ͷ� songjia add 2010/08/19 begin �޸�Ϊ�ͷ�ʹ�õ�jquery�汾ʱ������ʹ������汾-->
<script src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js" type="text/javascript"></script>
<!--(3)�ͷ� songjia add 2010/08/19 end -->
<script src="<%=request.getContextPath()%>/njs/system/system.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/plugins/autocomplete.js"  type="text/javascript"></script>
<!-- �ͷ� tangsong update 2010/08/25 begin ���ڿͷ���Ӫҵ����callpanel���ʹ�������iframe�߶�Ҫ���¼���-->
<script src="<%=request.getContextPath()%>/njs/plugins/tabScript_jsa.js" type="text/javascript"></script>
<!--
<script src="<%=request.getContextPath()%>/njs/plugins/tabScript_jsa_kf.js" type="text/javascript"></script>
�ͷ� tangsong update 2010/08/25 end -->
<script src="<%=request.getContextPath()%>/njs/plugins/MzTreeView12.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/redialog/redialog.js" type="text/javascript"></script>

<!--(4)�ͷ� songjia add 2010/08/19 begin ����ͷ�xml���ذ����ࡢ����ť������ϵ����-->
<script src="/njs/csp/xmlHelper.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/csp/mutualArray.js" type="text/javascript"></script>


<!--(4)�ͷ� songjia add 2010/08/19 end -->

<script language="javascript" type="text/javascript">
/*(5)�ͷ� ȫ�ֱ������ô� songjia add 2010/08/19 begin*/
var vlflag;
var xmlHelper = new XmlHelper();
var xmlSeach = new XmlHelper();
var openTabFlag = "1";
/*(5)�ͷ� songjia add 2010/08/19 end*/

var iCustId = "";
var iPhoneNo = "index";

/*(6)�ͷ� �˳�ǰ��֤ songjia add 2010/08/19 begin*/
window.onbeforeunload=function(){
	
	
	
}
/*(6)�ͷ� songjia add 2010/08/19 */


//��ѯһ���˵�
function loadFirstMenu(){
	//update by songjia ,�ύҳ���޸�Ϊajax_queryFirstMenuKf.jsp;
	var packet =  new AJAXPacket("ajax_queryFirstMenuKf.jsp");
	core.ajax.sendPacketHtml(packet,doLoadFirstMenu);
	packet = null;

}

function doLoadFirstMenu(data){
	$("#ajaxResult").html(data);//���ط��ص�Html

	var retCode = $("#divRetCode").html();
	var retMsg = $("#divRetMsg").html();

	if(retCode=="0"){

		$("#oli").html($("#divShowFirstMenu").html());//data�а���divShowFirstMenu
		$("#otherFirstMenu").html($("#divOtherFirstMenu").html());//data�а���divOtherFirstMenu

	}else{
		showDialog(retMsg,0);
	}
}

/**************����ԭ��framework.js�Ĵ���*********/
// ���岼��
function layoutSwitch(n){

	$("#layoutStatus").val(n);

	$("#a1").attr("class","aSpace");
	$("#a2").attr("class","bSpace");
	$("#a3").attr("class","cSpace");
	$("#a4").attr("class","dSpace");

	if (n==1){//���������
		$("#navPanel").hide();
		$("#topPanel").hide();
		$("#workPanel").css("margin-left","4px");
		$("#a1").attr("class","aSpaceOn");
	}
	if(n==2){//�ָ�������ͼ
		$("#topPanel").show();
		$("#navPanel").show();
		$("#workPanel").css("margin-left","201px");
		$("#a2").attr("class","bSpaceOn");
	}
	if(n==3){//����topPanel���
		$("#topPanel").hide();
		$("#navPanel").show();
		$("#workPanel").css("margin-left","201px");
		$("#a3").attr("class","cSpaceOn");
	}
	if(n==4){//����navPanel���
		$("#topPanel").show();
		$("#navPanel").hide();
		$("#workPanel").css("margin-left","4px");
		$("#a4").attr("class","dSpaceOn");
	}

	initPanel(n);
}

function initPanel(n){
	//updated by tangsong 20100825 �޸���ʹ�������ĺ����������ȫչʾ��������ײ�
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

//����һ��TAB��iframe�߶ȡ����
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
		//updated by tangsong 20100825 �޸�"�ҵ���Ϣ"ҳ��ĸ߶ȣ�ʹ�������������ȫչʾ
		iframe[i].style.height=(workPanelHeight-tabHeight)+"px";
		//iframe[i].style.height=(workPanelHeight-tabHeight-60)+"px";
		iframe[i].style.width=(workPanelWidth)+"px";
	}
}

//���õ����������ݵĸ߶�,flag:tree��ģ������
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

//һ����Ŀ�л�
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
var isExit = "0"; //Ĭ��Ϊֱ�ӹر�
 /*
   ��ӱ�������ϵͳ�˳�ʱ�رյ�������
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
//(12)�ͷ� songjia add 2010/08/19 �����رյ������ڱ��� begin
//tancf ����201003098
	var popupWin;
	var canLoopAlertPopupWin = true;
//(12)�ͷ� songjia add 2010/08/19 �����رյ������ڱ��� end
//�������˳�ϵͳ
function closeWindow(){
	//add wanghong Ϊ���ڽ���ʱ����˳�ʱ�������˳�
	if(window.top.current_CurState ==5||window.top.current_CurState ==4){
		      rdShowMessageDialog("ͨ��״̬�޷��˳�����!"); 
		      return false;
	}
	//(12)�ͷ� songjia add 2010/08/19 �����رյ������� begin
	//tancf ����20100630
	
	
	if(rdShowConfirmDialog("ȷ��Ҫ�ر�ô?")==1)
		{
	try
	{
				
			     signOutFromIE();
			 
	}
	catch(e)
	{
	}
	//tancf ����20100630���
	canLoopAlertPopupWin = false;
	if (popupWin != null && !popupWin.closed){popupWin.close();}
	//(12)�ͷ� songjia add 2010/08/19 �����رյ������� end

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
	isExit = "1"; //���˳���ť
	var prop="dialogHeight:122px; dialogWidth:402px; status:no;unadorned:yes";
	window.showModalDialog("logout2.jsp","",prop);
	window.opener=null;
	window.open('','_self');
	window.close();
}
*/

/************************************ searchPanel *********************************/
function chgLoginType()//�����û���½����������
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
			$("#phoneNo").val("��������Ϣ���в�ѯ(Alt+1)");
			//�������֤����ͼ������
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

function clearPhoneNo()//����û���½����
{
	$("#phoneNo").val("");
}
function clearCustName()
{
	$("#iCustName").val("");
}

//�ж��Ƿ��Ѿ��򿪿ͻ���ҳ
function isTabExist()
{
	var tabSize = $("#contentArea iframe").size();
	for(var i=0;i<tabSize;i++)
	{
		if($("#contentArea iframe")[i].id.length>12)
		{
			if($("#contentArea iframe")[i].id.substring(0,12)=="iframecustid")
			{
				showDialog("������굱ǰ�ͻ������������ͻ�",1);
				return false;
			}
			if($("#contentArea iframe")[i].id.substring(0,15)=="iframecustLater")
			{
				showDialog("������굱ǰҵ�������������ͻ�",1);
				return false;
			}
		}
	}
	return true;
}

/*����
function addTabBySearch()
{
	if(!isTabExist()) return false;

	var phoneNo = $("#phoneNo").val();
	if(phoneNo=="��������Ϣ���в�ѯ(Alt+1)"||phoneNo=="")
	{
		showDialog("�������ѯ����",1);
		return false;
	}

	var loginType = $("#loginType").attr("loginType");
	if(loginType==="11")
	{
		openDivWin("getUserList.jsp?phoneNo="+phoneNo+"&loginType="+loginType,'�û��б�','600','400');
	}else{
		getCustId(phoneNo,loginType);
	}
}
*/
	function addTabBySearch(enterType)
	{
		 //����ǰ�ť�������
  	 if(enterType=='button')
  	 {
  	 	 var phoneNo = $("#phoneNo2").val();
  	 	 $("#phoneNo2").val("");
  	 }
  	 //�س�����
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
								  alert( "�ļ�������!");
								}
								else if (data.status=="500")
								{
								  alert("�ļ��������!");
								}
								else{
								  alert("ϵͳ����!");
								}
				    },
				    success: function(ret_code){
				      if(ret_code.trim()=="000000"){
								$("#phoneNo").val("");
								//(9)�ͷ� songjia add 2010/08/19 �޸�childTab2.jspΪ�ͷ�childTab2_kf.jsp begin
								//addTab(true,phoneNo,phoneNo,'childTab2.jsp?activePhone='+phoneNo);
								addTab(true,phoneNo,phoneNo,'childTab2_kf.jsp?activePhone='+phoneNo);
								//(9)�ͷ� songjia end 2010/08/19
						  }else{
								rdShowMessageDialog("�ֻ�������Ϣ����ȷ,��Tabҳ����!");
				      }
				      $("#phoneNo").val("�������ֻ�����");
				    }
					});
					sendphone_no=null;
		 }
	}
//(10)�ͷ� songjia ������֤ begin 2010/08/19
 /*
	 * 	openflag	 1.first tab;2.second tab;3.callcenter;4.asweb|jlnewsaleweb;other
	 *	opcode
	 *	title			 tab show text
	 *	targetUrl  page url
	 *	valideVal
	 */


	var kfFlagOc = "";  // opcode �Ƿ���Ҫ ����У���־ hejwa add
	function ajaxOpcodeLimit(opCodev){
	  var chkInfoPacket = new AJAXPacket("ajaxOcLimit.jsp","���ڻ�ȡopCode����У��״̬,���Ժ�...");
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
		var phstuPacket = new AJAXPacket("ajaxSetSession.jsp","���Ժ�...");
        phstuPacket.data.add("phoneNo" ,phoneNo);
        phstuPacket.data.add("flag" ,flag);
        core.ajax.sendPacket(phstuPacket,doProcess1);
		    phstuPacket =null;
	}
	function ajaxGetSession(g_activateTab){
		var phstuPacket = new AJAXPacket("ajaxGetSession.jsp","���Ժ�...");
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
 
 var g_checkPwdOth;//1Ϊ����������֤,����������֤ʱ,�û���Ϣҳ�������С��������һ�����ж�
 function toOpenTab(){
 //	alert("document.all.acceptPhoneNo.value|"+document.all.acceptPhoneNo.value+"\ndocument.all.telNo_oth.value|"+document.all.telNo_oth.value);

 	if(document.all.telNo_oth.value!=document.all.acceptPhoneNo.value){//������֤ ����
 		//alert("������֤ ����");
 		openTabFlag = "0";
 		g_checkPwdOth = 1;
 		addTabBySearchCustName(document.all.telNo_oth.value,'kf');//�൱�������ֻ��Ŵ���֤�ɹ���tab

 	}else{                                                                //������֤����
 		//alert("������֤ ����");
 		  var targetUrl=document.getElementById("targetUrl_ps").value;
		  var title=document.getElementById("title_ps").value;
		  var opcode =document.getElementById("opcode_ps").value;
		  var g_activateTab=document.getElementById("activephone_ps").value;
		  var telNo_pss=document.getElementById("telNo_ps").value;
		  //alert("targetUrl|"+targetUrl+"\ntitle|"+title+"\nopcode|"+opcode+"\ng_activateTab|"+g_activateTab+"\ntelNo_pss|"+telNo_pss);
			document.getElementById("iframe"+g_activateTab).contentWindow.addTab(false,opcode,title,targetUrl);

 	}
}
//��֤�Ƿ���ط��������
function toOpenTFTab(){
	if (document.getElementById("iframe5556")) {
		document.frames["iframe5556"].doToTF();
	}
}
 function checkPasswd(){
//	cCcommonTool.DebugLog("javascript  ��ʾ������֤��ʼ");
//
//	var height = 150;
//	var width = 260;
//	var top = screen.availHeight/2 - height/2;
//	var left = screen.availWidth/2 - width/2;
//	var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=yes";
//	window.open("../../npage/callbosspage/K086/otherPhoneCheck.html", "checkPasswd", winParam);
//  cCcommonTool.DebugLog("javascript  ��ʾ������֤����");
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
	if((validateResult=="undefined")||(validateResult!="1")){  // У��ʧ��
		ajaxSetSession(document.all.telNo_oth.value,"0");
	  return;
	}else if((validateResult=="undefined")||(validateResult=="kf_ivr")){
		//ת��ivr����
	}else{
		similarMSNPop("����У����ȷ");
		ajaxSetSession(document.all.telNo_oth.value,"1");
	}
}

//(10)�ͷ� songjia end 2010/08/19
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
			openDivWin(path,'ѡ��ͻ�','600','400');
		}else{
			showDialog("û�в�ѯ�����������Ŀͻ���",0);
		}
	}

	$("#phoneNo").val("��������Ϣ���в�ѯ(Alt+1)");
}
//�������֤����
function btnReadID2()
{
  try{
	  if(IDCard1.Syn_ReadMsg(1001)!=0){
	       showDialog("�������������·ſ�!",0);
	       return false;
	  }
	  var cardNo = IDCard1.IDCardNo;//���֤����
	  $("#phoneNo").val(cardNo);

	 }catch(e){
	 	  showDialog("������������ϵ����Ա��",0);
	 }
}
//��ʽ���ͻ�����
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

//(14)�ͷ� songjia begin 2010/08/19
/*
function addTabBySearchCustName(custType,enterType)
{
		 //����ǰ�ť�������
  	 if(enterType=='button')
  	 {
  	 	 var phoneNo = $("#iCustName2").val();
  	 	 $("#iCustName2").val("");
  	 	 $("#iCustName").val("�������ֻ������ѯ");
  	 }
  	 //�س�����
  	 else
  	 {
  	 	 var phoneNo = $("#iCustName2").val();
  	 	 $("#iCustName2").val("");
  	 	 $("#iCustName").val("�������ֻ������ѯ");
  	 }

			//var phoneNo = $("#iCustName").val();
			if(phoneNo=="��������Ϣ���в�ѯ"||phoneNo=="")
			{
				rdShowMessageDialog("�������ѯ����");
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
//���ٵ�¼����
function addTabBySearchCustName(custType,enterType)
{
	//alert("addTabBySearchCustName#\ncustType|"+custType+"\nenterType|"+enterType);
	  enterTypeAll=enterType;
	  cCcommonTool.DebugLog("enterTypeAll"+enterTypeAll);
	  //add by songjia 20101109 ��պ��м���
		 /*if(enterType!='kf')
		 {
		 		document.getElementById('callSkill').value="";
		 }*/
		 //����ǰ�ť�������
  	 if(enterType=='button')
  	 {
  	 	 var phoneNo = $("#iCustName2").val();
  	 	 $("#iCustName2").val("");
  	 	 //$("#iCustName").val("�������ֻ������ѯ");
  	 }
  	 //20100309 tancf �ͷ�����
  	 else if (enterType=='kf')
  	 	{
  	 		var phoneNo = custType;
  	 		// update by songjia �ͷ�(25) begin
  	 		//custType=document.all.loginType.value;
  	 		custType=document.all.cust_type.value;
  	 		//end
  	 	}
  	 	else if (enterType=='addBut')//���������ʱ���룬��¼���ֻ�����
  	 	{
  	 		var phoneNo = document.getElementById("acceptPhoneNo").value;
  	 		$("#iCustName2").val("");
  	 		custType="1";
  	 	}
  	 	else if (enterType=='addLink')//���������ʱ���룬��¼���ֻ�����
  	 	{
  	 		var phoneNo = custType;
  	 		$("#iCustName2").val("");
  	 		custType="1";
  	 	}
  	 else
  	 {
  	 	 var phoneNo = $("#iCustName2").val();
  	 	 $("#iCustName2").val("");
  	 	 //$("#iCustName").val("�������ֻ������ѯ");
  	 }

			//var phoneNo = $("#iCustName").val();
			if(phoneNo=="��������Ϣ���в�ѯ"||phoneNo=="")
			{
				rdShowMessageDialog("�������ѯ����");
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
	//(14)�ͷ� songjia end 2010/08/19

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
						var path="selectCustId.jsp?opName=ѡ��ͻ�&custIdArr="+custIdArr+"&custNameArr="+custNameArr+"&custIccid="+custIccidJ+"&custCtime="+custCtimeJ+"&loginType="+loginType;
						//openDivWin(path,'ѡ��ͻ�','600','400');
						window.open(path,"newwindow","height=600, width=600,top=50,left=250,scrollbars=yes, resizable=no,location=no, status=yes");
					}
			}

			$("#phoneNo").val("��������Ϣ���в�ѯ");
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
			    
			
			
			//added by tangsong 20110304 ��ѯ�ͻ���Ϣʱ�Զ��л����û���Ϣ����
			HoverNav('userinfo');
			//(15)�ͷ� songjia begin  ��ʱע�͵����޸���ɺ��ע��2010/08/19
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
                updatePhoneNo(phone_no);  //modify by yinzx 0811  �滻 $("#phoneNo").val() Ϊ phoneNo;
            }
        /*    
// add wanghong  ���ӵ����û���Ϣҳ�ж����к���,��ѯ�û�������Ϣ 20110711
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
           //tancf20090321�޸�����������
        lastphoneflag=lastphoneflag + 1;
           		//tancf 20110601
           	if(enterTypeAll!='kf')
           	{
		       	callCome(phone_no,document.getElementById("contactId").value);
		     		}		     			
		       	if(phone_no.indexOf("������")==-1){
		       		document.getElementById("acceptPhoneNo").value =phone_no;
		      	}
				//add by chenhr.20100525,�˲�����Ϊ����ͻ�����ҳ�洫��
				var contactId =	document.getElementById("contactId").value;
				//alert(phone_no);
				//add by songjia ���Ӽ��ܲ��� 20101109
				var callSkill = document.getElementById("callSkill").value;
			  try{
						parent.removeTab("5556");
					}
				catch(e){}		
				//���к���
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
			  L("1","5556","�û���Ϣ",pathTemp,"000");
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
				if(phone_no.indexOf("������")==-1){
					document.getElementById("acceptPhoneNo").value = phone_no;
				}
				return;
			}
			//(15)�ͷ� songjia end 2010/08/19
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
						var path="selectCustId.jsp?opName=ѡ��ͻ�&custIdArr="+custIdArr+"&custNameArr="+custNameArr+"&custIccid="+custIccidJ+"&custCtime="+custCtimeJ;
						//openDivWin(path,'ѡ��ͻ�','600','400');
						window.open(path,"newwindow","height=600, width=600,top=50,left=250,scrollbars=yes, resizable=no,location=no, status=yes");
					}
			}

			$("#phoneNo").val("��������Ϣ���в�ѯ");
		}
//(16)�ͷ� songjia begin  2010/08/19
/*
function openCustMain(custId,custName,loginType,phone_no)
{
    iCustId = custId;
	if($("#contentArea iframe").size() < 11){
		addTab(true,"custid"+custId,custName,'childTab2_kf.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&activePhone='+phone_no);
		$("#phoneNo").val("��������Ϣ���в�ѯ").blur();
		//document.all.phoneNo.blur();
		//layoutSwitch(1,$(".a1")[0]);
	}else{
		rdShowMessageDialog("ֻ�ܴ�10��һ��tab");
	}
}*/
function openCustMain(custId,custName,loginType,phone_no)
{
  
	//alert("openCustMain|"+"\n\n\n"+"custId|"+custId+"\ncustName|"+"\nloginType|"+loginType+"\nphone_no|"+phone_no);
    iCustId = custId;
    //(17)�ͷ� songjia begin  �޸���ɺ�ȡ��ע��2010/08/19
    //tancf 20100310 ����
    document.getElementById("last_caller_phone").value="custid"+custId;
    //(17)�ͷ� songjia end  2010/08/19
	if($("#contentArea iframe").size() <= <%=tabOpenMax%>){
		//added by tangsong 20110527 iPhoneNo�����︳ֵ��ȡ����activateTab�����︳ֵ(������ʱȡ����һ���ͻ��ĵ绰����)
		iPhoneNo = phone_no;
		addTab(true,"custid"+custId,custName,'childTab2_kf.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&activePhone='+phone_no);
		$("#phoneNo").val("��������Ϣ���в�ѯ");
		//document.all.phoneNo.blur();
		//layoutSwitch(1,$(".a1")[0]);

		if(openTabFlag=="0"){
        setTimeout("addTabOp()",3000);
        openTabFlag = "1";
     	}
	}else{
		rdShowMessageDialog("ֻ�ܴ�<%=tabOpenMax%>��һ��tab");
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
//(16)�ͷ� songjia end  2010/08/19
/* ����
function openCustMain(custId,custName,loginType,phone_no,signUser,id_no)
{
	showWinCover();
	if($("#contentArea iframe").size() < 11){
		addTab(true,"custid"+custId,formatString(custName),'childTab_kf.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&signUser='+signUser+"&idNo="+id_no+"&isMarket=true");
		$("#phoneNo").val("��������Ϣ���в�ѯ(Alt+1)");
		document.all.phoneNo.blur();
		bindRemoveTab("custid"+custId);
	}else{
		showDialog("ֻ�ܴ�10��һ��tab",1);
	}
}
*/
//������ɣ��򿪿ͻ���ҳ
function openCustMainForNewUser(custId,custName,loginType,phone_no,contactId,idNo,opType)
{
	if(!isTabExist()) return false; //��ֹ�������ͻ���ҳ
	if(loginType==="PHONE_NO") loginType="11";  //�������ô˷����ĵط���д��ΪPHONE_NO,Ϊ��������޸ģ�ת��Ϊ���ݿ��е�����
	showWinCover();
	if($("#contentArea iframe").size() <= <%=tabOpenMax%>){
		addTab(true,"custid"+custId,formatString(custName),'childTab_kf.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&contactId='+contactId+'&idNo='+idNo+'&opType='+opType);

		bindRemoveTab("custid"+custId);
	}else{
		showDialog("ֻ�ܴ�<%=tabOpenMax%>��һ��tab",1);
	}
}
//�Ӵ�������������򿪿ͻ���ҳ
function openCustMainForUnset(custId,custName,loginType,phone_no,signUser,unsetFrom,contentArr,idNo)
{
	if(!isTabExist()) return false; //��ֹ�������ͻ���ҳ
	if(loginType==="PHONE_NO") loginType="11";  //�������ô˷����ĵط���д��ΪPHONE_NO,Ϊ��������޸ģ�ת��Ϊ���ݿ��е�����
	showWinCover();
	$("#contentArr").val(contentArr);
	if($("#contentArea iframe").size() <= <%=tabOpenMax%>){
		addTab(true,"custid"+custId,custName,'childTab_kf.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&signUser='+signUser+'&unsetFrom='+unsetFrom+'&idNo='+idNo);

		bindRemoveTab("custid"+custId);
	}else{
		showDialog("ֻ�ܴ�<%=tabOpenMax%>��һ��tab",1);
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
				rdShowMessageDialog("������굱ǰ�ͻ������������ͻ�");
				return false;
			}
		}
	}
	*/
	if($("#contentArea iframe").size() <= <%=tabOpenMax%>){
		addTab(true,"custid"+custId,custName,'childTab2_kf.jsp?gCustId='+custId+'&custOrderId='+custOrderId);
		$("#phoneNo").val("��������Ϣ���в�ѯ");
		//document.all.phoneNo.blur();
		//layoutSwitch(1,$(".a1")[0]);
	}else{
		rdShowMessageDialog("ֻ�ܴ�<%=tabOpenMax%>��һ��tab");
	}
}

function doChangeType(obj){
    var type = obj.value;
    //�ͷ���� songjia (24) begin
    $("#cust_type").val(type);
    //end
    if(type == "0"){
        $("#iCustName").val("������ͻ�ID���в�ѯ");
    }else if(type == "1"){
        //$("#iCustName").val("�������ֻ������ѯ");
    }else if(type == "2"){
        $("#iCustName").val("�������ʻ�ID���в�ѯ");
    }else if(type == "4"){
        $("#iCustName").val("������֤��������в�ѯ");
    }else if(type == "6"){
        $("#iCustName").val("������ͻ����Ʋ�ѯ");
    }else{
        $("#iCustName").val("��������Ϣ���в�ѯ");
    }
}

//hejwa����������빦��b  newCustAddBut
		function newCustAddBut(){
				var phoNeNo = document.getElementById("acceptPhoneNo").value;
				if(phoNeNo==""){
					rdShowMessageDialog("���������ֻ�����");
					return false;
				}
				addTabBySearchCustName(phoNeNo,'addBut');//�൱�������ֻ��Ŵ���֤�ɹ���tab
		}

function newCustF(){
		L("1","1100","�ͻ�����","sq100/sq100_1.jsp","000");
	}
//(18)�ͷ� songjia begin ��ʱ�뿪��֤����  2010/08/19
	//ccs tancf ��ʱ�뿪 20090305
function checkPassWord(){
	btn_More();
	var pwValue=document.getElementById("checkPW").value;
	var packet = new AJAXPacket("../../../npage/callbosspage/checkPW/check.jsp", "\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("retType", "chkExample");
	packet.data.add("checkpw", pwValue);
	core.ajax.sendPacket(packet, doProcesspp, false);
	packet = null;
}
//tancf ��ʱ�뿪20090305
function doProcesspp(packet){
  var retType = packet.data.findValueByName("retType");
  var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
      var strmsg = packet.data.findValueByName("strmsg");
  if(retType=="chkExample"){
  	if(retCode=="000000"){
  		document.getElementById("kf_loading").style.display='none';
  	}
  	/*add by hucw 20110107,���뽫Ҫ�����ж�*/
  	else if(retCode == "900099"){
  		rdShowMessageDialog(strmsg,0);
  		document.getElementById("kf_loading").style.display='none';
  	}else{
      rdShowMessageDialog(strmsg,0);
			return false;
		}
   }
}
//(18)�ͷ� songjia end ��ʱ�뿪��֤����  2010/08/19
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

//BEGIN ����ת��
var quickFlag = true;
var content_array;//���ٵ��� 0: openWay 1:functionCode 2:functionName 3:url 4:passFlag �Կո����
var opStr_quick = ""; //ϵͳģ������ ��ʽ"0121 ǩ�� QT,...."

function initSearch(){

	//����ģ��
	$("#funcText").focus(function(){
		focusQuickNav(this)
	});
	$("#funcText").blur(function(){
		if($("#funcText").val() == ""){
			$("#funcText").val("����ģ�� (Alt+3)");
		}
	});

	//����ת��
	$("#tb").focus(function(){
		focusQuickNav(this)
	});
	$("#tb").blur(function(){
		if($("#tb").val() == ""){
			$("#tb").val("����ת�� (Alt+2)");
		}
	});
}

function focusQuickNav(obj)
{
	if(quickFlag){
		quickFlag = false;
		obj.value="���ݼ�����...";
		getQuickNavData(obj);
	}else{
 		obj.value="";
	}
}

function getQuickNavData(obj)
{
	var packet = new AJAXPacket("getQuickNavData.jsp","���Ժ�...");
	packet.data.add("objId" ,obj.id);
	core.ajax.sendPacket(packet,doProcessNav,true);//�첽
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
 	document.getElementById('tb').value="����ת�� (Alt+2)";
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
//END ����ת��

/************************************ navPanel ************************************/
// ����ϵͳ����
function searchFunc(keyword){

  var keyword = $.trim(keyword).toUpperCase();
	if(keyword == ""){
		 return;
	}else if(keyword.length < 2){
		alert("������������������",0);
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
		htmlString += "���ܲ�����";
	}

	$('#functionResult').html(htmlString);
	$('#wait').hide();
	$('#system_search_result').show();
}

//�������л�;
//(19)�ͷ� songjia add 2010/08/19 begin ����û���Ϣtab
function HoverNav(flag,parentNode,parentName){
	//����
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
		//getAuthorize();//ҵ���򵼺���
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
	}else if(flag =="userinfo"){//����
		//$("#getAuthorizeTree").addClass("on");
		$("#getTree").removeClass("on");
		$("#getAllTree").removeClass("on");
		$("#getFavFunc").removeClass("on");
		$("#buGu").removeClass("on");
		$("#getUserInfo").addClass("on");
		getUserInfo();
	}

}

//�ͷ�  add by chenhr.2010/10/14 end ���������������������û���Ϣtab
function newCustCall(obj){
	var phone=obj.innerText;
	if(phone==""||phone=="10086"){
			return false;
	}else{
		addTabBySearchCustName(phone,'addLink');
	}
}
//(19)�ͷ� songjia add 2010/08/19 end ����û���Ϣtab
//(20)�ͷ� songjia add 2010/08/19 begin �û���Ϣtab����
function getUserInfo()
{
	var node_userinfo = document.getElementById("node_userinfo");

	if(node_userinfo == null)
	{
		node_userinfo = document.createElement("div");
		node_userinfo.setAttribute("className","dis");
		node_userinfo.setAttribute("id","node_userinfo");
		$(".navMain")[0].appendChild(node_userinfo);
		$('#node_userinfo').html("<li><div id='tbc_01'><div  class='functitle'  style='color:#000000;background:url(../../nresources/default/images/icon_titleO.gif) no-repeat 1px 7px;padding:3px 0 0 16px;font-weight:bold;'>�û�������ˮ</div><table style='color:#009000;width:99%;'><tr><td colspan='3' id='contactIdnew'  style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>���к���</th><td colspan='2' id='caller_phone_no' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='newCustCall(this);copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>�������</th><td colspan='2' id='phone_no1' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='newCustCall(this);copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>���к���</th><td colspan='2' id='called_phone_no' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>���й�����</th><td colspan='2' id='town' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>�ͻ�����</th><td colspan='2' id='cust_name' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td>				</tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>�ͻ�����</th><td colspan='2'  id='card_name' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>�ͻ�Ʒ��</th><td colspan='2' id='sm_name' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>����ʽ</th><td colspan='2' id='handleType' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr id='handleNo_town_tr' style='display:none'><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>���������</th><td colspan='2' id='handleNo_town' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>����״̬</th><td colspan='2' id='run_name' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>Ԥ���</th><td colspan='2' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' id='prepay_fee1' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>���¿���Ԥ����ܶ�</th> <td colspan='2' id='hasMoney' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>Ƿ��</th><td colspan='2' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' id='prepay_fee2' onclick='copyToClipBoard(this)'></td></tr><tr id='speciallight' style='display:none' ><th  style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'><img  src='/nresources/default/images/ico_16/009i.gif' /></th> <td style='text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;' colspan='2' id='specialcontent'  value='' onclick='copyToClipBoard(this)'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>���й켣</th><td colspan='2' id='call_track' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:60px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>���м���</th><td colspan='2' id='call_skill' style='color:#ff0000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:120px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>������֤�������</th><td colspan='2' id='password_error_num' style='color:#009000;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'></td></tr><tr><th style='color:#000000;text-align:left;font-weight:normal;width:120px;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'>����ɧ��</th><td colspan='2' id='blUserNum' style='color:#F00;text-align:left;border-bottom:1px dotted #bdd0de;padding:5px 0 0 0;'></td></tr></table></div></li>");
	}
 
	setNav("N");
	$('#node_userinfo')[0].className="dis";
	$("#wait").hide();


}


//(20)�ͷ� songjia add 2010/08/19 end �û���Ϣtab����

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

/* ����
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

function showFavMenu(functionCode)  //չ�ֳ���ģ���Ҽ��˵�
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
		addTab(true,'index','�����ռ�','../portal/work/portal.jsp');
		document.getElementById("ifram").contentWindow.openDivWin("/npage/portal/work/modifyHotKey.jsp","�Զ����ݼ�","300","400");
		hideFavMenu();
		});

	$('#favMenu #helpIcon').bind('click',function(){
		callHelp(functionCode)
	});
}
$(document).click(function(){
	hideFavMenu();

	})

function  hideFavMenu() //���س���ģ���Ҽ��˵�
{
	favMenu.style.display  =  "none";

	$('#favMenu #delIcon').unbind('click');
	$('#favMenu #editIcon').unbind('click');
}

/*
*�����ù���
*id ��ģ�����(function_code)
*op_type:��������(a,���ӳ��ù���;d,ɾ�����ù���;u,�޸�����˳��)
*/
function addFavfunc(function_code,op_type,show_order)
{
	var  f = function_code.indexOf("custLater");
	if(f>-1)function_code = function_code.substr(f+9);
	if(function_code.indexOf("custid")>-1||$.trim(function_code)==""){
		showDialog("��ǰ���ܲ��ܼ��볣�ù��ܣ�",1);
		return false;
	}
	/** modified by hejwa in 20110718 ��OP����--�ղؼй��� begin**/
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
		
		showDialog("�����ɹ�",2);


		//ˢ����ೣ�ù�����
		$(".navMain")[0].removeChild(document.getElementById("node_favfunc"));
		HoverNav('fav');

		//ˢ�¹����ռ�ĳ��ù���
		document.frames["ifram"].loadLoginMdl();

		//ˢ�¿ͻ���ҳ���ù�����
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
		showDialog(retMsg,0,"detail=����ʧ�ܣ�"+retMsg);
	}
}
/** modified by hejwa in 20110718 ��OP����--�ղؼй��� begin**/

function doFavfunc(packet)
{

	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var detailMsg = packet.data.findValueByName("detailMsg");
	if(retCode=="000000"){

		showDialog("�����ɹ�",2);

		//ˢ����ೣ�ù�����
		$(".navMain")[0].removeChild(document.getElementById("node_favfunc"));
		HoverNav('fav');

		//ˢ�¹����ռ�ĳ��ù���
		document.frames["ifram"].loadLoginMdl();

		//ˢ�¿ͻ���ҳ���ù�����
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
               top.openDivWin("/npage/login/tempGrant.jsp?pop_type="+pop_type+"&function_code="+function_code+"&function_name="+function_name+"&jsp_name="+jsp_name+"&auFlag="+auFlag,'��ʱ��Ȩ','505','294');
		}else
		{
				showDialog("��ѡ��Ҫ����Ŀͻ�!",1);
		}
    }else
    {
    	top.openDivWin("/npage/login/tempGrant.jsp?pop_type="+pop_type+"&function_code="+function_code+"&function_name="+function_name+"&jsp_name="+jsp_name+"&auFlag="+auFlag,'��ʱ��Ȩ','505','294');
    }
}

/************************************ workPanel ************************************/
function callHelp(tabId)//����ϵͳ
{
	if (tabId.length != 4) {
		rdShowMessageDialog("�˹��ܲ��ṩ���߰�����", 1);
		return false;
	}
	
	var getFuncNamePacket = new AJAXPacket("ajaxGetFuncName.jsp","���ڽ��к���У�飬���Ժ�......");
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
		rdShowMessageDialog("sqlִ�д���:"+retCode+","+retMsg+".", 0);
	} else {
		var targetUrl = "http://10.110.0.100:52000/npage/login/Accept.jsp?workNo=<%=workNo%>&pass=<%=password%>&kfLoginNo=<%=kfLoginNo%>&dPage=/npage/funcBusiMgr/funcApplication.jsp&functionId=" + functionId + "&functionName=" + functionName;	//����
		//var targetUrl = "http://10.110.0.206:26001/npage/login/Accept.jsp?workNo=<%=workNo%>&pass=<%=password%>&kfLoginNo=<%=kfLoginNo%>&dPage=/npage/funcBusiMgr/funcApplication.jsp&functionId=" + functionId + "&functionName=" + functionName;	//����
		L("h", "h"+functionId, "ҵ������߰��� "+functionId+functionName, targetUrl, "000");
		//window.open("../help/h"+functionId+".html");
	}
}

function comment(tabId)//ģ������
{
    /*ģ�����ָ���Ϊ��ѯ�������
	var path = "/npage/public/rating.jsp";
	openDivWin(path,'ģ������','405','194');
	*/
	L("1","1560","��ѯ�������","../npage/s1300/s1560.jsp","000");
}

var g_activateTab = "index";//active tabId
function activateTab(id)
{
    g_activateTab = id;
	if(document.getElementById(g_activateTab.substring(6,g_activateTab.length))!=null){
	//commented by tangsong 20110527 iPhoneNo�������︳ֵ������openCustMain������ֵ
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
				  alert( "�ļ�������!");
				}else if (data.status=="500")
				{
				  alert("�ļ��������!");
				}else{
				  alert("ϵͳ����!");
				}
		   },
		   success: function(retCode){
		   }
		});
		sendop_code=null;
}
function destroyTab(id)
{
	//�رտͻ�Tabʱ��session
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
				  alert( "�ļ�������!");
				}else if (data.status=="500")
				{
				  alert("�ļ��������!");
				}else{
				  alert("ϵͳ����!");
				}
		   },
		   success: function(retCode){
		   }
		});
		sendop_code=null;
		}
		//(8)�ͷ� songjia add 2010/08/19 begin ������֤��session,�ʼ�״̬��֤��
		/**hejwa ��ʼ
		��δ������ر�ʱ����ֻ���ôsession���ݵ� ��Ҫ���λ��޸ġ���ǰ��֪ͨhejwa ������ǰ��*/
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
		/**hejwa ���� */
		/*add yinzx begin*/
		if(id!="index")
		{
			if(id!=''&& id!=undefined&&id.length>=4){
			var tempId=id.substring(0,4);

	       //�ƻ���
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
					rdShowMessageDialog("��������ѱ���ʱ���棡",2);	//guozw05
		        }
	        }
			if(tempId=='K214'){
				if(isSaved=='false'){
					if(rdShowConfirmDialog("���Ƿ�Ҫ���浱ǰ�ʼ�����",3)=='1'){
	           		frameObj.window.document.getElementById("isClosed").value='true';
	             	frameObj.window.saveQcInfo("1");
					}
				}
			}
		}
	}
	//(8)�ͷ� songjia end 2010/08/19
}

/************************************ footPanel ************************************/

function openwindow(url,name,iWidth,iHeight)
{
  var url;                            //ת����ҳ�ĵ�ַ;
  var name;                           //��ҳ���ƣ���Ϊ��;
  var iWidth;                         //�������ڵĿ��;
  var iHeight;                        //�������ڵĸ߶�;
  var iTop  = (window.screen.availHeight-30-iHeight)/2;       //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-10-iWidth)/2;           //��ô��ڵ�ˮƽλ��;
  var winOP = window.open(url,name,'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=yes,location=no,status=no');
  winOP.focus();
}

/*******************end***************************/
 	//(2)�ͷ� songjia add 2010/08/19 begin ע�͵������Է��㡣��ɺ���Ҫ�Ļ�

 		window.onunload=function(){
 			
 			if(isExit!=1){
 			try
	{
				
			     signOutFromIE();
			 
	}
	catch(e)
	{
	}
	//tancf ����20100630���
	canLoopAlertPopupWin = false;
	if (popupWin != null && !popupWin.closed){popupWin.close();}
	//(12)�ͷ� songjia add 2010/08/19 �����رյ������� end

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
 	//(2)�ͷ� songjia add 2010/08/19 begin
 		window.onload=function(){
 			
 		
 			if('<%=state%>'==1){
 				try
			{
			  iniOnclick();
			  SignInEx();
			}catch(e)
			{} 
	  }else{
	  	//��ʼ������ͼƬ�ĵ���¼�
	  		iniOnclick();
	  		//������ͼ������
		    btn_able();
		    //����������ť����ǩ����ʽ�ð�
		    btn_Gray(arr_K006);
		    //����ʾ���ð�
		    changeLight(0);
	  	}
	  	initcallreason();

		//added by tangsong 20110604 �ʼ�Ա�ƻ�ִ���������
		<%@ include file="/npage/callbosspage/public/constants.jsp" %>
		<%
			String powerCodekf = (String)session.getAttribute("powerCodekf");
			String[] powerCodeArr = powerCodekf.split(",");
			boolean is_zhijianyuan = false; //�Ƿ��ʼ�Ա���ʼ�Աֻ�ܲ�ѯ�Լ��ļƻ�ִ�����
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
			addTab(true,"K216",'�ʼ�Ա�ƻ�ִ�����',reportURL);
		}
	}

 	window.onresize = function(){
 		try{
		initPanel($("#layoutStatus").val());
		//(6)�ͷ� songjia add 2010/08/19 begin
		var more_btn2iframe =document.getElementById("more_btn2iframe");
		var btnMore=document.getElementById("more_btn");
		more_btn2iframe.style.width = btnMore.clientWidth;
		more_btn2iframe.style.height  = btnMore.clientHeight;
		}catch(e)
		{
			alert(e);
		}
		//�ͷ� songjia add 2010/08/19 begin
	}
	/*
	 * ���߿ͻ���ҳ��ģ����й���У��
	 * 	valideVal	 N_N,Y_N,N_Y,Y_Y,��һλ��ʾ�Ƿ�ǿ����֤���ڶ�λ��ʾ�Ƿ���Ҫ��֤
	 */
	function funcVerify(valideVal,opcode,custId,g_activateTab,title,targetUrl){
		var  valideArr = valideVal.split("_");
		//alert(valideVal+"-->"+opcode);
		//alert(valideArr[0]+"-->"+valideArr[1]);
		addUserToSession(opcode,custId);
		//return  true;

		var  urlStr = "cust_id="+custId+"&opcode="+opcode+"&g_activateTab="+g_activateTab+"&title="+title;
		urlStr += "&id_no="+$.trim(top.document.getElementById("currUserId").value);
		document.getElementById("targetUrlDiv").value = targetUrl; //��URL��׺�ݴ�main.jsp,����֤ҳ��ȡ
		if(valideArr[0]==="Y"){
			top.openDivWin("ajax_forceVerify.jsp?isForce=Y&"+urlStr,"��֤��Ϣ","400","200");
		}else{
			if(valideArr[1]==="Y"){
				top.openDivWin("ajax_verify.jsp?isForce=N&"+urlStr,"��֤��Ϣ","400","200");
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
				  alert( "�ļ�������!");
				}else if (data.status=="500")
				{
				  alert("�ļ��������!");
				}else{
				  alert("ϵͳ����!");
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
	/* ����
	function L(openflag,opcode,title,targetUrl,valideVal,grantNo)
	{
		if($.trim(targetUrl)==""||targetUrl=="#")return  false;//����Ŀ¼�ڵ��ҳ��
		if(openflag=="1")//first tab
		{
			if(targetUrl!="#"){
				targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title,grantNo);
				if($("#contentArea iframe").size() < 11){
					addTab(true,opcode,title,targetUrl);
				}else{
					showDialog("ֻ�ܴ�10��һ��tab",1);
				}
			}
		}else if(openflag=="2")//second tab
		{
			if(g_activateTab.substr(0,6)	=="custid"){
				openSecondTab(g_activateTab,targetUrl,opcode,title,valideVal,grantNo);
			}else
			{
				showDialog("��ѡ��Ҫ����Ŀͻ�!",1);
			}
		}else if(openflag=="3")//����ͻ���ҳ�Ѿ��򿪣���򿪶���tab�������һ��tab
		{
			var  _hasCustOpen = false;
			$("#contentArea iframe").each(function(){
				if($(this)[0].id.length>12&&$(this)[0].id.substring(0,12)=="iframecustid"){
					_hasCustOpen = true;
				}
			});

			if(_hasCustOpen){//�򿪶���tab
				if(g_activateTab.substr(0,6)=="custid"){
					openSecondTab(g_activateTab,targetUrl,opcode,title,valideVal,grantNo);
				}else
				{
					showDialog("��ѡ��Ҫ����Ŀͻ�!",1);
				}
			}else{  //��һ��tab
				if(targetUrl!="#"){
					targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title,grantNo);
					if($("#contentArea iframe").size() < 11){
						addTab(true,"custLater"+opcode,title,targetUrl);	////�Ե����ַ�ʽ�򿪵�ʱ���tab���±��
					}else{
						showDialog("ֻ�ܴ�10��һ��tab",1);
					}
				}
			}
		}else if(openflag=="4")//һ��tab�򿪼���ҳ��
		{
			if(targetUrl!="#"){
				if($("#contentArea iframe").size() < 11){
					addTab(true,opcode,title,targetUrl);
				}else{
					showDialog("ֻ�ܴ�10��һ��tab",1);
				}
			}
		}
		else//������ʽ
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
                rdShowMessageDialog("ֻ���ڽ���״̬�´�");               
                return false;
            }
		<%}%>
		//�жϹ��Ž��棺�û���Ϣҳ��opcode���� 
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
                rdShowMessageDialog("��ͨ��״̬�޷���ѯ\����");               
                return false;
              }
	 			 }
	 		}
	 		
	 	<%}%>
		
		if(openflag=="1")
		{

			/** modified by hejwa in 20110802 ��OP����--���һ��tab begin**/
			if($("#contentArea iframe").size() <= <%=tabOpenMax%>){
			}else{
				rdShowMessageDialog("ֻ�ܴ�<%=tabOpenMax%>��һ��tab",1);
				return;
			}
			/** modified by hejwa in 20110802 ��OP����--�ղؼй��� end**/

				//(13)�ͷ� songjia add 2010/08/19 �������ǩ��ת�޸� begin
				/*targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title);
				addTab(true,opcode,title,targetUrl);*/
				if(targetUrl.indexOf("report/XlsRep") != -1){
						//����Ҫ���޸ġ� songjia 20110902
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
				//(13)�ͷ� songjia add 2010/08/19 end
		}
		//second tab
		else if(openflag=="2")
		{

			if(g_activateTab.indexOf("custid")==-1){
				if(g_activateTab=="5556"){
					rdShowMessageDialog("�����ط�����ť!");
					$("#iCustName").select();
				    return;
				}else{
					rdShowMessageDialog("�������ֻ���������ط�����!");
				    $("#iCustName").select();
				    return;
				}
			}
		    if(iPhoneNo == "index"&&opcode!="1104"&&opcode!="q046"&&opcode!="4603"&&opcode!="4100"&&opcode!="7518"&&opcode!="4977"){
		        rdShowMessageDialog("�������ֻ�����!");
				    $("#iCustName").select();
				    return;
		    }
		    if(iPhoneNo == "custMain"){
		        rdShowMessageDialog("��ѡ��һ���û�!");
				    return;
		    }
		    if(iPhoneNo=="5556"&&opcode!="1104"&&opcode!="q046"&&opcode!="4603"&&opcode!="4100"&&opcode!="7518"&&opcode!="4977"){
		        rdShowMessageDialog("�������ֻ�����!");
				    return;
		    }

			//var patrn=/^((\(\d{3}\))|(\d{3}\-))?[12][03458]\d{9}$/;
			//if(g_activateTab.search(patrn)!=-1){

			//(11)�ͷ� songjia add 2010/08/19 ������֤�޸�
			/*
		  		if(typeof(valideVal)!="undefined"&&(valideVal.indexOf("1")!=-1)){ //��Ҫ��֤
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
             /**�ͷ�������֤ hejwa*/
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
		        rdShowMessageDialog("�������ֻ�����!");
				    $("#iCustName").select();
				    return;
		    }

		    if(g_activateTab == "5556"&&opcode!="1104"&&opcode!="q046"&&opcode!="4603"&&opcode!="4100"&&opcode!="7518"&&opcode!="4977"){
		        rdShowMessageDialog("�������ֻ�����!");
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
                 if((validateResult=="undefined")||(validateResult!="1")){  // У��ʧ��
                 		ajaxSetSession(document.all.telNo_oth.value,"0");
                    return;
                  }else if((validateResult=="undefined")||(validateResult=="kf_ivr")){
                  	//ת��ivr����
                  }else{
                  	similarMSNPop("����У����ȷ");
                  	ajaxSetSession(document.all.telNo_oth.value,"1");
                  }
          	}
         }
         //(11)�ͷ� songjia add 2010/08/19 ������֤�޸� end

          targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title);
          targetUrl = targetUrl+"&activePhone="+iPhoneNo;
          document.getElementById("iframe"+g_activateTab).contentWindow.addTab(false,opcode,title,targetUrl);
			//}
			//�ֻ�����
			//else
			//{
				//rdShowMessageDialog("�������ֻ�����!");
				//$("#iCustName").select();
			//}
		}
	  else if(openflag=="4")
	  {
	  	/** modified by hejwa in 20110802 ��OP����--���һ��tab begin**/
			if($("#contentArea iframe").size() <= <%=tabOpenMax%>){
			}else{
				rdShowMessageDialog("ֻ�ܴ�<%=tabOpenMax%>��һ��tab",1);
				return;
			}
			/** modified by hejwa in 20110802 ��OP����--�ղؼй��� end**/
			
	   
	  	targetUrl = changeUrl(targetUrl,opcode,title);
	  	addTab(true,opcode,title,targetUrl);
	  }
	  else if(openflag=="h") {	//2011/8/9 wanghfa��� ���߰���չʾ�ж�
  		var win= window.open(targetUrl,"","width=800,height=400,top="+(screen.availHeight/2-400/2)+",left="+(screen.availWidth/2-800/2)+",scrollbars=yes,resizable=yes,status=yes");
      addWinName(win,opcode);
	  }
	  //Ĭ�Ͼ�ҵ�񵯳���ʽ
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
	//�򿪶���TAB
	function  openSecondTab(g_activateTab,targetUrl,opcode,title,valideVal,grantNo){
		var user_index = document.getElementById("iframe"+g_activateTab).contentWindow.document.frames("user_index");
		if((!user_index)||(!user_index.document.all))return  false;
		if(typeof(user_index.document.all.isUserLoading)=="undefined")return false;
	//	if($.trim(user_index.document.all.isUserLoading.value)=="N")return false; //�ȴ��ͻ���ҳ���û��б�������
	//	if($.trim(top.document.getElementById("userFinishFlag").value)=="N")return false; //�½��û�������δ��⣬��Ҫ�ȴ����
		var  g_activeCustId = g_activateTab.substring(6);
		targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title,grantNo);
		targetUrl = targetUrl+addCustInfoToUrl(g_activeCustId);
		if(funcVerify(valideVal,opcode,g_activeCustId,g_activateTab,title,targetUrl)){
			document.getElementById("iframe"+g_activateTab).contentWindow.addTab(false,opcode,title,targetUrl);
		}
	}
	//����tab�򿪣���URL�����ӿͻ���ҳ�еĿͻ��û���Ϣ
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
        var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/public/timeValidate.jsp","���ڽ����û���Ч����֤,���Ժ�...");
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
      var str = s.replace(/#/g, "��");
      return str;
    }

	function chkIsValidate(validateVal,activePhone,opcode)
	{
	  	isValidateFlag = false;
	  	var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/public/chkIsValidate.jsp","���ڽ����û���Ч����֤,���Ժ�...");

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

         	    alert("ʱ�����ʧ��");
         	    return false;
        }
      }
	}

   /********����cookie����begin*******/
    function Clearcookie()   //���� COOKIE
    {
	    var temp=document.cookie.split("; ");
	    var len;
	    var ts;
	    for (len=0;len<temp.length;len++){
	        ts=temp[len].split("=")[0];
	        if (ts.indexOf("rkName")!=-1||ts=="cookieNum"){  //��� ts��"rkName"�����ɾ��
	            var exp = new Date();
	            exp.setTime(exp.getTime()-100000);//ʱ��
	            var cval=temp[len].split("=")[1];
	            document.cookie = ts + "=" + cval + "; expires=" + exp.toGMTString();
	        }
	    }
    }
   /******����cookie����end*******/

	$(document).ready(
		function(){
			loadFirstMenu();//����һ���˵�
			HoverMenu('oli','li');//��ʼ���˵�,��һ���˵��¼�,����getTree
			//(19)�ͷ� songjia add 2010/08/19 begin �û���ϢĬ����ʾ
			//HoverNav('fav');
			HoverNav("userinfo");
			//(19)�ͷ� songjia add 2010/08/19 end
			<%if(hotkey.equals("Y"))
			{%>
			getHotKey();					//��ȡ��ݼ��˵�
			<%}%>
			initSearch();					//��ʼ�������������
			
			/** modified by hejwa in 20110718 ��OP����--ҳ������ begin**/
			layoutSwitch(parseInt("<%=layout%>")+1);			//��ʼ��ҳ������ֵĴ�С;����1,2,3,4
			setNav('N');
			$("#wait").hide();
			/** modified by hejwa in 20110718 ��OP����--ҳ������ end**/
			
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
    			rdShowMessageDialog("��ӭ��ʹ�ú������ƶ��ۺϿͻ�����ϵͳ��");
    			});
    		$.hotkeys.add('Ctrl+r', function(){
    			rdShowMessageDialog("��ӭ��ʹ�ú������ƶ��ۺϿͻ�����ϵͳ��");
    			});
    		$.hotkeys.add('f5', function(){
    				rdShowMessageDialog("��ӭ��ʹ�ú������ƶ��ۺϿͻ�����ϵͳ��");
    				window.event.keyCode = 0;
    				return;
    			});
    		$.hotkeys.add('f11', function(){
    			rdShowMessageDialog("��ӭ��ʹ�ú������ƶ��ۺϿͻ�����ϵͳ��");
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
    		//(7)�ͷ� ��ʼ��ǩ�� ,��ʼ������ԭ�� ��ʱע�͵�ǩ�룬songjia add 2010/08/19 begin
			 	 $("b").hide();
	     	 var packet = new AJAXPacket("../login/getPanlePdom.jsp","���Ժ�...");
	  		 core.ajax.sendPacket(packet,doProcessPanPdom);//�첽
			 	 packet =null;

    		//(7)�ͷ� songjia add 2010/08/19 end

		    window.setInterval(function() {
		    	//showMessageDialog();
		    	if(canLoopAlertPopupWin){
		    	  //��ǰ�Ĵ���
		    	  //queryMaxIdAjax();
		    	  //add by chenhr.20101103.Ϊ��ʵ�ֹ������ѡ�񵯳�ʱ��Ӧ�õ��������⡣
		    	 	//queryMaxPopPubilicNotice();
		    	}
		    }, 60000);

      	 /* window.setInterval(function() {//add by chenhr.20101115.Ϊ��ʵ�ֹ���2����֮�ڵ�����
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
			//(22)��������ʾ��������songjia add 2010/08/19 begin
				 $("#bn_status_first_1").show();
		     $("#bn_status_second_1").show();
		     $("#bn_status_third_1").show();
		     //$("#K073").show();
		     $("#K101").show();
		    $("#callSearch").show();
		    //(22)��������ʾ��������songjia end 2010/08/19 begin
	}

<%
//added by tangsong 20101124 ȡ�õ�ǰ�������Ĺ���·��
String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath();
%>
	//(7)�ͷ� ����ԭ���ʼ������ songjia add 2010/08/19 begin
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
	//(7)�ͷ� songjia add 2010/08/19 end
	
	//add by licl at 20120706 ��̨ˢ������ԭ�� begin	
	
	var xmlDocTemp,xmlDocSeachTemp;
	var xmlHelperUp,xmlSeachUp;
	var oldxmlHelper,oldxmlSeach;
	var oldXmlMark = true;
	function updatecallreason(){		
		//alert("updatecallreason");
		xmlHelperUp = null;//��˵���ö������
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
					//���سɹ�					
					xmlSeachUp = null;
					xmlDocSeachTemp = null;
					xmlSeachUp = new XmlHelper();
					xmlDocSeachTemp = xmlSeachUp.loadXmlByAsync(checkStateSeach,'<%=basePath%>/file/callcenter/callresonseach.xml');
				}
				else
				{					
					//����ʧ��					
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
					//���سɹ�
					setXmlHelper(xmlHelperUp,xmlSeachUp);
					cleanCallCauseNodeStatus();
					//alert("���³ɹ�");
				}
				else
				{					
					//����ʧ��					
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
	//add by licl at 20120706 ��̨ˢ������ԭ�� end

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
								if(confirm("ȷ��Ҫ�˳��ͻ���ҳ��")){
									if(confirm("�Ƿ񳷵���")){
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
	
	
		/** modified by hejwa in 20110714 ��OP����--����ҵ���� begin**/
	
	//var has_busiGuide = false;//�Ƿ����ҵ����,
	
	
	//��ѯ�򵼡���һ�����в�ѯ
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
	
	//��ҵ���˳�ʱ�������ҵ����
	function hideBusiguide(opcode){
		//alert("hideBusiguide->opcode|"+opcode);
		if($('#tbc_04').children('#busiguide_'+opcode)[0]){
			//alert("size|"+$('#tbc_04>div').size());
				if($('#tbc_04>div').size()>1){//���ж���򵼣�ֻɾ���رյ�������
					$('#tbc_04').children('#busiguide_'+opcode).remove();
				}else{//��ֻ��һ����ر�ҵ������򵼲˵�
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
	 *���Ӷಽҵ�������ҵ������򵼹��ܣ����ղ���ȥ����ҵ��
	 *�磺��ͥҵ��parent.showBusiGuideStep("6385",1)�����һ����
	 *����Ӧ�Ľ�Ŀ����������δ��롣
	 *******************************************************/
	function showBusiGuideStep(opcode,step){
		HoverNav('buGu');	
		if(step==1||step=="1"){//��һ����ѯ���в���
				//���� getBusiguide.jsp������ֵ has_busiGuide =true  
				if($('#busiguide_'+busiGuide_opcode).size()==0)
			 		getBusiguide(opcode);
		}
		
		//���ݲ�����е���
		$("#step_"+opcode).children("div").each(
	      function(i){
          if((i+1)==Number(step)){//ѡ�в����Ϊ���ڽ���״̬
         	 	 $(this).removeClass();
         	 	 if($(this).children("img").size()>=2){
         	 	 		$(this).children("img:last").remove();
         	 	 }
         		 $(this).addClass('running');
         		 $(this).children("img:first").attr("src","<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/icon_nav.gif");
          }  

         	if((i+1)>Number(step)){//ѡ�в����ı�Ϊδ���״̬
             //��һ��ȫ����Ϊfresh--δ����ʱ
						 $(this).children("img:first").attr("src","<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/arrow_link_blue.gif");
	           $(this).removeClass();
	           $(this).addClass('fresh');
	           if($(this).children("img").size()>=2){
	           			$(this).children("img:last").remove();
	           }
					}
					
					if((i+1)<Number(step)){//ѡ��֮ǰ�Ĳ����Ϊ���״̬
						 //֮ǰ�Ķ����--finish
						 $(this).removeClass();
	           $(this).addClass('finish');
	           $(this).children("img:first").attr("src","<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/arrow_link_blue.gif");

						 if($(this).children("img").size()<2){
						 	  $(this).append("<img src=\"<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/icon_ok.gif\" style=\" margin-left:10px\" width=\"15\" height=\"15\"/>");
	         	 }
     		  }
       }
    );
  	//����TABҳ�Ƿ�رգ����ر������hideBusiguide�������ҵ����
  	$("#tabtag").children("#"+opcode).children("span").children("img").bind('click', function() {
 			 hideBusiguide(opcode);
		});
		
		//TABҳ�л�ʱ��ֻ��ʾ��ǰtab��
  	$("#tabtag").children("#"+opcode).bind('click', function() {
 			 $('#tbc_04').children('#busiguide_'+opcode).css("display","");
			 $('#tbc_04').children('#busiguide_'+opcode).siblings("div").css("display","none");
			 $('#busiguide_4').css("display","");
			 $('#tbc_04').css("display","");
			 $("#tbc_04").height("79%");
			 HoverNav('buGu');	
		});
	}

	/** modified by hejwa in 20110714 ��OP����--����ҵ���� end**/
	/** modified by hejwa in 20110916 ��OP����--�������񵯴� begin**/
var Message={
set: function() {//��С����ָ�״̬�л�
var set=this.minbtn.status == 1?[0,1,'block',this.char[0],'��С��']:[1,0,'none',this.char[1],'չ��'];
this.minbtn.status=set[0];
this.win.style.borderBottomWidth=set[1];
this.content.style.display =set[2];
this.minbtn.innerHTML =set[3]
this.minbtn.title = set[4];
this.win.style.top = this.getY().top;
},
close: function() {//�ر�
this.win.style.display = 'none';
window.onscroll = null;
},
setOpacity: function(x) {//����͸����
var v = x >= 100 ? '': 'Alpha(opacity=' + x + ')';
this.win.style.visibility = x<=0?'hidden':'visible';//IE�о��Ի���Զ�λ���ݲ��游͸���ȱ仯��bug
this.win.style.filter = v;
this.win.style.opacity = x / 100;
},//��ӭ����վ����Ч�������ǵ���ַ��www.zzjs.net���ܺüǣ�zzվ����js����js��Ч����վ�ռ�����������js���룬���������������ء�
show: function() {//����
clearInterval(this.timer2);
var me = this,fx = this.fx(0, 100, 0.1),t = 0;
this.timer2 = setInterval(function() {
t = fx();
me.setOpacity(t[0]);
if (t[1] == 0) {clearInterval(me.timer2) }
},10);
},//��ӭ����վ����Ч�������ǵ���ַ��www.zzjs.net���ܺüǣ�zzվ����js����js��Ч����վ�ռ�����������js���룬���������������ء�
fx: function(a, b, c) {//�������
var cMath = Math[(a - b) > 0 ? "floor": "ceil"],c = c || 0.1;
return function() {return [a += cMath((b - a) * c), a - b]}
},
getY: function() {//�����ƶ�����
var d = document,b = document.body, e = document.documentElement;
var s = Math.max(b.scrollTop, e.scrollTop);
var h = /BackCompat/i.test(document.compatMode)?b.clientHeight:e.clientHeight;
var h2 = this.win.offsetHeight;
return {foot: s + h + h2 + 2+'px',top: s + h - h2 - 2+'px'}
},
moveTo: function(y) {//�ƶ�����
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
}//��ӭ����վ����Ч�������ǵ���ַ��www.zzjs.net���ܺüǣ�zzվ����js����js��Ч����վ�ռ�����������js���룬���������������ء�
},10);
},
bind:function (){//�󶨴��ڹ��������С�仯�¼�
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
init: function() {//����HTML
function $(id) {return document.getElementById(id)};
this.win=$('msg_win');
var set={minbtn: 'msg_min',closebtn: 'msg_close',title: 'msg_title',content: 'msg_content'};
for (var Id in set) {this[Id] = $(set[Id])};
var me = this;
 
this.closebtn.onclick = function() {me.close()};
this.char=navigator.userAgent.toLowerCase().indexOf('firefox')+1?['_','::','��']:['0','2','r'];//FF��֧��webdings����
this.closebtn.innerHTML=this.char[2];
setTimeout(function() {//��ʼ������λ��
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

/** modified by hejwa in 20110916 ��OP����--�������񵯴� end**/
</script>
</body>
</html>
