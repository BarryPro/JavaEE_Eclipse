<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		response.setHeader("Pragma","No-Cache");
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0);
		String opCode = "6842";
    String opName = "����Ʒͳһ����";
    String regionCode= (String)session.getAttribute("regCode");
    String libaodaima=WtcUtil.repNull(request.getParameter("libaodaima"));
    String[] inParamsss1 = new String[2];
		inParamsss1[0] = "select * from dbgiftrun.RS_PROGIFT_PT_INFO where res_type = 'kz' and res_code = :rescode";
		inParamsss1[1] = "rescode="+libaodaima;
		
				    String[] inParamsss22 = new String[2];
		inParamsss22[0] = "select * from dbgiftrun.RS_PROGIFT_PT_INFO where  substr(Trim(res_type), 1, 1)='l' and res_code = :rescode";
		inParamsss22[1] = "rescode="+libaodaima;
 
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

<html>
	<head>
		<title>�ֻ���ֵ����ѯ</title>
	</head>
<script type="text/javascript">
		window.onload = function() {

		opchange();

	}
	
function doProcess(packet)
{
	var vRetPage=packet.data.findValueByName("rpc_page");
	
	if(vRetPage == "query_card"){

	
	
	var query_result = packet.data.findValueByName("result");
	var error_msg = packet.data.findValueByName("error_msg");
	if(query_result != "true"){
		rdShowConfirmDialog(error_msg);
		return;
	}
	
	var card_type = packet.data.findValueByName("card_type");
	var card_value = packet.data.findValueByName("card_value");
	document.all.s_cardTypeName.value=card_type;
	document.all.cardPrice.value=card_value;
	document.all.commit.disabled = false;
	document.all.beginNo.readOnly = true;
	document.all.endNo.readOnly = true;
}
else {
															document.all.commit.disabled = false;
												 	var query_result = packet.data.findValueByName("result");
													var error_msg = packet.data.findValueByName("error_msg");
													if(query_result != "true"){
														rdShowConfirmDialog(error_msg);
														return;
													}
													var card_type = packet.data.findValueByName("card_type");
													var card_value = packet.data.findValueByName("card_value");
													var begin_noss = packet.data.findValueByName("begin_no");
													
							var contdscf=0;						
            $("#sbtable tr").each(function(){ 
                 var priceTd=$("td:eq(0)",$(this) );//�Żݽ�� 
								if(priceTd.text()==begin_noss)    {        
								 contdscf=1;
                }
               
            }); 
								if(contdscf>0)	{
									rdShowConfirmDialog("�����ظ����뿨�ţ�");
									return false;
								}					
													
													$("#sbtable").show();
													var tr_str='';  
									         tr_str+="<tr>";  
									         tr_str+="<td>"+begin_noss+"</td>";  
									         tr_str+="<td>"+card_type+"</td>";  
									         tr_str+="<td>"+card_value+"</td>";  
									         tr_str+="<td><input type='button' value='ɾ��' class='b_text' onClick='deletzhka(this)'></td>";    
									         tr_str+="</tr>";  
									         $("#squerys").append(tr_str);  
									     
	
}

}
 function deletzhka(k) {
 	 $(k).parent().parent().remove(); 
 }
function checkCardNo()
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
											  	if(document.all.beginNo.value.trim()=="") {
											  				rdShowConfirmDialog("��ʼ���Ų���Ϊ�գ�");
																return;
											  	}
											  	if(document.all.endNo.value.trim()=="") {
											  				rdShowConfirmDialog("�������Ų���Ϊ�գ�");
																return;
											  	}		
											  	
											  			  		  <%if(dcust22.length>0) {%>
											 
													var myPacket = new AJAXPacket("f6842_query_card_rpc_liul.jsp","�����ֻ���ֵ����Ϣ�����Ժ�......");
													myPacket.data.add("begin_no",document.all.beginNo.value );
													myPacket.data.add("end_no",document.all.endNo.value );
													myPacket.data.add("card_nums",document.all.card_num.value );
													myPacket.data.add("card_type",document.all.card_type.value );
													myPacket.data.add("rpc_page","query_card" );

												  core.ajax.sendPacket(myPacket);
												  myPacket=null;
											  	
												<%}else {%>	 									  	
											  	
														var myPacket = new AJAXPacket("f6842_query_card_rpc.jsp","�����ֻ���ֵ����Ϣ�����Ժ�......");
													myPacket.data.add("begin_no",document.all.beginNo.value );
													myPacket.data.add("end_no",document.all.endNo.value );
													myPacket.data.add("card_num",document.all.card_num.value );
													myPacket.data.add("card_type",document.all.card_type.value );
													myPacket.data.add("rpc_page","query_card" );

												core.ajax.sendPacket(myPacket);
												myPacket=null;
												<%}%>
												}
												else if(opFlag=="two")
											  {
											  	if(document.all.beginNokazhe.value.trim()=="") {
											  				rdShowConfirmDialog("���Ų���Ϊ�գ�");
																return;
											  	}										
												var myPacket = new AJAXPacket("f6842_query_card_rpc_kazhe.jsp","�����ֻ���ֵ����Ϣ�����Ժ�......");
												myPacket.data.add("begin_no",document.all.beginNokazhe.value );
												myPacket.data.add("end_no",document.all.beginNokazhe.value );
												myPacket.data.add("card_num","1");
												myPacket.data.add("card_type",document.all.card_type2.value);
													myPacket.data.add("rpc_page","query_card2" );
												core.ajax.sendPacket(myPacket);
												myPacket=null;



											  }
								}
					 }
}


function dosubs() {
	
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
											 var  isns=0;
					            $("#sbtable tr").each(function(){ 
					                 var priceTd=$("td:eq(0)",$(this) );//�Żݽ�� 
					               isns++;
					            }); 
					            
					             var  desd=0;
											 var  spstr="";				
											 var  sdfsds=",";	            
					            $("#sbtable tr").each(function(){ 
					                 var priceTd=$("td:eq(0)",$(this) );//�Żݽ�� 
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
											  				rdShowConfirmDialog("��ӵ������͸�����������һ�£�");
																return;					            	
					            }*/
					            window.returnValue=spstr;
					           // window.returnValue = document.all.beginNo.value+'-'+document.all.beginNo.value;
					            window.close();
					            
					            										  	
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
                   $("#sbtable").hide();
                   $("#beginNokazhe").val("");
                   $("#liankasdf").show();
                    $("#zhekassdf").hide();
                   //$("#sbtable").hide();
                   //$("#squerys>tbody").remove();
                   //$("#squerys").empty();		    	
									  }else if(opFlag=="two")
									  {
                   $("#startkahao").hide();
                   $("#kaleixings").hide();
                   $("#zhekaxiaoshou").show();
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
				<td class="blue" width="15%">��ѯ����</td>
				<td colspan="3" id="liankasdf"><input type="radio" name="opFlag" id="gongdtype" value="one"  onclick="opchange()">��������</td>
					<td colspan="3" id="zhekassdf"><input type="radio" name="opFlag" id="exceltype" value="two" onclick="opchange()">��������</td>
			</tr>
	</table>
 <table cellspacing="0">
  <tr id="startkahao"  style="display:block">
    <td class="blue">��ʼ����</td>
    <td><input name="beginNo" type="text" <%if(dcust22.length>0) {%> size="27" maxlength="27"<%}else{%>size="22" maxlength="22"<%}%> value=""/>
	  <input type="hidden" name ="card_num" value="<%=request.getParameter("card_num")%>">
	  <input type="hidden" name ="card_type" value="<%=request.getParameter("card_type")%>">
	  <font color=red>*</font>
	</td>
    <td class="blue">��������</td>
    <td colspan="3">
      <input type="text" class="likebutton2" name="endNo"  <%if(dcust22.length>0) {%> size="27" maxlength="27"<%}else{%>size="22" maxlength="22"<%}%>  value=""  onkeydown="if(event.keyCode==13) checkCardNo()" ><font color=red > *</font>
    </td>
  </tr>
  <tr id="kaleixings" style="display:block">
     <td class="blue">������</td>
	 <td><input type="text" name="s_cardTypeName" readonly class="likebutton2">
      </td>
	 <td class="blue" id="kamianzhis">����ֵ</td>
	 <td colspan="3"><input name="cardPrice" type="text" size="20"  readonly="true"/></td>
  </tr>
      <tr id="zhekaxiaoshou"  style="display:none">
    <td class="blue">����</td>
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
	<input class="b_foot" type="button" onclick="checkCardNo()" value="У��">
	<input class="b_foot" type="button" name="commit" disabled="true" onclick="dosubs()" value="ȷ��">
	<input class="b_foot" type="button" onclick="window.close()" value="�ر�">
</td></tr></table>

<table cellspacing="0" id="sbtable"  style="display:none">
	<tr>
		<th>����</th>
		<th>������</th>
		<th>����ֵ</th>
		<th></th>
	</tr>
	<tbody id="squerys">
	</tbody>
	
</table>
<%@ include file="/npage/include/footer_pop.jsp" %> 
</body>
</html>
                                                                                                                                                                                                                                                                                                                      