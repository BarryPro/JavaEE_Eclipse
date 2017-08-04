
<%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
		String opCode=request.getParameter("opCode");	
		String opName=request.getParameter("opName");

	String workno = (String)session.getAttribute("workNo");
	String regioncode=(String)session.getAttribute("regCode");
	String orgcode = (String)session.getAttribute("orgCode");
  String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  String regionCode= (String)session.getAttribute("regCode");


%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"
	routerValue="<%=regioncode%>" id="sysAccept" />

<HTML>
<HEAD>
<TITLE><%=opName%></TITLE>
<script
	src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"
	type="text/javascript"></script>

<script language="JavaScript">
    var quanjusum=0;
    
    function doCommit()
	{				
		if(document.all.uploadFile.value.length<1)
		{
			rdShowMessageDialog("数据文件错误，请重新选择数据文件！");
			document.all.uploadFile.focus();
			return false;
		}

		var formFile=document.all.uploadFile.value.lastIndexOf(".");
		var beginNum=Number(formFile)+1;
		var endNum=document.all.uploadFile.value.length;
		formFile=document.all.uploadFile.value.substring(beginNum,endNum);
		formFile=formFile.toLowerCase(); 
        if(formFile!="txt")
        {
        	rdShowMessageDialog("上传文件格式只能是txt，请重新选择数据文件！");
			document.document.all.uploadFile.focus();
			return false;
        }
		document.all.quchoose.disabled=true;
		document.form1.action="fm399Upload.jsp?opCode=<%=opCode%>&opName=<%=opName%>&yewuType="+$("input[type=radio][name=yewuType]:checked").val();
      	document.form1.submit();
	      
	}

	function doclear()
	{
	        window.location.href = "m399.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
	</script>
</HEAD>
<BODY>
	<FORM action="" method=post name="form1" ENCTYPE="multipart/form-data">
		<%@ include file="/npage/include/header.jsp"%>
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<input type="hidden" name="opCode" value="<%=opCode%>"> <input
			type="hidden" name="opName" value="<%=opName%>"> <input
			type="hidden" name="loginAccept" id="loginAccept"
			value="<%=sysAccept%>">
		<table>
			<tr>
				<td class='blue'>业务类型</td>
				<td colspan="3">
				<input type="radio" name="yewuType" value="g073" checked="checked"/>停机保号(g073)
				<input type="radio" name="yewuType" value="1215"/>复机(1215)
				</td>
			</tr>
			<tr>
				<td>数据文件</td>
				<td><input type="file" name="uploadFile"> <font
					color="#FF0000">*</font></td>
			</tr>
			<tr>
				<td colspan="4">说明：<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<font color="red">此次批量导入字段：业务流水</font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<font color="red">数据文件为TXT文件</font><br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">一次最大允许导入500个</font><br />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如： <br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;11223344 <br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;33445566 <br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;44556677 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;55667788 </td>
			</tr>
		</table>

		<table cellspacing="0">
			<tbody>
				<tr>
					<td id="footer"><input name="quchoose" id="quchoose" class="b_foot" type=button value=提交 onclick="doCommit()">&nbsp; 
					<input name="clear" class="b_foot" type=reset value=清除 onclick="doclear()"> &nbsp;</td>
				</tr>
			</tbody>
		</table>

		<div id="squerys"></div>
		<div id="squerys1"></div>
		<%@ include file="/npage/include/footer.jsp"%>
	</FORM>
</BODY>
</HTML>