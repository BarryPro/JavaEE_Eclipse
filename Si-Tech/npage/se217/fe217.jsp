<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ include file="/npage/sq100/getIccidFtpPas.jsp"%>
<head>
<title>Boss彩铃下载</title>
<%
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);

		String opCode = "e217";
		String opName = "Boss彩铃下载";
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		
		%>
<script language="javascript">
      var radioss="11";
      var queryMessage1="";
      var queryMessage2="";
      var queryMessage3="";
      var lyhcount="0";
      var lycount="0";
      var mofacount="0";
      $(function() {
        init();
       });

		 function init() {	 	
			document.getElementById('lingyhradios').checked = true;
			var radio1 = document.getElementsByName("opFlag");
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
								  if(opFlag=="one")
								{	
								lyhcount="1";	
						  	document.all.iquerys1.style.display='block';
						  	document.all.iquerys2.style.display='none';
						  	document.all.iquerys3.style.display='none';
						    	//alert("执行铃音盒查询");
						    var getdataPacket = new AJAXPacket("fe217_qry.jsp","正在获得数据，请稍候......");
					      var phoneNo =$("#phoneNo").val();
					     	getdataPacket.data.add("phoneNo",phoneNo);
					     	getdataPacket.data.add("ptype","2");
					     	getdataPacket.data.add("querysType","lingyinhe");
								core.ajax.sendPacketHtml(getdataPacket,lingyinhequery,true);
								getdataPacket = null;
						    }
				    }
		     }
			}
			function opchange() {
					 var radio1 = document.getElementsByName("opFlag");
							  for(var i=0;i<radio1.length;i++)
				  {
				    if(radio1[i].checked)
					{
					  var opFlag = radio1[i].value;
									  if(opFlag=="one")
									  {
									  	document.all.iquerys1.style.display='block';
									  	document.all.iquerys2.style.display='none';
									  	document.all.iquerys3.style.display='none';
									  	radioss="11";
										  	if(lyhcount=="0") {//第一次查询铃音盒时调用服务
									    //alert("执行铃音盒查询22");
									       	var getdataPacket = new AJAXPacket("fe217_qry.jsp","正在获得数据，请稍候......");
									      var phoneNo =$("#phoneNo").val();
									     	getdataPacket.data.add("phoneNo",phoneNo);
									     	getdataPacket.data.add("ptype","2");
									     	getdataPacket.data.add("querysType","lingyinhe");
												core.ajax.sendPacketHtml(getdataPacket,lingyinhequery,true);
												getdataPacket = null;
											}
											else {//以后查询时候只取缓存数据
												$("#lingyin").hide();
												$("#mofa").hide();
												$("#lingyinhe").show();
												$("#query").empty();
											}
								
									    	
									  }else if(opFlag=="two")
									  {
									  	document.all.iquerys1.style.display='none';
									  	document.all.iquerys2.style.display='block';
									  	document.all.iquerys3.style.display='none';
									   radioss="22";
										   if(lycount=="0") {//第一次查询铃音时调用服务
									    //alert("执行铃音查询22");
									     lycount="1";	
									     $("#lingyinhe").hide();
									     $("#mofa").hide();
									     $("#query").empty();
									       	var getdataPacket = new AJAXPacket("fe217_qry.jsp","正在获得数据，请稍候......");
									      var phoneNo =$("#phoneNo").val();
									     	getdataPacket.data.add("phoneNo",phoneNo);
									     	getdataPacket.data.add("ptype","1");
									     	getdataPacket.data.add("querysType","lingyin");
												core.ajax.sendPacketHtml(getdataPacket,lingyinquery,true);
												getdataPacket = null;
											}
											else {//以后查询时候只取缓存数据
												$("#lingyinhe").hide();
												$("#mofa").hide();
												$("#lingyin").show();
													$("#query").empty();
											}
								
									  }
									  else if(opFlag=="three")
									  {
									  	document.all.iquerys1.style.display='none';
									  	document.all.iquerys2.style.display='none';
									  	document.all.iquerys3.style.display='block';
									   radioss="33";
										   if(mofacount=="0") {//第一次查询铃音时调用服务
									    //alert("执行铃音查询22");
									     mofacount="1";	
									     $("#lingyin").hide();
									     $("#lingyinhe").hide();
									     $("#query").empty();
									       	var getdataPacket = new AJAXPacket("fe217_magicqry.jsp","正在获得数据，请稍候......");
									      var phoneNo =$("#phoneNo").val();
									     	getdataPacket.data.add("phoneNo",phoneNo);
									     	getdataPacket.data.add("ptype","1");
									     	getdataPacket.data.add("querysType","mofa");
												core.ajax.sendPacketHtml(getdataPacket,mofaquery,true);
												getdataPacket = null;
											}
											else {//以后查询时候只取缓存数据
												$("#lingyinhe").hide();
												$("#lingyin").hide();
												$("#mofa").show();
													$("#query").empty();
											}
								
									  }
								}
				  }
			}
			
			
		function lingyinhequery(data){
				//找到添加表格的div
				var markDiv=$("#lingyinhe"); 
				var markDiv1=$("#lingyin"); 
				var markDiv3=$("#query"); 
				//清空原有表格
				markDiv.empty();

				markDiv3.empty();
				markDiv.append(data);
				$("#lingyinhe").show();
				
				
		}
				function lingyinquery(data){
				//找到添加表格的div
				var markDiv=$("#lingyin"); 
				var markDiv1=$("#lingyinhe");
					var markDiv3=$("#query"); 
				//清空原有表格

				markDiv3.empty();
				markDiv.empty();
				markDiv.append(data);
				$("#lingyin").show();
				
		}
						function mofaquery(data){
				//找到添加表格的div
				var markDiv=$("#mofa"); 
				var markDiv1=$("#lingyinhe");
					var markDiv3=$("#query"); 
				//清空原有表格

				markDiv3.empty();
				markDiv.empty();
				markDiv.append(data);
				$("#mofa").show();
				
		}
		
		function queryss() {
			   //alert("查询操作1");
		 var radio1 = document.getElementsByName("opFlag");
						  for(var i=0;i<radio1.length;i++)
			  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
							  if(opFlag=="one")
							  {
						
						    //alert("执行铃音盒查询22");
						      var getdataPacket = new AJAXPacket("fe217_qry.jsp","正在获得数据，请稍候......");
						      var phoneNo =$("#phoneNo").val();
						      var Pselect1 =$("#Pselect1").val();
						      var sele1 =$("#sele1").val();
						      queryMessage1 = sele1;
						     // alert(Pselect1);
						     // alert(sele1);
						      getdataPacket.data.add("qtypes",Pselect1);
						      getdataPacket.data.add("sele",sele1);
						     	getdataPacket.data.add("phoneNo",phoneNo);
						     	getdataPacket.data.add("ptype","2");
						     	getdataPacket.data.add("querysType","lingyinhequery");
									core.ajax.sendPacketHtml(getdataPacket,queryResult,true);
									getdataPacket = null;
						
							    	
							  }else if(opFlag=="two")
							  {
						
						    //alert("执行铃音查询22");
						      var getdataPacket = new AJAXPacket("fe217_qry.jsp","正在获得数据，请稍候......");
						      var phoneNo =$("#phoneNo").val();
						      var Pselect1 =$("#Pselect2").val();
						      var sele1 =$("#sele2").val();
						      //alert(Pselect1);
						      //alert(sele1);
						      queryMessage2 = sele1;
						      getdataPacket.data.add("qtypes",Pselect1);
						      getdataPacket.data.add("sele",sele1);
						     	getdataPacket.data.add("phoneNo",phoneNo);
						     	getdataPacket.data.add("ptype","1");
						     	getdataPacket.data.add("querysType","lingyinquery");
									core.ajax.sendPacketHtml(getdataPacket,queryResult,true);
									getdataPacket = null;
						
							  }
							  else if(opFlag=="three")
							  {
						
						    //alert("执行铃音查询22");
						      var getdataPacket = new AJAXPacket("fe217_magicqry.jsp","正在获得数据，请稍候......");
						      var phoneNo =$("#phoneNo").val();
						      var Pselect1 =$("#Pselect3").val();
						      var sele1 =$("#sele3").val();
						      //alert(Pselect1);
						      //alert(sele1);
						      queryMessage3 = sele1;
						      getdataPacket.data.add("qtypes",Pselect1);
						      getdataPacket.data.add("sele",sele1);
						     	getdataPacket.data.add("phoneNo",phoneNo);
						     	getdataPacket.data.add("ptype","3");
						     	getdataPacket.data.add("querysType","mofaquery");
									core.ajax.sendPacketHtml(getdataPacket,queryResult,true);
									getdataPacket = null;
						
							  }			
						}		
			  }

		}
			function queryResult(data){
						if(radioss=="11") {
				   		document.getElementById('lingyhradios').checked = true;
				   }
				    if(radioss=="22") {
				   		document.getElementById('lingyradios').checked = true;
				   }
				   if(radioss=="33") {
				   		document.getElementById('mofaradios').checked = true;
				   }
				  document.getElementById('sele1').value = queryMessage1;
				  document.getElementById('sele2').value = queryMessage2;	
					document.getElementById('sele3').value = queryMessage3;
	
					//找到添加表格的div
					var markDiv=$("#query"); 
					//清空原有表格
					markDiv.empty();
					markDiv.append(data);
					
			}
		function quechoose() {//下载铃音或铃音盒
	 
		var radio1 = document.getElementsByName("opFlag");
		var doloadtype="";
		var bianhao="";
		var weizhi="";
		for(var i=0;i<radio1.length;i++)
		{
			if(radio1[i].checked)
			{
				var opFlag = radio1[i].value;
				if(opFlag=="one")
				{
					doloadtype="2";
				
				}else if(opFlag=="two")
				{
					doloadtype="1";
				
				}
				else if(opFlag=="three")
				{
					doloadtype="3";
				
				}
			}
		}
		if(doloadtype!="3") {
		var phoneNo =$("#phoneNo").val();
		var iToneType="";
		var sm= new Array();
		var price="";
		var a=document.getElementsByName("lingyinheradio");
				for(i=0;i <a.length;i++) 
				{ 
						if(a[i].checked) {
						//alert(a[i].value); 
						sm =a[i].value.split("|");
						bianhao=sm[0];
						price=sm[1];
						//weizhi=sm[2];
						//alert(bianhao+"|||||||||"+price);
						//alert(weizhi);
						}	  	
				} 
				if(bianhao=="") {
					rdShowMessageDialog("请选择要下载的铃音或铃音盒！");
					return ;
				}
		var b=document.getElementsByName("lingyin"+bianhao);
				for(i=0;i <b.length;i++) 
				{ 
						if(b[i].checked) {
						iToneType=b[i].value;
						//alert(iToneType);
						}	  	
				}
		//alert(iToneType);  
		//alert(doloadtype+"--"+iToneType+"--"+phoneNo+"--"+bianhao+"--"+price); 
		
		//alert("执行铃音或铃音盒下载22");
		var getdataPacket = new AJAXPacket("fe217_download.jsp","正在获得数据，请稍候......");
		getdataPacket.data.add("doloadtype",doloadtype);
		getdataPacket.data.add("phoneNo",phoneNo);
		getdataPacket.data.add("bianhao",bianhao);
		getdataPacket.data.add("iToneType",iToneType);
		getdataPacket.data.add("price",price);
		core.ajax.sendPacket(getdataPacket);
		getdataPacket = null;
	}else {//魔法铃音盒下载
		//alert("--");
				var phoneNo =$("#phoneNo").val();
		var iToneType="";
		var sm= new Array();
		var price="";
		var bianhao="";
		var a=document.getElementsByName("lingyinheradio");
						for(i=0;i <a.length;i++) 
				{ 
						if(a[i].checked) {
						//alert(a[i].value); 

						sm =a[i].value.split("|");
						bianhao=sm[0];
						price=sm[1];
						//alert(bianhao+"|||||||||"+price);
						}	  	
				}
					if(bianhao=="") {
					rdShowMessageDialog("请选择要下载的铃音或铃音盒！");
					return ;
				}
		var getdataPacket = new AJAXPacket("fe217_magicdoload.jsp","正在获得数据，请稍候......");
		getdataPacket.data.add("phoneNo",phoneNo);
		getdataPacket.data.add("bianhao",bianhao);
		getdataPacket.data.add("price",price);
		core.ajax.sendPacket(getdataPacket);
		getdataPacket = null;
		}

		}
		function doProcess(packet) {

			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			if(retCode == "000000"){
				rdShowMessageDialog("下载成功！",2);
				//removeCurrentTab();
			}else {
				rdShowMessageDialog("下载失败，错误代码："+retCode+"错误信息："+retMsg,0);
				//removeCurrentTab();
			}
		}

		</script>
<body >
	<form name="frm" method="POST" action="">
		<%@ include file="/npage/include/header.jsp"%>
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<table cellspacing="0">

			<tr>
				<td class="blue" width="25%">操作类型</td>
				<td><input type="radio" name="opFlag" id="lingyhradios" value="one"
					onclick="opchange()">铃音盒&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="opFlag" id="lingyradios" value="two"
					onclick="opchange()">铃音&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="opFlag" id="mofaradios" value="three"
					onclick="opchange()">魔法铃音盒</td>
			</tr>
			<tr>
				<td class="blue" width="25%">手机号码</td>
				<td><input type="text" id="phoneNo" name="phoneNo" v_must="1"
					v_type="mobphone" maxlength="11" onblur="checkElement(this)"
					readOnly Class="InputGrey" value="<%=activePhone%>" /> <font
					class="orange">*</font></td>
			</tr>

			<tr id="iquerys1" name="iquerys1">
				<td class="blue" width="25%">查询</td>
				<td><select id="Pselect1" style="width:130px;">
						<option value="1" selected>铃音盒名称</option>
						<option value="2">铃音盒中铃音名称</option>
				</select> <input type="text" id="sele1" name="sele1" style="width:190px;" v_type="string" maxlength="30"/> <input type="button"
					name="" class="b_text" value="查询" onclick="queryss()" /></td>
			</tr>

			<TR id="iquerys2" name="iquerys2">
				<TD class="blue" width="25%">查询</TD>
				<TD><select id="Pselect2" style="width:130px;">
						<option value="1" selected>歌曲名称</option>
						<option value="2">歌手名称</option>
				</select> <input type="text" id="sele2" name="sele2" style="width:190px;" v_type="string" maxlength="30"/> <input type="button"
					name="" class="b_text" value="查询" onclick="queryss()" /></TD>
			</TR>
			
						<TR id="iquerys3" name="iquerys3">
				<TD class="blue" width="25%">查询</TD>
				<TD><select id="Pselect3" style="width:150px;">
						<option value="1" selected>魔法铃音盒名称</option>
						<option value="2">魔法铃音盒中铃音名称</option>
				</select> <input type="text" id="sele3" name="sele3" style="width:190px;" v_type="string" maxlength="30"/> <input type="button"
					name="" class="b_text" value="查询" onclick="queryss()" /></TD>
			</TR>

			<td noWrap id="footer" colspan="4">&nbsp;</td>

		</table>

		<br>
		<div id="lingyinhe"></div>
		<div id="lingyin"></div>
		<div id="mofa"></div>
		<div id="query"></div>

		<table cellspacing="0">
			<tr>
				<td noWrap id="footer">
					<div align="center">
						<input type="button" name="quchoose" class="b_foot" value="下载"
							onclick="quechoose()" /> &nbsp; <input type="button"
							name="close" class="b_foot" value="关闭"
							onClick="removeCurrentTab();">
					</div></td>
			</tr>
		</table>
		<%@ include file="/npage/include/footer.jsp"%>
	</form>
</body>
</html>