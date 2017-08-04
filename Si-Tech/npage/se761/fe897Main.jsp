<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/********************
version v3.0
������: si-tech
ningtn 2012-6-20 16:06:37
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
	String opCode=request.getParameter("opCode");
  String opName=request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode= (String)session.getAttribute("regCode");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String phoneNo = request.getParameter("phoneNo");
  String cccTime=new java.text.SimpleDateFormat("yyyyMMdd HHmmss", Locale.getDefault()).format(new java.util.Date());
 	String printAccept="";
 	String cancelPhone = "";
%>
		<wtc:service name="sPreSrcQry" routerKey="region" routerValue="<%=regionCode%>"
		  retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value=""/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="1"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	if(!"000000".equals(retCode)){
%>
		<script language="javascript">
			rdShowMessageDialog("<%=retCode%>:<%=retMsg%>",0);
			/**************Ϊ�˲���*/
			window.location.href="fe759Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			
		</script>
<%
	}else{
		cancelPhone = result[0][0];
	}
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		printAccept = seq;
%>

<link href="css/prodRevoStyle.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="pubProdScript.js"></script>
<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>
<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
<script type="text/javascript" src="/npage/public/pubLightBox.js"></script>
<script language="javascript">
	var prodRevolution = new Prod_Revolution();
	$(document).ready(function(){
		getUserBaseInfo();
		getPriceRevoMsg();
		/*������ע��Ĭ��ֵ*/
		$("#opNote").val("ӪҵԱ<%=workNo%>Ϊ<%=phoneNo%>�û�������Դת��");
	});
	function getPriceRevoMsg(){
		var getdataPacket = new AJAXPacket("/npage/se761/fe759PubPriceRevoMsg.jsp","���Ժ�...");
		getdataPacket.data.add("opCode","<%=opCode%>");
		
		getdataPacket.data.add("phoneNo","<%=cancelPhone%>");
		/**************Ϊ�˲���
		getdataPacket.data.add("phoneNo","13946162284");**/
		getdataPacket.data.add("qryType","3");
		getdataPacket.data.add("flag","0");
		core.ajax.sendPacketHtml(getdataPacket,doGetPriceRevoMsgHtml);
		getdataPacket =null;
	}
	function doGetPriceRevoMsgHtml(data){
		$("#stockTab").empty();
		$("#stockTab").append(data);
		var showMsg = "";
		$.each($("#stockTab").find("table").eq(0).find("tr:gt(0)"),function(i,n){
			showMsg += $(this).find("th:eq(0)").text() + $(this).find("td:eq(2)").text()+"; ";
		});
		$("#allResource").text(showMsg);
	}
	function getUserBaseInfo(){
		/*��ȡ�û���Ϣ*/
		var getdataPacket = new AJAXPacket("/npage/public/pubGetUserBaseInfo.jsp","���ڻ�����ݣ����Ժ�......");
		getdataPacket.data.add("phoneNo","<%=phoneNo%>");
		getdataPacket.data.add("opCode","<%=opCode%>");
		core.ajax.sendPacket(getdataPacket,doGetPrypayBack);
		getdataPacket = null;
	}
	function doGetPrypayBack(packet){
		var retCode = packet.data.findValueByName("retcode");
		var retMsg = packet.data.findValueByName("retmsg");
		var stPMvPhoneNo = packet.data.findValueByName("stPMvPhoneNo");
		var stPMcust_id = packet.data.findValueByName("stPMcust_id");
		var stPMcust_name = packet.data.findValueByName("stPMcust_name");
		var stPMsm_name = packet.data.findValueByName("stPMsm_name");
		var openTime = packet.data.findValueByName("openTime");
		var stPMrun_name = packet.data.findValueByName("stPMrun_name");
		var unbillFee = packet.data.findValueByName("unbillFee");
		/*����Ԥ��*/
		var stPMtotalPrepay = packet.data.findValueByName("stPMtotalPrepay");
		var stPMgrpbig_name = packet.data.findValueByName("stPMgrpbig_name");
		var stPMcard_name = packet.data.findValueByName("stPMcard_name");
		var show1270V2 = packet.data.findValueByName("show1270V2");
		var stPMid_name = packet.data.findValueByName("stPMid_name");
		var nobillpay = packet.data.findValueByName("nobillpay").trim();
		var now_prepayFee = packet.data.findValueByName("now_prepayFee").trim();
		var zx_yc_fee = packet.data.findValueByName("zx_yc_fee").trim();
		var pt_yc_fee = packet.data.findValueByName("pt_yc_fee").trim();
		var limitOwe = packet.data.findValueByName("limitOwe").trim();
		$("#stPMvPhoneNo").text(stPMvPhoneNo);
		$("#stPMcust_id").text(stPMcust_id);
		$("#stPMcust_name").text(stPMcust_name);
		$("#stPMsm_name").text(stPMsm_name);
		$("#openTime").text(openTime);
		$("#stPMrun_name").text(stPMrun_name);
		$("#unbillFee").text(unbillFee);
		/*��������Ŀ���Ԥ��*/
		//$("#prepayFee").text(stPMtotalPrepay);
		$("#limitOwe").text(limitOwe);
		$("#stPMcard_name").text(stPMcard_name);
		$("#show1270V2").text(show1270V2);
		$("#stPMid_name").text(stPMid_name);
		/*���������*/
		$("#nobillpay").text(nobillpay);
		$("#now_prepayFee").text(now_prepayFee);
		//$("#zx_yc_fee").text(zx_yc_fee);
		//$("#pt_yc_fee").text(pt_yc_fee);
	}

	function clearPage(){
		location = "/npage/se761/fe897Main.jsp?phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
	}
	function doBack(){
		window.location.href="fe759Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}

	function doNext(subButton){
		
		/* ��ť�ӳ� */
		controlButt(subButton);
		if(!check(document.frm)){
			return false;
		}
		frm.action="/npage/se761/fe897Cfm.jsp";
		frm.submit();
	}
	function replaceAllSign(str){
		/*����ȡJSON�������ܴ�ð�ţ����ֻ�����˫����*/
		str = str.replace(/\//g,"");
		str = str.replace(/\:/g,"");
		str = str.replace(/\-/g,"");
		return str;
	}
</script>
<body class="second">
	<form name="frm" method="post">
		<div id="Operation_Title">
			<div class="icon"></div>
				<B><font face="Arial"><%=WtcUtil.repNull(opCode)%></font>��<%=WtcUtil.repNull(opName)%></B>
			</div>
			<div class="prodContent">
			 	<input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
			 	<input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
			 	<div class="m-box">
				<div class="m-box1-top">
					�û���Ϣ
				</div>
				<div class="m-box-txt2">
					<table class="cust-detail">
						<tr>
							<td>
								�ƶ����룺
								<font class="cust-font" id="stPMvPhoneNo"></font>
							</td>
							<td>
								�ͻ�ID ��
								<font class="cust-font" id="stPMcust_id"></font>
							</td>
							<td>
								�ͻ����ƣ�
								<font class="cust-font" id="stPMcust_name"></font>
							</td>
							<td>
								ҵ��Ʒ�ƣ�
								<font class="cust-font" id="stPMsm_name"></font>
							</td>
						</tr>
						<tr>
							<td>
								����ʱ�䣺
								<font class="cust-font" id="openTime"></font>
							</td>
							<td>
								����״̬��
								<font class="cust-font" id="stPMrun_name"></font>
							</td>
							<td>
								�û�����/Mֵ��
								<font class="cust-font" id="show1270V2"></font>
							</td>
							<td>
								֤�����ͣ�
								<font class="cust-font" id="stPMid_name"></font>
							</td>
						</tr>
						<tr>
							<td>
								�����ȣ�
								<font class="cust-font" id="limitOwe"></font>
							</td>
							<td>
								��ͻ����
								<font class="cust-font" id="stPMcard_name"></font></font>
							</td>
							<td>
								�������ѽ�
								<font class="cust-font" id="nobillpay"></font>
							</td>
							<td>
								Ԥ�����
								<font class="cust-font" id="now_prepayFee"></font>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!---ת�����--->
			<div class="m-box">
				<div class="m-box1-top">
					��Դת��
				</div>
				<div class="m-box-txt2">
					<table>
						<tr>
							<td width="25%">ת������</td>
							<td>
								<input type="text" name="preToNo" maxlength="11"
								 data-bind="value:givePhoneNo,valueUpdate:'afterkeydown'" 
								 v_must="1" v_type="mobphone" onblur = "checkElement(this)"/>
								<font class="orange">*</font>
							</td>
						</tr>
						<tr>
							<td>
								��ת����Դ��
							</td>
							<td>
								<span id="allResource"></span>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!---��ѯ���--->
			<input type="hidden" name="preFromNo" value="<%=cancelPhone%>"/>
<div id="prodLibDiv" style="display:none;">
	<div class="m-box-txt2" id="stockTab">
	</div>
</div>
			<table cellspacing="0">
				<tr id="footer"> 
					<td> 
						<div align="center"> 
						<input name="confirm" type="button" class="b_foot" value="ȷ���ύ" 
						 data-bind="enable:givePhoneNo().length>0" onClick="doNext(this)" />
						&nbsp; 
						<input name="clear" type="button" class="b_foot" value="���" onClick="clearPage()" />
						&nbsp; 
						<input name="goBack" type="button" class="b_foot" value="����" onClick="doBack()" />
						&nbsp;
						<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�" />
						&nbsp; 
						</div>
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="printAccept" name="printAccept" value="<%=printAccept%>" />
		<input type="hidden" id="opNote" value="" maxlength="60" size="100" />
		<input type="hidden" id="myJSONText" name="myJSONText" />
		<input type="hidden" id="phoneNo" name="phoneNo" value="<%=phoneNo%>" />
		
	</form>
</body>
<script type="text/javascript" language="JavaScript">
    var viewModel = {
        givePhoneNo: ko.observable("")
    }
    ko.applyBindings(viewModel);
</script>
</html>