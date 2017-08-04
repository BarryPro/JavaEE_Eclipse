<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/login/dispatch.jsp" %>
<%
		String opName ="黑龙江BOSS-营销提示";
		String regionCode= (String)session.getAttribute("regCode");
    /*得到输入参数*/
    String phoneNo=request.getParameter("phoneNo");
    String loginNo = (String)session.getAttribute("workNo");
    String loginNoPass = (String)session.getAttribute("password");
    System.out.println("=========getMarket.jsp" + phoneNo);
    String opcodeurl = getLink("4","market/14936/4938/f4938_main1.jsp?isPreengage=N","e177",session,request,"营销执行");
    System.out.println("yanpx opcodeurl="+opcodeurl);
%> 	
	<wtc:service name="sCollInit" routerKey="region" routerValue="<%=regionCode%>" 
		 outnum="4" retcode="retCode1" retmsg="retMsg">
		<wtc:param value=""/> 
		<wtc:param value="01"/>
		<wtc:param value=""/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNoPass%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
		if(!"000000".equals(retCode1)){
%>
			<script language="javascript">
				//rdShowMessageDialog("错误代码：" + "<%=retCode1%>" + "，错误信息：" + "<%=retMsg%>",0);
				window.close();
			</script>
<%
		}
		if(result == null || result.length == 0){
%>
			<script language="javascript">
				//alert("here?");
				window.close();
			</script>
<%
		}
%>
<HEAD>
<TITLE>黑龙江BOSS-营销提示</TITLE>
<script language="javascript">
	function closeWindow(){
		window.close();
	}
	function saveAction(btnObj){
		var activeArr = "";
		var activeIdArr = "";
		var belongGroupArr = "";
		/* 记录是否有接触的 */
		var activeFlag = "0";
		activeLength = "<%=result.length%>";
		for(var i = 0; i < activeLength; i++){
			var searchName = "active" + i;
			var activeId = "vActiveId" + i;
			var belongGroup = "vBelongGroup" + i;
			var activeVal = $("input[@name='" + searchName + "'][@checked]").val();
			var activeIdVal = $("#" + activeId + "").val();
			var belongGroupVal = $("#" + belongGroup + "").val();
			if(typeof(activeVal) == "undefined"){
				activeVal = 4;
			}else{
				activeFlag = "1";
			}
			activeArr += activeVal;
			activeArr += ",";
			
			activeIdArr += activeIdVal;
			activeIdArr += ",";
			
			belongGroupArr += belongGroupVal;
			belongGroupArr += ",";
		}
		//alert(activeIdArr + " | " + belongGroupArr + " | " + activeArr);
		if("0" == activeFlag){
			/* 一个都没选 */
			closeWindow();
		}else{
			var getdataPacket = new AJAXPacket("marketCfm.jsp","正在提交服务，请稍候......");
			getdataPacket.data.add("phoneNo","<%=phoneNo%>");
			getdataPacket.data.add("activeIdArr",activeIdArr);
			getdataPacket.data.add("belongGroupArr",belongGroupArr);
			getdataPacket.data.add("activeArr",activeArr);
			core.ajax.sendPacket(getdataPacket);
			getdataPacket = null;
		}
	}
	function doProcess(packet){
		var retCode2 = packet.data.findValueByName("retcode");
		var retMsg = packet.data.findValueByName("retmsg");
		if("000000" != retCode2){
			rdShowMessageDialog("错误代码：" + retCode2 + "错误信息：" + retMsg);
		}
		closeWindow();
	}
	function openSale(){
		alert("1");
		window.opener.openSale("<%=opcodeurl%>");
	  closeWindow();
	}
</script>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>
<FORM method=post name="fPubSimpSel">   
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">营销提示</div>
	</div>
	<table cellspacing="0">
		<tr>
			<th>营销案名称</th>
			<th>营销用语</th>
			<th>操作</th>
		</tr>
		<%
			String vActiveId = "";
			String vBelongGroup = "";
			String vSaleNote = "";
			String vActiveName = "";
			for(int i = 0;i < result.length; i++){
				if(result[i][0] != null){
					vActiveId = result[i][0];
				}
				if(result[i][1] != null){
					vBelongGroup = result[i][1];
				}
				if(result[i][2] != null){
					vSaleNote = result[i][2];
				}
				if(result[i][3] != null){
					vActiveName = result[i][3];
				}
		%>
		<tr>
			<td>
				<input type="hidden" name="marketId<%=i%>" id="marketId<%=i%>" value="hide1" />
				<input type="hidden" name="vActiveId<%=i%>" id="vActiveId<%=i%>" value="<%=vActiveId%>" />
				<input type="hidden" name="vBelongGroup<%=i%>" id="vBelongGroup<%=i%>" value="<%=vBelongGroup%>" />
				<%=vActiveName%>
			</td>
			<td>
				<%=vSaleNote%>
			</td>
			<td width="40%">
				&nbsp;&nbsp;
				<input type="radio" name="active<%=i%>" id="success<%=i%>" value="1" />成功
				&nbsp;&nbsp;
				<input type="radio" name="active<%=i%>" id="interest<%=i%>" value="2" />感兴趣
				&nbsp;&nbsp;
				<input type="radio" name="active<%=i%>" id="turnDown<%=i%>" value="3" />拒绝
			</td>
		</tr>
		<%
			}
		%>
		 		
		<tr id="footer">
			<td colspan="3">
				<input type="button" name="close" id="close" value="确认" 
				  class="b_foot" onclick="saveAction()" rownum="99" />
				<input type="button" name="close" id="close" value="关闭" 
				  class="b_foot" onclick="closeWindow()" rownum="99" />
			</td>
		</tr>

	</table>
	<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>    
