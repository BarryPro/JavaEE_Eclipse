<%
	/*
	 * 功能： 全网流量套餐信息页面
	 * 版本： v1.0
	 * 20121128 sunzj
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%@ page import="java.util.*"%>
<%
	String xml = request.getParameter("gAddFeeInfo");
	String meansId = request.getParameter("meansId");
	String svcNum = request.getParameter("svcNum");
	String reginCode = request.getParameter("reginCode");
	String loginNo = request.getParameter("loginNo");
	String loginPwd = request.getParameter("password");
	String orderId = request.getParameter("orderId");
	String groupId = request.getParameter("groupId");
	System.out.println("gAddFeeInfo=meansId===AAAAAAAAAAAAAAAAAAAAAA====" + meansId);
	System.out.println("gAddFeeInfo=xml===AAAAAAAAAAAAAAAAAAAAAA====" + xml);
	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%	
	List fundsList = null;
	Iterator it =null;
	String codeStr = "";
	if(null != mb){
		fundsList = mb.getList("OUT_DATA.H36.GADD_FEE_LIST.GADD_FEE_INFO");
		if(null!=fundsList){
		  it = fundsList.iterator();
		  if(null!=it){
			String split = "";
			while(it.hasNext()){
				Map stMap = mb.isMap(it.next());
				if(null==stMap)continue;
				String ADD_FEE_CODE = (String)stMap.get("ADD_FEE_CODE") == null ? "":(String)stMap.get("ADD_FEE_CODE");
				codeStr = codeStr + split + "'" +ADD_FEE_CODE + "'";
			}
		  }
	    }
	
	
 %>
 <s:service name="WsGetChangeAddFee" >
    <s:param name="Root">
    	<s:param name="REQUEST_INFO">
    		<s:param name="SVCNUM" type="string" value="<%=svcNum %>" />
    	   	<s:param name="CHN_CODE" type="string" value="<%=reginCode %>" />
   			<s:param name="OPCODE" type="string" value="g794" />
   			<s:param name="LOGINNO" type="note" value="<%=loginNo%>" />
   			<s:param name="LOGINPWD" type="note" value="<%=loginPwd%>" />
   			<s:param name="GROUP_ID" type="string" value="<%=groupId %>" />
   			<s:param name="CODE_STR" type="string" value="<%=codeStr %>" />
   			<s:param name="FUNDSLIST" type="note" value="<%=xml%>" />
    	</s:param>
    </s:param>
</s:service>
<% 
	List slist = result.getList("OUT_DATA.ADD_FEE_LIST.ADD_FEE_INFO");
%> 
 

<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation">
		<form method="post" name="frm4938" action="">
				
				<div id="operation_table">
					 <div class="title">
						<div class="text">
							流量套餐详细信息
						</div>
					</div>
					<div class="input">
					<table id="selectTable">
						<tr>
							<th>选择</th>
							<th>流量套餐代码</th>
							<th>流量套餐名称</th>
							<th>期限</th>
							<th>消费金额</th>
						</tr>
					<%
							Map mMap = null;
							MapBean maps = new MapBean();
							Iterator itrs = slist.iterator();
							while (itrs.hasNext()) {
				  				mMap = maps.isMap(itrs.next());
				  				if(mMap==null) continue;
									String ADD_FEE_CODE = (String)mMap.get("ADD_FEE_CODE")== null ? "":(String)mMap.get("ADD_FEE_CODE");
									String ADD_FEE_NAME = (String)mMap.get("ADD_FEE_NAME") == null ? "":(String)mMap.get("ADD_FEE_NAME");
									String ADD_FEE_SCORE = (String)mMap.get("ADD_FEE_SCORE") == null ? "":(String)mMap.get("ADD_FEE_SCORE");
									String COST = (String)mMap.get("COST") == null ? "":(String)mMap.get("COST");
					 %>
							<tr>
								<td>
									<input type="checkbox" name="fee" id="<%=ADD_FEE_CODE %>"  size="1"/>
								</td>														
								<td id="<%=ADD_FEE_CODE %>_1">
									<%=ADD_FEE_CODE%>					
								</td>
								<td id="<%=ADD_FEE_CODE %>_2">
									<%=ADD_FEE_NAME%>
								</td>
								<td id="<%=ADD_FEE_CODE %>_3">
									<%=ADD_FEE_SCORE%>
								</td> 
								<td id="<%=ADD_FEE_CODE %>_4">
									<%=COST%>
								</td> 															
							</tr>
						
						<%}}%>
						</table>
<s:service name="s5584QryGPRSWS_XML" >
    <s:param name="Root">
   			<s:param name="chn" type="string" value="<%=reginCode%>" />
   			<s:param name="opcode" type="string" value="g794" />
   			<s:param name="loginno" type="string" value="<%=loginNo%>" />
   			<s:param name="loginpwd" type="string" value="<%=loginPwd%>" />
   			<s:param name="svcnum" type="string" value="<%=svcNum%>" />
    </s:param>
</s:service>
<% 
	List list = result.getList("OUT_DATA.BUSI_INFO");
%>
						 <div class="title">
							<div class="text">
								已经办理的流量套餐
							</div>
						</div>			
					<table id="oldTable">
						<tr>
							<th>选择</th>
							<th>流量套餐代码</th>
							<th>流量套餐名称</th>
						</tr>					
						<%
							Map MeanMap = null;
							MapBean m = new MapBean();
							Iterator itr = list.iterator();
							while (itr.hasNext()) {
				  				MeanMap = m.isMap(itr.next());
				  				if(MeanMap==null) continue;
								String id = (String)MeanMap.get("ID");
								String name = (String)MeanMap.get("NAME");
							
						%>
							<tr>
								<td >
									<input type="checkbox" name="fee" id="<%=id %>"  size="1" checked="checked"/>
								</td>
								<td id="<%=id %>_1" >
									<%=id %>
								</td>
								<td id="<%=id %>_2" >
									<%=name %>
								</td>								
							</tr>
						<%}%>
					</table>
										
						</div>
					<div id="operation_button">
						<input type="button" class="b_foot" value="选择" id="btnCancel"
							name="btnCancel" onclick="subAll()" />					
						<input type="button" class="b_foot" value="关闭" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
		<%@ include file="/npage/include/footer_pop.jsp"%>
	</body>
<script type="text/javascript">
	var allcost = "";
	function subAll(){
		var checkEle = $("#selectTable input:checked");
		var checkEleOld = $("#oldTable input:checked");
		var uncheckOld = $("#oldTable input:checkbox").not("input:checked");
		var codes = "";
		var feeNames = "";
		var showNames = "";
		var feeScores = "";
		var split = "";
		var split2 = "";
		var split3 = "";
		var split4 = "";
		var orderStr = "";//订购串
		//拼写新订购的串
		for(var i=0; i<checkEle.length; i++){
			var tid = $(checkEle[i]).attr("id");
			var code = $.trim($("#"+tid+"_1").text());
			var name = $.trim($("#"+tid+"_2").text());
			var score = $.trim($("#"+tid+"_3").text());
			var cost = $.trim($("#"+tid+"_4").text());
			codes = codes + split + code;
			feeNames = feeNames + split + name;
			showNames = showNames + split2 + name;
			feeScores =  feeScores + split + score;
			allcost = Number(allcost) + Number(cost);
			orderStr = orderStr + split3 + "N";
			split = "#";
			split2 = "<br>";
			split3 = ",";
		}
		//将旧订购的业务名称加入显示
		for(var i=0; i<checkEleOld.length; i++){
			var tid = $(checkEleOld[i]).attr("id");
			var name = $.trim($("#"+tid+"_2").text());
			showNames = showNames + split2 + name;
			split2 = "<br>";
		}
		//将取消的旧订购业务拼串
		for(var i=0; i<uncheckOld.length; i++){
			var tid = $(uncheckOld[i]).attr("id");
			var code = $.trim($("#"+tid+"_1").text());
			var name = $.trim($("#"+tid+"_2").text());
			var score = "0";
			codes = codes + split + code;
			feeNames = feeNames + split + name;
			feeScores =  feeScores + split + score;
			orderStr = orderStr + split3 + "Y";
			split = "#";
			split3 = ",";
		}
		
//=============================增加生效时间和失效时间调用接口==============================			
		if(codes != "" ){
			var iPhoneNoStr="";//手机号码串
			var iOprTypeStr="";//资费标识串
			var iDateTypeStr="";//资费类型串
			var iOfferTypeStr="";//资费类型串
			var iUnitStr="";//资费类型串
			
			var codeStrS = codes.split("#");
			var orderStrs = orderStr.split(",");
			for(var i =0;i<codeStrS.length;i++){
				iPhoneNoStr = iPhoneNoStr + split4 + "<%=svcNum%>";
				if(orderStrs[i] == "N"){
					iOprTypeStr = iOprTypeStr + split4 + "1";
					iDateTypeStr = iDateTypeStr + split4 + "1";
				}else{
					iOprTypeStr = iOprTypeStr + split4 + "3";
					iDateTypeStr = iDateTypeStr + split4 + "3";
				}
				iOfferTypeStr = iOfferTypeStr + split4 + "1";
				iUnitStr = iUnitStr + split4 + "6";
				split4 = "#";
			}
			
			//alert("iPhoneNoStr:"+iPhoneNoStr);
			//alert("iOprTypeStr:"+iOprTypeStr);
			//alert("iDateTypeStr:"+iDateTypeStr);
			//alert("iOfferTypeStr:"+iOfferTypeStr);
			//alert("iUnitStr:"+iUnitStr);
			
			var sPacket = new AJAXPacket("getEffectTime.jsp","请稍候......");
			sPacket.data.add("iChnSource","<%=reginCode%>");
			sPacket.data.add("iLoginNo","<%=loginNo%>");
			sPacket.data.add("iLoginPWD","<%=loginPwd%>");
			sPacket.data.add("iPhoneNo","<%=svcNum%>");
			sPacket.data.add("iOprAccept","<%=orderId%>");
			sPacket.data.add("iPhoneNoStr",iPhoneNoStr);
			sPacket.data.add("iOfferIdStr",codes);
			sPacket.data.add("iOprTypeStr",iOprTypeStr);
			sPacket.data.add("iUnitStr",iUnitStr);
			sPacket.data.add("iDateTypeStr",iDateTypeStr);
			sPacket.data.add("iOfferTypeStr",iOfferTypeStr);
			sPacket.data.add("iOffsetStr",feeScores);
			//==================================================
			sPacket.data.add("meansId","<%=meansId%>");
			sPacket.data.add("codes",codes);
			sPacket.data.add("feeNames",feeNames);
			sPacket.data.add("showNames",showNames);
			sPacket.data.add("feeScores",feeScores);
			sPacket.data.add("orderStr",orderStr);
			core.ajax.sendPacket(sPacket,doserviceResCat);
			sPacket = null;
		}else{
			parent.saveGAddFee("<%=meansId%>", codes, feeNames, showNames, feeScores, allcost, orderStr,"","");
			closeWin();
		}
	}		

	function doserviceResCat(packet){		
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		//=====================================================================		
		var meansId = packet.data.findValueByName("meansId");
		var codes = packet.data.findValueByName("codes");
		var feeNames = packet.data.findValueByName("feeNames");
		var showNames = packet.data.findValueByName("showNames");
		var feeScores = packet.data.findValueByName("feeScores");
		var orderStr = packet.data.findValueByName("orderStr");
		var effDateStr = packet.data.findValueByName("effDateStr");
		var expDateStr = packet.data.findValueByName("expDateStr");
		if(RETURN_CODE!="000000"){
			showDialog(RETURN_MSG,0);
			return false;
		}	
		//存储内容
		parent.saveGAddFee("<%=meansId%>", codes, feeNames, showNames, feeScores, allcost, orderStr,effDateStr,expDateStr);
		closeWin();
	}
	function closeWin(){
		closeDivWin();
	}
	</script>
</html>