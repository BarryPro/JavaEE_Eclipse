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
  
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String loginPwd    = (String)session.getAttribute("password");
  String regionCode = orgCode.substring(0,2);
  
  String opname="���ļ�ͥ��Ʒ����";
  String opcode="7333";
%>
<%
  String retFlag="",retMsg="";//����Ƿ�У��ʧ�ܵı�־����Ϣ
/****************���ƶ�����õ����롢������������ܰ��ͥ�������Ϣ s1251Init***********************/
  String[] paraAray1 = new String[4];
  String main_card = request.getParameter("chief_srv_no");
  String op_code = request.getParameter("opCode");
  String openType = request.getParameter("open_type");/* ��������*/
  String passwordFromSer="";
  
  paraAray1[0] = main_card;		/* �ֻ�����   */ 
  paraAray1[1] = loginNo; 	/* ��������   */
  paraAray1[2] = orgCode;	/* ��������   */
  paraAray1[3] = op_code;	/* ��������   */
 
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s7328Qry", paraAray1, "37", "phone",main_card);
%>
	<wtc:service name="s7328Qry" routerKey="phone" routerValue="<%=main_card%>" retcode="retCode1" retmsg="retMsg1" outnum="39">			

		<wtc:param value="0"/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=paraAray1[3]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=loginPwd%>"/>									
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value=""/>	
		<wtc:param value="<%=paraAray1[2]%>"/>
	</wtc:service>	
	<wtc:array id="result1"  start="0" length="25" scope="end"/>
	<wtc:array id="result0"  start="26" length="1" scope="end"/>
	<wtc:array id="result9"  start="27" length="1" scope="end"/>
	<wtc:array id="result10" start="28" length="1" scope="end"/>
	<wtc:array id="result2"  start="29" length="1" scope="end"/>
	<wtc:array id="result3"  start="30" length="1" scope="end"/>
	<wtc:array id="result4"  start="31" length="1" scope="end"/>
	<wtc:array id="result5"  start="32" length="1" scope="end"/>
	<wtc:array id="result6"  start="33" length="1" scope="end"/>
	<wtc:array id="result7"  start="34" length="1" scope="end"/>
	<wtc:array id="result8"  start="35" length="1" scope="end"/>
	<wtc:array id="result11"  start="36" length="1" scope="end"/>	
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",op_type="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",prodId="",prodNote="";
  String otherCardFlag = "",mainDisabledFlag="",print_note="",bp_add="",cardId_no="",prod_name="";
  String[][] tempArr= new String[][]{};
  String[][] familyCodeArr= new String[][]{};
  String[][] otherCodeArr= new String[][]{};
  String[][] cardTypeArr= new String[][]{};
  String[][] beginTimeArr= new String[][]{};
  String[][] endTimeArr= new String[][]{};
  String[][] opTimeArr= new String[][]{};
  String[][] newRateCodeArr= new String[][]{};
  String[][] FamilyProdArr= new String[][]{};
  String[][] FamilyNoteArr= new String[][]{};
  String[][] ParentProdArr= new String[][]{};
  String[][] FriendNoArr= new String[][]{};
  String errCode = retCode1;
  String errMsg = retMsg1;
  tempArr = result1;
  System.out.println("errCode======"+errCode);
  if(result1.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag="1";
	   retMsg="s7328Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg ;
    }  
  }else if(errCode.equals("000000") && result1.length>0)
  {
	
	    bp_name = tempArr[0][3];//��������
	    
	    bp_add = tempArr[0][4];//�ͻ���ַ
	  
	    passwordFromSer = tempArr[0][2];//����
	 
	    sm_code = tempArr[0][11];//ҵ�����
	 
	    sm_name = tempArr[0][12];//ҵ���������
	 
	    rate_code = tempArr[0][5];//�ʷѴ���
	 
	    rate_name = tempArr[0][6];//�ʷ�����
	 
	    next_rate_code = tempArr[0][7];//�����ʷѴ���
	 
	    next_rate_name = tempArr[0][8];//�����ʷ�����
	
	    bigCust_flag = tempArr[0][9];//��ͻ���־
	 
	    bigCust_name = tempArr[0][10];//��ͻ�����
	
	    lack_fee = tempArr[0][15];//��Ƿ��
	 
	    prepay_fee = tempArr[0][16];//��Ԥ��
	    
	     cardId_no = tempArr[0][19];//֤������
	    
	  FamilyProdArr = result0;  //��Ʒ����
	  FamilyNoteArr = result9;	//��Ʒ����
	  ParentProdArr = result10;	//��Ʒ��־��'0'������ͥ����Ʒ�����඼�Ǹ��Ӳ�Ʒ��
	  familyCodeArr = result2;//��ͥ���� 
	  FriendNoArr = result11; //��ͥ��������������
	  if(result2.length!=0)
	  {
	  	family_code = familyCodeArr[0][0].substring(4,10);
	  }
	  otherCodeArr = result3;//��������--��Ա����
      cardTypeArr = result4;//������--����ʱ��
      beginTimeArr = result5;//��ʼʱ��--������
      endTimeArr = result6;//����ʱ��--������ˮ
      opTimeArr = result7;//����ʱ��--����
	  newRateCodeArr = result8;//��ܰ��ͥ�ʷѴ���--����
	  //�ж��Ƿ���������¼
	  if(familyCodeArr==null || familyCodeArr.length==0 || familyCodeArr[0][0].equals("")){
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="�ú���û�ж�Ӧ��������Ϣ!";
        }  
	  }else if(familyCodeArr.length>1){
	    otherCardFlag = "1";//�ж��Ƿ���ڸ���
	  }
	}else{
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="s7328Qry��ѯ���������Ϣʧ��!"+errMsg;
        }
	}
	

  //******************�õ�����������***************************//
 String sqlRateCode = "";
    //�ʷ���Ϣ
   
	sqlRateCode = "select a.mode_code,a.mode_code||'--'||a.mode_name from sbillmodecode a,sFamModeCode b  where a.region_code=b.region_code and a.mode_code=b.mode_code and b.region_code='"+regionCode +"'" ;
	System.out.println("sqlRateCode="+sqlRateCode);
	String[] paramIn = new String[2];
	paramIn[0] = "select a.mode_code,a.mode_code||'--'||a.mode_name from sbillmodecode a,sFamModeCode b  where a.region_code=b.region_code and a.mode_code=b.mode_code and b.region_code=:regionCode";
	paramIn[1] = "regionCode="+regionCode;
	//ArrayList rateCodeArr = co.spubqry32("2",sqlRateCode);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">			
	<wtc:param value="<%=paramIn[0]%>"/>	
	<wtc:param value="<%=paramIn[1]%>"/>	
	</wtc:service>	
	<wtc:array id="rateCodeStr"  scope="end"/>
<%

	System.out.println("retCode2==="+retCode2);
	System.out.println("rateCodeStr"+rateCodeStr.length);
	String op_note="";
	op_note="���������";	
  	String printAccept="";
  	printAccept = getMaxAccept();
%>
<head>
<title>���ļ�ͥ��Ϣ��ѯ</title>
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

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";
 
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
  	if(document.all.friend_no.value=="")
  	{
  		rdShowConfirmDialog('��ѡ��Ҫ����ļ�ͥ�������!�����ѡ��ť����ѡ��!');
  	}
  	else if(document.all.friend_no.value=="0") 
  	{
  		rdShowConfirmDialog('����Ʒû������ţ���ѡ�����¸��Ӳ�Ʒ��');
  	}	
  	else if(document.all.new_friend_no.value=="")
  	{
  		rdShowConfirmDialog('���������������!')
  		document.all.new_friend_no.focus();	
  	}
  	else if(document.all.new_friend_no.length <	11)
  	{
  		rdShowConfirmDialog('�����������������������������!')
  		document.all.new_friend_no.focus();	
  	}  	
	else
	{
	  	//alert(document.all.friend_no.value+"|"+document.all.fam_prod_id.value+"|"+document.all.pay_fee.value);
	  	setOpNote();//Ϊ��ע��ֵ
	  	document.frm.action="f7333Cfm.jsp";
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
		var opCode="<%=op_code%>";                                  //��������
		var phoneNo=document.frm.main_card.value;                 //�ͻ��绰
		
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.frm.main_card.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
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
		
		cust_info+="�ֻ����룺"+"<%=main_card%>"+"|";
		cust_info+="�ͻ�������"+"<%=bp_name%>"+"|";
		
		
		opr_info+="�û�Ʒ�ƣ�"+document.all.sm_name.value+"  "+"����ҵ�񣺳��ļ�ͥ��Ʒ����֮<%=op_note%>"+"|";
		opr_info+="������ˮ��"+"<%=printAccept%>"+"|";		
		
		opr_info+="���ǰ�ĺ���Ϊ��  "+document.frm.friend_no.value+"|";
		opr_info+="����ɵĺ���Ϊ��  "+document.frm.new_friend_no.value+"|";
		opr_info+="��������ѣ�  "+document.frm.pay_fee.value+" Ԫ"+"|";
		opr_info+="��Чʱ�䣺 "+"����"+"|";
		note_info1+="��ע��"+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
		return retInfo;
  } 
 function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "��ͥ��Ʒ����--<%=op_note%> �ҳ�����:"+document.frm.main_card.value; 
	}
	return true;
}
function f7328Init(obj){
	document.frm.fam_prod_id.value = obj.FamilyProd.trim();
	document.frm.friend_no.value = obj.FriendNo.trim();
	if(document.frm.friend_no.value=="0")
	{
		document.all.new_friend_no.disabled=true;
		document.all.new_friend_no_id.disabled=true;
		document.all.pay_fee_id.disabled=true;
		document.all.pay_fee.disabled=true;
		document.all.new_friend_no.value="";
	}
	else
	{
		document.all.new_friend_no_id.disabled=false;
		document.all.new_friend_no.disabled=false;
		document.all.pay_fee_id.disabled=false;
		document.all.pay_fee.disabled=false;
	}		
}

//-->
</script>

</head>


<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
		  <tr> 
            <td class="blue">��������</td>
            <td colspan="3">���������</td>
            <input name="op_type" type="hidden" class="InputGrey" id="op_type" value="<%=openType%>" >
          </tr>
          <tr> 
		    <td class="blue">�ֻ�����</td>
            <td>
			  <input name="main_card" type="text" class="InputGrey" id="main_card" value="<%=main_card%>" readonly >
			</td>
            <td class="blue">ҵ������</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_name%>" readonly>
			</td>
          </tr>
          <tr> 
            <td class="blue">��ǰ���ײ�</td>
            <td>
			  <input name="rate_name" type="text" class="InputGrey" id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td class="blue">�������ײ�</td>
            <td>
			  <input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" size="30"  value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
			</td>             
          </tr>
		  <tr>
		    <td class="blue">��������</td>
            <td>
			  <input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>
			</td>
            <td class="blue">��ͻ���־</td>
            <td>
			<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
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
			<tr>
		      <th align=center>��ͥ����</th>
			  <th align=center>��ͥ���</th>
			  <th align=center>�ֻ�����</th>
			  <th align=center>��ʼʱ��</th>
			  <th align=center>��������</th>
			  <th align=center>������ˮ</th>
			</tr>
			<% 
			 for(int j=0;j<otherCodeArr.length;j++){
			 	String tdClass = (j%2==0)?"Grey":"";
                if(cardTypeArr[j][0].equals("0") && otherCardFlag.equals("1")){
				  mainDisabledFlag = "disabled";
				}else{
				  mainDisabledFlag = "";
				}
			%>
		    <tr> 
			  <TD align=center class="<%=tdClass%>"><%=familyCodeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=newRateCodeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=otherCodeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=cardTypeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=beginTimeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=endTimeArr[j][0]%></TD>
			</tr>				
			<%
			 }
			%>
		</table>
	</div>
<div id="Operation_Table"> 
	<div class="title">
	<div id="title_zi">��ǰ��ͥ��Ʒ��Ϣ</div>
	</div>
	    <TABLE  cellSpacing="0">
          <TBODY> 
          <tr>
			<tr align="middle" >
				<th align=center>ѡ��</th>
		      <th align=center>��ͥ��Ʒ����</th>
			  <th align=center>��Ʒ��ϸ</th>
			  <th align=center>�������</th>
			</tr> 
			<% 
				 for(int i=0;i<FamilyProdArr.length;i++){
				 	String TdClass = (i%2==0)?"Grey":"";		 	
			%>
			<tr>
				<td class="Grey" align=center>
		      		<input type="radio" name="radio" class="button" FamilyProd="<%=FamilyProdArr[i][0]%>" FamilyNote="<%=FamilyNoteArr[i][0]%>" FriendNo="<%=FriendNoArr[i][0]%>" onclick="f7328Init(this)">	</td>
				<TD align=center class="<%=TdClass%>"><%=FamilyProdArr[i][0]%></TD>
			   	<TD align=center class="<%=TdClass%>"><%=FamilyNoteArr[i][0]%></TD>			   	
			   	<TD align=center class="<%=TdClass%>"><%=FriendNoArr[i][0]%></TD>
			</tr>
			<%}%>
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
			<td class="blue" align=center>
				ԭ�������
			</td>
            <td>
				<input name="friend_no" type="text" class="InputGrey" id="friend_no"  maxlength=8 readonly>
			</td>
			<td class="blue" align=center id="new_friend_no_id" disabled >���������</td>  	
			<td>	
				<input name="new_friend_no" type="text" class="button" id="new_friend_no" maxlength=11 size="12" v_type="0_9" v_must=1 v_minlength=1 v_maxlength=12 disabled>    
        	</td> 
        </tr>
        <tr>
        	<td class="blue" align=center id="pay_fee_id" disabled>���������</td>  
        	<td colspan=4>	
				<input name="pay_fee" type="text" class="button" id="pay_fee" maxlength=6 size="6" v_type="0_9" v_must=1 v_minlength=1 v_maxlength=12 value="0.00" disabled>    
        	</td> 
        </tr>
		  <tr> 
            <td id="footer" colspan="4"> <div align="center"> 
            	 &nbsp; 
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="ȷ��" onClick="printfrmCfm(this)" >
                 &nbsp;
                <input name="reset" type="hidden" class="b_foot" value="���" >
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
  <input type="hidden" name="printAccept" value="<%=printAccept%>"><!--��ӡ��ˮ-->
  <input type="hidden" name="phoneNo" value="<%=main_card%>">
  <input type="hidden" name="op_code" value="<%=opCode%>">
  <input name="fam_prod_id" type="hidden" id="fam_prod_id" maxlength=8 > <!--��ͥ����-->
  <input name="opNote" type="hidden" id="opNote" value="" onFocus="setOpNote();" > 
  <input type="hidden" name="return_page" value="/npage/bill/f7333_login.jsp?activePhone=<%=main_card%>&opName=<%=opname%>&opCode=<%=opcode%>">
   <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>



