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
    String opCode = "4484";
    String opName = "全网产品本省对应关系删除";
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
 	
 	function doSubmit(){
    	if(!check(form1)){
    		return;
    	}   	
    	if(rdShowConfirmDialog("确认要提交吗？")==1)
			{ 
				
				form1.action="f4484_cfm.jsp"
				form1.submit();
				loading();
			}
    }
   var params ="";
   function getDeployInfo(){
      if(!checkElement(document.getElementById('unit_id'))){
		  		return false;
	    }
      var unit_id = document.getElementById('unit_id').value;
      params = unit_id+"|";
      var sqlStr = "90000166";
	    var selType = "S";    //'S'单选；'M'多选
		  var retQuence = "0|1|2|3|4|";//返回字段
		  var fieldName = "本省集团名称|产品订购编号|全网客户名称|产品规格编码|产品规格名称|";//弹出窗口显示的列、列名
      var pageTitle = "全网产品本省对应关系信息查询";
      var retToField="cust_name|product_id|customer_name|productSpec_number|productSpec_name|";
      var path = "/npage/public/fPubSimpSel.jsp";
      path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
      path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
      path = path + "&selType=" + selType;
      path += "&params="+params;
      //alert(path);
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
		<td class=blue>本省集团编号</td>
		<td class=blue>
			 <input type='text' name='unit_id' v_must='1' v_name='unit_id' id='unit_id' v_type='0_9'>
	     <font class='orange'>*</font>
    	 <input type='button' class='b_text' name='idNoQry' id='idNoQry' value='查询' onClick="getDeployInfo();" />
	 </td>
	 <td class=blue>本省集团名称</td>
		<td class=blue>
			 <input type='text' name='cust_name' v_must='1' v_name='cust_name' id='cust_name' Class="InputGrey" readOnly />   	 
	 </td>
	</tr>
	<tr>
	 	 <td class=blue>产品订购关系编码</td>
	   <td class=blue>
	   	 <input type='text' name='product_id' v_must='1' v_name='product_id' id='product_id' v_type='0_9' Class="InputGrey" readOnly />   	 
	   </td>
	   <td class=blue>全网客户名称</td>
	   <td class=blue>
			 <input type='text' name='customer_name' v_must='1' v_name='customer_name' id='customer_name' Class="InputGrey" readOnly />   	 
	   </td>
	</tr>
	<tr>
	   <td class=blue>产品规格编码</td>
	   <td class=blue>
	   	 <input type='text' name='productSpec_number' v_must='1' v_name='productSpec_number' id='productSpec_number' v_type='0_9' Class="InputGrey" readOnly />   	 
	   </td>
	   <td class=blue>产品规格名称</td>	
	   <td class=blue>
			 <input type='text' name='productSpec_name' v_must='1' v_name='productSpec_name' id='productSpec_name' Class="InputGrey" readOnly />   	 
	   </td>	
	</tr>   	
</table>
    	

<TABLE cellSpacing=0>
    <TR id="footer">        
        <TD align=center>
            <input class="b_foot" name="sure" id="sure" type=button value="确认" onclick="doSubmit();"/>
            <input class="b_foot" name='clear2' id='clear2' type='button' value="清除" onClick="window.location='f4484_1.jsp';" />
       <input class="b_foot" name="close2"  onClick="removeCurrentTab()" type=button value="关闭" />
        </TD>
    </TR>
</TABLE>
<jsp:inclu     de page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>