 <%
	/********************
	 version v2.0
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


%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regioncode%>"  id="sysAccept" />

<HTML>
	<HEAD>
		<TITLE><%=opName%></TITLE>
		<script language="JavaScript">
		$(document).ready(function(){
			
			changeType();			
			doQry2();
		
		});
		function doCommit()
		{
			var radioFlag = $("input[name='opType'][checked]").val();
			if(radioFlag == "simple"){
				
				/*����ѡ����Ʒ��Ϣ*/
				var giftSel = $.trim($("select[name='giftSel']").find("option:selected").val());
				
				if(giftSel.length == 0){
					rdShowMessageDialog("��ѡ���ն���Ʒ��",0);
					return false;
				}
				
			}else if(radioFlag == "piliang"){
				var checkGroupIds ="";
				/*����Ҫѡ��һ����ɾ��*/
				/*��ȡ��ѡ�е�groupId����|�ָ�*/
				$("input[name='groupIdChkS'][checked]").each(function(i){
					var thisVal = $(this);
					if(i==0){
						checkGroupIds = thisVal.val();
					}else{
						checkGroupIds += "|"+thisVal.val();
					}
				});
				if(checkGroupIds.length == 0){
					rdShowMessageDialog("����ѡ��һ��������Ϣ��",0);
					return false;
				}
			}		
			
      if(rdShowConfirmDialog('ȷ���ύ��Ϣô��')==1)
      {
      	/*�ύ����Ч*/
				$("#quchoose").attr("disabled","disabled");
	    	formConfirm();
      }
				
			  return true;
			}
		
		function formConfirm(){
			
			var phoneNo = "";
			var radioFlag = $("input[name='opType'][checked]").val();
			var upFileName = "";
			var checkGroupIds = "";
			/*��Ʒ���� ����ʱΪ������ɾ��ʱΪ���*/
			var giftNos = "";
			
			if(radioFlag == "simple"){
				upFileName = $("input[name='serviceFileName']").val();
				
				var giftSel = $.trim($("select[name='giftSel']").find("option:selected").val());
				var giftArray = new Array();
				giftArray = giftSel.split("|");
				var giftNo = giftArray[0];
				giftNos = giftNo;
				
			}else if(radioFlag == "piliang"){
				
				/*��ȡ��ѡ�е�groupId����|�ָ�*/
				$("input[name='groupIdChkS'][checked]").each(function(i){
					var thisVal = $(this);
					var thisValArray = new Array();
					thisValArray = thisVal.val().split("|");
					if(i==0){
						checkGroupIds = thisValArray[0];
						giftNos = thisValArray[1];
					}else{
						checkGroupIds += "|"+thisValArray[0];
						giftNos += "|"+thisValArray[1];
					}
				});
				
			}
			
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm295/fm295Cfm.jsp","���ڻ�����ݣ����Ժ�......");
			
			var opCode = "<%=opCode%>";
			
			getdataPacket.data.add("opCode",opCode);
			getdataPacket.data.add("upFileName",upFileName);
			getdataPacket.data.add("radioFlag",radioFlag);
			getdataPacket.data.add("checkGroupIds",checkGroupIds);
			getdataPacket.data.add("giftNos",giftNos);
			
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var errorNum = packet.data.findValueByName("errorNum");
			var infoArray = packet.data.findValueByName("infoArray");
			var radioFlag = $("input[name='opType'][checked]").val();
			
			if(retCode == "000000"){
				if(radioFlag == "simple"){
					rdShowMessageDialog("������ɣ���鿴���������",2);
				
				$("#resultContent2").show();
				$("#appendBody2").empty();
				$("#errorNum").html(errorNum);	
				for(var i=0;i<infoArray.length;i++){
						
						var msg0 = infoArray[i][0];
						var msg1 = infoArray[i][1];
				
						var appendStr = "<tr>";
						
						appendStr += "<td width='50%'>"+msg0+"</td>"
												+"<td width='50%'>"+msg1+"</td>"
						appendStr +="</tr>";	
										
						$("#appendBody2").append(appendStr);
					}
				}else{
					rdShowMessageDialog("�����ɹ���",2);
					doclear();
				}
				
				
			}else{
				$("#resultContent2").hide();
				$("#appendBody2").empty();
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				doclear();
				
			}
			
		}


		function doclear()
		{
		    window.location.href='/npage/sm295/fm295Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
		}
		
function changeType(opCode){
	
	var radioFlag = $("input[name='opType'][checked]").val();
	/*����*/
	if(radioFlag == "simple"){
		
		$("#gswd").hide();
		$("#mutiConstants").show();
		$("#resultContent").hide();
		$("#printTable1").hide();
		$("#qryContent4").show();
		
	}else if(radioFlag == "piliang"){
		/*ɾ��*/
		$("#gswd").show();
		$("#mutiConstants").hide();
		$("#resultContent").show();
		$("#printTable1").show();
		$("#qryContent4").hide();
	}
	
}


	
	/*�ϴ�txt�ļ��ķ���*/
		function uploadBroad(){
			if($("#workNoList").val() == ""){
				rdShowMessageDialog("���ϴ��ļ���");
				$("#workNoList").focus();
				return false;
			}
			var formFile=frm.workNoList.value.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=frm.workNoList.value.length;
			formFile=frm.workNoList.value.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("�ϴ��ļ���ʽֻ����txt��������ѡ���ļ���",1);
				document.frm.workNoList.focus();
				return false;
			}
			else
				{
					/*׼���ϴ�*/
					document.frm.target="hidden_frame";
			    document.frm.encoding="multipart/form-data";
			    document.frm.action="/npage/sm295/fm295Upload.jsp";
			    document.frm.method="post";
			    document.frm.submit();
					return true;
				}
			
		}
		/*�ϴ��ɹ���Ҫ�����¶�*/
		function doSetFileName(oldFileName,newFileName,newFilePath){
			rdShowMessageDialog("�ϴ��ļ�"+oldFileName+"�ɹ���",2);
			$("input[name='serviceFileName']").val(newFileName);
			$("input[name='serviceFilePath']").val(newFilePath);
			/*�ϴ�����Ч*/
			$("#uploadFile").attr("disabled","disabled");
			/*�ύ����Ч*/
			$("#quchoose").attr("disabled","");
			/*��ѡ��ť����Ч*/
			$("input[name='opType']").each(function(){
				$(this).attr("disabled","disabled");
			});
		}
		/*�ϴ�ʧ�ܺ�Ҫ�����¶�*/
		function showUploadError(errorInfo){
			rdShowMessageDialog(errorInfo,1);
			window.location.href='/npage/sm295/fm295Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
			
		}
    
   	function tellMore1000(){
			rdShowMessageDialog("���ֻ���ϴ�200�����ݣ���������ѡ���ļ�",1);
			return false;
		}
		
		function doQryBtn(){
			
			var groupId = $.trim($("#groupId").val());
			
			if(!checkElement($("#groupId")[0])){
				
				return false;
			}
				
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm295/fm295Qry.jsp","���ڻ�����ݣ����Ժ�......");
			
			
			var iOpCode = "<%=opCode%>";
			
			
			
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iGroupId",groupId);
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
		
	function doRetRegion(packet){
		
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var outNum = packet.data.findValueByName("outNum");
			
			var infoArray = packet.data.findValueByName("infoArray");
			
			
			
		if(retCode == "000000" && outNum != "0"){
		
				$("#resultContent").show();
				$("#appendBody").empty();

				for(var i=0;i<infoArray.length;i++){
						
						var msg0 = infoArray[i][0];
						var msg1 = infoArray[i][1];
						var msg2 = infoArray[i][2];
						var msg3 = infoArray[i][3];
						var msg4 = infoArray[i][4];
						var msg5 = infoArray[i][5];
						/*��Ʒ����*/
						var msg6 = infoArray[i][6];
						/*��Ʒ����*/
						var msg7 = infoArray[i][7];
				
						var appendStr = "<tr>";
						var appendCheckBoxStr = "<input type='checkbox' name='groupIdChkS' value='"+msg2+"|"+msg6+"'/> ";
						appendStr += "<td width='10%'>"+appendCheckBoxStr+"</td>"
												+"<td width='15%'>"+msg2+"</td>"
												+"<td width='15%'>"+msg7+"</td>"
												+"<td width='15%'>"+msg3+"</td>"
												+"<td width='15%'>"+msg0+"->"+msg1+"</td>"
												+"<td width='15%'>"+msg4+"</td>"
												+"<td width='15%'>"+msg5+"</td>"
						appendStr +="</tr>";	
										
						$("#appendBody").append(appendStr);
					}
				/*�ύ����Ч*/
				$("#quchoose").attr("disabled","");
				/*��ѡ��ť����Ч*/
				$("input[name='opType']").each(function(){
					$(this).attr("disabled","disabled");
				});
			}else{
				
				$("#appendBody").empty();
				//$("#export").attr("disabled","disabled");
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				doclear();
			}
		}
		function checkAll(){
			var checkStatus = $("input[name='groupIdChkAll']").attr("checked");
			if(checkStatus == true){
				$("input[name='groupIdChkS']").each(function(){
					$(this).attr("checked",true);
				});
			}else{
				$("input[name='groupIdChkS']").each(function(){
					$(this).attr("checked",false);
				});
			}
		}
		
		function doQry2(){
			
			/*�ֻ�����*/
			var phoneNo = "";
			/*��Ʒ����*/
			var giftNo = $.trim($("#giftNo").val());
			/*��Ʒ����*/
			var giftName = $.trim($("#giftName").val());
			
				
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm295/fm295QryGift.jsp","���ڻ�����ݣ����Ժ�......");
		 	getdataPacket.data.add("phoneNo",phoneNo);
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("giftNo",giftNo);
			getdataPacket.data.add("giftName",giftName);
			core.ajax.sendPacket(getdataPacket,doRetRegion2);
			getdataPacket = null;
			
			
		}
		
		function doRetRegion2(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			var canUseJf = packet.data.findValueByName("canUseJf");
			
		
			if(retCode == "000000"){
				if(infoArray.length == 0){
					rdShowMessageDialog("û�пɶһ���Ʒ!",1);
					return false;
				}	
				/*��ֵ���û���*/
				$("#canUseJf").val(canUseJf);
				var optionStr = "<option value='' selected>--��ѡ��--</option>";
				for(var i=0;i<infoArray.length;i++){
					var giftSum = infoArray[i][0];
					if(giftSum == "0"){
						rdShowMessageDialog("�޿ɶһ���Ʒ��");
						return false;
					}
					var giftNo = infoArray[i][0];
					var giftName = infoArray[i][1];
					var giftContent = infoArray[i][2];
					var giftJf = infoArray[i][5];
					var giftPrice = infoArray[i][7];
					var initPrice = 0;
					if(giftPrice.length != 0){
						initPrice = Number(giftPrice)/100;
					}
					
					optionStr += "<option value='"+giftNo+"|"+giftName+"|"+giftContent+"|"+giftJf+"|"+initPrice+"'>"+giftName+"-->"+giftJf+"����</option>"

				}
				$("select[name='giftSel']").empty();
				$("select[name='giftSel']").append(optionStr);
				
				$("#qryContent4").show();
				
			}else{
				$("#qryContent1").hide();
				$("#qryContent2").hide();
				$("#qryContent3").hide();
				$("#qryContent4").hide();
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
			}
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
	<input type="hidden" name="sysAccept" value="<%=sysAccept%>"> 
	<input type="hidden" name="opflag" value="0">

        <table id=""  cellspacing="0">      	
        	  <tr>

			        		<td width=20% class="blue">��������</td>

			        		<td width=80% colspan="3">

			        			<input type="radio" name="opType"	value="simple"   onclick="changeType(this.value);" checked/>���� &nbsp;&nbsp;

			        			<input type="radio" name="opType"	value="piliang"  onclick="changeType(this.value);"/>ɾ�� &nbsp;&nbsp;

			        		</td>

        				</tr>
		        <tr style="display:none">
				  		<td width="20%" class="blue">��Ʒ����</td>
				  		<td width="30%">
				  			<input type="text" id="giftNo" name="giftNo"  value=""/>
				  		</td>
				  		<td width="20%" class="blue">��Ʒ����</td>
				  		<td width="30%">
				  			<input type="text" id="giftName" name="giftName" value="" />
				  		</td>
				  	</tr>
				  	
		  	<tr id="qryContent1" style="display:none">
		  		<td width="20%" class="blue">���û���</td>
		  		<td width="80%" colspan="3">
		  			<input type="text" id="canUseJf" name="canUseJf" value="" class="InputGrey" readonly />
		  		</td>
		  		
		  	</tr>
		  	<tr id="qryContent4" style="display:none">
		  		<td width="20%" class="blue">��Ʒ��Ϣ</td>
		  		<td width="80%" colspan="3">
		  			<select name="giftSel" onchange= "changeGift();" style="width:320px">
		  				
		  			</select>
		  		</td>
		  	</tr>
		  	<tr id="qryContent2" style="display:none">
		  		<td width="20%" class="blue">��Ʒ����</td>
		  		<td width="80%" colspan="3" id="giftContent">
		  			
		  		</td>
		  	</tr>
		  	<tr id="qryContent3" style="display:none">
		  		<td width="20%" class="blue">�һ�����</td>
		  		<td width="80%" colspan="3">
		  			<input type="text" id="dhNum" class="InputGrey" name="dhNum" value="1" v_type="0_9" v_must="1" readOnly/>
		  			
		  			<input type="hidden" id="giftJf" name="giftJf" value="" />
		  		</td>
		  	</tr>
	  	
       </table>
      
       <table id="gswd">
       	<tr>
       		<td width="20%" class="blue">
						��������
					</td>
					<td colspan="3">
						<input type="text" id="groupId" name="groupId" value="" v_type="0_9" v_must="0" />
						<input type="button" name="doQry" id="doQry" class="b_text" value="��ѯ" onclick="doQryBtn();"/>
						&nbsp;<font class="orange">������groupId</font>
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
		          �ϴ��ļ��ı���ʽΪgroupid��10031����.txt�ļ���ʾ�����£�<br>
		          <font class='orange'>
		          	&nbsp;&nbsp; 10031<br/>
		          	&nbsp;&nbsp; 10032<br/>
		          	&nbsp;&nbsp; 10033<br/>
		          	&nbsp;&nbsp; 10034<br/>
		          	&nbsp;&nbsp; 10035<br/>
		          	&nbsp;&nbsp; 10036<br/>
		          	&nbsp;&nbsp; 10037<br/>
		          	&nbsp;&nbsp; 10038<br/>
		          	&nbsp;&nbsp; 10039
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
                            <input  name="quchoose" id="quchoose" class="b_foot" type="button" value="ȷ��"  onclick="doCommit();" disabled="disabled">
                            &nbsp;
                            <input type="button" class="b_text" id="printTable1" name="printTable1" value="����Excel���" onclick="printTable();"/>
                          	&nbsp;
                          	<input  name="clear" class="b_foot" type=reset value="����" onclick="doclear()">
                          	&nbsp;

        		</td>
      		</tr>
      </tbody>
    </table>
    <!-- ��ѯ����б� -->
		<div id="resultContent" style="display:block">
			<div class="title">
				<div id="title_zi">��ѯ����б�&nbsp;</div>
			</div>
			<table id="exportExcel" name="exportExcel">
				<th width="10%"><input type='checkbox' name='groupIdChkAll' onclick="checkAll();" value=""/>ѡ��</th>
				<th width="15%">��������</th>
				<th width="15%">��Ʒ����</th>
				<th width="15%">��������</th>
				<th width="15%">��������</th>
				<th width="15%">���ù���</th>
				<th width="15%">����ʱ��</th>
				<tbody id="appendBody">
					
				
				</tbody>
			</table>
		</div>
    <!-- ��ѯ����б� -->
		<div id="resultContent2" style="display:none">
			<div class="title">
				<div id="title_zi">������Ϣ�б�&nbsp;�������:<span ><font id="errorNum" color="red"></font></span></div>
			</div>
			<table id="exportExcel2" name="exportExcel2">
				<th width="50%">��������</th>
				<th width="50%">������Ϣ</th>
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
			<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
	     <%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=1;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</script>
</BODY>
</HTML>

