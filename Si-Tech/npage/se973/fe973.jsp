<%
    /*************************************
    * ��  ��: ����˺Ŷ˿ڳ�ʼ�� e973
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-8-9
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
		String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String loginNo = (String)session.getAttribute("workNo");
    String password = (String)session.getAttribute("password");
    String regCode = (String)session.getAttribute("regCode");
    String broadPhone = request.getParameter("broadPhone");
    String phoneNo = (String)request.getParameter("activePhone");
%>  
<HTML>
<HEAD>
    <TITLE>����˺Ŷ˿ڳ�ʼ��</TITLE>
<script language="javascript">
  $(document).ready(function(){
  	/*2015/03/02 17:10:10 gaopeng �����ڿͷ��������������Ӷ˿ڳ�ʼ�����ܵ�����
  		����ֻ������ͨ���(kd)����ʱ��(kf)Ʒ�ơ����԰����ҵ�񣬱��������������Ʒ�ƣ�������ȷ��
  	*/
  	getPubSmCode("<%=broadPhone%>");
  	var pubSmCode = $.trim($("#pubSmCode").val());
  	if(pubSmCode != "kd" && pubSmCode != "kf" && pubSmCode != "kh" && pubSmCode != "ki"){
  		rdShowMessageDialog("ֻ������ͨ���(kd)����ʱ��(kf)Ʒ�ơ���ͨ���(kh)Ʒ�ơ����ſ��(ki)Ʒ�ơ����԰����ҵ��",0);
  		removeCurrentTab();
  	}
  	
  	getUserBaseInfo();
  	
  });
  
  function getUserBaseInfo(){
    var getdataPacket = new AJAXPacket("/npage/public/pubGetUserBaseInfo.jsp","���ڻ�����ݣ����Ժ�......");
		getdataPacket.data.add("phoneNo","<%=phoneNo%>");
		getdataPacket.data.add("opCode","<%=opCode%>");
		core.ajax.sendPacket(getdataPacket,doGetPrypayBack);
		getdataPacket = null;
  }

  function doGetPrypayBack(packet){
  	var retCode = packet.data.findValueByName("retcode");
  	var retMsg = packet.data.findValueByName("retmsg");
  	var stPMcust_name = packet.data.findValueByName("stPMcust_name");
  	var stPMrun_name = packet.data.findValueByName("stPMrun_name");
  	var stPMid_name = packet.data.findValueByName("stPMid_name");
  	var stPMid_iccid = packet.data.findValueByName("stPMid_iccid");
  	var stPMcust_address = packet.data.findValueByName("stPMcust_address");
  	$("#stPMcust_name").text(stPMcust_name);
  	$("#stPMrun_name").text(stPMrun_name);
  	$("#stPMid_name").text(stPMid_name);
  	$("#stPMid_iccid").text(stPMid_iccid);
  	$("#stPMcust_address").text(stPMcust_address);
  }
  
  /*2014/04/04 11:02:20 gaopeng ���ù�����ѯ����Ʒ��sm_code*/
	function getPubSmCode(kdNo){
			var getdataPacket = new AJAXPacket("/npage/public/pubGetSmCode.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("phoneNo","");
			getdataPacket.data.add("kdNo",kdNo);
			core.ajax.sendPacket(getdataPacket,doPubSmCodeBack);
			getdataPacket = null;
	}
	function doPubSmCodeBack(packet){
		retCode = packet.data.findValueByName("retcode");
		retMsg = packet.data.findValueByName("retmsg");
		smCode = packet.data.findValueByName("smCode");
		if(retCode == "000000"){
			$("#pubSmCode").val(smCode);
		}
	}
  
  function subInfo(){
    var packet = new AJAXPacket("fe973_ajax_subInfo.jsp","���ڻ�����ݣ����Ժ�......");
    packet.data.add("broadPhone","<%=broadPhone%>");
		packet.data.add("phoneNo","<%=phoneNo%>");
		packet.data.add("opCode","<%=opCode%>");
		core.ajax.sendPacket(packet,doSubInfo);
		packet = null;
  }
  
  function doSubInfo(packet){
    var retCode = packet.data.findValueByName("retcode");
    var retMsg = packet.data.findValueByName("retmsg");
    if(retCode!="000000"){
      rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
      window.location.href="fe973.jsp?broadPhone=<%=broadPhone%>&activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
    }else{
      rdShowMessageDialog("�ύ�ɹ���",2);
      window.location.href="fe973.jsp?broadPhone=<%=broadPhone%>&activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
    }
  }

</script>
</HEAD>
<body>
<form name="frme973" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
		<div id="title_zi">�û���Ϣ</div>
	</div>
	<table>
		<tr>
			<td class="blue" width="15%">����˺�</td>
			<td width="15%">
				<span id="cfmLogin"><%=broadPhone%></span>
			</td>
			<td class="blue" width="15%">�ͻ�����</td>
			<td>
				<span id="stPMcust_name"></span>
			</td>
				<td class="blue" width="15%">�ͻ�״̬</td>
			<td>
				<span id="stPMrun_name"></span>
			</td>
		</tr>
		<tr style="display:none">
			<td class="blue" width="15%">֤������</td>
			<td>
				<span id="stPMid_name"></span>
			</td>
			<td class="blue" width="15%">֤������</td>
			<td>
				<span id="stPMid_iccid"></span>
			</td>
		  <td class="blue" width="15%">סַ(��֤����ַ)</td>
			<td>
				<span id="stPMcust_address"></span>
			</td>
		</tr>
		<tr > 
			  <td colspan="6" align="center" id="footer">
			<input name="confirm" type="button" class="b_foot" value="ȷ��" onClick="subInfo()" />
			&nbsp; 
			<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�" />
			&nbsp;
			</td>
		</tr>
	</table>
	<!-- 2014/04/04 11:15:23 gaopeng Ʒ��sm_code -->
	<input type="hidden" name="pubSmCode" id="pubSmCode" value="" />
</div>
  <%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>

