<%@ page contentType="text/html;charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/notices/public/include/top.jsp"%>
<%@ page import="com.sitech.crm.cmd.notices.dto.Note"
	import="java.util.*"
	import="java.io.File"
	import="org.apache.commons.io.FileUtils"
	import="com.sitech.crmpd.core.ijdbc.sql.*"
	import="com.sitech.crmpd.core.ijdbc.*"
	import="net.fckeditor.FCKeditor"%>
<si:bean name="noteBean" type="com.sitech.crm.cmd.notices.dto.Note"  scope="end" />
<%
/*����public_notice_bean���bean������ת�������.*/
if( noteBean.getId() != null){%>
<si:query name="noteBean" id="selectNoteById" type="com.sitech.crm.cmd.notices.dto.Note"
 	param="<%=noteBean%>" scope="end" />
<%}else{%>
<si:seq name="seq" id="SEQ_NOTE_ID" scope="end"  /> 
<%noteBean.setId(new Long(seq));
}
String noteAction = ( null == request.getParameter("noteAction") ? "" : request.getParameter("noteAction") );
String noticeId = ( null == request.getParameter("noticeId") ? "" : request.getParameter("noticeId") );
String tempForwardNoteId = "";//ת��ʱ���ID������ѯclob�ֶ�.
String userId = (String)request.getSession().getAttribute("workNo");
/**������ת�����Ǵ𸴵�action.*/
if("reply".equals(noteAction)){
	/*�ظ���������.*/
	%><si:seq name="seq_1" id="SEQ_NOTE_ID" scope="end"  /><%
	noteBean.setId(new Long(seq_1));/*��������ID.*/
	noteBean.setTitle("�ظ�:"+noteBean.getTitle());
	noteBean.setReceiverPersons(noteBean.getSendPerson());
	noteBean.setNoteLevel("");
}else if("forward".equals(noteAction)){
	/*ת����������.*/
	tempForwardNoteId = noteBean.getId()+"";
	%><si:seq name="seq_2" id="SEQ_NOTE_ID" scope="end"  /><%
	noteBean.setId(new Long(seq_2));/*��������ID.*/
	noteBean.setTitle("ת��:"+noteBean.getTitle());
	noteBean.setReceiverPersons("");
	noteBean.setNoteLevel("");
	SqlFind sqlfind = new SqlFind();
	sqlfind.addParam(new SqlParameter(SqlTypes.VARCHAR, tempForwardNoteId));
	String sql_1 = " SELECT T2.ATTACHEMENT_PATH FROM DNOTEATTACHMENT T2 WHERE T2.NOTE_ID = ? ";
	/*��ѯ��ǩ������·��.������·�����������ļ�.*/
	List list = sqlfind.findList(sql_1);
	String noteFilePathName = "";
	String noteFilePathNewName = "";/*����һ���µ��ļ���.��ֹһ����ǩ�������ת��.ת��һ�η������ļ�����һ��,��ֹɾ����ʱ�򽫹��渽��ɾ��.*/
	if (list.size() > 0) {
		
		String[] col = (String[])list.get(0);
		//0��·��.
		noteFilePathName = col[0];
		if (noteFilePathName.lastIndexOf("/") != -1) {
			noteFilePathNewName = noteFilePathName.substring(noteFilePathName.lastIndexOf("/")+1);
		}/* ȡ���ļ���.*/ 
		
		String webContentDir = com.sitech.crmpd.core.util.SystemUtils.getConfigByMap("Note_Upload_Dir");
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy_MM_dd");/*ÿ�찴�����ڴ���һ���ļ���.*/
		String dateFolder = fmt.format(new Date());
		File dateFile = new File(webContentDir+"/"+dateFolder);
		if (!dateFile.isDirectory()) {
			dateFile.mkdirs();/*���촴���ļ���.*/
		}
		
		noteFilePathNewName =  dateFolder+ "/"+ System.currentTimeMillis()+"_" + noteFilePathNewName;
		/*��ֹ�¿������ļ�������.���ļ���ǰ�����һ�������.*/
		
		try{
			/*���ļ�����һ�ݵ���ǩ�ļ���.*/
			FileUtils.copyFile(new File(webContentDir+noteFilePathName)
				,new File(webContentDir + noteFilePathNewName));
			/*�����濽������ǩ�ļ���.ͬʱ������һ���µ�����.��ֹ�ظ�.����ļ�����ʧ��.�׳��쳣�����������ݿ���롣*/
		
			SqlChange change = new SqlChange();
			String sql_2 = " INSERT INTO DNOTEATTACHMENT ( ID , NOTE_ID, ATTACHEMENT_NAME, ATTACHEMENT_TYPE, ATTACHEMENT_PATH ) "
				+" SELECT SEQ_NOTEATTACHMENT_ID.NEXTVAL , ? , T1.ATTACHEMENT_NAME ,T1.ATTACHEMENT_TYPE, ? "
				+" FROM DNOTEATTACHMENT T1 WHERE T1.NOTE_ID = ? ";
			/*������ĸ������ݿ��ֶ�Ų����ǩ�ı�����.SEQ_NOTEATTACHMENT_ID.NEXTVAL ��ѯ��һ��������ID.*/
			change.addParam(new SqlParameter(SqlTypes.VARCHAR, noteBean.getId()+""));
			/*�����±�ǩ����.*/
			change.addParam(new SqlParameter(SqlTypes.VARCHAR, noteFilePathNewName));
			/*�����ǩ�������ļ�����.*/
			change.addParam(new SqlParameter(SqlTypes.VARCHAR, tempForwardNoteId));/*��ѯ��ǩID*/
			change.execute(sql_2);
			System.out.println(noteFilePathNewName+"\t"+tempForwardNoteId);
		
		}catch(Exception e){
			e.printStackTrace();
			out.print("<script type=\"text/javascript\">rdShowMessageDialog(\"ԭ���������ڣ�\",1);</script>");
		}
	}
	  
}else if("forwardNotice".equals(noteAction)){
	/*ת�����洦������.��Ҫһ������ID.Ȼ���������ID�ı����ѯ����.note�Լ���ID���Զ�����.�൱���½�һ��note.*/
	SqlFind sqlfind = new SqlFind();
	sqlfind.addParam(new SqlParameter(SqlTypes.VARCHAR, noticeId));
	String sql_1 = " SELECT T2.ATTACHEMENT_PATH FROM DPUBLICNOTICE T1,DNOTICEATTACHMENT T2 WHERE T1.ID = T2.NOTICE_ID AND T1.ID = ? ";
	/*һ����ϲ�ѯ.ͬʱ��ѯ������ı���͸�����·��.������·�����������ļ�.*/
	List list = sqlfind.findList(sql_1);
	String noticeFilePathName = "";
	String noticeFilePathNewName = "";/*����һ���µ��ļ���.��ֹһ�����汻�����ת��.ת��һ�η������ļ�����һ��,��ֹɾ����ʱ�򽫹��渽��ɾ��.*/
	if (list.size() > 0) {
		String[] col = (String[])list.get(0);
		noticeFilePathName = col[0];
		if (noticeFilePathName.lastIndexOf("/") != -1) {
			noticeFilePathNewName = noticeFilePathName.substring(noticeFilePathName.lastIndexOf("/")+1);
		}/* ȡ���ļ���.*/ 
		
		String webContentDir = com.sitech.crmpd.core.util.SystemUtils.getConfigByMap("Note_Upload_Dir");
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy_MM_dd");/*ÿ�찴�����ڴ���һ���ļ���.*/
		String dateFolder = fmt.format(new Date());
		File dateFile = new File(webContentDir+"/"+dateFolder);
		if (!dateFile.isDirectory()) {
			dateFile.mkdirs();/*���촴���ļ���.*/
		}
		
		noticeFilePathNewName = dateFolder+ "/"+ System.currentTimeMillis()+"_" + noticeFilePathNewName;
		/*��ֹ�¿������ļ�������.���ļ���ǰ�����һ�������.*/
		noteBean.setReceiverPersons("");
		noteBean.setNoteLevel("");
		
		/*��ֹ�¿������ļ�������.���ļ���ǰ�����һ�������.*/
		try{
			/*���ļ�����һ�ݵ���ǩ�ļ���.*/
				FileUtils.copyFile(
				new File(com.sitech.crmpd.core.util.SystemUtils.getConfigByMap("Notices_Upload_Dir")+noticeFilePathName)
				,new File(com.sitech.crmpd.core.util.SystemUtils.getConfigByMap("Note_Upload_Dir")+noticeFilePathNewName));
			/*�����濽������ǩ�ļ���.ͬʱ������һ���µ�����.��ֹ�ظ�.����ļ�����ʧ��.�׳��쳣�����������ݿ���롣*/
			SqlChange change = new SqlChange();
			String sql_2 = " INSERT INTO DNOTEATTACHMENT ( ID , NOTE_ID, ATTACHEMENT_NAME, ATTACHEMENT_TYPE, ATTACHEMENT_PATH ) "
				+" SELECT SEQ_NOTEATTACHMENT_ID.NEXTVAL , ? , T1.ATTACHEMENT_NAME ,T1.ATTACHEMENT_TYPE, ? "
				+" FROM DNOTICEATTACHMENT T1 WHERE T1.NOTICE_ID = ? ";
			/*������ĸ������ݿ��ֶ�Ų����ǩ�ı�����.SEQ_NOTEATTACHMENT_ID.NEXTVAL ��ѯ��һ��������ID.*/
			change.addParam(new SqlParameter(SqlTypes.VARCHAR, noteBean.getId()+""));
			/*�����±�ǩ����.*/
			change.addParam(new SqlParameter(SqlTypes.VARCHAR, noticeFilePathNewName));
			/*�����ǩ�������ļ�����.*/
			change.addParam(new SqlParameter(SqlTypes.VARCHAR, noticeId));/*��ѯ����ID*/
			change.execute(sql_2);
		
		}catch(Exception e){
			e.printStackTrace();
			out.print("<script type=\"text/javascript\">rdShowMessageDialog(\"ԭ���������ڣ�\",1);</script>");
		}
	}
	/*��Ҫ������ı����ѯ���������ת��������.*/
	sqlfind = new SqlFind();
	sqlfind.addParam(new SqlParameter(SqlTypes.VARCHAR, noticeId));
	sql_1 = " SELECT T1.TITLE FROM DPUBLICNOTICE T1 WHERE T1.ID = ? ";
	/*һ����ϲ�ѯ.ͬʱ��ѯ������ı���͸�����·��.������·�����������ļ�.*/
	list = sqlfind.findList(sql_1);
	if (list.size() > 0) {
		String[] col = (String[])list.get(0);
		//0��id,1�Ǹ�������,2��·��.
		noteBean.setTitle("ת��:"+col[0]);
	}
}
%>

<%@page import="java.text.SimpleDateFormat"%><html><body>
<div id="Main">
	<div id="Operation_Table">
	<!-- ������ Start -->
	<div class="title">
		<div id="title_zi">�༭��ǩ</div>
	</div><!-- ������ End -->
	<!-- ###########������Start########### -->
	<table width=50% border="0" cellspacing="0" cellpadding="0"align="center">
<form action="Note_save_do.jsp" method="post">
<!-- ###########################��1. START.################################ -->
		<tr>
			<td class="Blue">��ǩ����</td>
			<td>
			<html:text name="noteBean" property="title" style="width: 500px;"/>
			<span class="red">*</span>
			</td>
		</tr>
		<tr>
			<td class="Blue">������</td>
			<td>
			<html:text name="noteBean" property="receiverPersons" style="width: 400px;"/>
			<span class="red">*</span>
			<input class="b_foot_long" style="width: 102px;" type="button" onclick="chooseReceiverPersons();" value="ѡ����ϵ��"/>&nbsp;
			<script language="javascript">
				function chooseReceiverPersons(){
					//alert(selObj.text);
					var width = 650,height = 600;
					sysWindowOpen('../notice_contacts/DNoticeContacts_choose_list.jsp?userId=<%=userId%>','width='+width+'px,height='
							+height+'px,top='+((screen.availHeight-width)/2)
							+',left= '+((screen.availWidth-height)/2)+',');
					//window.location.href=url;//for test.
				}
				</script>
			</td>
		</tr>
		<!-- <tr>
			<td class="Blue">����Ⱥ��</td>
			<td>
			<div style="white-space:normal; word-break:break-all; overflow: scroll; position: relative; width: 99%; height: 90px;" >
			<%
			{SqlFind sqlfind = new SqlFind();
			//sqlfind.addParam(new SqlParameter(SqlTypes.VARCHAR, "1"));
			String sql = " SELECT  T.CLASS_ID , T.CLASS_NAME FROM SCALLCLASS T ORDER BY TO_NUMBER(T.CLASS_ID)  ";
			List listnoteTypes = sqlfind.findList(sql);
			String[] checkList = null;
			if(noteBean.getReceiverGroups() != null){
				checkList = noteBean.getReceiverGroups().split(",");}
			else{
				checkList = new String[]{};
			}
			for(int i = 0; i < listnoteTypes.size(); i ++){
				
				String[] col = (String[]) listnoteTypes.get(i);
				boolean isChecked = false;
				for( int j = 0; j < checkList.length; j ++){
					if(checkList[j].trim().equals(col[0])){
						isChecked = true;
						break;
					}
				}
				%>
				<input type="checkbox" name="receiverGroups" value="<%= col[0]%>" 
				<%if(isChecked){%>checked="checked" <%}%> ><%= col[1]%>
				<%
				if( ( i + 1 ) % 8 == 0){out.println("<br>");}
				}
			}%></div>
			<span class="red">*</span>
			</td>
		</tr> -->
		
		<tr>
			<td class="Blue">���ȼ�</td>
			<td>
			<html:select name="noteBean" property="noteLevel" style="width: 240px;">
			<html:option value="1">һ��</html:option>
			<html:option value="2">����</html:option>
			<html:option value="3" >�ؼ�</html:option>
			<html:option value="4">����</html:option>
			</html:select>
			<span class="red">*</span>
			</td>
		</tr>
		
		<tr>
			<td class="Blue">����</td>
			<td>
<!-- ���fck�ı��༭���� ��ʼ####-->
<script type="text/javascript" src="../fckeditor.js"></script>
<%
FCKeditor fckEditor = new FCKeditor(request, "content","99%","240px","","","/npage/notices");
//�����ļ��ڵ�ǰĿ¼�¡�
//����ר�ŵ�FCK���д���
com.sitech.crm.cmd.notices.service.OracleClobService oracleClobService = 
	new com.sitech.crm.cmd.notices.service.OracleClobService();
String oracleClobStr = "";
if("forward".equals(noteAction)){//�����ת��.��ѯת����ID.�������ݸı�.
	oracleClobStr = "<p>&nbsp;</p><p>-----&nbsp;ת����:"+ userId +"&nbsp;&nbsp;ʱ��:"+
	new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())+"-----&nbsp;</p>"+
	oracleClobService.getClob("DNOTE","CONTENT",tempForwardNoteId);
	
}else if("forwardNotice".equals(noteAction)){
	oracleClobStr = "<p>&nbsp;</p><p>-----&nbsp;ת����:"+ userId +"&nbsp;&nbsp;ʱ��:"+
	new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())+"-----&nbsp;</p>"+
	oracleClobService.getClob("DPUBLICNOTICE","CONTENT",""+noticeId);
	
}else{
	oracleClobStr = oracleClobService.getClob("DNOTE","CONTENT",""+noteBean.getId());
}
//�����ǲ��뻹�Ǹ������ݵ�ʱ��,�滻���ݿ⵱�е�clob�ֶ�.
if(oracleClobStr != null){
	fckEditor.setValue(oracleClobStr);
}
out.println(fckEditor);//��ʾFCK.���Ǵ�ӡ��־.
%>
<!-- ���fck�ı��༭���� ����####-->
			</td>
		</tr>
		<!-- ###########################��1��������Ϣ. START.################################ -->
			<html:hidden name="noteBean" property="id" />
			 
			<html:hidden name="noteBean" property="state"/>
			<html:hidden name="noteBean" property="createTime"/>
			<input type="hidden" name="sendPerson" value="<%=userId%>">
		<!-- ###########################��1��������Ϣ. END.################################ -->
</form>
<!-- ###########################��1. END.################################ -->
<!-- ###########################�ϴ�����Form START.################################ -->
<form method="post" enctype ="multipart/form-data" >
		<tr>
			<td class="Blue">�ϴ�����</td>
			<td>
			<div id="showAttachmentDiv" 
			style="white-space:normal; word-break:break-all; position: static; width: 80%;" >&nbsp;</div>
			<div id="showFileDiv" style="position: static;"><input type='file' name='upFile'/></div>
			<div id="showFileDiv" style="position: static;">
			<input type="hidden" name="noteId" value="<%=noteBean.getId()%>" />
			<input type="hidden" name="siUrl" value="Note_add.jsp" />
			<input type="button" class="b_foot" value="�ϴ�" onClick="formSubmit();"/>
			</div>
			</td>
		</tr>
</form>
<script language="JavaScript" type="text/JavaScript">
function formSubmit(){
	var upFile = $("input[name='upFile']");
	if(upFile.val() == ""){
		rdShowMessageDialog("��ѡ���ļ�!",1)
		return;
	}else if((""+upFile.val()).indexOf(".tar.gz") > 0){
		rdShowMessageDialog("��֧��.tar.gzѹ���ļ�,��ѹ����.rar��.zip��ʽ!",1)
		return;
	}
	document.forms[1].action="<%=request.getContextPath()%>/Note_upload_file_do.jsp?noteId=<%=noteBean.getId()%>";
	document.forms[1].target="upload_frame";
	document.forms[1].submit();
	//progressbar_microsoft.gif
	$("#showAttachmentDiv").show().html('<img src="<%=request.getContextPath()%>/npage/notices/public/images/ajax-loader.gif" border="0" />');
	//��ʾ�ȴ�ͼƬ....
	$("#id_send").attr("disabled", "true");
	$("#id_save").attr("disabled", "true");
	/*���ϴ���ʱ���ֹ�ύ.*/
}
var showAttachment = function(){
	//alert('function showAttachment.');
	$.ajax({//ajax begin
		url:'query_attachment_ajax_do.jsp?noteId=<%=noteBean.getId()%>&canDelete=true', 
		type:'get', //������get��post.
		dataType:'html',//��html��xml
		data:'',//Ҫ�����ֵ.
		success:
			function(json){//funciton begin
				//alert(json);
				$("#showAttachmentDiv").show().html(json);
				$("#showFileDiv").show().html("<input type='file' name='upFile'/>");
				//����ϴ���.
				$("#id_send").attr("disabled", "");
				$("#id_save").attr("disabled", "");
				/*���ϴ����ȡ������.*/
			}//funciton end ..
		});//ajax end .
}
/*�ϴ��ļ�����������ƴ���...*/
var attachmentMaxError = function(){
	rdShowMessageDialog("�ļ������������.",1);
	showAttachment();
}
var deleteAttachment =  function(id){
	var returnValue = rdShowConfirmDialog("ȷ��Ҫɾ����");
	if (returnValue == rdConstOK) {
	$("#showAttachmentDiv").show().html('<img src="<%=request.getContextPath()%>/npage/notices/public/images/ajax-loader.gif" border="0" />');
	$.ajax({//ajax begin
		url:'delete_attachment_ajax_do.jsp?id='+id, 
		type:'get', //������get��post.
		dataType:'html',//��html��xml
		success:
			function(json){//funciton begin
				//alert();
				showAttachment();
			}//funciton end ..
		});//ajax end .
	}
}
$(document).ready(function(){
	$("#showAttachmentDiv").show().html('<img src="<%=request.getContextPath()%>/npage/notices/public/images/ajax-loader.gif" border="0" />');
	//��ʾ�ȴ�ͼƬ....
	showAttachment();//Ĭ�ϼ���ҳ���ʱ����ʾ.
});
</script>
<iframe src="" name="upload_frame" height="0%" width="0%" frameborder="0" 
marginwidth="0" marginheight="0"></iframe>
<!-- ###########################�ϴ�����Form END.################################ -->
		<tr>
			<td colspan="2" id="footer">
			<div align="center">
				<input id="id_send" class="b_foot" type="button" onclick="send();" value="���ͱ�ǩ"/>&nbsp;
				<input id="id_save" class="b_foot" type="button" onclick="save();" value="����ݸ�"/>&nbsp;
				<input class="b_foot" type="button" value="�ر�" onclick="javaScript:window.close();"/>
			</div>
			</td>
		</tr>
	</table><!-- ###########������End########### -->
	</div>

<script type="text/javascript">
function checkForm(){
	var strErrorMsg = "";
	var title = $("input[name='title']");
	if(title.val() ==  ''){strErrorMsg += "��ǩ���ⲻ��Ϊ��!<br>";}
	var receiverPersons = $("input[name='receiverPersons']");
	if(receiverPersons.val() ==  '')
	{strErrorMsg += "�����˲���Ϊ��!<br>";}
	return strErrorMsg;
}
function send(){
	var strErrorMsg = checkForm();
	if(strErrorMsg != ''){rdShowMessageDialog(strErrorMsg,1);return;}
    document.forms[0].action="Note_send_do.jsp";
    $("#id_save").attr("disabled", "true");
    $("#id_send").attr("disabled", "");
	document.forms[0].submit();
}
function save(){
	var strErrorMsg = checkForm();
	if(strErrorMsg != ''){rdShowMessageDialog(strErrorMsg,1);return;}
    document.forms[0].action="Note_save_do.jsp";
    $("#id_save").attr("disabled", "true");
    $("#id_send").attr("disabled", "");
	document.forms[0].submit();
}
</script></div>
</body></html>