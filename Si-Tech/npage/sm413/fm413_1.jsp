<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2016-10-8 17:04:40------------------
 关于对实名制管理中相关原则进行系统调整和报表开发的函（修改姓名和删除次数）
 
 
 -------------------------后台人员：xiahk/chenlina--------------------------------------------
 
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

	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	
	//out.print( new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()));
%> 

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>
 




//查询客户基础信息
function go_queryCustName(){
    var packet = new AJAXPacket("fm413_ajax_queryCustName.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo",$("#phoneNo").val());//
    core.ajax.sendPacket(packet,do_queryCustName);
    packet =null;
}
//查询客户基础信息回调
function do_queryCustName(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息
    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//操作成功
    	var old_custName = packet.data.findValueByName("custName");
	    var old_custaddr = packet.data.findValueByName("custAddr");
	    	
    	if(old_custName!=""){
	    	set_opr_tr();
	    	$("#phoneNo").attr("disabled","disabled");
	    	$("#btn_qry_phoneNo").attr("disabled","disabled");
	    	$("#upd_opType").attr("disabled","disabled");

	    	$("#old_custName").text(old_custName);
	    	$("#old_custaddr").text(old_custaddr);
    	}else{
    		rdShowMessageDialog("请输入正确的手机号码");
    	}
    	
    }
}


function go_Cfm(){
		
		var new_custName = "";
		
		var iOpType  = "";/*操作类型0改姓名;1改地址*/
		var iOpValue = "";
		var iOpmemo  = "";
		
		if("upd_name"==$("#upd_opType").val()){
			if(checkElement(document.msgFORM.new_custName)){
				if(!checkCustNameFunc16New(document.msgFORM.new_custName,0,0)){
					return;
				}
			}else{
				return;
			}    
		
		
			iOpType  = "0";
			iOpValue = $("#new_custName").val().trim();
			iOpmemo  = "备注：修改客户名称";
			new_custName = $("#new_custName").val().trim(); 

		}
		if("upd_ad"==$("#upd_opType").val()){
			if($("#new_addr").val().trim()==""){
				rdShowMessageDialog("请输入新客户地址");
				return;
			}  
			
			var m = /^[\u0391-\uFFE5]*$/;
			var chinaLength = 0;
			for (var i = 0; i <$("#new_addr").val().trim().length; i ++){
		        var code = $("#new_addr").val().trim().charAt(i);//分别获取输入内容
		        var flag = m.test(code);
		        if(flag){
		        	chinaLength ++;
		        }
		  }
    	if(chinaLength < 8){
				rdShowMessageDialog("新客户地址必须含有至少8个中文汉字！");
				$("#new_addr").val("");
				return;
			}
    
			iOpType = "1";
			iOpValue = $("#new_addr").val().trim();
			iOpmemo  = "备注：修改客户地址";
		}		
		
		
    var packet = new AJAXPacket("fm413_updCfm.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo",$("#phoneNo").val());//
        packet.data.add("iOpType",iOpType);//
        packet.data.add("iOpValue",iOpValue);//
        packet.data.add("iOpmemo",iOpmemo);//
        packet.data.add("new_custName",new_custName);//
    core.ajax.sendPacket(packet,do_Cfm);
    packet =null;
	
}

function do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息
    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg,0);
	    return;
    }else{//操作成功
    	rdShowMessageDialog("操作成功",2);
    	reSetThis();
    }
}


function reSetThis(){
	location = location;
}


//操作类型
function set_opr_tr() {
	var opType = $("#upd_opType").val();
	if("upd_name"==opType){
		$("#tr_old_custname").show();
		$("#tr_new_custname").show();
		
		$("#tr_old_custaddr").hide();
		$("#tr_new_custaddr").hide();
		
	}
	if("upd_ad"==opType){
		$("#tr_old_custname").hide();
		$("#tr_new_custname").hide();
		
		$("#tr_old_custaddr").show();
		$("#tr_new_custaddr").show();
		
	}
		
}



</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>

<table cellSpacing="0">

		<tr>
	    <td class="blue"  width="15%">操作类型</td>
		  <td colspan="3">
		  	<select id="upd_opType"   >
				    <option value="upd_name">客户名称</option>
				    <option value="upd_ad">客户地址</option>
				</select>
		  </td> 
	</tr>	
		
		<tr>
			  <td class="blue" width="15%">手机号码</td>
		  <td width="35%">
			    <input type="text"  name="phoneNo" id="phoneNo"  maxlength="11" value="" />
			    <input type="button" class="b_text" value="查询" id="btn_qry_phoneNo" onclick="go_queryCustName()" />
		  </td>	
		</tr>
	
		<tr id="tr_old_custname"    style="display:none">
	  
		  <td class="blue"  width="15%">客户姓名</td>
		  <td>
			    <span id="old_custName"></span>
		  </td>
	</tr>
	<tr id="tr_new_custname"  style="display:none">
	    <td class="blue">新客户姓名</td>
		  <td colspan="3">
			    <input name=new_custName id="new_custName" value="" v_must="1"  maxlength="30" v_type="string"    onblur="if(checkElement(this)){checkCustNameFunc16New(this,0,0)}">
		  </td>
	</tr>

	

	<tr id="tr_old_custaddr" style="display:none;">
		  <td class="blue"  width="15%">客户地址</td>
		  <td>
			    <span id="old_custaddr"></span>
		  </td>
	</tr>
	<tr id="tr_new_custaddr" style="display:none;">
	    <td class="blue">新客户地址</td>
		  <td colspan="3">
			    <input  name="new_addr" id="new_addr" value="" size="100"   v_must="1"   v_type="string"   maxlength="30"   />
		  </td>
	</tr>

</table>


<table cellSpacing="0" style="display:">
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