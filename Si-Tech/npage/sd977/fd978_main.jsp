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
	
  System.out.println("====fd978_main.jsp====wanghfa==== opCode = " + opCode);
  System.out.println("====fd978_main.jsp====wanghfa==== opName = " + opName);

	String result[] = new String[3];
	String inputArry[] = new String[1];
	String Tmsql="select to_char(trunc(last_day(sysdate)+1),'yyyy-mm-dd hh24:mi:ss') from dual";
	inputArry[0] = Tmsql;
%> 
<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inputArry[0]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr1"  scope="end"/>
<%
	String exeTime = tempArr1[0][0].substring(0,10);
	
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="printAccept"/>
<%
	System.out.println("====wanghfa====fd978_main.jsp====s7327Qry====0==== �ҳ����� = " + activePhone);
	System.out.println("====wanghfa====fd978_main.jsp====s7327Qry====1==== inOpCode = " + opCode);
	System.out.println("====wanghfa====fd978_main.jsp====s7327Qry====2==== inOpFlag = d");
	System.out.println("====wanghfa====fd978_main.jsp====s7327Qry====3==== 0");
%>
	<wtc:service name="s7327Qry" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode1" retmsg="retMsg1" outnum="12">
		<wtc:param value="<%=activePhone%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="d"/>
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
	System.out.println("====wanghfa=====fd978_main.jsp====s7327Qry : " + retCode1 + "," + retMsg1);
	
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
				System.out.println("====wanghfa=====fd978_main.jsp====s7327Qry==== result7[0]["+j+"] = " + result7[0][j]);
				result[j] = result7[0][j];
			}
		}
		if(result1.length>0) {
			mainArr = result1;// ��������
			memArr = result8;//��������
			beginTimeArr = result3;//��ʼ����
			endTimeArr = result4;//��������
		}
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>��ͥ���˷���ȡ��</title>
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
		
		var ret = showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��","Yes");	//��ӡ���
		
		if (rdShowConfirmDialog("ȷ��Ҫ���д��������") == 1) {
			document.frm.submit();
		} else {
			controlBtn(false);
			return false;
		}
	}
	
	function initFrm(obj) {
		$("#submitBtn").attr("disabled", false);
		document.frm.mainCard.value = obj.sMainCard;
		document.frm.memNum.value = obj.slaveCard;
		document.frm.beginTime.value = obj.beginTime;
		document.frm.endTime.value = obj.endTime;
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
		opr_info += "�������룺" + document.getElementById("mainCard").value + "|";
		opr_info += "�������룺" + document.getElementById("memNum").value + "|";
		opr_info += "����ʱ�䣺" + exeDate + "|";
		opr_info += "��Чʱ�䣺" + "<%=exeTime%>" +"|";
		
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

<form name="frm" method="POST" action="fd978_cfm.jsp">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="opNote" id="opNote" value="">
<input type="hidden" name="printAccept" id="printAccept" value="<%=printAccept%>">

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
</table>
<br/>
<div class="title">
	<div id="title_zi">������Ϣ</div>
</div>
<table>
	<tr>
		<th width="5%" align=center>ѡ��</th>
		<th width="15%" align=center>��������</th>
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
			System.out.println("====wanghfa=====fd978_main.jsp====s7327Qry==== " + mainArr[i][0] + "," + memArr[i][0] + "," + beginTimeArr[i][0] + "," + endTimeArr[i][0]);
			%>
			<tr>
			  <td align=center>
					<input type="radio" name="radio" sMainCard="<%=mainArr[i][0]%>" slaveCard="<%=memArr[i][0]%>" beginTime="<%=beginTimeArr[i][0]%>" endTime="<%=endTimeArr[i][0]%>" onclick="initFrm(this)">
			  </td>
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
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="ȷ��" onClick="doCfm();" disabled=true>
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="����" onClick="window.location = 'fd977.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>';">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
</DIV>
</DIV>
<input type="hidden" name="mainCard" id="mainCard" value="">
<input type="hidden" name="memNum" id="memNum" value="">
<input type="hidden" name="beginTime" id="beginTime" value="">
<input type="hidden" name="endTime" id="endTime" value="">
</form>
</body>
</html>
