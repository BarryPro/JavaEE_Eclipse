<%
   /*
   * ����: ����ͳ����ʷ��ѯ
�� * �汾: v1.0
�� * ����: 2006/11/07
�� * ����: xiening
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-09-09    qidp        �°漯�Ų�Ʒ����
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>

<%
	Logger logger = Logger.getLogger("f3188_1.jsp");
	 
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
		
	String op_name = "����ͳ����ʷ��ѯ";
	
	String opCode = "3188";
	String opName = "����ͳ����ʷ��ѯ";
	 
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
		var contract_pay=packet.data.findValueByName("contract_pay");
		var contract_no=packet.data.findValueByName("contract_no");
		var total_date=packet.data.findValueByName("total_date");
		var login_accept=packet.data.findValueByName("login_accept");
		var pay_type=packet.data.findValueByName("pay_type");
		var pay_money=packet.data.findValueByName("pay_money");
		var pay_note=packet.data.findValueByName("pay_note");
		var login_no=packet.data.findValueByName("login_no");
		var op_time=packet.data.findValueByName("op_time");
		var num=packet.data.findValueByName("num");
		/*
		if(parseInt(num)==1){
			var tr1=tab1.insertRow();
			tr1.bgColor="#f5f5f5";
			tr1.insertCell(0).innerHTML = '<td><div align=center>'+contract_pay+'</div></td>';
			tr1.insertCell(1).innerHTML = '<td><div align=center>'+contract_no+'<div></td>';
			tr1.insertCell(2).innerHTML = '<td><div align=center>'+total_date[0].substring(0,6)+'<div></td>';
			tr1.insertCell(3).innerHTML = '<td><div align=center>'+login_accept+'<div></td>';
			tr1.insertCell(4).innerHTML = '<td><div align=center>'+pay_type+'<div></td>';
			tr1.insertCell(5).innerHTML = '<td><div align=center>'+pay_money+'<div></td>';
			tr1.insertCell(6).innerHTML = '<td><div align=center>'+login_no+'<div></td>';
			tr1.insertCell(7).innerHTML = '<td><div align=center>'+op_time+'<div></td>';
		}
		else{*/
			for(i=0;i<contract_pay.length;i++){
				var tr1=tab1.insertRow();
				tr1.id="tr";
				if((i+1)%2==1){
					tr1.bgColor="#f5f5f5";
				}
				else{
					tr1.bgColor="#e8e8e8";
				}
				tr1.insertCell(0).innerHTML = '<td><div align=center>'+contract_pay[i]+'</div></td>';
				tr1.insertCell(1).innerHTML = '<td><div align=center>'+contract_no[i]+'<div></td>';
				tr1.insertCell(2).innerHTML = '<td><div align=center>'+total_date[i].substring(0,6)+'<div></td>';
				tr1.insertCell(3).innerHTML = '<td><div align=center>'+login_accept[i]+'<div></td>';
				tr1.insertCell(4).innerHTML = '<td><div align=center>'+pay_type[i]+'<div></td>';
				tr1.insertCell(5).innerHTML = '<td><div align=center>'+pay_money[i]+'<div></td>';
				tr1.insertCell(6).innerHTML = '<td><div align=center>'+login_no[i]+'<div></td>';
				tr1.insertCell(7).innerHTML = '<td><div align=center>'+op_time[i]+'<div></td>';
			}
		/*}*/
	}
}


function commitJsp(){
    if(document.all.totalDate.value == ""){
        rdShowMessageDialog("ͳ�����²���Ϊ�գ�",0);
        document.all.totalDate.focus();
        return false;
    }
	if(!check(form1)) return false;
	
	var rows=tab1.rows.length;
	for(i=1;i<rows;i++){
		tab1.deleteRow(1);
	}
	
	if(!forDate(document.all.totalDate)){
		return false;
	}
	var contract_Pay=document.all.contract_Pay.value;
	var contract_Pay2=document.all.contract_Pay2.value;
	var totalDate=document.all.totalDate.value;
	var phoneNo=document.all.phoneNo.value;
	var opType=document.all.opType.value;
	var myPacket = new AJAXPacket("f3188_2.jsp","�����ύ�����Ժ�......");
	myPacket.data.add("contract_Pay",contract_Pay);
	myPacket.data.add("contract_Pay2",contract_Pay2);
	myPacket.data.add("totalDate",totalDate);
	myPacket.data.add("opType",opType);
	myPacket.data.add("phoneNo",phoneNo);
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}
	
</script>

<body>
<form name="form1" method="post" action="">
    <%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">����ͳ����ʷ��ѯ</div>
</div>
	<TABLE id="mainOne" cellspacing="0" >
	 
          <TBODY>
          	 <tr id="line_1"> 
          	 	<td class='blue' nowrap>
          	 		��������
          	 	</td>
          	 	<td colspan="3">
          	 		<select name="opType" >
          	 			<option value='3189'>ͳһ����</option>
          	 			<option value='3172'>һ��֧��</option>
          	 		</select>
          	 	</td>
          	 </tr>
             <TR id="line_1"> 
				<td class='blue' nowrap>֧���ʺ�</TD>
		            <TD>		              	
						<input type="text"  v_type="0_9"   v_maxlength=14 name="contract_Pay"   maxlength="14" >
		            </TD>		            
		            <td class='blue' nowrap>��֧���ʺ�</TD>
		            <TD>
		            	<input type="text"  v_type="0_9"  v_maxlength="14" name="contract_Pay2" maxlength="14">
		            </TD>		            	              
	            </TR>
	            <TR id="line_1">
	            	<td class='blue' nowrap>�ֻ�����</TD>
		            <TD>
		              <input type=text v_type="mobphone" v_must="0" name="phoneNo" maxlength="11" value="">	              	
		            </TD> 
					<td class='blue' nowrap>ͳ������</TD>
		            <TD>
		              <input type=text v_format='yyyyMM' v_must="0" name="totalDate" maxlength="6">	              	
		            <font class="orange">*(��ʽ��YYYYMM)</font>
		            </TD> 	            	              
	            </TR>
	                    
          </TBODY>
        </TABLE> 
		  <TABLE  cellSpacing=0>
				 <TR id="footer"> 
		         	<TD> 
		         	    <input name="bSubmit1" style="cursor:hand" type="button" class="b_foot" value="�б�" onClick="commitJsp()">
		         	    <input name="" style="cursor:hand" type="reset" class="b_foot" value="����">
		         	    <input name="" style="cursor:hand" type="button" class="b_foot" value="�ر�" onClick="javascript:removeCurrentTab();">
				 	</TD>
		       </TR>
		       
		   </TABLE>
		  <table cellspacing=0 id="tab1" name="tab1">
				<tr>
				  <th>֧���ʺ�</th>         
				  <th>��֧���ʺ�</th>
				  <th>ͳ������</th>
				  <th>�ֻ�����</th>
				  <th>֧����ʽ</th>
				  <th>֧�����</th>
				  <th>��������</th>
				  <th>����ʱ��</th>
				</tr>
			</table>
			<%@ include file="/npage/include/footer.jsp" %>
			</form>
</body>
</html>