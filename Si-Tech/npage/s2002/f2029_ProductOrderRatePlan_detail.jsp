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
  String workNo = (String)session.getAttribute("workNo");
  String org_code = (String)session.getAttribute("orgCode");
  System.out.println(workNo+"============="+org_code);
  String p_BusinessMode = (String)session.getAttribute("p_BusinessMode_f2029_1.jsp"); //add by wangzn 
  String p_OperType = (String)session.getAttribute("p_OperType_f2029_1.jsp"); //add by wangzn 
  // out.println(p_BusinessMode+"----"+p_OperType); //add by wangzn for test
  String opCode="";
  String opName="产品规格信息";
  String sqlStr="";
  
  
  String in_ChanceId = (String)request.getParameter("in_ChanceId");
  System.out.println("====wanghfa====in_ChanceId = " + in_ChanceId);
  String busi_req_type = WtcUtil.repNull((String)request.getParameter("busi_req_type"));
  String in_productspec_number = WtcUtil.repNull((String)request.getParameter("in_productspec_number"));
  String in_BatchNo = WtcUtil.repNull((String)request.getParameter("in_BatchNo"));
  
  
%>
<HTML>
<HEAD>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<div id="Main">
<DIV id="Operation_Table">
 <div class="title"><div id="title_zi">产品级资费</div></div>
 <input type="hidden" id="p_POSpecNumber" value="">
 <input type="hidden" id="p_POOrderNumber" value="">
 <input type="hidden" id="p_ProductOrderNumber" value="">
 <input type="hidden" id="a_OperType" value="">
 <input type="hidden" id="p_ProductSpecNumber" value="">
 <input type="hidden" id="p_ParAcceptID" value=""> 
 <input type="hidden" id="p_AcceptID" value="">
 <input type="hidden" id="p_OperType" value="">
 <input type="hidden" id="action_flag" value="">
 <input type="hidden" id="is_add" value="">
 <input type="hidden" id="product_OperType" value="">
 
 <table>
  <tr>
   <td>资费计划标识   	
   </td>
   <td>
   	   <input id="p_RatePlanID" type="string" size="20" maxlength="20" readOnly>
   	   <input id="getProductOrderRatePlan" type="button" class="b_text" onclick="getProductOrderRatePlan()" value="查询">   		   	  
   </td>
   <td>资费描述   	
   </td>
   <td>
   	   <input id="p_Description" type="string" size="20" maxlength="150" readOnly>   		   	  
   </td>   
 	</tr>
 </table>
<br>  
<DIV id="div0_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div0_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">ICB参数列表</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv0">
	 	  <DIV id="wait0"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>
<DIV id="div1_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div1_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">集团产品</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv1">
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
var RatePlan;

var _jspPage =
{"div0_switch":["mydiv0","f2029_ProductOrderICBs_list.jsp","f"]
,"div1_switch":["mydiv1","f2029_ProductCode_list.jsp","f"]
};
function hiddenSpider()
{
	document.getElementById("mydiv0").style.display='none';
	document.getElementById("mydiv1").style.display='none';
}

$(document).ready(function () {
	//隐藏进度条
	hiddenSpider();
	$('img.closeEl').bind('click', toggleContent);
	$('#nextoper').click(function(){
     nextoper();
  });

  }
);

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
		   	{  		   	
		   		//alert("sPOOrderNumber:"+$("#p_POOrderNumber").val());
		   		//alert("sPOSpecNumber:"+$("#p_POSpecNumber").val());
		   		//alert("sProductOrderNumber:"+$("#p_ProductOrderNumber").val());
		   		//alert("sRatePlanID:"+$("#p_RatePlanID").val());
		   		//alert("sCheckFlag:"+RatePlan[5]);
		   		//alert("sProductSpecNumber:"+$("#p_ProductSpecNumber").val());
		   		//alert("sParAcceptID:"+$("#p_AcceptID").val());
		   		//alert("p_OperType:"+$("#p_OperType").val());
		   		//alert("product_OperType:"+$("#product_OperType").val());
		   		//alert("is_add:"+$("#is_add").val());
		   		$("#"+tmp2[0]).load(tmp2[1],{sPOOrderNumber:$("#p_POOrderNumber").val()
		   			                          ,sPOSpecNumber:$("#p_POSpecNumber").val()
		   			                          ,sProductOrderNumber:$("#p_ProductOrderNumber").val()
		   			                          ,sRatePlanID:$("#p_RatePlanID").val()
		   			                          ,sCheckFlag:RatePlan[5]
		   			                          ,a_OperType:$("#a_OperType").val()	//wanghfa add
		   			                          ,sProductSpecNumber:$("#p_ProductSpecNumber").val()
		   			                          ,sParAcceptID:$("#p_AcceptID").val()
		   			                          ,p_OperType:$("#p_OperType").val()            //wuxy add
		   			                          ,product_OperType: $("#product_OperType").val() //lusc add
		   			                          ,is_add: $("#is_add").val()     //lusc add 09-4-30
		   			                          ,in_ChanceId:'<%=in_ChanceId%>'
                                      ,busi_req_type:'<%=busi_req_type%>'
                                      ,in_productspec_number:'<%=in_productspec_number%>'
                                      ,in_BatchNo:'<%=in_BatchNo%>'
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
  	rdShowMessageDialog("资费计划标识不能为空!");
  	    return;
  }
  //add by rendi for 不选择集团产品提示
  if($("#p_POSpecNumber").val() != "01011304" && $("#p_POSpecNumber").val() != "01011301" && $("#p_POSpecNumber").val() != "01011302"&& ($(".ProductCode_contenttr").size())=="0")
  {
  	rdShowMessageDialog("集团产品不能为空!");
  	    return;
  }	
  
  

  RatePlan[0]  = $("#p_RatePlanID").val();        //0                        
  RatePlan[1]  = $("#p_Description").val();       //1	  	                  
  RatePlan[2]  = $("#p_POOrderNumber").val();     //2                        
  RatePlan[3]  = $("#p_POSpecNumber").val();      //3                     	  
  RatePlan[4]  = $("#p_ProductOrderNumber").val();//4  
  POICBsListArray = new Array($(".poicb_contenttr1").size());//列表数组初始化
  //列表数组赋值    
  $(".poicb_contenttr1").each(function(i)
  {
  	var POICBs = new Array(11);//列表每行数据数组
  	POICBs[0]=$(this).attr("a_ParameterNumber");
  	POICBs[1]=$(this).attr("a_ParameterName");
  	POICBs[2]=$(this).attr("a_ParameterValue");
    POICBs[3]=$(this).attr("a_POSpecNumber");   	  	  	                                 
    POICBs[4]=$(this).attr("a_POOrderNumber"); 
    POICBs[5]=$(this).attr("a_ProductOrderNumber"); 
    POICBs[6]=$(this).attr("a_RatePlanID");
    POICBs[7]=$(this).attr("a_OperType");
    POICBs[8]=$(this).attr("a_ProductSpecNumber");
    POICBs[9]=$(this).attr("a_ParAcceptID");
    POICBs[10]=$(this).attr("a_AcceptID");  
   
    
  	POICBsListArray[i]=POICBs;      	      
  });
  RatePlan[6]=POICBsListArray;//压入列表数组
  RatePlan[9]= $("#p_ProductSpecNumber").val();;
  RatePlan[10]=$("#p_ParAcceptID").val();;
  RatePlan[11]=$("#p_AcceptID").val();;   
  
  PCICBsListArray = new Array($(".ProductCode_contenttr").size());//列表数组初始化
  //列表数组赋值    
  $(".ProductCode_contenttr").each(function(i)
  {
  	var PCICBs = new Array(11);//列表每行数据数组
  	PCICBs[0]=$(this).attr("a_ProductCode");
  	PCICBs[1]=$(this).attr("a_ProductName");
  	PCICBs[2]=$(this).attr("a_ProductValue");
    PCICBs[3]=$(this).attr("a_POSpecNumber");   	  	  	                                 
    PCICBs[4]=$(this).attr("a_POOrderNumber"); 
    PCICBs[5]=$(this).attr("a_ProductOrderNumber"); 
    PCICBs[6]=$(this).attr("a_RatePlanID");
    PCICBs[7]=$(this).attr("a_OperType");
    PCICBs[8]=$(this).attr("a_ProductSpecNumber");
    PCICBs[9]=$(this).attr("a_ParAcceptID");
    PCICBs[10]=$(this).attr("a_DealFlag");  
   
    
  	PCICBsListArray[i]=PCICBs;      	      
  }); 	 
  RatePlan[14]=PCICBsListArray;//压入列表数组 
  // liujian 2012-8-27 10:33:53 添加议价
  RatePlan[15]=$('#bargain').val();     
  window.returnValue = "Y";
  window.close();     
}

//页面装载
$(document).ready(function () {	
	  RatePlan=window.dialogArguments;
	  $("#p_RatePlanID").val(RatePlan[0]);
	  $("#p_Description").val(RatePlan[1]);
	  $("#p_POOrderNumber").val(RatePlan[2]);	
	  $("#p_POSpecNumber").val(RatePlan[3]);	  
	  $("#p_ProductOrderNumber").val(RatePlan[4]);	  
	  $("#a_OperType").val(RatePlan[8]);
	  $("#p_ProductSpecNumber").val(RatePlan[9]);
	  
	  $("#p_ParAcceptID").val(RatePlan[10]);
	  
	  $("#p_AcceptID").val(RatePlan[11]);
	  $("#p_OperType").val(RatePlan[12]);	        //wuxy add  	
	  $("#action_flag").val(RatePlan[13]);
	  
	  ///  add by lusc 2009-04-09
	  $("#product_OperType").val(RatePlan[15]);
	  //alert($("#product_OperType").val());
	  	  	  	  	  	  
	  //注册确认
    $('#confirm').click(function(){
       ConfirmCheck();
    });	
      if( $("#p_OperType").val()=="1")
      {
      	 document.all.p_RatePlanID.readOnly=true;
      	 $("#getProductOrderRatePlan").hide();
      	 document.all.p_Description.readOnly=true;
      	
      } 
       if( $("#p_OperType").val()=="4")
      {
      	 var editflag=RatePlan[15].match("5"); 
	  			//alert(editflag);	 
      	 if(editflag==null){
      			$("#buttontr").hide();
      			$("#buttontrcode").hide();
      	 }
      	 $("#is_add").val(RatePlan[16]);
      	 //alert("::"+RatePlan[16]+"::");
      	 if(RatePlan[16]=="1"){
      	 	$("#buttontr").show();
      		$("#buttontrcode").show();
      	}
      } 
      
    if('05'=='<%=busi_req_type%>'){
        // $("#getProductOrderRatePlan").click();	
    }	  	 	  
});

function getProductOrderRatePlan(){	  
	  var pageTitle = "";
    var fieldName = "资费计划标识|资费描述|流水|";
    var sqlStr = "";
    var selType = "S";//'S'单选；'M'多选
    var retQuence = "3|0|1|2|";

    var retToField = "p_RatePlanID|p_Description|p_AcceptID|";

    var path = "<%=request.getContextPath()%>/npage/s2002/f2029_getProductOrderRatePlan_list.jsp?";
    path = path + "&fieldName="+fieldName;
    path = path + "&selType="+selType;
    path = path + "&retQuence="+retQuence;
    path = path + "&retToField="+retToField;
    path = path + "&sProductSpecNumber=" +$("#p_ProductSpecNumber").val();   
    path = path + "&sPoSpecNumber=" +$("#p_POSpecNumber").val();
    path = path + "&workNo=<%=workNo%>";
    path = path + "&orgCode=<%=org_code%>";    
    path = path + "&p_BusinessMode=<%=p_BusinessMode%>"; //add by wangzn
    path = path + "&p_OperType=<%=p_OperType%>"; // add by wangzn
    path = path + "&in_ChanceId=<%=in_ChanceId%>"; // add by wangzn 
    path = path + "&in_BatchNo=<%=in_BatchNo%>"; // add by wangzn
    path = path + "&busi_req_type=<%=busi_req_type%>"; // add by wangzn 
    
    
    
    retInfo = window.open(path,
                          "newwindow",
                          "height=400, width=700,top=300,left=350,scrollbars=yes, resizable=no,location=no, status=yes");
    return true;
}

function getProductOrderRatePlanRtn(retInfo)
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
