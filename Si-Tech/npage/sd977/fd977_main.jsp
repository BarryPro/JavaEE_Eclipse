<%
  /*
   * ����: ���ڡ���ͥ���ʷ���ҵ������
   * �汾: 1.0
   * ����: 20110701
   * ����: wanghfa
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String comboType = request.getParameter("comboType");
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String ipAddr = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
	String[][] mainArr = new String[][]{};
	String[][] memArr = new String[][]{};
	String[][] beginTimeArr = new String[][]{};
	String[][] endTimeArr = new String[][]{};
	String limitNo = new String();
	//�ж��Ƿ���Ҫ��������
	boolean pwrf = false;
  String[][] pubFavInfo =(String[][])session.getAttribute("favInfo");
  String[] pubFavStr= new String[pubFavInfo.length];
  for(int i=0;i<pubFavStr.length;i++) pubFavStr[i]=pubFavInfo[i][0].trim();
	if(WtcUtil.haveStr(pubFavStr,"a272")) {	//��������Ȩ��
		System.out.println("������Ȩ��!!!!");
		pwrf = true;
	}
	//pwrf = false;
	
  System.out.println("====fd977_main.jsp====wanghfa==== opCode = " + opCode);
  System.out.println("====fd977_main.jsp====wanghfa==== opName = " + opName);

	String result[] = new String[3];
	
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="printAccept"/>
<%
	System.out.println("====wanghfa====fd977_main.jsp====s7327Qry====0==== �ҳ����� = " + activePhone);
	System.out.println("====wanghfa====fd977_main.jsp====s7327Qry====1==== inOpCode = " + opCode);
	System.out.println("====wanghfa====fd977_main.jsp====s7327Qry====2==== inOpFlag = a");
	System.out.println("====wanghfa====fd977_main.jsp====s7327Qry====3==== 0");
%>
	<wtc:service name="s7327Qry" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode1" retmsg="retMsg1" outnum="12">
		<wtc:param value="<%=activePhone%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="a"/>
	</wtc:service>
	<wtc:array id="result0"  start="0" length="2" scope="end"/>
	<wtc:array id="result1"  start="2" length="1" scope="end"/>
	<wtc:array id="result2"  start="3" length="1" scope="end"/>
	<wtc:array id="result3"  start="4" length="1" scope="end"/>
	<wtc:array id="result4"  start="5" length="1" scope="end"/>
	<wtc:array id="result5"  start="6" length="1" scope="end"/>
	<wtc:array id="result6"  start="7" length="1" scope="end"/>
	<wtc:array id="result7"  start="8" length="3" scope="end"/>
	<wtc:array id="result8"  start="11" length="1" scope="end"/>
<%
	System.out.println("====wanghfa=====fd977_main.jsp====s7327Qry : " + retCode1 + "," + retMsg1);
	
	if (!retCode1.equals("000000")) {
%>
	<script language="JavaScript">
		rdShowMessageDialog("s7327Qry���룺<%=retCode1%>����Ϣ��<%=retMsg1%>",0);
		history.go(-1);
	</script>
<%
	} else {
		if (result7.length > 0) {
			for (int j = 0; j < result7[0].length; j ++) {
				System.out.println("====wanghfa=====fd977_main.jsp====s7327Qry==== result7[0]["+j+"] = " + result7[0][j]);
				result[j] = result7[0][j];
			}
		}
		System.out.println("====wanghfa=====fd977_main.jsp====s7327Qry==== result1.length = " + result1.length);
		if(result1.length > 0) {
			mainArr = result1;// ��������
			memArr = result8;//��������
			beginTimeArr = result3;//��ʼ����
			endTimeArr = result4;//��������
			limitNo = result6[0][0];
		}
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>��ͥ���˷�������</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language=javascript>
	window.onload = function() {
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		controlBtn(true);
		
		if (!checkElement(document.getElementById("addMemberPhone"))) {
			document.getElementById("addMemberPhone").focus();
			controlBtn(false);
			return false;
		} else if(parseInt(document.frm.numLimit.value) <= 0) {
			rdShowMessageDialog("�������û��������������ٰ����ҵ��", 1);
			controlBtn(false);
			return false;
		}

		<%
		if (!pwrf) {
		%>
			if (document.getElementById("memberPwd").value.length !=6) {
				rdShowMessageDialog("������6λ���룡", 1);
				document.getElementById("memberPwd").focus();
				controlBtn(false);
				return false;
			}
			var checkPwdPacket = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ��к���У�飬���Ժ�......");
			checkPwdPacket.data.add("custType", "01"); //01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwdPacket.data.add("phoneNo", document.getElementById("addMemberPhone").value); //�ƶ�����,�ͻ�id,�ʻ�id
			checkPwdPacket.data.add("custPaswd", document.getElementById("memberPwd").value);//�û�/�ͻ�/�ʻ�����
			checkPwdPacket.data.add("idType", ""); //en ����Ϊ���ģ�������� ����Ϊ����
			checkPwdPacket.data.add("idNum", ""); //����
			checkPwdPacket.data.add("loginNo", "<%=workNo%>"); //����
			core.ajax.sendPacket(checkPwdPacket, doMsg);
			checkPwdPacket = null;
		<%
		} else {
		%>
			cfm();
		<%
		}
		%>
	}
	
	function doMsg(packet) {
		var retCode = packet.data.findValueByName("retResult");
		var retMsg = packet.data.findValueByName("msg");
		if(retCode == "000000"){
			cfm();
		}else{
			rdShowMessageDialog(retMsg);
			controlBtn(false);
			return false;
		}
	}
	
	function cfm() {
		var ret = showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��","Yes");	//��ӡ���
		
		if (rdShowConfirmDialog("ȷ��Ҫ���д��������") == 1) {
			document.frm.submit();
		} else {
			controlBtn(false);
			return false;
		}
	}

	
	function showPrtDlg(printType, DlgMessage, submitCfm)
	{  //��ʾ��ӡ�Ի���
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;

		var pType="subprint";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
		var billType="1";                                          //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
		var sysAccept="<%=printAccept%>";                          // ��ˮ��
		var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
		var mode_code=null;                                        //�ʷѴ���
		var fav_code=null;                                         //�ط�����
		var area_code=null;                                        //С������
		var opCode="<%=opCode%>";                                  //��������
		var phoneNo="<%=activePhone%>";         					        //�ͻ��绰

		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
	}
	
	function printInfo(printType) {
		var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//�õ�ִ��ʱ��
		
		var retInfo = "";
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		cust_info+="�ֻ����룺" + document.getElementById("activePhone").value + "|";
		cust_info+="�ͻ�������" + document.getElementById("custName").value + "|";
		cust_info+="֤�����룺" + document.getElementById("idCardNo").value + "|";
		cust_info+="�ͻ���ַ��" + document.getElementById("custAddr").value + "|";
		opr_info += "ҵ�����ͣ�<%=opName%>" + "|";
		opr_info += "ҵ����ˮ��<%=printAccept%>" + "|";
		opr_info += "�������룺<%=activePhone%>" + "|";
		opr_info += "�������룺" + document.getElementById("addMemberPhone").value + "|";
		opr_info += "����ʱ�䣺" + exeDate + "|";
		opr_info += "��Чʱ�䣺" + exeDate + "|";
		document.getElementById("opNote").value = "����<%=workNo%>Ϊ<%=activePhone%>�û�����<%=opName%>��";
		
		note_info1+="������ע��"+"|";
		note_info1+="1.�������ƶ��ͻ����԰����ҵ�񣬹��⡢���񡢲��Կ��������˻���Ƿ�ѡ�������״̬�ͻ����⡣"+"|";
		note_info1+="2.�������ֽ��˻�����Ϊ�������и��ѣ������ר���˻��޷�Ϊ�������и��ѡ�"+"|";
		note_info1+="3.����Ƿ��ͣ������������������ͣ����ͣ����"+"|";
		note_info1+="4.����Ϊ�������ѽ����������ĵ��������ڡ�"+"|";
		note_info1+="5.������Ϊȫ��ͨ�򶯸еش�Ʒ�ƿͻ�������Ϊ�������ѽ���������Ļ��֣��鸱�����С�������Ϊ�����пͻ���������Ϊ�������ѽ��������֡�"+"|";
		note_info1+="6.���롰���ʷ���ҵ�񣬰����������Ч��ȡ����ҵ��������Ч��"+"|";
		note_info1+="7.����Ϊ�������ѵĽ�����µ׳���ʱһ���Ի�����"+"|";
		
		retInfo = strcat(cust_info, opr_info, note_info1, note_info2, note_info3, note_info4);
		retInfo = retInfo.replace(new RegExp("#","gm"), "%23");
		return retInfo;
	}

</script>
</head>
<body>

<form name="frm" method="POST" action="fd977_cfm.jsp">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="opNote" id="opNote" value="">
<input type="hidden" name="printAccept" id="printAccept" value="<%=printAccept%>">
<input type="hidden" name="numLimit" id="numLimit" value="<%=limitNo%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">���û���Ϣ</div>
</div>
<table>
	<tr>
		<td class="blue" width="20%">
			�绰����
		</td>
		<td width="30%">
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" class="InputGrey" readonly>
		</td>
		<td class="blue"width="20%">
			�ͻ�����
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" size="40" value="<%=result[0]%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			�ͻ���ַ
		</td>
		<td colspan="3">
			<input name="custAddr" id="custAddr" type="text" size="60" class="InputGrey" value="<%=result[1]%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			֤������
		</td>
		<td colspan="3">
			<input type="text" name="idCardNo" id="idCardNo" size="40" value="<%=result[2]%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			�����Ѻ���
		</td>
		<td>
			<input type="text" name="addMemberPhone" id="addMemberPhone" value="" maxlength="11" v_maxlength="11" v_must="1"/>
		</td>
		<td class="blue">
			����
		</td>
		<td>
		<%
			if (pwrf) {
				%>
					�˹���������Ȩ�ޣ��ɲ������û�����
				<%
			} else {
				%>
					<input type="password" name="memberPwd" id="memberPwd" type="text" onKeyPress="return isKeyNumberdot(0)" maxlength="6" v_maxlength="6">
					<input class="b_text" onclick="showNumberDialog(document.all.memberPwd);" type=button value="����">
				<%
			}
		%>
		</td>
	</tr>
</table>
<br/>
<div class="title">
	<div id="title_zi">������Ϣ</div>
</div>
<table>
	<tr>
		<th width="20%" align=center>��������</th>
		<th width="20%" align=center>��������</th>
		<th width="25%" align=center>��ʼʱ��</th>
		<th width="25%" align=center>����ʱ��</th>
	</tr>
<%
	if (memArr.length == 0) {
		%>
		<tr>
		  <td colspan="4" align=center>����Ϣ</td>
		</tr>
		<%
	} else {
		for (int i = 0; i < memArr.length; i ++) {
			System.out.println("====wanghfa=====fd977_main.jsp====s7327Qry==== " + mainArr[i][0] + "," + memArr[i][0] + "," + beginTimeArr[i][0] + "," + endTimeArr[i][0]);
			%>
			<tr>
			  <td align=center><%=mainArr[i][0]%></td>
			  <td align=center><%=memArr[i][0]%></td>
			  <td align=center><%=beginTimeArr[i][0]%></td>
			  <td align=center><%=endTimeArr[i][0]%></td>
			</tr>
			<%
		}
	}
%>
</table>
<table>
	<tr>
		<td colspan="4" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="ȷ��" onClick="doCfm();">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="����" onClick="window.location = 'fd977.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>';">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
</DIV>
</DIV>

</form>
</body>
</html>
