<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:SIM���ظ��˻� 7047
   * �汾: 1.0
   * ����: 2009/3/16
   * ����: liucm
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%     
		String opCode = "7047";
		String opName = "SIM���ظ��˻�";
		String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<base target="_self">
<script language="JavaScript">
<!--
var WshShell=new ActiveXObject("WScript.Shell");

//�������վ��ip
WshShell.RegWrite("HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\ZoneMap\\Ranges\\Range100\\","");
WshShell.RegWrite("HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\ZoneMap\\Ranges\\Range100\\http","2","REG_DWORD");
WshShell.RegWrite("HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\ZoneMap\\Ranges\\Range100\\:Range","10.110.0.204");

//�޸�IE ActiveX��ȫ����
WshShell.RegWrite("HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Zones\\2\\1001","0","REG_DWORD");
WshShell.RegWrite("HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Zones\\2\\1004","0","REG_DWORD");
WshShell.RegWrite("HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Zones\\2\\1200","0","REG_DWORD");
WshShell.RegWrite("HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Zones\\2\\1201","0","REG_DWORD");
WshShell.RegWrite("HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Zones\\2\\1405","0","REG_DWORD");
WshShell.RegWrite("HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Zones\\2\\2201","0","REG_DWORD");

//����xinxp����������ֹ����
WshShell.RegWrite("HKCU\\Software\\Microsoft\\Internet Explorer\\New Windows\\PopupMgr","no");

function readSim()
{
try{
		var ocxver=writecardocx.GetVersion();
		var isgoodcard=writecardocx.IsCardExist();
		if(isgoodcard==0)
		{
			var card_sim=writecardocx.GetSIMICCID();
			//card_sim="89860093084206109467";
			if(card_sim.substring(0,4)!="8986")
			{
				rdShowMessageDialog("��ȡSIM���������!");
				return false;
			}
			else
			{
				document.mainForm.sim_no.value=card_sim;
			}
			var card_no=writecardocx.GetICCSerial();//ȡ�տ����к�
			//card_no="0806001650000881";
			document.mainForm.card_no.value=card_no;
		}
 }catch(e)
  {
 	rdShowMessageDialog("���ڼ�������,���Ժ�",0);
 	}
}
function docheck() 
{
	if (document.mainForm.sim_no.value.length == 0) 
	{
    	rdShowMessageDialog("SIM�����벻��Ϊ�գ�����ȡ��ť !!")
      	document.mainForm.contract_no.focus();
      	return false;
   	} 
   	
   	mainForm.action="f7047_2.jsp";
	  mainForm.submit();
} 

 
 function doclear(){
 	 mainForm.reset();
 }
-->
 </script> 
 
<title>������BOSS-SIM���ظ��˻�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<form action="" method="post" name="mainForm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">SIM���ظ��˻�</div>
	</div>
<table cellspacing="0">
	             
	<tr> 
		<td class="blue" nowrap>SIM������</td>
		<td> 
			<input class="button"type="text" value="" name="sim_no" size="20" readonly >
			<font color="orange"> #</font>
			<input name=readsim type=button onClick="readSim();" class="b_text" style="cursor:hand" id="readsim" value=��ȡ��Ϣ>
		</td>
		<td class="blue">�տ����к�</td>
		<td> 
			<input type="text" class="button" value="" name="card_no" size="20"  readonly> 
			<font color="orange"> #</font>
		</td>
	</tr>
				
	

	<TR> 
		<TD align="center" id="footer" colspan="4"> 
			<input type="button" name="query"  class="b_foot" value="��ѯ" onclick="docheck()" index="9">
			&nbsp;
			<input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" index="10">
			&nbsp;
			<input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" index="13">
		</TD>
	</TR>
</table>
	 <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
 </BODY>
 <OBJECT
ID= "writecardocx"
CLASSID="clsid:930C8A98-EC73-4C37-9E20-9F4E0A5F93C4"
CODEBASE="/ocx/hljqqx.cab#version=1,0,0,1"
WIDTH = 0
HEIGHT = 0
ALIGN = center
HSPACE = 0
VSPACE = 0
VIEWASTEXT>
</OBJECT>
</HTML>