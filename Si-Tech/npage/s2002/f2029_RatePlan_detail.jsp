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
  String opName="��Ʒ���ʷ�";
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
 <div class="title"><div id="title_zi">��Ʒ���ʷ�</div></div>
 <input type="hidden" id="p_POSpecNumber" value="">
 <input type="hidden" id="p_POOrderNumber" value="">
 <input type="hidden" id="p_POSpecRatePolicyID" value="">
 <input type="hidden" id="p_ParAcceptID" value="">
 <input type="hidden" id="p_AcceptID" value="">
 <input type="hidden" id="p_OperType" value="">
 <input type="hidden" id="action_flag" value="">
 <table>
  <tr>
  	
   <td width="25%">�ʷѼƻ���ʶ   	
   </td>
   <td width="35%">
   	   <input id="p_RatePlanID" type="string" size="20" maxlength="20" readonly>
   	   <input id="getRatePlanNumber" type="button" class="b_text" onclick="getRatePlanNumber()" value="��ѯ">               		   	     		   	  
   </td>
   <td width="25%">�ʷ�����  	
   </td>
   <td width="15%">
   	   <input id="p_Description" type="string" size="20" maxlength="60" readonly>
   		   	  
   </td>
 	</tr>  
 </table>
<br>  
 <DIV id="div0_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div0_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">ICB����ֵ�б�</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv0">
	 	  <DIV id="wait0"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>
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
var RatePlan;

var _jspPage =
{"div0_switch":["mydiv0","f2029_POICB_list.jsp","f"]
};
function hiddenSpider()
{
	document.getElementById("mydiv0").style.display='none';
}

var toggleContent = function(e)
{
	var targetContent = $( 'DIV.itemContent',this.parentNode.parentNode.parentNode);
	if (targetContent.css('display') == 'none') {  	  
		   targetContent.slideDown(300);
		   $(this).attr({ src: "../../../nresources/default/images/jian.gif"});
		   //���÷���
		   try{
		   	var tmp = $(this).attr('id');
		   	var tmp2 = eval("_jspPage."+tmp);
		   	if(tmp2[2]=="f"&&tmp2[1]!=''&&tmp2[1]!=undefined)
		   	{  		   		
		   		$("#"+tmp2[0]).load(tmp2[1],{sPOSpecNumber:$("#p_POSpecNumber").val()
		   			                          ,sPOOrderNumber:$("#p_POOrderNumber").val()
		   			                          ,sPOSpecRatePolicyID:$("#p_POSpecRatePolicyID").val()
		   			                          ,sRatePlanID:$("#p_RatePlanID").val()
		   			                          ,sCheckFlag:RatePlan[8]
		   			                          ,sParAcceptID:$("#p_AcceptID").val()	
		   			                          ,p_OperType:$("#p_OperType").val()      //wuxy alter	 			                          
		   			                          });
		   		tmp2[2]="t";
		   	}
		   }catch(e)
		   {
		   }
	} else {
		targetContent.slideUp(300);
		$(this).attr({ src: "../../../nresources/default/images/jia.gif"});
	}
	return false;
};

function ConfirmCheck(){

  if($("#p_RatePlanID").val()=="")
  {
  	rdShowMessageDialog("�ʷѼƻ���ʶ����Ϊ��!");
  	return;
  }
  RatePlan[0] = $("#p_RatePlanID").val();
  RatePlan[1] = $("#p_Description").val();
  RatePlan[2] = $("#p_POSpecNumber").val();
  RatePlan[3] = $("#p_POOrderNumber").val();
  RatePlan[4] = $("#p_POSpecRatePolicyID").val(); 
  RatePlan[9] = $("#p_ParAcceptID").val();
  RatePlan[10]= $("#p_AcceptID").val();
  
  
  var POICBListArray = new Array($(".poicb_contenttr").size());//�б������ʼ��
  //�б����鸳ֵ    
  $(".poicb_contenttr").each(function(i)
  {
  	var POICB = new Array(10);//�б�ÿ����������      
  	POICB[0]=$(this).attr("a_ParameterNumber");
  	POICB[1]=$(this).attr("a_ParameterName");
  	POICB[2]=$(this).attr("a_ParameterValue");
  	POICB[3]=$(this).attr("a_POSpecNumber");
  	POICB[4]=$(this).attr("a_POOrderNumber");
  	POICB[5]=$(this).attr("a_POSpecRatePolicyID");
  	POICB[6]=$(this).attr("a_RatePlanID");
  	POICB[7]=$(this).attr("a_OperType");
  	POICB[8]=$(this).attr("a_ParAcceptID");
  	POICB[9]=$(this).attr("a_AcceptID");  
  	
  	POICBListArray[i]=POICB;      	      
  });
  RatePlan[6]=POICBListArray;//ѹ���б�����                  
  window.returnValue = "Y";    
  window.close();
}

//ҳ��װ��
$(document).ready(function () {
	  RatePlan=window.dialogArguments;	   	  	  	  
	  $("#p_RatePlanID").val(RatePlan[0]);
	  $("#p_Description").val(RatePlan[1]);
	  $("#p_POOrderNumber").val(RatePlan[2]);
	  $("#p_POSpecNumber").val(RatePlan[3]);	
	 
	  $("#p_POSpecRatePolicyID").val(RatePlan[4]);	
	  $("#p_ParAcceptID").val(RatePlan[9]); 
	  
	  $("#p_AcceptID").val(RatePlan[10]);
	  $("#p_OperType").val( RatePlan[11]);        //wuxy alter ��������
	  $("#action_flag").val(RatePlan[12]);
	  
	  if($("#p_OperType").val()=="1")
	  {
	  	document.all.p_RatePlanID.readOnly=true;
	  	$("#getRatePlanNumber").hide();
	  	document.all.p_Description.readOnly=true;
	  }
	  
	  //ע��ȷ��
    $('#confirm').click(function(){
  	   ConfirmCheck();
  	});    
	  //���ؽ�����
	  hiddenSpider();
	  $('img.closeEl').bind('click', toggleContent);
	  $('#nextoper').click(function(){
       nextoper();
    });
    

});

function getRatePlanNumber(){	  
	  var pageTitle = "ICB����ֵ";
    var fieldName = "��������|������|��ˮ|";
    var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "3|0|1|2|";

    var retToField = "p_RatePlanID|p_Description|p_AcceptID|";

    var path = "<%=request.getContextPath()%>/npage/s2002/f2029_getRatePlan_list.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName="+fieldName;
    path = path + "&selType="+selType;
    path = path + "&retQuence="+retQuence;
    path = path + "&retToField="+retToField;
    path = path + "&sPOSpecNumber=" +$("#p_POSpecNumber").val();
    path = path + "&sPOOrderNumber="+$("#p_POOrderNumber").val();
    path = path + "&sPOSpecRatePolicyID=" +$("#p_POSpecRatePolicyID").val();
    path = path + "&sRatePlanID="+$("#p_RatePlanID").val();
    
    retInfo = window.open(path,
                          "newwindow",
                          "height=400, width=700,top=300,left=350,scrollbars=yes, resizable=no,location=no, status=yes");
    return true;
}

function getRatePlanNumberRtn(retInfo)
{
    var retToField = "p_RatePlanID|p_Description|p_AcceptID|";
    
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
</script>
</BODY>
</HTML>
