<%
   /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2008��10��25��
�� * ����: piaoyi
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  String opCode="";
  String opName="ICB����ֵ";
  String sqlStr="";
%>
<HTML>
<HEAD>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<div id="Main">
<DIV id="Operation_Table">


 <div class="title"><div id="title_zi">ICB����ֵ</div></div>

 <input type="hidden" id="p_POOrderNumber" value="">
 <input type="hidden" id="p_POSpecNumber" value="">
 <input type="hidden" id="p_ProductOrderNumber" value="">
 <input type="hidden" id="p_ProductSpecNumber" value="">
 <input type="hidden" id="p_RatePlanID" value="">
 <input type="hidden" id="p_ParAcceptID" value="">
 <input type="hidden" id="p_AcceptID" value="">
 <input type="hidden" id="action_flag" value="">
  <input type="hidden" id="p_OprType" value="">
 <table>
  <tr>
   <td>��������
   </td>
   <td>
   	   <input id="p_ParameterNumber" type="string" size="20" maxlength="20" readonly="readonly">
   	    <input id="getParameterNumber" type="button" class="b_text" onclick="getParameterNumber()" value="��ѯ">
   </td>
   <td>������
   </td>
   <td>
   	   <input id="p_ParameterName" type="string" size="20" maxlength="20" readonly="readonly">

   </td>
 	</tr>
<tr>
   <td>����ֵ
   </td>
   <td colspan="3">
   	   <input id="p_ParameterValue" type="string" size="20" v_maxlength="12" maxlength="12" v_type="money">
   </td>
 	</tr>
 </table>

<table>
  <tr>
    <td align="center" id="footer" colspan="4">
    	<input class="b_foot" id=confirm type=button value="ȷ��" onClick="">
      <input class="b_foot" id=closebtn type=button value="�ر�" onClick="window.close()">
    </td>
  </tr>
</table>
</div>
</div>
<script>
var ProductOrderICB;

function ConfirmCheck(){
	/*yuanqs add 2011-3-15 17:27:40 �����ֶβ���Ϊ�� begin*/
	if($("#p_ParameterNumber").val()=="")
	{
		rdShowMessageDialog("�������벻��Ϊ��!");
		return;
	}
	if($("#p_ParameterName").val()=="")
	{
		rdShowMessageDialog("�������Ʋ���Ϊ��!");
		return;
	}

	if($("#p_ParameterValue").val()=="")
	{
		rdShowMessageDialog("����ֵ����Ϊ��!");
		return;
	} else if (!checkElement(document.getElementById("p_ParameterValue"))) {
  	rdShowMessageDialog("����ֵ�����Ǵ��ڵ���0�ģ�����С�ڵ���12λ�����֣�");
  	return;
  } else if (parseInt(document.getElementById("p_ParameterValue").value) < 0) {
  	rdShowMessageDialog("����ֵ�����Ǵ��ڵ���0�ģ�����С�ڵ���12λ�����֣�");
  	return;
  }

	 if (document.getElementById("p_ParameterValue").value.indexOf(".")>9) {
    	rdShowMessageDialog("����ֵ�ṹ������9λ���ּ���λС����");
      return;	
   }
  
	/*yuanqs add 2011-3-15 17:27:59 end */
	ProductOrderICB[0]  = $("#p_ParameterNumber").val();       //0
	ProductOrderICB[1]  = $("#p_ParameterName").val();         //1
	ProductOrderICB[2]  = $("#p_ParameterValue").val();        //2
	ProductOrderICB[3]  = $("#p_POSpecNumber").val();          //3
	ProductOrderICB[4]  = $("#p_POOrderNumber").val();         //4
	ProductOrderICB[5]  = $("#p_ProductOrderNumber").val();    //5
	ProductOrderICB[6]  = $("#p_RatePlanID").val();            //6
	ProductOrderICB[8]  = $("#p_ProductSpecNumber").val();     //8
	ProductOrderICB[9]  = $("#p_ParAcceptID").val();           //9
	ProductOrderICB[10] = $("#p_AcceptID").val();              //10
	
	window.returnValue = "Y";
	window.close();
}



function getParameterNumber(){	  
	  var pageTitle = "ICB����ֵ";
    var fieldName = "��������|������|��ˮ|";
    var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "3|0|1|2|";

    var retToField = "p_ParameterNumber|p_ParameterName|p_AcceptID|";

    var path = "<%=request.getContextPath()%>/npage/s2002/f2029_getProPOICB_list.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName="+fieldName;
    path = path + "&selType="+selType;
    path = path + "&retQuence="+retQuence;
    path = path + "&retToField="+retToField;
    path = path + "&sPOSpecNumber=" +$("#p_POSpecNumber").val();
    path = path + "&sp_ProductSpecNumber="+$("#p_ProductSpecNumber").val();
    path = path + "&sPOSpecRatePolicyID=" +$("#p_POSpecRatePolicyID").val();
    path = path + "&sRatePlanID="+$("#p_RatePlanID").val();
    
    
    retInfo = window.open(path,
                          "newwindow",
                          "height=400, width=700,top=300,left=350,scrollbars=yes, resizable=no,location=no, status=yes");
    return true;
}

function getParameterNumberRtn(retInfo)
{
    var retToField = "p_ParameterNumber|p_ParameterName|p_AcceptID|";
   
    if (retInfo == undefined)
    {
        return false;
    }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while (chPos_field > -1)
    {
        obj = retToField.substring(0, chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0, chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
    }
}









//ҳ��װ��
$(document).ready(function () {
	  ProductOrderICB=window.dialogArguments;
	  
	  for(var i=0;i<ProductOrderICB.length;i++)
	  {
	  	//alert('['+i+']['+ProductOrderICB[i]+']');	
	  }
	  
	  $("#p_ParameterNumber").val(ProductOrderICB[0].trim());
	  $("#p_ParameterName").val(ProductOrderICB[1].trim());
	  $("#p_ParameterValue").val(ProductOrderICB[2].trim());
	  $("#p_POSpecNumber").val(ProductOrderICB[3]);
	 
	  $("#p_POOrderNumber").val(ProductOrderICB[4]);
	  $("#p_ProductOrderNumber").val(ProductOrderICB[5]);
	  $("#p_RatePlanID").val(ProductOrderICB[6]);
	  
	  $("#p_ProductSpecNumber").val(ProductOrderICB[8]);
	  $("#p_ParAcceptID").val(ProductOrderICB[9]);
	  
	  $("#p_AcceptID").val(ProductOrderICB[10]);
	  $("#p_OprType").val(ProductOrderICB[11]);
	  $("#action_flag").val(ProductOrderICB[12]);
	  if( $("#p_OprType").val()=="1")
	  {
	  	document.all.p_ParameterNumber.readOnly=true;
	  	document.all.p_ParameterName.readOnly=true;
	  	document.all.p_ParameterValue.readOnly=true;
	  	$("#getParameterNumber").hide();
	  }
	  //ע��ȷ��
    $('#confirm').click(function(){
       ConfirmCheck();
    });
	}
);
</script>
</BODY>
</HTML>
