<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-18
********************/
%>
              
<%
  String opCode = "4400";
  String opName = "����VIP��������";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<head>
<title>����VIP��ȡҳ��</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<script language="JavaScript">
window.onbeforeunload = function() 
{
  clearMem();
}


function readerInit(IReaderType,IComName,IComBaudRate,UsbKeyPort){
  oReq.ReaderInit(IReaderType,IComName,IComBaudRate,UsbKeyPort);
	var result=oReq.ResultCode;
        if(result==null){	
	oReq.ReaderClose();		
	document.reader.init.value="�豸��ʼ��ʧ�ܣ�";		
	document.reader.init.style.color="#ff0000";		
	document.reader.init.style.fontWeight="bold";		
	document.reader.info.value="��ʼ������ֵ"+result;		
	document.reader.info.style.color="#ff0000";		
	document.reader.info.style.fontWeight="bold";
	}
	if(result == 0){
		oReq.CloseReaderLight();
		getReaderState();
		document.reader.init.value="�豸��ʼ���ɹ���";
		document.reader.init.style.color="#000000";
		document.reader.init.style.fontWeight="bold";
		document.reader.info.value="";
		document.reader.change_reader.disabled=false;
		document.reader.reader_type.disabled=true;
		document.reader.com.disabled=true;
		document.reader.query_state.disabled=false;;
	}
	else{
		document.reader.init.value="�豸��ʼ��ʧ�ܣ�";
		document.reader.init.style.color="#ff0000";
		document.reader.init.style.fontWeight="bold";
		document.reader.info.value="��ʼ������ֵ"+result;
		document.reader.info.style.color="#ff0000";
		document.reader.info.style.fontWeight="bold";
		if(oReq!=null){
			oReq.ReaderClose();
		}
	}
	delete result;
	CollectGarbage();
}
function getReaderState(){
	var state=oReq.GetReaderState();
	state=0;
	if(state==0){
		document.reader.reader_state.value="�豸״̬������";
		document.reader.reader_state.style.color="#000000";
		document.reader.reader_state.style.fontWeight="bold";
		document.reader.read_data.disabled=false;
	}else{
		document.reader.reader_state.value="�豸״̬�쳣��";
		document.reader.reader_state.style.color="#ff0000";
		document.reader.reader_state.style.fontWeight="bold";
		document.reader.read_data.disabled=true;
	}
	delete state;
	CollectGarbage();
}
function getdata(type){
	var data = 	oReq.GetReaderData(type,"hex");
	document.reader.temp.value=data;
	var data_length = oReq.ResultCode;
        //alert("data_length"+data_length);
	if(data_length!=0){
		read_times++;
		document.reader.times.value=read_times;
		if(data_length > 0){
			document.reader.hex.value=document.reader.temp.value;
			document.reader.hex.style.color="#000000";
			document.reader.hex.style.fontWeight="bold";
			hexTobin(document.reader.hex.value);
			document.reader.data_len.value=data_length;
			document.reader.message_type.value=oReq.MessageType;
			document.reader.info.value="��ȡ�ɹ���";
		}
		else if(data_length==-2){
			document.reader.info.value="�������";
			document.reader.info.style.color="#000000";
			document.reader.info.style.fontWeight="bold";
		}
	
		else if(data_length==-3){
			document.reader.info.value="���ܴ���";
			document.reader.info.style.color="#000000";
			document.reader.info.style.fontWeight="bold";
		}
	
		else if(data_length==-4){
			document.reader.info.value="У�����";
			document.reader.info.style.color="#000000";
			document.reader.info.style.fontWeight="bold";
		}
		else if(data_length==-1){
			document.reader.info.value="����";
			document.reader.info.style.color="#000000";
			document.reader.info.style.fontWeight="bold";
		}
	}else{
		document.reader.info.value="�豸�ȴ���ȡ......";
		document.reader.info.style.color="#000000";
		document.reader.info.style.fontWeight="bold";
	}
        //alert("data_length2"+data_length);
	delete data;
	delete data_length;
	CollectGarbage();
}
function hexTobin(hex){
	var length=hex.length-1;
	var i=0;
	var subHex;
	var bin="";
	for(i;i<length;i=i+2){
		subHex=parseInt(hex.substring(i,i+2),16);
		bin=bin+String.fromCharCode(subHex);
	}
	document.reader.bin.value=bin;
	document.reader.bin.style.color="#000000";
	document.reader.bin.style.fontWeight="bold";
	delete length;
	delete i;
	delete subHex;
	delete bin;
	CollectGarbage();
}
function startgetdata(){ 
	document.reader.read_type.disabled=true;
	document.reader.interval.disabled=true;
	document.reader.info.value="�豸�ȴ���ȡ......";
	document.reader.info.style.color="#000000";
	document.reader.info.style.fontWeight="bold";
	var readType=document.reader.read_type.value;
	oReq.OpenReaderLight();
	if(readType=="0"){
		var time=document.reader.interval.value;
		if(time<200){
			time=200;
		}
		iTimerID = window.setInterval("getdata(0)", time);
		document.reader.read_data.disabled=true;
		document.reader.stop_read.disabled=false;
		document.reader.query_state.disabled=true;
		delete time;
	}else{
		getdata(1);
		oReq.CloseReaderLight();
		document.reader.stop_read.disabled=true;
		document.reader.read_type.disabled=false;
		document.reader.interval.disabled=false;
	}
	delete readType;
	CollectGarbage();
}
function stopgetdata(){ 
	oReq.CloseReaderLight();
	window.clearTimeout(iTimerID);
	document.reader.read_type.disabled=false;
	document.reader.interval.disabled=false;
	document.reader.read_data.disabled=false;
	document.reader.stop_read.disabled=true;
	document.reader.query_state.disabled=false;
	document.reader.info.value="��ȡ������ֹ��";
	document.reader.info.style.color="#000000";
	document.reader.info.style.fontWeight="bold";
}
function clearTimes(){
	document.reader.times.value="0";
	document.reader.info.value="";
	read_times=0;
}
function clearMem(){
	window.clearTimeout(iTimerID);
	//delete iTimerID;
	//oReq.ReaderClose();
	delete oReq;
	delete read_times;
	CollectGarbage();
}
function readMenuChange(){
	var readType=document.reader.read_type.value;
	if(readType=="0"){
		document.reader.interval.disabled=false;
		document.reader.interval.value="500";
	}
	else{
		document.reader.interval.value="";
		document.reader.interval.disabled=true;
	}
	delete readType;
	CollectGarbage();
}
function readerMenuChange(){
	var readerType=document.reader.reader_type.value;
	if(readerType=="0"){
		document.reader.com.disabled=false;
	}else{
		document.reader.com.value="";
		document.reader.com.disabled=true;
		if(readerType=="1"){
			readerInit(1,"",0,"");
		}else{
			readerInit(2,"",0,"USB1");
		}
	}
	delete readerType;
	CollectGarbage();
}
function comReader(){
	var com_port=document.reader.com.value;
	readerInit(0,com_port,9600,"USB1");
	delete com_port;
	CollectGarbage();
}
function interfaceInit(){
	document.reader.stop_read.disabled=true;
	document.reader.read_data.disabled=true;
	document.reader.change_reader.disabled=true;
	document.reader.query_state.disabled=true;
	document.reader.init.value="�豸��δ��ʼ����";
	document.reader.init.style.color="#ff0000";
	document.reader.init.style.fontWeight="bold";
	document.reader.reader_type.value="";
	document.reader.com.value="";
	document.reader.reader_state.value="";
	document.reader.reader_type.value="1";
	readerMenuChange();
}
function beforeChangeReader(){
	if(iTimerID!=null){
		window.clearTimeout(iTimerID);
		iTimerID=null;
	}
	oReq.ReaderClose();
	interfaceInit();
	document.reader.reader_type.disabled=false;
	document.reader.com.disabled=false;
	document.reader.change_reader.disabled=true;
}
function returndata()
{
  clearMem();
  window.returnValue=document.reader.bin.value;
  window.close();
}
</script>
<body class="navtree" onunload="returndata()">
<br>
<form name="reader">
<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">ѡ���������</div>
	</div>

  <TABLE cellSpacing="0">
  <TR>
    <TD Align=center class="blue">ʶ��ͷ����</TD>
    <TD><select name="reader_type" onchange="readerMenuChange()">
      <!--option value="0">COMʶ��ͷ+USBKEY</option>-->
      <option value="1">USBʶ��ͷ+����IC��</option> 
      <!--option value="2">USBʶ��ͷ+USBKEY</option>-->
    </select>&nbsp;
	<input type="button" name="change_reader" class="b_text" value="����ʶ��ͷ" onclick="beforeChangeReader()"/>
    </TD>
  </TR>
  <TR>
    <TD Align=center class="blue">COM�˿�</TD>
    <TD><select name="com" disabled="disabled" onchange="comReader()">
      <option value="COM1">COM1</option>
      <option value="COM2">COM2</option>
	  <option value="COM3">COM3</option>
	  <option value="COM4">COM4</option>
    </select>������COMʶ��ͷ��Ч��
    </TD>
  </TR>
  <TR>
    <TD Align=center class="blue">��ȡ��ʽ</TD>
    <TD><select name="read_type" onchange="readMenuChange()">
      <option value="0" selected="selected">ѭ����ȡ</option>
      <option value="1">���ζ�ȡ</option>
    </select>
    </TD>
  </TR>
  <TR>
    <TD Align=center class="blue">��ȡ���</TD>
    <TD><input name ="interval" type="text" value="500" size =8 maxlength="8" onkeypress="return event.keyCode>=48&&event.keyCode<=57" 
  onpaste="var s=clipboardData.getData('text'); if(!/\D/.test(s)) value=s.replace(/^0*/,''); return false;" ondragenter="return false" 
  style="ime-mode:disabled"  onkeyup="if(/(^0+)/.test(value))value=value.replace(/^0*/, '')">
    ���루�����ѭ����ȡ��Ч��</TD>
  </TR>
  <TR>
    <TD Align=center class="blue">�豸��ʼ��</TD>
    <TD><input name ="init" type="text" size =20 readonly="true" Class="InputGrey"></TD>
  </TR>
  <TR>
    <TD Align=center class="blue">�豸״̬</TD>
    <TD><input name ="reader_state" type="text" size =20 readonly="true"  Class="InputGrey"></TD>
  </TR>
  <TR>
    <TD Align=center class="blue">�������ݣ�BIN��</TD>
    <TD><input name ="bin" type="text" size =50 readonly="true" Class="InputGrey"></TD>
  </TR>
  <TR>
    <TD Align=center class="blue">�������ݣ�HEX��</TD>
    <TD><input name ="hex" type="text" size =50 readonly="true" Class="InputGrey"></TD>
  </TR>
  <TR>
    <TD Align=center></TD>
    <TD><input name ="temp" type="hidden"/></TD>
  </TR>
  <TR>
    <TD Align=center class="blue">���볤��</TD>
    <TD><input name ="data_len" type="text" size =5 readonly="true" Class="InputGrey"></TD>
  </TR>
  <TR>
    <TD Align=center class="blue">��Ϣ����</TD>
    <TD><input name ="message_type" type="text" size =5 readonly="true" Class="InputGrey"></TD>
  </TR>
  <TR>
    <TD Align=center class="blue">�Ѷ�ȡ����</TD>
    <TD><input name ="times" type="text" value="0" size =5 readonly="true" Class="InputGrey"></TD>
  </TR>
   <TR>
    <TD Align=center class="blue">��Ϣ</TD>
    <TD><input name ="info" type="text" size =50 readonly="true" Class="InputGrey"></TD>
  </TR>
  <TR>
    <TD Align=center colSpan=2 id="footer">
	<input type="button" name="read_data" class="b_foot" value="��ȡ����" onclick="startgetdata()" />
	&nbsp;
	<input type="button" name="stop_read" class="b_foot"  value="ֹͣ��ȡ" onclick="stopgetdata()"/>
	&nbsp;
	<input type="button" name="query_state" class="b_foot"  value="��ѯ״̬" onclick="getReaderState()"/>
	&nbsp;
	<input type="button" name="closeWindow" class="b_foot"  value="��������" onclick="returndata()"/>
    </TD>
  </TR>
</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
<script language="JavaScript">
var oReq;
//oReq=document.reader.oReq;
oReq=new ActiveXObject("ER_Reader.ER_READER_OPERATE")
var iTimerID;
var read_times=0;
interfaceInit();
</script>
<br>
</body></html>
