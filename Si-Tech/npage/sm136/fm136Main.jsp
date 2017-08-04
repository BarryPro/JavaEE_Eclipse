<%
  /*
   * ����:
   * �汾: 1.0
   * ����: 
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
		
%>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
		
		});
		
		function doQry(){
			
			var cfmFlag = false;
			var opType = $("input[name='opType'][checked]").val();
			var mainUnitCode = $.trim($("input[name='mainUnitCode']").val());
			var otherUnitCode = $.trim($("input[name='otherUnitCode']").val());
			
			/*2014/08/08 10:49:02 gaopeng R_CMI_HLJ_xueyz_2014_1666493@����ʵ���ں�ͨ�����ϼ��ŵ�����
				��ѯʱ���������ٵ���дһ�� 
			*/
			if(opType == "2"){
				if(mainUnitCode.length == 0 && otherUnitCode.length == 0){
					rdShowMessageDialog("�����ű���͸������ű���������Ҫ����һ��!",1);
					return false;
				}
			}else if(opType == "0" || opType == "1"){
				if(mainUnitCode.length == 0 || otherUnitCode.length == 0){
					rdShowMessageDialog("�����ű���͸������ű�����붼����!",1);
					return false;
				}
			}
			
			if(opType == "0" || opType == "1"){
				
				if($("#mainUnitCode_ID").val().trim()==""){
					rdShowMessageDialog("��ѡ�������ű����ƷID",1);
					return false;
				}
				if($("#otherUnitCode_ID").val().trim()==""){
					rdShowMessageDialog("��ѡ�������ű����ƷID",1);
					return false;
				}
				
				
				if(rdShowConfirmDialog("�Ƿ�ȷ�ϲ���?")==1){
					cfmFlag = true;
				}else{
					cfmFlag = false;
				}
			}else if(opType == "2"){
				cfmFlag = true;
			}
			
			if(cfmFlag){
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm136/fm136Qry.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = "";
			var iUserPwd = "";
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("mainUnitCode",mainUnitCode);
			getdataPacket.data.add("otherUnitCode",otherUnitCode);
			
			getdataPacket.data.add("mainUnitCode_ID",$("#mainUnitCode_ID").val().trim());
			getdataPacket.data.add("otherUnitCode_ID",$("#otherUnitCode_ID").val().trim());
			
			getdataPacket.data.add("opType",opType);
			
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
		}
			
	}
	
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			var iOpType = packet.data.findValueByName("opType");
			
		if(retCode == "000000"){
			
				if(iOpType == "2"){
					$("#resultContent").show();
					$("#appendBody").empty();
					
					var appendTh = 
						"<tr>"
						+"<th width='25%'>�����ű���</th>"
						+"<th width='25%'>�����ű����ƷID</th>"
						+"<th width='25%'>�������ű���</th>"
						+"<th width='25%'>�������ű����ƷID</th>"
						
						+"</tr>";
					$("#appendBody").append(appendTh);	
					for(var i=0;i<infoArray.length;i++){
					
					var orderAccept = infoArray[i][0];
					var opType = infoArray[i][1];
					
					
					
							var appendStr = "<tr>";
							
							appendStr += "<td width='25%'>"+orderAccept+"</td>"
													+"<td width='25%'>"+infoArray[i][2]+"</td>"
													+"<td width='25%'>"+opType+"</td>"
													
													
													+"<td width='25%'>"+infoArray[i][3]+"</td>"
													
													;
							appendStr +="</tr>";	
											
							$("#appendBody").append(appendStr);
					}
			}else{
				rdShowMessageDialog("�����ɹ���",2);
				location = location;
			}
				
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
			}
		}
	function doResetS(tmp){
		$("#resultContent").hide();
		$("#appendBody").empty();
		
		if(tmp=="2"){
			$("#tr_Unitids").hide();
			$("#btn_go_QryUnitCode1").hide();
			$("#btn_go_QryUnitCode2").hide();
			
		}else{
			$("#tr_Unitids").show();
			$("#btn_go_QryUnitCode1").show();
			$("#btn_go_QryUnitCode2").show();
		}
		
	}


function go_QryUnitCode(flag){
	
		var In_UnitId   = "";
		var In_BandFlag = $("input[name='opType']:checked").val();   // �󶨻����ʶ0�󶨣�1���
		
		
		
		var In_MainFlag = flag; //���������ű�ʶ0����1����
				
		if(flag=="0"){
			In_UnitId = $("#mainUnitCode").val();
		}else{
			In_UnitId = $("#otherUnitCode").val();
		}		
				
    var packet = new AJAXPacket("fm136_go_QryUnitCode.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("flag",flag);//
        
        packet.data.add("In_UnitId",In_UnitId);//
        packet.data.add("In_MainFlag",In_MainFlag);//
        packet.data.add("In_BandFlag",In_BandFlag);//
        
    core.ajax.sendPacket(packet,do_QryUnitCode);
    packet =null;	
}	

function do_QryUnitCode(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//�����ɹ�
			
			var In_MainFlag = packet.data.findValueByName("In_MainFlag");
			var retArray    = packet.data.findValueByName("retArray");
			
			
			
			var option_str = "<option value=''>--��ѡ��--</option>";
			if(retArray.length>0){
				
					for(var i=0;i<retArray.length;i++){
							option_str += "<option value='"+retArray[i][0]+"'>"+retArray[i][0]+"</option>";
					}
					
					
					if(In_MainFlag=="0"){
							$("#mainUnitCode_ID option").remove();
							$("#mainUnitCode_ID").append(option_str);
					}else{
							$("#otherUnitCode_ID option").remove();
							$("#otherUnitCode_ID").append(option_str);
					}
					
					
			}else{
					rdShowMessageDialog("δ��ѯ�����");
			}
			
    }
}

	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
		<table>
			
	    <tr>
	  		<td width=20% class="blue">��������</td>
	  		<td width=80% colspan="3">
		  		<input type="radio" name="opType"  value="0" onclick="doResetS(0)"/>��� &nbsp;
		  		<input type="radio" name="opType"   value="1" onclick="doResetS(1)"/>�� &nbsp;
		  		<input type="radio" name="opType"  value="2" checked onclick="doResetS(2)"/>��ѯ &nbsp;
	  		</td>
	    </tr>
	    <tr>
	    	<td width="20%" class="blue">�����ű���</td>
	    	<td width=30%>
	    		<input type="text" name="mainUnitCode" id="mainUnitCode"	value="" maxlength="10"/>
	    		<input type="button" class="b_text" id="btn_go_QryUnitCode1" value="��ѯ" onclick="go_QryUnitCode(0);" style="display:none" />
	    	</td>
	    	<td width=20% class="blue">�������ű���</td>
	    	<td width=30%>
	    		<input type="text" name="otherUnitCode" id="otherUnitCode"	value="" maxlength="10"/>
	    		<input type="button" class="b_text" id="btn_go_QryUnitCode2" value="��ѯ" onclick="go_QryUnitCode(1);" style="display:none" />
	    	</td>
	    </tr>
	    
	    
	    <tr id="tr_Unitids" style="display:none">
	    	<td width="20%" class="blue">�����ű����ƷID</td>
	    	<td width=30%>
	    		
	    		<select id="mainUnitCode_ID" name="mainUnitCode_ID" >
					    <option value="">--��ѡ��--</option>
					</select>
					
					
	    	</td>
	    	<td width=20% class="blue">�������ű����ƷID</td>
	    	<td width=30%>
	    		<select id="otherUnitCode_ID" name="otherUnitCode_ID" >
					    <option value="">--��ѡ��--</option>
					</select>
					
	    	</td>
	    </tr>
	    
	    <tr> 
	    	
 
			<td align=center colspan="4" id="footer">
				<input class="b_foot" name="sure"  type="button" value="ȷ��"  onclick="doQry();">
				<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
				
			</td>
		</tr>
		</table>
	</div>
	<!-- ��ѯ����б� -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">��ѯ����б�</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
	</div>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel2;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</script>
</body>


</html>
