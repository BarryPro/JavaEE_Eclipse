<%
/********************
 version v2.0
������: si-tech
********************/
%>

<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
 <%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../page/bill/getMaxAccept.jsp" %>


<%		
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
 SPubCallSvrImpl impl = new SPubCallSvrImpl();
 ScallSvrViewBean viewBean = new ScallSvrViewBean();//ʵ����viewBean
  ArrayList retList = new ArrayList();
 
  String[] paraAray1 = new String[3];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String passwordFromSer="";
  
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
 int[] lens={13,6};
 HashMap map = new HashMap();
 map.put("0" , "000000");
 String outNum="19";
 CallRemoteResultValue value=viewBean.callService("0",null,"s7165Qry",outNum,lens, paraAray1,map); 
 retList  = value.getList();
 String[][] result = new String[][]{}; 
 String[][] result1 = new String[][]{};
 result = (String[][])retList.get(0);
 String return_code = result[0][0];
 String return_msg = result[0][1];   
 //retList = impl.callFXService("s7165Qry", paraAray1, "19","phone",phoneNo);
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String[][] tempArr= new String[][]{};
  //int errCode = impl.getErrCode();
 // String errMsg = impl.getErrMsg();
  if(retList == null)
  {System.out.println("retFlagaaaaaaaaaaaaaaaaaa="+retFlag);
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s7160Qry��ѯ���������ϢΪ��!<br>return_code: " + return_code + "<br>return_msg+" + return_msg;
    }    
  }else if(!(retList == null))
  {System.out.println("return_code="+return_code);
  System.out.println("retFlagbbbbbbbbbbbbbbbbbbbbb="+retFlag);
  System.out.println("return_msg="+return_msg);
  if(!return_code.equals("000000") ){%>
<script language="JavaScript">
<!--
  	alert("������룺<%=return_code%>������Ϣ��<%=return_msg%>");
  	 history.go(-1);
  	//-->
  </script>
  <%}
	if (return_code.equals("000000")){
	 
	    bp_name = result[0][2];//��������
	    bp_add = result[0][3];//�ͻ���ַ
	    cardId_type = result[0][4];//֤������
	    cardId_no = result[0][5];//֤������
	    sm_code = result[0][6];//ҵ��Ʒ��
	    region_name = result[0][7];//������
	    run_name = result[0][8];//��ǰ״̬
	    vip = result[0][9];//�֣ɣм���
	    posint = result[0][10];//��ǰ����
	    prepay_fee = result[0][11];//����Ԥ��
	    passwordFromSer = result[0][12];//����Ԥ��
	  	result1= (String[][])retList.get(1);
	  
	  
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
 
  String passTrans=Pub_lxd.repNull(request.getParameter("cus_pass")); 
  System.out.println("lllllllllllllllpassTrans="+passTrans);
  if(!pwrf)
  {System.out.println("lllllllllllllllpassTrans22222222222="+passTrans);
     String passFromPage=Encrypt.encrypt(passTrans);
     System.out.println("passFromPage="+passFromPage);
     System.out.println("passwordFromSer="+passwordFromSer);
     if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage))	{%>
     <script language='jscript'>
			  alert("�û��������",0);
			  document.location.replace("<%=request.getContextPath()%>/page/s1141/f7160_login.jsp");
			  </script>
			  <%
     //System.out.println("pppppppppppppppppp");
	  // if(!retFlag.equals("1"))
	   //{
	     // retFlag = "1";
         // retMsg = "�������!";
	   //}
	    
    }       
  }
 %>
<%
//******************�õ�����������***************************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
String exeDate="";
exeDate = getExeDate("1","7165");

    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>"ũ��ͨ"ҵ���ѯ</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../css/jl.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../js/common/common_check.js"></script>
<script type="text/javascript" src="../../js/common/common_util.js"></script>
<script type="text/javascript" src="../../js/common/common_single.js"></script>
<script type="text/javascript" src="../../js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="../../page/s3000/js/S3000.js"></script>
<script language="JavaScript" src="../../page/s1400/pub.js"></script>
<script language="JavaScript" src="../../js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="../../js/rpc/src/core_c.js"></script>

 
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
  
 
	
  function initLoad()
 {
	 if('<%=opcode%>'=='7164'){
		document.all.op_code_7168.style.display="none";
		document.all.op_code_7165.style.display="block";
	 }else{
		document.all.op_code_7168.style.display="block";
		document.all.op_code_7165.style.display="none";
	 }
 
 }

  
</script>




<link rel="stylesheet" href="../../css/jl.css" type="text/css">
</head>


<body bgcolor="#FFFFFF" text="#000000" background="../../images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="initLoad()">
<form name="frm" method="post" action="f7164Cfm.jsp" onKeyUp="chgFocus(frm)">
<table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
      <td background="../../images/jl_background_1.gif" bgcolor="E8E8E8"> 
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="45%"> 
            <p><img src="../../images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
          <td width="55%" align="right"><img src="../../images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">���ţ�<%=loginNo%>
		  <img src="../../images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">����Ա��<%=loginName%></td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" background="../../images/jl_background_3.gif" height="69"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="../../images/jl_logo.gif"></td>
                <td align="right"><img src="../../images/jl_head_1.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="73%"> 
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="42"><img src="../../images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td background="../../images/jl_background_4.gif"><font color="FFCC00"><b>"ũ��ͨ"ҵ���ѯ</b></font></td>
                      <td><img src="../../images/jl_ico_3.gif" width="350" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            
          </td>
          <td width="27%"> 
            <table border="0" cellspacing="0" cellpadding="4" align="right">
              <tr>
                <td><img src="../../images/jl_ico_4.gif" width="60" height="50"></td>
                <td><img src="../../images/jl_ico_5.gif" width="60" height="50"></td>
                <td><img src="../../images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>

        <table width="98%" align="center" bgcolor="#FFFFFF" cellspacing="1" border="0" >
		  
          <tr bgcolor="F5F5F5"> 
            <td>�ͻ�����:</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text" class="button" v_must=1 readonly id="cust_name" maxlength="20" v_name="����"> 
			  <font color="#FF0000">*</font>
            </td>
            <td>�ͻ���ַ:</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text" class="button" v_must=1 readonly id="cust_addr" maxlength="20" > 
			  <font color="#FF0000">*</font>
            </td>
            </tr>
            <tr bgcolor="F5F5F5"> 
            <td>֤������:</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text" class="button" v_must=1 readonly id="cardId_type" maxlength="20" > 
			  <font color="#FF0000">*</font>
            </td>
            <td>֤������:</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text" class="button" v_must=1 readonly id="cardId_no" maxlength="20" > 
			  <font color="#FF0000">*</font>
            </td>
            </tr>
            <tr bgcolor="F5F5F5"> 
            <td>ҵ��Ʒ��:</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text" class="button" v_must=1 readonly id="sm_code" maxlength="20" > 
			  <font color="#FF0000">*</font>
            </td>
            <td>����״̬:</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text" class="button" v_must=1 readonly id="run_type" maxlength="20" > 
			  <font color="#FF0000">*</font>
            </td>
            </tr>
            <tr bgcolor="F5F5F5"> 
            <td>VIP����:</td>
            <td>
			  <input name="vip" value="<%=vip%>" type="text" class="button" v_must=1 readonly id="vip" maxlength="20" > 
			  <font color="#FF0000">*</font>
            </td>
            <td>����Ԥ��:</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="button" v_must=1 readonly id="prepay_fee" maxlength="20" > 
			  <font color="#FF0000">*</font>
            </td>
            </tr>
	
	
	
	<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF" id="op_code_7165">
        <tr>
          <td>
              <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="#FFFFFF">
          <tr> 
            <td bgcolor="#99ccff" width="10%" nowrap> 
              <div align="center">ҵ������</div>
            </td>
            <td bgcolor="#99ccff" width="6%" nowrap> 
              <div align="center">���ʽ</div>
            </td>
			<td bgcolor="#99ccff" width="6%" nowrap> 
              <div align="center">��ʼʱ��</div>
            </td>
			<td bgcolor="#99ccff" width="4%" nowrap> 
              <div align="center">����ʱ��</div>
            </td>
            <td bgcolor="#99ccff" width="5%" nowrap> 
              <div align="center">��Ʒ����</div>
            </td>
            <td bgcolor="#99ccff" width="5%" nowrap> 
              <div align="center">��ȡ��־</div>
            </td>
            
          </tr>
		  <%System.out.println("length="+result1.length);
		     if (result1.length>0) {
			    for (int i=0;i<result1.length;i++){
		  %>
		  <tr bgcolor="#EEEEEE"> 
            <td bgcolor="#E8E8E8" width="8%"><%=result1[i][0]%></td>
            <td bgcolor="#E8E8E8" width="13%"><%=result1[i][1]%></td>
            <td bgcolor="#E8E8E8" width="13%"><%=result1[i][2]%></td>
            <td bgcolor="#E8E8E8" width="10%"><%=result1[i][3]%></td>
            <td bgcolor="#E8E8E8" width="10%"><%=result1[i][4]%></td>
            <td bgcolor="#E8E8E8" width="10%"><%=result1[i][5]%></td> 
			
          </tr>
		  <%}}%>
        </table>
          <tr bgcolor="F5F5F5"> 
            <td colspan="4"> <div align="center"> 
                <input name="back" onClick="history.go(-1)" type="button" class="button" value="����">
                &nbsp; </div></td>
          </tr>
        </table>
	 <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF" id="op_code_7168">
        <tr>
          <td>
              <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="#FFFFFF">
          <tr> 
            <td bgcolor="#99ccff" width="10%" nowrap> 
              <div align="center">ҵ������</div>
            </td>
            <td bgcolor="#99ccff" width="6%" nowrap> 
              <div align="center">���ʽ</div>
            </td>
			<td bgcolor="#99ccff" width="6%" nowrap> 
              <div align="center">��ʼʱ��</div>
            </td>
			<td bgcolor="#99ccff" width="4%" nowrap> 
              <div align="center">����ʱ��</div>
            </td>
          </tr>
		  <%System.out.println("length="+result1.length);
		     if (result1.length>0) {
			    for (int i=0;i<result1.length;i++){
		  %>
		  <tr bgcolor="#EEEEEE"> 
            <td bgcolor="#E8E8E8" width="8%"><%=result1[i][0]%></td>
            <td bgcolor="#E8E8E8" width="13%"><%=result1[i][1]%></td>
            <td bgcolor="#E8E8E8" width="13%"><%=result1[i][2]%></td>
            <td bgcolor="#E8E8E8" width="10%"><%=result1[i][3]%></td>
          </tr>
		  <%}}%>
        </table>
          <tr bgcolor="F5F5F5"> 
            <td colspan="4"> <div align="center"> 
                <input name="back" onClick="history.go(-1)" type="button" class="button" value="����">
                &nbsp; </div></td>
          </tr>
       </table>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>  
  </td>
  </tr>
  </table>	
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="consume_term">
</form>
</body>

</html>
