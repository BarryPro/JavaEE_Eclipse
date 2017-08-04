<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年10月25日
　 * 作者: piaoyi
　 * 版权: sitech
   * 修改历史
   * 修改日期 2008.12.17     修改人 leimd     修改目的
 　*/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	String workName = (String)session.getAttribute("workName");
    String ipAddr = (String)session.getAttribute("ipAddr");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String opCode="2035";
	String opName="成员签约关系管理";  
	String sqlStr="";
%>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<html>
<link href="s2002.css" rel="stylesheet" type="text/css">
<script>
	function getCustomerNumber(){
		var pageTitle = "订购信息";
	    var fieldName = "产品订单号|订单来源|生效时间|产品状态|";
	    var sqlStr = "";
	    var selType = "S";    //'S'单选；'M'多选
	    var retQuence = "4|0|1|2|3|";
	    var flag="";
	    if($("#operType").val()=="5")
	    {
	    	flag="1";
	    }
	    else
	    {
	    	flag="0";
	    }
	    var retToField = "productID|orderSource|p_AccessNumber|p_PriAccessNumber|";
	
	    var path = "<%=request.getContextPath()%>/npage/s2002/f2035_getCustomerNumber.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName="+fieldName;
	    path = path + "&selType="+selType;
	    path = path + "&retQuence="+retQuence;
	    path = path + "&retToField="+retToField;
	    path = path + "&s_OrderSource=" +$("#orderSource").val();
	    path = path + "&s_ProductID=" +$("#productID").val();
	    path = path + "&s_flag="+flag;
	    retInfo = window.open(path,
	                          "newwindow",
	                          "height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	    return true;
		
	}
	
	function toNextPage(){
	    if(check(form1)){
	    	getProduct();
			var operType = document.all.operType.value;
			if(operType=="1"){
				document.form1.action="f2035_2.jsp";
				document.form1.submit();
			}else if(operType=="5"){
				document.form1.action="f2035_5.jsp";
				document.form1.submit();
			}
			else if(operType=="6"){
				document.form1.action="f2035_7.jsp";
				document.form1.submit();
			}
			else{
				document.all.orderSourceName.value = document.getElementById("orderSource").options[document.getElementById("orderSource").selectedIndex].innerText;;
				document.form1.action="f2035_4.jsp";
				document.form1.submit();	
			}
	    }
	}
function getProduct()//获取产品规格编码
{
    var getProduct_Packet = new AJAXPacket("f2035_getProductSpecNumber.jsp","正在获取产品规格编码，请稍候......");
	getProduct_Packet.data.add("retType","getProduct");
    getProduct_Packet.data.add("productId",$("#productID").val());
	core.ajax.sendPacket(getProduct_Packet);
	getProduct_Packet=null;
}
function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");			
	if(retType=="getProduct")
    {
    	if(retCode="000000")
    	{ 
    			var productSpecNum = packet.data.findValueByName("productSpecNum");
    			document.all.productSpecNum.value = productSpecNum;			    			
    	}
    	else
    	{		    	
    		rdShowMessageDialog(retMessage);
    	}
    }			
}		
function setButtonUse() {
		document.all.nextoper.disabled=true;
}
</script>
</head>
<body>
<form name="form1" method="post">
	<input type="hidden" name="pageOpCode" value="<%=opCode%>">
	<input type="hidden" name="pageOpName" value="<%=opName%>">
	<input type="hidden" id="grpIdNo" name="grpIdNo" value="">
	<input type="hidden" name="productSpecNum" value="">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">产品订单信息</div>
</div>
<table cellspacing=0>
	<tr>
		<td class="blue" width="15%">
		 	产品订购关系编码
		</td>
		<td  width="35%">       
			<input name="productID" id="productID" v_type="string"  v_must="1" size="20" maxlength="20" onChange="setButtonUse()">
				<font class="orange">*</font>              
			<input name="CustomerNumberQuery" type="button" class="b_text" onclick="getCustomerNumber()" id="getCustomerNumberBtn" value="查询">                      
		</td>
		<td class="blue"  width="15%">
			订单来源
		</td>
	    <td  width="35%">
	    	<select name="orderSource" id=orderSource>
               <option value='0'>省BOSS上传 </option>
	  			<option value='1'>EC上传</option>
	  			<option value='2'>BBOSS受理</option>
      		</select>
      			<input type="hidden" value="" name="orderSourceName">    	           
    		</td>    
	</tr>
    <tr>
    	<td class="blue"  width="15%" >
    		操作类型
    	</td>
    	<td  width="85%" colspan="3">       
      		<select name="operType" id="operType" width=50>  			
	  			<option value='5'>查询 </option>
	  			<option value='1'>新增 </option>
	  			<option value='0'>删除 </option>
	  			<!--<option value='2'>变更成员类型 </option>--><!--wuxy alter 20090709 去掉该操作类型-->
	  			<option value='3'>暂停成员 </option>
	  			<option value='4'>恢复成员 </option>
	  			<option value='6'>修改成员属性 </option>
      		</select>
      			<font class="orange">*</font>
		</td>   
	</tr>
	<tr>
    	<td align="center" id="footer" colspan="4">
      		<input class="b_foot" name=next id=nextoper type=button value="下一步" onclick="toNextPage()" disabled>
      		<input class="b_foot" name=reset type=button value="关闭" onClick="removeCurrentTab()">
    	</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
