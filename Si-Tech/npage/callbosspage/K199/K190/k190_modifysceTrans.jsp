<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: �ͷ�һ������¼����Ϣ��
�� * �汾: 1.0.0
�� * ����: 2009/09/07
�� * ����: yinzx
�� * ��Ȩ: sitech
   * 
�� */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String sceid =  request.getParameter("sceid");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";

String serSql="select SERIALNO,TO_CHAR(CENTER10086),TO_CHAR(CALLAG10086), TO_CHAR(CALLPE10086),TO_CHAR(CALLEN10086),TO_CHAR(CALLER10086),TO_CHAR(CALLPER10086),TO_CHAR(CENTER12580), TO_CHAR(CALLOUTAG10086),TO_CHAR(CALLEROUT10086),TO_CHAR(OUTAG10086),TO_CHAR(AG12580),TO_CHAR(AGER12580),TO_CHAR(OUTAGER10086),TO_CHAR(ENER10086),TO_CHAR(OUTMAIN), TO_CHAR(OTHERAG1008612580),TO_CHAR(WAVEBD),    	TO_CHAR(OUTTOTAL),    TO_CHAR(OTHERER1008612580),TO_CHAR(MALFUNCTION),to_char(datetime,'YYYY-MM-DD HH24:MI:SS') AS datetime,TO_CHAR(AGENTAVGNUM),TO_CHAR(CALLTIME) from difagfirst where 1=1  and SERIALNO= :sceid " ;
 myParams = "sceid="+sceid;

 
 
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="25">
	<wtc:param value="<%=serSql%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />
	
 
	
 
	
<html>
<head>
<title>�ͷ�һ������¼����Ϣ��</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script language=javascript>
	
/**
  * 
  */
function modifysceTrans(){
	 
	var xinval="";
	var yinval="";
  
	for(var i=0;i<23;i++)
	{
		   if ($("input")[i].value=="")
		   {
		   	  $("input")[i].value=" ";
		   }
			 xinval+=$("input")[i].value+",";
			 
  }
 
   
	var packet = new AJAXPacket("k190_sceTrans_rpc.jsp","...");
	packet.data.add("retType","modifysceTrans");
	packet.data.add("addvalxin" ,xinval);
	packet.data.add("sceid" ,"<%=sceid%>");
	 


	
	core.ajax.sendPacket(packet,doProcessmodsceTrans,true);
	packet=null;
}

/**
  *���ش�����
  */
function doProcessmodsceTrans(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");

	if (retCode == "000000") {
		rdShowMessageDialog("�޸����ݳɹ���");	
		opener.document.location.replace("k190_Main.jsp");	
    closeWin();
   
	} else {
		rdShowMessageDialog("�޸�����ʧ�ܣ�");

	}
}

 

// �������¼
function cleanValue(){
  	var e = document.sitechform.elements;
			for(var i=0;i<e.length;i++){
				if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
				  e[i].value="";
				}else{
			  		e[i].checked=false;
			    }
			}   
}

function closeWin(){
	window.close();
}

function initValue(){

}

</script>
</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<div class="title"><div id="title_zi">�ͷ�һ������¼����Ϣ��</div></div>
		<table>
		 
			 <TR class=content3>
          <td noWrap>ȫʡ10086�ͻ�������������<font color=#ff0000 
            >*</FONT></TD></TD>
          <td><input class=form1 id=text1  v_must=1
             type=text size=18     value="<%=rows[0][1] %>" readonly>
          
          <td noWrap>10086��������ϯ��<font color=#ff0000 
            >*</FONT></TD></TD>
          <td><input class=form1 id=text2  v_must=1
             type=text size=18 value="<%=rows[0][2] %>" ></TD>
          <td noWrap>10086����ר����ϯ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text3  v_must=1
             type=text size=18 value="<%=rows[0][3] %>" ></TD></TR>
        <TR class=content2>
          <td noWrap>10086������ϯ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text4  v_must=1
             type=text size=18 value="<%=rows[0][4] %>" ></TD>
          <td noWrap>10086���뻰��Ա��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text5  v_must=1
             type=text size=18 value="<%=rows[0][5] %>" </TD>
          <td noWrap>10086����רϯ����Ա��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text6  v_must=1
             type=text size=18 value="<%=rows[0][6] %>" > </TD></TR>
        <TR class=content3>
          <td noWrap>12580�ͻ�������������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text7  v_must=1
             type=text size=18 value="<%=rows[0][7] %>" ></TD>
          <td noWrap>10086������ϯ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text8  v_must=1
             type=text size=18 value="<%=rows[0][8] %>"></TD>
          <td noWrap>10086��������Ա��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text9  v_must=1
             type=text size=18 value="<%=rows[0][9] %>" ></TD></TR>
        <tr class=content2>
          <td noWrap><font color=#ff0000 
            ><font color=#0f384b 
            >10086�нӵ������Ŀ����ϯ��</FONT>*</FONT> </TD>
          <td noWrap><input class=form1 id=text10  v_must=1
             type=text size=18 value="<%=rows[0][10] %>" ></TD>
          <td noWrap>12580��ϯ����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text11  v_must=1
             type=text size=18 value="<%=rows[0][11] %>" > </TD>
          <td noWrap>12580����Ա����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text12  v_must=1
             type=text size=18 value="<%=rows[0][12] %>" > </TD></TR>
        <tr class=content3>
          <td noWrap>10086�нӵ������Ŀ�Ļ���Ա��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text13  v_must=1
             type=text size=18 value="<%=rows[0][13] %>" ></TD>
          <td noWrap>10086���ﻰ��Ա��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text14  v_must=1
             type=text size=18 value="<%=rows[0][14] %>" > </TD>
          <td noWrap><font 
            color=#0000ff>������ʧ��</font><font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text15  v_must=1
             type=text size=18 value="<%=rows[0][15] %>" > </TD></TR>
        <tr class=content2>
          <td noWrap><font color=#ff0000 
            ><font color=#0f384b 
            >�����˾�н�10086/12580ҵ�����ϯ��</FONT>*</FONT></TD>
          <td noWrap><input class=form1 id=text16  v_must=1
             type=text size=18 value="<%=rows[0][16] %>" ></TD>
          <td noWrap><font 
            color=#0000ff>���񲦶�ϵ��</font><font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text17  v_must=1
             type=text size=18 value="<%=rows[0][17] %>" > </TD>
          <td noWrap><font 
            color=#0000ff>������ʧ��</font><font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text18  v_must=1
             type=text size=18 value="<%=rows[0][18] %>"> </TD></TR>
        <tr class=content3>
          <td noWrap>�����˾�н�10086/12580ҵ��Ļ���Ա��<font 
            color=#ff0000>*</FONT></TD>
          <td noWrap><input class=form1 id=text19  v_must=1
             type=text size=18 value="<%=rows[0][19] %>" ></TD>
          <td noWrap>ϵͳ���ϴ���<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text20 
             type=text size=18 value="<%=rows[0][20] %>" > </TD>
          <td noWrap><font color=#00ff00>�ύ����</font><font 
            color=#ff0000>*</FONT></TD>
           <td >
			  <input id="start_date" name ="start_date" type="text" v_must=1  value="<%=rows[0][21] %>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);return false;">
		    <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  	</td>
		  </TR>
          
          <tr class=content3>
          <td noWrap>�˾�ÿСʱ�绰������<font 
            color=#ff0000>*</FONT></TD>
          <td noWrap><input class=form1 id=text22 
             type=text size=18 value="<%=rows[0][22] %>" ></TD>
          <td noWrap>��ʱ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text23 
             type=text size=18 value="<%=rows[0][23] %>" > </TD>
          <td noWrap><font color=#00ff00> </font><font 
            color=#ff0000></FONT></TD>
          <td noWrap>
          </TD></TR>
          
        <tr class=content2>
          <td noWrap colSpan=6>
            <p><font color=#ff0000><strong>ע���������ݾ�Ϊ�����ͣ�����ʱ��ע�⣡<font 
            color=#0000ff>������ʧ��</font> ��<font color=#0000ff>���񲦶�ϵ��</font>��<font 
            color=#0000ff>������ʧ��</font>��Ϊ�ٷ������뽫��ת��ΪС���ͣ�����23.58%ת����Ϊ0.2358��</strong></font></p>
            <p><strong><font color=#ff0000>&nbsp;&nbsp;&nbsp; <font 
            color=#00ff00>�ύ����</font>�ڲ�������ʱ����Ϊ�գ��Է�������޸�����ʱ���ύ���ڲ�ѯ������</font></strong></p></TD></TR>
			<tr >
  				<td colspan="6" align="center" id="footer">
   					<input name="add" type="button" class="b_text" id="add" value="����" onClick="modifysceTrans()">
   					<input name="clean" type="button" class="b_text" id="clean" value="����" onClick="cleanValue()">
   					<input name="close" type="button" class="b_text" id="close" value="�ر�" onClick="closeWin()">
  				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
<script language=javascript>
</script>