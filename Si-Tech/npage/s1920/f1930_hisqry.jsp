<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2004-01-31
* revised : 2004-01-31
*/%>
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.01.15
 ģ��:������ϵ��ʷ��ѯ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>


<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������ϵ��ʷ��ѯ</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<%
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  	String phoneNo = request.getParameter("activePhone");
    
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
	String login_passwd = (String)session.getAttribute("password");
	String ip_address = (String)session.getAttribute("ipAddr");
	
%>
<script language=javascript>

<!--
//����Ӧ��ȫ�ֵı���
var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
var YE_SUCC_CODE = "000000";		//����Ӫҵϵͳ������޸�
var dynTbIndex=1;				//���ڶ�̬�����ݵ�����λ��,��ʼֵΪ1.���Ǳ�ͷ


onload=function()
{		
	
}

//---------1------RPC������------------------
function doProcess(packet){
	//ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
	var error_code = packet.data.findValueByName("errorCode");
	var error_msg =  packet.data.findValueByName("errorMsg");
	var verifyType = packet.data.findValueByName("verifyType");
	self.status="";
	if(verifyType=="phoneno"){
		if( parseInt(error_code) == 0 ){
			var custname= packet.data.findValueByName("custname");
			var runcode= packet.data.findValueByName("runcode");
			var brand=packet.data.findValueByName("brand");
			document.all.value201.value=custname;
			document.all.runname.value=runcode;
			document.form1.qryPage.disabled=false;
		}
		else{
			rdShowMessageDialog("<br>�������:["+error_code+"]</br>������Ϣ:["+error_msg+"]",0);
			return false;
		}
	}
	
}


function getUserInfo()
{
		if(document.form1.phoneNo.value.length<11 || isNumberString(document.form1.phoneNo.value,"1234567890")!=1) {
			rdShowMessageDialog("�������ֻ�����,����Ϊ11λ����!!");
			document.form1.phoneNo.focus();
			return false;
		}
		else if (parseInt(document.form1.phoneNo.value.substring(0,2),10)!=15 && parseInt(document.form1.phoneNo.value.substring(0,2),10)!=14 &&parseInt(document.form1.phoneNo.value.substring(0,2),10)!=18 &&parseInt(document.form1.phoneNo.value.substring(0,2),10)!=18 &&parseInt(document.form1.phoneNo.value.substring(0,2),10)!=14 &&(parseInt(document.form1.phoneNo.value.substring(0,3),10)<134 || parseInt(document.form1.phoneNo.value.substring(0,3),10)>139)){
			rdShowMessageDialog("������134-139,��15,14,18��ͷ���ֻ�����!!");
			document.form1.phoneNo.focus();
			return false;
		}
			
	  var myPacket = new AJAXPacket("f1920_rpc_check.jsp","����ȷ�ϣ����Ժ�......");
	
		myPacket.data.add("verifyType","phoneno");
		myPacket.data.add("phoneno",document.form1.phoneNo.value);
		myPacket.data.add("passwd","");
		    	    
		  core.ajax.sendPacket(myPacket);
		  myPacket=null;	  	
	  		
	}

//��֤���ύ����
function doCfm()
{ 
	if(!check(document.form1))
	{
		document.form1.phoneNo.value = "";
		return false;
	}
	form1.action="f1930_hisinfo.jsp";
	form1.submit();
}

function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
for (Count=0; Count < InString.length; Count++)  {
        TempChar= InString.substring (Count, Count+1);
        if (RefString.indexOf (TempChar, 0)==-1)  
        return (false);
}
return (true);
}

function getSpInfo(){
        var h=480;
        var w=773;
        var t=screen.availHeight/2-h/2;
        var l=screen.availWidth/2-w/2;
        var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
        var str=window.open('f1920_rpc_getSpCode.jsp?busytype='+document.all.busytype.value+'&phoneno='+document.all.phoneNo.value+'&optype=06&retToField=spCode|',"newwindow",prop);
        //document.form.spCode.value=str;
}
function getSpBizInfo(val){
        if(val.length<=0 ||val=="undefined"||val=="[object]"){
                rdShowMessageDialog("����ѡ����ҵ���룡",0);
                document.form1.spCode.value="";
                document.form1.spQuery.focus();
                return false;
        }
        var h=480;
        var w=773;
        var t=screen.availHeight/2-h/2;
        var l=screen.availWidth/2-w/2;
        var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
        var str=window.open('f1920_rpc_getSpBzCode.jsp?busytype='+document.all.busytype.value+'&phoneno='+document.all.phoneNo.value+'&optype=06&spcode='+val+'&retToField=spBizCode|',"",prop);
        if(str==""||str=="undefined"){
                rdShowMessageDialog("��ѡ��ҵ�������룡",0);
                document.form1.spBizCode.value="";
                document.form1.spBizQuery.focus();
                return false;
        }
        //document.form.spBizCode.value=str;
        
}
function getvalue2(retInfo,retToFieldBack)
	{		
			var retToField = retToFieldBack;
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
	
function getvalue(retInfo,retToFieldBack)
	{
	    var retToField = retToFieldBack;
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
	        
	        //����Ϊ�Զ������
	    }		
	}
//-->
</script>
</head>
<body>
<form name="form1" method="POST">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

   <table cellspacing="0">
    <tr>
	  	<td class="blue">
        <div align="right">ҵ������</div>
      </td>
      <td colspan="3">
        <div>
          <select name="busytype">
                  <option class="button" value="">��ѡ��ҵ�����</option>
                  <option class="button" value="al">����ҵ��</option>
                <wtc:qoption name="sPubSelect" outnum="2">
				<wtc:sql>select oprcode,oprname from oneboss.sOBBizType where regtype='0' order by oprcode asc</wtc:sql>
				</wtc:qoption>	
           </select>
        </div>
      </td>      
      
    </tr>
    <tr> 
      <td class="blue"><div align="right">�ֻ�����</div></td>
      <td colspan="3"> 
        <input type="text" name="phoneNo" value="<%=phoneNo%>" class="InputGrey" onKeyDown="if(event.keyCode==13)document.all.accountpassword.focus()" onKeyPress="return isKeyNumberdot(0)" readOnly>
      	<input type="button" class="b_text" name="query" value="��֤" onclick="getUserInfo()">
      </td>
    <tr> 
      <td class="blue"><div align="right">�û�����</div></td>
      <td>
        <input type="hidden" class="InputGrey" readonly name="code201" value="201">
        <input type="text"  readonly name="value201" value="" class="InputGrey">
      </td>
      <td class="blue"><div align="right">����״̬</div></td>
      <td>
        <input type="text" readonly name="runname" value="" class="InputGrey">
      </td>
    </tr> 
    <tr id="spinfo" style="">
      <td class="blue"><div align="right">SP��ҵ����</div></td>
      <td>
        <input type="text" name="spCode" value="" readonly class="InputGrey">
        <input type="button" name="spQuery" value="��ѯ" class="b_text" onclick="getSpInfo()">
      </td>
      <td class="blue"><div align="right">SPҵ�����</div></td>
      <td>
      	  <input type="text" name="spBizCode" value="" readonly class="InputGrey">
      	  <input type="button" name="spBipQuery" value="��ѯ" class="b_text" onclick="getSpBizInfo(document.form1.spCode.value)">
      </td>
    </tr>
    <tr>
      <td class="blue"><div align="right">��ʼ�·�</div></td>
      <td>
        <input type="text" name="begintime" value="" maxlength="6">(YYYYMM)
      </td>
      <td class="blue"><div align="right">�����·�</div></td>
      <td><input type="text" name="endtime" value="" maxlength="6">(YYYYMM)
      </td>
    </tr>
	<tr>
		<td colspan="4" id="footer">
		<div align="center">
		<input class="b_foot" type=button name=qryPage value="��ѯ" onClick="doCfm()" index="2" onKeyUp="if(event.keyCode==13){doCfm()}" disabled>
		<input class="b_foot" type=button name=back value="���" onClick="form1.reset()">
		<input class="b_foot" type=button name=qryPage1 value="�ر�" onClick="removeCurrentTab()">
		</div>
		</td>
    </tr>
  </table>
 
  <input name="org_code" type="hidden" value="<%=org_code%>">
  <input name="work_no" type="hidden" value="<%=work_no%>">
  <input name="login_passwd" type="hidden" value="<%=login_passwd%>">
  <input name="ip_address" type="hidden" value="<%=ip_address%>">
  <input name="loginName" type="hidden" value="<%=loginName%>">
   <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>