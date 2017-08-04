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
function getAjaxInfo(){
    var packet = new AJAXPacket("ajaxGetServRe.jsp","请稍后...");
        packet.data.add("servName","sWIflowQry");//服务名称
        packet.data.add("phone_no",PHONE_NO);//手机号
        packet.data.add("cust_name",$("#cust_name").val());//客户姓名
    core.ajax.sendPacket(packet,doGetAjaxInfo);
    packet =null;
}
//查询客户基础信息回调
function doGetAjaxInfo(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code=="000000"){//操作成功
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//调用服务失败
	    var resultArray = packet.data.findValueByName("resultArray");	
    }
}

function show_tab_optype(optype){
	if(0==optype){
		$("#tab_optype_1").show();
		$("#tab_optype_2").hide();
		$("#tab_optype_3").hide();
	}
	if(1==optype){
		$("#tab_optype_1").hide();
		$("#tab_optype_2").show();
		$("#tab_optype_3").hide();
	}
	if(2==optype){
		$("#tab_optype_1").hide();
		$("#tab_optype_2").hide();
		$("#tab_optype_3").show();
	}
}

$(document).ready(function(){
	show_tab_optype(0);
});



function go_cfm(){
	var optype = $("input[name='optype']:checked").val();
	if(optype=="0"){
		if($("#phoneIn").val().trim()==""){
			rdShowMessageDialog("请输入固话号码");
			return;
		}
	} 
	
	if(optype=="1"){
		if($("#feefile").val().trim()==""){
			rdShowMessageDialog("请选择文件");
			return;
		}
	} 
	
	if(optype=="2"){
		if($("#phoneNo_b").val().trim()==""||$("#phoneNo_e").val().trim()==""){
			rdShowMessageDialog("开始号码、结束号码必须输入");
			return;
		}
		
		if(parseInt($("#phoneNo_b").val().trim())>parseInt($("#phoneNo_e").val().trim())){
			rdShowMessageDialog("开始号码不大于结束号码");
			return;
		}
		
		if(parseInt($("#phoneNo_e").val().trim())-parseInt($("#phoneNo_b").val().trim())>10000){
			rdShowMessageDialog("结束号码与开始号码差值不能超过10000");
			return;
		}
		
	} 
	
	
	if($("#unit_name").val().trim()==""){
			rdShowMessageDialog("请输入归属的集团名称");
			return;
	}
	
	if(optype=="0"){//单个

			document.msgFORM.action  = "fm398_Cfm.jsp?opCode=<%=opCode%>"+
																"&opName=<%=opName%>"+
																"&optype="+optype+
																"&unit_name="+$("#unit_name").val().trim()+
																"&phoneNo_b="+$("#phoneIn").val().trim()+
																"&phoneNo_e="+$("#phoneIn").val().trim()
																;

		
	}	
	if(optype=="1"){//文件
		
				document.msgFORM.action  = "fm398_file_Cfm.jsp?opCode=<%=opCode%>"+
																	"&opName=<%=opName%>"+
																	"&optype="+optype+
																	"&unit_name="+$("#unit_name").val().trim()+
																	"&phoneNo_b="+
																	"&phoneNo_e=";

	}
	if(optype=="2"){//号段
		
			document.msgFORM.action  = "fm398_Cfm.jsp?opCode=<%=opCode%>"+
																"&opName=<%=opName%>"+
																"&optype="+optype+
																"&unit_name="+$("#unit_name").val().trim()+
																"&phoneNo_b="+$("#phoneNo_b").val().trim()+
																"&phoneNo_e="+$("#phoneNo_e").val().trim()
																;

	}
	
	//alert(document.msgFORM.action);
	document.msgFORM.submit();
	
	
}

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM"     method="POST" ENCTYPE = "multipart/form-data"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">查询条件</div></div>


<table cellSpacing="0" >
	<tr>
	    <td class="blue" width="15%">操作类型</td>
		  <td >
			    <input type="radio" name="optype" id="optype_1" value="0" onclick="show_tab_optype(0)" checked/> 单个号码录入
			    <input type="radio" name="optype" id="optype_1" value="1" onclick="show_tab_optype(1)" /> 批量号码录入
			    <input type="radio" name="optype" id="optype_1" value="2" onclick="show_tab_optype(2)" /> 按照号码段录入
		  </td>
	</tr>
</table>

<!--单个号码录入-->
<table cellSpacing="0" id="tab_optype_1" style="display:none">
	<tr>
	    <td class="blue" width="15%">固话号码</td>
		  <td  >
			    <input type="text" name="phoneIn" id="phoneIn" value="" maxlength="11"/> 
		  </td>
		 
	</tr>
</table>

<!--批量号码录入-->
<table cellSpacing="0" id="tab_optype_2" style="display:none">
	<tr>
		<td colspan="4">
			<font class="orange">
				文件为txt格式，每行一条数据，不能超过500行，不能有空格和空行。<br>
				固话号码|<br>
				内容示例如下：<br>
				4001590459|<br>
				4001057157|<br>
			</font>
		</td>
	</tr>
	<tr>
	    <td class="blue" width="15%">导入文件</td>
		  <td  >
			    <input type="file" name="feefile" id="feefile" value="" /> 
		  </td>
	</tr>
		  
</table>

<!--按照号码段录入-->
<table cellSpacing="0" id="tab_optype_3" style="display:none">
	<tr>
	    <td class="blue" width="15%"  >开始号码</td>
		  <td width="35%">
			    <input type="text" v_type="int"  onblur = "checkElement(this)" name="phoneNo_b" id="phoneNo_b" value=""   /> 
		  </td>
		  <td class="blue" width="15%"  >结束号码</td>
		  <td width="35%">
			    <input type="text" v_type="int"  onblur = "checkElement(this)" name="phoneNo_e" id="phoneNo_e" value=""      /> 
		  </td>
	</tr>
	<tr>
		  
 
</table>


<table cellSpacing="0" >
	<tr>
		  <td class="blue" width="15%">归属的集团</td>
		  <td  >
		  	<input type="text" name="unit_name" id="unit_name"  v_type="string"  onblur = "checkElement(this)"  value="" /> 
		  </td>
	</tr>
</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定" onclick="go_cfm()"            /> 
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>