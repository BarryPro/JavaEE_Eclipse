   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-23
********************/
%>
              
<%
  String opCode = "1397";
  String opName = "������ʹҵ������";
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="java.util.*"%>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
  
    request.setCharacterEncoding("GBK");
%>

<html>

<head>
<title>������ʹҵ������</title>
<%
	String phoneNo = (String)request.getParameter("activePhone");
    String workNoFromSession=(String)session.getAttribute("workNo");
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");

	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;
	  	
	String regionCode = (String)session.getAttribute("regCode");
   
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>

//----------------��֤���ύ����-----------------
 function verifyCust(){
 	var vOpFlag;
  if(document.frm.opFlag[0].checked)
  {
  	vOpFlag = document.frm.opFlag[0].value;
  }
  else
  {
  	vOpFlag = document.frm.opFlag[1].value;
  }
	var myPacket = new AJAXPacket("custmsg.jsp","���ڲ�ѯ�ͻ���Ϣ�����Ժ�......");
	myPacket.data.add("phoneNo",(document.frm.srv_no.value).trim());
	myPacket.data.add("opFlag",vOpFlag);
	myPacket.data.add("type","0");
	core.ajax.sendPacket(myPacket);
	myPacket = null;

 }

 
function doProcess(packet)
{
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
		var retResult = packet.data.findValueByName("retResult");
    var type = packet.data.findValueByName("type");
		var iccid = packet.data.findValueByName("id_iccid");
    var custName = packet.data.findValueByName("cust_name");
		var custAddress = packet.data.findValueByName("id_address");
    
    if (type == "0"){
		document.frm.iccid.value = iccid;
		document.frm.custName.value = custName;
		document.frm.custAddress.value = custAddress;
			} 

	  if(retCode != "000000"){
			rdShowMessageDialog(retMsg);	
	  }

}

function printCommit()
{         

	getAfterPrompt();

	if (document.frm.srv_no.value.length == 0) {
      rdShowMessageDialog("�ֻ����벻��Ϊ�գ����������� !!",0);
      document.frm.srv_no.focus();
      return false;
     } 
	if(document.frm.iccid.value!="")
  {
	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");

     if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
        {  
	      frm.submit();
        }


	    if(ret=="remark")
	    {
         if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
         {
	       frm.submit();
         }
	   }
	}
    else
    {
       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
       {
	     frm.submit();
       }
    }
  }

    return true;  	 
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var printStr = printInfo(printType);

   	
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
      var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =<%=sysAcceptl%>;                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =  document.all.opCode.value;                         //��������
     var phoneNo = <%=phoneNo%>;                            //�ͻ��绰
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
     return ret;    
}


function printInfo(printType)
{
  	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		
 
    cust_info+="�ֻ����룺"+document.frm.srv_no.value+"|";
    cust_info+="�ͻ�������"+document.frm.custName.value+"|";
    cust_info+="֤�����룺"+document.frm.iccid.value+"|";
    cust_info+="�ͻ���ַ��"+document.frm.custAddress.value+"|";
	
	if(document.frm.opFlag[0].checked )
	{
	 	opr_info+="ҵ�����ͣ�"+"������ʹҵ������"+"|";
	 	document.all.opCode.value = "1397";
	 	document.all.opName.value = "������ʹҵ������";
	}else
	{
		 opr_info+="ҵ�����ͣ�"+"������ʹҵ��ȡ��"+"|";
		 document.all.opCode.value = "1398";
		 document.all.opName.value = "������ʹҵ��ȡ��";
	}
  
	note_info1+="|";

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
    return retInfo;  
  return retInfo;
}



</script>
</head>
<body>
<form name="frm" method="POST" action="f1397_confirm.jsp" >
	<%@ include file="/npage/include/header.jsp" %>                         

		<input type="hidden" name="sysAcceptl"  value="<%=sysAcceptl%>">
		<input type="hidden" name="opCode"  value="">
		<input type="hidden" name="opName"  value="">
	<div class="title">
		<div id="title_zi">������ʹҵ������</div>
	</div>
 
      <table cellspacing="0" >
          <tr> 
              <td colspan="4"  nowrap>&nbsp;</td>
          </tr>
	      <TR > 
	          <TD width="16%" class="blue">��������</TD>
              <TD width="34%">
			       <input type="radio" name="opFlag" value="0001" checked>����&nbsp;&nbsp;
				   <input type="radio" name="opFlag" value="0002" checked>ȡ��
	          </TD>
	          <TD width="16%">&nbsp;</TD>
		      <TD width="34%">&nbsp;</TD>
         </TR>
         <tr> 
           
			<td width="16%"  nowrap class="blue"> 
              <div align="left">�ֻ�����</div>
            </td>
            <td nowrap  width="28%"> 
            <div align="left"> 
                <input  type="text"  name="srv_no"size="12" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11" index="0" value =<%=phoneNo%>  Class="InputGrey" readOnly >
                <font class="orange">*
				<input type="button" name="infor" class="b_text" value="��ѯ" onClick="verifyCust()">
				</font></div>
            </td>
		 <td>&nbsp;</td>
		 <td>&nbsp;</td>
         </tr>
        <tr >
		    <td width="16%"  nowrap> 
               <div align="left" class="blue">�û�����</div>
			</td>
		    <td>
		       <INPUT  TYPE=text NAME="custName"  readonly Class="InputGrey" >
		    </td>
		    <td width="16%"  nowrap class="blue"> 
               <div align="left">&nbsp;</div>
			</td>
			<td>
		       <INPUT  TYPE="hidden" NAME="iccid"  readonly Class="InputGrey" >
		    </td>
         </tr>
         <tr > 
            <td colspan="5" > 
              <div align="center"> 
              <input type=button name="confirm" class="b_foot" value="ȷ��" onClick="printCommit()" index="2">    
              <input type=button name=back value="���" class="b_foot" onClick="frm.reset()">
		      <input type=button name=qryP value="�ر�" class="b_foot" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
 
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer.jsp" %>
    <INPUT  TYPE="hidden" NAME="custAddress" size="40" readonly Class="InputGrey" >
   </form>
</body>
</html>
