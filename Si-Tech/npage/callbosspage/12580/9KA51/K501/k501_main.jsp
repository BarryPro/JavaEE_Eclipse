<%
  /*
   * 功能: 发送单条短信
　 * 版本: 1.0.0
　 * 日期: 2009/01/07
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%@ include file="../../headTotal.jsp" %>
<%
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0);
%>
<%
	String catype = (String)session.getAttribute("catype");//呼叫类型

	String capn = (String)session.getAttribute("capn");//原始被叫不为空则是原始被叫，如果为空则为主叫号码
	String opCode = "K501";
	String opName = "发送短信";	
	String loginNo = (String) session.getAttribute("workNo");
	String dateStr = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
%>
<html>
	<head>
		<title>12580发送短信</title>
		<meta http-equiv=Content-Type content="text/html; charset=GBK">
		
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/FormText.css"
			rel="stylesheet" type="text/css"></link>
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/font_color.css"
			rel="stylesheet" type="text/css"></link>
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css"
			rel="stylesheet" type="text/css"></link>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
		<script language="javascript" type="text/javascript"
			src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>	
		<script language="JavaScript" type="text/JavaScript" src="../../inputops.js"></script>
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
		<script type="text/javascript">
			
		
		function ghistory(){
			document.sitechform.user_name.value = "";
			document.sitechform.msg_content.value = "";
			//document.sitechform.user_phone.value = "";
			document.sitechform.charsmonitor.value = "0";
			document.sitechform.sendnum.value = "0";
		}
		function g(o){
			return document.getElementById(o);
		}
		
		function HoverLi(n){
			window.frames['iframe0'+n].location.reload();
			for(var i=1;i<=4;i++)
			{
				g('tb_'+i).className='normaltab';
				g('tbc_0'+i).className='undis';
			}
			g('tbc_0'+n).className='dis';
			g('tb_'+n).className='hovertab';
			
		}
		</script>
		<script language="JavaScript" type="text/JavaScript" src="../../inputops.js"></script>
		<script language=javascript>
		
		function sendMsg(){
				
				if(document.sitechform.user_phone.value != ""){
					
					var rsp = document.sitechform.user_phone.value.split(" ");
		    	
					for(var i = 0; i < rsp.length; i++){
						
						if(rsp[i] != "" && !f_check_mobile(rsp[i])){
							
							showTip(document.sitechform.user_phone,"目标号码格式不正确！请从新选择后输入");
							
							sitechform.user_phone.focus();
							
							return;
						}
					}
				}
			  
		    if(document.sitechform.user_phone.value == ""){
		    	
					showTip(document.sitechform.user_phone,"目标号码不能为空！请从新选择后输入");
					
					sitechform.user_phone.focus();
						
		    }else if(document.sitechform.msg_content.value == ""){
		    	
					showTip(document.sitechform.msg_content,"短信内容不能为空！请从新选择后输入");
					
					document.sitechform.msg_content.focus();
					
				}else if(document.sitechform.msg_content.value.length > 300){
		    	
					showTip(document.sitechform.msg_content,"短信内容字数不能超出300个汉字！");
					
					document.sitechform.msg_content.focus();
					
				}else {
					
					hiddenTip(document.sitechform.user_phone);
					
					hiddenTip(document.sitechform.msg_content);
					
					if(rdShowConfirmDialog("确实要发送吗?",2) != 1){
				
					}else{
						var rp = document.sitechform.user_phone.value;
						document.all.frameTarget.src = "k501_ifram_target.jsp?rphone="+rp;
						document.all.frameOperate.src = "k501_ifram_operate.jsp?rphone="+rp;
						document.all.frameHistory.src = "k501_ifram_history.jsp?rphone="+rp;

						sendSubmit();  
					}					
					
				}
		}
		
		//去左右空格;
		function trim(s){
				return rtrim(ltrim(s));
		}
		//去左空格;
		function ltrim(s){
		  	return s.replace( /^\s*/, "");
		}
		
		//去右空格;
		function rtrim(s){
				return s.replace( /\s*$/, "");
		}
				
		function encodeMsg(){
			var content = trim(document.getElementById('msg_content').value);
			content = content.replace(/\^/g,"");//替换掉^号，因为^是服务的分隔符
			content = content.replace(/\r\n/g,"");//替换回车和换行
			content = content.replace(/\+/g,"%2B");//编码+号
			return content;
		}
		
		//rpc调用发送caller_phone_no
		function sendSubmit(){
			var callerphone = "";
			var contactid = "";
			if(window.top.cCcommonTool != undefined && window.top.cCcommonTool.getCaller() != ""){
				callerphone = window.top.cCcommonTool.getCaller();
				contactid = trim(parent.document.getElementById("contactIdnew").innerHTML);
			}else{
				callerphone = trim(parent.document.getElementById("caller_phone_no").innerHTML);
			}
			
			//发送号码形式 1-10658088；2-当前主叫；3-指定号码
			var fl;
			var obj = document.sitechform.sendno;
			for(var i = 0; i < obj.length; i++){
				if(obj[i].checked){
					fl = obj[i].value;
				}
			}
			
			var sendno = "";
			if(fl=='1'){
				sendno = "10658088";
			}else if(fl=='2'){
				sendno = callerphone;
			}else if(fl=='3'){
				if(document.sitechform.zdphone.value == ""){
		    	
					showTip(document.sitechform.zdphone,"指定的号码不能为空！请从新选择后输入");
					
					sitechform.zdphone.focus();
						
		    }else if(!f_check_mobile(document.sitechform.zdphone.value)){
		    	
		    	showTip(document.sitechform.zdphone,"指定的号码格式不正确！请从新选择后输入");
							
					sitechform.zdphone.focus();
							
					return;
		    }
		    sendno = document.sitechform.zdphone.value;
			}
			
			//页面传递属性
			var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/12580/9KA51/K501/k501_msgSend_rpc.jsp","正在发送短信，请稍候......");
			
			mypacket.data.add("sendno",sendno);//指定的短信发件人的号码
			
			mypacket.data.add("user_phone",document.sitechform.user_phone.value);
			
			mypacket.data.add("callerphone",callerphone);
			mypacket.data.add("contactid",contactid);
			var msg_contentV = encodeMsg();
			
			//chengh 判断短信内容
		  if(document.sitechform.user_name.value!=""){
		  	if(document.sitechform.sex.value=="山西移动"){
		      mypacket.data.add("msg_content",document.sitechform.sex.value+":"+msg_contentV);
		    }else{
			     mypacket.data.add("msg_content",document.sitechform.user_name.value+document.sitechform.sex.value+":"+msg_contentV);
			  }
			}else{
				if(document.sitechform.sex.value=="山西移动"){
					mypacket.data.add("msg_content",document.sitechform.sex.value+":"+msg_contentV);
			  }else{
			  	mypacket.data.add("msg_content",msg_contentV);
			  }
		  }
		  if(document.sitechform.VALID_TIME.value==""){
			  mypacket.data.add("VALID_TIME","notime");//短信发送时间
			}else{
		    mypacket.data.add("VALID_TIME",document.sitechform.VALID_TIME.value);//短信发送时间
		  }
			mypacket.data.add("user_name",document.sitechform.user_name.value+document.sitechform.sex.value);
			
		  core.ajax.sendPacket(mypacket,doProcess,true);
			mypacket=null;
		}

		
		function doProcess(packet){
			var retCode = packet.data.findValueByName("scucc_flag");
			if(retCode="1"){
		    window.sitechform.flag.value="1";
		    parent.similarMSNPop("短信发送成功");
		    
			}else if(retCode="0"){
		    window.sitechform.flag.value="0";
		    parent.similarMSNPop("短信发送失败");
			}
			  
			  //window.sitechform.action="k501_main.jsp";
		    //window.sitechform.method='post';
		    //window.sitechform.submit();
		}
		function importphone(){
			
			var retValue = window.showModalDialog('plCh.jsp','','dialogWidth:600px;dialogHeight:400px;center:1');
			
			if(retValue == undefined){
				
				return;
			}else{
				document.sitechform.user_phone.value += retValue;
			}		
		}
		function qry(){		
			var rp = document.sitechform.user_phone.value;
			document.all.frameTarget.src = "k501_ifram_target.jsp?rphone="+rp;
			document.all.frameOperate.src = "k501_ifram_operate.jsp?rphone="+rp;
			document.all.frameHistory.src = "k501_ifram_history.jsp?rphone="+rp;
			for(var i=1;i<=4;i++)
			{
				g('tb_'+i).className='normaltab';
				g('tbc_0'+i).className='undis';
			}
			g('tbc_02').className='dis';
			g('tb_2').className='hovertab';
		}
		
		function inCaller(){
			var va = document.sitechform.msg_content.value;
			var cp = "";
			//chengh  获取主叫
			var sessionstr = "<%=capn %>";
			if(window.top.cCcommonTool.getCaller() != undefined && window.top.cCcommonTool.getCaller() != ""){
					cp = window.top.cCcommonTool.getCaller();
			}else{
				if(sessionstr!=""){
			    cp = sessionstr;
			  }
		  }
			document.sitechform.msg_content.value = va + cp;
		}
		
		function hishow(){
			
			var prop = document.getElementById("particularinfo").style.display;
			if(prop == "none"){
				document.getElementById("particularinfo").style.display = "";
				document.sitechform.proset.value="取消详细设置";
				
			}else{
				document.getElementById("particularinfo").style.display = "none";
				document.sitechform.proset.value="详细设置";
			}
		}
		//判断短信字数和发送短信条数
		function onCharsChange(varField){ 
			var leftChars = getLeftChars(varField);
			var num = 1;
	      if ( leftChars >= 0){
					document.sitechform.charsmonitor.value=leftChars;
					if(parseInt(leftChars%70)==0){
						num = leftChars/70;
					}else{
						num = parseInt(leftChars/70)+1;
					}
					
					document.sitechform.sendnum.value = num;
					return true;   
        }
    }
    function getLeftChars(varField)   {   
      var i = 0;   
      var counter = 0;
      var leftchars = varField.value.length;            
      return (leftchars);   
    }
    
    //获取焦点，判断回车触发哪个事件
    /*
    var ls = null; onFocus="getfocus(this);" 
    
    function getfocus(obj){
    	if(obj.name != undefined){
			  ls=obj.name;
			  //document.sitechform.msg_content.focus();
			}
    }
    function document.onkeydown(){
			if(event.keyCode == 13){
			 
				if(ls=="user_phone"){
					sitechform.msg_content.focus();
					if(document.sitechform.msg_content.value.length>0){
						sitechform.msg_content.focus();
				  }
					qry();
					
					ls = null;
				}else{
					sendMsg();
				}
				
			}
		}*/
		//chengh update 
		function contentFocus(){
		 if(event.keyCode == 13){
		 	document.sitechform.msg_content.focus();
			qry();		 	  
		 }
	  }
	  function contentOnKeyDownSend(){
	  	if(event.keyCode == 13){
			  sendMsg();
			}
	  }
	  //end
		//指定号码文本可编辑
		function sezdPhone(obj){
			if(obj.checked){
				document.sitechform.zdphone.disabled = false;
			}
		}
		
		function phokeyup(obj){
			if(window.event.keyCode!=37 && window.event.keyCode!=39){
				obj.value=obj.value.replace(/[^\d\ ]/g,'');
			}		
		}
		
		function phoonbeforepaste(){
			if(window.event.keyCode!=37 && window.event.keyCode!=39){
				clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d\ ]/g,''));
			}		
		}
		</script>
		<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
	</head>

	<body>
		<form name="sitechform" id="sitechform">
			<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
						
						<td valign="top">
							<div id="Operation_Table">
							
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
							  <tr>
							    <td colspan="2">
							    	<input type="button" class="b_foot" value="目标号码" onClick="importphone();"/>
							    	<input name="user_phone" id="ACCEPT_NO1" value="<%=(request.getParameter("user_phone")!=null)?request.getParameter("user_phone"):"" %>" size="40" onClick="hiddenTip(this);" onkeyup="phokeyup(this);contentFocus();"  onbeforepaste="phoonbeforepaste()" />
							    	<input type="button" class="b_foot" value="查询" onClick="qry();"><input type="hidden" name="contactId" value=""/>
							    	<input type="hidden" name="myaction" value=""/>
							    	<input type="hidden" name="flag" value=""/>
							    	<input type="button" class="b_foot" name="fso" value="发送" onClick="sendMsg();"/>							    	
							    	<input type="button" name="proset" class="b_foot_long" value="详细设置" onClick="hishow();">
							    	<input type="button" value="带主叫" name="onfos" class="b_foot" onClick="inCaller();">
							    </td>
							  </tr>
							  <tr>
							    <td colspan="2">
							    	<table id="particularinfo" width="100%" border="0" cellpadding="0" cellspacing="0" style="display:none ">
								      <tr>
								        <td>客户名称</td>
								        <td>
								          <input type="text" name="user_name">
								          <select name="sex">
								          	<option value="先生">先生</option>
								          	<option value="女士">女士</option>
								          	<option value="小姐">小姐</option>
								          	<option value="山西移动">山西移动</option>
								          </select><font class="orange">*</font>
								        </td>
								      </tr>
								      <tr>
								        <td>指定发送时间</td>
								        <td>
								          <input id="VALID_TIME" name="VALID_TIME" type="text" value="">
										  <img onclick="WdatePicker({el:$dp.$('VALID_TIME'),dateFmt:'yyyy-MM-dd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
								          <font class="orange">*</font>
								        </td>
								      </tr>
								      <tr>
								        <td>优先级</td>
								        <td>
								          <select name="">
								          	<option>普通</option>
								          	<option>紧急</option>
								          </select>
								          <font class="orange">*</font>
								        </td>
								      </tr>
								      
								      <tr>
								        <td>送出号码</td>
								        <td>								        	
									        <p><input type="radio" name="sendno" value="1" checked>默认源地址&nbsp; 10658088</p>
									        <p><input type="radio" name="sendno" value="2" >当前主叫</p>
									        <p><input type="radio" name="sendno" value="3" onClick="sezdPhone(this)">指定号码<input type="text" name="zdphone" disabled></p>
								        </td>
								      </tr>								      
								    </table>
							    </td>
							  </tr>
							  <tr>
							    <td width='40%' height="100%">
							    	共<input name=charsmonitor style="border:none;" tabindex=100 value=0 e=5 size="2" readonly>字符  分<input name=sendnum style="border:none;" tabindex=100 value=0 e=5 size="2" readonly>次发送<br />
							    	<textarea name="msg_content" id="msg_content" onpaste="return onCharsChange(this);" onkeyup="onCharsChange(this);" onkeydown="contentOnKeyDownSend();" tabIndex=1 onchange="return onCharsChange(this);" style="width:100%;word-break:break-all;font-size:15px" rows="22"></textarea>
							    </td>
							    <td valign="top">
							    	<div class="content_02" width="100%">
										<div id="tabtit" width="100%">
											<ul>
												
												<li id="tb_1" class="normaltab" onclick="HoverLi(1);" nowrap>
													预定义短信
												</li>
												<li id="tb_2" class="hovertab" onclick="HoverLi(2);">
													目标用户信息
												</li>
												
												<li id="tb_3" class="normaltab" onclick="HoverLi(3);">
													操作信息
												</li>
												<li id="tb_4" class="normaltab" onclick="HoverLi(4);">
													历史短信
												</li>
											</ul>
										</div>
										<div class="undis" id="tbc_01" width="100%">
											<!--<iframe id="iframe01" style="height:90%" name="framePreconcerted" src="K503/K503_message_tree.jsp" FRAMEBORDER="0" SCROLLING="auto" width="100%"></iframe>-->
											<iframe id="iframe01" style="height:90%" name="framePreconcerted" src="k501_ifram_preconcert.jsp" FRAMEBORDER="0" SCROLLING="auto" width="100%"></iframe>
										</div>
										<div class="dis" id="tbc_02" width="100%">
											<iframe id="iframe02" style="height:90%" name="frameTarget" src="k501_ifram_target.jsp?rphone=<%=capn %>" FRAMEBORDER="0" SCROLLING="auto" width="100%"></iframe>
										</div>
										<div class="undis" id="tbc_03" width="100%">
											<iframe id="iframe03" style="height:90%" name="frameOperate" src="k501_ifram_operate.jsp?rphone=<%=capn %>" FRAMEBORDER="0" SCROLLING="auto" width="100%"></iframe>
										</div>
										<div class="undis" id="tbc_04" width="100%">
											<iframe id="iframe04" style="height:90%" name="frameHistory" src="k501_ifram_history.jsp?rphone=<%=capn %>" FRAMEBORDER="0" SCROLLING="auto" width="100%"></iframe>
										</div>
										</div>
							    </td>
							  </tr> 
							</table>
							</div>							
						</td>
					</tr>					
				</table>										
		</form>
	</body>
</html>