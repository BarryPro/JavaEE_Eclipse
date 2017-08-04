<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)[2017/1/9 17:08:14]------------------
 关于流量伴侣卡业务的优化需求
 
 -------------------------后台人员：[wangzc]--------------------------------------------
 
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
<SCRIPT language=JavaScript>

//重置刷新页面
function reSetThis(){
	  location = location;	
}


//
function go_Query(){
	if($("#ipt_phoneNo").val().trim()==""){
		rdShowMessageDialog("请输入手机号码");
		return;
	}
	//m239·物联网业务开通状态查询  打印免填单后调用服务更新状态
 	var pactket = new AJAXPacket("fm444_Qry.jsp","正在进行电子工单状态修改，请稍候......");
 	
			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("phoneNo",$("#ipt_phoneNo").val().trim());
			core.ajax.sendPacket(pactket,do_Query);
			pactket=null;
}
// 回调
function do_Query(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
			var retArray = packet.data.findValueByName("retArray");
			//获取数组成功，动态拼接列表
			var trObjdStr = "";
			//第二次以后查询会有多余行数据，所以删除除了title以外行的数据
			$("#upgMainTab tr:gt(0)").remove();
						
						var td1 = "";
						var td2 = "";
						var td3 = "";
						var td4 = "";
						for(var i=0;i<retArray.length;i++){
							if("7005"==retArray[i][1]){
								td1 = "<td>"+retArray[i][0]+"</td>";
							}
							if("7006"==retArray[i][1]){
								td2 = "<td>"+retArray[i][0]+"</td>";
							}
							td3 = "<td>"+retArray[i][2]+"</td>";
							td4 = "<td>"+retArray[i][3]+"</td>";
						}								
						
				trObjdStr += "<tr>"+
											td1+
											td2+
											td3+
											td4+
						         "</tr>";
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
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
		  <td class="blue" width="15%">手机号码</td>
		  <td class="blue"  >
		  	<input type="text" class="ipt_phoneNo" value="" id="ipt_phoneNo"   />
		  	 <input type="button" class="b_foot" value="查询" onclick="go_Query()"          />
		  </td>
		 
	</tr>
</table>

<div class="title"><div id="title_zi"><%=opName%>-查询结果列表</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="25%">主卡号码</th>
        <th width="25%">副卡号码</th>
        <th width="25%">办理时间</th>
        <th  >关系类型</th>
    </tr>
</table>

 

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>