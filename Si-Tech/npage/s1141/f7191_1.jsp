<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: �����ֻ������Ű�BOSS����7191
   * �汾: 1.0
   * ����: 2008/01/13
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%	
	String opCode="7191";
	String opName="�����ֻ������Ű�BOSS����";	
	String loginNo = (String)session.getAttribute("workNo");			//����
	String loginName = (String)session.getAttribute("workName");		//����
	String regionCode = (String)session.getAttribute("regCode");		//���д���
	String phoneNo = request.getParameter("srv_no");					//�û��ֻ���
  	String opcode = request.getParameter("opcode");						//��������
	String retFlag="",retMsg="";
	
	String passwordFromSer="";
	String[] paraAray1 = new String[3];
	paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
	paraAray1[1] = opcode; 	    /* ��������   */
	paraAray1[2] = loginNo;	    /* ��������   */

	for(int i=0; i<paraAray1.length; i++)
	{		
		if( paraAray1[i] == null )
		{
		  	paraAray1[i] = "";
		  
		}
	}
 /* ��������� �����룬������Ϣ���ͻ��������ͻ���ַ��֤�����ͣ�֤�����룬ҵ��Ʒ�ƣ�
 			�����أ���ǰ״̬��VIP���𣬵�ǰ����,����Ԥ��
 */

%>
	<wtc:service name="s7160Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="15" retcode="retCode" retmsg="retMsg1">
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
  
	String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
	String errCode = retCode;
	String errMsg = retMsg1;
	if(tempArr == null)
	{
		System.out.println("retFlagaaaaaaaaaaaaaaaaaa="+retFlag);
		if(!retFlag.equals("1"))
		{
			System.out.println("retFlag="+retFlag);
		   retFlag = "1";
		   retMsg = "s7160Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
		}    
	}else if(!(tempArr == null))
	{
		System.out.println("errCode="+errCode);
		System.out.println("retFlagbbbbbbbbbbbbbbbbbbbbb="+retFlag);
		System.out.println("errMsg="+errMsg);
		if(!errCode.equals("000000") ){%>
			<script language="JavaScript">
			<!--
			  	rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);
			  	 history.go(-1);
			  	//-->
			  </script>
  		<%}
	if (errCode.equals("000000")&&tempArr.length>0 ){
	    bp_name = tempArr[0][2];//��������
	    System.out.println(bp_name);
	    bp_add = tempArr[0][3];//�ͻ���ַ
	    cardId_type = tempArr[0][4];//֤������
	    cardId_no = tempArr[0][5];//֤������
	    sm_code = tempArr[0][6];//ҵ��Ʒ��
	    region_name = tempArr[0][7];//������
	    run_name = tempArr[0][8];//��ǰ״̬
	    vip = tempArr[0][9];//�֣ɣм���
	    posint = tempArr[0][10];//��ǰ����
	    prepay_fee = tempArr[0][11];//����Ԥ��
	    passwordFromSer = tempArr[0][12];//����Ԥ��
	  }
	  
	}
  

%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>
<%
  //�ֻ�Ʒ��
	String[] inParam = new String[2];
	inParam[0] = "select paper_code,paper_name,paper_money,sp_code,oper_code,award_code,award_detailcode,gift_code,to_char(consume_term),server_code from sPaperGiftCfg where region_code=:regionCode" + " and valid_flag='Y' and op_code='7191'";
	inParam[1] = "regionCode="+regionCode;
%>
	<wtc:service name="TlsPubSelCrm"  outnum="10" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg2">
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/> 
	</wtc:service>
	<wtc:array id="agentCodeStr" scope="end"/>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�����ֻ������Ű�BOSS����</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";
  
  var arrpapercode =new Array();
  var arrpapername=new Array();
  var arrpapermoney=new Array();
  var arrspcode=new Array();
  var arropercode=new Array();
  var arrawardcode=new Array();
  var arrawarddetailcode=new Array();
  var arrgiftcode=new Array();
  var arrconsumeterm=new Array();
  var arrservercode=new Array();
 
<%  
  for(int i=0;i<agentCodeStr.length;i++)
  {
	out.println("arrpapercode["+i+"]='"+agentCodeStr[i][0]+"';\n");
	out.println("arrpapername["+i+"]='"+agentCodeStr[i][1]+"';\n");
	out.println("arrpapermoney["+i+"]='"+agentCodeStr[i][2]+"';\n");
	out.println("arrspcode["+i+"]='"+agentCodeStr[i][3]+"';\n");
	out.println("arropercode["+i+"]='"+agentCodeStr[i][4]+"';\n");
	out.println("arrawardcode["+i+"]='"+agentCodeStr[i][5]+"';\n");
	out.println("arrawarddetailcode["+i+"]='"+agentCodeStr[i][6]+"';\n");
	out.println("arrgiftcode["+i+"]='"+agentCodeStr[i][7]+"';\n");
	out.println("arrconsumeterm["+i+"]='"+agentCodeStr[i][8]+"';\n");
	out.println("arrservercode["+i+"]='"+agentCodeStr[i][9]+"';\n");
  }  
  
%>
	
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
 //***IMEI ����У��
 
 function printCommit()
 { 
 	getAfterPrompt();
  //У��
  //if(!check(frm)) return false;
  with(document.frm){
    if(cust_name.value==""){
	  rdShowMessageDialog("����������!");
      cust_name.focus();
	  return false;
	}
	if(paper_code.value==""){
	  rdShowMessageDialog("����������!");
      paper_code.focus();
	  return false;
	}
	
	if(prepay_fee.value-paper_money.value<0){
		rdShowMessageDialog("Ԥ��������ҵ�����Ƚɷ�!");
		return false;
	}
	 }
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
   var h=200;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
	var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=printAccept%>;             			//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							//�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		//С������
	var opCode="7191" ;                   			 		//��������
	var phoneNo="<%=phoneNo%>";                  	 		//�ͻ��绰
   
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo=<%=phoneNo%>"+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;    
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
	
	opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
	cust_info+="֤�����룺"+document.all.cardId_no.value+"|";
	opr_info+="ҵ�����ͣ������ֻ������Ű�BOSS����"+"|";
	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
	opr_info+="�������ͣ�"+document.all.paper_name.value+"|";

 
 /********liyang 20080619****/
 	if(document.all.consume_term.value=="1")
 	{
  		note_info1+="�ʷ�1Ԫ/�£�20��ǰ�������շѣ�21�գ���21������ĩ��������շѡ���ҵ����2008��9��30�����ߣ���ʱϵͳ���Զ�ȡ��������ϵ��"+"|";
	}
	else
	{
  		note_info1+="�ʷ�1Ԫ/�£�20��ǰ�������շѣ�21�գ���21������ĩ��������շѣ�����;�˶������ں�ϵͳ�Զ����ײ�δʹ�õķ���һ������ȡ��ҵ���ں��Զ�ת���£���ȡ1Ԫ/�°��·ѡ���ҵ����2008��9��30�����ߣ���ʱϵͳ���Զ�ȡ��������ϵ��"+"|";
	}

	retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;
}



//-->
</script>

<script language="JavaScript">
<!--
/****************����agent_code��̬����phone_type������************************/
 function selectChange()
 {
 	document.all.paper_money.value="";
 	document.all.sp_code.value="";
 	document.all.oper_code.value="";
 	document.all.award_code.value="";
 	document.all.award_detailcode.value="";
 	document.all.gift_code.value="";
 	document.all.consume_term.value="";
 	document.all.server_code.value="";
 	document.all.paper_name.value="";
 	
  for ( x1 = 0 ; x1 < arrpapermoney.length  ; x1++ )
   	{
      		if ( arrpapercode[x1] == document.all.paper_code.value)
      		{
        				document.all.paper_money.value=arrpapermoney[x1] ;
        				document.all.sp_code.value=arrspcode[x1] ;
        				document.all.oper_code.value=arropercode[x1] ;
        				document.all.award_code.value=arrawardcode[x1] ;
        				document.all.award_detailcode.value=arrawarddetailcode[x1] ;
        				document.all.gift_code.value=arrgiftcode[x1] ;
        				document.all.consume_term.value=arrconsumeterm[x1] ;
        				document.all.server_code.value=arrservercode[x1] ;
        				document.all.paper_name.value=arrpapername[x1] ;
      		}
   	}
 } 
 


//-->
</script>

</head>

<body>
<form name="frm" method="post" action="f7191Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�����ֻ������Ű�BOSS����</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue">��������</td>
		<td colspan="3">�����ֻ������Ű�BOSS����-����</td>
	</tr>
	<tr> 
		<td class="blue">�ͻ�����</td>
		<td>
			<input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20"> 
			<font color="orange">*</font>
		</td>
		<td class="blue">�ͻ���ַ</td>
		<td>
			<input name="cust_addr" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="20" > 
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td class="blue">֤������</td>
		<td>
			<input name="cardId_type" value="<%=cardId_type%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" > 
			<font color="orange">*</font>
		</td>
		<td class="blue">֤������</td>
		<td>
			<input name="cardId_no" value="<%=cardId_no%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" > 
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td class="blue">ҵ��Ʒ��</td>
		<td>
			<input name="sm_code" value="<%=sm_code%>" type="text" class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" > 
			<font color="orange">*</font>
		</td>
		<td class="blue">����״̬</td>
		<td>
			<input name="run_type" value="<%=run_name%>" type="text" class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" > 
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td class="blue">VIP����</td>
		<td>
			<input name="vip" value="<%=vip%>" type="text" class="InputGrey" v_must=1 readonly id="vip" maxlength="20" > 
			<font color="orange">*</font>
		</td>
		<td class="blue">����Ԥ��</td>
		<td>
			<input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" > 
			<font color="orange">*</font>
		</td>
	</tr>
	
	<tr> 
		<td class="blue">ҵ������</td>
		<td colspan="3">
			<SELECT id="paper_code" name="paper_code" v_must=1  onchange="selectChange();">  
				<option value ="">--��ѡ��--</option>
				<%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
				<option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
				<%}%>
			</select>
		<font color="orange">*</font>	
		</td>
		<!--
		<td >ҵ���</td>-->
		<!--  <td >-->
		<input name="paper_money" type="hidden" class="InputGrey" id="paper_money" v_type="money" v_must=1   readonly v_name="�������" >
		<!--  <font color="#FF0000">*</font>	
		</td>-->
		
	</tr>
     
	<tr> 
		<td class="blue">��ע</td>
		<td colspan="3">
			<input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" value="�����ֻ������Ű�BOSS����" > 
		</td>
	</tr>
	<tr> 
		<td colspan="4" align="center" id="footer">  
			<input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()"  >
			&nbsp; 
			<input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
		</td>
	</tr>
</table>
 
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="sp_code" value="" >
	<input type="hidden" name="oper_code" value="" >
    <input type="hidden" name="award_code" value="" >  
	<input type="hidden" name="award_detailcode" value="" > 
	<input type="hidden" name="gift_code" value="" >
	<input type="hidden" name="server_code" value="" >
	<input type="hidden" name="consume_term" value="">
	<input type="hidden" name="paper_name" value="">
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
