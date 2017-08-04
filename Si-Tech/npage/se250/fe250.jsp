<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%@ include file="/npage/sq100/getIccidFtpPas.jsp" %>
<head>
	<title>测试</title>
	<%
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);

		String opCode = "e250";
		String opName = "国开行锚定申请";
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		
		%>
		<script language="javascript">

		function checksp(obs) {//判断输入数据是否符合逻辑

				 while ($("#phoneNo").val().indexOf(" ") != -1) {//解决入参空格导致服务down掉
			   $("#phoneNo").val($("#phoneNo").val().replace(" ", ""));
		     }
		     	while ($("#phoneNo").val().indexOf("\n") != -1) {//去掉回车符，回车符占一个位置
			   $("#phoneNo").val($("#phoneNo").val().replace("\n", ""));
		     }
       var  sn = 	$("#phoneNo").val().length;
				if(sn<12 && sn!=11) {
					checkElement(obs);	
				}
				if(sn>12) {
					var txt3=document.getElementById("phoneNo").value.split("|");//将phoneNo中的文本定义成数组

						if(txt3.length==1) {
								if(sn!=12) {
								checkElement(obs);
							}
						}
						if(txt3.length>1) {
			
							if(sn!=((txt3.length-1)*11+txt3.length-1)) {
								checkElement(obs);
							}
							else {
								 hiddenTip(document.all.phoneNo);
							}
						}
		
				}
				if(sn==11) {//输入的号码为11位时候
					var txt1=document.getElementById("phoneNo").value.split("|");
		
						checkElement(obs);
							if(checkElement(obs)==true) {
								if(txt1.length==1) {
								rdShowMessageDialog("请在号码后面加上竖线",1);
							 }
						  }
					
				}
				if(sn==12) {//输入号码为12位时候
					var txt1=document.getElementById("phoneNo").value.split("|");
						
						if(txt1.length==1) {
							
							rdShowMessageDialog("请在号码后面加上竖线",1);
						}
						if(txt1.length!=2 && txt1.length!=1) {
						  checkElement(obs);
						}
						if(txt1.length==2) {
						 hiddenTip(document.all.phoneNo);
						}
				}
		}
		
		function comiitps() {
		    
				while ($("#phoneNo").val().indexOf(" ") != -1) {//解决入参空格导致服务down掉
		   $("#phoneNo").val($("#phoneNo").val().replace(" ", ""));
	     }
	     	while ($("#phoneNo").val().indexOf("\n") != -1) {//去掉回车符，回车符占一个位置
			   $("#phoneNo").val($("#phoneNo").val().replace("\n", ""));
		     }
     	var obs =(document.all.phoneNo);
      var  sn = 	$("#phoneNo").val().length;
				if(sn<12 && sn!=11) {
					checkElement(obs);	
				}
				if(sn>12) {
					var txt3=document.getElementById("phoneNo").value.split("|");//将phoneNo中的文本定义成数组
		
						if(txt3.length==1) {
								if(sn!=12) {
								checkElement(obs);
							}
						}
					if(txt3.length>1) {
		
							if(sn!=((txt3.length-1)*11+txt3.length-1)) {
								checkElement(obs);
							}
							else {
								 hiddenTip(document.all.phoneNo);
								 frm1();
							}
					}
		
				}
				if(sn==11) {//输入的号码为11位时候
					var txt1=document.getElementById("phoneNo").value.split("|");
		
						checkElement(obs);
						if(checkElement(obs)==true) {
								if(txt1.length==1) {
								rdShowMessageDialog("请在号码后面加上竖线",1);
							 }
					  }
					
				}
				if(sn==12) {//输入号码为12位时候
					var txt1=document.getElementById("phoneNo").value.split("|");
						
							if(txt1.length==1) {							
								rdShowMessageDialog("请在号码后面加上竖线",1);
							}
							if(txt1.length!=2 && txt1.length!=1) {
							  checkElement(obs);
							}
							if(txt1.length==2) {
						 hiddenTip(document.all.phoneNo);
						 frm1();
						}
				}
		}
		 function frm1() {
		 	document.frm.quchoose.disabled=true;
		 	frm.submit();
		 	return true;
		 }
		
		</script>
		<body >
		<form name="frm" method="POST" action="fe250_1.jsp">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">


						<tr>
			<td class="blue" width="15%">手机号码</td>
			<td>
				<textarea cols=34 rows=8 name="phoneNo" id="phoneNo" v_must="1" style="overflow:auto" v_type="mobphone" onblur="checksp(this)"/></textarea>

			<font class="orange">*</font> 
	</td>
	<td>
		  注：单个号码输入时请在号码后面加上“|”；
			<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;批量输入多个号码时请每一个号码后加“|”作为分隔符，并且最后一个号码也请用"|"作为结束。 
			<br>
			<br>&nbsp;例：单个号码输入：139********|
			<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;多个号码输入：139********|139********|
	</td>
	
		</tr>

		

			
	</table>


	 
	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">	
					<input type="button" name="quchoose" class="b_foot" value="确定" onclick="comiitps()" />		
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>

</form>
	<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>