<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/********************
 version v2.0
 ������ si-tech
 create hejwa 2012-12-19 14:10:56
********************/
%>

<%
		String opCode = "g365";
    String opName = "������¼��ѯ";
    
	String regionCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String currDate = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	
	String workNoIn   = request.getParameter("workNoIn")==null?"":(request.getParameter("workNoIn")).trim();
	String funccodeIn = request.getParameter("funccodeIn")==null?"":(request.getParameter("funccodeIn")).trim();
	String optype     = request.getParameter("optype")==null?"":(request.getParameter("optype")).trim();
	String selDate    = request.getParameter("selDate")==null?"":(request.getParameter("selDate")).trim();
	String ordername  = request.getParameter("ordername")==null?"":(request.getParameter("ordername")).trim();
	String ordertype  = request.getParameter("ordertype")==null?"":(request.getParameter("ordertype")).trim();

	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
%> 
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>
$(document).ready(function(){
	$("#workNoIn").val("<%=workNoIn%>");
	$("#funccodeIn").val("<%=funccodeIn%>");
	$("#optype").val("<%=optype%>");
	$("#selDate").val("<%=selDate%>");
	$("#ordername").val("<%=ordername%>");
	$("#ordertype").val("<%=ordertype%>");
	//senfe("dataTab","#fff","#ccc","#cfc","#f00"); 
	if($("#workNoIn").val()==""){
		$("#workNoIn").val("<%=workNo%>");
	}
	$("#workNoIn").focus();
	$("#pageNumDiv").find("select").width("40px");
});
		function reSetThis(){
			location = location;	
		}
 
		function queryBut(){
			if($("#workNoIn").val().trim()==""){
				$("#workNoIn").val("");
				$("#workNoIn").focus();
				rdShowMessageDialog("�������ѯ����");
				return;
			}
				document.all.prodCfm.action="oprInfoQryMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				document.all.prodCfm.submit();
		}
function checkFuncCode(){
	if($("#funccodeIn").val().trim()=="") return ;
	var checkFuncCodePacket = new AJAXPacket("<%=request.getContextPath()%>/npage/tempConf/ajaxCheckFuncCode.jsp","����ִ��,���Ժ�...");	
		checkFuncCodePacket.data.add("funccode",$("#funccodeIn").val().trim());
		core.ajax.sendPacket(checkFuncCodePacket,doCheckFuncCode);
		checkFuncCodePacket = null; 
}
function doCheckFuncCode(packet){
	var countOpcode = packet.data.findValueByName("countOpcode"); 
	if(countOpcode=="0"){
		rdShowMessageDialog("�������������������������",0);
		$("#funccodeIn").val("");
		$("#funccodeIn").focus();
	}
}		 

function deleteSel(){
	if(rdShowConfirmDialog('ȷ��ɾ��ѡ�м�¼��')!=1) return;
	var idArrays = "";
	$("input[type='checkbox']:checked").each(function(){
		if(typeof($(this).attr("id"))!="undefined"){
			idArrays += $(this).attr("id")+"~";
		}
	});
	if(idArrays==""){
		rdShowMessageDialog("��ѡ��Ҫɾ���ļ�¼");
		return;
	}
	var packet = new AJAXPacket("ajaxDeleteSel.jsp","����ִ��,���Ժ�...");	
		packet.data.add("idArrays",idArrays);
		core.ajax.sendPacket(packet,doDeleteSel);
		packet = null; 
}
function doDeleteSel(packet){
	var retcode = packet.data.findValueByName("code"); 
	if(retcode=="000000"){
		rdShowMessageDialog("�����ɹ�",2);
		queryBut();
	}else{
		rdShowMessageDialog("����ʧ��",0);
	}
}		
function selTabChekbox(bt){
	var b = $(bt).attr("checked");
	if(typeof(b)=="undefined") b = false;
	$(bt).parent().parent().parent().find("input[type='checkbox']").attr("checked",b);
}
function setOrdertype(bt){
	if($(bt).val()==""){
		$("#ordertype").val("");
	}else{
		$("#ordertype").val("asc");
	}
}
function checkThisWorkNo(){
	if($("#workNoIn").val().trim()==""){
		return;
	}
	var packet = new AJAXPacket("checkThisWorkNo.jsp","����ִ��,���Ժ�...");	
		packet.data.add("workNoIn",$("#workNoIn").val());
		core.ajax.sendPacket(packet,doCheckThisWorkNo);
		packet = null; 
}
function doCheckThisWorkNo(packet){
	var msg = packet.data.findValueByName("msg"); 
	if(msg!=""){
		$("#workNoIn").val("");
		$("#workNoIn").focus();
		rdShowMessageDialog(msg);
		return;
	}
}
function senfe(o,a,b,c,d){ 
	var t=document.getElementById(o).getElementsByTagName("tr"); 
	for(var i=0;i<t.length;i++){ 
			var oldColo = this.style.backgroundColor;
			t[i].onmouseover=function(){ 
				if(this.x!="1")this.style.backgroundColor=c; 
				} 
			t[i].onmouseout=function(){ 
				if(this.x!="1")
				this.style.backgroundColor=oldColo; 
			} 
	} 
} 
function checkOrderName(bt){
	if($("#ordername").val()==""){
		rdShowMessageDialog("����ѡ����������");
		$(bt).val("");
		return;
	}
}
	</SCRIPT>
</HEAD>	
<BODY>
<FORM name="prodCfm" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">������¼��ѯ</div></div>
<TABLE cellSpacing=0>
	<tr>
		<td class="blue">����</td>
		<td><input type="text" name="workNoIn" id="workNoIn" maxlength="6" value="" onkeyup="ng35_autoChgFocus(this,6,'funccodeIn')"  onblur="checkThisWorkNo()"/> </td>
				<td class="blue">��������</td>
		<td><input type="text" name="funccodeIn" id="funccodeIn" value=""  maxlength="6"	onblur="checkFuncCode()"  onkeyup="ng35_autoChgFocus(this,4,'optype')"/> </td>
	</tr>
	<tr>
		<td class="blue">��������</td>
		<td>
				<select name="optype" id="optype"> 
					<option value="">--��ѡ��--</option>
					<option value="0">��ѯ</option>
					<option value="1">����</option>
					<option value="2">�޸�</option>
					<option value="3">ɾ��</option>
				</select>
		</td>
		<td class="blue">����</td>
		<td  ><input type="text" id="selDate" name="selDate"   readOnly onclick="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true,onpicked:function(){}})" /></td>
	</tr>
	
	
	<tr>
		<td class="blue">�����ֶ�</td>
		<td>
				<select name="ordername" id="ordername" onchange="setOrdertype(this)"> 
					<option value="">--��ѡ��--</option>
					<option value="work_no">����</option>
					<option value="opr_date">��������</option>
					<option value="opr_funccode">��������</option>
					<option value="opr_type">��������</option>
				</select>
		</td>
		<td class="blue">��������</td>
		<td>
			<select name="ordertype" id="ordertype"  onchange="checkOrderName(this)"> 
					<option value="">--��ѡ��--</option>
					<option value="asc">����</option>
					<option value="desc">����</option>
				</select>
		</td>
	</tr>
	
</table>
<div id="showReDiv"></div>
<TABLE cellSpacing=0>
	 <tr>
	 	<td id="footer">
	 		<input type="button" value="��ѯ" class="b_foot" onclick="queryBut()">
	 		<INPUT class="b_foot" onclick="reSetThis()" type="button" value="����" /> 
	 		<INPUT class="b_foot" onclick="deleteSel()" type="button" value="ɾ��" /> 
			<INPUT class="b_foot" onclick="removeCurrentTab()" type="button" value="�ر�" /> 
	 	</td>
	</tr>
</table>

<%

String tableName = "dng35_opr_record"+currDate;
String selsql = "select work_no,work_name,phone_no,decode(opr_type,0,'��ѯ',1,'����',2,'�޸�',3,'ɾ��'),opr_ip,opr_funccode,to_char(opr_date,'yyyy-MM-DD HH24:MI:SS'),opr_recode ,to_char((to_number(opr_end_long)-to_number(opr_begin_long))/1000000,'0D99') ,recode_id"+
								"  ,rownum id  from "+tableName+" where 1=1";
String countSql = "select count(*) "+" from "+tableName+" where 1=1";
String sqlParam = "";

if(!workNoIn.equals("")){
	selsql   += " and work_no=:work_no";
	countSql   += " and work_no=:work_no";
	sqlParam += ",work_no="+workNoIn;
}			
if(!funccodeIn.equals("")){
	selsql += " and opr_funccode=:funccodeIn";
	countSql += " and opr_funccode=:funccodeIn";
	sqlParam += ",funccodeIn="+funccodeIn;
}							
if(!optype.equals("")){
	selsql += " and opr_type=:optype";
	countSql += " and opr_type=:optype";
	sqlParam += ",optype="+optype;
}
if(!selDate.equals("")){
	selsql += " and opr_date between to_date(:beDate,'yyyy-MM-DD HH24:MI:SS') and to_date(:enDate,'yyyy-MM-DD HH24:MI:SS')";
	countSql += " and opr_date between to_date(:beDate,'yyyy-MM-DD HH24:MI:SS') and to_date(:enDate,'yyyy-MM-DD HH24:MI:SS')";
	sqlParam += ",beDate="+selDate+" 00:00:00";
	sqlParam += ",enDate="+selDate+" 23:59:59";
}

if(!ordername.equals("")){
	selsql += " order by "+ordername;
}
if(!ordertype.equals("")){
	selsql += "  "+ordertype;
}
String pageSql = "select * from (select at.*,rownum as idd  from ( "+selsql+" )  at )where idd <"+iEndPos+" and idd>="+iStartPos;

%>
  <wtc:service name="TlsPubSelCrm" outnum="11" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=countSql%>" />
		<wtc:param value="<%=sqlParam%>" />	
	</wtc:service>
	<wtc:array id="result_t1" scope="end" />

  <wtc:service name="TlsPubSelCrm" outnum="11" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=pageSql%>" />
		<wtc:param value="<%=sqlParam%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end" />
				
<div class="title"><div id="title_zi">ģ���б�</div></div>
<TABLE cellSpacing="0" id="dataTab"  vColorTr="set">
	<tr>
		<th width="2%"><input type="checkbox" onclick="selTabChekbox(this)" id=""></th>
		<th width="7%">����</th>
		<th width="9%">����</th>
		<th width="12%">�ֻ�����</th>
		<th width="7%">��������</th>	
		<th width="10%">IP��ַ</th>	
		<th width="7%">��������</th>	
		<th width="18%">����ʱ��</th>	
		<th width="8%">����ʱ��</th>	
		<th>��������</th>	
	</tr>
<%
String trCss="even";
for(int i=0;i<result_t.length;i++){
if(i%2==1) trCss="even"; else trCss="";
%>
<tr class="<%=trCss%>" >
		<td class="blue"><input type="checkbox" id="<%=result_t[i][9]%>"></td>
		<td class="blue"><%=result_t[i][0]%></td>
		<td class="blue"><%=result_t[i][1]%></td>	
		<td class="blue"><%=result_t[i][2]%></td>	
		<td class="blue"><%=result_t[i][3]%></td>	
		<td class="blue"><%=result_t[i][4]%></td>	
		<td class="blue"><%=result_t[i][5]%></td>	
		<td class="blue"><%=result_t[i][6]%></td>	
		<td class="blue"><%if("".equals(result_t[i][8])) out.print("δ֪"); else out.print(result_t[i][8]+"��");%></td>
		<td class="blue"><%=result_t[i][7]%></td>	
	</tr>

<%	
}
%>		
</table>

<%	
	int iQuantity = Integer.parseInt(result_t1[0][0].trim());
    //int iQuantity = 500;
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
		PageView view = new PageView(request,out,pg); 
%>
		<div id="pageNumDiv" style="position:relative;font-size:12px" align="center">
<%
    view.setVisible(true,true,0,0);      
%>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>