 <%
	/********************
	 version v2.0 R_CMI_HLJ_guanjg_2015_2164784@���ںͽ�ͨ-Υ�²�ѯҵ��BOSS����վϵͳ��������ĺ�-���ſͻ�����
	������: si-tech
	update:2015/02/12 12:54:23 gaopeng
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
	String ipAddr = (String)session.getAttribute("ipAddr");
	
	String mysql = " select field_code2,field_code3 from dbvipadm.scommoncode where common_code='1040'";
	String[] inParamsss1 = new String[2];
  inParamsss1[0] = "select field_code2,field_code3 from dbvipadm.scommoncode where common_code='1040'";
  inParamsss1[1] = "";
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="2">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>
	</wtc:service>
	<wtc:array id="result0y" scope="end" />

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regioncode%>"  id="sysAccept" />

<HTML>
	<HEAD>
		<TITLE><%=opName%></TITLE>
		<script language="JavaScript">
		/*�ϴ���־*/
		var uploadFlag = false;
		
		$(document).ready(function(){
			var radioFlag = $("input[name='opType'][checked]").val();
			if(radioFlag == "simple"){
				$("#isgua option[value='1']").remove();
				$("#simpleEx").show();
			}
			changeType();	
			$("#resultContent2").hide();		
		
		});
		
		function doCommit()
		{
			var radioFlag = $("input[name='opType'][checked]").val();
			var selFlag = $("select[name='opSel']").find("option:selected").val();
			/*
				2015/5/11 8:29:04 gaopeng 
				����ʱ,����
				����ʱ,��Ҫ��������д
				ɾ��ʱ,���ƺű�����д
			*/
			if(radioFlag == "simple"){
				if(selFlag == "01"){
					if(!checkElement(document.all.carPNo)){
						return false;
					}
					if(!checkElement(document.all.carJNo)){
						return false;
					}
					if(!checkElement(document.all.carFNo)){
						return false;
					}
					var carNoType = $("select[name='carNoType']").find("option:selected").val();
					if(carNoType == "$$"){
						rdShowMessageDialog("��ѡ��������࣡");
						return false;
					}
				}else if(selFlag == "02"){
					if(!checkElement(document.all.carPNo)){
						return false;
					}
				}
				
			}else if(radioFlag == "piliang"){
				if(!uploadFlag){
					rdShowMessageDialog("���ϴ�������Ϣ�ļ���",1);
					return false;
				}
				
			}
			if(rdShowConfirmDialog('ȷ���ύ��Ϣô��')==1)
			{
				/*�ύ����Ч*/
			$("#quchoose").attr("disabled","disabled");
				/*�ύ*/
				formConfirm();
			}
			
		}
		
		function formConfirm(){
			
			
			var radioFlag = $("input[name='opType'][checked]").val();
			var selFlag = $("select[name='opSel']").find("option:selected").val();
			
			/*���ֻ�����*/
			var phoneNo = $.trim($("#phoneNo").val());
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm260/fm260Cfm.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=sysAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=workno%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = phoneNo;
			var iUserPwd = "";
			
			/*
				@ In_sCarNo ���ƺ�
				@ In_sDivingNo ���ܺ�
				@ In_sMotorNo ��������
				
				@ In_sOpType �������ͣ�01-��ӣ�02-ɾ��
				@ In_sIPAdd IP��ַ
				@ In_sGrpID ���Ų�ƷID
				@ In_sUnitID ���ű���

			*/
			
			var carPStr = "";
			var carJStr = "";
			var carFStr = "";
			var carNoType = "";
			if(radioFlag == "simple"){
				
				carPStr = $.trim($("#carPNo").val());
				carJStr = $.trim($("#carJNo").val());
				carFStr = $.trim($("#carFNo").val());
				carNoType = $("select[name='carNoType']").find("option:selected").val();
				
			}else if(radioFlag == "piliang"){
				
				var carPStr = $("input[name='carPStr']").val();
				var carJStr = $("input[name='carJStr']").val();
				var carFStr = $("input[name='carFStr']").val();
				carNoType = $("input[name='carNoTypeHide']").val();
			}
			
			var product_id = $("#product_id").val();
			var unitCode = $.trim($("#unitCode").val());
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			getdataPacket.data.add("carPStr",carPStr);
			getdataPacket.data.add("carJStr",carJStr);
			getdataPacket.data.add("carFStr",carFStr);
			getdataPacket.data.add("carNoType",carNoType);
			
			
			getdataPacket.data.add("selFlag",selFlag);
			getdataPacket.data.add("ipAddr","<%=ipAddr%>");
			getdataPacket.data.add("product_id",product_id);
			getdataPacket.data.add("unitCode",unitCode);
			
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			
			if(retCode == "000000"){
				
				var CarNoList = infoArray[0][0];
				var CarMsgList = infoArray[0][1];
				
				var CarNoListArray = new Array();
				var CarMsgListArray = new Array();
				CarNoListArray = CarNoList.split("~");
				CarMsgListArray = CarMsgList.split("~");
				
				$("#resultContent2").show();
				$("#appendBody2").empty();
				for(var i=0;i<CarNoListArray.length;i++){
					var msg0 = CarNoListArray[i];
					var msg1 = CarMsgListArray[i];
					if(msg0.length != 0){
					var appendStr = "<tr>";
						
						appendStr += "<td width='50%'>"+msg0+"</td>"
												+"<td width='50%'>"+msg1+"</td>"
												
												
						appendStr +="</tr>";	
										
						$("#appendBody2").append(appendStr);
					}
				}
				
				
				
			}else{
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				doclear();
				
			}
			
		}

function doclear(){
	Window.location.reload();	
}
		 
		
/*
	�������ͱ������
*/		
function changeType(opCode){
	/*��ղ���*/
	uploadFlag = false;
	$("#carPNo").val("");
	$("#carJNo").val("");
	$("#carFNo").val("");
	
	var radioFlag = $("input[name='opType'][checked]").val();
	if(radioFlag == "simple"){
		$("#dyntb").show();
		$("#mutiConstants").hide();
		
	}else if(radioFlag == "piliang"){
		$("#dyntb").hide();
		$("#mutiConstants").show();
		
	}
	
}

	
	/*�ϴ�txt�ļ��ķ���*/
		function uploadBroad(){
			if($("#workNoList").val() == ""){
				rdShowMessageDialog("���ϴ�������Ϣ�ļ���");
				$("#workNoList").focus();
				return false;
			}
			var formFile=frm.workNoList.value.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=frm.workNoList.value.length;
			formFile=frm.workNoList.value.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("�ϴ��ļ���ʽֻ����txt��������ѡ���мۿ���Ϣ�ļ���",1);
				document.frm.workNoList.focus();
				return false;
			}
			else
				{
					/*׼���ϴ�*/
					document.frm.target="hidden_frame";
			    document.frm.encoding="multipart/form-data";
			    document.frm.action="/npage/sm260/fm260Upload.jsp";
			    document.frm.method="post";
			    document.frm.submit();
					return true;
				}
			
		}
		/*�ϴ��ɹ���Ҫ�����¶�*/
		function doSetFileName(oldFileName,newFileName,newFilePath,carPStr,carJStr,carFStr,carNoType){
			rdShowMessageDialog("�ϴ��ļ�"+oldFileName+"�ɹ���",2);
			$("input[name='serviceFileName']").val(newFileName);
			$("input[name='serviceFilePath']").val(newFilePath);
			
			$("input[name='carPStr']").val(carPStr);
			$("input[name='carJStr']").val(carJStr);
			$("input[name='carFStr']").val(carFStr);
			$("input[name='carNoTypeHide']").val(carNoType);
			
			/*�ϴ�����Ч*/
			$("#uploadFile").attr("disabled","disabled");
			/*�ύ����Ч*/
			$("#quchoose").attr("disabled","");
			/*��ѡ��ť����Ч*/
			$("input[name='opType']").each(function(){
				$(this).attr("disabled","disabled");
			});
			uploadFlag = true;
		}
		/*�ϴ�ʧ�ܺ�Ҫ�����¶�*/
		function showUploadError(errorInfo){
			rdShowMessageDialog(errorInfo,1);
			uploadFlag = false;
			window.location.href='/npage/sm260/fm260Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
			
		}
		
	
   function tellMore1000(){
			rdShowMessageDialog("���ֻ���ϴ�50�����ݣ���������ѡ���ļ�",1);
			return false;
	 }
	 /*
	 	2015/05/06 14:20:37 gaopeng R_CMI_HLJ_guanjg_2015_2164784@���ںͽ�ͨ-Υ�²�ѯҵ��BOSS����վϵͳ��������ĺ�-���ſͻ�����
	 	��ѯ�ͽ�ͨ��Ϣ�б�
	 */	
	 function showMsg(){
		 	var unitCode = $.trim($("#unitCode").val());
		 	if(!checkElement($("#unitCode")[0])){
		 		return false;
		 	}
		 	if(unitCode.length == 0){
		 		rdShowMessageDialog("�����뼯�ű��룡",1);
				return false;
		 	}
		 	var path = "/npage/sm260/fm260BindQry.jsp";
		 	path += "?unitCode="+unitCode;
		 	path += "&iLoginNo=<%=workno%>";
		 	path += "&iOpCode=<%=opCode%>";
		 	path += "&iOpName=<%=opName%>";
	    retInfo = window.open(path,"newwindow","height=550, width=1000,top=0,left=0,scrollbars=yes, resizable=no,location=no, status=yes");
		  return true;
	 }
		
	</script>
</HEAD>
<BODY >
	<FORM action="" method=post name="frm" ENCTYPE="multipart/form-data">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
				<table cellspacing="0">
			    <tr>
			  		<td width="20%" class="blue">���ű���</td>
			  		<td width="84%" colspan="3">
			  			<input type="text" id="unitCode" name="unitCode" v_type="0_9" maxlength="10" value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
			  			<input type="button" id="qryUnitBtn" class="b_text" name="qryUnitBtn" value="��ѯ" onclick="showMsg();"/>
			  		</td>
			    </tr>
			    <tr>
			  		<td width="20%" class="blue">���ֻ�����</td>
			  		<td width="30%">
			  			<input type="text" id="phoneNo" name="phoneNo" v_type="0_9" maxlength="11" value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
			  			
			  		</td>
			  		<td width="20%" class="blue">��ǰ������</td>
			  		<td width="30%">
			  			<input type="text" id="bindNum"  name="bindNum" value="" v_type="0_9"/>
			  		</td>
			    </tr>
		    	<tr>
        		<td width=20% class="blue">������ʽ</td>
        		<td width=30% >
        			<input type="radio" name="opType"	value="simple"   onclick="changeType(this.value);" checked/>���ʲ��� &nbsp;&nbsp;
        			<input type="radio" name="opType"	value="piliang"  onclick="changeType(this.value);"/>�������� &nbsp;&nbsp;
						</td>
						<td width="20%" class="blue">��������</td>
			  		<td width="30%">
			  			<select name="opSel">
			  				<option value="01">����</option>
			  				<option value="02">ɾ��</option>
			  			</select>
			  		</td>
      		</tr>
	  		</table>
       
       	<table   cellspacing="0" id="dyntb" style="display:none">
 	        <tr >
        		<td width=20% class="blue">���ƺ�</td>
        		<td width=30% >
                 <input type="text" name="carPNo" v_must="1" id="carPNo" value="" />
        		</td>
        		<td width=20% class="blue">���ܺ�</td>
        		<td width=30% >
                 <input type="text" name="carJNo" v_must="1" id="carJNo" value="" />
        		</td>
  				</tr>
  				<tr >
        		<td width=20% class="blue">��������</td>
        		<td width=30% >
                 <input type="text" name="carFNo" v_must="1" id="carFNo" value="" />
        		</td>
        		<td width=20% class="blue">��������</td>
        		<td width=30% >
        				 <select name="carNoType">
        				 		<option value="$$">--��ѡ��--</option>
        				 		<%
        				 			System.out.println("gaopengSeeLogM260============result0y.length="+result0y.length);
        				 			if(result0y.length != 0){
        				 				for(int i=0;i<result0y.length;i++){
        				 				
        				 				%>
        				 				<option value="<%=result0y[i][0]%>"><%=result0y[i][0]%>-<%=result0y[i][1]%></option>
        				 				<%
        				 				        				 				
        				 				}
        				 			}
        				 		%>
					  			</select>
        		</td>
  				</tr>
        </table>

        				
  <div id="mutiConstants" >
			<table>
				<tr>
					<td width="20%" class="blue">
						������Ϣ����
					</td>
					<td>
						<input type="file" name="workNoList" id="workNoList" class="button"
						style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
						&nbsp;&nbsp;
						<input type="button" name="uploadFile" id="uploadFile" class="b_text" value="�ϴ�" onclick="uploadBroad();"/>
					</td>
				</tr>
				<tr>
					<td class="blue">
						�ļ���ʽ˵��
					</td>
		      <td> 
		          �ϴ��ļ��ı���ʽΪ�����ƺ�|���ܺ�|��������|��������|����ʾ�����£�<br>
		          <font class='orange'>
		          	&nbsp;&nbsp; ��A12341|LBXSWEFS782631|HBSW998121A|01|<br/>
		          	&nbsp;&nbsp; ��A12342|LBXSWEFS782632|HBSW998122A|02|<br/>
		          	&nbsp;&nbsp; ��A12343|LBXSWEFS782633|HBSW998123A|15|<br/>
		          	&nbsp;&nbsp; ��A12344|LBXSWEFS782634|HBSW998124A|01|<br/>
		          	&nbsp;&nbsp; ��A12345|LBXSWEFS782635|HBSW998125A|02|<br/>
		          	&nbsp;&nbsp; ��A12346|LBXSWEFS782636|HBSW998126A|15|<br/>
		          	&nbsp;&nbsp; ��A12347|LBXSWEFS782637|HBSW998127A|01|<br/>
		          	&nbsp;&nbsp; ��A12348|LBXSWEFS782638|HBSW998128A|15|<br/>
		          	&nbsp;&nbsp; ��A12349|LBXSWEFS782639|HBSW998129A|02|
		          </font>
		          <b>
		          <br>&nbsp;&nbsp; ע����ʽ�е�ÿһ�����������ڿո�,��ÿ����Ϣ����Ҫ�س����С�
		          </b> 
		      </td>
		    </tr>
			</table>
		</div>

        				       	
     
             <table cellspacing="0">
              	<tbody>
              		<tr>
                		<td id="footer">
                                    <input  name="quchoose" id="quchoose" class="b_foot" type="button" value="ȷ��"  onclick="doCommit();" >
                                    &nbsp;
                                  	<input  name="clear" class="b_foot" type=reset value="����" onclick="doclear()">
                                  	&nbsp;         

                		</td>
              		</tr>
              </tbody>
            </table>
       
       <!-- ��ѯ����б� -->
				<div id="resultContent2" style="display:block">
					<div class="title">
						<div id="title_zi">ʧ�ܽ���б�&nbsp;</div>
					</div>
					<table id="exportExcel2" name="exportExcel2">
						<th width="13%">���ƺ�</th>
						<th width="13%">������Ϣ</th>
						<tbody id="appendBody2">
							
						
						</tbody>
					</table>
				</div>
      <!--��ˮ�� -->
			<input type="hidden" name="printAccept" value="<%=sysAccept%>">
			<!-- �������� -->
			<input type="hidden" name="opCode" value="<%=opCode%>">		
			<!-- �������� -->
			<input type="hidden" name="opName" value="<%=opName%>">		
			<!--�ϴ��ļ��� -->	
			<input type="hidden" name="serviceFileName" value=""/>
			<!--�ϴ��ļ�ȫ·���� -->	
			<input type="hidden" name="serviceFilePath" value=""/>
			<!--���ƺŴ� -->	
			<input type="hidden" name="carPStr" value=""/>
			<!--���ܺŴ� -->	
			<input type="hidden" name="carJStr" value=""/>
			<!--�������Ŵ� -->	
			<input type="hidden" name="carFStr" value=""/>
			<!--�������Ŵ� -->	
			<input type="hidden" name="carNoTypeHide" value=""/>
			<!--���Ų�ƷID -->	
			<input type="hidden" id="product_id" name="product_id" value=""/>
			
			<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
	     <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

