<%
/********************
 version v2.0
������: si-tech
*
*huangqi
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
		String opCode = "zg83";
		String opName = "���⼤��";
		String orgCode     = (String)session.getAttribute("orgCode");
		String regionCode  = orgCode.substring(0,2);
		String workno      = (String)session.getAttribute("workNo");
		String workname    = (String)session.getAttribute("workName");
		String nopass      = (String)session.getAttribute("password");
		/****�õ���ӡ��ˮ****/
		String printAccept="";
		printAccept = getMaxAccept();
%>
	 
<HTML>
<HEAD>
<script language="JavaScript">
var printFlag=9;
 function inits(){
 	
 }
 function docheck()
 {
 	var card_no = document.getElementById("card_no").value;//��ֵ������ 
	var remark = document.getElementById("remark").value;//��ע
 	var cardType = document.getElementById("cardType").value;//��ֵ���Ƿ��ѹ�
	var user_phone_no = document.getElementById("user_phone_no").value;// 
	var user_no = document.getElementById("user_no").value;// 
	if(card_no==""){
		rdShowMessageDialog("�������ֵ�����ţ�");
		return false;
	}
	else	if(user_phone_no==""){
		rdShowMessageDialog("������ֿ����ֻ����룡");
		return false;
	}
	else	if(remark==""){
		rdShowMessageDialog("�����뱸ע��Ϣ��");
		return false;
	}
	else	if(user_no==""){
		rdShowMessageDialog("������ֿ���֤�����룡");
		return false;
	}
	else
	{
		/*
		var checkPwd_Packet = new AJAXPacket("zg83_check.jsp","���ڽ��в�ѯ�����Ժ�......");
		checkPwd_Packet.data.add("card_no",card_no);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet=null;
		*/
		//xl add new ���ǰ ���Ӳ�ѯ���ĵط� begin
		var checkPwd_Packet1 = new AJAXPacket("../zg82/zg82_getMoney.jsp","���ڽ��в�ѯ�����Ժ�......");
		checkPwd_Packet1.data.add("card_no",card_no);
		//printAccept
		checkPwd_Packet1.data.add("printAccept","<%=printAccept%>");
		core.ajax.sendPacket(checkPwd_Packet1,s_get_money);
		checkPwd_Packet1=null;
		//end of ��ѯ���

		//xl add for ����߼�
	}
 }
 function  s_get_money(packet)
 {
	 var s_flag = packet.data.findValueByName("s_flag");
	 var loginAccept = packet.data.findValueByName("loginAccept");
	 var card_money = packet.data.findValueByName("card_money");
	 //alert("loginAccept is "+loginAccept);
	 document.getElementById("card_money").value=card_money;
	 var card_no = document.getElementById("card_no").value;//��ֵ������ 
	 var card_pwd = "";//��������ֶ�û��
	 var phoneNo = "";//����ֵ���� �ֶ�û��
	 var user_phone_no = document.getElementById("user_phone_no").value;//�ֿ����ֻ����� 
	 var user_no = document.getElementById("user_no").value;//�ֿ������֤����
	 var cardType = document.getElementById("cardType").value;//��ֵ���Ƿ��ѹ�
	 var remark = document.getElementById("remark").value;//��ע
	 if(s_flag=="0")
	 {
		//alert("1?"); 
		printCommit();
		//alert("2 printFlag is "+printFlag);
		if(printFlag!=1)
		{
			//alert("3?");
			return false;
		}
		else
		{
			//alert("4?");
			var checkPwd_Packet = new AJAXPacket("../zg82/zg82_check.jsp","���ڽ��в�ѯ�����Ժ�......");
			checkPwd_Packet.data.add("card_no",card_no);
			checkPwd_Packet.data.add("card_pwd","");
			checkPwd_Packet.data.add("phoneNo","");		
			checkPwd_Packet.data.add("user_phone_no",user_phone_no);
			checkPwd_Packet.data.add("user_no",user_no);
			checkPwd_Packet.data.add("cardType",cardType);
			checkPwd_Packet.data.add("loginAccept",loginAccept);
			//alert("loginAccept is "+loginAccept);
			core.ajax.sendPacket(checkPwd_Packet);
			checkPwd_Packet=null;
		}
	 }
	 else
     {
		 alert("��ֵ!");
	 }
 } 
function doProcess(packet)
{
	var checkresult = packet.data.findValueByName("checkresult");
	var checkMsg = packet.data.findValueByName("checkMsg");
	var loginAccept = packet.data.findValueByName("loginAccept");
	if(checkresult=="Y")
	{		
		//û�����ݣ���������
		var card_no = document.getElementById("card_no").value;//��ֵ������ 
 	 
 		var cardType = document.getElementById("cardType").value;//��ֵ���Ƿ��ѹ�
		var user_no  =  document.getElementById("user_no").value;
		//document.frm.action="zg83_2.jsp?card_no="+card_no+"&cardType"+cardType+"&user_no="+user_no;
		document.frm.action="zg83_2.jsp?card_no="+card_no+"&cardType"+cardType+"&user_no="+user_no+"&loginAccept="+loginAccept;
		//alert(document.frm.action);
		document.frm.submit();
	}
	else
	{
		alert(checkMsg);
		return false;
	}
}	 
 


 //xl add for Huxl �����ǰ��ӡ
 function printCommit()
 {          
	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");  	
 }
 function showPrtDlg(printType,DlgMessage,submitCfn)
 {  //��ʾ��ӡ�Ի���
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;

	var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=printAccept%>;             			//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							//�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		//С������
	var opCode="zg83" ;                   			 		//��������
	var phoneNo=document.getElementById("user_phone_no").value;                  	 		//�ͻ��绰
	//alert("sysAccept is "+sysAccept);
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfn;
	path+="&mode_code="+mode_code+
		"&fav_code="+fav_code+"&area_code="+area_code+
		"&opCode=<%=opCode%>&sysAccept="+sysAccept+
		"&phoneNo="+phoneNo+
		"&submitCfm="+submitCfn+"&pType="+
		pType+"&billType="+billType+ "&printInfo=" + printStr;

	var ret=window.showModalDialog(path,printStr,prop);
	if(ret==""){
		ret="confirm";
	}
		  if(typeof(ret)!="undefined")
		  {
			 if((ret=="confirm")&&(submitCfn == "Yes"))
			 {
			   if(rdShowConfirmDialog('ȷ��Ҫ���д��������')==1)
			   {
				document.all.printcount.value="1";
				printFlag=1;
			   }
			 }
			 if(ret=="continueSub")
			 {
				if(rdShowConfirmDialog('ȷ��Ҫ���д��������')==1)
				{
					document.all.printcount.value="0";
					printFlag=1;
				}
			 }
		 }
		else
		{
			if(rdShowConfirmDialog('ȷ��Ҫ���д��������')==1)
			{
				document.all.printcount.value="0";
				printFlag=1;
			}
		}
 }
 function printInfo(printType)
 {
		var cust_info=""; //�ͻ���Ϣ
		var opr_info=""; //������Ϣ
		var retInfo = "";  //��ӡ����
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
		
		cust_info+=" "+"|";
		opr_info+="�ֻ�����:"+document.getElementById("user_phone_no").value+"|";
		opr_info+="֤������:"+document.getElementById("user_no").value+"|";
		opr_info+="����ҵ��:��ֵ���������"+"|";
		opr_info+="������ˮ:"+"<%=printAccept%>"+"|";
		opr_info+="ӪҵԱ����:"+"<%=workno%>"+"|";
		opr_info+="����ʱ�䣺" + "<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>" +  "|";
		opr_info+="�����ֵ����:"+document.getElementById("card_no").value+"|";
		opr_info+="�����ֵ����ֵ��"+document.getElementById("card_money").value+"Ԫ"+"|";
		opr_info+="��ע��Ϊ�������ĳ�ֵ������ʹ�ã�������Ӫҵ���ֳ����г�ֵ��������ֵ��������Ӫҵ��Ա����"+"|";

		note_info1+=""+"|";

		retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

		return retInfo;
 }
 //end of huxl
  function doclear() {
 		frm.reset();
 }

-->
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">		
		<%@ include file="/npage/include/header.jsp" %>  
 
     
  
	<table cellspacing="0">
		<tr > 
      <td class="blue" width="15%">��ֵ������ </td>
     	<td> 
				<input class="button"type="text" id="card_no" name="card_no" onKeyPress="return isKeyNumberdot(0)" size="32" maxlength="32"   >
		  </td> 
		    <td class="blue" width="15%">��ֵ���Ƿ��ѹ�</td>
     	<td> 
				<select name="cardType" id="cardType" >
						<option value="0" selected>�ѹ�</option>
						<option value="1">δ��</option>
				</select>
		  </td>   
	<input type="hidden" id="card_money">	    
  	</tr>
	<tr>
		<tr > 
			 <td class="blue" width="15%">�ֿ������֤���� </td>
     	<td> 
				<input class="button"type="text" id="user_no" name="user_no" size="20" onKeyPress="return isKeyNumberdot(0)" size="20" maxlength="20"   >
		  </td>
      <input type="hidden" name="printcount">
		  <td class="blue" width="15%">�ֿ����ֻ����� </td>
     	<td> 
				<input class="button"type="text" id="user_phone_no" name="user_phone_no" size="20" onKeyPress="return isKeyNumberdot(0)"  maxlength="15"   >
		  </td>      
		</tr>
	</tr>
	<tr >   
		  <td class="blue" width="15%">��ע</td>
     	<td colspan=3> 
				<textarea name="remark" id="remark" maxlength="256"  rows="5" cols="75" class="required" ></textarea>
		  </td>      
  	</tr>
	
    <!--
		
		<tr><td  colspan=4></td></tr>
		<tr > 
			 <td class="blue" width="15%">����ֵ�ֻ����� </td>
     	<td> 
				<input class="button"type="text" id="phone_no" name="phone_no" size="20" onKeyPress="return isKeyNumberdot(0)"  maxlength="15"   >
		  </td> 
		 <td class="blue" width="15%" >����</td>
     	<td> 
				<input class="button"type="text" id="card_pwd" name="card_pwd" onKeyPress="return isKeyNumberdot(0)" size="32" maxlength="32"   >
		  </td>   
    
    
    
    
		</tr>
		<tr >   
		  <td class="blue" width="15%">��ע</td>
     	<td colspan=3> 
				<textarea name="remark" id="remark" maxlength="256"  rows="5" cols="75" class="required" ></textarea>
		  </td>      
  	</tr>
	-->
  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="ȷ��" onclick="docheck()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="����" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>