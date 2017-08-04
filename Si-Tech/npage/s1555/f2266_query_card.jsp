<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode = "2266";
    String opName = "促销品统一付奖";
    String regionCode= (String)session.getAttribute("regCode");
    String libaodaima=WtcUtil.repNull(request.getParameter("libaodaima"));
    String[] inParamsss1 = new String[2];
		inParamsss1[0] = "select * from dbgiftrun.RS_PROGIFT_PT_INFO where res_type = 'kz' and res_code = :rescode";
		inParamsss1[1] = "rescode="+libaodaima;
		
		    String[] inParamsss22 = new String[2];
		inParamsss22[0] = "select * from dbgiftrun.RS_PROGIFT_PT_INFO where  substr(Trim(res_type), 1, 1)='l' and res_code = :rescode";
		inParamsss22[1] = "rescode="+libaodaima;
		
		System.out.println("-------"+inParamsss22[0]);
		
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust" scope="end" />
  	
  		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss2" retmsg="retMsg1ss2" outnum="1">			
	<wtc:param value="<%=inParamsss22[0]%>"/>
	<wtc:param value="<%=inParamsss22[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust22" scope="end" />  	
  <%	
  		System.out.println("---dcust22----"+dcust22.length);
  		%>
<html>
	<head>
		<title>充值卡查询</title>
	</head>
<script type="text/javascript">
//Load RPC Lib
		window.onload = function() {

		opchange();

	}

function doProcess(packet)
{
	var vRetPage=packet.data.findValueByName("rpc_page");

	if(vRetPage == "query_card" )
	{
		var query_result = packet.data.findValueByName("result");
		var error_msg = packet.data.findValueByName("error_msg");
		if(query_result == "true")
		{
			var card_type = packet.data.findValueByName("card_type");
			var card_value = packet.data.findValueByName("card_value");
			
					 var radio1 = document.getElementsByName("opFlag");
							  for(var i=0;i<radio1.length;i++)
				  {
						    if(radio1[i].checked)
							{
							  var opFlag = radio1[i].value;
											  if(opFlag=="one")
											  {	
											document.all.s_cardTypeName.value=card_type;
											document.all.cardPrice.value=card_value;
											document.all.commit.disabled = false;
													}
												else if(opFlag=="two")
											  {
											  	
											  	var begin_noss = packet.data.findValueByName("begin_no");
											  	
														document.all.commit.disabled = false;
												var contdscf=0;						
					            $("#sbtable tr").each(function(){ 
					                 var priceTd=$("td:eq(0)",$(this) );//优惠金额 
													if(priceTd.text()==begin_noss)    {        
													 contdscf=1;
					                }
					               
					            }); 
													if(contdscf>0)	{
														rdShowConfirmDialog("不能重复输入卡号！");
														return false;
													}	
													$("#sbtable").show();	
													var tr_str='';  
									         tr_str+="<tr>";  
									         tr_str+="<td>"+begin_noss+"</td>";  
									         tr_str+="<td>"+card_type+"</td>";  
									         tr_str+="<td>"+card_value+"</td>";  
									         tr_str+="<td><input type='button' value='删除' class='b_text' onClick='deletzhka(this)'></td>";    
									         tr_str+="</tr>";  
									         $("#squerys").append(tr_str);   

											  		//$("#squerys").html("<tr id='"+begin_noss+"'><td>"+begin_noss+"</td><td>"+card_type+"</td><td>"+card_value+"</td><td><input type='button' value='删除' onClick='deletzhka(this)'></td></tr>");
											  }
								}
					 }
		}
		else
		{
			alert(error_msg);
		}
	}else if(vRetPage == "query_card1"){
		var query_result1 = packet.data.findValueByName("result");
		var error_msg1 = packet.data.findValueByName("error_msg");
		if(query_result1 == "true")
		{
							 var radio1 = document.getElementsByName("opFlag");
							  for(var i=0;i<radio1.length;i++)
				  {
						    if(radio1[i].checked)
							{
							  var opFlag = radio1[i].value;
											  if(opFlag=="one")
											  {	
													window.returnValue = document.all.beginNo.value+'-'+document.all.endNo.value;
													window.close();
													}
												else if(opFlag=="two")
											  {
											  var $td=$(td).parents('tr').children('td');	
											  	

											  }
								}
					 }

		}
		else
		{
			alert(error_msg1);
		}
	}
	else
	{
		alert("error");
	}
}
 function deletzhka(k) {
 	  $(k).parent().parent().remove();  
 }
 	
function checkCardNo(flag)
{
	document.all.commit.disabled = true;
						 var radio1 = document.getElementsByName("opFlag");
							  for(var i=0;i<radio1.length;i++)
				  {
						    if(radio1[i].checked)
							{
							  var opFlag = radio1[i].value;
											  if(opFlag=="one")
											  {												  	
											  <%if(dcust22.length>0) {%>
											
											  	var myPacket = new AJAXPacket("f2266_query_card_rpc_liul.jsp","正在流量卡信息，请稍候......");
												myPacket.data.add("begin_no",document.all.beginNo.value );
												myPacket.data.add("end_no",document.all.endNo.value );
												myPacket.data.add("card_nums",document.all.card_num.value );
												if(flag == "0"){
													myPacket.data.add("rpc_page","query_card" );
												}else{
													myPacket.data.add("rpc_page","query_card1" );
												}
												core.ajax.sendPacket(myPacket);
												myPacket=null;
											  
											  			
											  	
												<%}else {%>
													
												var myPacket = new AJAXPacket("f2266_query_card_rpc.jsp","正在充值卡信息，请稍候......");
												myPacket.data.add("begin_no",document.all.beginNo.value );
												myPacket.data.add("end_no",document.all.endNo.value );
												myPacket.data.add("card_num",document.all.card_num.value );
												myPacket.data.add("card_type",document.all.card_type.value );
												if(flag == "0"){
													myPacket.data.add("rpc_page","query_card" );
												}else{
													myPacket.data.add("rpc_page","query_card1" );
												}
												core.ajax.sendPacket(myPacket);
												myPacket=null;
												
												<%}%>
												}
												else if(opFlag=="two")
											  {
											  if(flag == "0"){
												var myPacket = new AJAXPacket("f2266_query_card_rpc_zheka.jsp","正在充值卡信息，请稍候......");
												myPacket.data.add("begin_no",document.all.beginNokazhe.value );
												myPacket.data.add("end_no",document.all.beginNokazhe.value );
												myPacket.data.add("card_num","1");
												myPacket.data.add("card_type",document.all.card_type2.value);
												
												myPacket.data.add("rpc_page","query_card" );
												core.ajax.sendPacket(myPacket);
												myPacket=null;
												
												}else{
											
											
													 var  isns=0;
					            $("#sbtable tr").each(function(){ 
					                 var priceTd=$("td:eq(0)",$(this) );//优惠金额 
					               isns++;
					            }); 
					            
					             var  desd=0;
											 var  spstr="";				
											 var  sdfsds=",";	            
					            $("#sbtable tr").each(function(){ 
					                 var priceTd=$("td:eq(0)",$(this) );//优惠金额 
					                 if(desd==0) {
					                 }
					                 else {
					                 		if(desd-1 == isns-2) {
					                 			sdfsds=",";
					                 		}
					                 		else {
					                 			sdfsds=",";
					                 		}
					                 		spstr+=priceTd.text()+sdfsds;
					                 }
					               desd++;
					            });
					            /*if(document.all.card_num2.value!=isns-1) {
											  				rdShowConfirmDialog("添加的数量和付奖的数量不一致！");
																return;					            	
					            }*/
					            window.returnValue=spstr;
					           // window.returnValue = document.all.beginNo.value+'-'+document.all.beginNo.value;
					            window.close();
											
												}




											  }
								}
					 }

}


					function opchange() {
						
					<%
					if(dcust.length==0) {
					%>
					//document.getElementsByName("opFlag")[1].checked;
					document.getElementById('gongdtype').checked = true;
					<%
					}else {
						%>
					//document.getElementsByName("opFlag")[0].checked;
					document.getElementById('exceltype').checked = true;
						<%
					}
					%>	
						
					 var radio1 = document.getElementsByName("opFlag");
							  for(var i=0;i<radio1.length;i++)
				  {
				    if(radio1[i].checked)
					{
					  var opFlag = radio1[i].value;
									  if(opFlag=="one")
									  {							
                   $("#startkahao").show();
                   $("#kaleixings").show();
                   $("#zhekaxiaoshou").hide();
                   $("#squerys").hide();
                   $("#beginNokazhe").val("");
                   	$("#liankasdf").show();
                    $("#zhekassdf").hide();			    	
									  }else if(opFlag=="two")
									  {
                   $("#startkahao").hide();
                   $("#kaleixings").hide();
                   $("#zhekaxiaoshou").show();
                  // $("#squerys").show();
                  $("#sbtable").show();
                  $("#beginNo").val("");
                  $("#endNo").val("");
                  $("#s_cardTypeName").val("");
                  $("#cardPrice").val("");
                   $("#liankasdf").hide();
                    $("#zhekassdf").show();
									  }

									}
								}
							}
</script>
<body>
<%@ include file="/npage/include/header_pop.jsp" %>
	<table cellspacing="0">
							<tr>
				<td class="blue" width="15%">查询类型</td>
				<td colspan="3" id="liankasdf"><input type="radio" name="opFlag" id="gongdtype" value="one" checked onclick="opchange()">连号销售</td>
					<td colspan="3" id="zhekassdf"><input type="radio" name="opFlag" id="exceltype" value="two" onclick="opchange()">卡折销售</td>
			</tr>
	</table>
 <table cellspacing="0">
  <tr id="startkahao"  style="display:block">
    <td class="blue">开始卡号</td>
    <td><input name="beginNo" type="text" <%if(dcust22.length>0) {%> size="27" maxlength="27"<%}else{%>size="22" maxlength="22"<%}%> />
	  <input type="hidden" name ="card_num" value="<%=request.getParameter("card_num")%>">
	  <input type="hidden" name ="card_type" value="<%=request.getParameter("card_type")%>">
	  <font color=red>*</font>
	</td>
    <td class="blue" >结束卡号</td>
    <td colspan="3">
      <input type="text" class="likebutton2" name="endNo" <%if(dcust22.length>0) {%> size="27" maxlength="27"<%}else{%>size="22" maxlength="22"<%}%> onkeydown="if(event.keyCode==13) checkCardNo('0')" ><font color=red > *</font>
    </td>
  </tr>
  <tr id="kaleixings" style="display:block">
     <td class="blue" >卡类型</td>
	 <td><input type="text" name="s_cardTypeName" readonly class="likebutton2">
      </td>
	 <td class="blue" id="kamianzhis">卡面值</td>
	 <td colspan="3"><input name="cardPrice" type="text" size="20"  readonly="true"/></td>
  </tr>
  
    <tr id="zhekaxiaoshou"  style="display:none">
    <td class="blue">卡号</td>
    <td><input id="beginNokazhe" name="beginNokazhe" type="text" size="27" maxlength="27" />
    	<input type="hidden" name ="card_num2" value="<%=request.getParameter("card_num")%>">
    	<input type="hidden" name ="card_type2" value="<%=request.getParameter("card_type")%>">
	  <font color=red>*</font>
	</td>
  </tr>
</table>
<table cellspacing="0">
<tr>
	<td align="center" id="footer">
	<input class="b_foot" type="button" onclick="checkCardNo('0')" value="校验">
	<input class="b_foot" type="button" name="commit" disabled="true" onclick="checkCardNo('1');" value="确定">
	<input class="b_foot" type="button" onclick="window.close()" value="关闭">
</td></tr></table>

<table cellspacing="0" id="sbtable" style="display:none">
	<tr>
		<th>卡号</th>
		<th>卡类型</th>
		<th>卡面值</th>
		<th></th>
	</tr>
	<tbody id="squerys">
	</tbody>
	
</table>

<%@ include file="/npage/include/footer_pop.jsp" %> 
</body>
</html>
