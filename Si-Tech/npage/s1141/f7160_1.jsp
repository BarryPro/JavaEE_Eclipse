<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-09 ҳ�����,�޸���ʽ
     *
     ********************/
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
	String opCode = "7160";
	String opName = "�����ͺ���";
	    
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = request.getRemoteAddr();  
  String regionCode = orgCode.substring(0,2);

  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String passwordFromSer="";
  String[] paraAray1 = new String[3];  
  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = opcode; 	    /* ��������   */
  paraAray1[2] = loginNo;	    /* ��������   */

  for(int i=0; i<paraAray1.length; i++){		
		if( paraAray1[i] == null ){
		  paraAray1[i] = "";
		}
  }

  //retList = impl.callFXService("s7160Qry", paraAray1, "13","phone",phoneNo);
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
 %>
		<wtc:service name="s7160Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="15" >
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		</wtc:service>
		<wtc:array id="s7160QryArr" scope="end"/>
<%
	  int errCode = retCode1==""?999999:Integer.parseInt(retCode1);
	  String errMsg = retMsg1;

  	if(errCode != 0){
 %>
		<script language="JavaScript">
			<!--
	  		rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>");
	  	 	parent.removeTab("<%=opCode%>");
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
				region_name = s7160QryArr[0][7];//������
				run_name = s7160QryArr[0][8];//��ǰ״̬
				vip = s7160QryArr[0][9];//�֣ɣм���
				posint = s7160QryArr[0][10];//��ǰ����
				prepay_fee = s7160QryArr[0][11];//����Ԥ��
				passwordFromSer = s7160QryArr[0][12];//����Ԥ��
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
		  String sqlAgentCode = " select paper_code,paper_name,paper_money,sp_code,oper_code,award_code,award_detailcode,gift_code,consume_term,server_code from sPaperGiftCfg where region_code='" + regionCode + "' and valid_flag='Y' and op_code='7160'";
		  System.out.println("sqlAgentCode====="+sqlAgentCode);
%>
			<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" outnum="10">
			<wtc:sql><%=sqlAgentCode%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="agentCodeStr" scope="end" />		
<html>
<head>
<title>�����ͺ���</title>
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
  getAfterPrompt();//add by qidp
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
	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
	cust_info+="֤�����룺"+document.all.cardId_no.value+"|";


	opr_info+="ҵ�����ͣ������ͺ���"+"|";
    opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
	opr_info+="�������ͣ�"+document.all.paper_name.value+"|";
  note_info1="��ע��"+"|";
  if(document.all.consume_term.value=="4"){
   		//note_info1+="  ��δ��3����������ǰȡ���ֻ���ҵ�񣬷��ò��˲��������ڴӱ��¿�ʼ�ĵ�5���¿۳���ҵ���ں����������˶����粻ȡ�����Զ����ơ�"+"|";	
         note_info1+="  ���Ѷ����ֻ���ҵ��ҵ��24Сʱ����Ч����Ч�󣬽��������ֻ�Ԥ����ʻ��п۳�9Ԫ�ֽ�Ԥ�棬��Ϊ�ֻ���ר��ʹ�ã�ר�����֧���ֻ���ҵ��"+"|";
         note_info1+="  ��δ��3�������£�20�գ������գ�ǰ���룬���¼���Ϊ�����ã�20�պ����룬���¿�ʼ����Ϊ�����ã�����ǰȡ���ֻ���ҵ��ר����ò��˲�����"+"|";
         note_info1+=" ���ڴ����뵱�¿�ʼ�ĵ�5�����³��۳���ҵ���ں����������˶����粻ȡ�����Զ�ת�ֻ�������ҵ��"+"|";

}else{
  	  //note_info1+="��δ��6����������ǰȡ���ֻ���ҵ�񣬷��ò��˲��������ڴӱ��¿�ʼ�ĵ�8���¿۳���ҵ���ں����������˶����粻ȡ�����Զ����ơ�"+"|";	
      note_info1+="���Ѷ����ֻ���ҵ��ҵ��24Сʱ����Ч����Ч�󣬽��������ֻ�Ԥ����ʻ��п۳�18Ԫ�ֽ�Ԥ�棬��Ϊ�ֻ���ר��ʹ�ã�ר�����֧���ֻ���ҵ��"+"|";
      note_info1+="��δ��6�������£�20�գ������գ�ǰ���룬���¼���Ϊ�����ã�20�պ����룬���¿�ʼ����Ϊ�����ã���ǰȡ���ֻ���ҵ�񣬷��ò��˲�����"+"|";
      note_info1+="���ڴ����뵱�¿�ʼ�ĵ�8�����³��۳���ҵ���ں����������˶����粻ȡ�����Զ�ת�ֻ�������ҵ��"+"|";
  }
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
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
		<form name="frm" method="post" action="f7160Cfm.jsp" onKeyUp="chgFocus(frm)">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			    <div id="title_zi">�������ͣ������ͺ���-����</div>
			</div>

			<table cellspacing="0">
			    <tr>
			        <td class="blue" width="15%">�ͻ�����</td>
			        <td width="35%">
			            <input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name">
			        </td>
			        <td class="blue">֤������</td>
			        <td>
			            <input name="cardId_type" value="<%=cardId_type%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20">
			        </td>
			    </tr>
			    <tr style="display:none">
			        <td class="blue" width="15%">&nbsp;</td>
			        <td width="35%">
			            <input name="cust_addr" size="60" value="<%=bp_add%>" type="hidden" class="InputGrey" v_must=1 readonly id="cust_addr">
			        </td>
			        <td class="blue">&nbsp;</td>
			        <td>
			            <input name="cardId_no" value="<%=cardId_no%>" type="hidden" class="InputGrey" v_must=1 readonly id="cardId_no">
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
			        <td class="blue">��ע</td>
			        <td colspan="3">
			            <input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="�����ͺ���" readonly>
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
	</form>
</body>
</html>
