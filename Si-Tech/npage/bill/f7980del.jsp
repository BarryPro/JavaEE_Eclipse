<%
/********************
 version v2.0
 ������: si-tech
 ģ��: ��ͥ����ƻ����
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%
  response.setDateHeader("Expires", 0);
%>	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%              
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String iPhoneNo = request.getParameter("srv_no");
            
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  	/****��ϵͳ��ˮ****/
	String printAccept="";		
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
  	printAccept = sLoginAccept; 
  String  retFlag="",retMsg="";  
  String  bp_name="",sm_code="",rate_code="",sm_name="",bigCust_flag="",bigCust_name="";
  String  rate_name="",next_rate_code="",next_rate_name="";
  String  total_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  imain_stream="",next_main_stream="",group_type_code="",group_type_name="";
  String  card_no="",print_note="",hand_fee="",favorcode="";
  String  oSaleName="",oSaleCode="",oModeCode="";
  String  omodename="",oColorMode="",oColorName="",oNextMode="";
  String  oBeginTime="",oEndTime="",oPayMoney="";
 
  String iLoginNoAccept = request.getParameter("backaccept");
  //String iOrgCode = request.getParameter("iOrgCode");
  String iOpCode = request.getParameter("opCode");

	String  inputParsm [] = new String[5];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = iLoginNoAccept;
	System.out.println("phoneNO === "+ iPhoneNo);
	System.out.println("opCode === "+ iOpCode);
	
  //retList = co.callFXService("s7978Init", inputParsm, "39","phone",iPhoneNo);
%>
	<wtc:service name="s7978Init" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="39">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>	
	<wtc:param value="<%=inputParsm[3]%>"/>	
	<wtc:param value="<%=inputParsm[4]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr" start="0" length="36"  scope="end"/>
	<wtc:array id="result0"  start="36" length="1" scope="end"/>
<%
  String errCode = retCode1;
  String errMsg = retMsg1;
	String[][] KinNos= new String[][]{};
	//co.printRetValue();
  if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "s7978Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;  
  }
  else if(errCode.equals("000000") && tempArr.length>0)
  {
	  
	    bp_name = tempArr[0][3];           //��������
	 
	    bp_add = tempArr[0][4];            //�ͻ���ַ
	 
	    sm_code = tempArr[0][11];         //ҵ�����
	
	    sm_name = tempArr[0][12];        //ҵ���������
	  
	    rate_code = tempArr[0][5];     //�ʷѴ���
	 
	    rate_name = tempArr[0][6];    //�ʷ�����
	 
	    next_rate_code = tempArr[0][7];//�����ʷѴ���
	
	    next_rate_name = tempArr[0][8];//�����ʷ�����
	    
	    bigCust_flag = tempArr[0][9];//��ͻ���־
	 
	    bigCust_name = tempArr[0][10];//��ͻ�����
	    
	    hand_fee = tempArr[0][13];      //������
	
	    favorcode = tempArr[0][14];     //�Żݴ���
	    
	    total_prepay = tempArr[0][16];//��Ԥ��
	 
	    cardId_type = tempArr[0][17];//֤������
	  
	    cardId_no = tempArr[0][18];//֤������
	 
	    cust_id = tempArr[0][19];//�ͻ�id
	  
	    cust_belong_code = tempArr[0][20];//�ͻ�����id
	    
	    group_type_code = tempArr[0][21];//���ſͻ�����
	 
	    group_type_name = tempArr[0][22];//���ſͻ���������
	 
	    imain_stream = tempArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	 
	    next_main_stream = tempArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	 
	    oModeCode = tempArr[0][25];//���ʷѴ���
	 
	    omodename = tempArr[0][26];//���ʷ�����
	 
	    oColorMode = tempArr[0][29];//�����ʷѴ���
	  
	    oColorName = tempArr[0][30];//�����ʷ�����
	 
	    oPayMoney = tempArr[0][31];//
	
	    oBeginTime = tempArr[0][32];//��ͨʱ��
	 
	    oEndTime = tempArr[0][33];//����ʱ��
	    
		oNextMode = tempArr[0][35]; //ȡ�����ʷѴ���
	 	
	 	KinNos = result0;  //�������	  
	 } 
	else{%>
	 <script language="JavaScript">
	<!--
  	rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);
  		//window.location="f7960_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>";
  	 history.go(-1);
  	//-->
  </script>
<%	
	}
%>
<head>
<title>�������ɾ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
 
<script language="JavaScript">
    //���У��ʧ�ܣ��򷵻���һ����
	<%if(retFlag.equals("1")){%>
	 rdShowMessageDialog("<%= retMsg %>");
	 history.go(-1);
	<%}%>
<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�

  onload=function()
  {		
  }
  
  function frmCfm()
  {
 	frm.submit();
	return true;
  }
  //***
  function printfrmCfm(){
  	getAfterPrompt();
  	if(document.all.kin_nos.value.length==0)
  	{
  		rdShowConfirmDialog('��ѡ������һ��Ҫɾ����������룡');
  	}
	else
	{
	  	//alert(document.all.friend_no.value+"|"+document.all.fam_prod_id.value+"|"+document.all.pay_fee.value);
	  	setOpNote();//Ϊ��ע��ֵ
	  	document.frm.action="f7979_Cfm.jsp";
	 	 var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	    if(typeof(ret)!="undefined")
	    {
	      if((ret=="confirm"))
	      {
	        if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
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
	}    	
	return true;
  }

  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի��� 
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		
		var pType="subprint";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
		var billType="1";                                          //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
		var sysAccept=<%=printAccept%>;                            // ��ˮ��
		var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
		var mode_code=null;                                        //�ʷѴ���
		var fav_code=null;                                         //�ط�����
		var area_code=null;                                        //С������
		var opCode="<%=opCode%>";                                  //��������
		var phoneNo=document.frm.phoneNo.value;                 //�ͻ��绰
		
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.frm.phoneNo.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
  }

  function printInfo(printType)
  {
		var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//�õ�ִ��ʱ��
		
		var cust_info=""; //�ͻ���Ϣ
		var opr_info=""; //������Ϣ
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
		var retInfo = "";  //��ӡ����
		
		cust_info+="�ֻ����룺"+"<%=iPhoneNo%>"+"|";
		cust_info+="�ͻ�������"+"<%=bp_name%>"+"|";
		
		
		opr_info+="�û�Ʒ�ƣ�"+document.all.oSmName.value+"  "+"����ҵ�����������ϰ��Ŀ��������ɾ��"+"|";
		opr_info+="������ˮ��"+"<%=printAccept%>"+"|";		
		
		opr_info+="ɾ�����������Ϊ��"+document.frm.kin_nos.value+"|";
		
		opr_info+="��Чʱ�䣺 "+"����"+"|";
		note_info1+="��ע��"+"|";
		note_info1+="ÿ��ɾ��������������ֻ����4�Σ���ÿ������ɾ��4��������룻"+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
		return retInfo;
  } 
 function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "����Ա��<%=loginNo%>������������ɾ������"; 
	}
	return true;
}

/**��ѡ��ȫ��ѡ��**/
function doSelectAllNodes(){
	document.all.confirm.disabled=false;
	var regionChecks = document.getElementsByName("regionCheck");
	for(var i=0;i<regionChecks.length;i++){
		regionChecks[i].checked=true;
	}
	doChange();	
}

/**ȡ����ѡ��ȫ��ѡ��**/
function doCancelChooseAll(){
	document.all.confirm.disabled=true;
	var regionChecks = document.getElementsByName("regionCheck");
	for(var i=0;i<regionChecks.length;i++){
		regionChecks[i].checked=false;
	}
	doChange();				
}
function doChange()
{				
	document.all.confirm.disabled=false;
	var regionChecks = document.getElementsByName("regionCheck");
	var impCodeStr = "";
	var regionLength=0;
	for(var i=0;i<regionChecks.length;i++){		
		if(regionChecks[i].checked){
		var impValue = regionChecks[i].value;
			var impArr = impValue.split("|");
			if(regionLength==0){
				impCodeStr = impArr[0];			
			}else{
				impCodeStr += (","+impArr[0]);									
			}
			regionLength++;
		}						
	}	
	document.all.kin_nos.value=impCodeStr;
	if(document.all.kin_nos.value.length==0)
	{
		document.all.confirm.disabled=true;
	}	
}

//-->
</script>

</head>


<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">�û���Ϣ</div>
		</div>

      <table cellspacing="0">
          <tr>
			<td align="center" width="15%" class="blue">�ֻ�����</td>
            <td>
				<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" value="<%=iPhoneNo%>" readonly >
			</td> 
			<td align="center" width="15%" class="blue">��������</td>
			<td>
				<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>                    
			</td>           
		</tr>
		<tr> 
			<td align="center" width="15%" class="blue">ҵ��Ʒ��</td>
            <td>
				<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
			</td>
            <td align="center" width="15%" class="blue">�ʷ�����</td>
            <td>
				<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
			</td>            
		</tr>
		</table>
		</div>
<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">ҵ����ϸ</div>
</div>
		<TABLE cellSpacing="0">
          <TBODY> 
		  <tr>	
			<td align="center" width="15%" class="blue">
				���ʷѴ���
			</td>
            <td>
				<input name="Mode_Code" type="text" class="InputGrey" id="Mode_Code" readonly value="<%=oModeCode%>">
			</td>  
			<td align="center" width="15%" class="blue">
				���ʷ�����
			</td>
			<td>
				<input name="Mode_Name" type="text" class="InputGrey" id="Mode_Name" readonly value="<%=omodename%>">
		</tr>	
		<tr> 
     	 <td align="center" width="15%" class="blue">
       		 ������ʷѴ���
      	</td>
      		<td>
				<input name="kin_mode" type="text" class="InputGrey" id="kin_mode"  value="<%=oColorMode%>" readonly>
			</td>
			<td align="center" width="15%" class="blue">
			������ʷ�����
			</td>
            <td>
				<input name="kin_name" type="text" class="InputGrey" id="kin_name"  value="<%=oColorName%>" readonly>
			</td>             
		</tr>
		<tr>	
            <td align="center" width="15%" class="blue">
            	ҵ��ͨ����
            </td>
            <td>
            	<input type="text" name="Begin_Time" id="Begin_Time" value="<%=oBeginTime%>" readonly class="InputGrey">
			</td>            
            <td align="center" width="15%" class="blue">
            	ҵ��������
            </td>
            <td>
				<input name="End_Time" type="text" class="InputGrey" id="End_Time" value="<%=oEndTime%>" readonly>
			</td>
		</tr>	
		</table>
	</div>
<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">���������Ϣ</div>
</div>
		<TABLE cellSpacing="0">
          <TBODY> 
          	<tr> 
          	<td align="center" width="15%" class="blue">�����������</td>
          	<td width="85%" align=left class="InputGrey">	
			<% 
			 for(int j=0;j<KinNos.length;j++){        	
			%>			
				<input type="checkbox" name="regionCheck" id="regionCheck" value="<%=KinNos[j][0]%>" onclick="doChange()">&nbsp;
				<%=KinNos[j][0]%>&nbsp;&nbsp;										
			<%	
			 	if(j > 4)
			 	{
			 		%> <br> <%
			 	}
			 }
			%>
		</td>
			</tr>
		</table>
	
		<TABLE cellSpacing="0">
          <tr>
			<td colspan=4>
				<input type="hidden" name="kin_nos" id="kin_nos">
			</td>
			</tr>	
		  <tr> 
            <td id="footer" colspan="4"> <div align="center"> 
            	 &nbsp; 
            	 <input type="button" name="allchoose"  class="b_foot" value="ȫ��ѡ��" style="cursor:hand;" onclick="doSelectAllNodes()" >&nbsp;
	       		<input type="button" name="cancelAll" class="b_foot" value="ȡ��ȫѡ" style="cursor:hand;" onClick="doCancelChooseAll()" >&nbsp;	
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="ȷ��" onClick="printfrmCfm(this)" disabled>
                 &nbsp;
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
                &nbsp; 				
				</div>
			</td>
          </tr>
       </table>
 <input type="hidden" name="bp_addr" id="bp_addr" value="<%=bp_add%>"> <!--�ͻ���ַ-->
 <input name="cardId_no" type="hidden" id="cardId_no" value="<%=cardId_no%>"> <!--֤������-->
  <input type="hidden" name="phoneNoForPrt" ><!--Ҫȡ�����ֻ�����,���ڴ�ӡ-->
  <input type="hidden" name="cardTypeForPrt" ><!--Ҫȡ���Ŀ�����,���ڴ�ӡ-->
   <input type="hidden" name="stream" value="<%=printAccept%>"><!--��ӡ��ˮ-->
   <input name="Next_Mode" type="hidden" id="Next_Mode" value="<%=oNextMode%>" ><!--���ں��ʷ�-->
  <input type="hidden" name="phoneNo" value="<%=iPhoneNo%>">
  <input type="hidden" name="op_code" value="<%=opCode%>">
  <input type="hidden" name="opName" value="<%=opName%>">
   <input type="hidden" name="regionCode" value="<%=regionCode%>">
  <input name="opNote" type="hidden" id="opNote" value="" onFocus="setOpNote();" > 
  <input type="hidden" name="return_page" value="/npage/bill/f7977Login.jsp?activePhone=<%=iPhoneNo%>&opName=<%=opName%>&opCode=<%=opCode%>">
   <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>



