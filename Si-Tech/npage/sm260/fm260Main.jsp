 <%
	/********************
	 version v2.0 R_CMI_HLJ_guanjg_2015_2164784@关于和交通-违章查询业务BOSS与网站系统开发需求的函-集团客户部分
	开发商: si-tech
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
		/*上传标志*/
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
				单个时,交验
				新增时,需要都必须填写
				删除时,车牌号必须填写
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
						rdShowMessageDialog("请选择号牌种类！");
						return false;
					}
				}else if(selFlag == "02"){
					if(!checkElement(document.all.carPNo)){
						return false;
					}
				}
				
			}else if(radioFlag == "piliang"){
				if(!uploadFlag){
					rdShowMessageDialog("请上传批量信息文件！",1);
					return false;
				}
				
			}
			if(rdShowConfirmDialog('确认提交信息么？')==1)
			{
				/*提交置有效*/
			$("#quchoose").attr("disabled","disabled");
				/*提交*/
				formConfirm();
			}
			
		}
		
		function formConfirm(){
			
			
			var radioFlag = $("input[name='opType'][checked]").val();
			var selFlag = $("select[name='opSel']").find("option:selected").val();
			
			/*绑定手机号码*/
			var phoneNo = $.trim($("#phoneNo").val());
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm260/fm260Cfm.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=sysAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=workno%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = phoneNo;
			var iUserPwd = "";
			
			/*
				@ In_sCarNo 车牌号
				@ In_sDivingNo 车架号
				@ In_sMotorNo 发动机号
				
				@ In_sOpType 操作类型：01-添加；02-删除
				@ In_sIPAdd IP地址
				@ In_sGrpID 集团产品ID
				@ In_sUnitID 集团编码

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
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				doclear();
				
			}
			
		}

function doclear(){
	Window.location.reload();	
}
		 
		
/*
	操作类型变更操作
*/		
function changeType(opCode){
	/*清空操作*/
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

	
	/*上传txt文件的方法*/
		function uploadBroad(){
			if($("#workNoList").val() == ""){
				rdShowMessageDialog("请上传批量信息文件！");
				$("#workNoList").focus();
				return false;
			}
			var formFile=frm.workNoList.value.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=frm.workNoList.value.length;
			formFile=frm.workNoList.value.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("上传文件格式只能是txt，请重新选择有价卡信息文件！",1);
				document.frm.workNoList.focus();
				return false;
			}
			else
				{
					/*准备上传*/
					document.frm.target="hidden_frame";
			    document.frm.encoding="multipart/form-data";
			    document.frm.action="/npage/sm260/fm260Upload.jsp";
			    document.frm.method="post";
			    document.frm.submit();
					return true;
				}
			
		}
		/*上传成功后要做的事儿*/
		function doSetFileName(oldFileName,newFileName,newFilePath,carPStr,carJStr,carFStr,carNoType){
			rdShowMessageDialog("上传文件"+oldFileName+"成功！",2);
			$("input[name='serviceFileName']").val(newFileName);
			$("input[name='serviceFilePath']").val(newFilePath);
			
			$("input[name='carPStr']").val(carPStr);
			$("input[name='carJStr']").val(carJStr);
			$("input[name='carFStr']").val(carFStr);
			$("input[name='carNoTypeHide']").val(carNoType);
			
			/*上传置无效*/
			$("#uploadFile").attr("disabled","disabled");
			/*提交置有效*/
			$("#quchoose").attr("disabled","");
			/*单选按钮置无效*/
			$("input[name='opType']").each(function(){
				$(this).attr("disabled","disabled");
			});
			uploadFlag = true;
		}
		/*上传失败后要做的事儿*/
		function showUploadError(errorInfo){
			rdShowMessageDialog(errorInfo,1);
			uploadFlag = false;
			window.location.href='/npage/sm260/fm260Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
			
		}
		
	
   function tellMore1000(){
			rdShowMessageDialog("最多只能上传50条数据！，请重新选择文件",1);
			return false;
	 }
	 /*
	 	2015/05/06 14:20:37 gaopeng R_CMI_HLJ_guanjg_2015_2164784@关于和交通-违章查询业务BOSS与网站系统开发需求的函-集团客户部分
	 	查询和交通信息列表
	 */	
	 function showMsg(){
		 	var unitCode = $.trim($("#unitCode").val());
		 	if(!checkElement($("#unitCode")[0])){
		 		return false;
		 	}
		 	if(unitCode.length == 0){
		 		rdShowMessageDialog("请输入集团编码！",1);
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
			  		<td width="20%" class="blue">集团编码</td>
			  		<td width="84%" colspan="3">
			  			<input type="text" id="unitCode" name="unitCode" v_type="0_9" maxlength="10" value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
			  			<input type="button" id="qryUnitBtn" class="b_text" name="qryUnitBtn" value="查询" onclick="showMsg();"/>
			  		</td>
			    </tr>
			    <tr>
			  		<td width="20%" class="blue">绑定手机号码</td>
			  		<td width="30%">
			  			<input type="text" id="phoneNo" name="phoneNo" v_type="0_9" maxlength="11" value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
			  			
			  		</td>
			  		<td width="20%" class="blue">当前绑定数量</td>
			  		<td width="30%">
			  			<input type="text" id="bindNum"  name="bindNum" value="" v_type="0_9"/>
			  		</td>
			    </tr>
		    	<tr>
        		<td width=20% class="blue">操作方式</td>
        		<td width=30% >
        			<input type="radio" name="opType"	value="simple"   onclick="changeType(this.value);" checked/>单笔操作 &nbsp;&nbsp;
        			<input type="radio" name="opType"	value="piliang"  onclick="changeType(this.value);"/>批量操作 &nbsp;&nbsp;
						</td>
						<td width="20%" class="blue">操作类型</td>
			  		<td width="30%">
			  			<select name="opSel">
			  				<option value="01">新增</option>
			  				<option value="02">删除</option>
			  			</select>
			  		</td>
      		</tr>
	  		</table>
       
       	<table   cellspacing="0" id="dyntb" style="display:none">
 	        <tr >
        		<td width=20% class="blue">车牌号</td>
        		<td width=30% >
                 <input type="text" name="carPNo" v_must="1" id="carPNo" value="" />
        		</td>
        		<td width=20% class="blue">车架号</td>
        		<td width=30% >
                 <input type="text" name="carJNo" v_must="1" id="carJNo" value="" />
        		</td>
  				</tr>
  				<tr >
        		<td width=20% class="blue">发动机号</td>
        		<td width=30% >
                 <input type="text" name="carFNo" v_must="1" id="carFNo" value="" />
        		</td>
        		<td width=20% class="blue">号牌种类</td>
        		<td width=30% >
        				 <select name="carNoType">
        				 		<option value="$$">--请选择--</option>
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
						批量信息导入
					</td>
					<td>
						<input type="file" name="workNoList" id="workNoList" class="button"
						style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
						&nbsp;&nbsp;
						<input type="button" name="uploadFile" id="uploadFile" class="b_text" value="上传" onclick="uploadBroad();"/>
					</td>
				</tr>
				<tr>
					<td class="blue">
						文件格式说明
					</td>
		      <td> 
		          上传文件文本格式为“车牌号|车架号|发动机号|号牌种类|”，示例如下：<br>
		          <font class='orange'>
		          	&nbsp;&nbsp; 黑A12341|LBXSWEFS782631|HBSW998121A|01|<br/>
		          	&nbsp;&nbsp; 黑A12342|LBXSWEFS782632|HBSW998122A|02|<br/>
		          	&nbsp;&nbsp; 黑A12343|LBXSWEFS782633|HBSW998123A|15|<br/>
		          	&nbsp;&nbsp; 黑A12344|LBXSWEFS782634|HBSW998124A|01|<br/>
		          	&nbsp;&nbsp; 黑A12345|LBXSWEFS782635|HBSW998125A|02|<br/>
		          	&nbsp;&nbsp; 黑A12346|LBXSWEFS782636|HBSW998126A|15|<br/>
		          	&nbsp;&nbsp; 黑A12347|LBXSWEFS782637|HBSW998127A|01|<br/>
		          	&nbsp;&nbsp; 黑A12348|LBXSWEFS782638|HBSW998128A|15|<br/>
		          	&nbsp;&nbsp; 黑A12349|LBXSWEFS782639|HBSW998129A|02|
		          </font>
		          <b>
		          <br>&nbsp;&nbsp; 注：格式中的每一项均不允许存在空格,且每条信息都需要回车换行。
		          </b> 
		      </td>
		    </tr>
			</table>
		</div>

        				       	
     
             <table cellspacing="0">
              	<tbody>
              		<tr>
                		<td id="footer">
                                    <input  name="quchoose" id="quchoose" class="b_foot" type="button" value="确认"  onclick="doCommit();" >
                                    &nbsp;
                                  	<input  name="clear" class="b_foot" type=reset value="重置" onclick="doclear()">
                                  	&nbsp;         

                		</td>
              		</tr>
              </tbody>
            </table>
       
       <!-- 查询结果列表 -->
				<div id="resultContent2" style="display:block">
					<div class="title">
						<div id="title_zi">失败结果列表&nbsp;</div>
					</div>
					<table id="exportExcel2" name="exportExcel2">
						<th width="13%">车牌号</th>
						<th width="13%">错误信息</th>
						<tbody id="appendBody2">
							
						
						</tbody>
					</table>
				</div>
      <!--流水号 -->
			<input type="hidden" name="printAccept" value="<%=sysAccept%>">
			<!-- 操作代码 -->
			<input type="hidden" name="opCode" value="<%=opCode%>">		
			<!-- 操作代码 -->
			<input type="hidden" name="opName" value="<%=opName%>">		
			<!--上传文件名 -->	
			<input type="hidden" name="serviceFileName" value=""/>
			<!--上传文件全路径名 -->	
			<input type="hidden" name="serviceFilePath" value=""/>
			<!--车牌号串 -->	
			<input type="hidden" name="carPStr" value=""/>
			<!--车架号串 -->	
			<input type="hidden" name="carJStr" value=""/>
			<!--发动机号串 -->	
			<input type="hidden" name="carFStr" value=""/>
			<!--发动机号串 -->	
			<input type="hidden" name="carNoTypeHide" value=""/>
			<!--集团产品ID -->	
			<input type="hidden" id="product_id" name="product_id" value=""/>
			
			<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
	     <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

