<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.1.8
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%            
  	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName"); 	
  	String iPhoneNo = request.getParameter("srv_no");
            
  	String loginNo = (String)session.getAttribute("workNo");
  	String orgCode = (String)session.getAttribute("orgCode");
  	String regionCode = (String)session.getAttribute("regCode");
  
	  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
		String op_strong_pwd = (String) session.getAttribute("password");
	  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
  
  	String paraStr[]=new String[1];
  	String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
  	//paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
%>
<%
    ArrayList arrSession2 = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession2 = (String[][])arrSession2.get(0);
     
  	String retFlag="",retMsg="";  
  	String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  	String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
  	String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  	String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  	String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";
	
	//String iLoginNo = request.getParameter("iLoginNo");
	//String iOrgCode = request.getParameter("iOrgCode");
	String iOpCode = request.getParameter("opCode");
	String cus_pass = request.getParameter("cus_pass");
		
	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	System.out.println("phoneNO === "+ iPhoneNo);

  //retList = co2.callFXService("s126bInit", inputParsm, "39","phone",iPhoneNo);
%>
	<wtc:service name="s126bInit" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="29">			
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=iOpCode%>"/>
				<wtc:param value="<%=loginNo%>"/>
				<wtc:param value="<%=op_strong_pwd%>"/>
				<wtc:param value="<%=iPhoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=inputParsm[2]%>"/>
	</wtc:service>	
	<wtc:array id="tempArr"  scope="end"/>
<%
  	String errCode = retCode2;
  	String errMsg = retMsg2;

	//co2.printRetValue();

  if(tempArr.length==0)
  {
	  retFlag = "1";
	  retMsg = "s126bInit��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;  
  }
  else if(errCode.equals("000000") && tempArr.length>0)
  {
	 
	    bp_name = tempArr[0][3];           //��������
	
	    bp_add = tempArr[0][4];            //�ͻ���ַ
	 
	    sm_code = tempArr[0][11];         //ҵ�����
	 
	    sm_name = tempArr[0][12];        //ҵ���������
	 
	    hand_fee = tempArr[0][13];      //������
	
	    favorcode = tempArr[0][14];     //�Żݴ���
	 
	    rate_code = tempArr[0][5];     //�ʷѴ���
	 
	    rate_name = tempArr[0][6];    //�ʷ�����
	 
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
	 
	 }else{%>
		<script language="JavaScript">
			rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
			history.go(-1);
		</script>
<%	 }
%>

<head>
<title>���������ϰ��Ŀ�����</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--
 
  onload=function()
  {

  	document.all.phoneNo.focus();
   	self.status="";
   }
//--------1---------doProcess����----------------

  function doProcess(packet)
  {  
    var vRetPage=packet.data.findValueByName("rpc_page");
 	
	var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage");	
    var retFlag = packet.data.findValueByName("retFlag");	
  
	if(retType=="chkX")
	{
    	var retObj = packet.data.findValueByName("retObj");
		if(retCode == "000000"){
				rdShowMessageDialog("У��ɹ�!",2);			
				document.all.commit.disabled=false;
			}else if(retCode=="100001"){
				retMessage = retCode + "��"+retMessage;	
				rdShowMessageDialog(retMessage);		 
				document.all.commit.disabled=false;
				return true;
    	}else{
				retMessage = "����" + retCode + "��"+retMessage;			 
				rdShowMessageDialog(retMessage,0);
				document.all.commit.disabled=true;
				document.all(retObj).focus();
				return false;
			 
		}
	}
 }

  /***** �ύǰ����Ʒ��ת����ʾ��Ϣ added by hanfa 20070118 begin *****/ 
  function formCommit()
  {
  		if(document.frm.mode_code.value=="")
		{
		  rdShowMessageDialog("��ѡ���ʷ���Ϣ!");
  		  return false;
		}
	
  		//getAfterPrompt();
  		if(document.all.oSmCode.value == "zn" && document.all.m_smCode.value == "gn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((document.all.m_smCode.value !="") && (document.all.m_smCode.value != document.all.oSmCode.value))
	  			rdShowMessageDialog("�ò����漰��Ʒ�Ʊ�����������л��֣���Mֵ�������ʷ���Ч�Ĵ��³����㣬������ʱ�һ�");
  		}
		frmCfm();
  }
  /***** �ύǰ����Ʒ��ת����ʾ��Ϣ added by hanfa 20070118 end *****/
  
  function frmCfm()
  { 
     if(document.frm.opNote.value=="")
     document.frm.opNote.value="�û���ͨ�����������ϰ��Ŀ�����";
     document.frm.iAddStr.value=document.all.i16.value+"|"+document.frm.mode_code.value+"|"+document.frm.kin_mode.value+"|"+document.all.iccid.value+"|"+document.all.opNote.value+"|"+document.getElementById('kin_nos').value+"|";
     //alert(document.frm.iAddStr.value);
     document.frm.ip.value=document.frm.mode_code.value;
     document.frm.i1.value=document.frm.phoneNo.value;
    
     if (document.all.i9.value == "Y")
     {
     	rdShowMessageDialog("���û��������û�,Ԥ������������ʱ�ջأ�");
     }

         //if(document.all.i9.value == "N" && parseFloat(document.all.oPayPre.value)<parseFloat(document.all.Prepay_Fee.value))
         //{
          // rdShowMessageDialog("���ν���Ԥ����,���ܰ���!");
           //return;
        // }

	frm.submit();
  }
	
 
function change_idType()
{
    var Str = document.frm.idType.value;
    if(Str.indexOf("���֤") > -1)
    {   document.frm.iccid.v_type = "idcard";   }
    else
    {   document.frm.iccid.v_type = "string";   }
    document.all.commit.disabled=true;
}  
function rpc_chkX(x_type,x_no,chk_kind)
{
  var obj_type=document.all(x_type);
  var obj_no=document.all(x_no);
  var idname="";
	
  if(obj_type.type=="text")
  {
    idname=(obj_type.value).trim();
  }
  else if(obj_type.type=="select-one")
  {
    idname=(obj_type.options[obj_type.selectedIndex].text).trim();  
  }	
  if((obj_no.value).trim().length>0)
  {
    if((obj_no.value).trim().length<15)
	{
      rdShowMessageDialog("֤�����볤����������15λ����");
	  obj_no.focus();
  	  return false;
	}
	else
	{
      if(idname=="���֤")
	  {
        if(checkElement(obj_no)==false) return false;
	  }
	}
  }
  else 
	return;
  var myPacket = new AJAXPacket("/npage/innet/chkX.jsp","������֤��������Ϣ�����Ժ�......");
	  myPacket.data.add("retType","chkX");
	  myPacket.data.add("retObj",x_no);
	  myPacket.data.add("x_idType",getX_idno(idname));
	  myPacket.data.add("x_idNo",obj_no.value);
	  myPacket.data.add("x_chkKind",chk_kind);
	  core.ajax.sendPacket(myPacket);
	  myPacket=null;
  
}
function getX_idno(xx)
{
  if(xx==null) return "0";
  
  if(xx=="���֤") return "0";
  else return "0";
}
  
  function salechage()
	{ 
	  //���ù���js
	  var mode_code=document.all.mode_code.value;
	  var kin_mode=document.all.kin_mode.value;
	  var regionCode = "<%=regionCode%>";
	  var rate_code = "<%=rate_code%>";
	  var pageTitle = "Ӫ������Ϣ";
	  var fieldName = "���ʷѴ���|���ʷ�����|������ʷѴ���|������ʷ�����|�����ʷ�";//����������ʾ���С����� 
	  var sqlStr = "select a.new_mode,b.mode_name new_mode_name,a.kin_mode,c.mode_name kin_name,a.cancel_mode from sElderlyCardCfg a,sbillmodecode b,sbillmodecode c "
	             + "where a.region_code='"+regionCode+"' and a.region_code=b.region_code and a.region_code=c.region_code and a.new_mode=b.mode_code and sysdate between a.begin_time and a.end_time and a.kin_mode=c.mode_code";
	  var selType = "S";    //'S'��ѡ��'M'��ѡ
	  var retQuence = "0|1|2|3|4";//�����ֶ�
	  var retToField = "mode_code|mode_name|kin_mode|kin_name|next_mode";//���ظ�ֵ����
	  if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));   
	  document.frm.iAddStr.value=document.frm.iccid.value+"|"+document.frm.mode_code.value+"|"+document.frm.kin_mode.value+"|"+document.all.imain_stream.value+"|"+document.getElementById('kin_nos').value+"|";
	  //alert(document.frm.iAddStr.value); 
	  document.frm.ip.value=document.frm.mode_code.value;
		document.frm.i1.value=document.frm.phoneNo.value;
		getMidPrompt("10442",codeChg(document.frm.mode_code.value),"ipTd");
		getMidPrompt("10442",codeChg(document.frm.kin_mode.value),"ipTd1");  
	}

function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի��� 
     var h=150;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;

     var printStr = printInfo(printType);

     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     var path = "<%=request.getContextPath()%>/pages/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
     var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
     var ret=window.showModalDialog(path,"",prop);
     return ret;    
  }

function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth)
{
    var path = "<%=request.getContextPath()%>/page/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
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

function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}

//-->
</script>

</head>


<body>
	<form name="frm" method="post" action="f1270_3.jsp" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">�û���Ϣ</div>
		</div>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
	  	<input type="hidden" name="m_smCode" value="">
		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=paraStr%>">
		<input type="hidden" name="Gift_Code" value="">

	<table cellspacing="0">
		<tr>
			<td width="15%" class="blue">�ֻ�����</td>
            <td>
				<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" v_name="�ֻ�����" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly >
			</td>
			<td width="15%" class="blue">��������</td>
			<td>
				<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td width="15%" class="blue">ҵ��Ʒ��</td>
            <td>
				<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
			</td>
            <td width="15%" class="blue">�ʷ�����</td>
            <td>
				<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" size=20 readonly>
			</td>
		</tr>
		<tr>
			<td width="15%" class="blue">֤������ </td>
			<TD>
				<select align="left" name=idType onChange="change_idType()" width=50 index="10">
		<%			//�õ��������
         String sqlStr3 ="select trim(ID_TYPE), ID_NAME,ID_NAME from sIdType order by id_type";           
 		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="3">
		<wtc:sql><%=sqlStr3%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result3" scope="end" /> 
		 <%
		      if(retCode3.equals("000000")){		     
		      	System.out.println("���÷���ɹ���");                
		      	out.println("<option class='button' value='" + result3[0][0] + "|" + result3[0][2] + "'>" + result3[0][1] + "</option>");		     	      
		      }else{
		    	 System.out.println("***********************************************************************");
		         System.out.println("���÷���ʧ�ܣ�");		    	   
		    	}              
		               
		           
		%>		
</TD>
			<td width="15%" class="blue">���֤����</td>
        <td>
				<input name="iccid" class="button" v_must=1 v_type="string" size="20" onChange="change_idType()" maxlength="18" index="11">
				<input name="chkId" class="b_text" type="button" value="��֤" onclick="rpc_chkX('idType','iccid','A')">
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
			<td width="15%" class="blue">
				���ʷѴ���
			</td>
        <td width="35%" id=ipTd>
				<input name="mode_code" type="text" class="InputGrey" id="mode_code" size="8" readonly>
				<input name="qry" class="b_text" type="button" value="��ѯ" onclick="salechage();">
			</td>  
			 <td width="15%" class="blue">
       ���ʷ�����
       </td>
       <td width="35%">
         <input name="mode_name" type="text" class="InputGrey" id="mode_name"   readonly>
			</td>
		</tr>
		<tr> 
			<td width="15%" class="blue">
				������ʷѴ���
			</td>
            <td width="35%" id=ipTd1>
				<input name="kin_mode" type="text" class="InputGrey" id="kin_mode" readonly>
			</td>  
			<td width="15%" class="blue">
				������ʷ�����
			</td>
      <td width="35%">
        <input name="kin_name" type="text" class="InputGrey" id="kin_name" readonly>
        <input name="next_mode" type="hidden" class="button" id="next_mode" readonly>
			</td>
		</tr>
		<tr>
			<td width="15%" class="blue">
				�������
			</td>
			<td colspan=3>
				<TEXTAREA   NAME="kin_nos"  ROWS="1" COLS="60" onkeypress="check();"></TEXTAREA>
				<font color="red">(����ĺ�������","�Ÿ���)</font>
			</td>
		</tr>	
		<tr>                    
    <td width="15%" class="blue">
    	������ע
    </td>
    <td colspan=3>
    	<input name="opNote" type="text" class="InputGrey" id="opNote" maxlength=60 size="60">
    </td>	
     </tr>
		<tr>
			<td id="footer" colspan="4">
				<div align="center">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot"   value="ȷ��" onClick="formCommit();" disabled >
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="���" >
                &nbsp; 
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
                &nbsp; 
				</div>
			</td>
		</tr>
	</table>
</div>
<div name="licl" id="licl">
			<input type="hidden" name="opCode" value="7977">
			<input type="hidden" name="iOpCode" value="7977">
			<input type="hidden" name="opName" value="<%=opName%>">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<!--���²�����Ϊ��f1270_3.jsp������Ĳ���
			i2:�ͻ�ID
			i16:��ǰ���ײʹ���
			ip:�������ײʹ���
			belong_code:belong_code
			print_note:��������
			iAddStr:
			
			i1:�ֻ�����
			i4:�ͻ�����
			i5:�ͻ���ַ
			i6:֤������
			i7:֤������
			i8:ҵ��Ʒ��
			
			ipassword:����
			group_type:���ſͻ����
			ibig_cust:��ͻ����
			do_note:�û���ע
			favorcode:�������Ż�Ȩ��
			maincash_no:�����ײʹ��루�ϣ�
			imain_stream:��ǰ���ʷѿ�ͨ��ˮ
			next_main_stream:ԤԼ���ʷѿ�ͨ��ˮ
			
			i18:�������ײ�
			i19:������
			i20:���������
			-->				
			<input type="hidden" name="i2" value="<%=cust_id%>">	                			
			<input type="hidden" name="i16" value="<%=rate_code%>">	
			<input type="hidden" name="ip" value="">				

			<input type="hidden" name="belong_code" value="<%=cust_belong_code%>">								
			<input type="hidden" name="print_note" value="<%=print_note%>">
			<input type="hidden" name="iAddStr" value="">

			<input type="hidden" name="i1" value="">
			<input type="hidden" name="i4" value="<%=bp_name%>">			
			<input type="hidden" name="i5" value="<%=bp_add%>">
			<input type="hidden" name="i6" value="<%=cardId_type%>">
			<input type="hidden" name="i7" value="<%=cardId_no%>">
			<input type="hidden" name="i8" value="<%=sm_code%>--><%=sm_name%>">			
			<input type="hidden" name="i9" value="<%=contract_flag%>">			

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="do_note" value="<%=iPhoneNo%>����ͨ�����������ϰ��Ŀ�ҵ��">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">			
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">
			
			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">			
			<input type="hidden" name="i20" value="<%=hand_fee%>">
			<input type="hidden" name="cus_pass" value="<%=cus_pass%>">	
			<input type="hidden" name="return_page" value="/npage/bill/f7977Login.jsp?activePhone=<%=iPhoneNo%>&opName=<%=opName%>&opCode=<%=opCode%>">
</div>		
 <%@ include file="/npage/include/footer.jsp" %>   	
</form>
</body>
</html>
