<%
  /*
   * ����: ���߼��Ӫ������� d259
   * �汾: 1.8.2
   * ����: 2011/3/10
   * ����: huangrong
   * ��Ȩ: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>
<%		
String opCode = request.getParameter("opcode");
System.out.println("opCodeopCode="+opCode);
String opName="���߼��Ӫ�������";
	    
String loginNo = (String)session.getAttribute("workNo");
String loginName = (String)session.getAttribute("workName");
String orgCode = (String)session.getAttribute("orgCode");
String ip_Addr = request.getRemoteAddr();  
String regionCode = orgCode.substring(0,2);
String phoneNo = request.getParameter("srv_no");
String passwordFromSer="";
String oldLoginAccept=request.getParameter("backaccept");
String sql1 = " select to_char(count(*)) from shighlogin where login_no=:loginNo1 and op_code=:opCode2 ";
String [] paraIn = new String[2];
paraIn[0] = sql1;    
paraIn[1]="loginNo1="+loginNo+",opCode2="+opCode;
  %>
<wtc:service name="TlsPubSelCrm" routerKey="login_no" routerValue="<%=loginNo%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
<wtc:param value="<%=paraIn[0]%>"/>
  <wtc:param value="<%=paraIn[1]%>"/> 
</wtc:service>
<wtc:array id="logincount" scope="end" />
	<%
if(logincount[0][0].equals("0")){
	System.out.println("dddddddddddddddddddddd");
%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("�˹���û��Ȩ��");
  	history.go(-1);
  	//-->
</script>
<%}%>
  <%
  String[] paraAray1 = new String[8];  
  paraAray1[0] = "";	    /* ������ˮ   */
  paraAray1[1] = "01";	    /* ��������   */  
  paraAray1[2] = opCode; 	    /* ��������   */
  paraAray1[3] = loginNo;	    /* ��������   */  
  paraAray1[4] = loginNo;	    /* ��������   */  
  paraAray1[5] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[6] = "";		/* �û�����   */ 
  paraAray1[7] = oldLoginAccept;	    /* ����ˮ ������ˮ   */
  for(int i=0; i<paraAray1.length; i++){		
		if( paraAray1[i] == null ){
		  paraAray1[i] = "";
		}
  }
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",run_name="",vip="",prepay_fee="",paper_money="",paper_code="";
 %>
		<wtc:service name="sd259Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="12" >
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=paraAray1[3]%>"/>
		<wtc:param value="<%=paraAray1[4]%>"/>
		<wtc:param value="<%=paraAray1[5]%>"/>
		<wtc:param value="<%=paraAray1[6]%>"/>
		<wtc:param value="<%=paraAray1[7]%>"/>			
		</wtc:service>
		<wtc:array id="d259QryArr" scope="end"/>
<%
	  String errCode = retCode1;
	  String errMsg = retMsg1;
	  System.out.println("-----------------errCode-------------------------"+errCode);
  	if(!errCode.equals("000000")){
 %>
		<script language="JavaScript">
			<!--
	  		rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>");
	  	 	history.go(-1);
	  	//-->
	  </script>
  <%
  		return;
  	}
  	if(d259QryArr!=null&&d259QryArr.length>0){
				bp_name = d259QryArr[0][0];//��������
				bp_add = d259QryArr[0][1];//�ͻ���ַ
				cardId_type = d259QryArr[0][2];//֤������
				cardId_no = d259QryArr[0][3];//֤������
				sm_code = d259QryArr[0][4];//ҵ��Ʒ��
				run_name = d259QryArr[0][5];//��ǰ״̬
				vip = d259QryArr[0][6];//�֣ɣм���
				prepay_fee = d259QryArr[0][7];//����Ԥ��
				paper_money = d259QryArr[0][8];//ҵ����
				paper_code= d259QryArr[0][9];//ҵ������
				System.out.println("--------------------paper_money----------------"+paper_money);
					System.out.println("--------------------paper_code----------------"+paper_code);			
  	}else{
 	%>
				<script language="JavaScript">
					<!--
			  		rdShowMessageDialog("s7160Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg);
			  	 	parent.removeTab("<%=opCode%>");
			  	//-->
			  </script>
<%    		
  	}

			String printAccept="";
%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone"  routerValue="<%=phoneNo%>" id="sLoginAccept"/>
<%
			printAccept = sLoginAccept;
%>
			
<html>
<head>
<title>"<%=opName%>"</title>
<script language="JavaScript">

<!--
  //����Ӧ��ȫ�ֵı���
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

  //***
  function frmCfm(){
	 	frm.submit();
		return true;
  }
 //***IMEI ����У��
 
 function printCommit()
 { 
  getAfterPrompt();
  with(document.frm){
    if(cust_name.value==""){
	  	rdShowMessageDialog("����������!");
      cust_name.focus();
	  	return false;
		}
		if(paper_code.value==""){
		  	rdShowMessageDialog("��ѡ��ҵ������!");
	      paper_code.focus();
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
  }else{
     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
     {
	   frmCfm();
     }
  }
  return true;
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";   
	var billType="1";  
	var sysAccept = document.all.login_accept.value;   
	var printStr = printInfo(printType);
	var mode_code=null;
	var fav_code=null;
	var area_code=null;   
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;    
}

function printInfo(printType)
{
	var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="֤�����룺"+document.all.cardId_no.value+"|";

	opr_info+="����ҵ��"+"<%=opName%>"+"|";
  opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
	opr_info+="�ͻ�Ԥ��"+document.all.paper_money.value+"|";
	opr_info+="������Ʒ�����߼���豸"+"|";
	opr_info+="����ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd ", Locale.getDefault()).format(new java.util.Date())%>'+"|";
  note_info1="��ע��"+document.all.opNote.value+"|";
  
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;	
}
//-->
</script>

</head>
<body>
		<form name="frm" method="post" action="fd259Cfm.jsp" onKeyUp="chgFocus(frm)">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			    <div id="title_zi">�������ͣ�<%=opName%> </div>
			</div>

			<table cellspacing="0">
			    <tr>
			        <td class="blue" width="15%">�ͻ�����</td>
			        <td width="35%">
			            <input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name">
			        </td>
			        <td class="blue" width="15%">�ͻ���ַ</td>
			        <td width="35%">
			            <input name="cust_addr" size="60" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr">
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">֤������</td>
			        <td>
			            <input name="cardId_type" value="<%=cardId_type%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20">
			        </td>
			        <td class="blue">֤������</td>
			        <td>
			            <input name="cardId_no" value="<%=cardId_no%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_no">
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">ҵ��Ʒ��</td>
			        <td>
			            <input name="sm_code" value="<%=sm_code%>" type="text" class="InputGrey" v_must=1 readonly id="sm_code">
			
			        </td>
			        <td class="blue">����״̬</td>
			        <td>
			            <input name="run_type" value="<%=run_name%>" type="text" class="InputGrey" v_must=1 readonly id="run_type">
			
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">VIP����</td>
			        <td>
			            <input name="vip" value="<%=vip%>" type="text" class="InputGrey" v_must=1 readonly id="vip" maxlength="20">
			
			        </td>
			        <td class="blue">����Ԥ��</td>
			        <td>
			            <input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee">
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">ҵ������</td>
			        <td>
			            <input name="prepay_code" value="<%=paper_code%>" type="text" class="InputGrey" v_must=1 readonly id="paper_code">
			        </td>
			        <td class="blue">ҵ����</td>
			        <td>
			            <input name="paper_money" value="<%=paper_money%>"  type="text" class="InputGrey" id="paper_money" v_type="money" v_must=1 readonly>
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">��ע</td>
			        <td colspan="3">
			            <input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="<%=opName%>" readonly >
			        </td>
			    </tr>
			    <tr>
			        <td colspan="4" id="footer">
			            <input class="b_foot" name="confirm" type="button" index="2" value="ȷ��&��ӡ" onClick="printCommit()">
			            <input class="b_foot" name="reset" type="reset" value="���">
			            <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
			        </td>
			    </tr>
			</table>		
       <%@ include file="/npage/include/footer.jsp" %>
		<input type="hidden" name="phone_no" value="<%=phoneNo%>">
		<input type="hidden" name="work_no" value="<%=loginName%>">
		<input type="hidden" name="opcode" value="<%=opCode%>">
		<input type="hidden" name="login_accept" value="<%=printAccept%>">
		<input type="hidden" name="op_name" value="<%=opName%>">
		<input type="hidden" name="old_accept" value="<%=oldLoginAccept%>">
	</form>
</body>
</html>

