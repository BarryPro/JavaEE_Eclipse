<%
  /*
   * 功能:批量工号置无效的功能
   * 版本: 1.0
   * 日期: 2012/07/24
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String sWorkNo = (String)session.getAttribute("workNo");
 		String dNopass = (String)session.getAttribute("password");
 		String serverIp=realip.trim();
 		String chnSource="01";
 		String phoneNo = "";
 		String opCode = "e941";
 		String opName = "批量工号置无效";
 		
%>
<!--取流水号方法 -->
<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		String printAccept = seq;
%>
<html>
<head>
	<title>批量工号置无效</title>
	<script language="javascript">
		
		$(document).ready(function(){
		
		});
		
		function submitt(){
			if($("#workNoList").val() == ""){
				rdShowMessageDialog("请上传BOSS工号文件！");
				return false;
			}
			if($("#oaNumber").val()==""){
				rdShowMessageDialog("请输入OA编号！");
				return;
			}
			if($("#oaTitle").val()==""){
				rdShowMessageDialog("请输入OA标题！");
				return;
			}
			var formFile=frm.workNoList.value.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=frm.workNoList.value.length;
			formFile=frm.workNoList.value.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("上传文件格式只能是txt，请重新选择BOSS工号文件！",1);
				document.frm.workNoList.focus();
				return false;
			}
			else
				{
					doajax();
					return true;
				}
			
		}
		
		function doajax()
		{
			var fileName1 = $("input[name='serviceFileName']").val();
			var MydataPacket = new AJAXPacket("/npage/se941/fe941Cfm.jsp","正在处理批量工号置无效，请稍候......");
			MydataPacket.data.add("iLoginAccept","0");
			MydataPacket.data.add("iChnSource","<%=chnSource%>");
			MydataPacket.data.add("OpCode","<%=opCode%>");
			MydataPacket.data.add("iLoginNo","<%=sWorkNo%>");
			MydataPacket.data.add("iLoginPwd","<%=dNopass%>");
			MydataPacket.data.add("iPhoneNo","<%=phoneNo%>");
			MydataPacket.data.add("iUserPwd","");
			MydataPacket.data.add("iInputFile",fileName1);
			MydataPacket.data.add("iServerIp","<%=serverIp%>");
			MydataPacket.data.add("iOpNote","批量工号置无效");
			MydataPacket.data.add("close_reason",$("#close_reason").val());
			MydataPacket.data.add("oaNumber",$("#oaNumber").val());
			MydataPacket.data.add("oaTitle",$("#oaTitle").val());
			core.ajax.sendPacket(MydataPacket);
			MydataPacket = null;
			
		}
		function doProcess(packet){
			//得到成功条数
			var successNo = packet.data.findValueByName("SuccessNo");
			//得到错误信息
			var errorMsg = packet.data.findValueByName("ErrorMsg");
			//得到响应标识
			var flag = packet.data.findValueByName("Flag");
			//得到总条数
			var all_totalNo = $("input[name='uploadLine']").val();
			//计算失败条数
			var results=all_totalNo-successNo;
			if(flag==0)
			{
				
					//成功条数打印
					$("#suc_noinfo").html(successNo+"");
					//失败条数打印
					$("#err_noinfo").html(results+"");
					$("#sucessMsg").show();
					$("#errorMsg").show();
					//如果存在失败的工号
					if(results>0)
					{
						$("#errorbutton").show();
					}
					else 
						{
							$("#errorbutton").hide();
						}
				
			}else{
				rdShowMessageDialog(errorMsg,1);
				return false;
			}

		}
		function uploadWorkNoList(){
			document.frm.target="hidden_frame";
	    document.frm.encoding="multipart/form-data";
	    document.frm.action="fe941_upload.jsp";
	    document.frm.method="post";
	    document.frm.submit();
		}
		function doSetFileName(fileName1,lines){
			$("input[name='serviceFileName']").val(fileName1);
			//计算上传txt文件中一共有多少条工号
			var arrys = lines.split(",").length-1;
			$("input[name='uploadLine']").val(arrys);
			rdShowMessageDialog("上传文件成功！",2);
			$("#oaMsg").show();
			
		}
		//上传置无效
		function setdisabled()
		{
			$("#workNoList").attr("disabled","disabled");
			$("#uploadFile").attr("disabled","disabled");
		}
		//查看错误文档方法
		function seeInformation()
		{
			var filename=$("input[name='printAccept']").val();
			var path = "<%=request.getContextPath()%>/npage/se941/fe941error.jsp?fileName="+filename+".txt";
			window.open(path,"","height=500, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
		}
	</script>
	</head>
<body>
	<form action="" method="post" name="frm">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">批量工号置无效</div>
	</div>
	<table>
			<tr>
				<td width="18%" class="blue">
					批量工号导入
				</td>
				<td>
					<input type="file" name="workNoList" id="workNoList" class="button"
					style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
					&nbsp;&nbsp;
					<input type="button" name="uploadFile" id="uploadFile" class="b_text" value="上传" onclick="uploadWorkNoList();"/>
				</td>
			</tr>
		<tr>
			<td class="blue">关停原因</td>
			<td>
				<select id="close_reason">
					<option value="1">违规</option>
					<option value="2">停业</option>
					<option value="3">到期</option>
					<option value="4">其他</option>
				</select>
			</td>
		</tr>
			<tr>
				<td class="blue">
					文件格式说明
				</td>
        <td> 
            上传文件文本格式为“工号+回车键”，示例如下：<br>
            <font class='orange'>
            	&nbsp;&nbsp; aaa457<br/>
            	&nbsp;&nbsp; aaa889<br/>
            	&nbsp;&nbsp; aacv02<br/>
            	&nbsp;&nbsp; an1051<br/>
            	&nbsp;&nbsp; an1053<br/>
            	&nbsp;&nbsp; ab1204
            </font>
            <b>
            <br>&nbsp;&nbsp; 注：格式中的每一项均不允许存在空格,且每个工号都需要回车换行。
            </b> 
        </td>
	    </tr>
		</table>
		
		<table id="sucessMsg" cellSpacing=0 style="display:none">
					<tr>
						<td class="blue" width="18%">
							成功个数
						</td>
						<td id="suc_noinfo">
							
						</td>
					</tr>
			</table>
			<table id="errorMsg" cellSpacing=0 style="display:none">
					<tr>
						<td class="blue" width="18%">
							失败个数
						</td>
						<td id="err_noinfo">
							
						</td>
						<td id="errorbutton">
							<input class="b_foot_long" name="seeInfo" type="button" value="失败信息查看" onClick="seeInformation()">
						</td>
					</tr>
			</table>
			<table id="oaMsg" cellSpacing=0 style="display:none">
					<tr>
						<td class="blue">&nbsp;OA编号</td>
						<td><input type="text" id="oaNumber" name="oaNumber" maxlength="30"/></td>
					</tr>
					<tr>
						<td class="blue">&nbsp;OA标题</td>
						<td><input type="text" id="oaTitle" name="oaTitle" maxlength="30"/></td>
					</tr>
			</table>
		<table  cellSpacing=0>
				<tbody>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="确认" onclick="submitt()" id="Button1">&nbsp;&nbsp;
							<input  name="resetsd"  class="b_foot" type="button" value="清除" onclick="javascript:window.location.href='/npage/se941/fe941.jsp'" id="Button3">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value=关闭 id="Button2" onclick="removeCurrentTab()">
						</td>
					</tr>
				</tbody>
			</table>
			<!--流水号 -->
			<input type="hidden" name="printAccept" value="<%=printAccept%>">		
			<!--上传文件全路径名 -->	
			<input type="hidden" name="serviceFileName" value=""/>
			<!--上传的总工号个数 -->
			<input type="hidden" name="uploadLine" value=""/>
			<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>