<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.23
 ģ��: MAS/ADCҵ����ͣ/�ָ�����
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>MAS/ADCҵ����ͣ/�ָ�����</TITLE>
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
	String opCode  =request.getParameter("opCode");
	String opName  =request.getParameter("opName");
	
%>

</HEAD>

<body>
<SCRIPT language="JavaScript">
	var params = "";
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
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
    var path = "/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    path += "&params="+params;
    
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
	    var retToField = "unitId|condText|";
		var sqlStr="";
		if (document.frm.queryType.value=="0")
		{
			document.frm.unitId.value=document.frm.condText.value;
			//window.location="f5082_2.jsp?unitId=" + document.frm.unitId.value;
			window.location="f3915_2.jsp?unitId=" + document.frm.unitId.value+"&opCode=<%=opCode%>&opName=<%=opName%>";
		}
		if (document.frm.queryType.value=="1")
		{
			params = document.frm.condText.value+"|";
			sqlStr ="90000171";
		}
		if (document.frm.queryType.value=="2")
		{
			params = document.frm.condText.value+"|";
			sqlStr ="90000172";
		}
		if (document.frm.queryType.value=="1" || document.frm.queryType.value=="2")
		{
			PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
			if (document.frm.unitId.value!="")
				//window.location="f5082_2.jsp?unitId=" + document.frm.unitId.value;
				window.location="f3915_2.jsp?unitId=" + document.frm.unitId.value+"&opCode=<%=opCode%>&opName=<%=opName%>";
		}
		if (document.frm.queryType.value=="3")
		{
			//window.location="f5082_dCustGrp.jsp?phoneNo=" + document.frm.condText.value;
			window.location="f3915_dCustGrp.jsp?phoneNo=" + document.frm.condText.value+"&opCode=<%=opCode%>&opName=<%=opName%>";
		}
		if (document.frm.queryType.value=="4")
		{
			params = document.frm.condText.value+"|";
			sqlStr ="90000173";
			PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
			if (document.frm.unitId.value!="")
				//window.location="f5082_2.jsp?unitId=" + document.frm.unitId.value;
				window.location="f3915_2.jsp?unitId=" + document.frm.unitId.value+"&opCode=<%=opCode%>&opName=<%=opName%>";
		}
	}
	return true;
}

</SCRIPT>
 
<FORM method=post name="frm" >
	<%@ include file="/npage/include/header.jsp" %>   
  	<input type="hidden" name="opCode" value="<%=opCode%>">
  	<input type="hidden" name="opName" value="<%=opName%>">
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

	<TABLE cellSpacing="0">
        <TR> 
          <TD class="blue">��ѯ����</TD>
          <TD>
           <select align="left" name=queryType>
              <option value="0">���ű��</option>
              <option value="1">��������</option>
              <option value="2">VPMN����</option>
              <!--option class="button" value="3">�ֻ�����</option-->
              <option value="4">֤������</option>
            </select> 
		  </TD>
          <TD class="blue"> ������Ϣ</TD>
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
	<TABLE cellSpacing="0">
	  <tr> 
	    <td id="footer">
	      &nbsp; <input class="b_foot" name=reset  type=reset onClick="" value=���>
	      &nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
	      &nbsp; 
	    </td>
	  </tr>
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>   
</FORM>
</BODY>
</HTML>
<!--***********************************************************************-->
