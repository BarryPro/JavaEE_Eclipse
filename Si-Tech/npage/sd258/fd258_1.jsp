<%
  /*
   * ����: ���߼���豸Ӫ������� d258
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
String opName="";
opName = "���߼��Ӫ�������";
String loginPwd    = (String)session.getAttribute("password");	    
String loginNo = (String)session.getAttribute("workNo");
String loginName = (String)session.getAttribute("workName");
String orgCode = (String)session.getAttribute("orgCode");
String ip_Addr = request.getRemoteAddr();  
String regionCode = orgCode.substring(0,2);
System.out.println("---------------orgCode---------------------"+opCode);
System.out.println("---------------loginNo---------------------"+loginNo);
String phoneNo = request.getParameter("srv_no");
String passwordFromSer="";
String sql1 = " select to_char(count(*)) from shighlogin where login_no=:loginNo1 and op_code=:opCode2";
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
System.out.println("---------------logincount---------------------"+logincount[0][0]);
if(logincount[0][0].equals("0")){
%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("�˹���û��Ȩ��");
  	history.go(-1);
//-->
</script>
<%}%>
<%
String[] paraAray1 = new String[4];  
paraAray1[0] = phoneNo;		  /* �ֻ�����   */ 
paraAray1[1] = opCode; 	    /* ��������   */
paraAray1[2] = loginNo;	    /* ��������   */
paraAray1[3] = "0";	        /*  saleType  */

for(int i=0; i<paraAray1.length; i++){		
	if( paraAray1[i] == null ){
	  paraAray1[i] = "";
	}
}

String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",run_name="",vip="",prepay_fee="";
System.out.println("----------------------------begin----------------------------------------");
%>
		<wtc:service name="s1145Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="22" >
		<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginPwd%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=" "/>
		<wtc:param value="0"/>
		</wtc:service>
		<wtc:array id="s7160QryArr" scope="end"/>
<%
    System.out.println("----------------------------end----------------------------------------");
	  String errCode = retCode1;
	  String errMsg = retMsg1;

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
  	
  	if(s7160QryArr!=null&&s7160QryArr.length>0){
				bp_name = s7160QryArr[0][2];//��������
				bp_add = s7160QryArr[0][3];//�ͻ���ַ
				cardId_type = s7160QryArr[0][4];//֤������
				cardId_no = s7160QryArr[0][5];//֤������
				sm_code = s7160QryArr[0][6];//ҵ��Ʒ��
				run_name = s7160QryArr[0][8];//��ǰ״̬
				vip = s7160QryArr[0][9];//�֣ɣм���
				prepay_fee = s7160QryArr[0][11];//����Ԥ��
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
		  String sqlAgentCode = " select paper_code,paper_name,paper_money,award_code,award_detailcode,gift_code,to_char(consume_term) from sPaperGiftCfg where region_code=:regionCode1 and valid_flag='Y' and op_code=:opCode1";
		  System.out.println("sqlAgentCode====="+sqlAgentCode);
		   System.out.println("regionCode1====="+regionCode);
		   System.out.println("opCode1====="+opCode);
			paraIn[0] = sqlAgentCode;    
			paraIn[1]="regionCode1="+regionCode+",opCode1="+opCode;
%>
			<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" outnum="7">
				<wtc:param value="<%=paraIn[0]%>"/>
        		<wtc:param value="<%=paraIn[1]%>"/>
        	</wtc:service>
			<wtc:array id="agentCodeStr" scope="end" />		
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
 
<%  
System.out.println("----------------------------------------agentCodeStr.lengthagentCodeStr.length="+agentCodeStr.length);
  for(int i=0;i<agentCodeStr.length;i++)
  {
	out.println("arrpapercode["+i+"]='"+agentCodeStr[i][0]+"';\n");
	out.println("arrpapername["+i+"]='"+agentCodeStr[i][1]+"';\n");
	out.println("arrpapermoney["+i+"]='"+agentCodeStr[i][2]+"';\n");
	out.println("arrawardcode["+i+"]='"+agentCodeStr[i][3]+"';\n");
	out.println("arrawarddetailcode["+i+"]='"+agentCodeStr[i][4]+"';\n");
	out.println("arrgiftcode["+i+"]='"+agentCodeStr[i][5]+"';\n");
	out.println("arrconsumeterm["+i+"]='"+agentCodeStr[i][6]+"';\n");
	System.out.println("agentCodeStr[i][5]="+agentCodeStr[i][5]);
	System.out.println("agentCodeStr[i][6]="+agentCodeStr[i][6]);
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
  note_info1="��ע����ӭ���μ��й��ƶ���չ�ġ����߼��Ӫ���������л�����й��ƶ���֧�֡�"+"|";
  note_info1+="����Ԥ���"+document.all.paper_money.value+"Ԫ������ר���ʻ�����������Ϊ"+document.all.consume_term.value+"���£�ÿ�����ѵ���Ϊ"+document.all.small_free.value+"Ԫ��ר��˲�ת����"+document.all.consume_term.value+"������δ�����꣬ʣ��Ԥ��ͳһ�ջأ�����Ϥ֪��"+"|";
  
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
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
	  				document.all.award_code.value=arrawardcode[x1] ;
	  				document.all.award_detailcode.value=arrawarddetailcode[x1] ;
	  				document.all.gift_code.value=arrgiftcode[x1] ;
	  				document.all.consume_term.value=arrconsumeterm[x1] ;
	  				document.all.small_free.value=Number(arrpapermoney[x1])/Number(arrconsumeterm[x1])
	  				document.all.paper_name.value=arrpapername[x1] ;
			}
 	}
 	getComp();
 } 
 
 function getComp()
 {
	 	var myPacket = new AJAXPacket("getComp.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
		myPacket.data.add("retType","getProjectType");
		myPacket.data.add("login_accept",(document.frm.login_accept.value).trim());
		myPacket.data.add("opcode",(document.frm.opcode.value).trim());
		myPacket.data.add("phone_no",(document.frm.phone_no.value).trim());
		myPacket.data.add("paper_code",(document.frm.paper_code.value).trim());
		myPacket.data.add("award_code",(document.frm.award_code.value).trim());
		myPacket.data.add("award_detailcode",(document.frm.award_detailcode.value).trim());
		myPacket.data.add("gift_code",(document.frm.gift_code.value).trim());
		myPacket.data.add("paper_money",(document.frm.paper_money.value).trim());
		myPacket.data.add("consume_term",(document.frm.consume_term.value).trim());
		myPacket.data.add("opNote",(document.frm.opNote.value).trim());
		myPacket.data.add("gift_name",(document.frm.gift_name.value).trim());
		core.ajax.sendPacket(myPacket);
		myPacket=null;
 }
 //------------------------------------------------------------------------
  function doProcess(packet){
 		var retCode = packet.data.findValueByName("retCode");
		var retMsg =  packet.data.findValueByName("retMsg");
		if(retCode!="000000") 
		{
				rdShowMessageDialog("ȡ��Ϣ����:"+retMsg);
				document.frm.confirm.disabled=true;
				return;
		}else{
				document.frm.confirm.disabled=false;
		}
 }
//-->
</script>
</head>

<body>
		<form name="frm" method="post" action="fd258Cfm.jsp" onKeyUp="chgFocus(frm)">
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
			            <SELECT id="paper_code" name="paper_code" v_must=1 onchange="selectChange();">
			                <option value="">--��ѡ��--</option>
			                <%for (int i = 0; i < agentCodeStr.length; i++) {%>
			                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%>
			                </option>
			                <%}%>
			            </select>
			        </td>
			        <td class="blue">ҵ����</td>
			        <td>
			            <input name="paper_money" type="text" class="InputGrey" id="paper_money" v_type="money" v_must=1 readonly>
			        </td>
			    </tr>
			    <tr>
			    		<td class="blue">������Ʒ</td>
			        <td>
			            <input name="gift_name" type="text" id="gift_name"class="InputGrey" value="���߼���豸" readonly >
			        </td>
			        <td class="blue">��ע</td>
			        <td>
			            <input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="���߼��Ӫ�����ר��˲�ת" readonly >
			        </td>
			    </tr>
			    <tr>
			        <td colspan="4" id="footer">
			            <input class="b_foot" name="confirm" type="button" index="2" value="ȷ��&��ӡ" onClick="printCommit()" disabled>
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
		<input type="hidden" name="sp_code" value="" >
		<input type="hidden" name="oper_code" value="" >
		<input type="hidden" name="award_code" value="" >  
		<input type="hidden" name="award_detailcode" value="" > 
		<input type="hidden" name="gift_code" value="" >
		<input type="hidden" name="server_code" value="" >
		<input type="hidden" name="consume_term" value="">
		<input type="hidden" name="paper_name" value="">
		<input type="hidden" name="op_name" value="<%=opName%>">
		<input type="hidden" name="small_free">		<!--��������ֵ-->
		
		
	</form>
</body>
</html>

