<%
  /*
   * 功能:MIS-POS统一冲正-查询
   * 版本: 1.0
   * 日期: 20121010
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/common/serverip.jsp" %>
<!--加载工行控件 -->
<%@ include file="/npage/public/posICBC.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		String orgCode =(String)session.getAttribute("orgCode");
    String regionCode = (String)session.getAttribute("regCode");
    String sWorkNo = (String)session.getAttribute("workNo");
 		String dNopass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("phoneNo");
		//流水号
 		String iLoginAccept = getMaxAccept();
 		//真实ip
 		String serverIp=realip.trim();
 		//查询客户信息sql
 		String custName="";
		String custSql = "select doc.cust_name from dcustdoc doc,dcustmsg msg where doc.cust_id = msg.cust_id and msg.phone_no='"+phoneNo+"'";
		
    String ip = (String)session.getAttribute("ipAddr");
 		String ssss = "通过phoneNo[" + phoneNo + "]查询";
%>
<wtc:service name="sUserCustInfo" outnum="40" >
      <wtc:param value="<%=iLoginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=sWorkNo%>"/>
      <wtc:param value="<%=dNopass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value="<%=ip%>"/>
      <wtc:param value="<%=ssss%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>

  <wtc:array id="result11" scope="end" />


<!--调用fusk查询服务  MIS-POS统一冲正 gaopeng 20121012-->
<wtc:service name="sg175Init" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode1" retmsg="errMsg1"  outnum="16">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="01" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=sWorkNo%>" />
		<wtc:param value="<%=dNopass%>" />
		<wtc:param value="<%=phoneNo%>" />
		<wtc:param value="" />
	</wtc:service>
<wtc:array id="result1" scope="end" />
		
<!--调用xiaoliang查询服务  MIS-POS统一冲正 gaopeng 20121012-->
<wtc:service name="getBankPosInf" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode2" retmsg="errMsg2"  outnum="8">		
		<wtc:param value="<%=phoneNo%>" />	
	</wtc:service>
<wtc:array id="result2" scope="end" />

<%
		if(result11.length <= 0)
		{
%>
<script language="JavaScript">
			rdShowMessageDialog("该用户不是在网用户或状态不正常！");
			removeCurrentTab();
</script>
<%
			return ;
		}
		else
		{
			custName=result11[0][5];
			
		}
%>


<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
			
		});
		function doSubmit()
		{
			if(check(f1))
			{
				var sG175 = $("input[name='sG175']:checked").val();
				if(typeof(sG175)=="undefined")
				{
					rdShowMessageDialog("请选择需要冲正的业务！",1);
				}
				else
					{
						var sFlag="";
						var sG175Arr = sG175.split("|");
						//如果是CRM冲正
						if(sG175Arr[2]=="0")
						{
							$("input[name='iOldAccept']").val(sG175Arr[0]);
							$("input[name='iRrn']").val(sG175Arr[1]);
							$("input[name='iOpNote']").val("MIS-POS统一冲正");
							//这里调用ICBCCommon进行冲正
							//原业务流水|原交易系统检索号|标志位|应退金额|原交易日期(提交日期)|分期付款期数|原交易终端号|原交易日期(提交日期)
							var transType     = "04";																	 /*交易类型 这里为冲正*/         
							var bMoney        = sG175Arr[3];          							 /*交易金额 这里是应退金额*/
							if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";  
							var response_time = ""+sG175Arr[4];                 					 /*原交易日期 */			
							var rrn           = sG175Arr[1];                           /*原交易系统检索号 */ 
							var instNum       = sG175Arr[5];                           /*分期付款期数 */  
							var terminalId    = sG175Arr[6];                           /*原交易终端号 */
							getSysDate();
							var request_time  = document.all.Request_Time.value;     	 /*交易提交日期  */ 
							var workno        = "<%=sWorkNo%>";                        /*交易操作员 */ 
							var orgCode       = "<%=orgCode%>";                        /*营业员归属 */ 
							var groupId       = "<%=groupID%>";                        /*营业员归属机构 */ 
							var phoneNo       = "<%=phoneNo%>";                        /*交易缴费号 */ 
							var toBeUpdate    = "";						                         /*预留字段 */         
							var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
										
								if(icbcTran=="succ")
								{
									f1.action="/npage/sg175/fg175Cfm.jsp";
									f1.submit();
								}		
							
						}
						//如果是计费冲正
						else if(sG175Arr[2]=="1")
							{
								$("input[name='iOldAccept']").val(sG175Arr[0]);
							//这里调用ICBCCommon进行冲正
							//原业务流水|原交易系统检索号|标志位|应退金额|原交易日期(提交日期)|分期付款期数|原交易终端号|原交易日期(提交日期)
							var transType     = "04";																	 /*交易类型 这里为冲正*/         
							var bMoney        = sG175Arr[3];          							 /*交易金额 这里是应退金额*/
							if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";  
							var response_time = ""+sG175Arr[4];                 					 /*原交易日期 */			
							var rrn           = sG175Arr[1];                           /*原交易系统检索号 */ 
							var instNum       = sG175Arr[5];                           /*分期付款期数 */  
							var terminalId    = sG175Arr[6];                           /*原交易终端号 */
							getSysDate();
							var request_time  = document.all.Request_Time.value;     	 /*交易提交日期  */ 
							var workno        = "<%=sWorkNo%>";                        /*交易操作员 */ 
							var orgCode       = "<%=orgCode%>";                        /*营业员归属 */ 
							var groupId       = "<%=groupID%>";                        /*营业员归属机构 */ 
							var phoneNo       = "<%=phoneNo%>";                        /*交易缴费号 */ 
							var toBeUpdate    = "";						                         /*预留字段 */         
							var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);		
								if(icbcTran=="succ")
								{
								f1.action="/npage/sg175/fg175Cfm2.jsp";
								f1.submit();
								}
							}
					}
				
			}
			
		}
	
	function getSysDate()
		{
			var myPacket = new AJAXPacket("/npage/s1300/s1300_getSysDate.jsp","正在获得系统时间，请稍候......");
			myPacket.data.add("verifyType","getSysDate");
			core.ajax.sendPacket(myPacket);
			myPacket = null;
		
		}
		function doProcess(packet)
     	{
					var verifyType = packet.data.findValueByName("verifyType");
					var sysDate = packet.data.findValueByName("sysDate");
					if(verifyType=="getSysDate"){
						//生效时间
						document.all.Request_Time.value = sysDate;
						return false;
					}
     	}
	function padLeft(str, pad, count)
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">客户信息</div>
	</div>
	<table>
		<tr>
			<td class="blue" >客户姓名</td>
			<td ><%=custName%></td>
			<td class="blue" >手机号码</td>
			<td ><%=phoneNo%></td>
		</tr>
	</table>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table>
		<th></th>
		<th>缴费类型</th>
		<th>操作代码</th>
		<th>业务名称</th>
		<th>应退金额</th>
		<th>卡序列号</th>
		<th>操作工号</th>
		<th>操作时间</th>
		<th>分期付款期数</th>
		<th>银行流水</th>
		<%              
		if("0".equals(errCode1) || "000000".equals(errCode1))
		{
            		for(int i=0;i<result1.length;i++){
     %>
		<tr>
			<td width="5%"><input name="sG175" type="radio" value="<%=result1[i][0]%>|<%=result1[i][10]%>|0|<%=result1[i][3]%>|<%=result1[i][11]%>|<%=result1[i][6]%>|<%=result1[i][9]%>|<%=result1[i][11]%>" /></td>
			<td width="10%">
				
				<%
				if(result1[i][2]=="BY" || "BY".equals(result1[i][2])){
				%>
				工商银行
				<%
				}
			else if(result1[i][2]=="BX" || "BX".equals(result1[i][2])){
				%>
				建设银行
				<%
				}
			else if(result1[i][2]=="EI" || "EI".equals(result1[i][2])){
				%>
				工商银行分期付款
				<%
				}
				%>
				</td>
			<td width="10%"><%=result1[i][1]%></td>
			<td width="10%"><%=result1[i][13]%></td>
			<td width="10%"><%=result1[i][3]%></td>
			<td width="15%"><%=result1[i][5]%></td>
			<td width="10%"><%=result1[i][4]%></td>
			<td width="10%"><%=result1[i][7]%></td>
			<td width="10%"><%=result1[i][6]%></td>
			<td width="10%"><%=result1[i][0]%></td>
		</tr>
		<%
		}
		}
	else{
		%>
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=errCode1%>，错误信息：<%=errMsg1%>");
				removeCurrentTab();
		</script>

		<%
		}
		%>
		
		
		<%              
		if("0".equals(errCode2) || "000000".equals(errCode2) || "123403".equals(errCode2))
		{
            		for(int i=0;i<result2.length;i++){
     %>
		<tr>
			<td algin="center"><input name="sG175" type="radio" value="<%=result2[i][6]%>||1" /></td>
			<td>
				<%
				if(result2[i][7]=="BY" || "BY".equals(result2[i][7])){
				%>
				工商银行
				<%
				}
			else if(result2[i][7]=="BX" || "BX".equals(result2[i][7])){
				%>
				建设银行
				<%
				}
				%>
				</td>
			<td><%=result2[i][0]%></td>
			<td><%=result2[i][1]%></td>
			<td><%=result2[i][2]%></td>
			<td><%=result2[i][3]%></td>
			<td><%=result2[i][4]%></td>
			<td><%=result2[i][5]%></td>
			<td>0</td>
			<td><%=result2[i][6]%></td>
		</tr>
		<%
		}
		}
	else{
		%>
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=errCode2%>，错误信息：<%=errMsg2%>");
				removeCurrentTab();
			</script>

		<%
		}
		%>
	</table>
	
	<table cellSpacing="0">
		<tr align="center">
			<td align="center" id="footer">
			<input type="button" class="b_foot" value="确认" onclick="doSubmit()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab();"/>
			</td>
		</tr>
	</table>
	<!--操作代码-->
	<input type="hidden" name="iOpCode" value="<%=opCode%>"/>
	<!--操作名-->
	<input type="hidden" name="iOpName" value="<%=opName%>"/>
	<!--工号-->
	<input type="hidden" name="iLoginNo" value="<%=sWorkNo%>"/>
	<!--工号密码-->
	<input type="hidden" name="iLoginPwd" value="<%=dNopass%>"/>
	<!--手机号-->
	<input type="hidden" name="iPhoneNo" value="<%=phoneNo%>"/>
	<!--用户密码-->
	<input type="hidden" name="iUserPwd" value=""/>
	<!--操作备注-->
	<input type="hidden" name="iOpNote" value=""/>
	<!--原业务流水-->
	<input type="hidden" name="iOldAccept" value=""/>
	<!--原交易系统检索号-->
	<input type="hidden" name="iRrn" value=""/>
	<!--ip-->
	<input type="hidden" name="inIpAddr" value="<%=serverIp%>"/>
	<!--orgCode-->
	<input type="hidden" name="iOrgCode" value="<%=orgCode%>"/>
	<input type="hidden" name="Request_Time" value=""/>
	
	
			<input type="hidden" name="MerchantNameChs"  value=""><!-- 从此开始以下为银行参数 -->
			<input type="hidden" name="MerchantId"  value="">
			<input type="hidden" name="TerminalId"  value="">
			<input type="hidden" name="IssCode"  value="">
			<input type="hidden" name="AcqCode"  value="">
			<input type="hidden" name="CardNo"  value="">
			<input type="hidden" name="BatchNo"  value="">
			<input type="hidden" name="Response_time"  value="">
			<input type="hidden" name="Rrn"  value="">
			<input type="hidden" name="AuthNo"  value="">
			<input type="hidden" name="TraceNo"  value="">
			<input type="hidden" name="Request_time"  value="">
			<input type="hidden" name="CardNoPingBi"  value="">
			<input type="hidden" name="ExpDate"  value="">
			<input type="hidden" name="Remak"  value="">
			<input type="hidden" name="TC"  value="">
			<input type="hidden" id="transTotal" name="transTotal"  value="">
			
	<%@ include file="/npage/include/footer.jsp" %>	
</form>
</body>


</html>