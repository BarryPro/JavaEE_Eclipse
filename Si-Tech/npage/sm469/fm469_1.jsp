
<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------duming 2017.4.13------------------
 关于新固话产品账期调整情况及现存问题报备的函  信用账期变更
 
 
 -------------------------后台人员：gudd--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");

%> 

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
	
	
<%	
     String sqlStrl ="select * from sgrpcreditctrl where ctrl_flag='1'";
  %> 	
    <wtc:service name="TlsPubSelCrm" outnum="100" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlStrl%>" />
		</wtc:service>
		<wtc:array id="resultl" scope="end" />
<SCRIPT language=JavaScript>

$(function(){ 
　　$("#myselect").change(function(){
		
    var i =  $('#myselect option:selected').val();
  	var a = $('#myselect option:selected').attr('v_oval');
  		 //alert("01234---"+a);
   		// alert("序号="+i);
   		 
 		
   	switch (a) {
   		case '1':
   			 $("#other_value option[value=1]").attr("selected",true);
   		break;
   		case '2':
   			 $("#other_value option[value=2]").attr("selected",true);
   		break;
   		case '3':
   			 $("#other_value option[value=3]").attr("selected",true);
   		break;
   		default:
   			$("#other_value option[value=0]").attr("selected",true);
   	}
   
		});
}); 


function go_Cfm(){
		var other_value = $("#other_value option:selected").text();
 		//alert(other_value);
 		var external_code = $('#myselect option:selected').attr('v_code');
 		//alert("v_code---"+external_code);
    var packet = new AJAXPacket("fm469_Cfm.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("other_value",other_value);// 信用账户
         packet.data.add("external_code",external_code);// 品牌编码
    core.ajax.sendPacket(packet,do_Cfm);
    packet =null;
    
      reSetThis();//强制重置
}

function do_Cfm(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息

	 if(code!="000000"){//调用服务失败
      rdShowMessageDialog(code+":"+msg);
	    return;
    }else{//操作成功
	    rdShowMessageDialog("操作成功",2);
    }
     
}


function reSetThis(){
	location = location;
}

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">品牌</td>
			<td width="15%">
		  	<select id="myselect" name="myselect" style = "width:180px;" >
				   	<option >请选择</option>
				   	<% 
				   	if(resultl.length>0){
				   		for(int i=0;i<resultl.length;i++){
				   	%>
				    <option v_oval='<%=resultl[i][7]%>' v_code='<%=resultl[i][0]%>'  value=<%=i+1%>><%=resultl[i][6]%></option>
				    <%
							}	
							}	    	
				    %>
				    
				</select>
		  </td>
		 	<td>
			    <select  id="other_value">
			    	<option value="0" selected>0</option>	
			    	<option value="1">1</option>	
			    	<option value="2">2</option>	
			    	<option value="3">3</option>	
			    
			    </select>
		  </td>
	</tr>
	<tr>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="修改" onclick="go_Cfm()"            />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
<%@ include file="/npage/include/public_smz_check.jsp" %>
</FORM>
</BODY>
</HTML>