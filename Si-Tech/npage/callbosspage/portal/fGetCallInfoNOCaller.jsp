<%
   /*
   * 功能: 用户呼入信息
　 * 版本: v1.0
　 * 日期: 2008/10/18
　 * 作者: ranlf
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.net.InetAddress"%>
<%
    String callPhone = request.getParameter("callPhone");
    String contactId = request.getParameter("contactId");
%>




<div class="functitle">用户呼入流水</div>
				<table>
					<tr>
						
						<td colspan="3" onClick="copyToClipBoard(this)"><%=contactId%></td>
						
					</tr>
					<tr>
						<th>主叫号码</th>
						<td colspan="2" id="caller_phone_no" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>被叫号码</th>
						<td colspan="2" id="called_phone_no" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>归属地</th>
						<td colspan="2" id="town" onClick="copyToClipBoard(this)"></td>
						
					</tr>	
					<tr>
						<th>客户姓名</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>客户级别</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>客户品牌</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>受理方式</th>
						<td colspan="2" id="handleType" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th >受理号码</th>
						<td colspan="2" id="serviceNO" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr id="handleNo_town_tr" style="display:none">
						<th>归属地</th>
						<td colspan="2" id="handleNo_town" onClick="copyToClipBoard(this)"></td>
						
					</tr>	
					<tr>
						<th>联系电话</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>联系地址</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>运行状态</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>邮政编码</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>预存款</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>欠费</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th nowrap >计费类型：</th>
  	  			<td colspan="2" nowrap onClick="copyToClipBoard(this)"></td>
  	  			
					</tr>
				</table>
				<div class="visitorFunc">
					<div class="functitle">服务器IP：<%=InetAddress.getLocalHost().getHostAddress()%></div>
					<!--
					<div class="functitle">当前内存：<span id="par_curMem"></span>M</div>	
				  -->
					 <!--
					<div class="functitle">话务员常用功能</div>
					<a href="javascript:addTab(true,'a03','综合查询','childTab_call.jsp?parentOpCode=K170')">综合查询</a>
					<a href="javascript:addTab(true,'a04','媒体查询','childTab_call.jsp?parentOpCode=K180')">媒体查询</a>
					<a href="javascript:addTab(true,'a05','接触记录','childTab_call.jsp?parentOpCode=K190')">接触记录</a>
					<br />
					<a href="javascript:addTab(true,'a06','呼出查询','childTab_call.jsp?parentOpCode=K220')">呼出查询</a>
					<a href="javascript:addTab(true,'a07','质检查询','childTab_call.jsp?parentOpCode=K200')">质检查询</a>
					<a href="javascript:addTab(true,'a08','质检考评','childTab_call.jsp?parentOpCode=K210')">质检考评</a>
				-->
				</div>
<script language="javaScript">
	
	
	//查询出的电话号码
	var searchPhoneNo = "<%=callPhone%>";
	var callerNo = cCcommonTool.getCaller();
	var calledNo = cCcommonTool.getCalled();
	cCcommonTool.DebugLog("fget  callerNo"+callerNo);
	cCcommonTool.DebugLog("fget  calledNo"+calledNo);
	var handleNo = "";
	//写入受理号码
	if(callerNo!=undefined)
	{
	if(callerNo.length==11){
		handleNo = callerNo;
	}
}
if(calledNo!=undefined)
	{
	if(calledNo.length==11){
		handleNo = calledNo;
	}
}
	//alert('11'+handleNo);
	document.getElementById('serviceNO').innerHTML = handleNo;
	//alert('searchPhoneNo='+searchPhoneNo);
//alert('calledNo='+calledNo);
	//如果受理号码与接通的用户号码不同(呼入/呼出)，更新受理号码归属地
	if(searchPhoneNo!=callerNo&&searchPhoneNo!=calledNo){
		//update 受理号码
		document.getElementById('serviceNO').innerHTML = "<%=callPhone%>";
		//show el
		document.getElementById('handleNo_town_tr').style.display = 'block';
		//扩展查询方法，更新受理号码归属地
		
		getLocationEx(searchPhoneNo,updateHandleNoRegion);
	}
		
	
  var workNo=cCcommonTool.getWorkNo();
  //tancf 20090604
  /*
	var current_CurState=0;
	if(parPhone.QueryAgentStatusEx(workNo)==0){
		current_CurState=parPhone.AgentInfoEx_CurState;
	}
	//alert(cCcommonTool.getCaller()+"ss"+cCcommonTool.getCalled());
	
	//alert('callerId='+callerId+' calledId='+calledId);
	
	if(current_CurState==5){
	*/
	//cCcommonTool.DebugLog("fget  parPhone.IsTalking"+parPhone.IsTalking);
	//if(parPhone.IsTalking==1){
		document.getElementById('caller_phone_no').innerHTML=callerNo;	
		document.getElementById('called_phone_no').innerHTML=calledNo;
  
		if(cCcommonTool.getOp_code()=="K025"){
  		//20090312 fangyuan 呼出时处理方式为电话呼出
  		document.getElementById("handleType").innerHTML = "电话呼出";
  		// by fangyuan 090324 针对所有号段更新归属地信息
  		getLocation(cCcommonTool.getCalled());
  	}else{
  		// by fangyuan 090324 针对所有号段更新归属地信息
  		getLocation(cCcommonTool.getCaller());
 	  }
  /*else{
  		getLocation('<%=callPhone%>');
  		document.getElementById('serviceNO').innerHTML='<%=callPhone%>';
  }*/
  	
  	
  //-----methods collection---------- begin
  
  //查询受理号码归属地的动态回调方法
  function updateHandleNoRegion(packet){
    	var retCode = packet.data.findValueByName("retCode");	
			if (retCode == "000000") {
				var townName ="";
				
				townName = packet.data.findValueByName("townName");
				var provice=packet.data.findValueByName("provice");
				
				// 更新受理号码归属地
				document.getElementById('handleNo_town').innerHTML = townName;
				document.getElementById('provice').value=provice;
				return;
			}	
  }
  
  //getLocation 扩展方法
  function getLocationEx(phoneNo,callback){
  	if(phoneNo==''||phoneNo=='undefined'){
  		return;
  	}
  	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/portal/getLocation.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
		packet.data.add("callPhone",phoneNo);
		core.ajax.sendPacket(packet,callback,true);
		packet=null;
  }	
  	
  	
  	
  function getLocation(phoneNo){
  	if(phoneNo==''||phoneNo=='undefined'){
  		return;
  	}
  	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/portal/getLocation.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
		packet.data.add("callPhone",phoneNo);
		core.ajax.sendPacket(packet,doGetLocation,true);
		packet=null;
  }
  
  function doGetLocation(packet){
  	var retCode = packet.data.findValueByName("retCode");	
		if (retCode == "000000") {
			var townName ="";
			townName = packet.data.findValueByName("townName");
			// 更新修改节点的名称
			document.getElementById('town').innerHTML = townName;
			return;
		}
  }	
  //-----methods collection---------- end 
  //单击复制选中内容 by libin 2009/04/28
	  function copyToClipBoard(obj){
	  //alert("+++++++++++++++++");
			var clipBoardContent = obj.innerHTML; 		
			window.clipboardData.setData('Text',clipBoardContent);		
		}
</script>
<script>
	//by zwy 20090617 显示内存
	/*
	function displayIEMem(){
		document.getElementById("par_curMem").innerHTML=cCcommonTool.getCurrentIEMemUsed();
	}	
	setInterval("displayIEMem()",2000);
	*/
</script>	
