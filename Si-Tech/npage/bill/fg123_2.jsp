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
<%@ include file="../../npage/bill/getMaxAccept.jsp"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%		
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
    	
  String loginNo = (String)session.getAttribute("workNo"); 
  String loginName = (String)session.getAttribute("workName"); 
  String orgCode = (String)session.getAttribute("orgCode"); 
  String regionCode = (String)session.getAttribute("regCode"); 
%>
<%
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
/****************���ƶ�����õ����롢���������� ����Ϣ s1205Init***********************/
  String[] paraAray1 = new String[6];

  String op_code = request.getParameter("op_code");
  String phoneNo = request.getParameter("chief_srv_no"); /* �ҳ�����*/
  
  System.out.println("mylog -----------phoneNo------------"+phoneNo);
  String home_no = request.getParameter("srv_no"); /* ��Ա����*/	
  String openType = request.getParameter("open_type");/* ��������*/
  String passwordFromSer="";
  String show_phone = "";
  String trOneView = "";
   /*****************
  	*add by zhanghonga@2009-02-06,
  	*����openType������opCode��opName,
  	*����ͳһ�Ӵ���opcode,opname��¼����
  	*������ǰ��ʾ�Ļ����벻��ʾ
  	****************/
	  switch(Integer.parseInt(openType)){
	  	case 0 : 
	  					opCode = "7123";
	  					opName = "��ͥ����ƻ�-������ͥ";
	  					break;
	  	case 1 :
	  					opCode = "7124";
	  					opName = "��ͥ����ƻ�-�����ͥ";
	  					break;
	  	case 2 :
	  					opCode = "7125";
	  					opName = "��ͥ����ƻ�-�˳���ͥ";
	  					break;
	  	case 3 :
	  					opCode = "7126";
	  					opName = "��ͥ����ƻ�-ȡ����ͥ";
	  					break;
	  	default:
	  					opCode = "7123";
	  					opName = "��ͥ����ƻ�-������ͥ";
	  					break;
	  }
	  System.out.println("########################################fg123_2.jsp->opCode->"+opCode+"&opName->"+opName);
  /**************add end here******************/
  
  
  if(openType.equals("0")){
	op_code="7123";
	show_phone = phoneNo;
	trOneView = "";//�пɼ�
  }else if(openType.equals("1")){
	op_code="7124";
	show_phone = home_no;
	trOneView = "";//�пɼ�
  }else if(openType.equals("2")){
	op_code="7125";
	show_phone = home_no;
	trOneView = "display:none";//�в��ɼ�
  }else{
	op_code="7126";
	show_phone = phoneNo;
	trOneView = "display:none";//�в��ɼ�
  }

  
  paraAray1[0] = home_no;		/* �ֻ�����   */ 
  paraAray1[1] = loginNo; 	    /* ��������   */
  paraAray1[2] = orgCode;	    /* ��������   */
  paraAray1[3] = op_code;		/* ��������   */
  paraAray1[4] = phoneNo;		/* ��ͥ��Ա	*/
  paraAray1[5] = openType;		/* ��������	*/
	
  System.out.println("home_no === "+ home_no);
  System.out.println("loginNo === "+ loginNo);
  System.out.println("orgCode === "+ orgCode);
  System.out.println("op_code === "+ op_code);
  System.out.println("phoneNo === "+ phoneNo);
  System.out.println("openType === "+ openType);
  
  for(int i=0; i<paraAray1.length; i++)
  {	
	
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  
  //retList = impl.callFXService("s7123Valid", paraAray1, "27");
%>
	<wtc:service name="s7123ValidEx" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="27">			
	<wtc:param value="<%=paraAray1[0]%>"/>	
	<wtc:param value="<%=paraAray1[1]%>"/>	
	<wtc:param value="<%=paraAray1[2]%>"/>	
	<wtc:param value="<%=paraAray1[3]%>"/>	
	<wtc:param value="<%=paraAray1[4]%>"/>	
	<wtc:param value="<%=paraAray1[5]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr"  scope="end"/>
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",print_note="", password="";
  String errCode = retCode1;
  String errMsg = retMsg1;
  System.out.println("errCode === "+ errCode);
  if(tempArr.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s7123Valid��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(errCode.equals("000000") && tempArr.length>0)
  {
	
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
	
		 family_code = tempArr[0][23]; //�û���ͥ����
	 
	    next_main_stream = tempArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	 
	    print_note = tempArr[0][25];//��������
	 
	    password = tempArr[0][26];//����
	 
	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s7123Valid��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}
//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//   
   //�Ż���Ϣ
  String[][] favInfo = (String[][])session.getAttribute("favInfo");  //���ݸ�ʽΪString[0][0]---String[n][0]
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
	if(tempStr.compareTo(favorcode) == 0)
    {
      handFee_Favourable = "";
    }
  }
  if(openType.equals("0")||openType.equals("1")||openType.equals("3"))
 {
	String passTrans=WtcUtil.repNull(request.getParameter("chief_cus_pass")); 
	if(!pwrf)
	{
		 String passFromPage=Encrypt.encrypt(passTrans);
		 if(0==Encrypt.checkpwd2(password.trim(),passFromPage))	{
		   if(!retFlag.equals("1"))
		   {
		      retFlag = "1";
			  retMsg = "�������!";
		   }
	    
		}       
	}
 }
  if(openType.equals("1")||openType.equals("2"))
 {
	String passTrans_2=WtcUtil.repNull(request.getParameter("cus_pass")); 
	if(!pwrf)
	{
		String passFromPage_2=Encrypt.encrypt(passTrans_2);
		 if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage_2))	{
		 if(!retFlag.equals("1"))
		 {
			retFlag = "1";
			retMsg = "�������!";
		 }
	    
		}       
	}
  }
	String sqlRateCode = "";
    //�ʷ���Ϣ
   
	sqlRateCode = "select a.mode_code,a.mode_code||'--'||a.mode_name from sbillmodecode a,sFamModeCode b  where a.region_code=b.region_code and a.mode_code=b.mode_code and b.region_code='"+regionCode +"'" ;
	System.out.println("sqlRateCode="+sqlRateCode);
	String[] paramIn = new String[2];
	//paramIn[0] = "select a.mode_code,a.mode_code||'--'||a.mode_name from sbillmodecode a,sFamModeCode b  where a.region_code=b.region_code and a.mode_code=b.mode_code and b.region_code=:regionCode";
	paramIn[0] = "select a.offer_id,a.offer_id ||'--'||a.offer_name from product_offer a,region b,sregioncode c WHERE  a.offer_id = b.offer_id AND b.group_id = c.group_id AND c.region_code='"+regionCode+"' and a.GROUP_TYPE_ID='10'";
	paramIn[1] = "regionCode="+regionCode;
	//ArrayList rateCodeArr = co.spubqry32("2",sqlRateCode);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2"  outnum="2">
    	<wtc:sql><%=paramIn[0]%></wtc:sql>
    </wtc:pubselect>
	<wtc:array id="rateCodeStr"  scope="end"/>
<%

	System.out.println("retCode2==="+retCode2);
	System.out.println("rateCodeStr"+rateCodeStr.length);

 String op_note="";
  if(openType.equals("0")){
	op_note="������ͥ";
  }else if(openType.equals("1")){
	op_note="�����ͥ";
  }else if(openType.equals("2")){
	op_note="�˳���ͥ";
  }else{
	op_note="ȡ����ͥ";
  }
    /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();
  
  String getParentPnSql = "select acc_nbr from group_instance_member where group_id =(select a.group_id from group_instance_member a,dcustmsg b where  a.serv_id = b.id_no and    b.phone_no ='"+home_no+"' and    a.member_role_id = 10010 and    sysdate between eff_date and exp_date) and    member_role_id = 11010 ";
%>

 	<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=getParentPnSql%></wtc:sql>
 	</wtc:pubselect>
	<wtc:array id="result_t" scope="end"/>
	 	<%
	 	String parentPnSV1 = "";
	 	if(result_t.length>0&&result_t[0][0]!=null){
	 		parentPnSV1 = result_t[0][0];
	 	}
	 	
	 	
	 	if(phoneNo==null||phoneNo.equals("")) phoneNo  = parentPnSV1;
	 	%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>��ͥ����ƻ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
 
<script language="JavaScript">

  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>",0);
    history.go(-1);
  <%}%>

<!--
  //����Ӧ��ȫ�ֵı���
  onload=function()
  {		
  } 
  
  
  function frmCfm()
  {
 	frm.submit();
	return true;
  }
  //У��
  function check()
  {
 		with(document.frm)
		{	
		var now_rate_code = "<%=rate_code%>";
		var next_rate_code = "<%=next_rate_code%>";
		return true;
    }
  }
  
  function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  } 
  
 function printCommitOne(subButton){
 	getAfterPrompt();
	//controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
//subButton.disabled = true;
	document.frm.new_rate_code.value=document.frm.add_mode.value.substring(0,8);
	if ((document.frm.new_rate_code.value=="")&&(document.frm.op_code.value=="7123"||document.frm.op_code.value=="7124"))
	{
		rdShowMessageDialog("��ͥ�ײʹ��벻��Ϊ��!");
		//document.frm.new_rate_code.focus();
		return false;
	}
	setOpNote();//Ϊ��ע��ֵ
	frm.action = "fg123Cfm.jsp";
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
		var opCode="<%=op_code%>";      
		var phoneNo=document.frm.show_phone.value;                 //�ͻ��绰
		
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
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
		
		cust_info+="�ֻ����룺"+"<%=show_phone%>"+"|";
		cust_info+="�ͻ�������"+document.frm.bp_name.value+"|";
		
		opr_info+="��ʼʱ�䣺 "+exeDate+"|";
		opr_info+="ҵ�����ͣ���ͥ����ƻ����"+"<%=op_note%>"+"|";
		opr_info+="��ͨ���룺"+document.frm.show_phone.value+"|";
		opr_info+="��ˮ��"+"<%=printAccept%>"+"|";
		opr_info+="�������ʣ�"+"<%=print_note%>"+"|"; 
		
		note_info1+="��ע��"+document.all.opNote.value.trim()+"|";
		
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
		return retInfo;
  }
  //�ύ���� 
  function printCommit(subButton){
  	getAfterPrompt();
	controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	//У��
	setOpNote();//Ϊ��ע��ֵ
    //�ύ��
    frmCfm();	
	return true;
  }
 

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
    if(retInfo ==undefined)      
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
	return true;
}
/******Ϊ��ע��ֵ********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{  
		<%
			if(opCode.equals("7125")){
			 %>
					var notePhone="<%=parentPnSV1%>";
			 <%
			}else{
				%>
					var notePhone=document.frm.phoneNo.value;
				<%				
				}
		%>
	  document.frm.opNote.value = "��ͥ����ƻ����--<%=op_note%> �ҳ�����:"+notePhone; 
	}
	return true;
}
//-->
//������ʾ
function controlFlagCodeTdView(){
	getMidPrompt("10442",codeChg(document.frm.add_mode.value),"ipTd");
}
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
            <td colspan="3">
			  <input name="op_type" type="text" class="InputGrey" id="op_type" value="<%=op_note%>" readonly>
			</td>
          </tr>
		  <tr>
		    <td class="blue">�ֻ�����</td>
            <td>
			  <input name="show_phone" type="text" class="InputGrey" id="show_phone" value="<%=show_phone%>" readonly> 
			</td> 
		    <td class="blue">��������</td>
            <td>
			  <input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>			  
			</td>           
          </tr>
          <tr> 
		    <td class="blue">ҵ��Ʒ��</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_code + "--" + sm_name%>" readonly>
			</td>
            <td class="blue">��ͻ���־</td>
            <td>
			<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
			</td>            
          </tr>
		  <tr> 
		    <td class="blue">֤������</td>
            <td>
			  <input name="cardId_type" type="text" class="InputGrey" id="cardId_type" value="<%=cardId_type%>" readonly>
			</td>
            <td class="blue">֤������</td>
            <td>
			<input name="cardId_no" type="text" class="InputGrey" id="cardId_no" value="<%=cardId_no%>" readonly>
			</td>            
          </tr>
          <tr> 
            <td class="blue">��ǰ���ײ�</td>
            <td>
			  <input name="rate_name" type="text" class="InputGrey" id="rate_name" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td class="blue">�������ײ�</td>
            <td>
			  <input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
			</td>             
          </tr>
		  <tr>
			<td class="blue">��ͥ����</td>
            <td colspan="<%=(trOneView=="display:none"?"3":"1")%>">
			  <input type="text" name="family_code" id="family_code"  v_must=1 value = "<%=family_code%>" readonly class="InputGrey">
			   <font color="orange">*</font>
			</td> 
			<TD class="blue" style=<%=trOneView%>> ��ͥ�ײʹ���</TD>
			<TD style="<%=trOneView%>" id="ipTd">
			  <select  name="add_mode" id="add_mode" onChange="controlFlagCodeTdView();">
				<option value="">--��ѡ��--</option>
				<%for(int i = 0 ; i < rateCodeStr.length ; i ++){%>
				<option value="<%=rateCodeStr[i][0]%>"><%=rateCodeStr[i][1]%></option>
				<%}%>
			  </select>
			  <font color="orange">*</font>
			</TD>
          </tr>
		  
          <tr> 
            <td class="blue">��ע</td>
            <td colspan="3">
             <input name="opNote" type="text" id="opNote" value="" onFocus="setOpNote();" readonly size="40" class="InputGrey"> 
            </td>
          </tr>
		  <tr> 
            <td colspan="4" id="footer"> <div align="center"> 
                &nbsp; 
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="ȷ��&��ӡ" onClick="printCommitOne(this)" >
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="���" >
                &nbsp; 
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
                &nbsp; 
				</div>
			</td>
          </tr>
      </table>
 
  <input type="hidden" name="favorcode">
  <input type="hidden" name="next_main_stream">
  <input type="hidden" name="open_type" value="<%=openType%>">
  <input type="hidden" name="home_no" value="<%=home_no%>">
  <input type="hidden" name="new_rate_code" value=""><!--��������ѡ�ʷѴ���-->
  <input type="hidden" name="printAccept" value="<%=printAccept%>"><!--��ӡ��ˮ-->
  <input type="hidden" name="print_note" value="<%=print_note%>"><!--��ӡ�������-->
  <input type="hidden" name="op_code" value="<%=op_code%>"><!--��������-->
  <input type="hidden" name="phoneNo" value="<%=phoneNo%>"><!--��ӡ�������-->
    <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
