<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>������Ϣ��ѯ</TITLE>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String opCode = "5082";
	String opName = "������Ϣ��ѯ";
%>
</HEAD>

<body>
<SCRIPT language="JavaScript">
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params,wtcOutNum)
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
    var path = "../../npage/public/fPubSimpSel_n1.jsp";
    path = path + "?sqlStr=" + sqlStr+ "&params=" + params+ "&wtcOutNum=" + wtcOutNum + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
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
function doCheck()
{	
	if(document.frm.condText.value=="")
	{	
		rdShowMessageDialog("�������ѯ������");
		document.frm.condText.select();
		return false;
	}
	else
	{
	    var pageTitle = "���Ų�ѯ";
	    var fieldName = "���ű��|��������|���ŵ�ַ|�ͻ�ID|VPMN����|"; 
	    var selType = "S";    //'S'��ѡ��'M'��ѡ
	    var retQuence = "2|0|1|";
	    var retToField = "unitId|";
		
		var param = "";
		var sqlStr = "";
		var wtcOutNum = "";
		    
		var sqlStr="select unit_id, unit_name, unit_addr, cust_id, boss_vpmn_code from dCustDocOrgAdd where ";
		if (document.frm.queryType.value=="0")
		{
			document.frm.unitId.value=document.frm.condText.value;
			window.location="fo001_ajax_queryGrpCust.jsp?unitId=" + document.frm.unitId.value;
		}
		if (document.frm.queryType.value=="1")
		{
			
			sqlStr += "unit_name like '%" + document.frm.condText.value + "%'";
			
			
			sqlStr = "51";	
			params = "condText=%"+document.frm.condText.value+"%";
			wtcOutNum = "5";
			
			PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params,wtcOutNum);

			if (document.frm.unitId.value!="")
				window.location="fo001_ajax_queryGrpCust.jsp?unitId=" + document.frm.unitId.value;
		}
		if (document.frm.queryType.value=="3")
		{
			window.location="fo001_dCustGrp.jsp?phoneNo=" + document.frm.condText.value;
		}
		if (document.frm.queryType.value=="4")
		{
			var sqlStr2="SELECT unit_id, unit_name, unit_addr, a.cust_id, boss_vpmn_code FROM dCustDocOrgAdd a, dcustdoc b WHERE a.cust_id=b.cust_id AND b.id_iccid = '"+document.frm.condText.value+"'";
			
			
			sqlStr = "52";	
			params = "condText="+document.frm.condText.value;
			wtcOutNum = "5";
			
			PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params,wtcOutNum);
			
			if (document.frm.unitId.value!="")
				window.location="fo001_ajax_queryGrpCust.jsp?unitId=" + document.frm.unitId.value;
		}
		
	}
	return true;
}
onload=function()
{
	document.all.condText.focus();
}



</SCRIPT>
 
<FORM method=post name="frm" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">������Ϣ��ѯ</div>
</div>
	<TABLE cellSpacing=0>
        <TR> 
          <td class='blue' nowrap>��ѯ����</TD>
          <TD>
           <select name=queryType>
              <option value="0">���ű��</option>
              <option value="1">��������</option>
              <option value="4">֤������</option>
            </select> 
		  </TD>
          <td class='blue' nowrap>������Ϣ</TD>
          <TD>
          	<input type="text" name="condText" size="20" maxlength="60" onKeyDown="if(event.keyCode==13){ doCheck();return false}">
          	<input type="button" class="b_text" name="Button1" value="��ѯ" onclick="doCheck()">
          	<input type="hidden" name="unitId" value="">
          </TD>
        </TR>
    </TABLE>

	<script>
		x = screen.availWidth;
		y = screen.availHeight;
		window.innerWidth = x;
		window.innerHeight = y;
	</script>  
	<!------------------------>
	<table cellspacing=0>
	  <tr id="footer"> 
	    <td>
	      <input class="b_foot" name=reset  type=reset onClick="" value=���>
	      <input class="b_foot" name=back onClick="window.close();" type=button value=�ر�>
	    </td>
	  </tr>
	</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<!--***********************************************************************-->
