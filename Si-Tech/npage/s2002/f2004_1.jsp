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
  String workName = (String)session.getAttribute("workName");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String opCode="2004";
  String opName="商品产品规格信息管理";  
  String sqlStr="";
%>
<HTML>
<HEAD>
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<FORM name="form1" method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title"><div id="title_zi">商品规格信息</div></div>
<table cellSpacing=0>
  <tr>
    <td class="blue">
    商品规格编码
    </td>
    <td>
       <input type="text" name="p_POSpecNumber" id="p_POSpecNumber" v_type="0_9"  v_must="1" size="20" maxlength="18" value=""  onchange="clearbutton1()">       
       <input name="custQuery" type="button" class="b_text" onclick="getPOSpecNumber()" id="getPOSpecNumberBtn" value="查询">
       
    </td>
    <td class="blue">
    商品规格名称
    </td>
    <td>
      <input name="p_POSpecName" id="p_POSpecName" v_type="string"  v_must="1" size="25" maxlength="40" value="" >      
      
    </td>    
  </tr> 
  <tr>
    <td class="blue">
    商品规格状态
    </td>
    <td>      
      <select align="left" name="p_Status" id=p_Status width=50>
      <option value="">------不限制------</option>
       <%sqlStr ="select detail_code, detail_name from sbbossListCode where list_code = 'Status' order by detail_order ";%>
			 <wtc:qoption name="sPubSelect" outnum="2">			 
			 <wtc:sql><%=sqlStr%></wtc:sql>
			 </wtc:qoption>
      </select>
            
    </td>
    <td  class="blue">
    商品生效时间
    </td>
    <td>
      <input name="p_StartDate" id="p_StartDate" v_type="string" size="25" maxlength="20" value="" readonly>
      
    </td>
   </tr>
   <tr>
    <td class="blue">
    商品失效时间
    </td>
    <td>
      <input name="p_EndDate" id="p_EndDate" v_type="string" size="25" maxlength="20" value="" readonly>
      
    </td>
    <td class="blue">
    商品规格描述
    </td>
    <td >
      <input name="p_Description" id="p_Description" v_type="string" size="50" value="" readonly>
      
    </td>
  </tr>
</table>
<br>  
 <DIV id="div0_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div0_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">业务开放省</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv0">
	 	  <DIV id="wait0"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>
<DIV id="div1_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div1_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">商品规格资费列表</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv1">
	 	  <DIV id="wait1"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>

<DIV id="div2_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div2_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">产品规格信息列表</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv2">
	 	  <DIV id="wait2"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>
<table>
  <tr>
    <td align="center" id="footer" colspan="2">
      <!--<input class="b_foot" name=next id=nextoper type=button value="确认">-->
      <input class="b_foot" name=reset type=button value="关闭" onClick="parent.removeTab('<%=opCode%>')">
      <input class="b_foot" name=reset type=button value="清除" onClick="clearbutton()">
    </td>
  </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

<script type="text/javascript">
	var _jspPage =
	{"div0_switch":["mydiv0","f2004_EnableCompanys_list.jsp","f"]
	,"div1_switch":["mydiv1","f2004_POSpecRatePolicys_list.jsp","f"]
	,"div2_switch":["mydiv2","f2004_Products_list.jsp","f"]
	};
	function hiddenSpider()
	{
		document.getElementById("mydiv0").style.display='none';
		document.getElementById("mydiv1").style.display='none';
	  document.getElementById("mydiv2").style.display='none';
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
  		   		$("#"+tmp2[0]).load(tmp2[1],{sPOSpecNumber:$("#p_POSpecNumber").val()});
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


//调用公共界面，进行商品规格选择
function getPOSpecNumber()
{
    var pageTitle = "商品规格选择";
    var fieldName = "商品规格编码|商品规格名称|商品规格状态|商品生效时间|商品失效时间|商品规格描述|";
    var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "6|0|1|2|3|4|5|";
    var retToField = "p_POSpecNumber|p_POSpecName|p_Status|p_StartDate|p_EndDate|p_Description|";
                
    var path = "<%=request.getContextPath()%>/npage/s2002/f2004_getPOSpecNumber.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName="    +fieldName;
    path = path + "&selType="      +selType;
    path = path + "&retQuence="    +retQuence;
    path = path + "&retToField="   +retToField;
    path = path + "&sPOSpecNumber="+$("#p_POSpecNumber").val();
    path = path + "&sPOSpecName="  +$("#p_POSpecName").val();  
    path = path + "&sStatus="      +$("#p_Status").val();      
    path = path + "&sStartDate="   +$("#p_StartDate").val();   
    path = path + "&sEndDate="     +$("#p_EndDate").val();
    retInfo = window.open(path,
                          "newwindow", 
                          "height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
    return true;
}

function getPOSpecNumberRtn(retInfo)
{
    var retToField = "p_POSpecNumber|p_POSpecName|p_Status|p_StartDate|p_EndDate|p_Description|";
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
function clearbutton()
{
	$("#p_POSpecNumber").val("");
	$("#p_POSpecName").val("");
	$("#p_Status").val("");
	$("#p_StartDate").val("");
	$("#p_EndDate").val("");
	$("#p_Description").val("");
	//var targetContent = $( 'DIV.itemContent',this.parentNode.parentNode.parentNode);
	//targetContent.slideUp(300);
	$("div.itemContent").slideUp(30);
	$("img.closeEl").attr({ src: "../../../nresources/default/images/jia.gif"});
}

function clearbutton1()
{
	$("div.itemContent").slideUp(30);
	$("img.closeEl").attr({ src: "../../../nresources/default/images/jia.gif"});
}

</script>
