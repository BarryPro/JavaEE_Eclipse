<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.24
 ģ��: �����ʷѴ�������
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

	
<%
  	response.setDateHeader("Expires", 0);
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%		
  
	String opCode  =request.getParameter("opCode");
	String opName  =request.getParameter("opName");
	
	String regionCode = (String)session.getAttribute("regCode");
	String regionName = "";
	String loginNo=(String)session.getAttribute("workNo");
	String[] inParams = new String[2];
	inParams[0] = "select region_name from sregioncode where region_code=:regionCode";
	inParams[1] = "regionCode="+regionCode;
	
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>	
	</wtc:service>	
	<wtc:array id="regionNameOut"  scope="end"/>
<%
    if(regionNameOut.length>0)
    	regionName = regionNameOut[0][0];  
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�����ʷѴ�������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

 
<script language="JavaScript">
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
	frm.action="f5025Cfm.jsp";
 	frm.submit();
	return true;
  }
  //***//У��
  function check(){
    var  iOpType = document.frm.opType.value;
	with(document.frm)
	{
	  if(iOpType=="0")//����
	  {
		  if(mode_code.value==""){
			rdShowMessageDialog("��ѡ���ʷѴ���!");
			mode_code.focus();
			return false;
		  }
		  if(next_mode_code.value==""){
			rdShowMessageDialog("�����뵽���ʷѴ���!");
			next_mode_code.focus();
			return false;
		  }
	  }else if(iOpType=="1")//ɾ��
	  {
		  if(mode_code.value==""){
			rdShowMessageDialog("��ѡ���ʷѴ���!");
			mode_code.focus();
			return false;
		  }
		  if(next_mode_code.value==""){
			rdShowMessageDialog("�����뵽���ʷѴ���!");
			next_mode_code.focus();
			return false;
		  }
	  }else if(iOpType=="2")//�޸�
	  {
		  if(mode_code.value==""){
			rdShowMessageDialog("��ѡ���ʷѴ���!");
			mode_code.focus();
			return false;
		  }
		  if(next_mode_code.value==""){
			rdShowMessageDialog("�����뵽���ʷѴ���!");
			next_mode_code.focus();
			return false;
		  }
		  if(new_next_mode_code.value==""){
			rdShowMessageDialog("�������µ����ʷѴ���!");
			new_next_mode_code.focus();
			return false;
		  }
	  }
	}
	return true;
  }

  function printCommit(){
  	getAfterPrompt();
	document.frm.confirm.disabled = true;
	//У��
	if(!check())
	{
	    document.frm.confirm.disabled = false;
		return false;
	}
	setOpNote();
    //�ύ��
    frmCfm();	
	return true;
  }

/**��ѯ�ʷѴ���**/
function getModeCode()
{ 
  	//���ù���js�õ����д���
    var pageTitle = "�ʷѴ����ѯ";
    var	iOpType = document.frm.opType.value;
	if(iOpType=="0")
	{    
	    var fieldName = "�ʷѴ���|�ʷ�����|Ʒ�ƴ���|";//����������ʾ���С�����
		var sqlStr ="select a.mode_code,a.mode_name,a.sm_code from sBillModeCode a,sBillModeDetail b where a.region_code=b.region_code and a.mode_code=b.mode_code and b.mode_time='Y' and b.time_flag='1' and a.region_code='<%=regionCode%>' and a.mode_flag='0' and a.mode_code like '" + codeChg("%"+(document.all.mode_code.value).trim()+"%") + "' and a.mode_name like '" + codeChg("%"+(document.all.mode_name.value).trim()+"%") + "' order by a.mode_code" ;
		//	alert(sqlStr); 
	    var selType = "S";    //'S'��ѡ��'M'��ѡ
	    var retQuence = "3|0|1|2|";//�����ֶ�
	    var retToField = "mode_code|mode_name|sm_code|";//���ظ�ֵ����
	}
	else
	{
	    var fieldName = "�ʷѴ���|�ʷ�����|Ʒ�ƴ���|���ڴ���|��������|";//����������ʾ���С�����
		var sqlStr ="select a.mode_code,a.mode_name,a.sm_code,c.next_mode,d.mode_name from sBillModeCode a,sBillModeMature c,sBillModeCode d where a.region_code=c.region_code and a.mode_code=c.mode_code and a.region_code=d.region_code and c.next_mode=d.mode_code and a.region_code='<%=regionCode%>' and a.mode_flag='0' and a.mode_code like '" + codeChg("%"+(document.all.mode_code.value)+"%").trim() + "' and a.mode_name like '" + codeChg("%"+(document.all.mode_name.value).trim()+"%") + "' order by a.mode_code" ;
		//alert(sqlStr);
	    var selType = "S";    //'S'��ѡ��'M'��ѡ
	    var retQuence = "5|0|1|2|3|4|";//�����ֶ�
	    var retToField = "mode_code|mode_name|sm_code|next_mode_code|next_mode_name|";//���ظ�ֵ����
	}   
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

/**��ѯ�����ʷѴ���**/
function getNextModeCode()
{ 
	var	iOpType = document.frm.opType.value;
    var	sqlStr="";
	with(document.frm)
	{
	  if(iOpType=="0")//����
	  {
		sqlStr ="select '" + (document.all.mode_code.value).trim()+ "',mode_code,mode_name,'Y' from sBillModeCode where region_code='<%=regionCode%>'  and mode_code like '" + codeChg("%"+(document.all.next_mode_code.value).trim()+"%") + "' and sm_code='"+(document.all.sm_code.value).trim()+"' and mode_code!='"+(document.all.mode_code.value).trim()+"' and mode_flag='0' order by mode_code" ;
	  	//alert(sqlStr);
	  }
	  else
	  {
		sqlStr ="select a.mode_code,a.next_mode,b.mode_name,a.use_flag from sBillModeMature a, sBillModeCode b where a.region_code=b.region_code and a.next_mode=b.mode_code and  a.region_code='<%=regionCode%>'  and  a.mode_code like '" + codeChg("%"+(document.all.mode_code.value).trim()+"%") + "' and a.next_mode like '" + codeChg("%"+(document.all.next_mode_code.value).trim()+"%") + "' order by a.mode_code,a.next_mode" ;
	  }
	}
  	//���ù���js�õ����д���
    var pageTitle = "�����ʷѴ����ѯ";
    var fieldName = "��ǰ�ʷ�|�����ʷ�|�����ʷ�����|��Ч��־|";//����������ʾ���С�����
	
	//alert(sqlStr); 
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|1|2|";//�����ֶ�
    var retToField = "next_mode_code|next_mode_name|";//���ظ�ֵ����
    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
/**��ѯ���ʷѴ���**/
function getNewNextModeCode()
{ 
  	//���ù���js�õ����д���
    var pageTitle = "�ʷѴ����ѯ";
    var fieldName = "�ʷѴ���|�ʷ�����|";//����������ʾ���С�����
	var sqlStr ="select a.mode_code,a.mode_name from sBillModeCode a,sBillModeDetail b where a.region_code=b.region_code and a.mode_code=b.mode_code and b.time_flag='0' and b.mode_time='Y' and a.region_code='<%=regionCode%>'  and a.mode_code like '" + codeChg("%"+(document.all.new_next_mode_code.value).trim()+"%") + "' and a.mode_name like '" + codeChg("%"+(document.all.new_next_mode_name.value).trim()+"%") + "' and a.sm_code='"+(document.all.sm_code.value).trim()+"' and a.mode_code!='"+codeChg(document.all.mode_code.value).trim()+"' and a.mode_code!='"+codeChg(document.all.next_mode_code.value).trim()+"' and a.mode_flag='0' order by mode_code" ;
		//alert(sqlStr); 
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";//�����ֶ�
    var retToField = "new_next_mode_code|new_next_mode_name|";//���ظ�ֵ����
    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel_m.jsp";
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
/****��opCode��̬�ı�����ؼ���״̬*****/
function controlObj()
{
	var opType = document.frm.opType.value;
    if(opType=="0")//����
	{
	    document.all.newFlagCodeTd.style.display="none";
		document.all.newFlagCodeTextTd.style.display="none";
		document.all.useFlagTd.colSpan="3";
	}else if(opType=="1")//ɾ��
	{
	    document.all.newFlagCodeTd.style.display="none";
		document.all.newFlagCodeTextTd.style.display="none";
		document.all.useFlagTd.colSpan="3";
	}else if(opType=="2")//�޸�
	{
	    document.all.newFlagCodeTd.style.display="";
		document.all.newFlagCodeTextTd.style.display="";
		document.all.useFlagTd.colSpan="1";
	}
	return true;
}
/****����Դ��js/common/common_check.js******/
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
/******Ϊ��ע��ֵ********/
function setOpNote(){
	var opType = document.frm.opType.value;
	if(opType=="0")
		document.frm.op_note.value = "���� "+(document.all.login_no.value).trim()+" ���������ʷѴ��룺"+(document.all.mode_code.value).trim()+"->"+(document.all.next_mode_code.value).trim();
	else if(opType=="1")
		document.frm.op_note.value = "���� "+(document.all.login_no.value).trim()+" ɾ�������ʷѴ��룺"+(document.all.mode_code.value).trim()+"->"+(document.all.next_mode_code.value).trim();
	else if(opType=="2")
		document.frm.op_note.value = "���� "+(document.all.login_no.value).trim()+" �޸� "+(document.all.mode_code.value).trim()+" �����ʷѴ���:"+(document.all.next_mode_code.value).trim()+"��Ϊ"+(document.all.new_next_mode_code.value).trim();
	return true;
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
		
      <table id="mainOne" cellspacing="0">
		  <tr> 
            <td class="blue">��������</td>
            <td>
                <select name="opType" id="opType" onChange="controlObj();">
				   <option value="0">���� </option>
				   <option value="1">ɾ�� </option>
				   <option value="2">�޸� </option>
			  	</select>	
				<font color="orange">*</font>
            </td>
            <td class="blue">���д���</td>
            <td>
			  <input name="region_code_1" type="text" class="InputGrey" id="region_code_1" value='<%=regionCode+"--"+regionName%>' readonly> 
			  <input type="hidden" class="button" name="sm_code" size="25" v_must=1 v_name=ԭ�ʷ�Ʒ��  onclick="">
			  <input type="hidden" class="button" name="login_no" size="25" v_must=1 v_name=���� value="<%=loginNo%>">
			</td>  
          </tr>
          <tr> 
		    <td class="blue">��ǰ�ʷ�</td>
            <td>
			  <input type="text"  name="mode_code" size="8" maxlength="8" v_must=1  onclick="">
			  <input type="text"  name="mode_name" size="25" v_must=1 onclick=""> 
			  <font color="orange">*</font>
			  <input name=modeCodeQuery type=button class="b_text"  style="cursor:hand" onClick="getModeCode()" value=��ѯ>
			</td>
            <td class="blue">�����ʷ�</td>
            <td>
			  <input type="text"  name="next_mode_code" size="8" maxlength="8" v_must=1  onclick="">
			  <input type="text"  name="next_mode_name" size="25" v_must=1 onclick="">
			  <font color="orange">*</font>
			  <input name=nextModeCodeQuery type=button class="b_text"  style="cursor:hand" onClick="getNextModeCode()" value=��ѯ>
			</td>   			
          </tr>
		  <tr> 		    
			<td class="blue">��Ч��־</td>
            <td  id="useFlagTd" colspan="3">
                <select name="useFlag" id="useFlag" class="button" >
				   <option value="Y">��</option>
				   <option value="N">��</option>
			  	</select>	
				<font color="orange">*</font>
            </td> 
            <td id="newFlagCodeTextTd" style="display:none" class="blue">�µ����ʷ�</td>
            <td id="newFlagCodeTd" style="display:none">
			  <input type="text"  name="new_next_mode_code" size="8" maxlength="8" v_must=1  onclick="">
			  <input type="text"  name="new_next_mode_name" size="25" v_must=1  onclick=""> 
			  <font color="orange">*</font>
			  <input name=newNextModeCodeQuery type=button class="b_text"  style="cursor:hand" onClick="getNewNextModeCode()" value=��ѯ>
			</td> 
          </tr>
		  <tr> 
            <td class="blue">��ע</td>
            <td colspan="4">
             <input name="op_note" type="text" class="InputGrey" readOnly id="op_note" size="60" maxlength="60" onFocus="setOpNote();"> 
            </td>
          </tr>
		  <tr> 
            <td colspan="4" id="footer"> <div align="center"> 
                &nbsp; 
				<input name="confirm" id="confirm" type="button" class="b_foot"   value="ȷ��" onClick="printCommit()">
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="���" >
                &nbsp; 
                <input name="close" onClick="removeCurrentTab()" type="button" class="b_foot" value="�ر�">
                &nbsp; 
				
				</div>
			</td>
          </tr>
      </table>
 <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>

