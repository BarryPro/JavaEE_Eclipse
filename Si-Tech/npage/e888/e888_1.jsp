<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String[] inParas2 = new String[2];
		String opCode = "e888";
		String opName = "��ͯ�ײͼҳ�֧������޸�";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");	    activePhone = request.getParameter("activePhone");
 
		
%>
 
<HTML>
<HEAD>
<script language="JavaScript">
var printFlag=9;
var h=480;
var w=650;
var t=screen.availHeight/2-h/2;
var l=screen.availWidth/2-w/2;
var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
function docheck()
{
	var phoneNo = document.frm.phoneNo.value;
	var childNo=""; 
	if(phoneNo==""||document.frm.phoneNo.value.length!=11)
	{
		rdShowMessageDialog("��������ȷ�ļҳ��ֻ�����!");
		return false;
	}
	

	else
	{
		returnValue = window.showModalDialog('getCount.jsp?phoneNo='+phoneNo,"",prop);
		if(returnValue==null)
		{
			rdShowMessageDialog("û���ҵ���Ӧ���ʺţ�");
			return false;
		}
		if(returnValue=="")
		{
			rdShowMessageDialog("��û��ѡ���ʺţ�");
			return false;
		}
		childNo = returnValue; 	
		//alert("childNo is "+childNo);

		var myPacket1 = new AJAXPacket("getParentInfo.jsp","�����ύ�����Ժ�......");
		myPacket1.data.add("phoneNo",phoneNo);
		myPacket1.data.add("childNo",childNo);
		core.ajax.sendPacket(myPacket1,doGetMoney);
		myPacket1=null;
		/*
		core.ajax.sendPacket(getdataPacket,doRemoteFirstAuth);
			getdataPacket = null;
		*/
	}
	//alert("pwd is "+pwd);

} 

function doGetMoney(packet)
{
	var flag1 = packet.data.findValueByName("flag1");
	var pay_money = packet.data.findValueByName("pay_money");
	var child_no = packet.data.findValueByName("child_no");
	var s_accept  =  packet.data.findValueByName("s_accept");
	document.getElementById("s_accept").value=s_accept;
	//alert("test flag1 is "+flag1+" and pay_money is "+pay_money);
	//flag1="0";
	if(flag1=="0")
	{
		document.getElementById("showid").style.display="block";
		document.getElementById("showid2").style.display="block";
		document.getElementById("money").value=pay_money;
		document.getElementById("childNo").value=child_no;
		document.frm.query.disabled=true;
		document.frm.edit.disabled=false;
	}
	else
	{
		rdShowMessageDialog("�ҳ�δ�����Ӫ����!");
		return false;
	}
	
}	

 function doclear() {
 		frm.reset();
 }

 
-->
	   
 </script> 
 
<title>������BOSS-��ѯ</title>
</head>
<BODY onload="onloads()"> 
<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">��ѯ����</div>
		</div>

    <table cellspacing="0">
      <tbody> 
	  <!--������tr id������
	  <tr class="blue" style="display:none" id="sptime3">
	  -->
   
	   
    </tbody>
  </table>
  
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%" >�ֻ�����</td>
      <td colspan=3> 
        <input class="button"type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" value="<%=activePhone%>" readonly>
      </td>
	   	
	  </tr>
	  
	  <tr id="showid2">
		<td class="blue" width="15%">
			��ͯ�ֻ�����
	    </td>
		<td colspan=3>
			<input type="text" name="secondNo"  id="childNo"  >
		</td>
	  </tr>
	  
	  <tr id="showid">
	   	<td class="blue" width="15%">
			�ҳ���ǰ���
	    </td>
		<td>
			<input type="text" name="oldmoney" id="money"  >
		</td>
		
		<td class="blue" width="15%">
			�޸ĺ���
	    </td>
		<td>
			<input type="text" name="newmoney" onKeyPress="return isKeyNumberdot(1)"  >
		</td>
      </tr>
	  <input type="hidden" id="s_accept" name="s_accept">
	  <input type="hidden" name="printcount">
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="��ѯ" onclick="docheck()" >
          &nbsp;
		  <input type="button" name="edit" class="b_foot" value="�޸�" onclick="doedit()" >
		  &nbsp;
          <input type="reset" name="return1" class="b_foot" value="���"   >
          &nbsp;
         <!--
		  <input type="button" name="reprint"  class="b_foot" value="�ش�Ʊ" onclick="doreprint()">
		  -->
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

<script language="javascript">
	function onloads()
	{
		//alert("q");
		document.frm.query.disabled=false; 
		document.frm.edit.disabled=true;
		document.getElementById("showid").style.display="none";
		document.getElementById("showid2").style.display="none";
	}
	function check_HidPwd()
	{
		if(document.frm.custPwd.value != "" ) 
	   {
		var phoneNo = document.all.phoneNo.value;
		var Pwd1 = document.all.custPwd.value;
		var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
		checkPwd_Packet.data.add("retType","checkPwd");
		checkPwd_Packet.data.add("phone_no",phoneNo);
		checkPwd_Packet.data.add("Pwd1",Pwd1);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet = null;
		}
		else
		{
		   rdShowMessageDialog("����д���룡",0);    
		} 
	}
	function doProcess(packet)
	{
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
			var retMessage=packet.data.findValueByName("retMessage");
		self.status="";
	 //---------------------------------------
		 if(retType == "checkPwd") //���ſͻ�����У��
		 {
			if(retCode == "000000")
			{
				var retResult = packet.data.findValueByName("retResult");
				if (retResult == "false") {
					rdShowMessageDialog("�ͻ�����У��ʧ�ܣ����������룡",0);
					frm.custPwd.value = "";
					frm.custPwd.focus();
					return false;	        	
				} else {
					rdShowMessageDialog("�ͻ�����У��ɹ���",2);
					document.frm.query.disabled=false;
					document.frm.edit.disabled=true;
				}
			 }
			else
			{
				rdShowMessageDialog("�ͻ�����У�����������У�飡",0);
				document.frm.query.disabled=true;
				document.frm.edit.disabled=true;
				return false;
			}
		 }	

		  
	 }
	 function doedit()
	 {
	    var newmoney= document.frm.newmoney.value;
		if(newmoney=="")
		{
			rdShowMessageDialog("�������޸ĺ�ĸ��ѽ��!");
			return false;
		}
		else if(newmoney<0 ||newmoney>100)
		{
			rdShowMessageDialog("���Ѷ��Ӧ��Ϊ0--100֮�䣬����������!");
			return false;
		}
		else
		{
			/*
			for huxl ����ȴ�
			var	prtFlag = rdShowConfirmDialog("�����޸ĺ�ĸ��Ѷ��Ϊ"+newmoney+"Ԫ,�Ƿ�ȷ���޸ģ�");
			if (prtFlag==1)
			{
				document.frm.action="e888_2.jsp";
			    document.frm.submit();
			}
			else
			{
				return false;
			}
			*/
			printCommit();
			if(printFlag!=1)
			{
				return false;
			}
			else
			{
				document.frm.action="e888_2.jsp";
				//alert(document.frm.action);
				document.frm.submit();
			}
			
		}
		
	 }
	function printCommit()
	{          
		showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");  	
	}

	function showPrtDlg(printType,DlgMessage,submitCfn)
	{  //��ʾ��ӡ�Ի��� 
	   var h=210;
	   var w=400;
	   var t=screen.availHeight/2-h/2;
	   var l=screen.availWidth/2-w/2;
		var pType="subprint";
		var billType="1"; 
		var mode_code=null;
		var fav_code=null;
		var area_code=null;
		var firstIdStr = $("#firstId").val();	
		var secondIdStr = $("#secondId").val();
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		var sysAccept = document.getElementById("s_accept").value;	
	   var printStr = printInfo(printType);
	   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage + "&iccidInfo=" +firstIdStr +"|"+secondIdStr + "&accInfoStr="+accInfoStr;
 
		path+="&mode_code="+mode_code+
		"&fav_code="+fav_code+"&area_code="+area_code+
		"&opCode=<%=opCode%>&sysAccept="+sysAccept+
		"&phoneNo="+document.frm.phoneNo.value+
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
		var cust_info="";  				//�ͻ���Ϣ
		var opr_info="";   				//������Ϣ
		var note_info1=""; 				//��ע1
		var note_info2=""; 				//��ע2
		var note_info3=""; 				//��ע3
		var note_info4=""; 				//��ע4
		var retInfo = "";  				//��ӡ����

		var a ="131";
		var b = "11";
		var c=a-b;
		
		cust_info+="�����˹���:"+"<%=workno%>"+"|";
		cust_info+="����������:"+"<%=workname%>"+"|";
	 
		opr_info+="�������ͣ���ͯ�ײͼҳ�֧������޸�"+"|";
		opr_info+="�ҳ��ֻ����룺"+document.frm.phoneNo.value+"|";
		opr_info+="��ͯ�ײͺ���:  "+document.frm.phoneNo.value+"|";
		opr_info+="ԭ֧����ȣ�"+document.frm.oldmoney.value+"    ��֧����ȣ�"+document.frm.newmoney.value+"|";
		opr_info+="��ˮ�ţ�"+document.getElementById("s_accept").value+"|";
		opr_info+="��֧����ȴ�����1����Ч"+"|";
		
		
	   // opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		retInfo+=""+"|";
		retInfo+=""+"|";
		retInfo+=""+"|";
		retInfo+=""+"|";
		retInfo+=""+"|";
		retInfo+=""+"|";

		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
			
	}
</script>