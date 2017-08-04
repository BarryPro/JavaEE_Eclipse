<%
/********************
 version v2.0
 开发商 si-tech
 create hejwa 2012-11-30 11:01:52
********************/
%>
              
<%
		String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String recodeIDd = request.getParameter("recodeIDd");
    String regionCode = (String)session.getAttribute("regCode");
    
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
	String workNo = (String)session.getAttribute("workNo");
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
	<SCRIPT language=JavaScript>
		function reSetThis(){
			location = location;	
		}
<%if(!"".equals(recodeIDd)){%>
	parent.parent.oprInfoRecode('','','','',"<%=recodeIDd%>");
<%}%>
function addtemplate(){
	var path = "addtemplate.jsp?opCode=<%=opCode%>";
	var retInfo = window.open(path,"","dialogWidth:65px;dialogHeight:40;");	
}
function getList(){
	$("#recodeIDd").val(parent.parent.oprInfoRecode('','0','<%=opCode%>','查询操作模板列表'));
	getList1();
}
function getList1(){
	  if($("#funccodes").val()=="请输入操作代码"){
	  	$("#funccode").val("");
	  }else{
	  	$("#funccode").val($("#funccodes").val());
	  }
	  
	  if($("#elNames").val()=="快捷键 Alt+5"){
	  	$("#elName").val("");
	  }else{
	  	$("#elName").val($("#elNames").val());
	  }
	  
		document.all.prodCfm.action="tempConfMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		document.all.prodCfm.submit();
}
function updThis(templateId){
	var path = "updtemplate.jsp?opCode=<%=opCode%>&templateId="+templateId;
	var retInfo = window.open(path,"","dialogWidth:65px;dialogHeight:40;");	
}
function delThis(templateId){
	if(rdShowConfirmDialog('确认删除权限记录吗？')!=1) return;
	$("#recodeIDd").val(parent.parent.oprInfoRecode('','3','<%=opCode%>','删除操作模板ID为：'+templateId));
	var deletePacket = new AJAXPacket("ajaxDelete.jsp","正在执行,请稍后...");	
		deletePacket.data.add("templateId",templateId);
		core.ajax.sendPacket(deletePacket,doDel);
		deletePacket = null; 
}
function doDel(packet){
	var code = packet.data.findValueByName("code"); 
	parent.parent.oprInfoRecode('','','','',$("#recodeIDd").val());
	$("#recodeIDd").val("");
	if(code="000000"){
		rdShowMessageDialog("删除成功",2);
		getList();
	}else{
		rdShowMessageDialog("删除失败",0);
	}
}

function setThisInput(bt,oldText){
	if($(bt).val()==oldText){
		$(bt).val("");
		$(bt).attr("style","");
	}else{
		var inText = $(bt).val().trim();
		if(inText==""){
			$(bt).val(oldText);
			$(bt).attr("style","color:gray");
		}
	}
}

$(document).bind("keydown",function(){
	//alt +5 取焦点
	 var oEvent = window.event;
	 //alert("oEvent.keyCode|"+oEvent.keyCode);
   if (oEvent.keyCode == 53 && oEvent.altKey) {
      $("#elNames").focus();
   }
});
	</SCRIPT>
	
</HEAD>	
<BODY>
<FORM name="prodCfm" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">订单查询</div></div>
<TABLE cellSpacing=0>
	<tr>
		<td class="blue">操作代码</td>
		<td><input type="text" name="funccodes"   style="color:gray"  id="funccodes" /> 
			<input type="hidden" name="funccode"  id="funccode"/>
			</td>
		
				<td class="blue">字段名称</td>
		<td><input type="text" name="elNames"    style="color:gray"  id="elNames" value="快捷键 Alt+5"  onfocus="setThisInput(this,'快捷键 Alt+5')"   onblur="setThisInput(this,'快捷键 Alt+5')" /> 
			<input type="hidden" name="elName"  id="elName"/>
			</td>
	</tr>
 	
</table>
<div id="showReDiv"></div>
<TABLE cellSpacing=0>
	 <tr>
	 	<td id="footer">
	 		<input type="button" value="查询" class="b_foot" onclick="getList()" />
	 		<INPUT class="b_foot" onclick="addtemplate()" type="button" value="新增模板" /> 
			<INPUT class="b_foot" onclick="removeCurrentTab()" type="button" value="关闭" /> 
	 	</td>
	</tr>
</table>
<%

String funccode = request.getParameter("funccode")==null?"":(request.getParameter("funccode")).trim();
String elName = request.getParameter("elName")==null?"":(request.getParameter("elName")).trim();


String selsql = "select templateid,conf_funccode,conf_key_name,conf_key,conf_value,to_char(cre_date,'yyyy-MM-DD HH24:MI:SS')"+
								" from dng35_Template_conf where work_no=:work_no";
String sqlParam = "work_no="+workNo;								
if(!funccode.equals("")){
	selsql   += " and conf_funccode=:funccode";
	sqlParam += ",funccode="+funccode;
}			
if(!elName.equals("")){
	selsql += " and conf_key_name like '%'||:elName||'%'";
	sqlParam += ",elName="+elName;
}			
selsql += " order by conf_funccode";				
%>
  <wtc:service name="TlsPubSelCrm" outnum="7" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=selsql%>" />
		<wtc:param value="<%=sqlParam%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end" />
		
<div class="title"><div id="title_zi">模板列表</div></div>
<TABLE cellSpacing=0 vColorTr="set">
	<tr>
		<th>操作代码</th>
		<th>字段名称</th>
		<th>字段ID或NAME</th>
		<th>模板内容</th>	
		<th>创建时间</th>	
		<th width="15%">操作</th>	
	</tr>
<%
String trCss = "";
for(int i=0;i<result_t.length;i++){
if(i%2==1)  trCss="even"; else trCss = "";
%>
<tr class="<%=trCss%>" >
		<td class="blue"><%=result_t[i][1]%></td>
		<td class="blue"><%=result_t[i][2]%></td>	
		<td class="blue"><%=result_t[i][3]%></td>	
		<td class="blue"><%=result_t[i][4]%></td>	
		<td class="blue"><%=result_t[i][5]%></td>	
		<td class="blue">
			<input type="button" value="修改" class="b_text" onclick="updThis('<%=result_t[i][0]%>')" />
			<input type="button" value="删除" class="b_text" onclick="delThis('<%=result_t[i][0]%>')" />
		</td>	
	</tr>

<%	
}
%>		
</table>
<%@ include file="/npage/include/footer.jsp" %>
<input type="hidden" name="recodeIDd" id="recodeIDd"  value=""/>
</FORM>
</BODY>
</HTML>