<%
  /*
   * 功能: 12580主页面
　 * 版本: 1.0.0
　 * 日期: 2009/02/12
　 * 作者: libin
　 * 版权: sitech
   * update:chengh
　 */
%>
<%
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0);
%>
<%
	String tf32ty = (String)session.getAttribute("KFTF32");//用于判断是否呼入号码开通移动秘书服务
  String caphone = (String)session.getAttribute("capn");//呼入号码

%>
<html>
	<head>

		<script language="javascript">
		var totalphone;
		var total_phone;
		function connectphone(){
			window.showModalDialog('../../connectware.jsp','','dialogWidth:400px;dialogHeight:150px;center:1');
		}
		//chengh 
		function getPhone(){
			  var phone_call = "";
				if(window.top.cCcommonTool.getCaller() != undefined){
					document.getElementById("total_phone").value = window.top.cCcommonTool.getCaller();
				  if(window.top.cCcommonTool.getCaller().length<11){
				  	phone_call=window.top.cCcommonTool.getCaller();
				  }else{
				    phone_call="<%=caphone==null?"":caphone %>";
				  }
				}
				
				if(document.getElementById("ACCEPT_NO") != undefined){
					
					document.getElementById("ACCEPT_NO").value = '<%=caphone==null?"":caphone %>';
				}
				if(window.top.cCcommonTool.getCaller() != undefined && document.getElementById("ACCEPT_NO1") != undefined && '<%=caphone %>' != window.top.cCcommonTool.getCaller()){
					
					document.getElementById("ACCEPT_NO1").value = '<%=caphone==null?"":caphone %>';
				}
				divid.innerHTML = phone_call;			
		}
		/*function getPhone(){
			  var phone_call = "";
				if(window.top.cCcommonTool.getCaller() != ""){
					if(window.top.document.getElementById('acceptPhoneNo').value!=""){
						if(window.top.cCcommonTool.getCaller()!=window.top.document.getElementById('acceptPhoneNo').value){
					    phone_call=window.top.document.getElementById('acceptPhoneNo').value;
					  }else
					  	phone_call=window.top.cCcommonTool.getCaller();
				  }
				  if(window.top.document.getElementById('acceptPhoneNo').value==""){
				    phone_call=window.top.cCcommonTool.getCaller();
				  }
					
					document.getElementById("total_phone").value = window.top.cCcommonTool.getCaller();
					//if(phone_num!="10086"){
					//	phone_call = "<%=caphone %>";
				  //}
				  //else
				  //	phone_call = "10086";
			  }
			  if(window.top.cCcommonTool.getCaller() == ""){
			    if(window.top.document.getElementById('acceptPhoneNo').value!=""){
			      phone_call=window.top.document.getElementById('acceptPhoneNo').value;
			    }else
			    	phone_call="";
			  }
			  if(document.getElementById("ACCEPT_NO") != undefined){
					document.getElementById("ACCEPT_NO").value = '<%=caphone==null?"":caphone %>';
				}
				if(window.top.cCcommonTool.getCaller() != undefined && document.getElementById("ACCEPT_NO1") != undefined && '<%=caphone %>' != window.top.cCcommonTool.getCaller()){
					/*var phonenum = window.top.document.getElementById('acceptPhoneNo').value;
					var callNo="";
					if(window.top.cCcommonTool.getOp_code()=='K025')
					{
						callNo = window.top.cCcommonTool.getCalled();	
					}
					else
					{
						callNo = window.top.cCcommonTool.getCaller();
					}
					if(callNo==""){
						callNo = phonenum;
					}else{
						if(phonenum!=""&&callNo != phonenum){
								callNo = phonenum;
						}	
		      }
					document.getElementById("ACCEPT_NO1").value = '<%=caphone==null?"":caphone %>';
					//document.getElementById("ACCEPT_NO1").value = callNo;
				}
				divid.innerHTML = phone_call;			
		}*/
		function getHiscall(){
			
			total_phone = document.form1.total_phone.value;
			
			window.open('../../hisCall.jsp?phone='+total_phone,'','toolbar=no,menubar=no,width=600px,height=400px');
		}
		
		function callOff(){
		 
			var top_button_release=window.top.document.getElementById("K013");
			top_button_release.click();
		}
		</script>
	</head>
  <body onLoad="getPhone();">
  <form name="form1" method="post">
  	<input type="hidden" id="total_phone" name="total_phone" value="" />
  	<input type="hidden" id="tf32ty" name="tf32ty" value="<%=tf32ty==null?"":tf32ty %>" />
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	  <tr align="left">
	    <td><input type="button" class="b_foot" value="商旅中心" onClick="window.open('../../12580commodity.jsp');"><font size="3px" color="green">受理号码</font><font size="2px" color="red"><span id="divid"></span></font>&nbsp;<!--<input name="" type="button" class="b_foot_long" value="转商旅中心" onClick="connectphone();">--><input name="" type="button" class="b_foot" value="挂机" onClick="callOff();"><input name="" type="button" class="b_foot_long" value="查看历史呼叫信息" onClick="getHiscall();"></td>
	  </tr>	  
		</table>
	</form>
  </body>
</html>
