<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-06
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="java.util.ArrayList"%>
<%
    String opCode = (String)request.getParameter("opCode");
    String opName = (String)request.getParameter("opName");
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String nopass = (String)session.getAttribute("password");
    String orgCode = (String)session.getAttribute("orgCode");
    String retCode = "";
    String retMsg = "";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=opName%></TITLE>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
</HEAD>
<script language="javascript">
//core.loadUnit("debug");
//core.loadUnit("rpccore");
onload=function(){
	//core.rpc.onreceive = doProcess;
}
function validDateNoFocus(obj)
{
  var theDate="";
  var one="";
  var flag="0123456789";
  for(i=0;i<obj.value.length;i++)
  { 
     one=obj.value.charAt(i);
     if(flag.indexOf(one)!=-1)
		 theDate+=one;
  }
  if(theDate.length!=8)
  {
	rdShowMessageDialog("���ڸ�ʽ�������������룡");
	//obj.value="";
	return false;
  }
  else
  {
     var year=theDate.substring(0,4);
	 var month=theDate.substring(4,6);
	 var day=theDate.substring(6,8);
	 if(myParseInt(year)<1900 || myParseInt(year)>3000)
	 {
       rdShowMessageDialog("��ĸ�ʽ�������������룡");
	   //obj.value="";
	   return false;
	 }
     if(myParseInt(month)<1 || myParseInt(month)>12)
	 {
       rdShowMessageDialog("�µĸ�ʽ�������������룡");
  	   //obj.value="";
	   return false;
	 }
     if(myParseInt(day)<1 || myParseInt(day)>31)
	 {
       rdShowMessageDialog("�յĸ�ʽ�������������룡");
	   //obj.value="";
	   return false;
	 }

     if (month == "04" || month == "06" || month == "09" || month == "11")  	         
	 {
         if(myParseInt(day)>30)
         {
	 	     rdShowMessageDialog("���·����30��,û��31�ţ�");
 	         //obj.value="";
             return false;
         }
      }                 
       
      if (month=="02")
      {
         if(myParseInt(year)%4==0 && myParseInt(year)%100!=0 || (myParseInt(year)%4==0 && myParseInt(year)%400==0))
		 {
           if(myParseInt(day)>29)
		   {
 		     rdShowMessageDialog("������·����29�죡");
      	     //obj.value="";
             return false;
		   }
		 }
		 else
		 {
           if(myParseInt(day)>28)
		   {
 		     rdShowMessageDialog("��������·����28�죡");
      	     //obj.value="";
             return false;
		   }
		 }
      }
  }
  return true;
}
function doProcess(packet){
	
	var backString = packet.data.findValueByName("backString");
	var cfmFlag = packet.data.findValueByName("flag");
	var errCode = packet.data.findValueByName("errCode");
	var errMsg = packet.data.findValueByName("errMsg");
		
	var errCodeInt = parseInt(errCode);
	if(cfmFlag==0){
		if(errCodeInt==0){
			rdShowMessageDialog("�����ɹ���",2);
			document.frm.userId.value=backString[0][0];
			document.frm.vTotalDate.value=backString[0][1];
			document.frm.vSmCode.value=backString[0][2];
			document.frm.vSmName.value=backString[0][3];
			document.frm.vBelongCode.value=backString[0][4];
			document.frm.vPhoneNo.value=backString[0][5];
			document.frm.vOrgCode.value=backString[0][6];
			document.frm.vOpCode.value=backString[0][7];
			document.frm.vOpName.value=backString[0][8];
			document.frm.vOpTime.value=backString[0][9];
			document.frm.vMachineCode.value=backString[0][10];
			document.frm.vMachName.value=backString[0][11];
			document.frm.vCashPay.value=backString[0][12];
			document.frm.vSimFee.value=backString[0][13];
			document.frm.vMachineFee.value=backString[0][14];
			document.frm.vInnetFee.value=backString[0][15];
			document.frm.vChoiceFee.value=backString[0][16];
			document.frm.vOtherFee.value=backString[0][17];
			document.frm.vHandFee.value=backString[0][18];
			document.frm.vDeposit.value=backString[0][19];
			document.frm.vBackFlag.value=backString[0][20];
			document.frm.vSystemNote.value=backString[0][21];
			document.frm.vOpNote.value=backString[0][22];
			infoDiv.style.display="";
			document.frm.submit.disabled=false;
		
		}else{
			
			rdShowMessageDialog(errCodeInt+errMsg,0);
			infoDiv.style.display="none";
			document.frm.submit.disabled=true;
		}
	}
	if(cfmFlag==9){
		
		rdShowMessageDialog(errCodeInt+errMsg,0);
		infoDiv.style.display="none";
		document.frm.submit.disabled=true;
	
	}
	
}
function getUserInfo(){

		document.frm.submit.disabled=true;
		if(!forNonNegInt(document.frm.loginAccept)){
		return false;
		}
		if(!forMobil(document.frm.phoneNo)){
		return false;
		}
		if(document.frm.loginAccept.value.length==0){
			rdShowMessageDialog("��������ˮ��!");
			return;
		}
		document.frm.checkDate.value=document.frm.totalDate.value+"01";
		if(!validDateNoFocus(document.frm.checkDate)){
		return false;
		}
		if(document.frm.totalDate.value>document.frm.nowDate.value){
		rdShowMessageDialog("���������Ӧ��С�ڵ�ǰ���ڣ�");
		return false;
		}
		var myPacket = new AJAXPacket("getUserInfo.jsp","�����ύ�����Ժ�......");
		
		myPacket.data.add("phoneNo",document.frm.phoneNo.value);
		myPacket.data.add("loginAccept",document.frm.loginAccept.value);
		myPacket.data.add("totalDate",document.frm.totalDate.value);
		

		
    	core.ajax.sendPacket(myPacket);

    	myPacket = null;
}
function resett(){
document.frm.phoneNo.value="";
document.frm.loginAccept.value="";
document.frm.totalDate.value="";
document.frm.userId.value="";
document.frm.vTotalDate.value="";
document.frm.vSmCode.value="";				
document.frm.vSmName.value="";				
document.frm.vBelongCode.value="";
document.frm.vPhoneNo.value="";
document.frm.vOrgCode.value="";
document.frm.vOpCode.value="";
document.frm.vOpName.value="";
document.frm.vOpTime.value="";
document.frm.vMachineCode.value="";
document.frm.vMachName.value="";
document.frm.vCashPay.value="";
document.frm.vSimFee.value="";
document.frm.vMachineFee.value="";
document.frm.vInnetFee.value="";
document.frm.vChoiceFee.value="";
document.frm.vOtherFee.value="";
document.frm.vHandFee.value="";
document.frm.vDeposit.value="";
document.frm.vBackFlag.value="";
document.frm.vSystemNote.value="";
document.frm.vOpNote.value="";
infoDiv.style.display="none";
document.frm.submit.disabled=true;




}
</script>
<body>

<FORM action="" method=post name="frm" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>

<table cellspacing="0">
    <tr> 
        <td class=blue>�ƶ�����</td>
        <td > 
            <input  id=Text2 type=text size=17 name=phoneNo  maxlength=11 value="">
        </td>
        <td class=blue>��ˮ��</td>
        <td > 
            <input id=Text1 size=17 name=loginAccept type=text value="">
        </td>
        <td class=blue>����</td>
        <td>
            <input type=text size=17 name=totalDate maxlength=6 v_format="yyyyMM" value="">
            <input class="b_text" type=button name=inp value="��ѯ" onclick="getUserInfo()">
        </td>
    </tr>
</table>


<div id=infoDiv style="display:none">

<br>
<div class="title">
	<div id="title_zi">ҵ����Ϣ</div>
</div>
<table cellspacing="0">
    <tr> 
        <td class=blue>�û�I D</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=userId readOnly>
        </td>
        <td class=blue>�ʻ�����</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vTotalDate readOnly >
        </td>
        <td class=blue>ҵ�����</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vSmCode readOnly >
        </td>
    </tr>
    <tr> 
        <td class=blue>ҵ������</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vSmName readOnly >
        </td>
        <td class=blue>��������</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vBelongCode readOnly >
        </td>
        <td class=blue>�ƶ�����</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vPhoneNo readOnly >
        </td>
    </tr>
    <tr> 
        <td class=blue>��������</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vOrgCode readOnly >
        </td>
        <td class=blue>��������</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vOpCode readOnly >
        </td>
        <td class=blue>��������</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vOpName readOnly >
        </td>
    </tr>
    <tr> 
        <td class=blue>����ʱ��</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vOpTime readOnly >
        </td>
        <td class=blue>��������</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vMachineCode readOnly >
        </td>
        <td class=blue>��������</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vMachName readOnly >
        </td>
    </tr>
    <tr> 
        <td class=blue>��ȡ�ֽ�</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vCashPay readOnly >
        </td>
        <td class=blue>SIM����</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vSimFee readOnly >
        </td>
        <td class=blue>��������</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vMachineFee readOnly >
        </td>
    </tr>
    <tr> 
        <td class=blue>��������</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vInnetFee readOnly >
        </td>
        <td class=blue>ѡ�ŷ���</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vChoiceFee readOnly >
        </td>
        <td class=blue>��������</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vOtherFee readOnly >
        </td>
    </tr>
    <tr> 
        <td class=blue>������</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vHandFee readOnly >
        </td>
        <td class=blue>Ѻ��</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vDeposit readOnly >
        </td>
        <td class=blue>������־</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vBackFlag readOnly >
        </td>
    </tr>
    <tr> 
        <td class=blue>��ע</td>
        <td colspan="5"> 
            <input class=InputGrey id=Text2 type=text size=75 name=vSystemNote readOnly >
        </td>
    </tr>
    <tr style="display:none"> 
        <td class=blue>������ע</td>
        <td colspan="5"> 
            <input class=InputGrey id=Text2 type=text size=75 name=vOpNote readOnly >
        </td>
    </tr>

</table>
</div>
<table>

    <TR id="footer">
        <TD colspan=6>
            <input class="b_foot" name=submit  type=button value="��ӡ" onclick="printBill_before()" disabled >
            <input class="b_foot" name=back  type=button value="�ر�" onclick="removeCurrentTab()">
            <input class="b_foot" name=back  type=button value="��λ" onclick="resett()">
        </TD>
    </TR>
</table>

<input type=hidden name=opCode value="1236">
<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=orgCode%>>
<input type=hidden name=sysRemark value="��Ʊ������">
<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
<input type=hidden name=nowDate value="<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%><%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>">
<input type=hidden name=qryFlagT>
<input type=hidden name=customPass>
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>
<input type=hidden name=backLoginAccept>
<input type=hidden name=checkDate>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>


<script>
function printBill_before(){
	var busi_sumPay = 1*document.getElementById("vCashPay").value;//�ֽ𽻿�+֧Ʊ����+Ԥ���
	if(busi_sumPay>0.01 || busi_sumPay<-0.01){
		printBill();
	}else{
		 rdShowMessageDialog("���ο���û�в������ã���˲��ܷ�Ʊ��ӡ��");
		 return;
	}
	
}
function printBill(){
	getAfterPrompt();
	var infoStr = "";
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
	infoStr = "<%=workNo%>|";
	infoStr += document.frm.loginAccept.value + "|";
	infoStr += "��Ʊ����" + "|";
	infoStr += "<%=new java.text.SimpleDateFormat("yyyy|MM|dd", Locale.getDefault()).format(new java.util.Date())%>|";
	infoStr += " |";	//6
	infoStr += " |";
	infoStr += document.getElementById("vPhoneNo").value + "|";
	infoStr += document.frm.userId.value + "|";
	infoStr += " |";
	infoStr += document.getElementById("vCashPay").value + "|";	//10
	infoStr += document.getElementById("vCashPay").value + "|";
	infoStr += "��Ʊ����";
	infoStr += "~ѡ�ŷ��ã�" + document.frm.vChoiceFee.value;
	infoStr += "~SIM���ѣ�" + document.frm.vSimFee.value;
	infoStr += "~�������ã�" + document.frm.vOtherFee.value;
	infoStr += "~�������ã�" + document.frm.vMachineFee.value;
	infoStr += "~Ѻ��" + document.frm.vDeposit.value;
	infoStr += "~�������ã�" + document.frm.vInnetFee.value;
	infoStr += "~";
	infoStr += "~��ע���û� "+document.frm.phoneNo.value+" ��ӡ��Ʊ|";
	infoStr += "<%=workName%>|";
	infoStr += " |";
	infoStr += " |";
	infoStr += " |";
	infoStr += " |";
/*
	 infoStr+='<%=workNo%>'+"  "+document.frm.loginAccept.value+"  "+"��Ʊ����"+"|";
         infoStr+='<%=new java.text.SimpleDateFormat("yyyy   MM    dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+=""+"|";
	     infoStr+=""+"|";
	     infoStr+=document.frm.phoneNo.value+"|";
	     infoStr+=document.frm.userId.value+"|";
	     infoStr+=""+"|";
		 infoStr+=document.frm.vCashPay.value+"|";
	     infoStr+="��Ʊ����*SIM���ѣ�"+document.frm.vSimFee.value+"*�������ã�"+document.frm.vMachineFee.value+"*�������ã�"+document.frm.vInnetFee.value+"|";
 		 infoStr+="ѡ�ŷ��ã�"+document.frm.vChoiceFee.value+"*�������ã�"+document.frm.vOtherFee.value+"*Ѻ��"+document.frm.vDeposit.value+"|";
 		 infoStr+="��ע��"+"�û� "+document.frm.phoneNo.value+" ��ӡ��Ʊ"+"|";
 		 infoStr+='<%=workName%>'+"|";

	 var workNo = document.all.workNo.value;
	 var loginAccept = document.all.loginAccept.value;
	 var totalDate = document.all.totalDate.value;
	 var phoneNo = document.all.phoneNo.value;
	 location.href="chkPrint.jsp?retInfo="+infoStr+"&dirtPage=f1244.jsp&workNo="+workNo+"&loginAccept="+loginAccept+"&totalDate="+totalDate+"&phoneNo="+phoneNo;                    
*/
		var  billArgsObj = new Object();
		$(billArgsObj).attr("10001","<%=workNo%>");
		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	 	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	 	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10005","");//�û����� ����ҳ���Լ���
		$(billArgsObj).attr("10006","");//opName
		$(billArgsObj).attr("10008",document.frm.phoneNo.value);
		$(billArgsObj).attr("10015",document.getElementById("vCashPay").value);//Сд
		$(billArgsObj).attr("10016",document.getElementById("vCashPay").value);//�ϼƽ��(��д) ��Сд������ҳת��
		$(billArgsObj).attr("10017","*");//���νɷѣ��ֽ�
		$(billArgsObj).attr("10020",document.frm.vInnetFee.value);//������
		$(billArgsObj).attr("10021",document.frm.vHandFee.value);//������
		$(billArgsObj).attr("10022",document.frm.vChoiceFee.value);//ѡ�ŷ�
		$(billArgsObj).attr("10023",document.frm.vDeposit.value);//Ѻ��
		$(billArgsObj).attr("10024",document.frm.vSimFee.value);//SIM����
		$(billArgsObj).attr("10026",document.frm.vMachineFee.value);//������
		$(billArgsObj).attr("10027",document.frm.vOtherFee.value);//������
		$(billArgsObj).attr("10030",document.frm.loginAccept.value);//ҵ����ˮ
		$(billArgsObj).attr("10036",document.frm.vOpCode.value);//����������� ֻ���1244
		$(billArgsObj).attr("10073","��Ʊ����"); //1244 �ض�����
		$(billArgsObj).attr("10031","<%=workName%>");//��Ʊ��
		$(billArgsObj).attr("10071","4");//ģ��ţ�ֻҪ��1244����Ʊ����Ϊ����4
		
		var printInfo = "";
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=ȷʵҪ���з�Ʊ��ӡ��";
		
					//��Ʊ��Ŀ�޸�Ϊ��·��
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=ȷʵҪ���з�Ʊ��ӡ��";
	
		var path = path + "&infoStr="+printInfo+"&loginAccept="+document.frm.loginAccept.value+"&opCode=1244&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop); 
		location = "/npage/s1244/f1244.jsp?opCode=1244&opName=<%=opName%>";

}

</script>
</BODY></HTML>
