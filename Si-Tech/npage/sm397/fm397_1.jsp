<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2016-8-31 10:19:13------------------
关于在CRM界面增加400及固话号码归属属性查询功能的需求
 
 
 -------------------------后台人员：xiahk--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  
	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%> 
	
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>



//重置刷新页面
function reSetThis(){
	  location = location;	
}


//查询客户基础信息
function doQuery(){
    var packet = new AJAXPacket("fm397_2.jsp","请稍后...");
    		packet.data.add("opCode","<%=opCode%>"); 
        packet.data.add("phoneIn",$("#phoneIn").val());
    core.ajax.sendPacket(packet,doGetAjaxInfo);
    packet =null;
}
//查询客户基础信息回调
function doGetAjaxInfo(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){// 
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{// 
	    var resultArray = packet.data.findValueByName("retArray");	
	    if(resultArray.length >0){
	    	$("#unit_name").text(resultArray[0][2]);
	    }
    }
}

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">查询条件</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">固话号码</td>
		  <td width="35%">
			    <input type="text" name="phoneIn" id="phoneIn" value="" /> 
			    <input type="button" class="b_text" value="查询" onclick="doQuery()"           />
		  </td>
		  
		  <td class="blue" width="15%">归属的集团名称</td>
		 
		  <td width="35%">
		  	 <span id="unit_name"></span>
		  </td>
		  
	</tr>
</table>
 

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>