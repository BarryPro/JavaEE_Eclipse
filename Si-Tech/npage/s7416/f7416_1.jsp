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
  String workName = (String)session.getAttribute("workName");
  String password = (String)session.getAttribute("password");  
  String ipAddr = (String)session.getAttribute("ipAddr");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String opCode="7422";
  String opName="动力100订单工单处理";
  String sqlStr="";
%>
<HTML>
<HEAD>
<link href="../s2002/s2002.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
	<FORM name="form1" method="post">
		<input type="hidden" name="p_IDNo" id="p_IDNo" v_type="0_9"  v_must="1" size="20" maxlength="18">
<%@ include file="/npage/include/header.jsp" %>
<div class="title"><div id="title_zi">订单信息</div></div>
<table cellSpacing=0>
  <tr>
    <td class="blue" width="15%">
    订单编号
    </td>
    <td width="35%">
      <input name="p_PONumber" id="p_PONumber" v_type="0_9"  v_must="1" size="20" maxlength="18">            
    </td>
    <td class="blue" width="15%">
    集团客户ID
    </td>
    <td width="35%">
      <input name="p_CustID" id="p_CustID" v_type="0_9"  v_must="1" size="20" maxlength="18">
    	<input name="getPOMsgBtn" type="button" class="b_text" onclick="getPOMsg()" id="getPOMsgBtn" value="查询">
    </td>
  </tr>
  <tr>
  	<td class="blue">
  		证件号码
  	</td>
    <td>
    	<input   id="p_IdIccid" name="p_IdIccid"  size="24" maxlength="20" v_type="string" v_must=1>    
      <!--input type="hidden"  id="p_POStatus" name="p_POStatus"-->    
    </td>
    <td class="blue" width="15%">
    集团编码
    </td>
    <td width="35%">
			<input name="p_UnitNo" id="p_UnitNo" v_type="0_9"  v_must="1" size="20" maxlength="18">
    </td>   	
    
    
    
   <tr>
    <td  class="blue">
    产品包代码
    </td>
    <td>
      <input name="p_ProdPackCode" id="p_ProdPackCode" v_type="0_9" size="20" maxlength="9" readonly>      
    </td>
    <td  class="blue">
    产品包名称
    </td>
    <td>
      <input name="p_ProdPackName" id="p_ProdPackName" v_type="0_9" size="20" maxlength="9" readonly>
    </td>     
   </tr>
  <tr>
  	
  	<td class="blue">
    订单状态
    </td>
    <td>
    	<select id="p_POStatus" name="p_POStatus">
      	<option value="1">订单处理中</option>
      	<option value="2">订单处理成功</option>
      	<option value="d">订单废弃</option>
      </select>
			<input type="hidden" name="p_POEndData" id="p_POEndData" v_type="string" readonly>            
    </td>
    
    <td class="blue">
    订单类型
    </td>
    <td>
    	<select id="p_POType" name="p_POType">
      	<option value="1">开通</option>
      	<option value="0">取消</option>
      </select>           
    </td>  	
    
  </tr>
  <tr>
    <td class="blue">
    订单备注
    </td>
    <td colspan="2">
			<input name="p_PONote" id="p_PONote" v_type="string" size="60" maxlength="20" readonly>                  
    </td>
    <td>
    	<input class="b_text" id=podropBtn type=button value="订单废弃" onClick="OPDrop()">
    </td>
  </tr> 
</table>
<br>

<DIV id="div1_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div1_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">工单列表</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv1">
	 	  <DIV id="wait1"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>
<table id="tc">
  <tr>
    <td align="center" id="footer" colspan="2">
    	
      <input class="b_foot" type=button name="b_back" value="清除" onClick="window.location.reload()" >  
                &nbsp;    	                                               
      <input class="b_foot" name=reset type=button value="关闭" onClick="parent.removeTab('<%=opCode%>')">
    </td>
  </tr>
</table>
</DIV>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<script type="text/javascript">
var _jspPage =
{"div1_switch":["mydiv1","f7416_order_list.jsp","f"]
};
$("#divold").hide() ;
function hiddenSpider()
{
	document.getElementById("mydiv1").style.display='none';
}

$(document).ready(function () {
	//隐藏进度条
	hiddenSpider();
	$('img.closeEl').bind('click', toggleContent);
	$('#div1_show').hide();	
	//$('#podropBtn').attr("disabled","true");
	$('#podropBtn').hide();
	$('#roderlistBtn').attr("disabled","true");
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
		   	  	$("#"+tmp2[0]).load(tmp2[1],{sPONumber:$("#p_PONumber").val()
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

//-----------------------------------------------------------------------------------------------------------
function getPOMsg(){
	
		if(document.form1.p_PONumber.value==""&&document.form1.p_CustID.value==""&&document.form1.p_UnitNo.value==""&&document.form1.p_IdIccid.value=="")
		{
			
			rdShowMessageDialog("请输入订单编号、证件号码、集团客户ID或集团编码后再查询!",1);
        return false;
		}
	  var pageTitle = "";
    var fieldName = "动力100订单选择|";
    var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "11|0|1|2|3|4|5|6|7|8|9|10|";
                                         
    var retToField = "p_PONumber|p_CustID|p_UnitNo|p_POStatus|p_ProdPackCode|p_ProdPackName|p_POType|p_POEndData|p_PONote|p_IDNo|p_IdIccid|";

    var path = "<%=request.getContextPath()%>/npage/s7416/f7416_getPOMsg_list.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName="+fieldName;
    path = path + "&selType="+selType;
    path = path + "&retQuence="+retQuence;
    path = path + "&retToField="+retToField;
    path = path + "&sPONumber=" +$("#p_PONumber").val();
    path = path + "&sUnitID=" +$("#p_CustID").val();    
		path = path + "&sIDNo=" +$("#p_UnitNo").val();
		path = path + "&sPOStatus=" +$("#p_POStatus").val();
		path = path + "&sIdiccid=" +$("#p_IdIccid").val();
		
    retInfo = window.open(path,
                          "newwindow",
                          "height=400, width=900,top=300,left=350,scrollbars=yes, resizable=no,location=no, status=yes");
    return true;
}


function Form_reset(){
	
	document.forms[0].reset();
}

function getPOMsgRtn(retInfo)
{
    var retToField = "p_PONumber|p_CustID|p_UnitNo|p_POStatus|p_ProdPackCode|p_ProdPackName|p_POType|p_POEndData|p_PONote|p_IDNo|p_IdIccid|";
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
    $(".POSOper").val("0");
  	$("#div1_show").show();
    //$("#div2_show").show();
    $("#nextoper").show();
    $("#ts").hide();
    $("#tc").show();
    $("#p_POType").attr("disabled","true");
    $("#p_POStatus").attr("disabled","true");
    $("#getPOMsgBtn").attr("disabled","true");

    $("#p_PONumber").attr("readonly","true");
    $("#p_UnitID").attr("readonly","true");
    $("#p_IDNo").attr("readonly","true");
        
  	$("#CustomerNumberQueryDiv").hide();
  	if($("#p_POStatus").val()=="1"){
  		//$('#podropBtn').attr("disabled","");
  		$('#podropBtn').show();
  	}
  	
  	
}

function OrderDealRtn(cfmpacket)
{
  var retCode = unescape(cfmpacket.data.findValueByName("retCode"));
	var retMsg = unescape(cfmpacket.data.findValueByName("retMsg"));
	var orderStatus = unescape(cfmpacket.data.findValueByName("orderStatus"));	
	if(retCode=="000000"){		
		$("#layer2").hide();
		$("#p_POStatus").val(orderStatus);
		try{
			  $("#mydiv1").load("f7416_order_list.jsp",{sPONumber:$("#p_PONumber").val()
			  });			  	
		}catch(e)
		{
		}		
    rdShowMessageDialog("操作成功！",1);		 	
  }else{
		rdShowMessageDialog("错误信息："+retMsg+" 错误代码："+retCode,0);	
	}
	if($("#p_POStatus").val()=="2"){
  		//$('#podropBtn').attr("disabled","");
  		$('#podropBtn').hide();
  	}
	
}
function OPDrop()
{
	var cfmpacket = new AJAXPacket("f7416_OPdrop_deal.jsp", "正在提交,请稍候......");
	cfmpacket.data.add("sWorkNo", "<%=workNo%>");                           //操作工号
	cfmpacket.data.add("sPassWord", "<%=password%>");                       //工号密码
	cfmpacket.data.add("sOpCode", "7422");                                  //功能代码
	cfmpacket.data.add("sPONumber", $("#p_PONumber").val());                //订单编号
	cfmpacket.data.add("sPOOper", "d");                                     //订单处理结果
	cfmpacket.data.add("sPONote", $("#p_PONote").val());                    //注释
	cfmpacket.data.add("sPOType", $("#p_POType").val());                    //工单处理结果
	core.ajax.sendPacket(cfmpacket,OPDropRtn,false);
	cfmpacket=null;
}
function OPDropRtn(cfmpacket)
{
  var retCode = unescape(cfmpacket.data.findValueByName("retCode"));
	var retMsg = unescape(cfmpacket.data.findValueByName("retMsg"));	
	if(retCode=="000000"){			
    rdShowMessageDialog("操作成功！",1);
    window.location="f7416_1.jsp?opCode=7416&opName=动力100订单工单处理"	;
    //parent.removeTab('<%=opCode%>');		 	
  }else{
		rdShowMessageDialog("错误信息："+retMsg+" 错误代码："+retCode,0);	
     window.location="f7416_1.jsp?opCode=7416&opName=动力100订单工单处理"	;
    //parent.removeTab('<%=opCode%>');		
	}
}
</script>
