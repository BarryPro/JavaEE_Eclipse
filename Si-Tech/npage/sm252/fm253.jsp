 <%
	/********************
	 version v2.0
	������: si-tech
	update:2015/3/26 17:09:31 ningtn
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode=request.getParameter("opCode");	
	String opName=request.getParameter("opName");

	String workno = (String)session.getAttribute("workNo");
	String regioncode=(String)session.getAttribute("regCode");
	String noPass = (String)session.getAttribute("password");
	String orgcode = (String)session.getAttribute("orgCode");
  String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  String regionCode= (String)session.getAttribute("regCode");

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regioncode%>"  id="sysAccept" />

<HEAD>
		<TITLE><%=opName%></TITLE>
		<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
		<script language="JavaScript">
			$(document).ready(function(){
				
				$("#clearBtn").click(function(){
					doclear();
				});
				
				$("#qryBtn").click(function(){
					$(":input").each(function(){
						hiddenTip($(this)[0]);
					});
					
					
					var qryType = $("#qryType").val();
					if(qryType == "2"){
						if(!checkElement($("#startDate")[0])){
							return false;
						}else if(!checkElement($("#endDate")[0])){
							return false;
						}
					}else{
						if(!checkElement($("#qryTxt")[0])){
							return false;
						}
					}
					
					qryfunc();
				});
				
				$("#qryType").change(function(){
					if($(this).val() == "0"){
						$("#timeTr").hide();
						$("#qryLabel").text("Ͷ�ߵ���");
						$("#qryLabel").show();
						$("#qryInput").show();
					}else if($(this).val() == "1"){
						$("#timeTr").hide();
						$("#qryLabel").text("֤������");
						$("#qryLabel").show();
						$("#qryInput").show();
					}else if($(this).val() == "2"){
						$("#qryLabel").hide();
						$("#qryInput").hide();
						$("#timeTr").show();
					}
				});
			});
			
			function doclear(){
				window.location.href = "fm253.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			}
			
			function qryfunc(){
					/*�����ύ����*/
					var param9,param10 = "";
					if($("#qryType").val() == "2"){
						param9 = $("#startDate").val();
						param10 = $("#endDate").val();
					}else{
						param9 = $("#qryTxt").val();
					}
					
					var getdataPacket = new AJAXPacket("/npage/public/pubCallServ.jsp","���ڻ�����ݣ����Ժ�......");
					getdataPacket.data.add("serviceName","sm253Qry");
					getdataPacket.data.add("outnum","22");
					getdataPacket.data.add("inputParamsLength","11");
					getdataPacket.data.add("inParams0",$("#sysAccept").val());
					getdataPacket.data.add("inParams1","01");
					getdataPacket.data.add("inParams2","<%=opCode%>");
					getdataPacket.data.add("inParams3","<%=workno%>");
					getdataPacket.data.add("inParams4","<%=noPass%>");
					getdataPacket.data.add("inParams5","");
					getdataPacket.data.add("inParams6","");
					getdataPacket.data.add("inParams7",$("#status").val());
					getdataPacket.data.add("inParams8",$("#qryType").val());
					getdataPacket.data.add("inParams9",param9);
					getdataPacket.data.add("inParams10",param10);
					core.ajax.sendPacket(getdataPacket,doQryBack);
					getdataPacket = null;
			}
			
			function doQryBack(packet){
		      var retcode = packet.data.findValueByName("retcode");
		      var retmsg = packet.data.findValueByName("retmsg");
		      if(retcode == "000000"){
		        var result = packet.data.findValueByName("result");
		        $("#qryTab").empty();
		        $.each(result,function(i,n){
		        	var tr = $("#qryTmp").clone();
		        	var tmpStr = "";
		        	if(n[0] == "0"){
		        		tmpStr = "δ�ʼ�";
		        	}else if(n[0] == "1"){
		        		tmpStr = "�ʼ���";
		        	}else if(n[0] == "2"){
		        		tmpStr = "�����";
		        		tr.find(":input").hide();
		        	}
		        	tr.find("td:eq(0)").text(tmpStr);
		        	tmpStr = "";
		        	if(n[1] == "0"){
		        		tmpStr = "δ��";
		        	}else if(n[1] == "1"){
		        		tmpStr = "�ѹ�";
		        	}
		        	tr.find("td:eq(1)").text(tmpStr);
		        	tmpStr = "";
		        	if(n[2] == "0"){
		        		tmpStr = "δ��";
		        	}else if(n[2] == "1"){
		        		tmpStr = "�ѳ�";
		        	}
		        	tr.find("td:eq(2)").text(tmpStr)
		        										.attr("oldCardNo",n[15])
		        										.attr("compName",n[16])
		        										.attr("orderNo",n[17])
		        										.attr("addr",n[18])
		        										.attr("reviceDate",n[19])
		        										.attr("phoneDate",n[20])
		        										.attr("activateDate",n[21]);
		        	tr.find("td:eq(3)").text(n[3]);
		        	tr.find("td:eq(4)").text(n[4]);
		        	tr.find("td:eq(5)").text(n[5]);
		        	tr.find("td:eq(6)").text(n[6]);
		        	tr.find("td:eq(7)").text(n[7]);
		        	tr.find("td:eq(8)").text(n[8]);
		        	tr.find("td:eq(9)").text(n[9]);
		        	tr.find("td:eq(10)").text(n[10]);
		        	tr.find("td:eq(11)").text(n[11]);
		        	tr.find("td:eq(12)").text(n[12]);
		        	tr.find("td:eq(13)").text(n[13]);
		        	tr.find("td:eq(14)").text(n[14]);
		        	tr.removeAttr("style");
		        	$("#qryTab").append(tr);
		        	
		        });
		        
		        $("#qryTab").find(":input").click(function(){
		        	openWin($(this));
		        });
		        
		      }else{
		      	rdShowMessageDialog("��ѯʧ�ܣ�������룺" + retcode + "��������Ϣ��" + retmsg,0);
		      	doclear();
		      }
		      
		    }
		    
		    function openWin(obj){
		    	
		    	var h=400;
   				var w=700;
   				var t=screen.availHeight/2-h/2;
   				var l=screen.availWidth/2-w/2;
   
		    	var oldCardNo 	= obj.parent().parent().find("td:eq(2)").attr("oldCardNo");
		    	var compName 		= obj.parent().parent().find("td:eq(2)").attr("compName");
		    	var orderNo 		= obj.parent().parent().find("td:eq(2)").attr("orderNo");
		    	var addr 				= obj.parent().parent().find("td:eq(2)").attr("addr");
		    	var reviceDate 	= obj.parent().parent().find("td:eq(2)").attr("reviceDate");
		    	var phoneDate 	= obj.parent().parent().find("td:eq(2)").attr("phoneDate");
		    	var activateDate = obj.parent().parent().find("td:eq(2)").attr("activateDate");
		    	var path = "<%=request.getContextPath()%>/npage/sm252/fm253Info.jsp";
		    	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
		    	var winObj = new Object();
          winObj.oldCardNo 	= oldCardNo;
          winObj.compName 	= compName;
          winObj.orderNo 		= orderNo;
          winObj.addr 			= addr;
          winObj.reviceDate = reviceDate;
          winObj.phoneDate 	= phoneDate;
          winObj.activateDate = activateDate;
		    	var ret=window.showModalDialog(path,winObj,prop);
		    	
		    	$("#qryBtn").click();

		    }
		</script>
</HEAD>
<BODY >
	<FORM action="" method=post name="frm" ENCTYPE="multipart/form-data">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="sysAccept" id="sysAccept" value="<%=sysAccept%>"> 
	
	<table cellspacing="0">
		<tr>
			<td class="blue">����״̬</td>
			<td>
				<select id="status">
					<option value="0">δ�ʼ�</option>
					<option value="1">�ʼ���</option>
					<option value="2">�����</option>
				</select>
			</td>
			<td class="blue">��ѯ����</td>
			<td>
				<select id="qryType">
					<option value="0">Ͷ�ߵ���</option>
					<option value="1">֤������</option>
					<option value="2">ȫ��</option>
				</select>
			</td>
			<td class="blue" id="qryLabel">Ͷ�ߵ���</td>
			<td id="qryInput">
				<input type="text" id="qryTxt" v_must="1" v_type="string"/>
				<font class=orange>*</font>
			</td>
		</tr>
		<tr id="timeTr" style="display:none;">
			<td class="blue">��ʼʱ��</td>
			<td>
				<input type="text" id="startDate" v_must="1" value="<%=dateStr%>"
					onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})"/>
				<font class=orange>*</font>
			</td>
			<td class="blue">����ʱ��</td>
			<td>
				<input type="text" id="endDate" v_must="1" value="<%=dateStr%>"
					onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})"/>
				<font class=orange>*</font>
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td id="footer" >
			<input  name="qryBtn" id="qryBtn" class="b_foot" type="button" value="��ѯ">
			&nbsp;
			<input  id="clearBtn" class="b_foot" type="button" value="����" />
			&nbsp;                  			
			</td>
		</tr>
	</table>
	<table cellspacing="0" >
		<tr>
			<th>����״̬</th>
			<th>�ɿ��Ƿ�ο�</th>
			<th>�ɿ��Ƿ��ֵ</th>
			<th>Ͷ����ˮ��</th>
			<th>��ʡ������˾����</th>
			<th>��ʡ�ʼĶ�����</th>
			<th>�ʷ�</th>
			<th>�Զ�ʡ</th>
			<th>��ϵ������</th>
			<th>��ϵ�˵绰</th>
			<th>֤������</th>
			<th>��������</th>
			<th>��ע</th>
			<th>����ʱ��</th>
			<th>��������</th>
			<th>����</th>
		</tr>
		<tr id="qryTmp" style="display:none;">
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td><input type="button" value="��¼" class="b_text" /></td>
		</tr>
		<tbody id="qryTab">
		</tbody>
	</table>
		
	<%@ include file="/npage/include/footer.jsp" %>
	</FORM>
</BODY>
</HTML> 