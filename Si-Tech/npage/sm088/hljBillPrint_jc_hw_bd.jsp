<%
/********************
*version v3.0
*开发商: si-tech
*
*update:ZZ@2008-10-13 页面改造,修改样式
*1104,1238等模块使用过的弹出对话框
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<HTML>
<HEAD>
<TITLE>打印</TITLE>
<script type="text/javascript" src="/njs/extend/jquery/jquery123_pack.js"></script>
<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>

</HEAD>
<%@ include file="/npage/innet/splitStr.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%	
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regCode = (String)session.getAttribute("regCode");

	String phoneNo = request.getParameter("phoneNo");
	String billType = request.getParameter("billType");
	String v_accp = request.getParameter("v_accp");
	String v_opcode = request.getParameter("v_opcode");
	String v_opName = request.getParameter("v_opName");
	String v_opTime = request.getParameter("v_opTime");
	String iccidInfo = request.getParameter("iccidInfo")==null ? "|||":request.getParameter("iccidInfo");
	String accInfo = request.getParameter("accInfoStr")==null ? "|||":request.getParameter("accInfoStr");
	String begin_month=request.getParameter("begin_month")==null ? "":request.getParameter("begin_month");
	System.out.println("iccidInfo======="+iccidInfo+"=======");
	System.out.println("accInfo======="+accInfo+"=======");
	
	String loginacceptJTss = request.getParameter("loginacceptJT");
	if(!iccidInfo.equals("|")) {
				loginacceptJTss="";
	}
	
	String addprintTime  = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());//业务补打时间
%>
<%
	String groupId = (String)session.getAttribute("groupId");
	String getLoginInfo = "SELECT   msg.group_name, msg.GROUP_ID, msg.root_distance"
						+" FROM dchngroupmsg msg, dchngroupinfo info"
						+" WHERE msg.GROUP_ID = info.parent_group_id"
						+" AND info.GROUP_ID = '" + groupId + "'"
						+" AND msg.root_distance > 1"
						+" ORDER BY msg.root_distance";
%>
	<wtc:pubselect name="sPubSelect" outnum="3" routerKey="region" 
		 routerValue="<%=regCode%>" retcode="retCode5" retmsg="retMsg5">
		<wtc:sql><%=getLoginInfo%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="ret" scope="end"/>

<%		
	String provinceInfo="黑龙江|10014";
	String regionInfo="|";
	String areaInfo="|";
	String hallInfo="|";
	String orgInfos="";
	
	String inParams [] = new String[2]; 
	inParams[0]="select a.group_name,a.group_id  from dchngroupmsg a, dchngroupinfo b  where a.group_id = b.parent_group_id  and root_distance in (2,3,4)  and b.group_id =:groupids order by root_distance";
	inParams[1]="groupids="+groupId;
	 /*10118区县*/
	 /*12613营业厅*/
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/>
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
		if(!retCode1.equals("000000")) {
		%>
			<script language="JavaScript">
	    rdShowMessageDialog("查询工号归属信息失败！");
	    removeCurrentTab();
			</script>
		<%
		return;
		}
		if("10014".equals(groupId)) {
						
		}
		else {
					if(ret.length==1) {
							regionInfo=ret[0][0]+"|"+ret[0][1];
					}
					if(ret.length==2) {
							regionInfo=ret[0][0]+"|"+ret[0][1];
							areaInfo=ret[1][0]+"|"+ret[1][1];
					}
					if(ret.length==3) {
							regionInfo=ret[0][0]+"|"+ret[0][1];
							areaInfo=ret[1][0]+"|"+ret[1][1];
							hallInfo=ret[2][0]+"|"+ret[2][1];					
					}
		}
				
		orgInfos=provinceInfo+"^"+regionInfo+"^"+areaInfo+"^"+hallInfo;
		System.out.println("组织机构信息=="+orgInfos);	
		
		
		String passwd = ( String )session.getAttribute( "password" );
    String workChnFlag = "0" ;
%>
<wtc:service name="s1100Check" outnum="30"
	routerKey="region" routerValue="<%=regCode%>" retcode="rc" retmsg="rm" >
	<wtc:param value = ""/>
	<wtc:param value = "01"/>
	<wtc:param value = "<%=v_opcode%>"/>
	<wtc:param value = "<%=work_no%>"/>
	<wtc:param value = "<%=passwd%>"/>
		
	<wtc:param value = ""/>
	<wtc:param value = ""/>
</wtc:service>
<wtc:array id="rst" scope="end" />
<%
if ( rc.equals("000000") )
{
	if ( rst.length!=0 )
	{
		workChnFlag = rst[0][0];
	}
	else
	{
	%>
		<script>
			rdShowMessageDialog( "服务s1100Check没有返回结果!" );
			//removeCurrentTab();
		</script>
	<%	
	}
}
else
{
%>
	<script>
		rdShowMessageDialog( "<%=rc%>:<%=rm%>" );
		//removeCurrentTab();
	</script>
<%
} 
%>				
		
<SCRIPT type="text/javascript">
	
var checkhwflags="0";//电子工单监测标识 0成功 1失败
	
$(document).ready(function(){
		var groupInfoArr = new Array();
	<%
		for(int retIter = 0; retIter < ret.length; retIter++){
	%>
		groupInfoArr["<%=retIter%>"] = "<%=ret[retIter][0]%>" + "|" + "<%=ret[retIter][1]%>";
	<%
		}
	%>
	if(typeof(groupInfoArr[0]) != "undefined" && groupInfoArr[0] != ""){
		$("#regionName").val(groupInfoArr[0]);
	}else{
		$("#regionName").val("|");
	}
	if(typeof(groupInfoArr[1]) != "undefined" && groupInfoArr[1] != ""){
		$("#areaName").val(groupInfoArr[1]);
	}else{
		$("#areaName").val("|");
	}
	if(typeof(groupInfoArr[2]) != "undefined" && groupInfoArr[2] != ""){
		$("#hallName").val(groupInfoArr[2]);
	}else{
		$("#hallName").val("|");
	}
	
	$("table[vColorTr='set']").each(function(){
		$(this).find("tr").each(function(i,n){
			$(this).bind("mouseover",function(){
				$(this).addClass("even_hig");
			});
			$(this).bind("mouseout",function(){
				$(this).removeClass("even_hig");
			});
			if(i%2==0){
				$(this).addClass("even");
			}
		});
	});	
	
	doTest();

});

 var result = '', timeoutss = null, bhpsStatus = false;
		//校验电子工单状态
function updInfo(str){

     result = '';
	 timeoutss = null;
	 bhpsStatus = false
     
	    timeoutss = window.setTimeout(function(){
	        if (result != 'running'){
	        	rdShowMessageDialog("无纸化设备异常，请切换纸质打印3！",0);
	        }
	    }, 5000);//8秒超时



						$.ajax({   
						
            async:false,   
            url:'http://10.110.0.100:59000/TestOKServer',
            type: 'GET',   
            dataType: 'jsonp',   
            jsonp: 'callbackparam', //默认callback  
            timeout: 5000,   
            success: function(json) { //客户端jquery预先定义好的callback函数，成功获取跨域服务器上的json数据后，会动态执行这个callback函数   
								//alert(json.result);
								
							if(timeoutss != null){
							//alert("qinglile");
							  clearTimeout(timeoutss);//取消别的处理方式，无纸化返回了							
							}
							
								var resultstatus=json.result+"";
								result=resultstatus;
								//alert(json.name);
								//resultstatus="stop";
								//alert(resultstatus);
								if(resultstatus.trim()=="running") {
									checkhwflags="0";
									
		   if(str=="d")	{
		   						
  //调用普通打印程序
	var print_Packet = new AJAXPacket("/npage/public/fPubSavePrint_hw.jsp","正在打印，请稍候......");
	print_Packet.data.add("retType","print");
	print_Packet.data.add("phoneNo","<%=phoneNo%>");
	print_Packet.data.add("billType","<%=billType%>");
	print_Packet.data.add("login_accept","<%=v_accp%>");
	print_Packet.data.add("opCode","<%=v_opcode%>");
	print_Packet.data.add("begin_month","<%=begin_month%>");
	
	core.ajax.sendPacket(print_Packet,doHWTest);
	print_Packet=null;
	
	//tiantest 生产
	//document.spubPrint.action="http://10.110.0.100:59000/bp003.go?method=init";
	//测试环境测试用的：
	//document.spubPrint.action="http://10.110.13.52:8899/bp003.go?method=init";
	//测试 获取值
	//document.spubPrint.action="fm088print.jsp";
	//document.spubPrint.submit();
										
		     }else {
		     
    
		     
		     
		     }							
									
									
								}else {
									checkhwflags="1";
									//alert("1");
									 rdShowMessageDialog("无纸化设备异常，请切换纸质打印1！",0);
								}
            },   
  
            error: function(xhr){  
            	if(timeoutss != null){
							  clearTimeout(timeoutss);//取消别的处理方式，无纸化返回了							
							}             
  							//alert(1);
                checkhwflags="1";
                rdShowMessageDialog("无纸化设备异常，请切换纸质打印2！",0);
            }
               
        });   
 
		
	}
	
	
	

function doTest(){

 updInfo("d");
					     
}

	function returncheckflags(packet){
	  	var retCode=packet.data.findValueByName("retcode");
		  var retMsg=packet.data.findValueByName("retmsg");
		  if(retCode == "000000"){
		    checkhwflags="0";
		 	}else{
		 		rdShowMessageDialog("无纸化设备异常，请切换纸质打印！错误代码："+retCode+"，错误信息："+retMsg,0);
		 		checkhwflags="1";
		 	}
	}
	


function doreturnSave(packet)
{
  var retCode = packet.data.findValueByName("errCode");
  var retMessage = packet.data.findValueByName("errMsg");

  if(retCode=="000000"){
  
	//tiantest 生产
//	document.spubPrint.action="http://10.110.0.100:59000/bp003.go?method=init";
	//测试环境测试用的：
	document.spubPrint.action="http://10.110.13.52:8899/bp003.go?method=init";
	//测试 获取值
	//document.spubPrint.action="fm088print.jsp";
	document.spubPrint.submit();

	//返回打印确认信息
	window.returnValue= "confirm";
	window.close();
  
  
	} else {
			alert("错误代码："+retCode+"错误信息："+retMessage);
			window.close();
	}
}

function ReplaceDot(str)
{
  if(str!=null) { 
  str = str.replace(/"/g,"”")    
  } 
  return str; 
}

function doHWTest(packet){
  var retType = packet.data.findValueByName("retType");
  var retCode = packet.data.findValueByName("errCode");
  var retMessage = packet.data.findValueByName("errMsg");

  if(retCode=="000000"){
   		var impResultArr = packet.data.findValueByName("impResultArr");
   		var workInfoVal = "";
   		var custInfoVal = "";
   		var oprInfo1Val = "";
   		var noteInfo1Val = "";
   		if(impResultArr.length>0){
   			for(var ai = 0; ai < impResultArr.length; ai++){
					if(impResultArr[ai][1] == '1'){
						/* workInfo */
						workInfoVal = workInfoVal + impResultArr[ai][10] + "|";
					}else if(impResultArr[ai][1] == '2'){
						/* custInfo */
						custInfoVal = custInfoVal + impResultArr[ai][10] + "|";
					}else if(impResultArr[ai][1] == '3'){
						/* oprInfo1 */
						oprInfo1Val = oprInfo1Val + impResultArr[ai][10] + "|";
					}else{
						/* noteInfo1 */
						noteInfo1Val = noteInfo1Val + impResultArr[ai][10] + "|";
					}
				}
				$("#workInfo").val(workInfoVal);
				$("#custInfo").val(custInfoVal);
				$("#oprInfo1").val(oprInfo1Val);
				$("#noteInfo1").val(noteInfo1Val);
				if("<%=phoneNo%>"!="" && "<%=phoneNo%>"!="null") {
			  if("<%=v_opcode%>"=="1104") {
				var isGoddNo_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s1104/isGoodPhoneres.jsp","正在查询号码是否是特殊号码，请稍候......");
	 			isGoddNo_Packet.data.add("selNumValue","<%=phoneNo%>");
	 			core.ajax.sendPacket(isGoddNo_Packet,doIsGoodPhoneF);
	 			isGoddNo_Packet=null; 
	 			}
			}
			
			
			var parmxmlstr="<req>";
						 parmxmlstr+="<workNo>"+document.all.workNo.value+"</workNo>";
						 parmxmlstr+="<workName>"+document.all.workName.value+"</workName>";
						 parmxmlstr+="<orgInfo>"+document.all.orgInfos.value+"</orgInfo>";
						 parmxmlstr+="<channelType><%=workChnFlag%></channelType>";
						 parmxmlstr+="<groupTrans><%=loginacceptJTss%></groupTrans>";						 
						 parmxmlstr+="<phoneNo>"+document.all.phoneNo.value+"</phoneNo>";
						 parmxmlstr+="<opTime>"+document.all.opTime.value+"</opTime>";
						 parmxmlstr+="<workInfo>"+document.all.workInfo.value+"</workInfo>";
						 parmxmlstr+="<custInfo>"+document.all.custInfo.value+"</custInfo>";
						 parmxmlstr+="<email>"+document.all.email.value+"</email>";
						 parmxmlstr+="<addprtTime>"+document.all.addprtTime.value+"</addprtTime>";
						 parmxmlstr+="<accInfo>"+document.all.accInfo.value+"</accInfo>";
						 parmxmlstr+="<iccidInfo>"+document.all.iccidInfo.value+"</iccidInfo>";
						 parmxmlstr+="<iscrmUploadfile>"+document.all.iscrmUploadfile.value+"</iscrmUploadfile>";
						 parmxmlstr+="<userIdCard>"+document.all.custiccid1.value+"</userIdCard>";
						 parmxmlstr+="<comments>"+document.all.comments.value+"</comments>";
						 parmxmlstr+="<busiList><busiInfo>";
					   parmxmlstr+="<sysAccept>"+document.all.sysAccept.value+"</sysAccept>";
					   parmxmlstr+="<opCode>"+document.all.opCode.value+"</opCode>";
					   parmxmlstr+="<opName>"+document.all.opName.value+"</opName>";
					   parmxmlstr+="<oprInfo><![CDATA["+ReplaceDot(document.all.oprInfo1.value)+"]]></oprInfo>";
					   parmxmlstr+="<noteInfo><![CDATA["+ReplaceDot(document.all.noteInfo1.value)+"]]></noteInfo>";
						 parmxmlstr+="</busiInfo></busiList></req>";
						 
						 $("#params").val(parmxmlstr);
			
      
        var note_Packet111 = new AJAXPacket("/npage/innet/hljBillPrint_jc_upstatus.jsp","正在保存附件名，请稍候......");
				note_Packet111.data.add("login_accept","<%=v_accp%>");
				note_Packet111.data.add("opCode",'<%=v_opcode%>');
				note_Packet111.data.add("phoneNo",'<%=phoneNo%>');
				note_Packet111.data.add("billType",'<%=billType%>');	
				note_Packet111.data.add("opflag",'1');
				note_Packet111.data.add("opNote",'m088');
				note_Packet111.data.add("begin_month",'<%=begin_month%>');
				
				core.ajax.sendPacket(note_Packet111,doreturnSave);
				note_Packet111=null;
				
				
			
   		}else{
   			alert("打印错误!<br>错误代码："+retCode+"，错误信息："+retMessage+"。",0);
					//返回打印确认信息
				window.returnValue= "confirm";
				window.close();
   		}
		}else{
			alert("打印错误!<br>错误代码："+retCode+"，错误信息："+retMessage+"。",0);
			window.returnValue= "confirm";
			window.close();
		}
}

	function doIsGoodPhoneF(packet){
			var countGoodNo = packet.data.findValueByName("countGoodNo");
			if(countGoodNo!=0){  //靓号
			  $("#iscrmUploadfile").val("Y");    
				}else{
				$("#iscrmUploadfile").val("N"); 
		}
}

</SCRIPT>

<!--**************************************************************************************-->

<body style="overflow-x:hidden;overflow-y:hidden">
	<head>
		<title>黑龙江移动BOSS</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
	</head>
<FORM method=post name="spubPrint">
	<input type="hidden" name="orgInfos" value="<%=orgInfos%>">
  <input type="hidden" name="custiccid1" value="">
  
  <input  name="comments" id="comments"  type="hidden" value="" />
	<input  name="email" id="email"  type="hidden"  value="" />
	<input type="hidden" name="sysAccept" value="<%=v_accp%>">
	<input type="hidden" name="workNo" value="<%=work_no%>" >
	<input type="hidden" name="workName" value="<%=work_name%>" >
	<input type="hidden" name="phoneNo" value="<%=phoneNo%>" >
	<input type="hidden" name="opTime" id="opTime" value="<%=v_opTime%>" > <%/* 办理业务时的日期 */%>
	<input type="hidden" name="addprtTime" id="addprtTime" value="<%=addprintTime%>" ><%/* Boss补打工单时间 */%>
	<input type="hidden" name="opCode" id="opCode" value="<%=v_opcode%>" >
	<input type="hidden" name="opName" id="opName" value="<%=v_opName%>" >
	<input type="hidden" name="workInfo" id="workInfo" value="" >
	<input type="hidden" name="custInfo" id="custInfo" value="" >
	
	<input type="hidden" name="oprInfo1" id="oprInfo1" value="" >
	<input type="hidden" name="noteInfo1" id="noteInfo1" value="" >
	
	<input type="hidden" name="relnum" value="1" >
	
	<input type="hidden" name="hallName" id="hallName" value="" >
	<input type="hidden" name="areaName" id="areaName" value="" >
	<input type="hidden" name="regionName" id="regionName" value="" >
	
	<input type="text" name="iccidInfo" value="<%=iccidInfo%>" >
	<input type="hidden" name="accInfo" value="<%=accInfo%>" >
	<input type="hidden" name="iscrmUploadfile" id="iscrmUploadfile" >
	<input type="text" name="params" id="params" value="" >
	<input type="text" id="groupTrans" name="groupTrans" value="<%=loginacceptJTss%>">

</FORM>
<!-- 加载 handwrite 虚拟打印控件 -->
<%@ include file="/npage/innet/pubHWPrint.jsp" %>
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.cab#version=1,1,0,3"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>
<object id='AGILEPOST' height='20%' width='20%' style='DISPLAY: none'
		classid='clsid:24018177-CAA4-4E5F-BFD2-577B1B4EA4FB' >
	</object>
</BODY>

</HTML>
