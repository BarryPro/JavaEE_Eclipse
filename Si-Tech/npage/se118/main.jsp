<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se118/public_title_name.jsp"%>
<%
	String loginNo = (String)session.getAttribute("workNo");//操作员登陆工号
	String password = (String)session.getAttribute("password");//操作员登陆工号密码
	String group_id = (String)session.getAttribute("groupId");
	String phoneNo = (String)request.getParameter("activePhone");//手机号
	String opCode = (String)request.getParameter("opCode");	//crm传过来的
	System.out.println("++++++++++++++++++++++e118 group_id="+group_id);
	System.out.println("++++++++++++++++++++++e118 loginNo="+loginNo);
	System.out.println("++++++++++++++++++++++e118 password="+password);
	System.out.println("++++++++++++++++++++++e118 phoneNo="+phoneNo);
	System.out.println("++++++++++++++++++++++e118 opCode="+opCode);
	
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>营销活动冲正</title>
	</head>
	<body>
		<%--@ include file="/npage/include/header.jsp"--%>
	<div id="operation">
	<html:form action="/f4939" method="post">
 	<div id="operation_table">
 		<div class="title">
			<div class="text">
				销售流水
			</div>
		</div>
			<div class="input">	
				<table>
					<tr>
						<th>
							销售流水
						</th>
						<td>
							<input type="text" name="saleSeq" id="saleSeq" value=""/>
							<%--<html:text property="saleSeq" styleId="saleSeq"/>--%>
						</td>

					</tr>
				</table>
		</div>
		<input type="hidden" id="checkResult" name="checkResult"  value="">
		<div id="operation_button">
			<input class="b_foot" type="button"  name="qry" id="qry" value="查询" onclick="checkSeq();">
		  	&nbsp; 
		  <input class="b_foot" type="button" name="re" value="重置"	onclick="reset();" />
		</div>
	</div>
	</html:form>
	</body>
<script>
	function checkSeq(serialId, actId, actName, feeSum, brandCode, resouceCode){
		var saleSeq = $.trim(document.getElementById("saleSeq").value);
		if(saleSeq == ""){
			rdShowMessageDialog("请输入销售流水号",1);
			return false;
		}
		window.open("<%=request.getContextPath()%>/npage/se118/f4939_attention.jsp?loginNo=<%=loginNo%>&password=<%=password%>&group_id=<%=group_id%>&saleSeq="+saleSeq+"&phoneNo=<%=phoneNo%>&loginNo=<%=loginNo%>",'冲正退费提醒','width=500px,height=200px');
	}
	function retSeq(){
		  var saleSeq = $.trim(document.getElementById("saleSeq").value);
		var packet = null;
		packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se118/f4939_checkSeq.jsp","请稍后...");//调用校验服务。。返回对应信息
		packet.data.add("saleSeq",saleSeq);
		packet.data.add("loginNo","<%=loginNo%>");
		packet.data.add("password","<%=password%>");
		packet.data.add("group_id","<%=group_id%>");
		packet.data.add("phoneNo","<%=phoneNo%>");
		packet.data.add("opCode","<%=opCode%>");
		core.ajax.sendPacketHtml(packet,doFunction,true);
		packet =null;
	}

	function doFunction(data){
		var sdata = data.split("~");
		var retCode1 = sdata[0];
		var retMsg1 = sdata[1];
		var retCode2 = sdata[2];
		var retMsg2 = sdata[3];
		var retCode3 = sdata[4];
		var retMsg3 = sdata[5];
		if(retCode1 == 0){
				if(retCode2 ==0){
					if(retCode3 ==0){
						$("#qry").attr("disabled","disabled");
						jumpPage();
					}else{
						rdShowMessageDialog(retMsg3,1);
					}
				}else{
					rdShowMessageDialog(retMsg2,1);
					//将流水域置为空
			    $("#saleSeq").val("");
				return;
				}
		}else{
		  rdShowMessageDialog(retMsg1,1);
			return false;
		}		
	}
	function jumpPage(){
	  var saleSeq = document.getElementById("saleSeq").value;
	  var opcode="g795";
	  var opName="营销案冲正";
	  var param = "opCode="+opcode+"&opName="+opName+"&saleSeq="+saleSeq+"&activePhone=<%=phoneNo%>";
				url="/npage/s1170/f1170Main.jsp?"+param;
				location = url;
	}
	function reset(){
	  $("#saleSeq").val("");
	}
</script>

</html>
