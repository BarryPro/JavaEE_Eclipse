<%
/*关于跨省专线业务两级订单流改造的需求*/
%>
<%
   /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年10月25日
　 * 作者: piaoyi
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
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
  String opName="产品规格信息";
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
 <div class="title"><div id="title_zi">套餐</div></div>
 <input type="hidden" id="p_POSpecNumber" value="">
 <input type="hidden" id="p_POOrderNumber" value="">
 <input type="hidden" id="p_AcceptID" value=""> 
 <input type="hidden" id="p_OperType" value=""> 
 <input type="hidden" id="action_flag" value=""> 
 <table>
  <tr>
   <td>套餐ID   	
   </td>
   <td>
   	   <input id="p_POSpecRatePolicyID" type="string" size="20" maxlength="20" class="InputGrey" readonly >
   	   <input id="getPOSpecRatePolicy" type="button" class="b_text" onclick="getPOSpecRatePolicy()" value="查询">   		   	  
   </td>
   <td>套餐名称   	
   </td>
   <td>
   	   <input id="p_Name" type="string" size="20" maxlength="20" class="InputGrey" readonly >
   		   	  
   </td>
 	</tr>
 </table>
<br>  
 <DIV id="div0_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div0_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">商品级资费计划列表</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv0">
	 	  <DIV id="wait0"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>
<table>
  <tr>
    <td align="center" id="footer" colspan="4">
    	<input class="b_foot" id=confirm type=button value="确认" onClick="">
      <input class="b_foot" id=closebtn type=button value="关闭" onClick="window.close()">
    </td>
  </tr>
</table>
</div>
</div>
<script>
var POSpecRatePolicy;


var _jspPage =
{"div0_switch":["mydiv0","f2029_RatePlans_list.jsp","f"]
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
		   //调用服务
		   try{
		   	var tmp = $(this).attr('id');
		   	var tmp2 = eval("_jspPage."+tmp);
		   	if(tmp2[2]=="f"&&tmp2[1]!=''&&tmp2[1]!=undefined)
		   	{  		//wuxy alter 多传一个操作类型   
		   				
		   		$("#"+tmp2[0]).load(tmp2[1],{sPOSpecNumber:$("#p_POSpecNumber").val()
		   			                          ,sPOOrderNumber:$("#p_POOrderNumber").val()
		   			                          ,sPOSpecRatePolicyID:$("#p_POSpecRatePolicyID").val()
		   			                          ,sCheckFlag:POSpecRatePolicy[7]
		   			                          ,sParAcceptID:$("#p_AcceptID").val()
		   			                          ,p_OperType:$("#p_OperType").val()
		   			                          });
		   		//tmp2[2]="t";
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

  if($("#p_POSpecRatePolicyID").val()=="")
  {
  	  rdShowMessageDialog("套餐ID不能为空");
  	  return;
  }	
  if($("#p_Name").val()=="")
  {
  	  rdShowMessageDialog("套餐名称不能为空");
  	  return;
  }	 
  POSpecRatePolicy[0] = $("#p_POSpecRatePolicyID").val();
  POSpecRatePolicy[1] = $("#p_Name").val();
  POSpecRatePolicy[2] = $("#p_POSpecNumber").val();
  POSpecRatePolicy[3] = $("#p_POOrderNumber").val();
  var RatePlansListArray = new Array($(".RatePlans_contenttr").size());//列表数组初始化     
  //列表数组赋值    
  $(".RatePlans_contenttr").each(function(i)
  {    	
  	var RatePlan = new Array(11);//列表每行数据数组  	
  	RatePlan[0]=$(this).attr("a_RatePlanID");
  	RatePlan[1]=$(this).attr("a_Description");
  	RatePlan[2]=$(this).attr("a_POOrderNumber");
  	RatePlan[3]=$(this).attr("a_POSpecNumber");
  	RatePlan[4]=$(this).attr("a_POSpecRatePolicyID"); 
  	RatePlan[5]=$(this).attr("a_OperType");
  	RatePlan[6]=$(this).data("a_POICBList");
  	RatePlan[8]=$(this).attr("a_POICBListCheck");
  	RatePlan[9]=$(this).attr("a_ParAcceptID");
    RatePlan[10]=$(this).attr("a_AcceptID");
    RatePlansListArray[i]=RatePlan; 
  });  
  POSpecRatePolicy[4]=RatePlansListArray;//压入列表数组
  POSpecRatePolicy[8]=$("#p_AcceptID").val();	  
  window.returnValue = "Y";    
  window.close();
}

//页面装载
$(document).ready(function () {
	  //隐藏进度条
	   hiddenSpider();
	   $('img.closeEl').bind('click', toggleContent);
	   $('#nextoper').click(function(){
       nextoper();
    });
	  POSpecRatePolicy=window.dialogArguments;	   	  	  	  
	  $("#p_POSpecRatePolicyID").val(POSpecRatePolicy[0]);
	  $("#p_Name").val(POSpecRatePolicy[1]);
	  $("#p_POOrderNumber").val(POSpecRatePolicy[2]);	  
	  $("#p_POSpecNumber").val(POSpecRatePolicy[3]);
	  $("#p_AcceptID").val(POSpecRatePolicy[8]);	
	  $("#p_OperType").val( POSpecRatePolicy[9]);             //wuxy alter 20081218
	  $("#action_flag").val(POSpecRatePolicy[10]);
	  
	  //注册确认
    $('#confirm').click(function(){
  	   ConfirmCheck();
  	});
  	if($("#p_OperType").val()=="1")
  	{
  		document.all.p_POSpecRatePolicyID.readOnly=true;
  		document.all.p_Name.readOnly=true;
  		$("#getPOSpecRatePolicy").hide();
  	}
  }
);


function getPOSpecRatePolicy(){	  
	
	
	
	  var pageTitle = "ICB参数值";
    var fieldName = "参数编码|参数名|流水|";
    var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "3|0|1|2|";

    var retToField = "p_POSpecRatePolicyID|p_Name|p_AcceptID|";
    var path="";
    
  
    path = "<%=request.getContextPath()%>/npage/s2002/f2029_getPOSpecRatePolicy_list.jsp";
 
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName="+fieldName;
    path = path + "&selType="+selType;
    path = path + "&retQuence="+retQuence;
    path = path + "&retToField="+retToField;
    path = path + "&sPOSpecNumber=" +$("#p_POSpecNumber").val();
    path = path + "&sp_OperType="+$("#p_OperType").val();
    
    
    
    retInfo = window.open(path,
                          "newwindow",
                          "height=400, width=700,top=300,left=350,scrollbars=yes, resizable=no,location=no, status=yes");
    
    return true;
}

function getPOSpecRatePolicyRtn(retInfo)
{
    var retToField = "p_POSpecRatePolicyID|p_Name|p_AcceptID|";
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
