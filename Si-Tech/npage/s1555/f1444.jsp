<%
/********************
 version v2.0
 ������: si-tech
 ģ�飺ͳһ�콱
 update zhaohaitao at 2009.1.4
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%		
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");	
  
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%>

<%
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
/****************���ƶ�����õ����롢���������� ����Ϣ R1444Init***********************/
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String award_type= request.getParameter("award_type");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;				/* �ֻ�����   */ 
  paraAray1[1] = loginNo; 	    /* ��������   */
  paraAray1[2] = orgCode;				/* ��������   */
  paraAray1[3] = "1444";	   		/* ��������   */
  
  for(int i=0; i<paraAray1.length; i++)
  {
		if( paraAray1[i] == null )
		{
	  	paraAray1[i] = "";
		}
  }
  
  //retList = impl.callFXService("s1444Init", paraAray1, "9","phone",phoneNo);
%>
	<wtc:service name="s1444InitEx" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="9">			
		<wtc:param value="<%=paraAray1[0]%>" />
		<wtc:param value="<%=paraAray1[1]%>" />
		<wtc:param value="<%=paraAray1[2]%>" />
		<wtc:param value="<%=paraAray1[3]%>" />
	</wtc:service>
	<wtc:array id="tempArr"  start="0" length="4" scope="end"/>
<%
  
  String id_no="";				//�û�ID
  String pwd="";					//�û�����
  String bp_name="";			//��������
  String bp_addr="";			//������ַ
  String cardId_type="";	//֤������
  String cardId_no="";		//֤������
  String sm_name="";			//ҵ��Ʒ��
  String total_point="";	//���²��Ż���
  String last_time="";		//����ҽ�ʱ��

  String errCode = retCode1;
  String errMsg = retMsg1;
  
  if(tempArr.length==0)
  {
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
		   retMsg = "s1444Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
	  }
	}
  else if(tempArr.length>0)
  {
	  if(errCode.equals("000000")) {		
		    id_no = tempArr[0][0];					//�û�ID
		 
		    pwd = tempArr[0][1];					//�û�����
		 
		    bp_name = tempArr[0][2];				//��������
		 
		    bp_addr = tempArr[0][3];				//������ַ
		 
		    cardId_type = tempArr[0][4];		//֤������
		 
		    cardId_no = tempArr[0][5];			//֤������
		 
		    sm_name = tempArr[0][6];				//ҵ��Ʒ��
		 
		    total_point = tempArr[0][7];		//���²��Ż���
		
		    last_time = tempArr[0][8];			//����ҽ�ʱ��
	  }	
	  else{
			if(!retFlag.equals("1"))
			{
			   retFlag = "1";
		       retMsg = "s1444Init��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
			}
		}
  }
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept(); 
   
  /*********************��֤�û��ϴζҽ�ʱ��*******************************/
  String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());

	if(null!=last_time && !"".equals(last_time)){
	  if(dateStr.equals(last_time.substring(0,6))){
	  	retFlag = "1";
	    retMsg = "�������Ѿ��һ�����Ʒ!";
	  	
	  }
	 }
    
%>


<head>
<title>���ŷ籩�ҽ�</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
	
  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}
	else{
  %>
  	if("<%=total_point%>"=="" || "<%=total_point%>"==null){
			rdShowMessageDialog("�����µĵ���Ϊ�㣡");
			history.go(-1);
		}
		else if("<%=total_point%>"<10){
			rdShowMessageDialog("�����µĵ���С��10�������Խ��жҽ���");
			history.go(-1);
		}
	<%}%>

</script>

</head>
<body>
	
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>   
  	
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>

<table cellspacing="0">
	<tr>
		<td class="blue">�ֻ�����</td>
		<td>
			<input name="phoneNo" type="text" class="InputGrey" id="phoneNo" value="<%=phoneNo%>" readonly> 
		</td> 
		<td class="blue">ҵ��Ʒ��</td>
		<td>
			<input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_name%>" readonly>
		</td>
	</tr>
	<tr> 
		<td class="blue">�ͻ�����</td>
		<td>
			<input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>	
			<input name="award_type" type="hidden" value=<%=award_type%>> 		  
		</td> 
		<td class="blue">�ͻ���ַ</td>
		<td>
			<input name="bp_addr" type="text" class="InputGrey" id="bp_addr" value="<%=bp_addr%>" size="40" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">֤������</td>
		<td>
			<input name="cardId_type" type="text" class="InputGrey" id="cardId_type" value="<%=cardId_type%>" readonly>
		</td>
		<td class="blue">֤������</td>
		<td>
			<input name="cardId_no" type="text" class="InputGrey" id="cardId_no" value="<%=cardId_no%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">��ǰ����</td>
		<td colspan="3">
			<input name="total_point" type="text" class="InputGrey" id="cardId_type" value="<%=total_point%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">�һ���ϸ</td>
		<td colspan="3"></td>
	</tr>
	<tr>
		<th>
			��Ʒ����
		</th>
		<th align="center">
			10Ԫ��Ʒȯ
		</th>
		<th align="center">
			20Ԫ��Ʒȯ									
		</th>
		<th align="center">
			50Ԫ��Ʒȯ
		</th>
		<th align="center">
			100Ԫ��Ʒȯ									
		</th>
		<th align="center">
			200Ԫ��Ʒȯ									
		</th>
	</tr>
	<tr>
		<td>
			����
		</td>
		<td align="center">
			<input type="text" name="num1" value="0" class="button" v_name="10Ԫ��Ʒȯ����" v_type="0_9" v_must="1" size="8" maxlength="2" onchange="if(chk(this)) comp()">
		</td>
		<td align="center">
			<input type="text" name="num2" value="0" class="button" v_name="20Ԫ��Ʒȯ����" v_type="0_9" size="8" v_must="1" maxlength="2"  onchange="if(chk(this)) comp()">
		</td>
		<td align="center">
			<input type="text" name="num3" value="0" class="button" v_name="50Ԫ��Ʒȯ����" v_type="0_9" size="8" v_must="1" maxlength="1"  onchange="if(chk(this)) comp()">
		</td>
		<td align="center"> 
			<input type="text" name="num4" value="0" class="button" v_name="100Ԫ��Ʒȯ����" v_type="0_9" size="8" v_must="1" maxlength="1"  onchange="if(chk(this)) comp()">
		</td>
		<td align="center">
			<input type="text" name="num5" value="0" class="button" v_name="200Ԫ��Ʒȯ����" v_type="0_9" size="8" v_must="1" maxlength="1"  onchange="if(chk(this)) comp()">
		</td>
	</tr>
			
	<tr>
	<td colspan="3"></td>
	<td align="center">ʹ�õ����ܼ�:
		<input name="usePoint" type="text" class="button" value="0" readonly size="8">
		<input name="leavePoint" type="hidden" >
		<input name="id_no" type="hidden" value="<%=id_no%>">
		</td>
	</tr>
	
	<tr> 
		<td id="footer" colspan="5"> 
			<div align="center"> 
				<input class="b_foot" type=button name="confirm1" value="ȷ��&��ӡ" onClick="printCommit()" index="2" disabled="true">    
				<input class="b_foot" type=button name=back value="����" onClick="rst()">
			    <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()();">
			    <input class="b_foot" type=button name=goback value="����" onClick="history.go(-1);">
			</div>
		</td>
	</tr>
</table>
  <input type="hidden" name="opCode" value="<%=opCode%>">
  <input type="hidden" name="opName" value="<%=opName%>">
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
   <input type="hidden" name="phoneNo" value="<%=phoneNo%>">
  <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
<script language='javascript'>
	function chk(obj){
		if(for0_9(obj)){
			document.all.confirm1.disabled=false;
			return true;
		}
		else{
			document.all.confirm1.disabled=true;
			obj.value="0";
			return false;
		}
	}
	
	function rst(){
			document.all.num1.value="0";
			document.all.num2.value="0";
			document.all.num3.value="0";
			document.all.num4.value="0";
			document.all.num5.value="0";
			document.all.usePoint.value="0";
	}
	
	function doCfm(){		
		document.frm.action="f1444_Cfm.jsp";
		document.frm.submit();
	}
	
	function comp(){
		var psum = 0;
		psum += 10 * document.all.num1.value;
		psum += 20 * document.all.num2.value;
		psum += 50 * document.all.num3.value;
		psum += 100 * document.all.num4.value;
		psum += 200 * document.all.num5.value;
		document.all.usePoint.value = psum;
	}
	
function printInfo(printType)
{
	var cust_info=""; //�ͻ���Ϣ
	var opr_info=""; //������Ϣ
	var note_info1=""; //��ע1
	var note_info2=""; //��ע2
	var note_info3=""; //��ע3
	var note_info4=""; //��ע4
	var retInfo = "";  //��ӡ����
	
	cust_info+="�ֻ����룺"+"<%=phoneNo%>"+"|";
	cust_info+="�ͻ�������"+"<%=bp_name%>"+"|";
    //cust_info+="�ͻ���ַ��"+"<%=bp_addr%>"+"|";
	//cust_info+="֤�����룺"+"<%=cardId_no%>"+"|";
	
	opr_info+="�û�Ʒ�ƣ�"+"<%=sm_name%>"+"|";
    opr_info+="����ҵ��"+"���ŷ籩�ҽ�"+"|";
    opr_info+="�ҽ���ϸ��"+"|";
    opr_info+="10Ԫ��Ʒȯ��"+document.all.num1.value+"��"+"|";
    opr_info+="20Ԫ��Ʒȯ��"+document.all.num2.value+"��"+"|";
    opr_info+="50Ԫ��Ʒȯ��"+document.all.num3.value+"��"+"|";
    opr_info+="100Ԫ��Ʒȯ��"+document.all.num4.value+"��"+"|";
    opr_info+="200Ԫ��Ʒȯ��"+document.all.num5.value+"��"+"|";
    opr_info+="ʹ�õ�����"+document.all.usePoint.value+"��"+"|";
   
	note_info1+="��ע��"+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
	var h=200;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var pType="subprint";                                     
	var billType="1";                                         
	var sysAccept=<%=printAccept%>;                           
	var printStr=printInfo(printType);                        
	var mode_code=null;                                        
	var fav_code=null;                                         
	var area_code=null;                                       
	var opCode="<%=opCode%>";                                
	var phoneNo=document.frm.phoneNo.value;                    
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	
	return ret;    
}

function printCommit()
{  
	getAfterPrompt();
	if(parseInt("<%=total_point%>") >= 200){
		if(document.all.usePoint.value != "200"){
			rdShowMessageDialog("������ֻ���Զһ�200�㣡");
			return false;
		}
		document.all.leavePoint.value = parseInt("<%=total_point%>")-200;
	}
	else{
		if(parseInt(document.all.usePoint.value) > parseInt("<%=total_point%>")){
			rdShowMessageDialog("ʹ�õ��������û������ܵ�����");
			return false;
		}
		else if((parseInt("<%=total_point%>")-10) > parseInt(document.all.usePoint.value)){
			rdShowMessageDialog("��ʹ�õĵ���С����Ͷҽ��޶");
			return false;
		}
		document.all.leavePoint.value = 0;
	}
  
     var ret = showPrtDlg("ȷʵҪ���е��������ӡ��","Yes"); 
     if(typeof(ret)!="undefined")
     {
        if((ret=="confirm"))
        {
          if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
          {
	          doCfm();
          }
	      }
	      if(ret=="continueSub")
	      {
          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
          {
	          doCfm();
          }
	      }
	   }
	   else
	   {
	       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
	       {
		       doCfm();
	       }
	   }
		 return true; 	    
}

</script>
