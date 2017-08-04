<%
/*************************************
* 功  能: g378·虚拟V网用户办理 
* 版  本: version v1.0
* 开发商: si-tech
* 创建者: liujian @ 2012-12-31 13:52:45
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	
	String opCode     =  request.getParameter("opCode");
    String opName     =  request.getParameter("opName");
    String workNo     = (String)session.getAttribute("workNo");
    String password = (String) session.getAttribute("password");
    String regionCode = (String)session.getAttribute("regCode");
    String phoneNo = request.getParameter("phoneNo");
    String powerRight = WtcUtil.repNull((String)session.getAttribute("powerRight"));
	boolean qryFlag = false;
	StringBuffer offerSb = new StringBuffer("");
	String sql_select1 = "select trim(a.offer_id),trim(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region d,DBCUSTADM.sregioncode e where a.offer_attr_type='VpG0' and a.offer_id=d.offer_id and d.group_id=e.group_id and e.region_code=:region_code and a.exp_date>=sysdate and a.eff_date<=sysdate and d.right_limit <= :right_limit order by a.offer_id";
	String srv_params1 = "region_code=" + regionCode + ",right_limit=" + powerRight ;
	String userPhoneNo = "", groupNo = "", groupName = "", userName = "", currOffer = "",nextOffer = "";
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
	<wtc:service name="sg381Qry"  routerKey="regioncode" 
			routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>	
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="qryArr"  scope="end"/>
<%
	if(retCode.equals("000000") && qryArr.length > 0) {
		qryFlag = true;
		groupNo = qryArr[0][0]; 
		groupName = qryArr[0][1];
		userPhoneNo = qryArr[0][2];
		userName = qryArr[0][3]; 
		currOffer = qryArr[0][4];
		nextOffer = qryArr[0][5];
		if(opCode.equals("g379")) {
%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="rstCode2" retmsg="rstMsg2" outnum="2">
				<wtc:param value="<%=sql_select1%>"/>
				<wtc:param value="<%=srv_params1%>"/>
			</wtc:service>
			<wtc:array id="result_offer" scope="end"/>
	<%
			
			for(int i=0; i<result_offer.length; i++) {
				  offerSb.append("<option value ='").append(result_offer[i][0]).append("'>")
						 .append(result_offer[i][1])
						 .append("</option>");
			}
		}
	}
%>		        	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>

<script type=text/javascript>
  $(function() {
  		$(window.parent.document).find("iframe[@id='groupIframe']").css('height','0px');
	
  		$('#offerSelect').css('width','300px');
  		if(<%=qryFlag%>) {
  			$('#currOffer').css('width','300px');
  			if('<%=opCode%>' == 'g379') {
  				$('#submitBtn').val("确定");
  				$('#offerSelect').css('display','block');
  				$('#offerSelect').append("<%=offerSb.toString()%>");
  				//TODO 设置当前资费的值不可选
  			}else if('<%=opCode%>' == 'g380') {
  				$('#submitBtn').val("退出");
  				$('#nextOfferTd').append('<input type="text" name="currOffer" id="nextOffer" value="<%=nextOffer%>" class="InputGrey" readonly />');
  			}
			showTable();
		}else {
			 clearTable();
			 rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
		}
		
		$('#submitBtn').click(function() {
			if('<%=opCode%>' == 'g379') {
				//TODO 
			}else if('<%=opCode%>' == 'g380') {
				var packet = new AJAXPacket("fg379_ajax.jsp","正在获得相关信息，请稍候......");
				var _data = packet.data;
				_data.add("opCode","<%=opCode%>");
				_data.add("userPhoneNo","<%=userPhoneNo%>");
				_data.add("groupNo",'<%=groupNo%>');
				_data.add("method","g380cfm");
				core.ajax.sendPacket(packet,g380cfmProcess);
				packet = null;	
			}	
		});
		//隐藏父页面的遮罩
		window.parent.hideBox();
  });
  
  function showTable() {
  	$('#userTable').css('display','block');
  	$(window.parent.document).find("iframe[@id='groupIframe']").css('height',$("body").height()+20 + 'px');		
  }
  function clearTable() {
  		$('#tabList2').empty();
  		$('#userTable').css('display','none');
  }
  
	function g380cfmProcess(package) {
		var g380cfmCode = package.data.findValueByName("g380cfmCode");
		var g380cfmMsg = package.data.findValueByName("g380cfmMsg");	
		if(g380cfmCode == '000000' || g380cfmCode == '0') {
			//TODO 刷新当前页面
			rdShowMessageDialog("虚拟V网用户退出成功！");
		}else {
			rdShowMessageDialog("错误代码：" + g380cfmCode +  "，错误信息：" + g380cfmMsg,0);	
		}
	}
</script>

<body>
<form name="frm2" action="" method="post" >
		<div id="userTable">
			<div class="title">
				<div id="title_zi">用户信息</div>
			</div>
			
			<div id="Operation_Table" style="padding:0px">
				<table cellspacing=0 >
					<tr>
						<td class='blue'>集团号</td>
						<td>
							<input type="text" name="groupNo" id="groupNo" value="<%=groupNo%>" class="InputGrey" readonly />
						</td>
						<td class='blue'>集团名称</td>
						<td>
							<input type="text" name="groupName" id="groupName" value="<%=groupName%>" class="InputGrey" readonly />
						</td>
				    </tr>
				    <tr>
						<td class='blue'>用户手机号码</td>
						<td>
							<input type="text" name="userPhoneNo" id="userPhoneNo" value="<%=userPhoneNo%>" class="InputGrey" readonly />
						</td>
						<td class='blue'>用户名称</td>
						<td>
							<input type="text" name="userName" id="userName" value="<%=userName%>" class="InputGrey" readonly />
						</td>
				    </tr>
				    <tr>
						<td class='blue'>当月资费</td>
						<td colspan="3">
							<input type="text" name="currOffer" id="currOffer" value="<%=currOffer%>" class="InputGrey" readonly />
						</td>
						
				    </tr>
				    <tr>
				    	<td class='blue'>下月资费</td>
						<td id="nextOfferTd" colspan="3"><select id="offerSelect" style="display:none"></select></td>	
				    </tr>
				    <tr id='footer'>
				        <td colspan='4'>
				            <input type="button"  id="submitBtn" class='b_foot' value="" name="submitBtn" />
				        </td>
				    </tr>
				</table>
			</div>
		</div>
		
</form>
</body>
</html>