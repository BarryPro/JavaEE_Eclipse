<%
    /********************
     version v2.0
     ������: si-tech
     *
     *create:wanghfa@2010-9-26 ����֮��
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>��������֮��</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<%
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String pwrf = WtcUtil.repNull(request.getParameter("pwrf"));
	System.out.println("=========wanghfa========= fb609_main.jsp " + opCode + ", " + opName + ", " + pwrf);
	
	String fatherPhone1 = WtcUtil.repNull(request.getParameter("fatherPhone1"));
	String fatherPwd1 = WtcUtil.repNull(request.getParameter("fatherPwd1"));
	String memberPhone1 = WtcUtil.repNull(request.getParameter("memberPhone1"));
	String memberPwd1 = WtcUtil.repNull(request.getParameter("memberPwd1"));
	
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String noPass = WtcUtil.repNull((String)session.getAttribute("password"));
	String result[][] = new String[1][13];
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="printAccept"/>

<%
	System.out.println("===========wanghfa=sB608Valid==0====== loginAccept = ");
	System.out.println("===========wanghfa=sB608Valid==1====== chnSource = 01");
	System.out.println("===========wanghfa=sB608Valid==2====== opCode = " + opCode);
	System.out.println("===========wanghfa=sB608Valid==3====== workNo = " + workNo);
	System.out.println("===========wanghfa=sB608Valid==4====== noPass = " + noPass);
	System.out.println("===========wanghfa=sB608Valid==5====== �ҳ����� = " + fatherPhone1);
	System.out.println("===========wanghfa=sB608Valid==6====== �ҳ����� = " + fatherPwd1);
	System.out.println("===========wanghfa=sB608Valid==7====== ��Ա���� = " + memberPhone1);
	System.out.println("===========wanghfa=sB608Valid==8====== ��Ա���� = " + memberPwd1);
%>
<wtc:service name="sB608Valid" routerKey="phone" routerValue="<%=fatherPhone1%>" retcode="retCode1" retmsg="retMsg1" outnum="13">
	<wtc:param value=""/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=noPass%>"/>
	<wtc:param value="<%=fatherPhone1%>"/>
	<wtc:param value="<%=fatherPwd1%>"/>
	<wtc:param value="<%=memberPhone1%>"/>
	<wtc:param value="<%=memberPwd1%>"/>
</wtc:service>
<wtc:array id="result1" scope="end"/>
<%
	System.out.println("===========wanghfa======= sB608Valid : " + retCode1 + ", " + retMsg1);
	if (!"000000".equals(retCode1)) {
%>
		<script language=javascript>
			rdShowMessageDialog("<%=retMsg1%>", 1);
			history.go(-1);
		</script>
<%
	} else {
		for (int i = 0; i < result1.length; i ++) {
			for (int j = 0; j < result1[i].length; j ++) {
				System.out.println("========wanghfa======= sB608Valid : result1[" + i + "][" + j + "] = " + result1[i][j]);
				result[i][j] = result1[i][j];
			}
		}
%>


<%
	System.out.println("===========wanghfa=sB608Qry==0====== loginAccept = ");
	System.out.println("===========wanghfa=sB608Qry==1====== chnSource = 01");
	System.out.println("===========wanghfa=sB608Qry==2====== opCode = " + opCode);
	System.out.println("===========wanghfa=sB608Qry==3====== workNo = " + workNo);
	System.out.println("===========wanghfa=sB608Qry==4====== noPass = " + noPass);
	System.out.println("===========wanghfa=sB608Qry==5====== �ҳ����� = " + fatherPhone1);
	System.out.println("===========wanghfa=sB608Qry==6====== �ҳ����� = " + fatherPwd1);
	System.out.println("===========wanghfa=sB608Qry==7====== ��Ա���� = " + memberPhone1);
	System.out.println("===========wanghfa=sB608Qry==8====== ��Ա���� = " + memberPwd1);
	System.out.println("===========wanghfa=sB608Qry==9====== ��ѯ���� = 0");
%>
<wtc:service name="sB608Qry" routerKey="phone" routerValue="<%=fatherPhone1%>" retcode="retCode2" retmsg="retMsg2" outnum="3">
	<wtc:param value=""/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=noPass%>"/>
	<wtc:param value="<%=fatherPhone1%>"/>
	<wtc:param value="<%=fatherPwd1%>"/>
	<wtc:param value="<%=memberPhone1%>"/>
	<wtc:param value="<%=memberPwd1%>"/>
	<wtc:param value="0"/>
</wtc:service>
<wtc:array id="result2" scope="end"/>
<%
	System.out.println("===========wanghfa======= sB608Qry : " + retCode2 + ", " + retMsg2);
	if ("000000".equals(retCode2)) {
		for (int i = 0; i < result2.length; i ++) {
			for (int j = 0; j < result2[i].length; j ++) {
				System.out.print("========wanghfa======= sB608Qry : result2[" + i + "][" + j + "] = ");
				System.out.println(result2[i][j]);
			}
		}
	}
%>


<script language=javascript>
	var comments;
	if (!<%=pwrf%>) {
		checkFatherPwd();
	}
	
	function checkFatherPwd() {
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
		checkPwd_Packet.data.add("custType", "01");						//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
		checkPwd_Packet.data.add("phoneNo", "<%=fatherPhone1%>");		//�ƶ�����,�ͻ�id,�ʻ�id
		checkPwd_Packet.data.add("custPaswd", "<%=fatherPwd1%>");		//�û�/�ͻ�/�ʻ�����
		checkPwd_Packet.data.add("idType", "un");						//en ����Ϊ���ģ�������� ����Ϊ����
		checkPwd_Packet.data.add("idNum", "");							//����
		checkPwd_Packet.data.add("loginNo", "<%=workNo%>");				//����
		core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
		checkPwd_Packet=null;
	}
	
	function doCheckPwd(packet) {
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		if (retResult != "000000") {
			rdShowMessageDialog("�ҳ��������" + msg, 1);
			history.go(-1);
		} else {
			checkMemberPwd();
		}
	}
	
	function checkMemberPwd() {
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
		checkPwd_Packet.data.add("custType", "01");						//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
		checkPwd_Packet.data.add("phoneNo", "<%=memberPhone1%>");		//�ƶ�����,�ͻ�id,�ʻ�id
		checkPwd_Packet.data.add("custPaswd", "<%=memberPwd1%>");		//�û�/�ͻ�/�ʻ�����
		checkPwd_Packet.data.add("idType", "un");						//en ����Ϊ���ģ�������� ����Ϊ����
		checkPwd_Packet.data.add("idNum", "");							//����
		checkPwd_Packet.data.add("loginNo", "<%=workNo%>");				//����
		core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
		checkPwd_Packet=null;
	}
	
	function doCheckPwd(packet) {
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		if (retResult != "000000") {
			rdShowMessageDialog("��Ա�������" + msg, 1);
			history.go(-1);
		}
	}
	
	function submitt() {
		document.getElementById("cubmitt").disabled = "true";
		var productIdObj = document.getElementById("productId");
		
		var getOfferCmtsPacket = new AJAXPacket("fb608_ajaxGetOfferCmts.jsp", "���ڻ�ȡ�����ʷ����������Ժ�......");
		getOfferCmtsPacket.data.add("offerId", productIdObj.options[productIdObj.selectedIndex].innerText.split("--")[0]);
		core.ajax.sendPacket(getOfferCmtsPacket, doGetCmts);
	}
	
	function doGetCmts(packet) {
		var buttonSub = document.getElementById("cubmitt");
		var retResult = packet.data.findValueByName("retResult");
		
		if (retResult == "000000") {
			comments = packet.data.findValueByName("comments");
		} else {
			comments = "ȡ�ʷ�����ʧ�ܡ�";
		}
		
		var ret = showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��","Yes");	//��ӡ���
		
		if(typeof(ret) != "undefined"){
			if (rdShowConfirmDialog("ȷ��Ҫ���д��������") == 1) {
				frm.submit();
			}
			buttonSub.disabled = "";
		} else {
			if (rdShowConfirmDialog("ȷ��Ҫ���д��������") == 1) {
				frm.submit();
			}
			buttonSub.disabled = "";
		}
	}
	
	function showPrtDlg(printType, DlgMessage, submitCfm)
	{  //��ʾ��ӡ�Ի���
		var h = 210;
		var w = 400;
		var t = screen.availHeight / 2 - h / 2;
		var l = screen.availWidth / 2 - w / 2;
		
		var pType = "subprint";
		var billType = "1";
		var sysAccept = "<%=printAccept%>";
		var printStr  =  printInfo(printType);
		var mode_code = null;
		var fav_code = null;
		var area_code = null;
		var opCode = "<%=opCode%>";
		var phoneNo = document.getElementById("memberPhone1").value;
		
		var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path = path + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
	}
	
	function printInfo(printType)
	{
		var retInfo = "";
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		cust_info+="�ֻ����룺" + document.getElementById("memberPhone1").value + "|";
		cust_info+="�ͻ�������" + document.getElementById("custName").value + "|";
		//cust_info+="֤�����룺" + document.getElementById("idNo").value + "|";
		//cust_info+="�ͻ���ַ��" + document.getElementById("custAddr").value + "|";
		
		opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'
			+ "  " + "�û�Ʒ��: " + document.getElementById("smName").value + "|";
		opr_info += "����ҵ��" + document.getElementById("opName").value + "  ������ˮ��" + "<%=printAccept%>" + "|";
		opr_info += "����ļ�ͥ���룺" + document.getElementById("familyGroupId").value + "  �ҳ����룺<%=fatherPhone1%>" + "|";
		opr_info += "��ͥ�ײͣ�" + document.getElementById("productId")[document.getElementById("productId").selectedIndex].text + "|";
		
		document.getElementById("opNote").value = "����<%=workNo%>Ϊ<%=memberPhone1%>�û�����<%=opName%>��";
		note_info1 += "��ע������<%=workNo%>Ϊ<%=memberPhone1%>�û�����<%=opName%>��|";
		note_info1 += "�ʷ�������" + comments + "|";
		note_info1 += "����֮���ײ͵���Ч��Ϊ2010��12��1����2011��6��30�գ���2011��7��1�����ײ��Զ�ʧЧ���ͻ��������ܴ��ײ͵��Żݡ�|";
		
		retInfo = strcat(cust_info, opr_info, note_info1, note_info2, note_info3, note_info4);
		retInfo = retInfo.replace(new RegExp("#","gm"), "%23");
		return retInfo;
	}
</script>
</head>
<body>

<form name="frm" action="fb609_cfm.jsp" method="POST">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="printAccept" id="printAccept" value="<%=printAccept%>">
<input type="hidden" name="fatherPhone1" id="fatherPhone1" value="<%=fatherPhone1%>">
<input type="hidden" name="memberPhone1" id="memberPhone1" value="<%=memberPhone1%>">
<input type="hidden" name="opNote" id="opNote" value="">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi">��Ա��Ϣ</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">
			�ͻ�����
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" size="40" value="<%=result[0][0]%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue" width="20%">
			�û�����
		</td>
		<td width="30%">
			<input type="text" name="fatherPhone1" id="fatherPhone1" value="<%=fatherPhone1%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			ҵ��Ʒ��
		</td>
		<td>
			<input type="text" name="smName" id="smName" value="<%=result[0][2]%>--<%=result[0][1]%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue">
			<%=result[0][3]%>
		</td>
		<td>
			<input type="text" name="idNo" id="idNo" value="<%=result[0][4]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			��ǰ���ײ�
		</td>
		<td>
			<input type="text" name="currentProduct" id="currentProduct" size="40" value="<%=result[0][5]%>--<%=result[0][6]%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue">
			�ͻ�����
		</td>
		<td>
			<input type="text" name="bigCust" id="bigCust" value="<%=result[0][7]%>--<%=result[0][8]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			�ͻ���ַ
		</td>
		<td colspan="3">
			<input type="text" name="custAddr" id="custAddr" size="60" value="<%=result[0][9]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
</table>

<div class="title">
	<div name="title_zi" id="title_zi">��ͥ״̬</div>
</div>
<table>
	<tr>
		<td class="blue" width="30%">
			��ͥ����
		</td>
		<td width="70%">
			<input type="text" name="familyGroupId" id="familyGroupId" value="<%=result[0][10]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="30%">
			��ͥ�ײ�
		</td>
		<td width="70%">
			<select id="productId" name="productId" style="width:300px">
<%
			for (int i = 0; i < result2.length; i ++) {
%>
				<option value="<%=result2[i][2]%>"><%=result2[i][0]%>--<%=result2[i][1]%></option>
<%
			}
%>
			</select>
		</td>
	</tr>
</table>
<table cellspacing="0">
	<tr>
	    <td id="footer">
	      <input class="b_foot" type=button name="cubmitt" value="ȷ��" onClick="submitt();">
	      <input class="b_foot" type=button name="cubmitt" value="����" onClick="window.location = 'fb608.jsp?opCode=<%=opCode%>&opName=<%=opName%>';">
	      <input class="b_foot" type=button name=qryPage value="�ر�" onClick="removeCurrentTab();">
	    </td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>
<%
	}
%>
