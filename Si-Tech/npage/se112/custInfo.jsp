<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	//date 20140711
	
	//String xml = request.getParameter("reScore");
	String meansId = request.getParameter("meansId");
	//String vCurPoint = request.getParameter("vCurPoint");
	//String subScore=request.getParameter("subScore");
	//String brandId=request.getParameter("brandId");
	//String payMoney = request.getParameter("payMoney");
	//String resourcefee = request.getParameter("resourcefee");

 	MapBean mb = new MapBean();
 %>	
 <%-- <%@ include file="getMapBean.jsp"%> --%>
 <%		
/* 	Iterator it =null;
	
	List custList = null;
		if(null != mb){
		custList = mb.getList("OUT_DATA.H22");
		System.out.println("_________custList________" + custList.toString());
		
		if(null!=custList)
			it =custList.iterator();
	} */


 %>
<html>
	<head>
	<title>异网号码校验</title>
	</head>
	<body >
		<div id="operation">
		<form method="post" name="frm1147" action="">
				
				<div id="operation_table">
	
					 <div class="input">
					   <table>
					   		<tr>
								<th>异网号码</th>
								<td>
									<input type="text" name="vOtherPhoneNo" id="vOtherPhoneNo" value="" onfocus="check_change()"/>
								</td>
								<td>	
									<input type="button" class="b_text" name="verify" id="verify" onclick="comit()" value="校验" />
									<font style="color:red"><b>*</b></font>
								</td>
							</tr>
						</table>
						</div>
					<div id="operation_button">
						 <input type="button" class="b_foot" value="确定" id="btnSubmit" disabled="disabled"
							name="btnSubmit" onclick="btnRsSubmit()" />
						<input type="button" class="b_foot" value="关闭" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">
	
	function check_change(){
		$("#btnSubmit").attr("disabled",true);
	}
	
	function comit(){
		var otherPhoneNo = document.getElementById("vOtherPhoneNo").value;
		if(!isTel(otherPhoneNo)){
			showDialog("请输入正确的手机号码格式！",1);
			return false;
		}
		var packet = null;
		packet = new AJAXPacket("custVerifyComit.jsp","请稍后...");
		packet.data.add("otherPhoneNo",otherPhoneNo);
		packet.data.add("meansId","<%=meansId%>");
		core.ajax.sendPacketHtml(packet,doComitCat,true);
		packet =null;
		
	}
	
	function doComitCat(data){
		var datas =data.split("~");
		
		if("000000"==trim(datas[0])){
			showDialog("校验成功!",2);
			$("#btnSubmit").attr("disabled",false);
		}else{
			showDialog(trim(datas[2]),0);
			return false;
		}
	} 
	
	 function btnRsSubmit(){
		 var otherPhoneNo = document.getElementById("vOtherPhoneNo").value;
		 var Desc = "异网号码："+otherPhoneNo;
		 parent.document.getElementById("custInfoDetails<%=meansId%>").innerHTML = Desc;
		//提交报文
		parent.h22CustData(otherPhoneNo);
		parent.h22CustInfo_Checkfuc();
		closeDivWin();
	 }
	
	function closeWin(){
			closeDivWin();
	}
	
	function isTel(v){
		var mobilePatrn = /^((\(\d{3}\))|(\d{3}\-))?1[3,5,8]\d{9}$/;
		if(mobilePatrn.exec(v)) {
			return true;
		} else {
			return false;
		}
	}
	</script>
</html>