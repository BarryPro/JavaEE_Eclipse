<%
    /*************************************
    * ��  ��: ���ſͻ������� e801
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-4-26
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>���ſͻ���������ѯ</TITLE>
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
	String regCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
%>
</HEAD>

<body>
<SCRIPT language="JavaScript">
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
    //var path = "../../npage/public/fPubSimpSel.jsp";
    var path = "/npage/s3915/f3915Qry.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
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
	    var fieldName = "���ű��|��������|���ŵ�ַ|�ͻ�ID|����������|"; 
	    var selType = "S";    //'S'��ѡ��'M'��ѡ
	    var retQuence = "2|0|1|";
	    var retToField = "unitId|";
  		//var sqlStr="select unit_id, unit_name, unit_addr, cust_id, boss_vpmn_code from dCustDocOrgAdd where ";
  		var paramStr = "";
  		if (document.frm.queryType.value=="0") //֤������
  		{
  			//var sqlStr2="SELECT unit_id, unit_name, unit_addr, a.cust_id, boss_vpmn_code FROM dCustDocOrgAdd a, dcustdoc b WHERE a.cust_id=b.cust_id AND b.id_iccid = '"+document.frm.condText.value+"'";
  			var paramStr2 = "&id_iccid=" + document.frm.condText.value+"&opCode=<%=opCode%>&opName=<%=opName%>&flag=2";
  			PubSimpSel(pageTitle,fieldName,paramStr2,selType,retQuence,retToField);
  			if (document.frm.unitId.value!="")
  				window.location="fe801_ajax_queryInfo.jsp?unitId=" + document.frm.unitId.value;
  		}
  		if (document.frm.queryType.value=="1") //���ű��
  		{
  			document.frm.unitId.value=document.frm.condText.value;
  			window.location="fe801_ajax_queryInfo.jsp?unitId=" + document.frm.unitId.value;
  		}
  		if (document.frm.queryType.value=="2") //���������
  		{
  			//sqlStr += "boss_vpmn_code='" + document.frm.condText.value + "'";
  			paramStr += "&boss_vpmn_code=" + document.frm.condText.value;
  			paramStr += "&opCode=<%=opCode%>&opName=<%=opName%>&flag=1";
  			PubSimpSel(pageTitle,fieldName,paramStr,selType,retQuence,retToField);
  			if (document.frm.unitId.value!="")
  				window.location="fe801_ajax_queryInfo.jsp?unitId=" + document.frm.unitId.value;
    		}
  		if (document.frm.queryType.value=="3") //�ͻ�ID
  		{
  		  var custId=document.frm.condText.value;
        var myPacket = new AJAXPacket("fe801_ajax_getUnitId.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
	    	myPacket.data.add("custId",custId);
	    	core.ajax.sendPacket(myPacket,doGetUnitId);
	    	myPacket=null; 
  		}
	}
	return true;
}

function doGetUnitId(packet){
  var retCode = packet.data.findValueByName("retcode");
  var retMsg = packet.data.findValueByName("retmsg");
  var unitIdBack = packet.data.findValueByName("unitIdBack");
  if(retCode!="000000"){
    rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    window.location.href="fe801_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
  }else{
    window.location.href="fe801_ajax_queryInfo.jsp?unitId="+unitIdBack;
  }
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
              <option value="0">֤������</option>
              <option value="1">���ű��</option>
              <option value="2">���������</option>
              <option value="3">�ͻ�ID</option>
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
	      <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
	    </td>
	  </tr>
	</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<!--***********************************************************************-->
