   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-15
********************/
%>
              
<%
  String opCode = "5517";
  String opName = "特殊操作权限配置";
  String sWorkNo = (String)session.getAttribute("workNo");
 	String dNopass = (String)session.getAttribute("password");
 	String chnSource="01";
 	String phoneNo = "";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/common/serverip.jsp" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String serverIp=realip.trim();
	String regionCode = (String)session.getAttribute("regCode");
	String sqlString = " select op_code,op_display_name from sHighOpr order by op_code";
	String resultList[][] = new String[][]{};
%>


		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlString%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

<%	
		
		if(code.equals("000000"))
		resultList = result_t2;
	
	int iCodeIndex =0;
%>
<!--取流水号方法 -->
<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		String printAccept = seq;
		String haveAccess = "false";
%>
<wtc:service name="sCommonCheck" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeXXYH" retmsg="retMsgXXYH" outnum="1">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="1500"/>
		<wtc:param value="<%=sWorkNo%>"/>
		<wtc:param value="<%=dNopass%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="2"/>
		</wtc:service>
	<wtc:array id="XXYHRet" scope="end"/>	
		
<%
	if("000000".equals(retCodeXXYH) && XXYHRet.length > 0){
		if("0".equals(XXYHRet[0][0])){
			haveAccess = "true";
		}else{
			haveAccess = "false";
		}
	}else{
		haveAccess = "false";
	}
	System.out.println("gaopengSeeLog1500-------haveAccess===="+haveAccess);
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>特殊操作权限配置</title>
<script language=javascript>
	
	$(document).ready(function(){
		
		});
var isHave = "no";

function doSearch() {
	
	if(document.frm.iLoginNo.value.length == 0){
		rdShowMessageDialog("请输入工号！",0);
	} else {
	    document.frm.search.disabled =true;
	    var myPacket = new AJAXPacket("s5517Search.jsp","正在查询，请稍候......");

	    myPacket.data.add("login_no",document.frm.iLoginNo.value);
	    myPacket.data.add("op_code",document.frm.iOpCode.value);
	    
        core.ajax.sendPacket(myPacket);
        myPacket = null;
	}
}

function doProcess(packet){
	var errcode = packet.data.findValueByName("errcode");
	//alert("RPC返回状态值"+errcode);
    
	if (errcode == null) {
	   var backGroupInfo = packet.data.findValueByName("backGroupInfo");

	   rdShowMessageDialog(backGroupInfo);
	   document.frm.submit1.disabled =true;
	   document.frm.iLoginNo.value ="";
	  
    } else {
    		var ret_msg;
	    switch(errcode)
	    {
	    	case "0":
	    		rdShowMessageDialog("此工号不存在，请修改后再试！",0);
	    		isHave = "nothing";
	    		ret_msg = "";
	    		break;
	    		
	    	case "1":
	    		ret_msg = "工号["+document.frm.iLoginNo.value+"]不具有["+document.frm.iOpCode.value+"]执行权限,您可以增加！<font color";
	    		isHave = "no";
	    		break;
	    	case "2":
	    		ret_msg = "工号["+document.frm.iLoginNo.value+"]已具有["+document.frm.iOpCode.value+"]执行权限,您可以删除！";
	    		isHave = "yes";
	    		break;
	    	default:
	    		rdShowMessageDialog("RPC返回值出错，请联系系统管理员！",0);
	    		isHave = "nothing";
	    }
	    //alert(packet.data.findValueByName("ret_msg"));
	    	document.all.retmsg.innerHTML = "<p><font class='orange'>"+ret_msg+"</font></p>";
	    	onChangeOpType();
	}
}

function onChangeOpCode()
{
	document.frm.submit1.disabled = true;
	document.frm.search.disabled = false;
}

function onChangeOpType()
{
	var opType = document.frm.opType.value;
	var result=$("input[name='LoginRadio']:checked").val();
	if(result=="1")
	{
		document.frm.submit1.disabled = false;
	}
	else{
	document.frm.submit1.disabled = true;
	switch(opType)
	{
		case "a":
			document.frm.submit1.value = "增加";
			if(isHave == "no") 
			{
				document.frm.submit1.disabled = false;
				
			}
			break;
		case "d":
			document.frm.submit1.value = "删除";
			if(isHave == "yes")
			{
				document.frm.submit1.disabled = false;
				
			}
			break;
		default:
			break;
	}	
}
}

function onChangeLoginNo()
{
	document.frm.search.disabled = false;
	
}
//上传批量工号文件方法 2012-8-1 gaopeng
function uploadWorkNoList(){

			document.frm.target="hidden_frame";
	    document.frm.encoding="multipart/form-data";
	    document.frm.action="s5517_upload.jsp";
	    document.frm.method="post";
	    document.frm.submit();
		}
//赋值上传的文件的全路径名以及赋值上传文件中的工号总个数
	function doSetFileName(fileName1,lines){
			$("input[name='serviceFileName']").val(fileName1);
			//计算上传txt文件中一共有多少条工号
			var arrys = lines.split(",").length-1;
			$("input[name='uploadLine']").val(arrys);
			rdShowMessageDialog("上传文件成功！",2);
			
		}
	//上传置无效
		function setdisabled()
		{
			$("#workNoList").attr("disabled","disabled");
			$("#uploadFile").attr("disabled","disabled");
		}
function doSubmit()
{
	var result=$("input[name='LoginRadio']:checked").val();
	/*
		2015/05/18 8:39:27 gaopeng R_CMI_HLJ_guanjg_2015_2233990@关于在BOSS系统中特殊号码查询增加密码验证功能的请示
		如果选择的是1500优惠信息查询权限，判断是否有1500免密权限，否则不让提交
	*/
	var iopCode = $.trim($("select[name='iOpCode']").find("option:selected").val());
	if(iopCode == "1500"){
		if("<%=haveAccess%>" != "true"){
			rdShowMessageDialog("该工号没有1500免密权限，不能添加【1500优惠信息查询权限】！",1);
			return false;
		}
	}
	
	if(result=="1")
	{
			if($("#workNoList").val() == ""){
				rdShowMessageDialog("请上传BOSS工号文件！",1);
				return false;
			}
			var formFile=frm.workNoList.value.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=frm.workNoList.value.length;
			formFile=frm.workNoList.value.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("上传文件格式只能是txt，请重新选择BOSS工号文件！");
				document.frm.workNoList.focus();
				return false;
			}
			else
			{
					doajax();
					return true;
			}
	}
	else if(result=="0")
		{
			getAfterPrompt();
			document.frm.action="s5517Cfm.jsp";
			document.frm.method="post";
			document.frm.submit();
		}
	
}
//ajax调用服务方法
function doajax()
		{
			var fileName1 = $("input[name='serviceFileName']").val();
			//得到操作类型
			var opType = document.frm.opType.value;
			var MydataPacket = new AJAXPacket("/npage/codeManage/s5517Cfm2.jsp","正在处理批量工号，请稍候......");
			//业务流水
			MydataPacket.data.add("iLoginAccept","0");
			//渠道标识
			MydataPacket.data.add("iChnSource","<%=chnSource%>");
			//操作代码
			MydataPacket.data.add("OpCode","<%=opCode%>");
			//工号
			MydataPacket.data.add("iLoginNo","<%=sWorkNo%>");
			//工号密码
			MydataPacket.data.add("iLoginPwd","<%=dNopass%>");
			//手机号
			MydataPacket.data.add("iPhoneNo","<%=phoneNo%>");
			//号码密码
			MydataPacket.data.add("iUserPwd","");
			//传入文件全路径名
			MydataPacket.data.add("iInputFile",fileName1);
			//IP地址
			MydataPacket.data.add("iServerIp","<%=serverIp%>");
			//操作类型
			MydataPacket.data.add("iDelayType",opType);
			//选择的操作代码
			var iopCode = $("select[name='iOpCode']").find("option:selected").val();
			//alert(iopCode);
			MydataPacket.data.add("iopCode",iopCode);
			core.ajax.sendPacket(MydataPacket,doProcess22);
			MydataPacket = null;
			
		}
	//Ajax回调函数	
	function doProcess22(packet){
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
function typechange()
{
		var result=$("input[name='LoginRadio']:checked").val();
			 	//如果是批量工号 显示mutiInfo 隐藏第一行的工号、输入框以及查询按钮
			 	if(result=="1")
			 	{
			 		document.frm.submit1.disabled = false;
			 		$("#retmsg").html("");
			 		$("#mutiInfo").show();
			 		$("#displayNo").hide();
			 		$("#displayIn").hide();
			 		$("#displayBtn").hide();
			 		//调整单元格
			 		$("#changewidth").attr("width","9%");
			 		var successNos = $("#suc_noinfo").html();
			 		if(successNos.length!=0)
			 		{
			 			$("#sucessMsg").show();
			 			$("#errorMsg").show();
			 		}
			 	}
			 	else if(result=="0")
		 		{
		 			document.frm.submit1.disabled = true;
		 			$("#mutiInfo").hide();
			 		$("#displayNo").show();
			 		$("#displayIn").show();
			 		$("#displayBtn").show();
			 		//调整单元格
			 		$("#changewidth").attr("width","10%");
			 		$("#retmsg").html("");
			 		$("#sucessMsg").hide();
			 		$("#errorMsg").hide();
		 			
		 		}
}
	//查看错误文档方法
		function seeInformation()
		{
			var filename=$("input[name='printAccept']").val();
			var path = "<%=request.getContextPath()%>/npage/codeManage/s5517_error.jsp?fileName="+filename+".txt";
			window.open(path,"","height=500, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
		}
</script>
</head>
<body>

 <form  method="post" name="frm" >
     <%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">特殊操作权限配置</div>
	</div>

			<table>
						<tr>
							<td  width="9%" class="blue">
								工号类型
							</td>
							<td colspan="6">
							<input type="radio"   name="LoginRadio" onclick="typechange()" value="0" checked>单一工号</input> 
							<input type="radio"   name="LoginRadio" onclick="typechange()" value="1">批量工号</input> 
							</td>
						</tr>
			</table>


		  <table  cellpadding="0">
			  <tbody>
				  <tr> 
					  <td id="changewidth" width="10%" class="blue">操作类型					  </td>
					  <td width="8">
					  	<select name="opType" onChange="onChangeOpType()">
							<option value="a" selected="selected">增加</option>
							<option value="d">删除</option>
						</select>
				    </td>
					  	
					  <td width="10%" class="blue">
					 	 操作代码					  </td>
					  <td width="32%">
					  	<select name="iOpCode">
<%
				for(int iii=0;iii<result_t2.length;iii++){
				for(int jjj=0;jjj<result_t2[iii].length;jjj=jjj+2){
%>

							<option value="<%=result_t2[iii][jjj-1>0?jjj:0]%>" selected="selected"><%=result_t2[iii][jjj-1>0?jjj:0]+"-->"+result_t2[iii][jjj+1]%></option>
<%					
					
				}
				}

%>					  		
						</select>
				    </td>
					  <td id="displayNo" width="10%" class="blue" >
					  	工号					  </td>
					  <td id="displayIn" width="20%" >
					  	<input type="text" name="iLoginNo" width="7"  onFocus="onChangeLoginNo()"/>
				    </td>
					  <td id="displayBtn" width="10%" >
					  	<input type="button" name="search" value="查询" class="b_foot" onClick="doSearch();"/>
				    </td>
				  </tr>
			  </tbody>
		  </table>
<!--2012-8-1新增 加入批量导入工号处理的方法 gaopeng  begin--> 
		  <table id="mutiInfo" style="display:none">
			<tr>
				<td  width="9%" class="blue">
					批量工号导入
				</td>
				<td colspan="6">
					<input type="file" name="workNoList" id="workNoList" class="button"
					style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
					&nbsp;&nbsp;
					<input type="button" name="uploadFile" id="uploadFile"
					class="b_text" value="上传" onclick="uploadWorkNoList()"/>
				</td>
			</tr>
			<tr>
				<td width="9%" class="blue">
					文件格式说明
				</td>
        <td colspan="6"> 
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
<!--2012-8-1新增 加入批量导入工号处理的方法 gaopeng end-->


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
 		  
		  <table cellpadding="0">
		  	<tbody id="msg" style="display:block">
			  	<tr>
					<td>
						<div id="retmsg"></div>
					</td>
				</tr>
			  </tbody>
		  </table>

		  <table cellpadding="0">
		  		<tr><td align="center"id="footer">
		  		<input type="button" name="submit1" onClick="doSubmit()" class="b_foot" value="提交" disabled >
		  		&nbsp;
		  			<input  name="resetsd"  class="b_foot" type="button" value="清除" onclick="javascript:window.location.href='/npage/codeManage/s5517.jsp'" id="Button3">&nbsp;
				<input type="submit" onClick="removeCurrentTab();" class="b_foot" value="关闭">
				</td></tr>
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
