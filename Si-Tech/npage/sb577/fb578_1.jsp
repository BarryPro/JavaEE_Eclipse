<%
/********************
 version v2.0
������: si-tech
update:huangrong@2010-09-20
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String opCode = "b578";     
  String opName = "Ԥ�滰������ݮ�ն˳���"; 

  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String powerCode= (String)session.getAttribute("powerCode");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String regionCode = orgCode.substring(0,2);
  String loginNoPass = (String)session.getAttribute("password");
  String op_code=request.getParameter("opCode");
  String groupId = (String)session.getAttribute("groupId");
%>
<%
  String retFlag="",retMsg="";
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String backaccept1= request.getParameter("backaccept1");//ҵ����ˮ
  String userpass="";
  String sqlUserPass = " select  unique trim(user_passwd) from dcustmsg  where phone_no='"+phoneNo+"'";
%>

<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlUserPass%></wtc:sql>
</wtc:pubselect>
<wtc:array id="userPassStr" scope="end"/>
<%
if(code1.equals("000000") || code1.equals("0"))
{
	if(userPassStr!= null && userPassStr.length > 0)
	{
		userpass=userPassStr[0][0];
	}
}
else
{  
%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("������룺<%=code1%>������Ϣ��<%=msg1%>",0);
  	 history.go(-1);
  	//-->
  </script>
<%
}
%>
	
<wtc:service  name="sB578Qry" routerKey="phone" routerValue="<%=phoneNo%>" outnum="27"  retcode="errCode" retmsg="errMsg">	
	<wtc:param  value="<%=backaccept1%>"/>
	<wtc:param  value="<%=op_code%>"/>
	<wtc:param  value="<%=loginNo%>"/>
	<wtc:param  value="<%=phoneNo%>"/>	
	<wtc:param  value="01"/>
	<wtc:param  value="<%=loginNoPass%>"/>
	<wtc:param  value="<%=userpass%>"/>	
</wtc:service>
<wtc:array id="retList" scope="end"/>
<%

 /* ��������� �����룬������Ϣ���ͻ��������ͻ���ַ��֤�����ͣ�֤�����룬ҵ��Ʒ�ƣ���ǰ״̬��VIP���� ������Ԥ��
 			Ӫ�����������ֻ�Ʒ���ͺţ�����������������ޣ�IMEINo�룬�ֻ�Ʒ�ƣ��ֻ�����
 			����������������ޣ�Ԥ���ܽ�ÿ��Ԥ��
 */
  String bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",run_name="",vip="",prepay_fee="";
  String sale_name="",phone_typeno="",IMEINo="",agent_code="",phone_type="";
  String phone_fee="",consume_Term="",baseFee="",monBaseFee="";

  if(retList == null)
  {
		if(!retFlag.equals("1"))
		{
		 System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }else if(!(retList == null))
  {System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(!errCode.equals("000000")&&!errCode.equals("0") ){%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
  <%}
	if (errCode.equals("000000")||errCode.equals("0")){
	  bp_name =retList[0][1];
	  bp_add = retList[0][2];	  
	  sm_code = retList[0][8];
	  prepay_fee = retList[0][10];/*����Ԥ��*/
	  cardId_type = retList[0][11];
	  cardId_no = retList[0][12];
	  sale_name = retList[0][26];
	  phone_typeno = retList[0][16];
	  phone_fee =retList[0][17];   /*������*/
	  consume_Term =retList[0][18];   /*������������*/
	  baseFee =retList[0][19];   /*Ԥ���ܽ��*/
	  monBaseFee =retList[0][20];   /*ÿ��Ԥ��*/
	  vip = retList[0][21];
	  run_name = retList[0][22];
	  agent_code = retList[0][23]; /*�ֻ�Ʒ��*/
	  phone_type = retList[0][24]; /*�ֻ��ͺ�*/
	  IMEINo = retList[0][25]; /*�ֻ��ͺ�*/
	}
  }

%>

<%
String printAccept="";
printAccept = getMaxAccept();
System.out.println("=====================AAAAAAAAAAAAAAAAAAAAAAAAaaaaaa"+printAccept);
%>
<html>
<head>
<title><%=opName%></title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

 <script language=javascript>

 
 </script>
<script language="JavaScript">

<!--
  function frmCfm(){
		var pingchuan="";
  	pingchuan+=document.all.sale_code.value+"|"; 
  	pingchuan+=document.all.agent_code.value+"|"; 
  	pingchuan+=document.all.phone_type.value+"|"; 
  	pingchuan+=document.all.baseFee.value+"|"; 
  	pingchuan+=document.all.monBaseFee.value+"|"; 
  	pingchuan+=document.all.consume_Term.value+"|"; 
  	pingchuan+=document.all.phone_fee.value+"|"; 
  	pingchuan+=document.all.IMEINo.value+"|";   	  	
  	var chuan=document.getElementById("chuan");
  	chuan.value=pingchuan;
		frm.submit();
		return true;
	}


 function printCommit()
 {
	 	getAfterPrompt();
 //��ӡ�������ύ��
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

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
	var h=188;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1"; //1��� 3�վ� 2��Ʊ
	var printStr = printInfo(printType);
	var sysAccept = document.all.login_accept.value;

	var mode_code=null;
	var fav_code=null;
	var area_code=null

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr ;
	var ret=window.showModalDialog(path,printStr,prop);
	//alert(path);
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

	cust_info+="�ֻ����룺   "+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������   "+document.all.cust_name.value+"|";
	cust_info+="�ͻ���ַ��   "+document.all.cust_addr.value+"|";
	cust_info+="֤�����룺   "+document.all.cardId_no.value+"|";
	

	opr_info+="�û�Ʒ�ƣ�"+document.all.sm_code.value+"          ����ҵ��Ԥ�滰������ݮ�ն˳���"+"|";
	opr_info+="������ˮ��"+document.all.login_accept.value+"|"; 	
  opr_info+="�ֻ��ͺţ�"+document.all.phone_typeno.value+"      IMEI�룺"+document.frm.IMEINo.value+"|";		


  var jkinfo="";
  jkinfo+="�˿�ϼƣ�"+document.all.baseFee.value+"Ԫ  ����Ԥ�滰�� "+document.all.baseFee.value+"Ԫ"+"|";
		
	opr_info+=jkinfo+"|";
	
	note_info1 =retInfo;
  note_info1+="��ע��"+document.all.opNote.value+"|";

		retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

//-->
</script>

</head>
<body>
<form name="frm" method="post" action="fb578_2.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�û���Ϣ</div>
	</div>
    <table cellspacing="0" >
		  <tr>
	        <td class="blue">��������</td>
	        <td>Ԥ�滰������ݮ�ն˳���</td>
	        <td>&nbsp;</td>
	        <td>&nbsp;</td>
	</tr>
	<tr>
          <td class="blue">�ͻ�����</td>
          <td>
				<input name="cust_name" value="<%=bp_name%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" v_name="����">
          </td>
          <td class="blue">�ͻ���ַ</td>
          <td>
				<input name="cust_addr" value="<%=bp_add%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_addr" size='40' maxlength="40" >
          </td>
	</tr>
	<tr>
           <td class="blue">֤������</td>
           <td>
				<input name="cardId_type" value="<%=cardId_type%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" >
           </td>
	         <td class="blue">֤������</td>
	         <td>
				<input name="cardId_no" value="<%=cardId_no%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" >
           </td>
	</tr>
	<tr>
           <td class="blue">ҵ��Ʒ��</td>
           <td>
				<input name="sm_code" value="<%=sm_code%>" type="text" Class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" >
           </td>
           <td class="blue">����״̬</td>
			 <td>
				<input name="run_type" value="<%=run_name%>" type="text" Class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" >
             </td>
	</tr>
	<tr>
            <td class="blue">VIP����</td>
            <td>
			    <input name="vip" value="<%=vip%>" type="text" Class="InputGrey" v_must=1 readonly id="vip" maxlength="20" >
            </td>
            <td class="blue">����Ԥ��</td>
            <td>
				<input name="prepay_fee" value="<%=prepay_fee%>" type="text" Class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" >				
            </td>
	</tr>
	</table>
	</div>
	<div id="Operation_Table">
	<div class="title">
	<div id="title_zi">ҵ�����</div>
	</div>
	<table cellspacing="0">
	<tr>
            <td class="blue">Ӫ������ </td>
            <td>
					<input type="text" name="sale_code"  v_name="Ӫ������" Class="InputGrey" id="sale_code"  value="<%=sale_name%>" readonly>
			</td>
			<td class="blue" >ÿ��Ԥ�� </td>
            <td>
			     <input name="monBaseFee" type="text" v_name="ÿ��Ԥ��" Class="InputGrey"  id="monBaseFee"  value="<%=monBaseFee%>" readonly>
            </td>
	</tr>
	<tr>
             <td class="blue">�ֻ�Ʒ���ͺ� </td>
             <td>
					<input name="phone_typeno" type="text" v_name="�ֻ�Ʒ���ͺ�" Class="InputGrey" id="phone_typeno"  value="<%=phone_typeno%>" readonly>
					
			</td>
            <td class="blue">������������ </td>
            <td>
					<input name="consume_Term" type="text" v_name="������������" Class="InputGrey"  id="consume_Term"  value="<%=consume_Term%>" readonly>				
			</td>
	</tr>
	<tr>
          <td class="blue">������ </td>
            <td>
			  		<input name="phone_fee" type="text" v_name="������"  Class="InputGrey" id="phone_fee"  value="<%=phone_fee%>" readonly>
					</td>
          <td class="blue">Ԥ���ܽ�� </td>
            <td>
					<input name="baseFee" type="text" v_name="Ԥ���ܽ��"  Class="InputGrey" id="baseFee" value="<%=baseFee%>" readonly>
			</td>
	</tr>
	<tr>
            <td class="blue" >IMEI��</td>
            <td>
			     			 <input name="IMEINo"  type="text" v_name="IMEI��" Class="InputGrey"  value="<%=IMEINo%>" readonly>
            </td>
            <td class="blue" >��ע</td>
            <td >
			     			 <input name="opNote" type="text" Class="InputGrey" id="opNote" size="60" value="Ԥ�滰������ݮ�ն˳���" readonly>
            </td>
	</tr>
	<tr>
            <td colspan="4" align="center">
                 <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()">
                 <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
            </td>
	</tr>

    </table>
    
    <input type="hidden" name="userpass" value="<%=userpass%>">
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="backaccept1" value="<%=backaccept1%>">
    <input type="hidden" name="chuan" id="chuan">
    <input type="hidden" name="opcode" value="<%=opcode%>">
	  <input type="hidden" name="op_code" value="<%=op_code%>" >
	  <input type="hidden" name="phone_type" value="<%=phone_type%>" >
	  <input type="hidden" name="agent_code" value="<%=agent_code%>" >
	  
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>



