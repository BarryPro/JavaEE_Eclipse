<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.01.15
 ģ��:Ԥ�滰�������-����
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
 
<%		
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  
%>
<%
String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
/************************���ƶ�����õ����롢���������Ȼ�����Ϣ s1292_Valid*******************************************/
  String[] paraAray1 = new String[2];
  String phoneNo = request.getParameter("srv_no");
  String passwordFromSer = "";  
  
  paraAray1[0] = phoneNo;		/* �ֻ�����   */
  paraAray1[1] = loginNo; 	/* ��������   */ 

  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  
  //String[] ret = impl.callService("s1292_Valid",paraAray1,"9","phone",phoneNo);
%>
	<wtc:service name="s1292_Valid" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="9">			
	<wtc:param value="<%=paraAray1[0]%>"/>	
	<wtc:param value="<%=paraAray1[1]%>"/>	
	</wtc:service>	
	<wtc:array id="result1"  scope="end"/>
<%
  String errCode;
  String errMsg;
  String bp_name="";
  errCode = retCode1;
  errMsg = retMsg1;
  if(result1.length==0)
  {
	 if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s1292_Valid��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    } 
  }else if(result1.length>0)
  {
	if (errCode.equals("000000")){
      bp_name = result1[0][5];//��������
	  passwordFromSer = result1[0][6];//����
	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
		   retMsg = "s1292_Valid��ѯ���������Ϣ����!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
		} 
	}
  }

//******************�õ�����������***************************//
  //�û�����
  String sqlTypeCode = "SELECT type_code||'~'||battery_fee, type_code||'->'||type_name FROM sBattUserCode a,sBattFeeCode b                  WHERE a.battery_fee_code=b.fee_code order by a.type_code ";
  //ArrayList typeCodeArr = co.spubqry32("2",sqlTypeCode);
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:sql><%=sqlTypeCode%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="typeCodeStrTemp" scope="end" />
<%
  String[][] typeCodeStr = typeCodeStrTemp;
  //��Ʒ����
  String sqlBatteryCode = " SELECT battery_code,battery_code||'->'||battery_name FROM sBattCode order by battery_code";
  //ArrayList batteryCodeArr = co.spubqry32("2",sqlBatteryCode);
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode3" retmsg="retMsg3" outnum="2">
	<wtc:sql><%=sqlBatteryCode%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="batteryCodeStrTemp" scope="end" />
<%
  String[][] batteryCodeStr = batteryCodeStrTemp;
  
  
  //�û���Ϣ
  String sqlInfo = "select b.id_iccid,b.id_address,c.sm_name  from dcustmsg a, dcustdoc b ,ssmcode c where a.phone_no='"+phoneNo+"' and a.cust_id=b.cust_id and  a.sm_code=c.sm_code and c.region_code=substr(a.belong_code,1,2) ";
  String[] inParams = new String[2];
  inParams[0] = "select b.id_iccid,b.id_address,c.sm_name  from dcustmsg a, dcustdoc b ,ssmcode c where a.phone_no=:phoneNo and a.cust_id=b.cust_id and  a.sm_code=c.sm_code and c.region_code=substr(a.belong_code,1,2) ";
  inParams[1] = "phoneNo=" + phoneNo;
 
  //ArrayList infoCodeArr = co.spubqry32("3",sqlInfo);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode4" retmsg="retMsg4" outnum="3">			
	<wtc:param value="<%=inParams[0]%>"/>
	<wtc:param value="<%=inParams[1]%>"/>	
	</wtc:service>	
	<wtc:array id="infoCodeStrTemp"  scope="end"/>
<%
  String[][] infoCodeStr = infoCodeStrTemp;		
  String id_iccid= infoCodeStr[0][0];
  String id_address= infoCodeStr[0][1];
  String sm_name= infoCodeStr[0][2];

  
  /****�õ���ӡ��ˮ****/
  String printAccept="";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=phoneNo%>"  id="seq"/>
<%
  printAccept = seq;
%>
<html  xmlns="http://www.w3.org/1999/xhtml">
<html>
<head>
<title>Ԥ�滰�������-����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
 
<script language="JavaScript">
<!--
  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>",0);
    history.go(-1);
  <%}%>
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  var arrBatteryCode = new Array();//��Ʒ���ʹ���
  var arrBatteryName = new Array();//��Ʒ��������
  var selectStatus = 0;
    
  
  onload=function()
  {		
  }  
 
<%  
  for(int i=0;i<batteryCodeStr.length;i++)
  {
	out.println("arrBatteryCode["+i+"]='"+batteryCodeStr[i][0]+"';\n");
	out.println("arrBatteryName["+i+"]='"+batteryCodeStr[i][1]+"';\n");
  }  
%>
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }	
  //***
  function printCommit(){
  	getAfterPrompt();
    //У��
    if(!checkElement(document.all.phoneNo)) return false;
	if(!checkElement(document.all.prepay_fee)) return false;
	if(!checkElement(document.all.invoice_accept)) return false;
	with(document.frm){
	  if(prepay_fee.value==""){
	    rdShowMessageDialog("������Ԥ�滰��!");
        prepay_fee.focus();
		return false;
	  }
	  if(type_code.value==""){
	    rdShowMessageDialog("��ѡ���û�����!");
        type_code.focus();
		return false;
	  }
	  if(battery_code.value==""){
	    rdShowMessageDialog("��ѡ����Ʒ����!");
        battery_code.focus();
		return false;
	  }
	  if(invoice_work.value==""){
	    rdShowMessageDialog("�����뷢Ʊ����!");
        invoice_work.focus();
		return false;
	  }
	  if(invoice_accept.value==""){
	    rdShowMessageDialog("�����뷢Ʊ��ˮ��!");
        invoice_accept.focus();
		return false;
	  }
      if((prepay_fee.value <  800.00   && type_code_value.value=="01") || (prepay_fee.value < 300.00  && type_code_value.value=="02") || (prepay_fee.value < 500.00  && type_code_value.value=="03") || (prepay_fee.value < 800.00  && type_code_value.value=="04" ) ||(prepay_fee.value < 300.00  && type_code_value.value=="05") || (prepay_fee.value < 500.00  && type_code_value.value=="06"))
	  {
	    rdShowMessageDialog("�������Ԥ�滰�ѻ���Ԥ�����û����Ͳ���,����������!");
        prepay_fee.focus();
		return false;
	  }
	}
	
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
	var billType="1";                                          // Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept="<%=printAccept%>"                           // ��ˮ��
	var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
	var mode_code=null;                                        //�ʷѴ���
	var fav_code=null;                                         //�ط�����
	var area_code=null;                                        //С������
	var opCode="1292";                                         //��������
	var phoneNo="<%=phoneNo%>";                                //�ͻ��绰
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}

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
	cust_info+="�ͻ�������" +document.frm.bp_name.value+"|";
	cust_info+="�ͻ���ַ��"+'<%=id_address%>'+"|";
    cust_info+="֤�����룺"+'<%=id_iccid%>'+"|";
    
	opr_info+="�û�Ʒ�ƣ�"+'<%=sm_name%>'+"  ����ҵ��: Ԥ�滰�������"+"  ������ˮ��"+"<%=printAccept%>"+"|";
	opr_info+="�û����ͣ�"+document.frm.type_code.options[document.frm.type_code.selectedIndex].text+"|";
	opr_info+="��Ʒ���ͣ�"+document.frm.battery_code.options[document.frm.battery_code.selectedIndex].text+"|";
      
    note_info1+="��ע��"+"|";
    
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;
}

//�ֽ��ַ���
   function oneTokSelf(str,tok,loc)
  {
    var temStr=str;
	var temLoc;
	var temLen;
    for(ii=0;ii<loc-1;ii++)
	{
       temLen=temStr.length;
       temLoc=temStr.indexOf(tok);
       temStr=temStr.substring(temLoc+1,temLen);
 	}
	if(temStr.indexOf(tok)==-1)
	  return temStr;
	else
      return temStr.substring(0,temStr.indexOf(tok));
  }		
//-->
</script>

<script language="JavaScript">
<!--
/****************����type_code��̬����battery_code������************************/
 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
   var strValue = document.frm.type_code.value;
   var typeCodeValue = oneTokSelf(strValue,"~",1);
   var batteryFee = oneTokSelf(strValue,"~",2);
   document.frm.type_code_value.value = typeCodeValue;
   document.frm.battery_fee.value = batteryFee;

   var myEle ;
   var x ;  
   var leng =control.value.length;
   var typeCode = document.frm.type_code_value.value;
   var tempSelectStatus ;
   if(typeCode>'08'){
	 tempSelectStatus = 1;
	 if(tempSelectStatus==selectStatus) return false;
	 selectStatus = 1;
	 // Empty the second drop down box of any choices
     for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
     // ADD Default Choice - in case there are no values
     myEle = document.createElement("option") ;
     for ( x = 0 ; x < ItemArray.length  ; x++ )
     {
      if ( ItemArray[x].indexOf("��")>-1 )
      {
          myEle = document.createElement("option") ;
          myEle.value = arrBatteryCode[x] ;
          myEle.text = ItemArray[x] ;
          controlToPopulate.add(myEle) ;
       }
	  }
   }else{
     tempSelectStatus = 2;
	 if(tempSelectStatus==selectStatus) return false;
	 selectStatus = 2;
	 // Empty the second drop down box of any choices
     for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
     // ADD Default Choice - in case there are no values
     myEle = document.createElement("option") ;
	 for ( x = 0 ; x < ItemArray.length  ; x++ )
	 {
	   myEle = document.createElement("option") ;
       myEle.value = arrBatteryCode[x] ;
       myEle.text = ItemArray[x] ;
       controlToPopulate.add(myEle) ;
	 }
   } 
 }
//-->
</script>
</head>

<body>
<form name="frm" method="post" action="f1292_confirm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>   
  	
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>

    <table cellspacing="0">
	  <tr> 
        <td class="blue">��������</td>
        <td colspan="3">����</td>
      </tr>
      <tr> 
        <td class="blue">�ֻ�����</td>
        <td>
		  <input name="phoneNo" type="text" class="InputGrey" id="phoneNo" maxlength="11" index="1" v_must=1 v_type="mobphone" v_minlength=11  value="<%=phoneNo%>" readonly>
        </td>
        <td class="blue">��������</td>
        <td>
		  <input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>	
		</td>
      </tr>
      <tr> 
        <td class="blue">�û�����</td>
        <td>
		  <SELECT id="type_code" name="type_code"  onchange="selectChange(this, battery_code, arrBatteryName, null);" >
		    <option value]="">--��ѡ��--</option>
            <%for(int i = 0 ; i < typeCodeStr.length ; i ++){%>
            <option value="<%=typeCodeStr[i][0]%>"><%=typeCodeStr[i][1]%></option>
            <%}%>
          </select>
		  <font color="orange">*</font>
		</td>
        <td class="blue">��Ʒ����</td>
        <td>
		  <select size=1 name="battery_code" id="battery_code"  >			  
          </select>
		  <font color="orange">*</font>
		</td>  
      </tr>
      <tr> 
        <td class="blue">��Ʒ���</td>
        <td >
		  <input name="battery_fee" type="text" class="InputGrey" id="battery_fee" readonly>	
		</td>
        <td class="blue">Ԥ�滰�ѽ��</td>
        <td>
		  <input name="prepay_fee" type="text" id="prepay_fee" v_type="money">
		  <font color="orange">*</font>
		</td>
      </tr>
      <tr> 
        <td class="blue">��Ʊ��������</td>
        <td >
		  <input name="invoice_date"  type="text" id="invoice_date" v_must=1 v_type="date" onKeyPress="return isKeyNumberdot(0)" maxlength="8">
		  <font color="orange">*</font>yyyymmdd
		</td>
        <td class="blue">��Ʊ����</td>
        <td>
		  <input name="invoice_work" type="text" id="invoice_work" maxlength="6">	
		  <font color="orange">*</font>
		</td>
      </tr>  
	   <tr> 
        <td class="blue">��Ʊ��ˮ</td>
        <td colspan="3">
		  <input name="invoice_accept"  type="text" id="invoice_accept" v_type="0_9" v_must=1   v_name="��Ʊ��ˮ" onKeyPress="return isKeyNumberdot(0)" maxlength="14">
		  <font color="orange">*</font>
		</td>
      </tr>
      <tr> 
        <td class="blue">��ע</td>
        <td colspan="3">
         <input name="opNote" type="text" class="InputGrey" id="opNote" size="60" maxlength="60" value=<%="" + phoneNo + ",Ԥ�������-����"%> > 
        </td>
      </tr>
	  <tr> 
        <td class="blue">˵��</td>
        <td colspan="3" height="32">��Ϊģ��������ں���ǰ��������: 04519000001
        </td>
      </tr>
      <tr> 
        <td colspan="4" id="footer"> <div align="center"> 
            <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()">
            &nbsp; 
            <input name="reset" type="reset" class="b_foot" value="���">
            &nbsp; 
            <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
            &nbsp; </div></td>
      </tr>
    </table>

  <input type="hidden" name="type_code_value" ><!-- �û����� -->
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
   <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>


