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

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%		
String opCode = "7047";
String opName="SIM���ظ��˻�";
    
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = request.getRemoteAddr();  
  String regionCode = orgCode.substring(0,2);

  String simNo = request.getParameter("sim_no");
  String cardNo= request.getParameter("card_no");
  String passwordFromSer="";
  String[] paraAray1 = new String[3];  
  paraAray1[0] = simNo;		/* �ֻ�����   */ 
  paraAray1[1] = opCode; 	    /* ��������   */
  paraAray1[2] = loginNo;	    /* ��������   */

  for(int i=0; i<paraAray1.length; i++){		
		if( paraAray1[i] == null ){
		  paraAray1[i] = "";
		}
  }

  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="";
  String phone_no="",imsi_no="",phoneNo="",vIdNo="";
 %>
		<wtc:service name="s7047Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="11" >
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
				region_name = s7160QryArr[0][7];//������
				phoneNo = s7160QryArr[0][8];//��ǰ״̬
				imsi_no = s7160QryArr[0][9];//�֣ɣм���
				vIdNo = s7160QryArr[0][10];
				
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
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%printAccept = sLoginAccept;%>

<html>
<head>
	<base target="_self">
<title>"<%=opName%>"</title>
<script language="JavaScript">

<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�

 
 
 

  //***
  function frmCfm(){
	 	frm.submit();
		return true;
  }
 //***IMEI ����У��
 function formatmsg()
 {
 	//alert("ssssssssss");
 	/*var str=window.showModalDialog(("trans.html","http://ip:port/testPage.jsp","newwin","dialogHeight: 200px; dialogWidth: 150px; dialogTop: 458px; dialogLeft: 166px; edge: Raised; center: Yes; help: Yes; resizable: Yes; status: Yes;");*/
 	// var path = "pubService_lcm.jsp";
   /* 
	  * diling update for �޸�Ӫҵϵͳ����Զ��д��ϵͳ�ķ��ʵ�ַ�������ڵ�10.110.0.125��ַ�޸ĳ�10.110.0.100��@2012/6/4
	  */
		path ="http://10.110.0.100:33000/rewritecard/index.jsp"
    path = path + "?OPID=" + "<%=loginNo%>";
   
    //var retInfo = window.showModalDialog(path,"","dialogWidth:50;dialogHeight:40;");
    var retInfo = window.showModalDialog("Trans.html",path,"","dialogWidth:50;dialogHeight:40;"); 
    //alert(retInfo);
    //var RESULT="";
    if(typeof(retInfo) == "undefined")     
    {	
    	rdShowMessageDialog("�ظ��˻�����!");
    	return false;   
    }
    var chPos;
    chPos = retInfo.indexOf("&");
    if(chPos < 0)
    {	
    	rdShowMessageDialog("�ظ��˻�����!");
    	return false ;	}
    //alert( retInfo.substring(0,chPos));
    retInfo=retInfo+"&";
    var retVal=new Array();   
    for(i=0;i<4;i++)
    {   	   
    	
    	var chPos = retInfo.indexOf("&");
        valueStr = retInfo.substring(0,chPos);
        var chPos1 = valueStr.indexOf("=");
        valueStr1 = valueStr.substring(chPos1+1);
        retInfo = retInfo.substring(chPos+1);
        retVal[i]=valueStr1;
        //alert(valueStr);
        //alert(retVal[i]);
    } 
    if(retVal[0]=="0")
    {
    	printCommit();
    }
    else{
    	rdShowMessageDialog("�ظ��˻�ʧ��,�������:"+retVal[0]);
    }
   
 }
 function printCommit()
 { 
  getAfterPrompt();//add by qidp
  
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
     // if(rdShowMessageDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
     // {
	    frmCfm();
      //}
	}
  }else{
    // if(rdShowMessageDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
     //{
	   frmCfm();
    // }
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
	
	cust_info+= "�ֻ����룺    "+document.all.phone_no.value+"|";
	cust_info+= "�ͻ�������    "+document.all.cust_name.value+"|";
	cust_info+= "֤�����룺    "+document.all.cardId_no.value+"|";
	cust_info+= "�ͻ���ַ��    "+document.all.cust_addr.value+"|";
	



	opr_info+="����ҵ��"+"<%=opName%>"+"|";
    opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
	  
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
   return retInfo;	
}
//-->
</script>


</head>

<body>
		<form name="frm" method="post" action="f7047Cfm.jsp" onKeyUp="chgFocus(frm)">
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
			        <td class="blue">�ֻ�����</td>
			        <td>
			            <input name="phone_no" value="<%=phoneNo%>" type="text" class="InputGrey" v_must=1 readonly id="phone_no">
			
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">SIM����</td>
			        <td>
			            <input name="sim_no" value="<%=simNo%>" type="text" class="InputGrey" v_must=1 readonly id="sim_no" maxlength="20">
			
			        </td>
			        <td class="blue">IMSI��</td>
			        <td>
			            <input name="imsi_no" value="<%=imsi_no%>" type="text" class="InputGrey" v_must=1 readonly id="imsi_no">
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">�տ����</td>
			        <td>
			            <input name="card_no" value="<%=cardNo%>" type="text" class="InputGrey" v_must=1 readonly id="card_no">
			        </td>
			        <td class="blue">�û�ID</td>
			        <td>
			            <input name="id_no" value="<%=vIdNo%>" type="text" class="InputGrey" v_must=1 readonly id="id_no">
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
			        	<input class="b_foot" name="format" type="button" index="2" value="�ظ��˻�" onClick="formatmsg()">
			            <!--<input class="b_foot" name="confirm" type="button" index="2" value="ȷ��&��ӡ" onClick="printCommit()" disabled >-->
			            <input class="b_foot" name="reset" type="reset" value="���">
			            <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
			        </td>
			    </tr>
			</table>		
       <%@ include file="/npage/include/footer.jsp" %>
		<input type="hidden" name="work_no" value="<%=loginName%>">
		<input type="hidden" name="opcode" value="<%=opCode%>">
		<input type="hidden" name="login_accept" value="<%=printAccept%>">
		<input type="hidden" name="op_name" value="<%=opName%>">
	</form>
</body>
</html>
