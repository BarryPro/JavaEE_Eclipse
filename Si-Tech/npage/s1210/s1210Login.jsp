<%
/********************
* ����: �ͻ����ϱ�� 1210
* version v3.0
* ������: si-tech
* update by qidp @ 2008-11-12
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%
request.setCharacterEncoding("GBK");
HashMap hm=new HashMap();
hm.put("1","û�пͻ�ID��");
hm.put("3","�������");
hm.put("4","�����Ѳ�ȷ���������ܽ����κβ�����");
hm.put("2","δȡ������1����˲����ݻ���ѯϵͳ����Ա��");
hm.put("10","δȡ������2����˲����ݻ���ѯϵͳ����Ա��");
hm.put("11","δȡ������3����˲����ݻ���ѯϵͳ����Ա��");
hm.put("12","δȡ������4����˲����ݻ���ѯϵͳ����Ա��");
hm.put("13","δȡ������5����˲����ݻ���ѯϵͳ����Ա��");
hm.put("14","δȡ������6����˲����ݻ���ѯϵͳ����Ա��");
%>

<%
    /* add by qidp @ 2009-08-13 for ���϶˵������� . */
    String regionCode = (String)session.getAttribute("regCode");
    String in_GrpId = request.getParameter("in_GrpId");
    String in_ChanceId = request.getParameter("in_ChanceId");
    String wa_no = request.getParameter("wa_no1");
    String openLabel = "";/*add by qidp.��ӱ�־λ��link���߶˵�������ͨ��������ƽ���˶���ģ�飻opcode�����߶˵������̣�ͨ��opcode�򿪴�ҳ�档*/
    String in_CustId = "";
    
    String accept = WtcUtil.repNull(request.getParameter("accept"));
    String oriPhoneNo = WtcUtil.repNull(request.getParameter("oriPhoneNo"));
    
    /* �жϽ����ģ��ķ�ʽ��������Ӧ�Ĵ���*/
    if(in_ChanceId != null){//������������ʱ���̻�����ض���Ϊ�ա�
        openLabel = "link";
    }else{
        in_GrpId = "";
        in_ChanceId = "";
        wa_no = "";
        openLabel = "opcode";
    }
    System.out.println("in_GrpId = "+in_GrpId); 
    if("link".equals(openLabel)){
        String ssql = "select cust_id from dbvipadm.dgrpcustmsg where unit_id = '"+in_GrpId+"'";
    %>
    	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode44" retmsg="retMsg44" outnum="1">
    		<wtc:sql><%=ssql%></wtc:sql>
    	</wtc:pubselect>
    	<wtc:array id="retVal44" scope="end"/>
    <%
        System.out.println("retCode="+retCode44); 
        if("000000".equals(retCode44) && retVal44.length > 0){
            in_CustId = retVal44[0][0];
        }
    }
    System.out.println("custId = "+in_CustId); 
    /* end by qidp @ 2009-08-13 for ���϶˵������� . */
%>

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
    <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
    <title>�ͻ����ϱ��</title>
        
<%											
    String opCode = (String)request.getParameter("opCode")==null?"1210":(String)request.getParameter("opCode");
    String opName = (String)request.getParameter("opName")==null?"�ͻ����ϱ��":(String)request.getParameter("opName");
String workNo=(String)session.getAttribute("workNo");
String userPhone=(String)request.getParameter("userPhoneNo");
boolean workNoFlag=false;
if(workNo.substring(0,1).equals("k"))
workNoFlag=true;

//ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
//String[][] baseInfoSession = (String[][])arrSession.get(0);
//String work_no = baseInfoSession[0][2];
//String loginName = baseInfoSession[0][3];
//String org_Code = baseInfoSession[0][16];
//String op_code = "1210";

//String work_no = (String)session.getAttribute("workNo");
//String loginName = (String)session.getAttribute("workName");
//String org_Code = (String)session.getAttribute("orgCode");

//----------------------------------------------------------
//String sqls="SELECT trim(id_Name)||'|'||id_type FROM sIdType order by id_type;";
//System.out.println("Sqls = " + sqls);
//SPubCallSvrImpl co=new SPubCallSvrImpl();
//String[][] metaData=co.fillSelect(sqls);
//System.out.println("metaData[0][9]="+metaData[0][9]);
  
  
  boolean hfrf=false;
  
	//2011/6/23 wanghfa��� ������Ȩ������ start
  boolean pwrf=false;
	String pubOpCode = opCode;
	String pubWorkNo = workNo;
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
	
<%
	System.out.println("====wanghfa====s1210Login.jsp------------------------------------------------------------==== pwrf = " + pwrf);
	//2011/6/23 wanghfa��� ������Ȩ������ end

String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
if(ReqPageName.equals("s1210Main"))
{
  String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));
%>
<script>
    rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");
</script>
<%
}
%>


<script language=javascript>

 var js_pwFlag="false";
 js_pwFlag="<%=pwrf%>";
	
	
function doReset(){
   location.reload();
document.all.qry_cond[2].checked=true;
}
//core.loadUnit("debug");
//core.loadUnit("rpccore");


onload=function()
{
	/*
		20120828 gaopeng ���� ���ͻ����ϱ������� 1210 �������ϱ�� �� g049 �������ϱ�� begin
	*/
	var reqopcode = "<%=opCode%>";
	if(reqopcode=="1210")
	{
		//���ؼ��ű�š����������
		$("input[name='qry_cond']").eq(4).next("span").hide();
		$("input[name='qry_cond']").eq(4).hide();
		$("input[name='qry_cond']").eq(5).next("span").hide();
		$("input[name='qry_cond']").eq(5).hide();
		
	}
	else if(reqopcode=="g049")
	{
		
		//���ؿͻ�ID���ͻ�֤����ԤԼ ID
		$("input[name='qry_cond']").eq(0).next("span").hide();
		$("input[name='qry_cond']").eq(0).hide();
		$("input[name='qry_cond']").eq(1).next("span").hide();
		$("input[name='qry_cond']").eq(1).hide();
		$("input[name='qry_cond']").eq(3).next("span").hide();
		$("input[name='qry_cond']").eq(3).hide();
		
	}
	/*
		20120828 gaopeng ���� ���ͻ����ϱ������� 1210 �������ϱ�� �� g049 �������ϱ�� end
	*/
//core.rpc.onreceive = doProcess;
self.status="";

//fillSelect();
document.all.qry_cond[2].checked=true;
document.all.booking.style.display="none";
document.all.identity.style.display="none";
document.all.unit.style.display="none"; //add by diling@2012/5/3 
document.all.vpmn.style.display="none"; //add by diling@2012/5/3 
/*��÷ 20070831 �޸� ������棬
<%
//if(workNoFlag)
//{
%>
document.all.qry_cond[0].disabled=true;
document.all.qry_cond[1].disabled=true;
document.all.phone_no.value="<%=userPhone%>";
document.all.phone_no.readOnly=true;
document.all.qryPage.focus();
getOneId();

<%
//}
//else
//{
%>
document.all.phone_no.focus();
<%
//}
%>
*/

/* add by qidp @ 2009-08-13 for ���϶˵������� . */
<% if("link".equals(openLabel)){ %>
    document.all.qry_cond[0].checked=true;
    chkId();
    document.all.qry_cond[1].disabled=true;
    document.all.qry_cond[2].disabled=true;
    
    document.all.cus_id.value="<%=in_CustId%>";
    document.all.cus_id.readOnly=true;
    $(document.all.cus_id).addClass("InputGrey");
<% } %>
/* end by qidp @ 2009-08-13 for ���϶˵������� . */
}

function doProcess(packet)
{
self.status="";
var cussid=packet.data.findValueByName("cussid");
	var phone_no_booking 	=packet.data.findValueByName("phone_no");
	var retcode				=packet.data.findValueByName("retcode");
	var retmsg				=packet.data.findValueByName("retmsg");
	if(document.all.qry_cond[3].checked)
	{
		document.all.cus_id.value = "";
		document.all.phone_no.value = "";
		if (phone_no_booking!="")
		{
			document.all.phone_no.value=phone_no_booking;
			document.all.cus_id.value=cussid;
		}
		else 
		{
			rdShowMessageDialog(retcode+":"+retmsg);
		}
	}
	else
	{
if(cussid!="")
{
document.all.cus_id.value=cussid;

}
else
{
rdShowMessageDialog("û�д˿ͻ���");
}
	}
}

//-------1--------��ѯϵ�к���----------------
function forMobilGh(obj)
{
	
	var patrn=/^((\(\d{3}\))|(\d{3}\-))?[12][03458]\d{9}$/;
	var sInput = obj.value;
	if(sInput.substring(0,3)=="451"||sInput.substring(0,3)=="046"||sInput.substring(0,3)=="045"){
		 var sInput1 = sInput.substring(3,sInput.length);
		 var patrn1=/^[0-9]{8}$/;
		 
		 if(sInput1.search(patrn1)==-1){
		 	showTip(obj,"�̻���ʽ����ȷ��");
			return false;
		 }else{
		 	hiddenTip(obj);
		 	return true;
		}
	}
	
	if(sInput.search(patrn)==-1){
		showTip(obj,"��ʽ����ȷ��");
		return false;
	}
	hiddenTip(obj);
	return true;
	
}
//ͨ���������õ��ͻ�ID
function getOneId()
{
if(((document.all.phone_no.value).trim()).length<1)
{
rdShowMessageDialog("�ֻ����벻��Ϊ�գ�");
return;
}

if (!checkServiceId()){
		return;
}

if(!forMobilGh(document.all.phone_no)) return;
var myPacket = new AJAXPacket("qryCus_id.jsp","���ڲ�ѯ�ͻ�ID�����Ժ�......");
myPacket.data.add("phoneNo",(document.all.phone_no.value).trim());
core.ajax.sendPacket(myPacket);
myPacket = null;
}
/*add by diling@2012/5/3 */
/*ͨ�����ű�Ż�ȡ�ͻ�id*/
function getOneId_unit(){
  if(((document.all.unitNo.value).trim()).length<1)
  {
    rdShowMessageDialog("���ű�Ų���Ϊ�գ�");
    return;
  }
  var myPacket = new AJAXPacket("qryCustidByUnitNo.jsp","���ڲ�ѯ�ͻ�ID�����Ժ�......");
  myPacket.data.add("unitNo",(document.all.unitNo.value).trim());
  core.ajax.sendPacket(myPacket);
  myPacket = null;
}

/*ͨ��vpmn�����ȡ�ͻ�id*/
function getOneId_vpmn(){
  if(((document.all.vpmnNo.value).trim()).length<1)
  {
    rdShowMessageDialog("���ű�Ų���Ϊ�գ�");
    return;
  }else{
    var pageTitle = "���Ų�ѯ";
    var fieldName = "���ű��|�ͻ�ID|��������|���ŵ�ַ|����������|"; 
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "unitId|cus_id|";

		var sqlStr = "90000111";
    var params = document.all.vpmnNo.value+"|";
    
  	PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params);
  }
  
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params)
{
	var theFirstRetToField=retToField;
    /*
    ����1(pageTitle)����ѯҳ�����
    ����2(fieldName)�����������ƣ���'|'�ָ��Ĵ�
    ����3(sqlStr)��sql���
    ����4(selType)������1 rediobutton 2 checkbox
    ����5(retQuence)����������Ϣ������������� �������ʶ����'|'�ָ�����"3|0|2|3"��ʾ����3����0��2��3
    ����6(retToField))������ֵ����������,��'|'�ָ�
    ע�⣺sql��У�飬��ֹsqlע��
    ʹ��window.openʵ���´��ڵĴ򿪣�����opener����Ч.
    ��ͨ��opener.arg4.values=''��ֵ
    */
    var path = "../../npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+ "&params=" + params; 
    retInfo = window.showModalDialog(path);
    if(typeof(retInfo)=="undefined")      
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
/*end add by diling*/
function getOneId_booking()
{
if(((document.all.booking_id.value).trim()).length<1)
{
rdShowMessageDialog("ԤԼID����Ϊ�գ�");
return;
}
var myPacket = new AJAXPacket("qryCustidByBookId.jsp","���ڲ�ѯ�ͻ�ID�����Ժ�......");
myPacket.data.add("booking_id",(document.all.booking_id.value).trim());
core.ajax.sendPacket(myPacket);
myPacket = null;
}
function getAllId_No(){
if(((document.all.id_no.value).trim()).length<1)
{
rdShowMessageDialog("֤�����벻��Ϊ�գ�");
return;
}

if(((document.all.id_type.value).trim())=="0")
{
if(forIdCard(document.all.id_no)==false)
return false;
}

var h=400;
var w=500;
var t=screen.availHeight/2-h/2;
var l=screen.availWidth/2-w/2;
var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
var ret=window.showModalDialog("AllId_No.jsp?id_no="+(document.all.id_no.value).trim()+"&id_type=" +document.all.id_type.value,"",prop);


if(typeof(ret)!="undefined")
{
document.all.cus_id.value=ret;
document.all.cus_pass.value="";
}
else
{
rdShowMessageDialog("������ѡ��һ���ͻ�ID��");
document.all.id_no.select();
document.all.id_no.focus();
}
}

function chkId()
{
if(self.status!="")
{
rdShowMessageDialog("������֤��Ϣ�����Ժ�");
return;
}

if(document.all.qry_cond[0].checked)
{
document.all.identity.style.display="none";
document.all.phone.style.display="none";
document.all.cus_id.value="";
document.all.cus_id.focus();
document.all.booking.style.display="none";
document.all.unit.style.display="none"; //add by diling@2012/5/3 
document.all.vpmn.style.display="none"; //add by diling@2012/5/3 
}
else if(document.all.qry_cond[1].checked)
{
document.all.identity.style.display="";
document.all.id_no.value="";
document.all.cus_id.value="";
document.all.id_no.focus();
document.all.phone.style.display="none";
document.all.booking.style.display="none";
document.all.unit.style.display="none"; //add by diling@2012/5/3 
document.all.vpmn.style.display="none"; //add by diling@2012/5/3 
}
else if(document.all.qry_cond[2].checked)
{
    document.all.identity.style.display="none";
    document.all.phone.style.display="";
    document.all.phone_no.value="";
    document.all.cus_id.value="";
    document.all.phone_no.focus();
    document.all.booking.style.display="none";
    document.all.qryId_No2.style.display = "";
    document.all.unit.style.display="none"; //add by diling@2012/5/3 
    document.all.vpmn.style.display="none"; //add by diling@2012/5/3 
}
else if(document.all.qry_cond[3].checked)
{
    document.all.identity.style.display="none";
    document.all.phone.style.display="";
    document.all.phone_no.value="";
    document.all.cus_id.value="";
    document.all.booking.style.display="block";
    document.all.qryId_No2.style.display = "none";
    document.all.unit.style.display="none"; //add by diling@2012/5/3 
    document.all.vpmn.style.display="none"; //add by diling@2012/5/3 
}
/*begin add by diling for �������Ӽ��ſͻ�ҵ���������ĺ���BOSS���ֵ�һ����@2012/5/3 */
else if(document.all.qry_cond[4].checked)
{
  document.all.identity.style.display="none";
  document.all.phone.style.display="none";
  document.all.cus_id.value="";
  document.all.booking.style.display="none";
  document.all.vpmn.style.display="none";
  document.all.unit.style.display="";
  document.all.unitNo.value="";
  document.all.qryId_unit.style.display = "";
}
else if(document.all.qry_cond[5].checked)
{
  document.all.identity.style.display="none";
  document.all.phone.style.display="none";
  document.all.booking.style.display="none";
  document.all.unit.style.display="none";
  document.all.vpmn.style.display="";
  document.all.vpmnNo.value="";
  document.all.qryId_vpmn.style.display = "";
  
}
/*end add by diling @2012/5/3 */
}

//-------2---------��֤���ύ����-----------------
function 	checkCustId(){
		var opCode = '<%=opCode%>';
		if (opCode != '1210'){
				return true;
		}
		
		if (!$($("input[name='qry_cond']")[0]).is(":checked")){
				return true;
		}
		
		if ((document.all.cus_id.value).trim() == ''){
				rdShowMessageDialog('�ͻ�ID����Ϊ�գ�', 1 );
				return false; 
		}
		
		var t = false;
		var packet = new AJAXPacket("checkIdNo.jsp","���ڲ�ѯ�ͻ�ID�����Ժ�......");
		packet.data.add("custId",(document.all.cus_id.value).trim());
		
		core.ajax.sendPacket(packet, function(packet){
      		var retCode = packet.data.findValueByName("retCode");
      		var retMsg = packet.data.findValueByName("retMsg");
      		
      		if (retCode != '000000'){
							$('#submitBtn').attr('disabled', 'true');
							rdShowMessageDialog("����ҳ��ʧ�ܣ�����ϵ������Ա��" + retCode + " " + retMsg , 1);
							return;
					}
      	
          var result = packet.data.findValueByName("result");
          
          if (result[0][0] == '1'){
          		t = true;
          } else {
          		rdShowMessageDialog('����ʹ�ü���ID���ͥID��ѯ��', 1 );
          		document.all.cus_id.value = "";
          }
      });
		packet = null;
		
		return t;
}

function doCfm()
{
	
if(self.status!="")
{
    rdShowMessageDialog("���ڲ�ѯ��Ϣ�����Ժ�");
    return false;
}

if (!checkCustId()){
		return false;
}

//if(js_pwFlag=="false")
//{
   if(document.all.cus_pass.value.length==0)
   {
     rdShowMessageDialog("�ͻ����벻��Ϊ�գ�");
	 document.all.cus_pass.focus();
     return false;
   }
//}

if(check(s3216) && checkServiceId())
{
    if(document.all.identity.style.display!="none")
    {
        if(document.all.id_type.options[document.all.id_type.options.selectedIndex].text=="���֤")
        {
            if(document.all.id_no.value.length==0)
            {
                rdShowMessageDialog("���֤�������󣡳��Ȳ��ԣ�");
                document.all.id_no.focus();
                return false;
            }

            if(forIdCard(document.all.id_no)==false)
            {
                document.all.id_no.value="";
                document.all.id_no.focus();
                return;
            }
        }
    }

    //if(document.all.qry_cond[2].checked){
    //    document.all.phone_no.value = "";
    //}
    s3216.action="s1210Main.jsp";
    s3216.submit();
}
}


//zhouby add to check gorup/personal service id 
function checkServiceId(){
		if (!$($("input[name='qry_cond']")[2]).is(":checked")){
				return true;
		}
	
		var opCode = '<%=opCode%>';
		var reg, msg_;
		if (opCode == '1210'){
				reg = /^[^2]{1}.*/;
				msg_ = '����������2��ͷ�ĺ��룡';
		} else if (opCode == 'g049'){
				reg = /^2{1}.*/;
				msg_ = 'ֻ��������2��ͷ�ĺ��룡';
		}

		var value = $.trim($('#phone_no').val());
		var result = reg.test(value);
		if (!result){
				rdShowMessageDialog(msg_, 1);
		}
		return result;
}



function clearID()
{
document.all.id_no.value="";
document.all.id_no.focus();
}

</script>
</head>
<body>

<form name="s3216" method="POST"  onKeyUp="chgFocus(s3216)">
<input type="hidden" name="accept" value="<%=accept%>"/>
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
<div id="title_zi">�û���Ϣ</div>
</div>
<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
<table cellspacing="0" align="center">
<tr>
    <td width="16%" class="blue">��ѯ����</td>
    <td colspan="3" class="blue" width="84%">
		 	<input type="radio" name="qry_cond" id="qry_cond" value="0" onclick="chkId()" index="0"><span>�ͻ�ID</span></input>
		 	<input type="radio" name="qry_cond" id="qry_cond" value="1" onclick="chkId()" index="1"><span>�ͻ�֤��</span></input>
		  <input type="radio" name="qry_cond" id="qry_cond" value="2" onClick="chkId()" index="2" checked>�������</input>
		  <input type="radio" name="qry_cond" id="qry_cond" value="3" onClick="chkId()" index="3" ><span>ԤԼID</span></input>
		  <input type="radio" name="qry_cond" id="qry_cond" value="4" onClick="chkId()" index="4" ><span>���ű��</span></input>
			<input type="radio" name="qry_cond" id="qry_cond" value="5" onClick="chkId()" index="5" ><span>���������</span></input>     
    </td>
</tr>
<tr id="identity">
    <td width="16%" class="blue">֤������</td>
    <td>
        <select name="id_type" id="id_type" onchange="clearID()" index="3">
            <wtc:qoption name="sPubSelect" outnum="11">
				<wtc:sql>select trim(ID_TYPE),ID_NAME from sIdType order by id_type</wtc:sql>
		    </wtc:qoption>         
        </select>
    </td>
    <td width="16%" class="blue">֤������</td>
    <td width="40%">
        <input type="text" size="18" name="id_no" id="id_no" maxlength="18" index="4" onkeyup="if(event.keyCode==13)getAllId_No()">
        <font class="orange">*</font>
        <input class="b_text" type="button" name="qryId_No" value="��ѯ" onClick="getAllId_No()">
    </td>
</tr>
<tr id="booking">
    <td width="16%" class="blue">ԤԼID</td>
    <td colspan="3">
        <input type="text" size="15"  name="booking_id" id="booking_id"  maxlength="16" onkeyup="if(event.keyCode==13)getBookingId()" index="5" >
        <font class="orange">*</font>
        <input class="b_text" type="button" name="qryBooking_No2"  id = "qryBooking_No2" value="��ѯ" onClick="getOneId_booking()">
    </td>
</tr>
<tr id="phone">
    <td width="16%" class="blue">�������</td>
    <td colspan="3">
        <input type="text" size="11"  name="phone_no" id="phone_no" value="<%=oriPhoneNo%>"  maxlength="11" onkeyup="if(event.keyCode==13)getOneId()" index="5" >
        <font class="orange">*</font>
        <input class="b_text" type="button" name="qryId_No2" value="��ѯ" onClick="getOneId()">
    </td>
</tr>
<%/*** begin �������ű�ţ���������Ų�ѯ���� by diling@2012/5/3  ***/%>
<tr id="unit">
    <td width="16%" class="blue">���ű��</td>
    <td colspan="3">
        <input type="text" size="11"  name="unitNo" id="unitNo" v_type="0_9"  maxlength="10" onkeyup="if(event.keyCode==13)getOneId()" index="5" >
        <font class="orange">*</font>
        <input class="b_text" type="button" name="qryId_unit" value="��ѯ" onClick="getOneId_unit()">
    </td>
</tr>
<tr id="vpmn">
    <td width="16%" class="blue">���������</td>
    <td colspan="3">
        <input type="text" size="11"  name="vpmnNo" id="vpmnNo"  maxlength="11" onkeyup="if(event.keyCode==13)getOneId()" index="5" >
        <font class="orange">*</font>
        <input class="b_text" type="button" name="qryId_vpmn" value="��ѯ" onClick="getOneId_vpmn()">
        <input type="hidden" name="unitId" value="" />
    </td>
</tr>
<%/*** end by diling@2012/5/3  ***/%>
<tr>
    <td width="16%" class="blue">�ͻ�ID</td>
    <td class=Input width="28%" >
        <input type="text" size="17" name="cus_id" id="cus_id" v_minlength=1 v_maxlength=22 v_type=int  maxlength="22" index="6">

    </td>
       <td  class="blue" width="16%"> 
          �ͻ�����
        </td>
        <td  width="40%"> 
         <jsp:include page="/npage/common/pwd_one.jsp">
	      <jsp:param name="width1" value="16%"  />
	      <jsp:param name="width2" value="34%"  />
	      <jsp:param name="pname" value="cus_pass"  />
	      <jsp:param name="pwd" value="12345"  />
        </jsp:include>
            </td>
            </tr>
        </table>
        <table cellspacing="0">
            <tbody>
                <tr>
                    <td id="footer">
                        <input class="b_foot" type=button name=qryPage id=qryPage value="ȷ��" onmouseup="doCfm()" onkeyup="if(event.keyCode==13)doCfm()" index="8">
                        <input class="b_foot" type=button name=back value="���" onClick="doReset()"  >
                        <input class="b_foot" type=button name=close value="�ر�" onClick="parent.removeTab('<%=opCode%>')"  >
                    </td>
                </tr>
            </tbody>
        </table>
        
        <input type="hidden" name="in_ChanceId" id="in_ChanceId" value="<%=in_ChanceId%>" />
        <input type="hidden" name="wa_no" id="wa_no" value="<%=wa_no%>" />
        <!--20120828 gaopeng ���������� opcode �� opname -->
        <input type="hidden" name="vopcode" value="<%=opCode%>"/>
        <input type="hidden" name="vopname" value="<%=opName%>"/>
      <%@ include file="/npage/include/footer_simple.jsp" %>
        </form>
    </body>
</html>  
