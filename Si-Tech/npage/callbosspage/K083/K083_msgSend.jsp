<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 短信发送
　 * 版本: 1.0
　 * 日期: 2008/11/1
　 * 作者: hanjc
　 * 版权: sitech
   *  修改代码：
   * 姓名：康晓强
   * 时间：2009/04/11
   * 修改内容：修改了表单中的form，将其全部换成getElementById
   * update yinzx 20090827 修改 1.屏蔽文件批量导入  2.修改服务
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<%
    //String caphone = (String)session.getAttribute("capn");
    //String caphone = (String)request.getParameter("acceptPhoneNo");
    String opCode="K083";
    String opName="短信发送";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  
	  String msg_content = (String)request.getParameter("msg_content");
	  
	  String action = (String)request.getParameter("myaction");
	  String isFirstIn = (String)request.getParameter("isFirstIn");//是否是第一次进入。N：否，Y：是
	  
	  String scucc_flag = (String)request.getParameter("flag");
	  String user_phone = WtcUtil.repNull(request.getParameter("user_phone"));
	  System.out.println("\n\n=1=scucc_flag==\n"+scucc_flag);
	  if(scucc_flag==null){
	    scucc_flag="";
	  }
	  System.out.println("\n\n=2=scucc_flag==\n"+scucc_flag);

  	/*取当前登陆工号的角色ID，为逗号分割的字符串 hanjc add 20090425*/
	String  powerCode = (String)session.getAttribute("powerCodekf");
	if(powerCode==null) {
			powerCode = "";
	}
	String[]  powerCodeArr = powerCode.split(",");
  	String isLeader="N";	
	/*
	 *是否是值班经理 测试环境：[0100020L] 生产环境：[01120O0A]，   上线时改一下
	 */
	for(int i = 0; i < powerCodeArr.length; i++){
		for(int j=0; j<ZBJL_ID.length; j++)
		if(ZBJL_ID[j].equals(powerCodeArr[i])){
			isLeader="Y";	
		}
	}	  
	  
%>

<html>
<head>
<title>短信发送</title>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

	function checkElement2() { 
				checkElement(this); 
		}	

//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
//打开短信预定义窗口
function addMsgModel(){
	openWinMid("K083_main.jsp",'自定义短信',650,850);
}

function sendMsg(){
	
	/*
	if(getLen(document.sitechform.msg_content.value)>320){
		rdShowMessageDialog('短信内容最大不能超过160个汉字,或者320个字符！');
		return;
	}
	*/
	//kangxq 将短信最大内容修改为160个字，320个字符
	//短信内容扩容，增大为700字节
	/*modify by yinzx 修改最长为500个字符*/
	if(getLen(document.getElementById('msg_content').value)>255){
		rdShowMessageDialog('短信内容最大不能超过128个汉字,或者255个字符！');
		return;
	}
	
   if( document.getElementById('user_phone').value == ""){
	  	rdShowMessageDialog('发送号码不能为空！请从新选择后输入!');
		  return;
    }
    //document.sitechform.msg_content.value == ""
	 if(document.getElementById("msg_content").value == ""){
	  	rdShowMessageDialog('短信内容不能为空！请从新选择后输入!');
		  return;
    }
	
    sendSubmit();
    
}

function encodeMsg(){
	var msg_content = document.getElementById('msg_content').value;
	msg_content = msg_content.replace(/\+/g,"%2B");
	return msg_content;
}	

//rpc调用发送

function sendSubmit(){
	//alert('send msg');
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K083/K083_msgSend_rpc.jsp","正在发送短信，请稍候......");
	mypacket.data.add("user_phone",document.getElementById('user_phone').value);
	var str = window.top.document.getElementById('contactId').value;
	mypacket.data.add("msg_content",encodeMsg());
	mypacket.data.add("con_id",str);
	core.ajax.sendPacket(mypacket,doProcess,true);
	mypacket = null;
}	

function doProcess(packet){
	var retCode = packet.data.findValueByName("scucc_flag");
			//alert(retCode);
	if(retCode=="1"){
    //window.document.getElementById('flag').value="1";
	 rdShowMessageDialog("发送成功！",2); 
	 //chengh 20090417根据用户反应短信发送后内容保存，受理好清空。
	 document.getElementById('user_phone').value="";   
	}else if(retCode=="0"){
    //window.document.getElementById('flag').value="0";
		rdShowMessageDialog("发送失败！");    
	}
	 // var user_phone=window.sitechform.user_phone.value;
	  //window.sitechform.action="K083_msgSend.jsp?user_phone="+user_phone;
    //window.sitechform.method='post';
   // window.sitechform.submit();
}

/**判断短信的长度。
   *一个字母数字等表示一个长度
   *一个汉字表示两个长度
   */
function getLen(str) 
{ 
var len=0; 

if(str != null && str.length>0){

   for(var i=0;i<str.length;i++){ 
    char = str.charCodeAt(i); 
    if(!(char>255)){ 
     len = len + 1; 
    }else { 
     len = len + 2; 
    } 
   } 
}
return len;
}

//居中打开窗口
function openWinMid(url,name,iHeight,iWidth)
{
  //var url; //转向网页的地址;
  //var name; //网页名称，可为空;
  //var iWidth; //弹出窗口的宽度;
  //var iHeight; //弹出窗口的高度;
  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

		function g(o){
			return document.getElementById(o);
		}
		function HoverLi(n){
			window.frames['iframe0'+n].location.reload();
			for(var i=1;i<=1;i++)
			{
				g('tb_'+i).className='normaltab';
				g('tbc_0'+i).className='undis';
			}
			g('tbc_0'+n).className='dis';
			g('tb_'+n).className='hovertab';
			
		}
		
				//判断短信字数和发送短信条数
		function onCharsChange(varField){ 
			var leftChars = getLeftChars(varField);
			var num = 1;
	      if ( leftChars >= 0){
					document.getElementById('charsmonitor').value=leftChars;
					if(parseInt(leftChars%70)==0){
						num = leftChars/70;
					}else{
						num = parseInt(leftChars/70)+1;
					}
					
					document.getElementById('sendnum').value = num;
					return true;   
        }
    }

    function getLeftChars(varField)   {  
      var i = 0;   
      var counter = 0;
      var leftchars = varField.value.length;            
      return (leftchars);   
    }
    
    
function checkcontent(){
  window.document.getElementById('user_phone').value=window.document.getElementById('user_phone').value.replace(/[^\d|^,]/g,'');
}
function loadMany(){
	openWinMid("K083_loadMany.jsp",'批量导入',250,550);
	//window.open("K083_loadMany.jsp");
}
</script>

		<style>
		.content_02
		{
			font-size:12px;
		}
		#tabtit
		{
			height:23px;
			padding:0px 0 0 12px;
		} 
		#tabtit ul
		{
			height:23px;
			position:absolute;
		} 
		#tabtit ul li
		{
			float:left;
			margin-right:2px;
			display:inline;
			text-align:center;
			padding-top:7px;
			cursor:pointer;
			height:22px;
			width:100px;
		}
		#tabtit .normaltab
		{
			color:#3161b1;
			background:url(../../../../../nresources/default/images/callimage/tab_bj_02.gif) no-repeat left top;
			height:23px;
		}
		#tabtit .hovertab 
		{ 
			color:#3161b1;
			background:url(../../../../../nresources/default/images/callimage/tab_bj_01.gif) no-repeat left top;
			height:24px;
		}
		.dis
		{
			display:block;
			border-top:1px solid #6c90ca;
			background:#fff url(../../../../../nresources/default/images/callimage/tab_cont.gif) repeat-x 0px 0px;
			padding:8px 12px;
		}
		.undis
		{
			display:none;
		}
		.content_02 .dis li
		{
			line-height:1.8em;
			padding-left:12px;
		}
		#msg{
		width:180px;
		height:120px;
		position:absolute;
		right:0px;
		bottom:0px;
		z-index:2;
		border:1px solid #555;
		background:url(<%= request.getContextPath() %>/nresources/default/images/callimage/msg_bj.gif) repeat-x 0 0;
		font-size:12px;
		}
		#msgTitle{
		height:16px;
		padding:8px 0px 0px 10px;
		border-bottom:2px solid #b3f9ff;
		position:relative;
		}
		#msgContent{
		padding:10px;
		height:1%;
		color:#555;
		}
		#msgImg{
		position:absolute;
		right:5px;
		top:5px;
		z-index:10;
		width:10px;
		height:10px;
    }
  </style>

<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body onload=''>

	<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title" style="height: 32px;"><div id="title_zi">
		发送号码 &nbsp;<input name="user_phone" id="user_phone"  onkeyup="checkcontent();" type="text" value="" size="15">
		<font color=''>&nbsp;&nbsp;多个号码请用","隔开!如(151****9107,135****6697)</font>&nbsp;
			<!--update by songjia 20100902-->
			<input name="clearnum" type="button"  id="clearnum"  style='height:25px' value="清除号码" onClick="document.getElementById('user_phone').value='';">  
			<!--end-->
		</div>
		
		</div>
		<table cellspacing="0">
		</table>   
    <table cellspacing="0" cellpadding="0">
    <table id="particularinfo" width="100%" border="0" cellpadding="0" cellspacing="0" >
    	<tr><td width='35%' height="100%">
			共<input name=charsmonitor style="border:none;" tabindex=100 value=0 e=5 size="2" readonly>字符  分<input name=sendnum style="border:none;" tabindex=100 value=0 e=5 size="2" readonly>次发送<br />
			<textarea name="msg_content" id="msg_content"  style="width:100%;word-break:break-all"  rows="20" title='最大允许250个汉字或500个字符' onpaste="return onCharsChange(this);" onkeyup="return onCharsChange(this);"></textArea>
							    </td>
							<!--   modify by yinzx 20090827   
							  <td valign="top">
							    	<div class="content_02" width="100%">
										<div id="tabtit" width="100%">
											<ul>
												
												<li id="tb_1" class="normaltab" onclick="HoverLi(1);" nowrap>
													预定义短信
												</li>
											</ul>
										</div>
										<div class="undis" id="tbc_01" width="100%">
											<iframe id="iframe01" style="height:90%" name="framePreconcerted" src="K083_ifram_preconcert.jsp" FRAMEBORDER="0" SCROLLING="auto" width="100%"></iframe>
										</div>

										</div>
							    </td> -->
      </tr>
		</table>
		 

		<p id="footer"><input name="send" type="button"  id="send" value="执行" onClick="sendMsg()">
			<%if("cddd".equals(isLeader)){%>
			<input name="addMsgModel" type="button"  id="addMsgModel" value="自定义短信包" onClick="addMsgModel()"/>
			<%}%>
		 		 
		</p>
<input type="hidden" id="myaction" name="myaction" value="">
<input type="hidden" id="isFirstIn" name="isFirstIn" value="N">
<input type="hidden" id="flag" name="flag" value="">
	</div>
</div>

<script>
	// by fangyuan 20090420 短信发送带受理号码。
	getCaller();
	function getCaller(){
		var phonenum = window.top.document.getElementById('acceptPhoneNo').value;
		var callNo="";
		if(window.top.cCcommonTool.getOp_code()=='K025')
		{
			callNo = window.top.cCcommonTool.getCalled();	
		}
		else
		{
			callNo = window.top.cCcommonTool.getCaller();
		}
		//当前没有处理来话的情况
		if(callNo==""){
			callNo = phonenum;
		}else{
			if(phonenum!=""&&callNo != phonenum){
					callNo = phonenum;
			}	
		}
		document.getElementById('user_phone').value=callNo;
	}
</script>

<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

