<%
/********************
* ����: ��ѡ�ײͰ������ 3264
* version v3.0
* ������: si-tech
* update by qidp @ 2008-11-27
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%
  String opCode = "3264";
  String opName = "��ѡ�ײͰ������";
  ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
  String[][] baseInfoSession = (String[][])arrSession.get(0);
  String[][] otherInfoSession = (String[][])arrSession.get(2);
  String[][] pass = (String[][])arrSession.get(4);

  String loginNo = baseInfoSession[0][2];
  String loginName = baseInfoSession[0][3];
  String powerCode= otherInfoSession[0][4];
  String orgCode = baseInfoSession[0][16];
  String ip_Addr = request.getRemoteAddr();
  String regionCode = orgCode.substring(0,2);
  String regionName = otherInfoSession[0][5];
  String loginNoPass = pass[0][0];
  String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
%>
<%
String retFlag="",retMsg="";
 //SPubCallSvrImpl impl = new SPubCallSvrImpl();
  //ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String opcode = "3264";
  String backaccept = request.getParameter("backaccept");
  //String pw_favor = request.getParameter("pw_favor");
  String thepassword = request.getParameter("ipassword");

  paraAray1[0] = phoneNo;		/* �ֻ�����   */
  paraAray1[1] = opcode; 	    /* ��������   */
  paraAray1[2] = loginNo;	    /* ��������   */
  paraAray1[3] = backaccept;	    /* ������ˮ   */
  System.out.println("opcode========="+opcode);

  for(int i=0; i<paraAray1.length; i++)
  {
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }

  //retList = impl.callFXService("s3264Qry", paraAray1, "11","phone",phoneNo);
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_name="",mode_type="",run_name="",mode_code="",passwordFromSer="";
  //String[][] tempArr= new String[][]{};
  %>
  
    <wtc:service name="s3264Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="err_code_s3264Qry" retmsg="err_msg_s3264Qry" outnum="11">
        <wtc:param value="<%=paraAray1[0]%>"/>
        <wtc:param value="<%=paraAray1[1]%>"/>
        <wtc:param value="<%=paraAray1[2]%>"/>
        <wtc:param value="<%=paraAray1[3]%>"/>
    </wtc:service>
    <wtc:array id="retS3264QryArr"  scope="end"/>
  <%
  String errCode = err_code_s3264Qry;
  String errMsg = err_msg_s3264Qry;
  if(retS3264QryArr == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
		retFlag = "1";
		retMsg = "s3264Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }else if(!(retS3264QryArr == null))
  {System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(!(errCode.equals("000000"))){%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>");
  	 history.go(-1);
  	//-->
  </script>
  <%}
	if (errCode.equals("000000") ){
	  //tempArr = (String[][])retList.get(2);
	  if(!(retS3264QryArr[0][2].equals(""))){
	    bp_name = retS3264QryArr[0][2];//��������
	    System.out.println(bp_name);
	  }
	  //tempArr = (String[][])retList.get(3);
	  if(!(retS3264QryArr[0][3].equals(""))){
	    bp_add = retS3264QryArr[0][3];//�ͻ���ַ
	  }
	  //tempArr = (String[][])retList.get(4);
	  if(!(retS3264QryArr[0][4].equals(""))){
	    cardId_type = retS3264QryArr[0][4];//֤������
	  }
	  //tempArr = (String[][])retList.get(5);
	  if(!(retS3264QryArr[0][5].equals(""))){
	    cardId_no = retS3264QryArr[0][5];//֤������
	  }
	  //tempArr = (String[][])retList.get(6);
	  if(!(retS3264QryArr[0][6].equals(""))){
	    sm_name = retS3264QryArr[0][6];//ҵ��Ʒ��
	  }
	  //tempArr = (String[][])retList.get(7);
	  if(!(retS3264QryArr[0][7].equals(""))){
	    run_name = retS3264QryArr[0][7];//��ǰ״̬
	  }
	  //tempArr = (String[][])retList.get(8);
	  if(!(retS3264QryArr[0][8].equals(""))){
	    mode_type = retS3264QryArr[0][8];//�ײ����
	  }
	  //tempArr = (String[][])retList.get(9);
	  if(!(retS3264QryArr[0][9].equals(""))){
	    mode_code = retS3264QryArr[0][9];//�ײ�����
	  }
	  //tempArr = (String[][])retList.get(10);
	  if(!(retS3264QryArr[0][10].equals(""))){
	    passwordFromSer = retS3264QryArr[0][10];//�û�����
	  }
	}
  }

%>
 <%  //�Ż���Ϣ//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//

  String[][] favInfo = (String[][])arrSession.get(3);   //���ݸ�ʽΪString[0][0]---String[n][0]
  boolean pwrf = false;//a272 ��������֤
  String handFee_Favourable = "readonly";        //a230  ������
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
    if(tempStr.compareTo("a272") == 0)
    {
      pwrf = true;
    }

  }

  String passTrans=WtcUtil.repNull(request.getParameter("cus_pass"));
  if(!pwrf)
  {
     String passFromPage=Encrypt.encrypt(passTrans);
     if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage))	{
	   if(!retFlag.equals("1"))
	   {
	      retFlag = "1";
          retMsg = "�������!";
	   }

    }
  }
// **************�õ�������ˮ***************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>��ѡ�ײͰ������</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">

<!--


  function frmCfm(){
 	frm.submit();
	return true;
  }
 //***
 function printCommit()
 {
    getAfterPrompt();
  //У��
  //if(!check(frm)) return false;

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
/*
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var printStr = printInfo(printType);

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/page/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
   return ret;
*/
var h=210;
var w=400;
var t=screen.availHeight/2-h/2;
var l=screen.availWidth/2-w/2;

var pType="subprint";
var billType="1";
var sysAccept = document.all.login_accept.value;
var mode_code = null;
var fav_code = null;
var area_code = null;
var printStr = printInfo(printType);

var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opcode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
var ret=window.showModalDialog(path,printStr,prop);
return ret;

}

function printInfo(printType)
{

/*
  	var retInfo = "";
	retInfo+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	retInfo+="�ֻ����룺"+document.all.phone_no.value+"|";
	retInfo+="�ͻ�������"+document.all.cust_name.value+"|";
	retInfo+="֤�����룺"+document.all.cardId_no.value+"|";
	retInfo+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+="�û�Ʒ�ƣ�"+document.all.sm_name.value+"    ����ҵ�񣺿�ѡ�����ײͳ���"+"|";
  	retInfo+="������ˮ��"+document.all.login_accept.value+"|";
  	retInfo+="�����Ŀ�ѡ�����ʷѣ�"+document.all.mode_code.value+"|";
  	retInfo+="ҵ����Чʱ�䣺����"+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+="˵���������������ʷѽ�������Ч�� "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
*/
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
    var retInfo = "";

	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
	cust_info+="֤�����룺"+document.all.cardId_no.value+"|";
	
	opr_info+="�û�Ʒ�ƣ�"+document.all.sm_name.value+"    ����ҵ�񣺿�ѡ�����ײͳ���"+"|";
    opr_info+="������ˮ��"+document.all.login_accept.value+"|";
    opr_info+="�����Ŀ�ѡ�����ʷѣ�"+document.all.mode_code.value+"|";
    opr_info+="ҵ����Чʱ�䣺����"+"|";
    
    note_info1+="˵���������������ʷѽ�������Ч�� "+"|";
    
    retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    
    return retInfo;
}


//-->
</script>
</head>

<body>
<form name="frm" method="post" action="f3264Cfm.jsp" onload="init()">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
       <div id="title_zi">�����ײ���Ϣ</div>
    </div>
        <table border="0" >
          <tr>
            <td class="blue">�ͻ�����</td>
            <td class="blue">
			  <input name="cust_name" value="<%=bp_name%>" type="text" v_must=1 readonly id="cust_name" maxlength="20" v_name="����">
			  <font class="orange">*</font>
            </td>
            <td class="blue">�ͻ���ַ</td>
            <td class="blue">
			  <input name="cust_addr" value="<%=bp_add%>" type="text" v_must=1 readonly id="cust_addr" maxlength="20" >
			  <font class="orange">*</font>
            </td>
          </tr>
          <tr>
            <td class="blue">֤������</td>
            <td class="blue">
			  <input name="cardId_type" value="<%=cardId_type%>" type="text" v_must=1 readonly id="cardId_type" maxlength="20" >
			  <font class="orange">*</font>
            </td>
            <td class="blue">֤������</td>
            <td class="blue">
			  <input name="cardId_no" value="<%=cardId_no%>" type="text" v_must=1 readonly id="cardId_no" maxlength="20" >
			  <font class="orange">*</font>
            </td>
          </tr>
          <tr>
            <td class="blue">ҵ��Ʒ��</td>
            <td class="blue">
			  <input name="sm_name" value="<%=sm_name%>" type="text" v_must=1 readonly id="sm_name" maxlength="20" >
			  <font class="orange">*</font>
            </td>
            <td class="blue">����״̬</td>
            <td class="blue">
			  <input name="run_type" value="<%=run_name%>" type="text" v_must=1 readonly id="run_type" maxlength="20" >
			  <font class="orange">*</font>
            </td>
          </tr>
          <tr>
            <td class="blue">�ײ����</td>
            <td class="blue">
				<input name="mode_type" value="<%=mode_type%>" type="text" v_must=1 readonly id="mode_type" maxlength="20" size="40">
			    <font class="orange">*</font>
			</td>
			<td class="blue">�ײ�����</td>
            <td class="blue">
			  <input name="mode_code" type="text" id="mode_code" value="<%=mode_code%>" readonly>
			  <font class="orange">*</font>
			</td>
          </tr>
          <tr>
            <td class="blue">��ע</td>
            <td colspan="3" class="blue">
             <input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="��ѡ�ײͰ������" readonly>
            </td>
          </tr>
          <tr>
            <td nowrap colspan="4" id="footer">
                    <div align="center"> 
                <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()">
                <input name="reset" type="reset" class="b_foot" value="���" >
                <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
                </div></td>
          </tr>
        </table>
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
	<input type="hidden" name="backaccept" value="<%=backaccept%>">
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>