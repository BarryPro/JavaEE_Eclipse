<%
/********************
 version v2.0
 开发商 si-tech
 create hejwa 2010-6-23 
********************/
%>
              
<%
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
	String regionCode = (String)session.getAttribute("regCode");
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>
$(document).ready(function(){
 	$("select").width("150");
	$("input[type='text']").width("150");
});
function addPermi(){
	var path = "addPermi.jsp?opCode=<%=opCode%>";
	var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:40;");	
}
function apnConfig(){
	var path = "apnConfig.jsp";
	var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:40;");	
}

function getPermi(){
	document.all.prodCfm.action="g3opPermiMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	document.all.prodCfm.submit();
} 
function del(simNo,loginNo,phoneNo,apnCode){
      if(rdShowConfirmDialog('确认删除权限记录吗？')!=1) return;
	var permiPacket = new AJAXPacket("delPermiCfm.jsp","正在执行,请稍后...");
		permiPacket.data.add("simno",simNo);
		permiPacket.data.add("loginNo",loginNo);
		permiPacket.data.add("phoneNo",phoneNo);
		permiPacket.data.add("apnCode",apnCode);
		permiPacket.data.add("opCode","<%=opCode%>");
		core.ajax.sendPacket(permiPacket,doDel);
		permiPacket = null; 
}
function doDel(packet){
	var code = packet.data.findValueByName("code"); 
	var msg = packet.data.findValueByName("msg"); 
	if(code=="000000"){
		rdShowMessageDialog("删除成功",2);
		getPermi();
	}else{
		rdShowMessageDialog("操作失败"+code+"："+msg,0);
	}
}
function upd(simNo,loginNo,status,bdate,edate){
	var path = "updPermi.jsp?simNo="+simNo+"&loginNo="+loginNo+"&status="+status+"&bdate="+bdate+"&edate="+edate;
	var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:40;");	
}

function getSimNo(){
	if($("#phoneno").val().trim()=="") return ;
	
	var getSimNaPacket = new AJAXPacket("ajaxGetSimNo.jsp","正在执行,请稍后...");	
		getSimNaPacket.data.add("phoneno",$("#phoneno").val().trim());
		core.ajax.sendPacket(getSimNaPacket,doGetSimNo);
		getSimNaPacket = null; 
}
function doGetSimNo(packet){
	var simNo = packet.data.findValueByName("simNo"); 
	if(simNo!=""){
		$("#simno").val(simNo);
	}else{
		rdShowMessageDialog("没有查到sim卡号，请重新输入",0);
		$("#phoneno").val("");
		$("#simno").val("");
	}
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="prodCfm" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
	<input type="hidden" name="opCode" value=<%=opCode%>>
	<input type="hidden" name="opName" value=<%=opName%>>
<div class="title"><div id="title_zi"><%=opName%></div></div>
<TABLE cellSpacing=0>
	<tr>
		<td class="blue">手机号码</td>
		<td class="blue"><input type="text" id="phoneno" name="phoneno" maxLength="11" >
			</td>
		 <td class="blue" width="25%">&nbsp;</td>
		 <td width="25%">&nbsp;</td>
	</tr>
	 
	<tr>
		 <td class="blue">状态</td>
		 <td>
		 	<select id="status" name="status">
		 		<option value="">--请选择--</option>
		 		<option value="0">正常</option>
		 		<option value="1">挂失</option>
		 	</select>
		 </td>
		 
		  <td class="blue" width="25%">工号</td>
		 <td width="25%"><input type="text" id="loginNo" name="loginNo"></td>
	</tr>
</table>

<div class="title"><div id="title_zi">权限列表</div></div>
<TABLE cellSpacing=0>
	<tr>
		<th>SIM卡号</th>
		<th>IMEI号</th>
		<th>手机号</th>
		<th>工号</th>	
		<th>状态</th>	
		<th>开始时间</th>	
		<th>结束时间</th>	
		<th>创建时间</th>	
		<th>操作</th>	
	</tr>
<%
String phoneno = request.getParameter("phoneno")==null?"":(request.getParameter("phoneno")).trim();
String loginNo = request.getParameter("loginNo")==null?"":(request.getParameter("loginNo")).trim();
String status = request.getParameter("status")==null?"":(request.getParameter("status")).trim();

/**
String querySql = "select SIMNO, "+
			         ""+
			         " LOGINNO, "+
			         " decode(loginstat, 0, '正常', 1, '挂失'), "+
			         " c.GROUP_ID, "+
			         " to_char(PERMI_BEGINDATE, 'yyyy-mm-dd HH:mi:ss'), "+
			         " to_char(permi_enddate, 'yyyy-mm-dd HH:mi:ss'), "+
			         " to_char(createdate, 'yyyy-mm-dd HH:mi:ss'), "+
			         " to_char(updatedate, 'yyyy-mm-dd HH:mi:ss') ,"+
			         "  b.phone_no from dg3op_permi c,dcustsim a, dcustmsg b where  a.id_no = b.id_no and trim(c.simno)=trim(a.SWITCH_NO) and ";
if(!phoneno.equals("")){
	querySql += " b.phone_no ='"+phoneno+"' and ";
}
if(!loginNo.equals("")){
	querySql += " c.LOGINNO='"+loginNo+"' and ";
}
if(!status.equals("")){
	querySql += " c.LOGINSTAT='"+status+"' and ";
}
querySql +=" 1=1";

*/

String querySql = 
" select f.SIMNO,																"+
"        f.LOGINNO,                                                             "+
"        decode(f.loginstat, 0, '正常', 1, '挂失'),                             "+
"        f.GROUP_ID,                                                            "+
"        to_char(f.PERMI_BEGINDATE, 'yyyy-mm-dd HH:mi:ss'),                     "+
"        to_char(f.permi_enddate, 'yyyy-mm-dd HH:mi:ss'),                       "+
"        to_char(f.createdate, 'yyyy-mm-dd HH:mi:ss'),                          "+
"        to_char(f.updatedate, 'yyyy-mm-dd HH:mi:ss'),                          "+
"        e.phone_no   ,f.imeiNo,f.apncode                                                          "+
"   from (select b.phone_no, a.switch_no                                        "+
"           from dcustsim a, dcustmsg b                                         "+
"          where a.id_no = b.id_no                                              "+
"            and a.SWITCH_NO in (select simno from dg3op_permi)) e,             "+
"        dg3op_permi f                                                          "+
"  where e.switch_no = f.simno      and                                            ";

if(!phoneno.equals("")){
	querySql += " e.phone_no ='"+phoneno+"' and ";
}
if(!loginNo.equals("")){
	querySql += " f.LOGINNO='"+loginNo+"' and ";
}
if(!status.equals("")){
	querySql += " f.LOGINSTAT='"+status+"' and ";
}
querySql +=" 1=1";
System.out.println(querySql);
%>	
	<wtc:pubselect name="sPubSelect" outnum="11" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=querySql%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_t" scope="end"/>
<%
System.out.println("--------------result_t.length-------------"+result_t.length);
for(int i=0;i<result_t.length;i++){
%>
<tr>
		<td class="blue"><%=result_t[i][0]%></td>
		<td class="blue"><%=result_t[i][9]%></td>	
		<td class="blue"><%=result_t[i][8]%></td>	
		<td class="blue"><%=result_t[i][1]%></td>	
		<td class="blue"><%=result_t[i][2]%></td>	
		<td class="blue"><%=result_t[i][4]%></td>	
		<td class="blue"><%=result_t[i][5]%></td>	
		<td class="blue"><%=result_t[i][6]%></td>	
		<td class="blue">
			<input type="button" value="修改" class="b_text" onclick="upd('<%=result_t[i][0]%>','<%=result_t[i][1]%>','<%=result_t[i][2]%>','<%=result_t[i][4]%>','<%=result_t[i][5]%>')">
			<input type="button" value="删除" class="b_text" onclick="del('<%=result_t[i][0]%>','<%=result_t[i][1]%>','<%=result_t[i][8]%>','<%=result_t[i][10]%>')">
		</td>	
	</tr>

<%	
}
%>		
</table>
<TABLE cellSpacing=0>
	 <tr>
	 	<td id="footer">
	 		<input type="button" value="查询" class="b_foot" onclick="getPermi()">
	 		<input type="button" value="新增" class="b_foot" onclick="addPermi()">
	 		<!--input type="button" value="APN配置" class="b_foot" onclick="apnConfig()" -->
			<INPUT class=b_foot onclick="removeCurrentTab()" type=button value=关闭> 
	 	</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>