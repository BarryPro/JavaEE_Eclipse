<%
/********************
 version v2.0
������: si-tech
update:anln@2009-02-16 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
   
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	String regionCode= (String)session.getAttribute("regCode");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
<html>
<head>
	<title><%=opName%></title>
<script language=javascript>
<!--
 
  onload=function()
  {
  	document.all.phoneno.focus();   	
  }
 
 	function PhoneChk()
 	{
 		if((document.all.phoneno.value.trim()).length<1)
		{
   		rdShowMessageDialog("�ֻ����벻��Ϊ�գ�");
 	  	return;
		} 

  		var myPacket = new AJAXPacket("post2267Qry.jsp","���ڲ�ѯ�ͻ������Ժ�......");
		myPacket.data.add("phoneNo",document.all.phoneno.value.trim());
		myPacket.data.add("opCode",document.all.op_code.value.trim());
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	}
  
 //--------4---------doProcess����----------------
function doProcess(packet)
{
	var vRetPage=packet.data.findValueByName("rpc_page");  
	var retCode = packet.data.findValueByName("retCode");
  	var retMsg = packet.data.findValueByName("retMsg");
	var cust_name = packet.data.findValueByName("cust_name");
	var type_name = packet.data.findValueByName("type_name");
	var type_no = packet.data.findValueByName("type_no");
	var contact_no = packet.data.findValueByName("contact_no");
	var cust_address = packet.data.findValueByName("cust_address");
	var valid_flag = packet.data.findValueByName("valid_flag");
	if(retCode == 0){
		document.all.cust_name.value = cust_name;
		document.all.IdType.value = type_name;
		document.all.IdTypeNo.value = type_no;
		document.all.ContactNo.value = contact_no;
		document.all.user_address.value = cust_address;
		
		if (valid_flag == '1')
		{
			rdShowMessageDialog("����: 100003 -> �û��Ѿ������ʵ��Ԥ�Ǽ���Ϣȷ��");
		}else
		{
			document.all.confirm.disabled=false;
		}
		
	}else
	{
		rdShowMessageDialog("����:"+ retCode + "->" + retMsg);
		return;
	}    
    
}

//-------2---------��֤���ύ����-----------------

function printCommit(){
    getAfterPrompt();
	//У��
    if(!checkElement(document.s2267.phoneno)) return false;	
    
    if (document.all.ContactNo.value.length < 7)
    {
    	alert("��������Ч����ϵ��ʽ!")
    	return false;
    }
    
    if (document.all.user_address.value.length < 8)
    {
    	alert("��������Ч���û���ס��ַ!")
    	return false;
    }
    
    
	//if(!check(s2267)) return false;
   //��ӡ�������ύ��
   document.all.op_mark.value="�û�"  + document.all.phoneno.value + "ʵ����Ϣ�Ǽ�";
    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");

     if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
        {  
	      ��s2267.submit();
        }


	    if(ret=="remark")
	    {
         if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
         {
	       s2267.submit();
         }
	   }
	}
    else
    {
       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
       {
	     s2267.submit();
       }
    }	
    return true;
  }
  
function showPrtDlg(printType,DlgMessage,submitCfm)
{  
	//��ʾ��ӡ�Ի��� 		
	var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
	var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
	var sysAccept ="<%=sysAcceptl%>";                       // ��ˮ��
	var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
	var mode_code=null;                        //�ʷѴ���
	var fav_code=null;                         //�ط�����
	var area_code=null;                    //С������
	var opCode =   "<%=opCode%>";                         //��������
	var phoneNo = <%=activePhone%>;                           //�ͻ��绰		
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);    

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
	
	cust_info+="�ͻ�������   "+document.all.cust_name.value+"|";
	cust_info+="�ֻ����룺   "+document.all.phoneno.value+"|";  
	
	opr_info+="����ҵ��"+"�ֻ��û�ʵ��Ԥ�Ǽǲ�ѯ/ȷ��"+"|";
    note_info1+="��ע��"+"|";
	
	retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
	return retInfo;	
 }

 //-->
</script>

</head>
<body> 
<form action="2267Cfm.jsp" method="POST" name="s2267"  onKeyUp="chgFocus(s2267)">
	
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">�ֻ��û�ʵ��Ԥ�Ǽǲ�ѯ/ȷ��</div>
	</div>	
	<input type="hidden" name="op_code" id="op_code" value="<%=opCode%>">
	<input type="hidden" name="op_type" id="op_type" value="a">
	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	
	<input type="hidden" name="opName" value="<%=opName%>">
	
	<table cellspacing="0">
		<tr> 
			<td  nowrap width="10%" class="blue">�û�����</td>
			<td nowrap   colspan="3"> 
				<input   type="text" name="phoneno"  v_must=1  v_type="mobphone"  maxlength=11  index="6" value =<%=activePhone%>  readonly class="InputGrey">
				<font class="orange">*</font> 				            
				<input  type="button" name="qryId_No" class="b_text" value="��ѯ" onClick="PhoneChk()" >            
			</td>    
		</tr>
		<tr> 
			<td  nowrap width="10%" class="blue">�û�����</td>
			<td  nowrap  width="40%"> 
				<input name="cust_name" type="text"   index="6" readonly class="InputGrey">
			</td>
			<td  nowrap  width="10%" class="blue">��Ч֤������</td>
			<td  nowrap  width="40%"> 
				<input  type="text" name="IdType" size="30" value="" readonly class="InputGrey">
			</td>
		</tr>
		<tr> 
			<td  nowrap width="10%" class="blue">��Ч֤������</td>
			<td  nowrap  width="40%"> 
				<input  type="text" name="IdTypeNo" size="30" value=""  readonly class="InputGrey">
			</td>
			<td  nowrap  width="10%" class="blue">��Ч��ϵ��ʽ</td>
			<td  nowrap  width="40%"> 
				<input  type="text" name="ContactNo" size="30" value="">
			</td>
		</tr>
		<tr> 
			<td class="blue"> �û���ס��ַ</td>
			<td colspan="3"> 
				<input type="text"  name="user_address" id="user_address" size="60"  maxlength=30>
			</td>
		</tr>
		<tr>
			<td class="blue"> ������ע</td>		
			<td colspan="3" > 
				<input type="text"  name="op_mark" id="op_mark" size="60" v_maxlength=60  v_type=string   index="28" readonly class="InputGrey" maxlength=60> 
			</td>
		</tr>
	</table>	
	<table cellspacing="0">
		<tr>
			<td id="footer">	
      				<input  type="button" name="confirm" class="b_foot_long" value="��ӡ&ȷ��"  onClick="printCommit()" index="26" disabled >
      				<input  type=reset name=back value="���" class="b_foot" onClick="document.all.confirm.disabled=true;" >
      				<input  type="button" name="b_back" class="b_foot" value="����"  onClick="removeCurrentTab()" index="28">    	
    			</td>
    		</tr>
	</table>	
	<%@ include file="/npage/include/footer.jsp" %> 
	<input type="hidden" value="<%=sysAcceptl%>" name="loginAccept"/>
</form>
</body>
</html>

