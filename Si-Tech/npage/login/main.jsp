<%
   /*
   * ����: ϵͳ�����
�� * �汾: v1.0
�� * ����: 2009-11-05
�� * ����: wuln/hujie
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����:2010-04-27      	�޸���:liubo      �޸�Ŀ��:���������
   * �޸�����:2011-07-27      	�޸���:hejwa      �޸�Ŀ��:��op����
   * �޸�����:2012-12-10       	�޸���:hejwa      �޸�Ŀ��:������NG3.5��Ŀ
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page errorPage="../common/errorpage.jsp" %>
<%
	System.out.println("---------------main---------------huangqi---------------(String)request.getParameter(Token---------"+(String)request.getParameter("Token"));
	System.out.println("---------------main---------------huangqi---------------(String)request.getParameter(Token---------"+(String)session.getAttribute("token4a"));

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
String layout = (String)session.getAttribute("layout")==null?"2":(String)session.getAttribute("layout");		
%>

<%-- /**  modified by hejwa in 20110714 ��OP����--����tabҳ  begin **/ --%>
<%
System.out.println("--------hejwa--op----------cssPath---------------"+cssPath);
String tabSql = "select to_char(open_max) from dwkspace where login_no=:workNo";
String tabParam = "workNo="+workNo;
//��¼���һ�ι��������ã����¼��OP��¼��־��
String duoOPLoginAccept = session.getAttribute("duoOPLoginAccept")==null?"":(String)session.getAttribute("duoOPLoginAccept");
	if("".equals(duoOPLoginAccept)){
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//��ɫ����
	String ismopRoleSql = "select m_rolecode from DMOPROLERELA where b_rolecode=:powerCode";
	String ismopRoleSqlparam = "powerCode="+powerCode;
	%>
		
				<wtc:service name="TlsPubSelCrm" outnum="1"  routerKey="region" routerValue="<%=regionCode%>" >
					<wtc:param value="<%=ismopRoleSql%>"/>
				  	<wtc:param value="<%=ismopRoleSqlparam%>"/>
				</wtc:service>
				<wtc:array id="result_isRole" scope="end" />
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
		System.out.println("---hejwa--op----------------tabReturn.length------------"+tabReturn.length);
			if(tabReturn.length>0){
				tabOpenMax = tabReturn[0][0];
			}
		}
		System.out.println("---hejwa--op----------------tabOpenMax------------------"+tabOpenMax);
		if(tabOpenMax==null||"".equals(tabOpenMax.trim())){
			tabOpenMax = "10";
		}
		
String taskTcSql = "select to_char(login_accept) from dTaskmsg where login_no=:login_no and to_char(seldate,'yyyyMMdd') = to_char(sysdate,'yyyyMMdd')";		
String taskTcSqlparam = "login_no="+login_no;
%>
<%-- /**  modified by hejwa in 20110714 ��OP����--����tabҳ  end **/ --%>
 
 				<wtc:service name="TlsPubSelCrm" outnum="2"  retmsg="msg" retcode="code"   routerKey="region" routerValue="<%=regionCode%>" >
					<wtc:param value="<%=taskTcSql%>"/>
				  	<wtc:param value="<%=taskTcSqlparam%>"/>
				</wtc:service>
				<wtc:array id="result_taskm" scope="end" />
<%
String taskFlag = "";
if(result_taskm.length>0){
	taskFlag = result_taskm[0][0];
}
%>
<html xmlns="http://www.w3.org/1999/xhtml">		
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<title>�й��ƶ��ͻ���ϵ����ϵͳ</title>
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/framework.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/rightmenu.css" rel="stylesheet" type="text/css" />
	<%-- /**  modified by hejwa in 20110714 ��OP����--ҵ����  begin **/ --%>
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/busiguide.css" rel="stylesheet"type="text/css">
	<link href="/nresources/<%=cssPath%>/css/ng35.css" rel="stylesheet" type="text/css"></link><!--hejwa ���� ng3.5��ʽ-->
	<%-- /**  modified by hejwa in 20110714 ��OP����--ҵ����  end **/ --%>
	<style>
		#imgLeftRight{
			position:absolute;
			left:0px;
			top:300px;
			height:50px;
			width:6px;	
			z-index:10000;
		}
		
		
#msg_win{border:1px solid #A67901;background:#EAEAEA;width:240px;position:absolute;right:0;font-size:12px;font-family:Arial;margin:0px;display:none;overflow:hidden;z-index:99;}
#msg_win .icos{position:absolute;top:2px;*top:0px;right:2px;z-index:9;}
.icos a{float:left;color:#833B02;margin:1px;text-align:center;font-weight:bold;width:14px;height:22px;line-height:22px;padding:1px;text-decoration:none;font-family:webdings;}
.icos a:hover{color:#fff;}
#msg_title{background:#FECD00;border-bottom:1px solid #A67901;border-top:1px solid #FFF;border-left:1px solid #FFF;color:#000;height:25px;line-height:25px;text-indent:5px;}
#msg_content{margin:5px;margin-right:0;width:230px;height:126px;overflow:hidden;}

	</style>
</head>
<body>		
	<!--topPanel begin-->
	<%@ include file="../module/topPanel.jsp"%>
	<!-- �洢ajax���÷��ص�html -->
	<div id="ajaxResult" style="display:none"></div>
	<!--topPanel end-->

	<!--searchPanel begin-->
	<%@ include file="../module/searchPanel.jsp"%>
	<!--searchPanel end-->
	
	<!--ContentArea bengin-->
	<div id="contentPanel">
		
		<!--navPanel begin-->
		<%@ include file="../module/navPanel.jsp"%>
		<!--navPanel end-->
		<div id="borderWorkAndNav"></div>
		<!--workPanel begin-->
		<%@ include file="../module/workPanel.jsp"%> 
		<!--workPanel end-->
	</div>
	<!--footPanel begin-->
	<%@ include file="../module/footPanel.jsp"%>
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
	<div id="msg_content">�������д���������<a href="#" onclick="showTask()">�鿴</a>��5���رգ�</div>
</div>

<script src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/system/system.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/plugins/autocomplete.js"  type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/plugins/tabScript_jsa.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/plugins/MzTreeView12.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/redialog/redialog.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
var flagtree;
var iCustId = "";
var iPhoneNo = "index";
var iBroadPhone = "broadPhone";
var busiGuide_opcode = "";
/**********
document.oncontextmenu=new Function("event.returnValue=false");
document.onkeydown = function(){ 
	if (event.ctrlKey && window.event.keyCode==67){ 
		return false; 
	} 
	if (event.ctrlKey && window.event.keyCode==86){ 
		return false; 
	} 
} 
*********/
//��ѯһ���˵�
function loadFirstMenu(){
	var packet =  new AJAXPacket("ajax_queryFirstMenu.jsp");
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
/**------ng3.5 ��Ŀ hejwa add ӪҵԱ������¼����----ng3.5��Ŀ��ʼ-----
  ���   phone_no��ӪҵԱ�������ֻ���
				 opr_type���������ͣ�0=��ѯ 1=���� 2=�޸� 3=ɾ��
				 opr_funccode:ӪҵԱ������opcode
				 opr_recode��������¼����������ѯ��ť
*/
function oprInfoRecode(phone_no,opr_type,opr_funccode,opr_recode,recodeId){
	//alert("oprInfoRecode#\nphone_no|"+phone_no+"\nopr_type|"+opr_type+"\nopr_funccode|"+opr_funccode+"\nopr_recode"+opr_recode+"\nrecodeId|"+recodeId);
	if(typeof(recodeId)=="undefined") recodeId = "";
	var packet =  new AJAXPacket("<%=request.getContextPath()%>/npage/oprInfoQry/ajaxOprInfoRecode.jsp");
	packet.data.add("recodeId" ,recodeId);
	packet.data.add("phone_no" ,phone_no);
	packet.data.add("opr_type" ,opr_type);
	packet.data.add("opr_funccode" ,opr_funccode);
	packet.data.add("opr_recode" ,opr_recode);
	core.ajax.sendPacket(packet,doOprInfoRecode);
	packet = null;
	return $("#recodeId_hid").val();
}
function doOprInfoRecode(packet){
	var recodeId = packet.data.findValueByName("recodeId");
	$("#recodeId_hid").val(recodeId)
}
//alt+x�л�tab
function altD_tab(){
	var currentObj = $("#tabtag").find("li[className='current']");
	var nextId = currentObj.next().attr("id");
	if(typeof(nextId)!="undefined"){
		//currentObj.attr("class","on");
		//currentObj.next().attr("class","current");
	}else{
		var firstObj = currentObj.parent().children(":first");
		      nextId = firstObj.attr("id");
		if(typeof(nextId)!="undefined"){
			//currentObj.attr("class","on");
			//firstObj.attr("class","current");
			nextId = "index";
		}
	}
	//alert("nextId|"+nextId);
	document.getElementById(nextId).click();
}
function altC_tab(){
	var currentId = $("#tabtag").find("li[className='current']").attr("id");
	if(typeof(currentId)!="undefined"){
		removeTab(currentId);
	}
}

//վ���ͼ
function func_map(){
L("1","NG35MAP","վ���ͼ","login/ng35funmap.jsp","000");
}

function tofuncMain(openflag,opcode,title,targetUrl,valideVal){
	//alert("tofunc#\nopenflag|"+openflag+"\nopcode|"+opcode+"\nopname|"+title+"\ntargetUrl|"+targetUrl+"\nvalideVal|"+valideVal);
	if(openflag=="1"){
		L(openflag,opcode,title,targetUrl,valideVal);
	}else{
		//�ж��Ƿ��й��ﳵ��ҳ��
		var custMainId =  $("#tabtag").find("li[id^='custid']").attr("id");
		if(typeof(custMainId)!="undefined"){
			document.getElementById(custMainId).click();
		}
		L(openflag,opcode,title,targetUrl,valideVal);
	}
}
//----------------ng3��5��Ŀ����---------------------------------------


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
		iframe[i].style.height=(workPanelHeight-tabHeight)+"px";
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
		$(".dis, .dis2").height($("#navPanel").height()-$(".title").height()-$(".search_bar").height()-marginHeight-14);
	}else{
		$(".search_bar").hide();
		$(".dis, .dis2").height($("#navPanel").height()-$(".title").height()-marginHeight-14);
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
//�������˳�ϵͳ
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
    window.showModalDialog("logout.jsp","",prop);
    window.opener=null;
    window.open('','_self');
    window.close();
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
								addTab(true,phoneNo,phoneNo,'childTab2.jsp?activePhone='+phoneNo);
						  }else{
								rdShowMessageDialog("�ֻ�������Ϣ����ȷ,��Tabҳ����!");
				      }
				      $("#phoneNo").val("�������ֻ�����");
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

function sTrueCodeQry_JsFunc(phoneNo,custType){
	if(custType == "1"){//ʵ���ƽ���ֻ�����ֻ�������
		var packet = new AJAXPacket("sTrueCodeQry.jsp");
			packet.data.add("phoneNo" ,phoneNo);
			core.ajax.sendPacket(packet,doSTrueCodeQry_JsFunc,true);
			packet =null;
	}
}
function doSTrueCodeQry_JsFunc(packet){
	var retCode = packet.data.findValueByName("code");
	var retMsg  = packet.data.findValueByName("msg");
	var result  = packet.data.findValueByName("result");
	if(retCode=="000000"){
		if(result!="1"){
			rdShowMessageDialog("�����ʵ���Ǽǣ�����ͻ����ϡ�");
		}
	}else{
		rdShowMessageDialog("ʵ���Ʋ�ѯʧ�ܣ�"+retCode+"��"+retMsg);
	}
}

/**
	* hejwa ����ע�� 2015/5/12 9:42:53
	* custType  1 = �ֻ����� 10 = ��ͥ���� 9 = ������ 8 = ���
	* enterType button = ���������ͼ�� undefined = ֱ�ӻس�
	**/

function addTabBySearchCustName(custType,enterType)
{
	//alert("custType = "+custType+"\nenterType = "+enterType);
			/*yanpx ע��
			var tabSize = $("#contentArea iframe").size();
			for(var i=0;i<tabSize;i++)
			{
				if($("#contentArea iframe")[i].id.length>12)
				{
					if($("#contentArea iframe")[i].id.substring(0,12)=="iframecustid")
					{
						rdShowMessageDialog("������굱ǰ�ͻ������������ͻ�");
						return false;
					}
				}
			}
			*/
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
			/*
			gaopeng 2013/4/2 ���ڶ� 15:58:27 �����߼��жϣ�����������10648��ͷ�ĵ绰����
			����ô���ú����ͷ��(10648)�޸�Ϊ205,�����147��ͷ���ĳ�206 start
			*/
			//alert(loginType);
			//alert(phoneNo);
			if(loginType=="9")
			{
				loginType="1";
				/*
				loginType="1";
				if(phoneNo.substring(0,5)=="10648")
				{
					phoneNo="205"+phoneNo.substring(5,phoneNo.length);
				}
				else if(phoneNo.substring(0,3)=="147")
				{
					phoneNo="206"+phoneNo.substring(3,phoneNo.length);
				}
				*/
				/*2015/9/18 9:26:02 gaopeng  ���ڶ��������ʷѲ��������Ĭ���Ż��ĺ�
					�޸�Ϊ���÷���sm317Cfm����ѯת����ĺ���
				*/
				
				var myPacket = new AJAXPacket("/npage/public/pubGetWLWPhoneNo.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
				
			  myPacket.data.add("opCode","");
			  myPacket.data.add("phoneNo",phoneNo);
			  
			  
			  core.ajax.sendPacket(myPacket,function(packet){
			  	var retCode=packet.data.findValueByName("retCode");
				  var retMsg=packet.data.findValueByName("retMsg");
				  var phoneNoRet=packet.data.findValueByName("phoneNoRet");
				  if(retCode == "000000"){
				  	phoneNo = phoneNoRet;
				 	}else{
						
				 	}
			  });
			  myPacket = null;
				
			}
				/*
			gaopeng 2013/4/2 ���ڶ� 15:58:27 �����߼��жϣ�����������10648��ͷ�ĵ绰����
			����ô���ú����ͷ��(10648)�޸�Ϊ205,�����147��ͷ���ĳ�206 end
			*/
			var packet = new AJAXPacket("getCustId.jsp");
			packet.data.add("phoneNo" ,phoneNo);
			packet.data.add("loginType" ,loginType);
			core.ajax.sendPacket(packet,doGetCustId,true);
			packet =null;
		}
		
		function doGetCustId(packet)
		{
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var custIdArr = packet.data.findValueByName("custIdArr");
			var custNameArr = packet.data.findValueByName("custNameArr");
			var phone_no = packet.data.findValueByName("phone_no");
			
			/* ningtn ��ͨ��� */
			var broadPhone = packet.data.findValueByName("broadPhone");			
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
			
			/*
			 * ���ڽ�һ����ǿʡ��֧��ϵͳʵ�����Ǽǹ��ܵ�֪ͨ
			 * hejwa add 2015/5/12 9:47:14
			 * �����ֻ������(����ͼ����������ֻ����뵯������)������û��Ƿ�ʵ������׼ʵ���û����򵯳���ʾ��
		   * ��ʾ��ϢΪ�������ʵ���Ǽǣ�����ͻ����ϡ���˵����ֻ����ʾ���������ơ�
			 */
			 var m_phone_no = phone_no+"";
			 if(m_phone_no.length >4){
			 	if(m_phone_no.substring(0,3)!="209"){//209��ͷ�����ֻ���
			 		sTrueCodeQry_JsFunc(m_phone_no,loginType);
				}
			 }
			 
					if(custIdArr.length==1)
					{
						$("#isse276").val("0");
						parent.openCustMain(custIdArr,phone_no,loginType,phone_no,broadPhone);
					}else
					{
						var path="selectCustId.jsp?opName=ѡ��ͻ�&custIdArr="+custIdArr+"&custNameArr="+custNameArr+"&custIccid="+custIccidJ+"&custCtime="+custCtimeJ+"&loginType="+loginType;
						//openDivWin(path,'ѡ��ͻ�','600','400');
						window.open(path,"newwindow","height=600, width=600,top=50,left=250,scrollbars=yes, resizable=no,location=no, status=yes");
					}
					
		
			}
			 
			$("#phoneNo").val("��������Ϣ���в�ѯ");
		}
function openCustMain(custId,custName,loginType,phone_no,broadPhone)
{
    iCustId = custId;
	if($("#contentArea iframe").size() <= <%=tabOpenMax%>){
		addTab(true,"custid"+custId,custName,'childTab2.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&activePhone='+phone_no+'&broadPhone='+broadPhone);
		$("#phoneNo").val("��������Ϣ���в�ѯ").blur();
		//document.all.phoneNo.blur();
		//layoutSwitch(1,$(".a1")[0]);
	}else{
		rdShowMessageDialog("ֻ�ܴ�<%=tabOpenMax%>��һ��tab");
	}
}
/* ����
function openCustMain(custId,custName,loginType,phone_no,signUser,id_no)
{
	showWinCover();
	if($("#contentArea iframe").size() < 11){
		addTab(true,"custid"+custId,formatString(custName),'childTab.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&signUser='+signUser+"&idNo="+id_no+"&isMarket=true");
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
		addTab(true,"custid"+custId,formatString(custName),'childTab.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&contactId='+contactId+'&idNo='+idNo+'&opType='+opType);
		
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
		addTab(true,"custid"+custId,custName,'childTab.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&signUser='+signUser+'&unsetFrom='+unsetFrom+'&idNo='+idNo);
		
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
		addTab(true,"custid"+custId,custName,'childTab2.jsp?gCustId='+custId+'&custOrderId='+custOrderId);
		$("#phoneNo").val("��������Ϣ���в�ѯ");
		//document.all.phoneNo.blur();
		//layoutSwitch(1,$(".a1")[0]);
	}else{
		rdShowMessageDialog("ֻ�ܴ�<%=tabOpenMax%>��һ��tab");
	}
}

function doChangeType(obj){
    var type = obj.value;
    if(type == "0"){
        $("#iCustName").val("������ͻ�ID���в�ѯ");
    }else if(type == "1"){
        $("#iCustName").val("�������ֻ������ѯ");
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

function newCustF(){
		L("1","1100","�ͻ�����","sq100/sq100_1.jsp","000");
	}
function dnyCreatDiv(cust_id,phone_no,broadPhone){
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
		/* ningtn ��ͨ�ں�*/
    if(broadPhone != null && typeof(broadPhone)!="undefined"){
    	/* ����ͨ�˺ţ������� */
    	newE.broadPhone = broadPhone;
    }
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
		$("#buGu").removeClass("on");
		$('#system_search_result').hide();
		getFavFunc(flag);
	}else if(flag =="tree"){
		$("#getTree").addClass("on");
		$("#getFavFunc").removeClass("on");
		$("#getAllTree").removeClass("on");
		$("#buGu").removeClass("on");
		$('#system_search_result').hide();
		getTree(parentNode,parentName);
	}else if(flag =="alltree"){
		$("#getAllTree").addClass("on");
		$("#getTree").removeClass("on");
		$("#getFavFunc").removeClass("on");
		$("#buGu").removeClass("on");
		$('#system_search_result').hide();
		getTree(parentNode,parentName);
	}else if(flag =="buGu"){
		$("#buGu").addClass("on");
		$("#getTree").removeClass("on");
		$("#getAllTree").removeClass("on");
		$("#getFavFunc").removeClass("on");
		setNav('N');
		$('#system_search_result').hide();
		$("#wait").hide();
	}else if(flag =="authorizetree"){
		//$("#buGu").addClass("on");
		$("#getTree").removeClass("on");
		$("#getAllTree").removeClass("on");
		$("#getFavFunc").removeClass("on");
		$('#system_search_result').hide();
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
$(function(){
	$(".goup").click(function(){
		rolObj = $(".leftmenu");
		var Topnum = rolObj.css("top");
		Topnum = parseInt(Topnum.replace("px", ""));
		rolObj.animate({top:Topnum-100},300);
	});
	
	$(".godown").click(function(){
		rolObj = $(".leftmenu");
		var Topnum = rolObj.css("top");
		Topnum = parseInt(Topnum.replace("px", ""));
		rolObj.animate({top:Topnum+100},300);
		
		Topnum = rolObj.css("top");
		Topnum = parseInt(Topnum.replace("px", ""));
		if(Topnum>-1){
			rolObj.animate({top:0},300);
		}
	});

	$("div.secondbox div a").live("click", function(){
		$(this).closest("div.secondbox").hide();
		$(this).closest("li").removeClass("on");
	});
});
function getTree(parentNode,parentName)
{
	var treenode = document.getElementById("node"+parentNode);
	if(treenode == null)
	{
		treenode = document.createElement("div");	
		treenode.setAttribute("id","node"+parentNode);		
		var packet;
		if(parentNode=="99001"){
			treenode.setAttribute("className","dis");
			flagtree=parentNode;
		  packet = new AJAXPacket("ajax_getmenu.jsp");
		}else{
			treenode.setAttribute("className","dis2");
			flagtree=parentNode;
		  packet = new AJAXPacket("getTree.jsp");
		}
		$(".navMain")[0].appendChild(treenode);
		packet.data.add("parentNode" ,parentNode);
		packet.data.add("parentName" ,parentName);
		core.ajax.sendPacketHtml(packet,doGetTree);
		packet =null;
	}else{
		setNav("tree");
		if(parentNode=="99001"){
			treenode.className="dis";
			flagtree=parentNode;
		}else{
			treenode.className="dis2";
			flagtree="99999";
		}
		$("#wait").hide();
	}
}
 
function doGetTree(data)
{
	setNav("tree");
	$("#wait").hide();
	var currnode ;
	$.each( $(".navMain > div"), function(i, n){
		  if($(".navMain > div")[i].className=="dis" || $(".navMain > div")[i].className=="dis2")
		  {
		  	currnode=$(".navMain > div")[i].id;
		  	return false;
		  }
	});

	if(flagtree=="99001" )  {
		$("#"+currnode)[0].className="dis";
		$("#"+currnode).html(data+"<s class='goup'></s>"+"<s class='godown'></s>");
	}else{
		$("#"+currnode)[0].className="dis2";
		$("#"+currnode).html(data);
	}
	

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
		showDialog(retMsg,0,"detail="+retMsg);
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
	iPhoneNo = "";
	iPhoneNo = document.getElementById(g_activateTab.substring(6,g_activateTab.length)).phone_no;
			iBroadPhone = "";
			iBroadPhone = document.getElementById(g_activateTab.substring(6,g_activateTab.length)).broadPhone;
   }
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
		iPhoneNo = ""; 
		}
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
 	window.onunload=function(){
 	  if(isExit!=="1"){
 			closeWindow();
 		}
 	}
 	
 	window.onresize = function(){
		initPanel($("#layoutStatus").val());
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
	//	alert(openflag+"|"+opcode+"|"+title+"|"+targetUrl+"|"+valideVal);

		//first tab
		if(openflag=="1")
		{
			chkIsValidate(valideVal,"",opcode);
			
			if(targetUrl!="#"){
				targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title);
			//	alert(targetUrl);
				if($("#contentArea iframe").size() <= <%=tabOpenMax%>){
					if(allCheck4A(opcode)){
						addTab(true,opcode,title,targetUrl);
					}
				}else{
					rdShowMessageDialog("ֻ�ܴ�<%=tabOpenMax%>��һ��tab",1);
				}
			}
		}
		//second tab
		else if(openflag=="2")
		{
			/*2014/07/09 12:53:31 gaopeng ��ӡ�ӹ������ֻ�����
			alert("iPhoneNo=="+iPhoneNo+"---opcode="+opcode);
			*/
		    if(iPhoneNo == "index"&&opcode!="1104"&&opcode!="m275"&&opcode!="q046"&&opcode!="4603"&&opcode!="4100"&&opcode!="7518"&&opcode!="4977"&&opcode!="g629"&&opcode!="g784"&&opcode!="g785"&&opcode!="m028"&&opcode!="m094"){
		       	
		        rdShowMessageDialog("�������ֻ�����!");
				    $("#iCustName").select();
				    return;
		    }
		    if(iPhoneNo == "custMain"){
		        rdShowMessageDialog("��ѡ��һ���û�!");
				    return;
		    }
		    if(iPhoneNo==""&&opcode!="1104"&&opcode!="m275"&&opcode!="q046"&&opcode!="4603"&&opcode!="4100"&&opcode!="7518"&&opcode!="4977"&&opcode!="g629"&&opcode!="g784"&&opcode!="g785"&&opcode!="m028"&&opcode!="m094"){
		        
		        rdShowMessageDialog("�������ֻ�����!");
				    return;		    	
		    }
		    
			//var patrn=/^((\(\d{3}\))|(\d{3}\-))?[12][03458]\d{9}$/;
			//if(g_activateTab.search(patrn)!=-1){
					chkIsValidate(valideVal,iPhoneNo,opcode);
					//if(isValidateFlag == false) {
					if( false) {	
						var path = "<%=request.getContextPath()%>/npage/public/publicValidate.jsp";
						path =  path + "?valideVal="   + valideVal;
						path =  path + "&titleName="   + title;
						path =  path + "&activePhone=" + iPhoneNo;
						path =  path + "&opCode=" + opcode;
						path =  path + "&nowTimeee=" + Math.random();
						var validateResult = window.showModalDialog(path,"","dialogWidth=450px;dialogHeight=250px");
						if((validateResult=="undefined")||(validateResult!="1")){
							return;
						}
					}
					targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title);
					targetUrl = targetUrl+"&activePhone="+iPhoneNo;
					targetUrl = targetUrl+"&broadPhone="+iBroadPhone;
          /**  modified by hejwa in 20110730 ��OP����--���ֻ��Źرպ�bug  begin **/
          //tab����Ϊ�� ��g_activateTabΪopcode��ʱ�򳤶ȿ϶�С��10
          if(document.getElementById("iframe"+g_activateTab)!=null&&typeof(document.getElementById("iframe"+g_activateTab))!= "undefined"&&(g_activateTab.indexOf("custid")!=-1||g_activateTab.length >10) ){
          	if(allCheck4A(opcode)){
          		document.getElementById("iframe"+g_activateTab).contentWindow.addTab(false,opcode,title,targetUrl);
          	}
          }else{
          	
          	rdShowMessageDialog("�������ֻ�����!");   
			$("#iCustName").select();                 
          }
          /**  modified by hejwa in 20110730 ��OP����--���ֻ��Źرպ�bug  begin **/
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
	  	if($("#contentArea iframe").size() <= <%=tabOpenMax%>){
			}else{
				showDialog("ֻ�ܴ�<%=tabOpenMax%>��һ��tab",1);
				return false;
			}
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
	  //	  alert(targetUrl);
	  	  if(allCheck4A(opcode)){
	  		var win= window.open(targetUrl,opcode,"width="+screen.availWidth+",height="+screen.availHeight+",top=0,left=0,scrollbars=yes,resizable=yes,status=yes");
        
        	addWinName(win,opcode);
        	
      	}
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

			
			$("#isse276").val("0");
			loadFirstMenu();//����һ���˵�
			HoverMenu('oli','li');//��ʼ���˵�,��һ���˵��¼�,����getTree
			HoverNav("fav");
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
    		setTimeout("timefunc()",5000);
    		setTimeout("timefuncs()",10000);
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
//��ʱ�ر�
function timefuncs(){
	$("#msg_win").hide();
}
function timefunc(){
	if("<%=taskFlag%>"!=""){
		$("#msg_win").show();
		Message.init();
	}else{
		$("#msg_win").hide();
	}
}
function showTask(){
	window.open("<%=request.getContextPath()%>/npage/portal/work/showPrompt.jsp?promptSeq=<%=taskFlag%>",'_blank','height=300,width=500,top=300,left=500,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
}

function addTabBySearchCustName2(custType,enterType)
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
			/*
			gaopeng 2013/4/2 ���ڶ� 15:58:27 �����߼��жϣ�����������10648��ͷ�ĵ绰����
			����ô���ú����ͷ��(10648)�޸�Ϊ205,�����147��ͷ���ĳ�206 start
			*/
			//alert(loginType);
			//alert(phoneNo);
			if(loginType=="9")
			{
				loginType="1";
				/*
				loginType="1";
				if(phoneNo.substring(0,5)=="10648")
				{
					phoneNo="205"+phoneNo.substring(5,phoneNo.length);
				}
				else if(phoneNo.substring(0,3)=="147")
				{
					phoneNo="206"+phoneNo.substring(3,phoneNo.length);
				}
				*/
				/*2015/9/18 9:26:02 gaopeng  ���ڶ��������ʷѲ��������Ĭ���Ż��ĺ�
					�޸�Ϊ���÷���sm317Cfm����ѯת����ĺ���
				*/
				
				var myPacket = new AJAXPacket("/npage/public/pubGetWLWPhoneNo.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
				
			  myPacket.data.add("opCode","");
			  myPacket.data.add("phoneNo",phoneNo);
			  
			  
			  core.ajax.sendPacket(myPacket,function(packet){
			  	var retCode=packet.data.findValueByName("retCode");
				  var retMsg=packet.data.findValueByName("retMsg");
				  var phoneNoRet=packet.data.findValueByName("phoneNoRet");
				  if(retCode == "000000"){
				  	phoneNo = phoneNoRet;
				 	}else{
						
				 	}
			  });
			  myPacket = null;
				
			}
				/*
			gaopeng 2013/4/2 ���ڶ� 15:58:27 �����߼��жϣ�����������10648��ͷ�ĵ绰����
			����ô���ú����ͷ��(10648)�޸�Ϊ205,�����147��ͷ���ĳ�206 end
			*/
			var packet = new AJAXPacket("getCustId.jsp");
			packet.data.add("phoneNo" ,phoneNo);
			packet.data.add("loginType" ,loginType);
			core.ajax.sendPacket(packet,doGetCustId2,true);
			packet =null;
		}
		
		function doGetCustId2(packet)
		{
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var custIdArr = packet.data.findValueByName("custIdArr");
			var custNameArr = packet.data.findValueByName("custNameArr");
			var phone_no = packet.data.findValueByName("phone_no");
			
			/* ningtn ��ͨ��� */
			var broadPhone = packet.data.findValueByName("broadPhone");			
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
			
			/*
			 * ���ڽ�һ����ǿʡ��֧��ϵͳʵ�����Ǽǹ��ܵ�֪ͨ
			 * hejwa add 2015/5/12 9:47:14
			 * �����ֻ������(����ͼ����������ֻ����뵯������)������û��Ƿ�ʵ������׼ʵ���û����򵯳���ʾ��
		   * ��ʾ��ϢΪ�������ʵ���Ǽǣ�����ͻ����ϡ���˵����ֻ����ʾ���������ơ�
			 */
			 var m_phone_no = phone_no+"";
			 if(m_phone_no.length >4){
			 	if(m_phone_no.substring(0,3)!="209"){//209��ͷ�����ֻ���
			 		sTrueCodeQry_JsFunc(m_phone_no,loginType);
				}
			 }
			 
					if(custIdArr.length==1)
					{
						$("#isse276").val("1");
						parent.openCustMain(custIdArr,phone_no,loginType,phone_no,broadPhone);
						
					}else
					{
						var path="selectCustId.jsp?opName=ѡ��ͻ�&custIdArr="+custIdArr+"&custNameArr="+custNameArr+"&custIccid="+custIccidJ+"&custCtime="+custCtimeJ+"&loginType="+loginType;
						//openDivWin(path,'ѡ��ͻ�','600','400');
						window.open(path,"newwindow","height=600, width=600,top=50,left=250,scrollbars=yes, resizable=no,location=no, status=yes");
					}
					
		
			}
			 
			$("#phoneNo").val("��������Ϣ���в�ѯ");
			
		}

/** modified by hejwa in 20110916 ��OP����--�������񵯴� end**/
</script>	
<input type="hidden" id="recodeId_hid" name="recodeId_hid" value="" />
<input type="hidden" id="isse276"/>
<input type="hidden" id="se276ziFei"/>
<input type="hidden" id="se276diZhi"/>
<!-- 2014/12/26 14:47:50 gaopeng �������ƽ��ģʽ�����������Ϣģ���������� ���빫��ҳ�� openType����������ͨ���У��Ͷ����๫��У��-->
<jsp:include page="/npage/public/intf4A/common/intfCommon4A.jsp">
	<jsp:param name="openType" value="NORMAL"  />
</jsp:include>
</body>
</html>