<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-------------------------------------------->
<!---����:  2008-11-12                    ---->
<!---����:  guanbj                       ---->
<!---����:  s1850                         ---->
<!---���ܣ���Ƶ����                       ---->
<!---�޸ģ��������ͨ��ע��ҵ��         ---->
<!-------------------------------------------->
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<!-------------------�������Զ����ò�ѯWTC����------------------------>
<%
String opCode = "1850";
String opName = "��Ƶ����";
String op_name="";
String regionCode = (String)session.getAttribute("regCode");
String phone_no=request.getParameter("phone_no");
String work_no =(String)session.getAttribute("workNo");
String loginName =(String)session.getAttribute("workName");

%>
<wtc:service name="s1850Qry" outnum="10" routerKey="phone" routerValue="<%=phone_no%>">
<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result" start="0" length="10" scope="end" />
<%
String cust_name="";
String run_name="";
String run_code="";
String is_open="";
String return_code="";
String return_msg="";
String packNumb="";
cust_name=result[0][0];
run_name=result[0][1];
run_code=result[0][2];
is_open=result[0][3];
packNumb=result[0][4];
return_code=result[0][5];
return_msg=result[0][6];
String next_numb=result[0][7];
String cust_address="";
String id_iccid="";
cust_address = result[0][8].trim();
id_iccid = result[0][9].trim();
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
%>
<!-------------------�������Զ����ò�ѯWTC����------------------------>
<html>
<head>
<title>��Ƶ����</title>
<!--js-->

<script type="text/javascript">
core.loadUnit("debug");
core.loadUnit("rpccore");
onload=function()
{
  	//core.rpc.onreceive = doProcess;	
  	var temp= "<%=run_code%>";
  	var return_code="<%=return_code%>";
	var return_msg="<%=return_msg%>";
	if(return_code=="000000")
	{
  		if(<%=is_open%>=='00')
  		{
  			document.getElementById("zx").disabled=true;
	 		document.getElementById("bg").disabled=true;
	 		document.getElementById("mm").disabled=true;
	 		document.getElementById("kt").disabled=false;
		}else if(<%=is_open%>=='02')
		{
			document.getElementById("zx").disabled=true;
	 		document.getElementById("bg").disabled=true;
	 		document.getElementById("mm").disabled=true;
	 		document.getElementById("kt").disabled=true;
	 		rdShowMessageDialog("�û��Ѿ�ע����ҵ��������һ���ٰ���ҵ��");
			parent.removeTab('<%=opCode%>');
		}else
		{
			document.getElementById("kt").disabled=true;
			document.getElementById("zx").disabled=false;
	 		document.getElementById("bg").disabled=false;
	 		document.getElementById("mm").disabled=false;
		}
		//�ٴ���֤����
  		if(temp=='A'||temp=='K'){}
  		else {
  			document.getElementById("kt").disabled=true;
    		document.getElementById("bg").disabled=true;
  		}
  	}else
	{
		rdShowMessageDialog("����:"+return_code+return_msg);
		history.go(-1);
	}
}

function func1(num)
{
	if(num==1 || num==2){
  		document.frm.packNumb.disabled=false;
  		
  	}else{
  		document.frm.packNumb.disabled=true;
  		
  	}
  	if(num==1 ||num==3 ){
  		document.getElementById("booking_vc").style.display="block";
	}
	else
	{
		document.getElementById("booking_vc").style.display="none";
	}
}

function doCfm()
{
	getAfterPrompt();
	var count = 0;
	for(var i = 0 ; i < document.frm.Td_code.length ; i ++)
	{
		if(document.all.Td_code[i].checked){
			count += 1;
			
		} 
	}
	if(count == 0){
		rdShowMessageDialog("������ѡ��һ�������");
		return;	
	}
	
	//var effetiTime = document.frm.effetiTime.value;
	var newPwd = document.frm.newPwd.value;
	//var spId = document.frm.spId.value;
	//var bizCode = document.frm.bizCode.value;
	
	 //alert(newPwd);
	if(newPwd !="" && newPwd.length!=6)
	{
		rdShowMessageDialog("��������λ�����룡");
		return false;
		
	}
	if(document.all.Td_code[0].checked||document.all.Td_code[3].checked)
	{
		if(newPwd.length!=6)
		{
			rdShowMessageDialog("��������λ�����룡");
			return false;
		}
		
	}
	if(newPwd.length==6)
	{
		if(!checkElement(document.frm.newPwd)){return false;}
		var a1="",a2="",a3="",a4="",a5="",a6="";
		a1=newPwd.substring(0,1);
		a2=newPwd.substring(1,2);
		a3=newPwd.substring(2,3);
		a4=newPwd.substring(3,4);
		a5=newPwd.substring(4,5);
		a6=newPwd.substring(5,6);
		if(a1==a2 && a2==a3 && a3==a4 && a4==a5 && a5==a6)
		{
			rdShowMessageDialog("��������λ����ͬ�����룡");
			return false;
		}
		if((parseInt(a1)+1==parseInt(a2) && parseInt(a2)+1==parseInt(a3)&& parseInt(a3)+1==parseInt(a4))||
		(parseInt(a2)+1==parseInt(a3) && parseInt(a3)+1==parseInt(a4)&& parseInt(a4)+1==parseInt(a5))||
		(parseInt(a3)+1==parseInt(a4) && parseInt(a4)+1==parseInt(a5)&& parseInt(a5)+1==parseInt(a6)))
		{
			rdShowMessageDialog("����������������λ�����룡");
			return false;
		}
		if((parseInt(a1)-1==parseInt(a2) && parseInt(a2)-1==parseInt(a3)&& parseInt(a3)-1==parseInt(a4))||
		(parseInt(a2)-1==parseInt(a3) && parseInt(a3)-1==parseInt(a4)&& parseInt(a4)-1==parseInt(a5))||
		(parseInt(a3)-1==parseInt(a4) && parseInt(a4)-1==parseInt(a5)&& parseInt(a5)-1==parseInt(a6)))
		{
			rdShowMessageDialog("����������������λ�����룡");
			return false;
		}
		
		
	}
	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
  	if(typeof(ret)!="undefined")
  	{
    	if((ret=="confirm"))
    	{
      		if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
      		{
	    		frmCfm();
      		}
		}
		if(ret=="continueSub")
		{
      		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
      		{
	    		frmCfm();
      		}
		}
  	}
  	else
  	{
     	if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
     	{
	   	frmCfm();
     	}
  	}
  	return true;
	
}
function frmCfm(){
	var work_no="<%=work_no%>";
	var phone_no="<%=phone_no%>";
	var packNumb=document.frm.packNumb.value;
	var Td_code = "1";
	var newPwd = document.frm.newPwd.value;
	for(var i = 0 ; i< document.frm.Td_code.length; i++){
		 if(document.frm.Td_code[i].checked==true){
		 	Td_code=document.frm.Td_code[i].value;
		 }
	 }
	var myPacket = new AJAXPacket("s1850deal.jsp","�������ڴ������Ժ�......");
	myPacket.data.add("work_no", work_no);
	myPacket.data.add("phone_no", phone_no);
  	myPacket.data.add("packNumb", packNumb);
	myPacket.data.add("Td_code",Td_code);
  	//myPacket.data.add("effetiTime",effetiTime);
  	myPacket.data.add("newPwd",newPwd);
  	myPacket.data.add("login_accept",document.frm.login_accept.value);
	//myPacket.data.add("spId",spId);
  	//myPacket.data.add("bizCode",bizCode);
	//core.rpc.sendPacket(myPacket);
	core.ajax.sendPacket(myPacket);
	myPacket=null; 
	//delete(myPacket);
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
	
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	//alert("ccccccccccccc");
	var pType="subprint";
	var billType="1";  
	var printStr = printInfo(printType);
 	var sysAccept = document.all.login_accept.value;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phone_no%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

	var ret=window.showModalDialog(path,printStr,prop);
	return ret;    
}

function printInfo(printType)
{
    var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
  
	var retInfo = "";
	var count = 0;
	var opr_name="";
	var oprcode="";
	for(var i = 0 ; i < document.frm.Td_code.length ; i ++)
	{
		if(document.all.Td_code[i].checked){
			count += 1;
			oprcode = document.all.Td_code[i].value;
		} 
	}
	if(oprcode=="01")
	{
		opr_name="��ͨ";
	}else if(oprcode=="02")
	{	opr_name="ע��";
	}else if(oprcode=="08")
	{	opr_name="����ȼ����";
	}else if(oprcode=="03")
	{	opr_name="������";
	}
	cust_info+="�ֻ����룺   "+"<%=phone_no%>"+"|";
	cust_info+="�ͻ�������   "+"<%=cust_name%>"+"|";
	cust_info+="�ͻ���ַ��   "+"<%=cust_address%>"+"|";
	cust_info+="֤�����룺   "+"<%=id_iccid%>"+"|";
	
	opr_info+="ҵ�����ͣ���Ƶ����"+opr_name+"|";
	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;	
}
function doProcess(packet)
{
	var code=packet.data.findValueByName("code");
	var msg=packet.data.findValueByName("msg");
	if(code!="000009")
	{
		rdShowMessageDialog(code+","+msg);
		window.location.reload("s1850.jsp?phone_no=<%=phone_no%>&op_code=1850");
	}
	else 
	{
		rdShowMessageDialog("000000,"+msg);
		parent.removeTab('<%=opCode%>');
	}
	
	
}
</script>
</head>
<body>
<form name="frm">
	<%@ include file="/npage/include/header.jsp" %>   
	<div class="title">
	<div id="title_zi">��Ƶ����</div>
	</div>
	
	<table cellspacing="0" >
    	<tr> 
			<td width="10%"  nowrap> �ֻ�����</td>
			<td nowrap>&nbsp;<%=phone_no%></td>
		</tr>
		<tr > 
			<td width="10%"  nowrap> �ͻ�����</td>
			<td  nowrap>&nbsp;
				<%if(cust_name.equals("unknow")){out.print("����δ�Ǽ�");}else{out.print(cust_name);}%>
			</td>
		</tr>
		<tr > 
		      <td width="10%"  >�ͻ���ַ</td>
			  <td  nowrap><%=cust_address%></td>
			 
		   </tr>
		   <tr > 
		      <td width="10%"  >֤������</td>
			  <td  nowrap><%=id_iccid%></td>
		   </tr>
		<tr> 
			<td width="10%"  nowrap> ��ǰ״̬</td>
			<td nowrap>
			  	&nbsp;�ֻ�����״̬Ϊ<font color="#880000"><%=run_name%></font>,
			  	<%
			  	if(is_open.equals("00")){
			  		out.print("����û�а������ҵ��");
			  	}else if(is_open.equals("01")){
			  		out.print("���Ѿ������ҵ�񣬿ɰ���ע����ȼ��������");
			  	}
			  %>

			</td>
		</tr>
		<tr> 
			<td width="10%"  nowrap> ��������</td>
			<td  nowrap>
			    <input type="radio" name="Td_code" id="kt" value="01" onclick="func1(1)">��ͨ����&nbsp;
				<input type="radio" name="Td_code" id="zx" value="02" onclick="func1(0)">ע������&nbsp;
				<input type="radio" name="Td_code" id="bg" value="08" onclick="func1(2)">����ȼ����&nbsp;
				<input type="radio" name="Td_code" id="mm" value="03" onclick="func1(3)">������&nbsp;
			</td>
		</tr>
		<tr> 
			<td width="10%"  nowrap> ����ȼ�</td>
			<td nowrap>&nbsp;��ѡ�����ȼ�
			     <select size="1" name="packNumb" disabled="disabled">
			     	
				   <option value="1" selected>1</option>
				   <option value="2">2</option>
				   <option value="3">3</option>
				   
				 </select>
				 <%if(!packNumb.equals("0") && !next_numb.equals("0"))
				 {%>
				 &nbsp(<font color="#333333">��ǰ����ȼ�</font>��<font color="#880000"><%=packNumb%>��,</font>ԤԼ����ȼ�<font color="#880000"><%=next_numb%>��</font>)
				 <%}%>
				 <%if(!packNumb.equals("0") && next_numb.equals("0"))
				 {%>
				 &nbsp(<font color="#333333">��ǰ����ȼ�</font>��<font color="#880000"><%=packNumb%>��</font>)
				 <%}%>
			</td>
		</tr>
		<!--
		<tr> 
			<td width="10%"  nowrap> ��Чʱ��</td>
			<td  nowrap>
				<input type="text" name="effetiTime" id="effetiTime" v_type="date" v_format = "yyyyMMdd" v_name="��Чʱ��" size="20" onblur="if(checkElement(this)){return false;}" maxlength="8"/>
			</td>
		</tr>
		-->
		<tbody id="booking_vc" style="display:none;">
		<tr> 
			<td width="12%" nowrap> ������</td>
			<td nowrap>
			    <input type="password" name="newPwd" id="newPwd" maxlength="6"  v_type = "0_9"    size="21"/>
			</td>
		</tr>
		</tbody>
		<input type="hidden" name="login_accept" value="<%=printAccept%>">
		<!--
		<tr > 
			<td width="10%"  nowrap> SP��ҵ����</td>
			<td  nowrap>
				<input type="text" name="spId" id="spId"/>
			</td>
		</tr>
		<tr > 
			<td width="10%"  nowrap> SPҵ�����</td>
			<td  nowrap>
				<input type="text" name="bizCode" id="bizCode"/>
			</td>
		</tr>
		-->
		<tr > 
			<td width="10%"  nowrap align="center" colspan="2"> 
				<input type="button" class="b_foot_long" value="ȷ��&��ӡ" name="confirm" onclick = "doCfm();">
			    <input type="button" class="b_foot_long" value="����" name="close" onclick="history.go(-1)">
				<!--<input type="button" class="b_foot_long" value="������������" name="other_no" onclick="location.replace('s1850_verify.jsp?op_code=1850');">-->
            </td>
		</tr>
	</table>
</form>
 <%@ include file="/npage/include/footer.jsp" %>
<br><br>
</body>
</html>
