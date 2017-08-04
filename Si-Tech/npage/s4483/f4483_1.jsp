<%
    /********************
     * @ OpCode    :  4388
     * @ OpName    :  全网产品本省对应关系设置
     * @ CopyRight :  si-tech
     * @ Author    :  wangzn
     * @ Date      :  2010-3-6 14:21:25
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.GregorianCalendar" %>
<%
    String opCode = "4483";
    String opName = "全网产品本省对应关系设置";
    String workNo =(String)session.getAttribute("workNo");
		String workName =(String)session.getAttribute("workName");
		String powerRight =(String)session.getAttribute("powerRight");
		String Role =(String)session.getAttribute("Role");
		String orgCode =(String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String groupId =(String)session.getAttribute("groupId");
		String ip_Addr =(String)session.getAttribute("ip_Addr");
		
		
		
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title><%=opName%></title>
 <script type=text/javascript>
 	var params ="";
 	 function getIdNo(){
 	 	if(!checkElement(document.getElementById('cust_id'))){
				return false;
	  }
	  var cust_id = document.getElementById('cust_id').value;
	  var params =cust_id+"|"+"<%=regionCode%>|";
	  //var sqlStr = "SELECT a.id_no,a.user_name FROM dgrpusermsg a ,dbbossproductdeploy b WHERE a.id_no = b.id_no(%2B) AND a.sm_code='MM' AND b.product_id IS NULL AND a.cust_id = "+cust_id+"";
	  var sqlStr="90000165";
		
	  var selType = "S";    //'S'单选；'M'多选
		var retQuence = "0|1|";//返回字段
		var fieldName = "集团产品id|集团名称|";//弹出窗口显示的列、列名
    var pageTitle = "集团产品信息查询";
    var retToField="id_no|user_name|";
    var path = "/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path += "&params="+params;
    var retInfo = window.showModalDialog(path,"","dialogWidth:70;dialogHeight:35;");
    if(retInfo ==undefined){
    	return;
    }
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
 	
 	function getProductId(){
 		if(!checkElement(document.getElementById('product_id'))){
				return false;
	  }
	  var productSpec_number = document.form1.productSpec_number.options[document.form1.productSpec_number.selectedIndex].value;
	  params = productSpec_number+"|";
	  //var sqlStr = "SELECT a.product_id,b.productspec_name,e.customer_name FROM dProductOrderDet a ,dProductSpecInfo  b , dbbossproductdeploy c,dPoorderInfo d,dCustomerInfo e WHERE a.productspec_number = b.productspec_number AND a.product_id = c.product_id(%2B) AND c.id_no IS NULL AND a.id_no = 0 AND a.poorder_id = d.poorder_id AND d.customer_id = e.customer_id AND a.productspec_number ='"+productSpec_number+"'";
	  var sqlStr="90000164 ";
	  var selType = "S";    //'S'单选；'M'多选
		var retQuence = "0|";//返回字段
		var fieldName = "产品订购关系编码|产品规格名称|客户名称|";//弹出窗口显示的列、列名
    var pageTitle = "全网产品订购信息查询";
    var retToField="product_id|";
    var path = "/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path += "&params="+params;
    var retInfo = window.showModalDialog(path,"","dialogWidth:70;dialogHeight:35;");
    if(retInfo ==undefined){
    	return;
    }
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
 	function doSubmit(){
    	if(!check(form1)){
    		return;
    	}   	
    	if(rdShowConfirmDialog("确认要提交吗？")==1)
			{ 	
				form1.action="f4483_cfm.jsp"
				form1.submit();
				loading();
			}
    }
   
 </script>
</head>
<body>
<form name="form1" action="" method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<table cellspacing=0>
	<tr>
		<td class=blue>本省集团编码</td>
		<td class=blue>
			 <input type='text' name='cust_id' v_must='1' v_name='cust_id' id='cust_id' v_type='0_9'>
	     <font class='orange'>*</font>
    	 <input type='button' class='b_text' name='idNoQry' id='idNoQry' value='查询' onClick="getIdNo();" />
	 </td>
		<td class=blue>产品规格</td>
		<td class=blue>
		  <select name='productSpec_number'>
		     <option value='110802'>M2M通道型业务（GPRS）</option>
		  </select>	
		</td>
	</tr>
	<tr>
		<td class=blue>本省集团产品id</td>
		<td class=blue><input type='text' Class="InputGrey" name='id_no' v_must='1' v_name='id_no' id='id_no' v_type='0_9' readOnly></td>
		<td class=blue>本省集团用户名称</td>
	  <td class=blue><input type='text' Class="InputGrey" name='user_name' v_must='1' v_name='user_name' id='user_name' readOnly></td>
  </tr>
  <tr>
  	<td class=blue>全网产品</td>
  	<td>
  		<input type='text' name='product_id' v_must='0' v_name='product_id' id='product_id' v_type='0_9' readOnly />
	    <font class='orange'>*</font>
    	<input type='button' class='b_text' name='productIdQry' id='productIdQry' value='查询' onClick="getProductId();" />
  	</td>
  	<td>&nbsp;</td>
  	<td>&nbsp;</td>
  </tr>
</table>
    	

<TABLE cellSpacing=0>
    <TR id="footer">        
        <TD align=center>
            <input class="b_foot" name="sure" id="sure" type=button value="确认" onclick="doSubmit();"/>
            <input class="b_foot" name='clear2' id='clear2' type='button' value="清除" onClick="window.location='f4483_1.jsp';" />
       <input class="b_foot" name="close2"  onClick="removeCurrentTab()" type=button value="关闭" />
        </TD>
    </TR>
</TABLE>
<jsp:inclu     de page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>