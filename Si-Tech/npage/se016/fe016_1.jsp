<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ѫ�¶һ���Ʒ�������� e016
   * �汾: 1.0
   * ����: 2011/7/5
   * ����: huangrong
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%	request.setCharacterEncoding("GBK");%>
<%
	String opCode="e016";
	String opName="ѫ�¶һ���Ʒ��������";
	String work_no = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String groupId = (String)session.getAttribute("groupId");
	String town="";
	String seqSql="select to_char(SMEDALACCEPT.nextval) from dual";
  String giftCode="";
%>
	<wtc:service name="sPubSelect" routerKey="regioncode" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=seqSql%>"/>	
	</wtc:service>	
	<wtc:array id="retResult"  scope="end"/>
<%	
	String errCode = retCode1;
	String errMsg = retMsg1;
	
	if(retResult == null)
  	{
%>
    <script language=JavaScript>
    		rdShowMessageDialog("��ȡ��Ʒ����ʧ�ܣ�");
				removeCurrentTab();
    </script>
<%  	
  	}else
  	{
		if(errCode.equals("000000")&&retResult.length>0 )
		{
			giftCode=retResult[0][0];
		 	System.out.println("giftCode="+giftCode);
		 	System.out.println("���÷���sPubSelect ��ѯ���гɹ�...............");
		 }
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>ѫ�¶һ���Ʒ��������</TITLE>
</HEAD>
<body>

<!-------------------------------------------------------------------------------->

	
<!-------------------------------------------------------------------------------->
<SCRIPT language="JavaScript">



function doSubmit()
{
	getAfterPrompt();
	if(document.form1.reginonCodes.value=="")
	{
		rdShowMessageDialog("��ѡ������Ӫҵ�����������Ӧ��У���Ƿ���Ӫҵ����ť����֤ѡ���Ӫҵ���Ƿ���Ӫҵ������!");
		return false;
	}	

	if(document.form1.giftCode.value=="")
	{
		rdShowMessageDialog("��Ʒ���벻��Ϊ��!");
		document.form1.giftCode.focus();
		return false;
	}		
	
	if(document.form1.giftName.value=="")
	{
		rdShowMessageDialog("��Ʒ���Ʋ���Ϊ��!");
		document.form1.giftName.focus();
		return false;
	}	
	if(document.form1.giftDescribe.value=="")
	{
		rdShowMessageDialog("��Ʒ��������Ϊ��!");
		document.form1.giftDescribe.focus();
		return false;
	}		
	if(document.form1.medalCount.value=="")
	{
		rdShowMessageDialog("��ѫ��������Ϊ��!");
		document.form1.medalCount.focus();
		return false;
	}		
	if(document.form1.startTime.value=="")
	{
		rdShowMessageDialog("��ѡ��ʼʱ��!");
		document.form1.startTime.focus();
		return false;
	}	
	if(document.form1.endTime.value=="")
	{
		rdShowMessageDialog("��ѡ�����ʱ��!");
		document.form1.endTime.focus();
		return false;
	}	
	var begin_time=document.form1.startTime.value;
	var end_time=document.form1.endTime.value;
	if(begin_time>=end_time)
  {
    rdShowMessageDialog("��ʼʱ��ӦС�ڽ���ʱ�䣬���������룡");
    return false;
  }
  if(document.form1.opNote.value=="")
  {
  	document.form1.opNote.value="ѫ�¶һ���Ʒ��������";
  }
  
  if(check(document.form1)){
	  document.form1.action="fe016Cfm.jsp";
	  document.form1.submit();
  }	

}



</SCRIPT>
<FORM method=post name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    <div id="title_zi">������Ϣ</div>
	</div>
<table cellSpacing="0">
	<tr>
		<td width="15%" class="blue" nowrap>��ѡ������Ӫҵ��&nbsp;<font color="orange">*</font></td>
		<td colspan="3">
			<iframe frameBorder="0" src="fe016_getRegionCode.jsp" id="sAuditLoginInfoFrame" align="center" name="sAuditLoginInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1;"  onload="document.getElementById('sAuditLoginInfoFrame').style.height=sAuditLoginInfoFrame.document.body.scrollHeight+'px'"></iframe>
			<input type="hidden" name="reginonCodes" ><!--���ѡ��ĵ���Ӫҵ��-->
		</td>
	</tr>	
	
	
	<tr>	
		<td class="blue">��Ʒ����</td>
		<td>
			<input type="text" name="giftCode" class="InputGrey" value="<%=giftCode%>" v_must="1" readonly>&nbsp;<font color="orange">*</font>
		</td>
		<td class="blue">��Ʒ����</td>
		<td>
			<input type="text" name="giftName" v_must="1"  maxlength="50">&nbsp;<font color="orange">*</font>
		</td>		
	</tr>
                
	<tr>
		<td class="blue">��Ʒ����</td>
		<td>
			<input type="text" name="giftDescribe" v_must="1" maxlength="100">&nbsp;<font color="orange">*</font>
		</td>
		<td class="blue">��ѫ����</td>
		<td>
			<input type="text" name="medalCount" v_must="1" v_type="cfloat" onblur = "checkElement(this)" >&nbsp;<font color="orange">*</font>
		</td>		
    </tr>
	<tr>
		<td class="blue">��ʼʱ��</td>
		<td>
			<input type="text" name="startTime" id="startTime" v_must="1" v_type="date" class="button" maxlength="8" readonly/>&nbsp;<font color="orange">*</font>
			<input type="button" name="dateButton" class="b_text" alt="�������������˵�" onclick="fPopUpCalendarDlg('startTime');return false" value="����" />
		</td>
		<td class="blue">����ʱ��</td>
		<td>
			<input type="text" name="endTime" id="endTime" v_must="1" v_type="date" class="button" maxlength="8" readonly/>&nbsp;<font color="orange">*</font>
			<input type="button" name="dateButton" class="b_text" alt="�������������˵�" onclick="fPopUpCalendarDlg('endTime');return false" value="����" />
		</td>
	</tr>	
	<tr>
		<td class="blue">��ע</td>
		<td colspan="3">
			<input type="text"   name="opNote"  size="60" maxlength="100">
		</td>
	</tr>	
	<tr> 
		<td align="center" id="footer" colspan="4">
			&nbsp; <input class="b_foot" name="confirm" onclick="doSubmit()" type=button value="ȷ��">
			&nbsp; <input class="b_foot" name="clear"  type=button onClick="location.reload()" value="ˢ��">
			&nbsp; <input class="b_foot" name="back" onClick="history.go(-1)" type=button value="����">
		</td>
	</tr>
</table>
	
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

<script language="javascript">
 onload=function(){
	form1.reset();
	}

function fPopUpCalendarDlg(timeName)
{
	var time_name=document.getElementById(timeName);
	if(false)
	{
		showx = 220 ; // + deltaX;
		showy = 220; // + deltaY;
	}
	else
	{
		showx = event.screenX - event.offsetX - 4 - 210 ; // + deltaX;
		showy = event.screenY - event.offsetY + 18; // + deltaY;
	}	
	newWINwidth = 210 + 4 + 18;
	if(false)
	{
		window.top.captureEvents (Event.CLICK|Event.FOCUS);
		window.top.onclick=IgnoreEvents;
		window.top.onfocus=HandleFocus;
		winPopupWindow.args = timeName;
		winPopupWindow.returnedValue = new Array();
		winPopupWindow.args = timeName;
		newWINwidth = 202;
		winPopupWindow.win = window.open("/js/common/date/CalendarDlg.htm","CalendarDialog","dependent=yes,left="+showx + ",top=" + showy + ",width="+newWINwidth + ",height=182px" )
		winPopupWindow.win.focus()
		return winPopupWindow;
	}
	else
	{
		retval = window.showModalDialog("/js/common/date/CalendarDlg.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; ");
	}
	if(retval != null && retval != "")
	{
		retval = retval.replace(/\//g,"");
		var myDate = new Date();
		var year = myDate.getFullYear();
		var mon = myDate.getMonth();
		mon = mon + 1 + "";
		if(mon < 10){
			mon = "0" + mon;
		}
		var day = myDate.getDate();
		if(day < 10){
			day = "0" + day;
		}
		var today = year + mon + day;
		//alert("today : " + today + "|" + retval + "|")
    time_name.value = retval;
	}
	else if(retval == "")
	{
		time_name.value = "";
	}else{
	}
}
</script>

