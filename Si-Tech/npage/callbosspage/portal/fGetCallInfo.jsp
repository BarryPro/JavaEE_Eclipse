<%
   /*
   * 功能: 用户呼入信息
　 * 版本: v1.0
　 * 日期: 2008/10/18
　 * 作者: ranlf
　 * 版权: sitech
   * 修改历史
   * 修改日期 2009-05-29     修改人  libina     修改目的  处理预存款和欠费显示问题
   * 修改日期 2009-06-04     修改人  libina     修改目的  屏蔽有安全隐患的信息
   * 修改日期 2009-06-06     修改人  libina     修改目的  优化页面
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
		String cust_name       = "";
		String contact_address = "";
		String phone_no        = "";
		String card_name       = "";
		String product_name    = "";
		String town_name       = "";
		String run_name        = "";
		//double prepay_fee      = 0.0;
		String prepay_fee      ="";
		String sm_name         = "";
		String prepay_fee_flag ="";
		
		String workNo = (String)session.getAttribute("workNo");
		String password = (String)session.getAttribute("password");
%>



<%
// 吉林代码开始 by fangyuan 20090801
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String params = "callPhone="+callPhone;
	//System.out.println("regionCode = "+regionCode);
	String sqlcustmsg="select to_char(id_no) from dcustmsg where phone_no=:callPhone";
 // System.out.println("sqlcustmsg:="+sqlcustmsg);
%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
	  <wtc:param value="<%=sqlcustmsg%>"/>
		<wtc:param value="<%=params%>"/>
	</wtc:service>
	<wtc:array id="fee" scope="end"/>		

<%
if(fee.length>0){
String idNo  = fee[0][0];//ID号
//System.out.println("------ idNo = "+idNo);


%>
	<wtc:service name="s1500Qry"  routerKey="region" routerValue="<%=regionCode%>" outnum="8">
		<wtc:param value="<%=callPhone%>"/>
		<wtc:param value="<%=idNo%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="1500"/>
		<wtc:param value="<%=password%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />


<%
//System.out.println("------ result.length = "+result.length);

	ArrayList  arlist = new ArrayList();    
	StringTokenizer resToken = null;
    int i = 0;
    for(int count = 0; count < 8; count++)
    {
			String value;
			for(resToken = new StringTokenizer(result[0][i], "|"); resToken.hasMoreElements(); arlist.add(value))
			{			
			  value = (String)resToken.nextElement();
			}
			i++;
    }
	
	String return_code = (String)arlist.get(0);
	String return_message = (String)arlist.get(1);
/*
System.out.println("------ return_code = "+return_code+" \treturn_message= "+return_message);

System.out.println("------cust_name = "+(String)arlist.get(3));
System.out.println("------contact_address = "+(String)arlist.get(16));
System.out.println("------card_name = "+(String)arlist.get(7));
System.out.println("------town_name = "+(String)arlist.get(4));
System.out.println("------run_name = "+(String)arlist.get(33));
System.out.println("------sm_name = "+(String)arlist.get(26));
System.out.println("------preFee = "+(String)arlist.get(49));
System.out.println("------prepay_fee_flag = "+(String)arlist.get(52));
*/

if (return_code.equals("000000")){

		cust_name      = (String)arlist.get(3)==null?"":(String)arlist.get(3);
		contact_address= (String)arlist.get(16)==null?"":(String)arlist.get(16);
	
		phone_no       = callPhone;
		card_name      = (String)arlist.get(7)==null?"":(String)arlist.get(7);
		product_name   = (String)arlist.get(37)==null?"":(String)arlist.get(37);
		town_name      = (String)arlist.get(4)==null?"":(String)arlist.get(4);
		run_name       = (String)arlist.get(33)==null?"":(String)arlist.get(33);		
		sm_name		     = (String)arlist.get(26)==null?"":(String)arlist.get(26);
		String preFee = (String)arlist.get(49);
		if (  preFee.length()==3 && preFee.substring(0,1).equals(".") ) { preFee = "0"+preFee;  }
		prepay_fee     = preFee;
		
		prepay_fee_flag = (String)arlist.get(52)==null?"":(String)arlist.get(52);
		
		
}
}
//吉林代码结束
%>




<div class="functitle">用户呼入流水</div>
				<table>
					<tr>
						<td colspan="3" onclick="copyToClipBoard(this)"><%=contactId%></td>					
					</tr>
					<tr>
						<th >主叫号码</th>
						<td colspan="2" id="caller_phone_no" onclick="copyToClipBoard(this)"></td>
					</tr>
					<tr>
						<th >被叫号码</th>
						<td colspan="2" id="called_phone_no" onclick="copyToClipBoard(this)"></td>
					</tr>
					<tr>
						<th >归属地</th>
						<td colspan="2" id="town" onclick="copyToClipBoard(this)"><%=town_name%></td>
					</tr>	
					<tr>
						<th>客户姓名</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=cust_name%></td>				
					</tr>
					<tr>
						<th>客户级别</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=card_name%></td>
					</tr>
					<tr>
						<th>客户品牌</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=null == sm_name?"" : sm_name%></td>
					</tr>
					<tr>
						<th>受理方式</th>
						<td colspan="2" id="handleType" onclick="copyToClipBoard(this)">电话接入</td>
					</tr>
					<tr>
						<th>受理号码</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=phone_no%></td>
					</tr>
					<tr id="handleNo_town_tr" style="display:none">
						<th>归属地</th>
						<td colspan="2" id="handleNo_town" onclick="copyToClipBoard(this)"></td>
					</tr>	
					<tr>
						<th>联系地址</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=contact_address%></td>
					</tr>
					<tr>
						<th nowrap >计费类型</th>
  	  			<td colspan="2" nowrap onclick="copyToClipBoard(this)"><%=product_name.trim()%></td>
					</tr>
					<tr>
						<th>运行状态</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=run_name%></td>
					</tr>
					<tr>
						<th>预存款</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=prepay_fee%></td>
					</tr>
					<tr>
						<th>欠费标志</th>
						<td colspan="2" onclick="copyToClipBoard(this)"><%=prepay_fee_flag%></td>
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
var calledNo = cCcommonTool.getCalled()

//alert('searchPhoneNo='+searchPhoneNo);
//alert('calledNo='+calledNo);
//如果受理号码与接通的用户号码不同(呼入/呼出)，更新受理号码归属地
if(searchPhoneNo!=callerNo&&searchPhoneNo!=calledNo){
	//show el
	document.getElementById('handleNo_town_tr').style.display = 'block';
	//扩展查询方法，更新受理号码归属地
	getLocationEx(searchPhoneNo,updateHandleNoRegion);
}

  var workMyNo=cCcommonTool.getWorkNo();
  var curState=0;
  /*
  if(parPhone.QueryAgentStatusEx(workMyNo)==0){
    curState=parPhone.AgentInfoEx_CurState;
  }
  */
  if(curState==5){
  	//20090311tancf去掉通话信息
	//document.getElementById('contactingMsg').innerHTML="正在与客户：<%=cust_name%>通话";
  }
  
  document.getElementById('caller_phone_no').innerHTML=cCcommonTool.getCaller();
  document.getElementById('called_phone_no').innerHTML=cCcommonTool.getCalled();
  document.getElementById('custName').value="<%=cust_name%>";
  cCcommonTool.setCallerUserName("<%=cust_name%>");
  if(cCcommonTool.getOp_code()=="K025"){
  	//20090312 fangyuan 呼出时处理方式为电话呼出
  	document.getElementById("handleType").innerHTML = "电话呼出";
  	// by fangyuan 090324 针对所有号段更新归属地信息
  	getLocation(cCcommonTool.getCalled());
  }else{
  	// by fangyuan 090324 针对所有号段更新归属地信息
  	getLocation(cCcommonTool.getCaller());
  }
  
  
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
				//将省份记录到callPanle隐藏域中
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
  // 查询归属地方法
  function getLocation(phoneNo){
  	if(phoneNo==''||phoneNo=='undefined'){
  		return;
  	}
  	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/portal/getLocation.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("callPhone",phoneNo);
	core.ajax.sendPacket(packet,doGetLocation,true);
	packet=null;
  }
  //普通呼入、呼出号码归属地查询的回调方法
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
  //alert("-------------------");
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
