<%
/********************
version v2.0
������: si-tech
ģ�飺��ֵ�������
���ڣ�2008.12.1
���ߣ�leimd
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp"%>
<%
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
/****************���ƶ�����õ����롢���������� ����Ϣ s126bInit***********************/
  ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String award_type= request.getParameter("award_type");
  String passwordFromSer="";
  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = loginNo; 	    /* ��������   */
  paraAray1[2] = orgCode;	    /* ��������   */
  paraAray1[3] = "7163";	    /* ��������   */
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
%>
   <wtc:service name="s1557Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="error_code" retmsg="error_msg"               outnum="29" >
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/> 
		<wtc:param value="<%=paraAray1[3]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",print_note="",contract_flag="",high_flag="";
  String errCode = error_code;
  String errMsg = error_msg;
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s1557Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(retList == null)){
	if (errCode.equals("000000") ){
		if(tempArr.length>0){
		    bp_name = tempArr[0][3];//��������
		    bp_add = tempArr[0][4];//�ͻ���ַ
		  	passwordFromSer = tempArr[0][2];//����
		    sm_code = tempArr[0][11];//ҵ�����
		    sm_name = tempArr[0][12];//ҵ���������
		    hand_fee = tempArr[0][13];//������
		    favorcode = tempArr[0][14];//�Żݴ���
		    rate_code = tempArr[0][5];//�ʷѴ���
		    rate_name = tempArr[0][6];//�ʷ�����
		    next_rate_code = tempArr[0][7];//�����ʷѴ���
		    next_rate_name = tempArr[0][8];//�����ʷ�����
		    bigCust_flag = tempArr[0][9];//��ͻ���־
		    bigCust_name = tempArr[0][10];//��ͻ�����
		    lack_fee = tempArr[0][15];//��Ƿ��
		    prepay_fee = tempArr[0][16];//��Ԥ��
		    cardId_type = tempArr[0][17];//֤������
		    cardId_no = tempArr[0][18];//֤������
		    cust_id = tempArr[0][19];//�ͻ�id
		    cust_belong_code = tempArr[0][20];//�ͻ�����id
		    group_type_code = tempArr[0][21];//���ſͻ�����
		    group_type_name = tempArr[0][22];//���ſͻ���������
		    imain_stream = tempArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ
		    next_main_stream = tempArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
		    print_note = tempArr[0][25];//�������
		    contract_flag = tempArr[0][27];//�Ƿ������˻�
		    high_flag = tempArr[0][28];//�Ƿ��и߶��û�
		}  
	}else{
		if(!retFlag.equals("1"))
			{
			   retFlag = "1";
		       retMsg = "s1557Init��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
			}
		}
  }
//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//   
   //�Ż���Ϣ
  String[][]  favInfo = (String[][])session.getAttribute("favInfo"); //�Żݴ���Ϊ����
  boolean pwrf = true;//a272 ��������֤
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
	if(tempStr.compareTo(favorcode) == 0)
    {
      handFee_Favourable = "";
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
//******************�õ�����������***************************//
 //Ԥ����
  String sql="select a.prepay_money,a.total_money from dPhoneAwardPrepay a,dCustmsg b  where b.phone_no = '"+phoneNo+"' and a.id_no=b.id_no";
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" outnum="2" retmsg="ret_msg_1">
	 	<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="prepay_money" scope="end"/>
<%
  System.out.println("sql="+sql);
  if (prepay_money.length!= 0)
		{
			if (prepay_money[0][0].equals("")) 
			{
				prepay_money = null;
			}
		}	
if(prepay_money.length==0)
	{
		System.out.println("bbbb");
%>
<script>
	 rdShowMessageDialog("���û���ֵ��Ϣ�����ڣ�");
	 history.go(-1);
</script>		
<%

	}else{
      sql="select a.login_no,a.login_accept,sum(a.res_num),sum(prepay_money) from wAwardPrePay a,dCustMsg b   "+
  		"where a.phone_no='"+phoneNo+"' "+
  		"and a.id_no=b.id_no "+
  		"group by  a.login_accept,a.login_no ";
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" outnum="4" retmsg="ret_msg_2">
	 	<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="colNameArr" scope="end"/>
<%
  System.out.println("sql="+sql);
  if (colNameArr != null&&colNameArr.length!=0)
		{
			if (colNameArr[0][0].equals("")) 
			{
				colNameArr = null;
			}
		}
	else{
%>
<script>
	 rdShowMessageDialog("���û���ֵ��Ϣ�����ڣ�");
	 history.go(-1);
</script>		
<%		
		}	
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();  
%>
<html>
<head>
<title>��ֵ������� </title>
<%
        String opCode = "7163";
        String opName = "��ֵ�������";
        String ReqPageName = WtcUtil.repNull(request.getParameter("ReqPageName"));
        activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
        System.out.println("##########################s1219Login.jsp->activePhone->"+activePhone);
%>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">
<%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}%>
  function frmCfm(){
	frm.submit();
  }
  function frmCfmCommit(){
  	getAfterPrompt();
  	var radioname1="";
	var consume_money="";
    var consume_present ="";
	var consume_num = ""
	document.all.commit.disabled=false;
	//һ�ж�û��
	if(document.all.radioname==undefined)
	{
	}
	//ֻ��һ��
	if(document.all.radioname.length==undefined)
	{
		if(document.all.radioname.checked==true	)
		{
			radioname1=document.all.radioname.value;
			consume_money= eval("document.all.consumMoney"+0+".value");
			consume_num =eval("document.all.consumNum"+0+".value");
			document.frm.consume_money.value=consume_money;
			document.frm.consume_num.value=consume_num;
		}
	}
	for(i=0;i<document.all.radioname.length;i++)
	{
		if(document.all.radioname[i].checked==true)
		{
			radioname1=document.all.radioname[i].value;
			consume_money= eval("document.all.consumMoney"+i+".value");
			consume_num=eval("document.all.consumNum"+i+".value");
			document.frm.consume_money.value=consume_money;
			document.frm.consume_num.value=consume_num;
		}	
	}
  	if(radioname1=="")
  	{
  		rdShowMessageDialog("��ѡ��Ҫ�����ļ�¼��");
  		return;
  	}
  	setOpNote();//Ϊ��ע��ֵ
  	frm.action = "f7163Cfm.jsp?loginaccept="+radioname1+"&sysAccept=<%=printAccept%>";
 	//��ӡ�������ύ��
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
	return true;

  }

function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի��� 
	var h=200;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
   
	var pType="subprint";
	var billType="1";
	var sysAccept = <%=printAccept%>;
	var mode_code = null;
	var fav_code = null;
	var area_code = null;
	var printStr = printInfo(printType);
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
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
	var retInfo = "";
	
	cust_info+="�ͻ�������"+document.frm.bp_name.value+"|";
	cust_info+="�ֻ����룺"+document.frm.phoneNo.value+"|";
	cust_info+="֤�����룺"+"<%=cardId_no%>"+"|";
	cust_info+="�ͻ���ַ��"+"<%=bp_add%>"+"|";	
	
	var sum_consum ="";
	sum_consum = parseFloat(document.frm.prepay_money.value)+parseFloat(document.frm.consume_money.value);
	opr_info+='<%=loginName%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	
	opr_info+="ҵ�����ͣ�"+"��ֵ�������"+"   �һ�������" + document.frm.consume_money.value +"|";
	opr_info+="�ۼƳ�ֵ��"+document.frm.prepay_money_lj.value+"  ���ó�ֵ��"+parseFloat(sum_consum)+"|";
	opr_info+="��ˮ: "+"<%=printAccept%>"+"|";
	opr_info+="��Ʒ������"+document.frm.consume_num.value+"|";
	note_info1+= "��ע��"+"|";
	//retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 	
	retInfo+="<%=print_note%>"+"|"; 
	
	return retInfo;
  }
  
/******Ϊ��ע��ֵ********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	   document.frm.opNote.value = "��ֵ�������;"+document.frm.phoneNo.value; 
	}
	return true;
}
</script>
</head>
<body>
<form name="frm" method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
  <div id="title_zi">��ֵ�������</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">�ֻ�����</td>
        <td>
			<input name="phoneNo" type="text" id="phoneNo" value="<%=phoneNo%>" Class="InputGrey" readOnly> 
		</td> 
		<td class="blue">��������</td>
        <td>
			<input name="bp_name" type="text" id="bp_name" value="<%=bp_name%>" Class="InputGrey" readOnly>	
			<input name="award_type" type="hidden" value=<%=award_type%>> 		  
		</td>           
    </tr>
    <tr> 
		<td class="blue">ҵ��Ʒ��</td>
        <td>
			<input name="sm_name" type="text" id="sm_name" value="<%=sm_code + "--" + sm_name%>" Class="InputGrey" readOnly>
		</td>
        <td class="blue">��ͻ���־</td>
        <td>
			<input name="bigCust_flag" type="text" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" Class="InputGrey" readOnly>
		</td>            
    </tr>
	<tr> 
		<td class="blue">֤������</td>
        <td>
			<input name="cardId_type" type="text" id="cardId_type" value="<%=cardId_type%>" Class="InputGrey" readOnly>
		</td>
        <td class="blue">֤������</td>
        <td>
			<input name="cardId_no" type="text" id="cardId_no" value="<%=cardId_no%>" Class="InputGrey" readOnly>
		</td>            
    </tr>
    <tr> 
        <td class="blue">��ǰ���ײ�</td>
    	<td>
			<input name="rate_name" type="text" id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" Class="InputGrey" readOnly>
		</td>
		<td class="blue">��ǰ���öһ����</td>
        <td>
			<input name="prepay_money" type="text" id="rate_name" size="30" value="<%=prepay_money[0][0]%>" Class="InputGrey" readOnly>
		</td>             
    </tr>
	<tr> 
		<td class="blue">�ۼƳ�ֵ���</td>
        <td colspan="3">
			<input name="prepay_money_lj" type="text" id="rate_name" size="30" value="<%=prepay_money[0][1]%>" Class="InputGrey" readOnly>
		</td> 
    </tr>
</table>
<table cellspacing="0">			 		 				  
	<tr>              
        <th nowrap> 
             ѡ��
        </th>
     	<th nowrap> 
             ����Ա
        </th>
        <th nowrap> 
             ��ˮ
        </th>
        <th nowrap> 
             ��Ʒ����
        </th>
        <th nowrap> 
             �һ����
        </th>
     </tr>
<%
    if(colNameArr!=null)
      {
		 for(int i=0;i<colNameArr.length;i++)
		 {
%>
	<tr> 
		<td height="25" nowrap> 
			<input type="radio" name="radioname" value="<%=colNameArr[i][1]%>">
        </td>
        <td height="25" nowrap> 
<%=colNameArr[i][0]%>
        </td>
        <td nowrap> 
<%=colNameArr[i][1]%>
        </td>
        <td nowrap> 
<%=colNameArr[i][2]%>
        </td>
        <td nowrap> 
<%=colNameArr[i][3]%>
        </td>
			<input name="consumNum<%=i%>" type="hidden" value= "<%=colNameArr[i][2]%>">
			<input name="consumMoney<%=i%>" type="hidden" value= "<%=colNameArr[i][3]%>">
    </tr>
<%
		}
	}

 %>             
</table>
<table cellspacing="0">
	<tr> 
    	<td class="blue">��ע</td>
        <td colspan="5">
        	<input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="" onfocus="setOpNote()" class="InputGrey" readOnly> 
        </td>
    </tr>		
	<tr> 
    	<td colspan="6" align="center"> 
			<input name="commit" id="commit" type="button" class="b_foot_long"   value="ȷ��&��ӡ" onClick="frmCfmCommit()" >
        	&nbsp; 
        	<input name="reset" type="reset" class="b_foot" value="���" >
        	&nbsp; 
        	<input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
        	&nbsp; 
        </td>
    </tr>
</table>
		<input type="hidden" name="consume_num" >
		<input type="hidden" name="consume_money" >
<%@ include file="/npage/include/footer.jsp" %>
</form>
</div>
</body>
</html>
<script language="JavaScript">
  <%if((high_flag.trim()).equals("Y")){%>
    rdShowMessageDialog('��ʾ: ��ע��,���û�Ϊ�и߶��û���');
  <%}	}%>
</script>

