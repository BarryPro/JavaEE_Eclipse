<%
   /*
   * ����: ���Ų�Ʒ�����ʷ��ѯ
�� * ����: 2007-12-24
�� * ����: «ѧ�
   * update by qidp @ 2009-09-07 for �����°��Ʒ����
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
	Logger logger = Logger.getLogger("f3103_1.jsp");
	 
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
		
	String returnFlag = request.getParameter("returnFlag");
	
	String op_name = "���Ų�Ʒ�����ʷ��ѯ";
	
	String opCode = "3103";
	String opName = "���Ų�Ʒ�����ʷ��ѯ";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head> 
<script language=javascript>
	

//core.loadUnit("debug");
//core.loadUnit("rpccore");
onload=function() 
{
	self.status="";
	//core.rpc.onreceive = doProcess;
}

function doProcess(packet) 
{
	var errCode=packet.data.findValueByName("errCode");
	var errMsg=packet.data.findValueByName("errMsg");
	
	if(parseInt(errCode)!=0)
	{
		rdShowMessageDialog("������룺"+errCode+",������Ϣ��"+errMsg);
		return false;
	}
	else
	{
		
		var id_no			=packet.data.findValueByName("id_no");
		var product_code  	=packet.data.findValueByName("product_code");
		var product_name 	=packet.data.findValueByName("product_name");
		var begin_time 		=packet.data.findValueByName("begin_time");
		var end_time		=packet.data.findValueByName("end_time");
		var login_no 		=packet.data.findValueByName("login_no");
		var op_code 		=packet.data.findValueByName("op_code");
		var function_name =packet.data.findValueByName("function_name");
		
		var num         =packet.data.findValueByName("num");
		//alert("luxc:"+num);
		
		for(i=0;i<id_no.length;i++)
		{
			var tr1=tab1.insertRow();
			tr1.id="tr";
			if((i+1)%2==1){
				tr1.bgColor="#f5f5f5";
			}
			else{
				tr1.bgColor="#e8e8e8";
			}
			tr1.insertCell(0).innerHTML = '<td>'+id_no[i]			+'</td>';
			tr1.insertCell(1).innerHTML = '<td>'+product_code[i]	+'</td>';
			tr1.insertCell(2).innerHTML = '<td>'+product_name[i]	+'</td>';
			tr1.insertCell(3).innerHTML = '<td>'+begin_time[i]	+'</td>';
			tr1.insertCell(4).innerHTML = '<td>'+end_time[i]		+'</td>';
			tr1.insertCell(5).innerHTML = '<td>'+login_no[i]	+'</td>';
			tr1.insertCell(6).innerHTML = '<td>'+op_code[i]		+'</td>';
			tr1.insertCell(7).innerHTML = '<td>'+function_name[i]	+'</td>';
		}
		
		var vProductCodeNow = packet.data.findValueByName("productCodeNow");
		var vProductNameNow = packet.data.findValueByName("productNameNow");
		var vBeginTimeNow = packet.data.findValueByName("beginTimeNow");
		var vEndTimeNow = packet.data.findValueByName("endTimeNow");
		
		$("#productInfoFlag").css("display","");
		$("#product_code_now").val(vProductCodeNow);
		$("#product_name_now").val(vProductNameNow);
		$("#begin_time_now").val(vBeginTimeNow);
		$("#end_time_now").val(vEndTimeNow);
	}
}


function commitJsp(){
	if(!check(document.form1)) return false;
	if(document.form1.cust_name.value==""){
        rdShowMessageDialog("���ſͻ����Ʋ���Ϊ�� ���Ȳ�ѯ��",0);
    	return false;
	}
	var rows=tab1.rows.length;
	for(i=1;i<rows;i++){
		tab1.deleteRow(1);
	}
	if(document.all.begin_time.value!="")
	{
		if(!forDate(document.all.begin_time))
		{
			return false;
		}
	}
	if(document.all.end_time.value!="")
	{
		if(!forDate(document.all.end_time)&&document.all.end_time.value!="")
		{
			return false;
		}
	}
	var grp_id=document.all.grp_id.value;
	var begin_time=document.all.begin_time.value;
	var end_time=document.all.end_time.value;
	
	var myPacket = new AJAXPacket("f3103_2.jsp","���ڲ�ѯ,���Ժ�......");
	myPacket.data.add("grp_id",grp_id);
	myPacket.data.add("begin_time",begin_time);
	myPacket.data.add("end_time",end_time);
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}










function getInfo_Cust()
{
    var pageTitle = "���ſͻ�ѡ��";
    var fieldName = "֤������|�ͻ�ID|�ͻ�����|�û�ID|�û���� |�û�����|��Ʒ����|��Ʒ����|����ID|�����ʻ�|Ʒ������|�����û����|APN���|";
	var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "12|0|1|2|3|4|5|6|7|8|9|10|11|";
    var retToField = "iccid|cust_id|cust_name|grp_id|user_no|grp_name|product_code|product_name|unit_id|account_id|sm_name|user_no|";
    var cust_id = document.form1.cust_id.value;
    if(document.form1.iccid.value == "" &&
       document.form1.cust_id.value == "" &&
       document.form1.unit_id.value == "" &&
       document.form1.user_no.value == "")
    {
        rdShowMessageDialog("���������֤�š����ſͻ�ID�����ű�Ż����û���Ž��в�ѯ��",0);
        document.form1.iccid.focus();
        return false;
    }

    if(document.form1.cust_id.value != "" && forNonNegInt(form1.cust_id) == false)
    {
    	form1.cust_id.value = "";
        rdShowMessageDialog("���������֣�",0);
    	return false;
    }

    if(document.form1.unit_id.value != "" && forNonNegInt(form1.unit_id) == false)
    {
    	form1.unit_id.value = "";
        rdShowMessageDialog("���������֣�",0);
    	return false;
    }

    if(document.form1.user_no.value == "0")
    {
    	form1.user_no.value = "";
        rdShowMessageDialog("�����û���Ų���Ϊ0��",0);
    	return false;
    }

    PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/query/f3103_getgrpuser.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
    path = path + "&cust_id=" + document.all.cust_id.value;
    path = path + "&unit_id=" + document.all.unit_id.value;
    path = path + "&user_no=" + document.all.user_no.value;
    //path = path + "&op_code=" + document.all.op_code.value;

    retInfo = window.open(path,"newwindow","height=450, width=1000,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}


function getvaluecust(retInfo)
{
  var retToField = "iccid|cust_id|cust_name|grp_id|run_name|grp_name|product_code|product_name|unit_id|account_id|sm_name|user_no|";
  if(retInfo ==undefined)      
    {   return false;   }

	var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
    
}





	
</script>

<body>
<form name="form1" method="post" action="">

<input type="hidden" name="grp_name" value="">
<input type="hidden" name="product_code" value="">
<input type="hidden" name="product_name" value="">
<input type="hidden" name="account_id" value="">
<input type="hidden" name="sm_name" value="">
<input type="hidden" name="grp_id" value="">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">���Ų�Ʒ�����ʷ��ѯ</div>
</div>
	<TABLE id="mainOne" cellspacing="0" >
		<TBODY>
			<TR>
            	<td class='blue' nowrap width='18%'>֤������</TD>
            	<TD width='32%'>
            	    <input name=iccid id="iccid" maxlength="18" v_type="string" v_must=1 index="1">
            	    <font class="orange">*</font>
            	    <input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor��hand" value=��ѯ>
            	    
            	</TD>
            	<td class='blue' nowrap width='18%'>���ſͻ�ID</TD>
            	<TD>
            	  <input type="text" name="cust_id" size="20" maxlength="18" v_type="0_9" v_must=1 index="2">
            	  <font class="orange">*</font>
            	</TD>
          	</TR>
          	<TR>
          	  	<td class='blue' nowrap>���ű��</TD>
          	  	<TD>
		  	  	<input name=unit_id id="unit_id"  maxlength="10" v_type="0_9" v_must=1 index="3">
          	  	<font class="orange">*</font>
          	  	</TD>
          	  	<td class='blue' nowrap>���Ų�Ʒ���</TD>
          	  	<TD>
          	  	  <input name="user_no" size="20" v_must=1 v_type=string index="4">
          	  	  <font class="orange">*</font>
          	  	</TD>
          	</TR>
          	<TR>
            	<td class='blue' nowrap>���ſͻ�����</TD>
            	<TD>
            	  <input name="cust_name" size="20" readonly v_must=1 v_type=string index="5">
            	</TD>
            	<td class='blue' nowrap>��Ʒ״̬</TD>
            	<TD><input name="run_name" size="20" readonly v_must=1 v_type=string index="6"></TD>
          	</TR>
          	<TR>
          		<td class='blue' nowrap>��ʼʱ��</td>
				<td>
					<input type=text  v_type='date' v_format='yyyyMMdd'  name="begin_time" maxlength="8" size="20">
					(YYYYMMDD)
				</td>
				<td class='blue' nowrap>����ʱ��</td>
				<td>
					<input type=text v_type='date' v_format='yyyyMMdd'   name="end_time" maxlength="8" size="20">
					(YYYYMMDD)
				</td>
			</TR>
		</TBODY>
	</TABLE> 
	

	
	<TABLE cellSpacing=0>
		<TR id="footer"> 
			<TD> 
		    	<input name="bSubmit1" style="cursor:hand" type="button" class="b_foot" value="��ѯ�б�" onClick="commitJsp()">
		    	<input name="" style="cursor:hand" type="button" class="b_foot" value="����" onClick="window.location.href='f3103_1.jsp'">
		    	<input name="" style="cursor:hand" type="button" class="b_foot" value="�ر�" onClick="javascript:removeCurrentTab();">
			</TD>
		</TR>
		
	</TABLE>
<span id="productInfoFlag" name="productInfoFlag" style="display:none;">
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">��ǰ��Ʒ��Ϣ</div>
</div>
<table cellspacing=0>
    <tr>
        <td class='blue' nowrap width='18%'>��ǰ��Ʒ����</td>
        <td width='32%'><input type='text' id='product_code_now' name='product_code_now' value='' class='InputGrey' readOnly /></td>
        <td class='blue' nowrap width='18%'>��ǰ��Ʒ����</td>
        <td><input type='text' id='product_name_now' name='product_name_now' value='' class='InputGrey' readOnly /></td>
    </tr>
    <tr>
        <td class='blue' nowrap width='18%'>��Ʒ��ʼʱ��</td>
        <td width='32%'><input type='text' id='begin_time_now' name='begin_time_now' value='' class='InputGrey' readOnly /></td>
        <td class='blue' nowrap width='18%'>��Ʒ����ʱ��</td>
        <td><input type='text' id='end_time_now' name='end_time_now' value='' class='InputGrey' readOnly /></td>
    </tr>
</table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">��Ʒ�����ʷ</div>
</div>
	<table cellspacing=0 id="tab1" name="tab1">
		<tr>
			<th>��ƷID</th>         
			<th>��Ʒ����</th>
			<th>��Ʒ����</th>
			<th>��Ʒ��ʼʱ��</th>
			<th>��Ʒ����ʱ��</th>
			<th>��������</th>
			<th>��������</th>
			<th>��������</th>
		</tr>
	</table>
</span>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>