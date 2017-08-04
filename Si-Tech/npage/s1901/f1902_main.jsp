<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2000.01.13
 ģ�飺���ź�ͬЭ��¼��
********************/
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
	
	String opCode = "1902";
	String opName = "���ź�ͬЭ��¼��";
    Logger logger = Logger.getLogger("f1902_main.jsp");
    String printAccept = "";
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String Department = (String)session.getAttribute("orgCode");
    String belongCode = Department.substring(0,7);
    String regionCode = Department.substring(0,2);
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String getAcceptFlag = "";
    String op_name="���ź�ͬЭ��¼��";
%>

<head>
<title>���ź�ͬ¼��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
</head>

<SCRIPT type=text/javascript>

onload=function(){
        document.frm1902.iccid.focus();
}

function doProcess(packet)
{
    //RPC������findValueByName
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    var retMessage = packet.data.findValueByName("retMessage");
    self.status="";
    if((retCode).trim()=="")
    {
       rdShowMessageDialog("����"+retType+"����ʱʧ�ܣ�");
       return false;
    }
    //---------------------------------------
    if(retType == "ConCustInfo")
    {
        //�ʻ�����ʱ�ͻ���Ϣ��ѯ
        var retname = packet.data.findValueByName("retname");
        if(retCode=="000000")
        {
			document.frm1902.cust_id.value = oneTok(retname,"|",1);
			document.frm1902.unit_id.value = oneTok(retname,"|",2);
			document.frm1902.cust_name.value = oneTok(retname,"|",3);
			document.frm1902.unit_name.value = oneTok(retname,"|",4);
			document.frm1902.contract_name.focus();
        }
        else
        {
            retMessage = retMessage + "[errorCode1:" + retCode + "]";
            rdShowMessageDialog(retMessage,0);
			return false;
        }       
     }
    //---------------------------------------
    if(retType == "ConUnitInfo")
    {
        //������Ϣ��ѯ
        var retname = packet.data.findValueByName("retname");
        if(retCode=="000000")
        {
			document.frm1902.cust_id.value = oneTok(retname,"|",1);
			document.frm1902.unit_id.value = oneTok(retname,"|",2);
			document.frm1902.cust_name.value = oneTok(retname,"|",3);
			document.frm1902.unit_name.value = oneTok(retname,"|",4);
			document.frm1902.contract_name.focus();
        }
        else
        {
            retMessage = retMessage + "[errorCode1:" + retCode + "]";
            rdShowMessageDialog(retMessage,0);
			return false;
        }       
     }
}

//���ù������棬���м��ſͻ�ѡ��
function getInfo_Cust()
{
    var pageTitle = "���ſͻ�ѡ��";
    var fieldName = "֤������|�ͻ�ID|�ͻ�����|����ID|��������|";
	var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "5|0|1|2|3|4|";
    var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|";

    var cust_id = document.frm1902.cust_id.value;

    if(document.frm1902.iccid.value == "" &&
       document.frm1902.cust_id.value == "" &&
       document.frm1902.unit_id.value == "")
    {
        rdShowMessageDialog("������֤�����롢�ͻ�ID����ID���в�ѯ��",0);
        document.frm1902.iccid.focus();
        return false;
    }

    if(document.frm1902.cust_id.value != "" && forNonNegInt(frm1902.cust_id) == false)
    {
    	frm1902.cust_id.value = "";
        rdShowMessageDialog("���������֣�",0);
    	return false;
    }

    if(document.frm1902.unit_id.value != "" && forNonNegInt(frm1902.unit_id) == false)
    {
    	frm1902.unit_id.value = "";
        rdShowMessageDialog("���������֣�",0);
    	return false;
    }

    if(PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s1901/fpubcust_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&iccid=" + document.frm1902.iccid.value;
    path = path + "&cust_id=" + document.frm1902.cust_id.value;
    path = path + "&unit_id=" + document.frm1902.unit_id.value

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
  var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|";;
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
}

//���ݿͻ�ID��ѯ�ͻ���Ϣ
function getInfo_CustId()
{
    var cust_id = document.frm1902.cust_id.value;

    //���ݿͻ�ID�õ������Ϣ
    if(document.frm1902.cust_id.value == "")
    {
        rdShowMessageDialog("������ͻ�ID��",0);
        return false;
    }
    if(forNonNegInt(frm1902.cust_id) == false)
    {	
    	frm1902.cust_id.value = "";
        rdShowMessageDialog("�ͻ�ID���������֣�",0);
    	return false;	
    }

    var getInfoPacket = new AJAXPacket("f1902_Infoqry.jsp","���ڻ�ü��ſͻ���Ϣ�����Ժ�......");
        var cust_id = document.frm1902.cust_id.value;
        getInfoPacket.data.add("region_code","<%=regionCode%>");
        getInfoPacket.data.add("retType","ConCustInfo");
        getInfoPacket.data.add("cust_id",cust_id);
        core.ajax.sendPacket(getInfoPacket);
        getInfoPacket=null; 
}
//���ݿͻ�ID��ѯ�ͻ���Ϣ
function getInfo_UnitId()
{
    var unit_id = document.frm1902.unit_id.value;

    if(document.frm1902.unit_id.value == "")
    {
        rdShowMessageDialog("���������뼯��ID��",0);
        return false;
    }
    if(forNonNegInt(frm1902.unit_id) == false)
    {
    	frm1902.unit_id.value = "";
        rdShowMessageDialog("����ID���������֣�",0);
    	return false;	
    }

    var getInfoPacket = new AJAXPacket("f1902_Infoqry.jsp","���ڻ�ü��ſͻ���Ϣ�����Ժ�......");
        var cust_id = document.frm1902.cust_id.value;
        getInfoPacket.data.add("region_code","<%=regionCode%>");
        getInfoPacket.data.add("retType","ConUnitInfo");
        getInfoPacket.data.add("unit_id",unit_id);
        core.ajax.sendPacket(getInfoPacket);
        getInfoPacket=null; 
}
//------------------------------------
function printCommit()
{
		getAfterPrompt();
        if((frm1902.deal_time.value != ""))
        {
            if(forDate(frm1902.deal_time) == false)
            {   return false;       }
        }

        if((frm1902.complete_time.value != ""))
        {
            if(forDate(frm1902.complete_time) == false)
            {   return false;       }
        }

        if((frm1902.logout_time.value != ""))
        {
            if(forDate(frm1902.logout_time) == false)
            {   return false;       }
        }

        var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());

        if(check(frm1902))
        {
            if((document.frm1902.opNote.value).trim().length==0)
            {
              document.frm1902.opNote.value="����Ա<%=workNo%>"+"��("+(document.frm1902.contract_name.value).trim()+")��ͬ¼�롣"
            }
            showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
        }
}
//-------------------------------------------------------
function printInfo(printType)
{
    var retInfo = "";
    if(printType == "Detail")
    {   //��ӡ�������
<%
        //ȡ�ô�ӡ��ˮ
        try
        {
                //String sqlStr ="select sMaxSysAccept.nextval from dual";
                //retArray = callView.sPubSelect("1",sqlStr);
%>
				<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=%>"  id="printAcceptWtc"/>
<%
                printAccept = printAcceptWtc;
        }catch(Exception e){
                out.println("rdShowMessageDialog('ȡϵͳ������ˮʧ�ܣ�',0);");
                getAcceptFlag = "failed";
        }
%>
        var getAcceptFlag = "<%=getAcceptFlag%>";
        if(getAcceptFlag == "failed")
        {   return "failed";    }

        //��ӡ�������
        var cust_info=""; //�ͻ���Ϣ
		var opr_info=""; //������Ϣ
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
		
		cust_info+="�ͻ�������"+document.frm1902.cust_name.value+"|";
		cust_info+="֤�����룺"+document.frm1902.iccid.value+"|";
		
		opr_info+="�������ƣ�"+document.frm1902.unit_name.value+"|";
		opr_info+="��ͬ���ƣ�"+document.frm1902.contract_name.value+"|";
		opr_info+="ҵ�����ͣ����ź�ͬ¼��"+"|";
    	opr_info+="��ˮ��"+<%=printAccept%>+"|";
    	
    	note_info1+="��ע��"+document.frm1902.opNote.value+"|";
    	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    }
    if(printType == "Bill")
    {   //��ӡ��Ʊ
    }
    return retInfo;
}
//-----------------------------------------------------------
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
	 var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var pType="print";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
   var billType="1";                                          //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
   var sysAccept="<%=printAccept%>";                          // ��ˮ��
   var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
   var mode_code=null;                                        //�ʷѴ���
   var fav_code=null;                                         //�ط�����
   var area_code=null;                                        //С������
   var opCode="<%=opCode%>";                                  //��������
   var phoneNo="";                   						  //�ͻ��绰

   if(printStr == "failed")
   {    return false;   }
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);

   //if(typeof(ret)!="undefined")
   {
     //if((ret=="confirm")&&(submitCfm == "Yes"))
     {
       if(rdShowConfirmDialog("ȷ��Ҫ�ύ���ź�ͬ¼����Ϣ��")==1)
       {
           frm1902.action="f1902_2.jsp";
           frm1902.submit();
       }
     }
   }
}
//---------------------------------------------------
function jspReset()
{
    //ҳ��ؼ���ʼ��
    var obj = null;
    var t = null;
    var i;
    for (i=0;i<document.frm1902.length;i++)
    {
        obj = document.frm1902.elements[i];
        packUp(obj);
        obj.disabled = false;
    }
    document.frm1902.commit.disabled = "none";
}
//----------------------------------------------------
function jspCommit()
{
     //ҳ���ύ
     document.frm1902.commit.disabled = "none";
     action="f1902_2.jsp"
     frm1902.submit();   //����������������ύ
}
//------------------------------------------------
//----��ͬ¼��----
function showtbs1()
{
	document.all.font1.color='222222';
	frm1.style.display="";
	document.all.font2.color='999999';
	frm2.style.display="none";
}
//---Э��¼��---
function showtbs2()
{
	document.all.font1.color='999999';
	frm1.style.display="none";
	document.all.font2.color='222222';
	frm2.style.display="";
}
//----֤�������ѯ----
function queryIccid2()
{
	if(document.form2.IccidValeus.value=="")
	{
		rdShowMessageDialog("֤�����벻��Ϊ��!");
		return;	
	}
	var path = "<%=request.getContextPath()%>/npage/s1901/f1902_query.jsp?formtype=form2&IccidValeus="+document.form2.IccidValeus.value;
    window.open(path,'_blank','height=600,width=600,scrollbars=yes');
}


function doChange2()
{
	if(document.form2.QryFlag.value=="0")
	{
		tbs4.style.display="";
		tbs6.style.display="none";
		document.form2.QryValues.v_type="0_9";
		document.form2.QryValues.v_name="�ͻ����";
		document.form2.QryValues.value="";
		document.form2.QryValues.maxLength="18";
		document.form2.IccidValeus.value="";
		document.form2.IccidValeus.disabled=true;
		document.form2.queryIccid.disabled=true;
		
	}
	else if(document.form2.QryFlag.value=="1")
	{
		tbs4.style.display="";
		tbs6.style.display="none";	
		document.form2.QryValues.v_type="0_9";
		document.form2.QryValues.v_name="�ͻ����";
		document.form2.QryValues.value="";
		document.form2.QryValues.maxLength="18";
		document.form2.IccidValeus.disabled=false;
		document.form2.queryIccid.disabled=false;
	}
	else 
	{
		tbs4.style.display="none";
		tbs6.style.display="";	
		document.form2.QryValues.v_type="0_9";
		document.form2.QryValues.v_name="���ű��";
		document.form2.QryValues.value="";
		document.form2.QryValues.maxLength="18";
		document.form2.IccidValeus.value="";
		document.form2.IccidValeus.disabled=true;
		document.form2.queryIccid.disabled=true;
	}
}

function showList2()
{
	getAfterPrompt();
	if(!checkElement(document.all.QryValues2))
	{
		return;
	}
	document.form2.action="<%=request.getContextPath()%>/npage/s1901/f1902_list.jsp";
	document.form2.target="listFrame";	
	document.form2.submit();
	parent.document.body.rows="268,*";
}

</SCRIPT>

<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">
	
	
 
			<%@ include file="/npage/include/header.jsp" %>   
        <div id=frm1 style=display="">
      	
		<FORM method=post name="frm1902" action="f1902_2.jsp"  onKeyUp="chgFocus(frm1902)">
  	
			<div class="title">
				<div id="title_zi">���ź�ͬ¼��</div>
			</div>
			<TABLE cellSpacing="0" style="display:none">
        	<tr>
              	<TD nowrap><a id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="f1902_1.jsp" value="1" target="_parent">&nbsp;&nbsp;<font id="font1" color='orange'><b>���ź�ͬ¼��</b>&nbsp;&nbsp;</font></a></TD>            
			  	<TD nowrap><a id="tabhead2" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs2()" value="1">&nbsp;&nbsp;<font id="font2" color='orange'><b>����Э��¼��</b>&nbsp;&nbsp;</font></a></TD>
            	<td width="80%">&nbsp;</td> 
            </tr>   
        	</table>
        	
      	  <input type="hidden" name="ReqPageName" value="f1902_1">
  		  <input type="hidden" name="workno" value=<%=workNo%>>
  		  <input type="hidden" name="regionCode" value=<%=regionCode%>>
  		  <input type="hidden" name="unitCode" value=<%=Department%>>
  		  <input type="hidden" name="belongCode" value=<%=belongCode%>>
  		  <input type="hidden" name="ip_Addr" value=<%=ip_Addr%>>
  		  <input type="hidden" name="loginAccept" value="<%=printAccept%>">
      	 
      	        <TABLE cellSpacing="0">
      	          <TBODY>
      	          <TR>
      	            <TD class="blue">
      	              <div align="left">֤������</div>
      	            </TD>
      	            <TD>
					    <input name=iccid class="button" id="iccid" size="24" maxlength="18" v_type="string" v_must=1 v_name="֤������" index="1">
      	              <input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=��ѯ>
      	              <font color="orange">*</font>
      	            </TD>
      	            <TD class="blue">
      	              <div align="left">���ſͻ�ID</div>
      	            </TD>
      	            <TD>
					    <input name=cust_id class="button" id="cust_id" size="24" maxlength="14" v_type="0_9" v_must=1 v_name="�ͻ�ID" index="2">
      	              <font color="orange">*</font>
      	            </TD>
      	          </TR>
      	
      	          <TR>
      	            <TD class="blue">
      	              <div align="left">����ID</div>
      	            </TD>
      	            <TD>
					    <input name=unit_id class="button" id="unit_id" size="24" maxlength="10" v_type="0_9" v_must=1 v_name="����ID" index="3">
						<!-- 
      	              <input name=unitQuery type=button class="button" onMouseUp="getInfo_UnitId();" onKeyUp="if(event.keyCode==13)getInfo_UnitId();" style="cursor:hand" id="unitQuery3" value=��ѯ>
						 -->
      	              <font color="orange">*</font>
					  </TD>
      	            <TD class="blue">
      	              <div align="left">���ſͻ�����</div>
      	            </TD>
      	            <TD>
      	              <input name=cust_name class="button" id="cust_name" size=32 maxlength="60" readonly v_must=1 v_type="string" v_name="�ͻ�����" v_maxlength=60 index="4">
      	              <font color="orange">*</font>
      	            </TD>
      	          </TR>
      	
      	          <tr>
      	            <TD class="blue">
      	              <div align="left">��������</div>
      	            </TD>
      	            <TD>
      	              <font color="orange">
      	              <input name=unit_name class="button" id="unit_name" size=32 maxlength="60" readonly v_must=1 v_type="string" v_name="��������" v_maxlength=60 index="4">
      	              *</font> </TD>
      	
      	            <td class="blue">
      	              <div align="left">��ͬ����</div>
      	            </td>
      	            <td><font color="orange">
      	              <input name=contract_name class="button" id="contract_name" size=32 maxlength="60" v_must=1 v_type="string" v_name="��ͬ����" v_maxlength=60 index="5">
      	              *</font>
      	            </td>
      	            </tr>
      	          <tr>
      	            <td class="blue">��ͬ״̬</td>
      	            <td>
      	            	<select name=contract_status id="contract_status" align="left" width=50 v_must=1 v_type="string" index="6">
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select Contract_Status, ContractStat_Name from sGrpContractStatusCode</wtc:sql>
							</wtc:qoption>
      	            	</select>
      	              <font color="orange">*</font> </td>
      	            <TD class="blue">
      	              <div align="left">��������</div>
      	            </TD>
      	            <TD class="blue">
      	              <input name=deal_time id="deal_time" size=10 maxlength="8" onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>" v_must=1 v_type="date" v_format="yyyyMMdd" v_maxlength=8 index="7">
      	              <font color="orange">*</font> </TD>
      	          </tr>
      	          <TR>
      	            <TD class="blue">
      	              <div align="left">��������</div>
      	            </TD>
      	            <!-- wuxy alter 20090508 ���������д������������������ -->
      	            <TD>
      	              <input name=complete_time class="button" id="complete_time" size=10 maxlength="8"  onKeyPress="return isKeyNumberdot(0)" v_must=0 v_type="date" v_format="yyyyMMdd" v_name="��������" v_maxlength=8 index="8">
      	            </TD>
      	            <!-- wuxy alter 20090508 ���������д������������������ -->
      	            <TD class="blue">
      	              <div align="left">ע������</div>
      	            </TD>
      	            <TD>
      	              <input name=logout_time class="button" id="logout_time" size=10 maxlength="8" onKeyPress="return isKeyNumberdot(0)" v_must=0 v_type="date"  v_format="yyyyMMdd" v_name="ע������" v_maxlength=8 index="9">
      	            </TD>
      	          </TR>
      	          <TR>
      	            <TD class="blue">
      	              <div align="left">�����</div>
      	            </TD>
      	            <TD>
      	              <input name=deal_address class="button" id="deal_address" size=30 maxlength="40" v_must=0 v_type="string" v_name="�����" v_maxlength=60 index="10">
      	            </TD>
      	            <TD class="blue">
      	              <div align="left">��Ŀ����</div>
      	            </TD>
      	            <TD> <input name=item_manager class="button" id="item_manager" size=20 maxlength="20" v_must=0 v_type="string" v_name="��Ŀ����" v_max_length=20 index="11">
      	            </TD>
      	          </TR>
      	          <TR>
      	            <TD class="blue">
      	              <div align="left">��ͬ����</div>
      	            </TD>
      	            <TD colspan="3">
      	              <input name=contract_desc class="button" id="contract_desc" size=60 maxlength="60" v_must=0 v_maxlength=60 v_type="string" v_name="��ͬ����" index="12">
      	            </TD>
      	          </TR>
      	          <TR  style="display:none">
      	            <TD class="blue">
      	              <div align="left">������ע</div>
      	            </TD>
      	            <TD colspan="3">
      	              <input name=opNote class="button" id="opNote" size=60 maxlength="60" v_must=0 v_maxlength=60 v_type="string" v_name="������ע" index="13">
      	            </TD>
      	          </TR>
      	 	    </TBODY>
      	 	  </TABLE>
      	 	  <TABLE cellSpacing="0">
      	 	    <TBODY>
      	 	      <TR>
      	 	            <TD id="footer" align=center>
      	 	              <input class="b_foot" name=print  onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()"  type=button value=ȷ��&��ӡ  index="39">
      	 	              <input class="b_foot" name=reset1 onClick="" type=reset value=��� index="40">
      	 	              <input class="b_foot" name=back type=button onClick="parent.parent.removeTab('<%=opCode%>');" value=�ر� index="41">
      	 	            </TD>
      	 	      </TR>
      	 	    </TBODY>
      	 	  </TABLE>    
      	  
 		  </form>
	
		</div>
		
		<div id=frm2 style="display:none">
   			
			<form name="form2"  method="get">
  	
				<div class="title">
					<div id="title_zi">����Э��¼��</div>
				</div>
				<TABLE cellSpacing="0">
        	<tr>
              	<TD nowrap><a id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="f1902_1.jsp" value="1" target="_parent">&nbsp;&nbsp;<font id="font1" color='orange'><b>���ź�ͬ¼��</b>&nbsp;&nbsp;</font></a></TD>            
			  	<TD nowrap><a id="tabhead2" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs2()" value="1">&nbsp;&nbsp;<font id="font2" color='orange'><b>����Э��¼��</b>&nbsp;&nbsp;</font></a></TD>
            	<td width="80%"></td> 
            </tr>   
        	</table>
					  <TABLE id="mainOne" cellspacing="0">
			          <TBODY>
			            <TR id="line_1"> 
							<TD class="blue">��ѯ����</TD>
		            		<TD>
		            			<select name="QryFlag" onchange="doChange2()">
		            				<option value="0">���ͻ���Ų�ѯ</option>
		            				<option value="1">��֤�������ѯ</option>
		            				<option value="2">�����ű�Ų�ѯ</option>
		            			</select>
		            		</TD>
		            		<TD class="blue">
							֤������
							</TD>
		            		<TD class="blue">
		            		  	<input type=text v_type="idcard" v_must=0  id="IccidValeus2" name="IccidValeus" maxlength=18 disabled>
		            		  	<input name="queryIccid" type="button" class="b_text" value="��ѯ" onClick="queryIccid2()" disabled>
		            			
		            		</TD> 
			            </TR>
			            <tr>
			            	<TD class="blue">
		            			<div id=tbs4 style=display="">
								�ͻ����
								</div>
								<div id=tbs6 style="display:none">
								���ű��
								</div>
		            		</TD> 
			            	<TD colspan="3">
		            		  	<input type=text v_type="string" v_must=1 id="QryValues2" name="QryValues" maxlength=18>
		            		</TD> 
			        	</tr>
			          </TBODY>
			        </TABLE> 
			        <TABLE  cellSpacing="0">
						<TR> 
				         	<TD id="footer" align="center"> 
				         	    <input name="queryButton" type="button" class="b_foot" value="��ѯ" onClick="showList2()" >
						 	</TD>
				       	</TR>
				    </TABLE>
				
			</form>
			
			</div>
				 <%@ include file="/npage/include/footer.jsp" %>   
  

 <script language="JavaScript">
    document.frm1902.iccid.focus();
 </script>
</body>
</html>
