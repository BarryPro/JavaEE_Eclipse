<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年10月25日
　 * 作者: leimd
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = WtcUtil.repNull(request.getParameter("pageOpCode"));	
	String opName = WtcUtil.repNull(request.getParameter("pageOpName"));	
	String operType = WtcUtil.repNull(request.getParameter("operType")); //操作类型
	String productID = WtcUtil.repNull(request.getParameter("productID"));//产品订单编号
	String orderSource = WtcUtil.repNull(request.getParameter("orderSource"));//订单来源编号
	String orderSourceName = WtcUtil.repNull(request.getParameter("orderSourceName"));//订单来源名称
	String productSpecNum = WtcUtil.repNull(request.getParameter("productSpecNum"));
	String id_no = request.getParameter("grpIdNo");
	String workName = (String)session.getAttribute("workName");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	/*zhangyan 2011-5-12 18:55:22
	sql_cntSpec 根据产品订单编号查配置表,检查能否用文件上传
	*/

	String sqlStr2 = "select count(*) from sbbossmembercharacter where productspec_number = '"+productSpecNum+"' and substr(character_attr_code,1,1)='1'";
	
	//根据操作类型取操作名称
	String operTypeName = "";
	switch(Integer.parseInt(operType)){
	  	case 0 : 
	  					operTypeName = "删除";
	  					break;
	  	case 2 :
	  					operTypeName = "变更成员类型";
	  					break;
	  	case 3 :
	  					operTypeName = "暂停成员";
	  					break;
	  	case 4 :
	  					operTypeName = "恢复成员";
	  					break;
	  	default:
	  					operTypeName = "";
	  					break;
	 }
%>



<!--zhangyan 2011-5-12 14:52:16 b
查产品配置SQL,为是否展示文件上传选择按钮做准备
-->


<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sqlStr2%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result2" scope="end"/>
	
<!--zhangyan 2011-5-12 14:52:16 e-->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>成员签约关系管理</title>
</head>
<script type="text/javascript">
function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");			
	if(retType=="getbizcode")
    {
    	if(retCode="000000")
    	{	
			var flag_1001 = packet.data.findValueByName("flag_1001");
			var flag_1002 = packet.data.findValueByName("flag_1002");
			var biz_code = packet.data.findValueByName("biz_code");
			document.all.flag_1001.value = flag_1001;
			document.all.flag_1002.value = flag_1002;
			document.all.biz_code.value = biz_code;	
    	}
    	else
    	{		    	
    		rdShowMessageDialog(retMessage);
    	}
    }
}		 
   
function getbizcode()
{
    var getbizcode_Packet = new AJAXPacket("f2035_ajax.jsp","正在获取业务代码，请稍候......");
	getbizcode_Packet.data.add("retType","getbizcode");
    getbizcode_Packet.data.add("id_no","<%=id_no%>");
    getbizcode_Packet.data.add("region_code","<%=regionCode%>");
	core.ajax.sendPacket(getbizcode_Packet);
	getbizcode_Packet=null;
	//delete(getbizcode_Packet);
	var proSpecNum="<%=productSpecNum%>";
	var operTYpe = document.frm.operType.value;
	if (operTYpe=="0")
	{
		$("#input_type").css("display","block");
		
		if (proSpecNum=="33101" || proSpecNum == "411506")
		{
				$("#input_type_file").css("display","block");
		}
	}
		
}	

/*zhangyan 2011-5-12 19:02:56
点击号码添加时
*/
function chkMeb()
{
	$("#memberNo_file").css("display","none");
	$("#memberNo_text").css("display","block");
	$("#mebNo_info").css("display","none");
	document.getElementById("fileflag").value="0";
}

/*zhangyan 2011-5-12 19:02:56
点击文件录入时
*/
function chkMebFile()
{
	$("#memberNo_file").css("display","block");
    $("#memberNo_text").css("display","none");
    $("#mebNo_info").css("display","block");
    document.getElementById("fileflag").value="1";
}
	
/*zhangyan 2011-5-12 19:04:25
文件提交
*/
function doFileCfm()
{
	document.frm.target="_self";
	document.frm.encoding="application/x-www-form-urlencoded";
	document.frm.action="f2035_cfm2.jsp";
	frm.method="post";
	frm.submit();
	loading();
}
	
function doCfm()
{
	var areaVal = document.all.phoneNo.value;
	var file_flag = document.frm.fileflag.value;
	if(areaVal=="" && file_flag !=1)
	{
		 rdShowMessageDialog("手机号码不能为空!");
		 return ;
	}
	if(areaVal.charAt(areaVal.length-1)!="|" && file_flag !=1)
	{
		rdShowMessageDialog("手机号码填写错误!");	
		return;
	}
    else
    {
    	var confirmFlag=0;
		confirmFlag = rdShowConfirmDialog("是否提交本次操作？");
		if (confirmFlag==1 && file_flag!="1") 
		{
			document.frm.action="f2035_cfm2.jsp";
			document.getElementById("doSubmit").disabled=true;
			document.frm.submit();
		}
		else if (confirmFlag==1 )
		{
			/*zhangyan add 2011-5-12 8:52:00
			文件上传时要求成员无属性
			*/
			if (  <%=result2[0][0]%>!="0" )
			{
				rdShowMessageDialog("要进行文件添加,成员属性必须为空!");
				return false;
			}
			document.frm.target="hidden_frame";
			document.frm.encoding="multipart/form-data";
			document.frm.action="f2035_upload.jsp";
			document.frm.method="post";
			document.getElementById("doSubmit").disabled=true;
			document.frm.submit();
			loading();	
			/*zhangyan add 2011-5-12 8:52:00 e*/
		}
	}
}

</script>


<body onload="getbizcode();">
	<form method="post" name="frm" >
		<input type="hidden" name="pageOpCode" value="<%=opCode%>">
		<input type="hidden" name="pageOpName" value="<%=opName%>">
		<input type="hidden" name="addmodeflag"  value="0"> 
		<input type="hidden" name="flag_1001" value="">
		<input type="hidden" name="flag_1002" value="">
		<input type="hidden" name="biz_code" value="">	
		<input type="hidden" name="fileflag" value="">
		<input type="hidden" name="memberType" value="">
		<input type="hidden" id = "inputFile" name="inputFile" value="">
		<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>	
	<%@ include file="/npage/include/header.jsp" %>
		<table cellspacing="0">
			<tr id= "input_type" name = "input_type" style = "display:none">
				<td class="blue">号码录入方式</td>
				<td colspan="3">
					<input type='radio' id='memberNo_type' name='memberNo_type' 
						onClick='chkMeb()' value='memberNo_type' checked/>号码输入 &nbsp;&nbsp;
	           	 	<div id="input_type_file" style="display:none">
	           	 	<input type='radio' id='memberNo_type' name='memberNo_type' 
	           	 		onClick='chkMebFile()' value='memberNo_type' />文件录入
	           	 	</div>
           	 	</td>
			</tr>
			<tr>
				<td class="blue">操作类型</td>
				<td colspan="3"><input name="operTypeName" value="<%=operTypeName%>" class="InputGrey" readonly></td>
				                <input name="operType" value="<%=operType%>" type="hidden"> 
			</tr>
			<tr>
				<td class="blue">产品订单编号</td>
				<td><input name="productIDName"    value="<%=productID%>" class="InputGrey" readonly></td>
				    <input name="productID"   value="<%=productID%>" type="hidden">
				<td class="blue">订单来源</td>
				<td>
					<input name="orderSourceName" value="<%=orderSourceName%>" class="InputGrey" readonly>
					<input name="orderSource" value="<%=orderSource%>" type="hidden"> 	
				</td>
			</tr>
			<%if(Integer.parseInt(operType) == 2){%>
                <tr>
                    <td class="blue">成员类型</td>
                    <td colspan="3">
                     	<select name="memberType">
	              			<option value="1" >签约成员</option>	
	              			<option value="2" >白名单</option>
	              			<option value="0" >黑名单</option>
          				</select>
          			</td>
                </tr>
            <%}%>
            
			<tr id = "memberNo_text" name  =  "memberNo_text" >
				<td class="blue">手机号码</td>
				<td>
					<textarea cols=30 rows=8 name="phoneNo" style="overflow:auto" v_must=1 v_minlength="11" v_maxlength="15" v_type="string" index="8"></textarea>
				<td colspan="2">注：批量增加手机号码时,请用"|"作为分隔<br>
								&nbsp;&nbsp;&nbsp;&nbsp;符,并且最后一个号码也请用"|"作为结束.<br>
								&nbsp;&nbsp;&nbsp;&nbsp;例如：13900000000|<br>
								&nbsp;&nbsp;&nbsp;&nbsp;13900000001|<br>
				</td>
			</tr>
			<tr id = "memberNo_file" name = "memberNo_file" style = "display:none">
				<td colspan =4 >

	 				<input type="file" id="memberNoFile"  name="memberNoFile" class="button" 
	 					style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;display:block'/>			
	 				<font class='orange' id = 'mebNo_info' name = 'mebNo_info' style = 'display:block'>
	 					文件说明:上传文件格式必须为文本文件,一个号码一行,每次最多50号码。
	 				</font>
	 			</td>		
			</tr>			
			<tr>
				<td class="blue">备注</td>
				<td colspan="3">
					<input name="opNote" size="60" value="操作员<%=workName%>进行<%=operTypeName%>操作" readonly Class="InputGrey">
				</td>
			</tr>
			<tr>
				<td align="center" id="footer" colspan="4">
					<input class="b_foot" name="doSubmit"  type=button value="确认" onclick="doCfm()">
					<input class="b_foot" name="reset1"  onClick="" type=reset value="清除">
					<input class="b_foot" name=next id=nextoper1 type=button value="返回" onclick="history.go(-1)" >
					<input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="关闭">
				</td>
			</tr>
		</table>
	<%@ include file="/npage/include/footer.jsp" %>
	</form>
</body>
</html>
