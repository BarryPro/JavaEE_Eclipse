<%
/********************
 version v2.0
 ������: si-tech
 ģ�飺ͳһ�콱
 update zhaohaitao at 2009.1.4
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
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%>
<%
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
/****************���ƶ�����õ����롢���������� ����Ϣ s1251Init***********************/
  String[][] temp=new String[][]{};
  String[][] tmpresult1= new String[][]{};
  String[][] tmpresult2= new String[][]{};
  String[][] tmpresult3= new String[][]{};
  String[][] tmpresult4= new String[][]{};
  String[][] tmpresult5= new String[][]{};
  String[] paraAray1 = new String[2];
  String phoneNo = request.getParameter("srv_no");
  String passwordFromSer="";
  int j=0;
  
  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = loginNo; 	/* ��������   */
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s1557barInit", paraAray1, "9","phone",phoneNo);
%>
	<wtc:service name="s1557barInit" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="9">			
		<wtc:param value="<%=paraAray1[0]%>" />
		<wtc:param value="<%=paraAray1[1]%>" />
	</wtc:service>
	<wtc:array id="tempArr"  start="0" length="4" scope="end"/>
	<wtc:array id="tempArr4" start="4" length="1" scope="end"/>
	<wtc:array id="tempArr5" start="5" length="1" scope="end"/>
	<wtc:array id="tempArr6" start="6" length="1" scope="end"/>
	<wtc:array id="tempArr7" start="7" length="1" scope="end"/>
	<wtc:array id="tempArr8" start="8" length="1" scope="end"/>
<%
  String  bp_name="";
  String errCode = retCode1;
  String errMsg = retMsg1;
  System.out.println("errCode==="+errCode);
  if(tempArr.length==0)
  {
	 if(!retFlag.equals("1"))
	 {
	   retFlag = "1";
	   retMsg = "s1557openinit��ѯ���������ϢΪ��!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
     }
  }else if(tempArr.length>0)
  {
	if (errCode.equals("000000")){
	  bp_name=tempArr[0][2];	//��������
	  passwordFromSer=tempArr[0][3];//����
	}else{
		if(!retFlag.equals("1"))
	    {
	         retFlag = "1";
	         retMsg = "s1557barInit��ѯ���������Ϣʧ��!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
        }
	}
  }
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();
%>
<head>
<title>�����͸�����Ʒ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
 
<script language="JavaScript">
  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}%>
<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";	 	//����Ӫҵϵͳ������޸�

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  onload=function()
  {		
  }
  
  //***
  function frmCfm(){
	document.frm.action = "fbargain_2.jsp";
	document.frm.submit();
	return true;
  }
  //***//У���Ƿ�ѡ���콱��¼
  function checkIfSelect(){
	  var radio1 = document.getElementsByName("radio1");
	  var doc = document.forms[0];
	  var flag = 0;
	  for(var i=0; i<radio1.length; i++)
	  {
	      if(radio1[i].checked)
		  {
				if(eval("doc.flag"+radio1[i].value+".value")=="Y")
				{
					rdShowConfirmDialog("��Ʒ�Ѿ���ȡ��"); 
					return false;
				}
				document.frm.awardId.value=eval("doc.awardId"+radio1[i].value+".value");
				document.frm.flag.value=eval("doc.flag"+radio1[i].value+".value");
				document.frm.inTotal.value=eval("doc.inTotal"+radio1[i].value+".value");
				document.frm.payAccept.value=eval("doc.payAccept"+radio1[i].value+".value");

				flag=1;
				break;
		   }		   
	  }
	  if(flag==0)
	  {
	      rdShowConfirmDialog("��ѡ��һ������Ʒ��¼��"); 
		  return false;
	  }
	  return true;
  }

  
/******Ϊ��ע��ֵ********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "��Ʒ;"+document.frm.phoneNo.value+";"+document.frm.awardNo.value; 
	}
	return true;
}

function printCommit()
{ 
	getAfterPrompt();
	with(document.frm)
	{
	  if(awardNo.value=="")
	  {
	      rdShowMessageDialog("�����뽱Ʒ"); 
		  awardNo.focus();
		  return false;
	  }
	}
	if(!(checkIfSelect())) return false;
	setOpNote();//��ע��ֵ
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
//---------------------------------------------------
function printInfo(printType)
{
	var cust_info=""; //�ͻ���Ϣ
	var opr_info=""; //������Ϣ
	var note_info1=""; //��ע1
	var note_info2=""; //��ע2
	var note_info3=""; //��ע3
	var note_info4=""; //��ע4
	var retInfo = "";  //��ӡ����
	
	cust_info+="�ֻ����룺"+document.frm.phoneNo.value+"|";
	cust_info+="�ͻ�������"+document.frm.bp_name.value+"|";
	
    opr_info+="ҵ�����ͣ�"+"ǩԼ����Ʒ"+"|";
    opr_info+="��Ʒ��"+document.frm.awardInfo.value+"|";
    opr_info+="��ˮ��"+"<%=printAccept%>"+"|";
   
	note_info1+="��ע��"+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;
}
//-----------------------------------------------------
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
	var h=200;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var pType="subprint";                                     
	var billType="1";                                         
	var sysAccept=<%=printAccept%>;                           
	var printStr=printInfo(printType);                        
	var mode_code=null;                                        
	var fav_code=null;                                         
	var area_code=null;                                       
	var opCode="<%=opCode%>";                                
	var phoneNo=document.frm.phoneNo.value;                    
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;    
}
/**��ѯ��Ʒ**/
function getAwardInfo()
{ 
  	//���ù���js�õ���Ʒ
    var pageTitle = "��Ʒ�����ѯ";
    var fieldName = "��������|��������|";//����������ʾ���С�����
    //alert("regionCode="+regionCode);
   	var sqlStr ="select gift_code,gift_name from sBargainGiftCode where  gift_code = '"+document.frm.awardId.value+"' and region_code='"+document.frm.regionCode.value+"' order by gift_code";
	//alert(sqlStr); 
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";//�����ֶ�
    var retToField = "awardNo|awardInfo|";//���ظ�ֵ����
    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
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
//-->
</script>

</head>

<body>
<form name="frm" method="post">
<%@ include file="/npage/include/header.jsp" %>   
  	
	<div class="title">
		<div id="title_zi">�ͻ���Ϣ</div>
	</div>
	
	<table cellspacing="0">
	  <tr class="blue"> 
	    <td>�ֻ�����</td>
	    <td>
		    <input name="phoneNo" type="text" class="InputGrey" id="phoneNo" value="<%=phoneNo%>" readonly> 
	    <td class="blue">�ͻ�����</td>
	    <td>
		  <input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly> 
		</td>  
	  </tr>
	</table>
	    </div>
  <div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">��Ʒ��ϸ</div>
</div>
	<TABLE cellspacing="0">
	  <TBODY> 
	  <tr>
	      <th align="center">ѡ��</th>
		  <th align="center">��Ʒ���</th>
		  <th align="center">��ȡ��־</th>
		  <th align="center">��Ʒ����</th>
		  <th align="center">��������</th>
		  <th align="center">������ˮ</th>
	  </tr>
	  <% 
	     for(j=0;j<9;j++)
		 {
			 	if (j==4)//3
			   	tmpresult1=tempArr4;
				if (j==6)//5
			   	tmpresult2=tempArr6;
				if (j==5)//4
			   	tmpresult3=tempArr5;
				if (j==7)//6
			   	tmpresult4=tempArr7;
				if (j==8)//7
			   	tmpresult5=tempArr8;
		 }                                              
		 for(j=0;j<tmpresult1.length;j++)
		 {
	  %>
			  <tr>
			  	<td align=center><input type="radio"  name="radio1" value="<%=j%>"></td>
				<TD align=center><%=tmpresult1[j][0]%></TD>
				<TD align=center><%=tmpresult2[j][0]%></TD>
				<TD align=center><%=tmpresult3[j][0]%></TD>
				<TD align=center><%=tmpresult4[j][0]%></TD>
				<TD align=center><%=tmpresult5[j][0]%></TD>
				
				<input name="awardId<%=j%>" type="hidden" value="<%=tmpresult1[j][0]%>">
				<input name="flag<%=j%>" type="hidden" value="<%=tmpresult2[j][0]%>">
				<input name="inTotal<%=j%>" type="hidden" value="<%=tmpresult4[j][0]%>">
				<input name="payAccept<%=j%>" type="hidden" value="<%=tmpresult5[j][0]%>">
			  </tr>				
		<%}%>  		
	  </TBODY>
	</TABLE>		
	 </div>
 <div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">ҵ�����</div>
</div>	 	 
	<table cellspacing="0">
	    <tr> 
			<td class="blue">��Ʒ����</td>
			<td colspan="3">
				<input type="text" name="awardNo" size="8" maxlength="8" v_must=1>
		        <input type="text" name="awardInfo" size="30" v_must=1>&nbsp;&nbsp;
			    <font color="orange">*</font>
		        <input name=awardInfoQuery type=button class="b_text"  style="cursor:hand" onClick="if(checkIfSelect()) getAwardInfo()" value=��ѯ> 
		    </td>
	    </tr>
	    <tr class="blue"> 
			<td>��ע</td>
			<td colspan="3">
	           <input name="opNote" type="text" id="opNote" size="60" maxlength="60" onFocus="setOpNote();"> 
	        </td>
	    </tr>
		<tr> 
	       <td id="footer" colspan="4"> 
		        <div align="center"> 
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="ȷ��&��ӡ" onClick="printCommit()" >
				&nbsp;  
				<input name="reset" type="reset" class="b_foot" value="���" >
				&nbsp; 
				<input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
				&nbsp; 				
				</div>
		  </td>
	    </tr>
	</TABLE>    
 
  <input type="hidden" name="regionCode" value="<%=regionCode%>">
  <input type="hidden" name="awardId" value="">
  <input type="hidden" name="flag" value="">
  <input type="hidden" name="inTotal" value="">
  <input type="hidden" name="payAccept" value="">
  <input type="hidden" name="orgCode" value="<%=orgCode%>">
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
  <input type="hidden" name="opCode" value="<%=opCode%>">
  <input type="hidden" name="opName" value="<%=opName%>">
   <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

