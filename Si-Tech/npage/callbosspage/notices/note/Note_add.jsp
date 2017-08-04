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
/*设置public_notice_bean这个bean是用来转发公告的.*/
if( noteBean.getId() != null){%>
<si:query name="noteBean" id="selectNoteById" type="com.sitech.crm.cmd.notices.dto.Note"
 	param="<%=noteBean%>" scope="end" />
<%}else{%>
<si:seq name="seq" id="SEQ_NOTE_ID" scope="end"  /> 
<%noteBean.setId(new Long(seq));
}
String noteAction = ( null == request.getParameter("noteAction") ? "" : request.getParameter("noteAction") );
String noticeId = ( null == request.getParameter("noticeId") ? "" : request.getParameter("noticeId") );
String tempForwardNoteId = "";//转发时候的ID用来查询clob字段.
String userId = (String)request.getSession().getAttribute("workNo");
/**设置是转发还是答复的action.*/
if("reply".equals(noteAction)){
	/*回复处理流程.*/
	%><si:seq name="seq_1" id="SEQ_NOTE_ID" scope="end"  /><%
	noteBean.setId(new Long(seq_1));/*重新生成ID.*/
	noteBean.setTitle("回复:"+noteBean.getTitle());
	noteBean.setReceiverPersons(noteBean.getSendPerson());
	noteBean.setNoteLevel("");
}else if("forward".equals(noteAction)){
	/*转发处理流程.*/
	tempForwardNoteId = noteBean.getId()+"";
	%><si:seq name="seq_2" id="SEQ_NOTE_ID" scope="end"  /><%
	noteBean.setId(new Long(seq_2));/*重新生成ID.*/
	noteBean.setTitle("转发:"+noteBean.getTitle());
	noteBean.setReceiverPersons("");
	noteBean.setNoteLevel("");
	SqlFind sqlfind = new SqlFind();
	sqlfind.addParam(new SqlParameter(SqlTypes.VARCHAR, tempForwardNoteId));
	String sql_1 = " SELECT T2.ATTACHEMENT_PATH FROM DNOTEATTACHMENT T2 WHERE T2.NOTE_ID = ? ";
	/*查询便签附件的路径.附件的路径用来拷贝文件.*/
	List list = sqlfind.findList(sql_1);
	String noteFilePathName = "";
	String noteFilePathNewName = "";/*设置一个新的文件名.防止一个便签被多个人转发.转发一次服务器文件拷贝一次,防止删除的时候将公告附件删除.*/
	if (list.size() > 0) {
		
		String[] col = (String[])list.get(0);
		//0是路径.
		noteFilePathName = col[0];
		if (noteFilePathName.lastIndexOf("/") != -1) {
			noteFilePathNewName = noteFilePathName.substring(noteFilePathName.lastIndexOf("/")+1);
		}/* 取得文件名.*/ 
		
		String webContentDir = com.sitech.crmpd.core.util.SystemUtils.getConfigByMap("Note_Upload_Dir");
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy_MM_dd");/*每天按照日期创建一个文件夹.*/
		String dateFolder = fmt.format(new Date());
		File dateFile = new File(webContentDir+"/"+dateFolder);
		if (!dateFile.isDirectory()) {
			dateFile.mkdirs();/*按天创建文件夹.*/
		}
		
		noteFilePathNewName =  dateFolder+ "/"+ System.currentTimeMillis()+"_" + noteFilePathNewName;
		/*防止新拷贝的文件夹重名.在文件夹前面添加一个随机数.*/
		
		try{
			/*将文件复制一份到便签文件夹.*/
			FileUtils.copyFile(new File(webContentDir+noteFilePathName)
				,new File(webContentDir + noteFilePathNewName));
			/*将公告拷贝到便签文件夹.同时重命名一个新的名字.防止重复.如果文件拷贝失败.抛出异常。不进行数据库插入。*/
		
			SqlChange change = new SqlChange();
			String sql_2 = " INSERT INTO DNOTEATTACHMENT ( ID , NOTE_ID, ATTACHEMENT_NAME, ATTACHEMENT_TYPE, ATTACHEMENT_PATH ) "
				+" SELECT SEQ_NOTEATTACHMENT_ID.NEXTVAL , ? , T1.ATTACHEMENT_NAME ,T1.ATTACHEMENT_TYPE, ? "
				+" FROM DNOTEATTACHMENT T1 WHERE T1.NOTE_ID = ? ";
			/*将公告的附件数据库字段挪到便签的表里面.SEQ_NOTEATTACHMENT_ID.NEXTVAL 查询下一个附件的ID.*/
			change.addParam(new SqlParameter(SqlTypes.VARCHAR, noteBean.getId()+""));
			/*插入新便签名称.*/
			change.addParam(new SqlParameter(SqlTypes.VARCHAR, noteFilePathNewName));
			/*插入便签的是新文件名字.*/
			change.addParam(new SqlParameter(SqlTypes.VARCHAR, tempForwardNoteId));/*查询便签ID*/
			change.execute(sql_2);
			System.out.println(noteFilePathNewName+"\t"+tempForwardNoteId);
		
		}catch(Exception e){
			e.printStackTrace();
			out.print("<script type=\"text/javascript\">rdShowMessageDialog(\"原附件不存在！\",1);</script>");
		}
	}
	  
}else if("forwardNotice".equals(noteAction)){
	/*转发公告处理流程.需要一个公告ID.然后将这个公告ID的标题查询出来.note自己的ID会自动创建.相当于新建一个note.*/
	SqlFind sqlfind = new SqlFind();
	sqlfind.addParam(new SqlParameter(SqlTypes.VARCHAR, noticeId));
	String sql_1 = " SELECT T2.ATTACHEMENT_PATH FROM DPUBLICNOTICE T1,DNOTICEATTACHMENT T2 WHERE T1.ID = T2.NOTICE_ID AND T1.ID = ? ";
	/*一个组合查询.同时查询出公告的标题和附件的路径.附件的路径用来拷贝文件.*/
	List list = sqlfind.findList(sql_1);
	String noticeFilePathName = "";
	String noticeFilePathNewName = "";/*设置一个新的文件名.防止一个公告被多个人转发.转发一次服务器文件拷贝一次,防止删除的时候将公告附件删除.*/
	if (list.size() > 0) {
		String[] col = (String[])list.get(0);
		noticeFilePathName = col[0];
		if (noticeFilePathName.lastIndexOf("/") != -1) {
			noticeFilePathNewName = noticeFilePathName.substring(noticeFilePathName.lastIndexOf("/")+1);
		}/* 取得文件名.*/ 
		
		String webContentDir = com.sitech.crmpd.core.util.SystemUtils.getConfigByMap("Note_Upload_Dir");
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy_MM_dd");/*每天按照日期创建一个文件夹.*/
		String dateFolder = fmt.format(new Date());
		File dateFile = new File(webContentDir+"/"+dateFolder);
		if (!dateFile.isDirectory()) {
			dateFile.mkdirs();/*按天创建文件夹.*/
		}
		
		noticeFilePathNewName = dateFolder+ "/"+ System.currentTimeMillis()+"_" + noticeFilePathNewName;
		/*防止新拷贝的文件夹重名.在文件夹前面添加一个随机数.*/
		noteBean.setReceiverPersons("");
		noteBean.setNoteLevel("");
		
		/*防止新拷贝的文件夹重名.在文件夹前面添加一个随机数.*/
		try{
			/*将文件复制一份到便签文件夹.*/
				FileUtils.copyFile(
				new File(com.sitech.crmpd.core.util.SystemUtils.getConfigByMap("Notices_Upload_Dir")+noticeFilePathName)
				,new File(com.sitech.crmpd.core.util.SystemUtils.getConfigByMap("Note_Upload_Dir")+noticeFilePathNewName));
			/*将公告拷贝到便签文件夹.同时重命名一个新的名字.防止重复.如果文件拷贝失败.抛出异常。不进行数据库插入。*/
			SqlChange change = new SqlChange();
			String sql_2 = " INSERT INTO DNOTEATTACHMENT ( ID , NOTE_ID, ATTACHEMENT_NAME, ATTACHEMENT_TYPE, ATTACHEMENT_PATH ) "
				+" SELECT SEQ_NOTEATTACHMENT_ID.NEXTVAL , ? , T1.ATTACHEMENT_NAME ,T1.ATTACHEMENT_TYPE, ? "
				+" FROM DNOTICEATTACHMENT T1 WHERE T1.NOTICE_ID = ? ";
			/*将公告的附件数据库字段挪到便签的表里面.SEQ_NOTEATTACHMENT_ID.NEXTVAL 查询下一个附件的ID.*/
			change.addParam(new SqlParameter(SqlTypes.VARCHAR, noteBean.getId()+""));
			/*插入新便签名称.*/
			change.addParam(new SqlParameter(SqlTypes.VARCHAR, noticeFilePathNewName));
			/*插入便签的是新文件名字.*/
			change.addParam(new SqlParameter(SqlTypes.VARCHAR, noticeId));/*查询公告ID*/
			change.execute(sql_2);
		
		}catch(Exception e){
			e.printStackTrace();
			out.print("<script type=\"text/javascript\">rdShowMessageDialog(\"原附件不存在！\",1);</script>");
		}
	}
	/*需要将公告的标题查询出来并添加转发两个字.*/
	sqlfind = new SqlFind();
	sqlfind.addParam(new SqlParameter(SqlTypes.VARCHAR, noticeId));
	sql_1 = " SELECT T1.TITLE FROM DPUBLICNOTICE T1 WHERE T1.ID = ? ";
	/*一个组合查询.同时查询出公告的标题和附件的路径.附件的路径用来拷贝文件.*/
	list = sqlfind.findList(sql_1);
	if (list.size() > 0) {
		String[] col = (String[])list.get(0);
		//0是id,1是附件名称,2是路径.
		noteBean.setTitle("转发:"+col[0]);
	}
}
%>

<%@page import="java.text.SimpleDateFormat"%><html><body>
<div id="Main">
	<div id="Operation_Table">
	<!-- 表单标题 Start -->
	<div class="title">
		<div id="title_zi">编辑便签</div>
	</div><!-- 表单标题 End -->
	<!-- ###########表单主体Start########### -->
	<table width=50% border="0" cellspacing="0" cellpadding="0"align="center">
<form action="Note_save_do.jsp" method="post">
<!-- ###########################表单1. START.################################ -->
		<tr>
			<td class="Blue">便签标题</td>
			<td>
			<html:text name="noteBean" property="title" style="width: 500px;"/>
			<span class="red">*</span>
			</td>
		</tr>
		<tr>
			<td class="Blue">接收人</td>
			<td>
			<html:text name="noteBean" property="receiverPersons" style="width: 400px;"/>
			<span class="red">*</span>
			<input class="b_foot_long" style="width: 102px;" type="button" onclick="chooseReceiverPersons();" value="选择联系人"/>&nbsp;
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
			<td class="Blue">接收群组</td>
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
			<td class="Blue">优先级</td>
			<td>
			<html:select name="noteBean" property="noteLevel" style="width: 240px;">
			<html:option value="1">一般</html:option>
			<html:option value="2">紧急</html:option>
			<html:option value="3" >特急</html:option>
			<html:option value="4">故障</html:option>
			</html:select>
			<span class="red">*</span>
			</td>
		</tr>
		
		<tr>
			<td class="Blue">内容</td>
			<td>
<!-- 添加fck文本编辑器。 开始####-->
<script type="text/javascript" src="../fckeditor.js"></script>
<%
FCKeditor fckEditor = new FCKeditor(request, "content","99%","240px","","","/npage/notices");
//配置文件在当前目录下。
//下面专门的FCK进行处理。
com.sitech.crm.cmd.notices.service.OracleClobService oracleClobService = 
	new com.sitech.crm.cmd.notices.service.OracleClobService();
String oracleClobStr = "";
if("forward".equals(noteAction)){//如果是转发.查询转发到ID.并将内容改变.
	oracleClobStr = "<p>&nbsp;</p><p>-----&nbsp;转发人:"+ userId +"&nbsp;&nbsp;时间:"+
	new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())+"-----&nbsp;</p>"+
	oracleClobService.getClob("DNOTE","CONTENT",tempForwardNoteId);
	
}else if("forwardNotice".equals(noteAction)){
	oracleClobStr = "<p>&nbsp;</p><p>-----&nbsp;转发人:"+ userId +"&nbsp;&nbsp;时间:"+
	new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())+"-----&nbsp;</p>"+
	oracleClobService.getClob("DPUBLICNOTICE","CONTENT",""+noticeId);
	
}else{
	oracleClobStr = oracleClobService.getClob("DNOTE","CONTENT",""+noteBean.getId());
}
//无论是插入还是更新数据的时候都,替换数据库当中的clob字段.
if(oracleClobStr != null){
	fckEditor.setValue(oracleClobStr);
}
out.println(fckEditor);//显示FCK.并非打印日志.
%>
<!-- 添加fck文本编辑器。 结束####-->
			</td>
		</tr>
		<!-- ###########################表单1的隐藏信息. START.################################ -->
			<html:hidden name="noteBean" property="id" />
			 
			<html:hidden name="noteBean" property="state"/>
			<html:hidden name="noteBean" property="createTime"/>
			<input type="hidden" name="sendPerson" value="<%=userId%>">
		<!-- ###########################表单1的隐藏信息. END.################################ -->
</form>
<!-- ###########################表单1. END.################################ -->
<!-- ###########################上传附件Form START.################################ -->
<form method="post" enctype ="multipart/form-data" >
		<tr>
			<td class="Blue">上传附件</td>
			<td>
			<div id="showAttachmentDiv" 
			style="white-space:normal; word-break:break-all; position: static; width: 80%;" >&nbsp;</div>
			<div id="showFileDiv" style="position: static;"><input type='file' name='upFile'/></div>
			<div id="showFileDiv" style="position: static;">
			<input type="hidden" name="noteId" value="<%=noteBean.getId()%>" />
			<input type="hidden" name="siUrl" value="Note_add.jsp" />
			<input type="button" class="b_foot" value="上传" onClick="formSubmit();"/>
			</div>
			</td>
		</tr>
</form>
<script language="JavaScript" type="text/JavaScript">
function formSubmit(){
	var upFile = $("input[name='upFile']");
	if(upFile.val() == ""){
		rdShowMessageDialog("请选择文件!",1)
		return;
	}else if((""+upFile.val()).indexOf(".tar.gz") > 0){
		rdShowMessageDialog("不支持.tar.gz压缩文件,请压缩成.rar或.zip格式!",1)
		return;
	}
	document.forms[1].action="<%=request.getContextPath()%>/Note_upload_file_do.jsp?noteId=<%=noteBean.getId()%>";
	document.forms[1].target="upload_frame";
	document.forms[1].submit();
	//progressbar_microsoft.gif
	$("#showAttachmentDiv").show().html('<img src="<%=request.getContextPath()%>/npage/notices/public/images/ajax-loader.gif" border="0" />');
	//显示等待图片....
	$("#id_send").attr("disabled", "true");
	$("#id_save").attr("disabled", "true");
	/*在上传的时候禁止提交.*/
}
var showAttachment = function(){
	//alert('function showAttachment.');
	$.ajax({//ajax begin
		url:'query_attachment_ajax_do.jsp?noteId=<%=noteBean.getId()%>&canDelete=true', 
		type:'get', //类型有get和post.
		dataType:'html',//有html和xml
		data:'',//要传入的值.
		success:
			function(json){//funciton begin
				//alert(json);
				$("#showAttachmentDiv").show().html(json);
				$("#showFileDiv").show().html("<input type='file' name='upFile'/>");
				//清空上传表单.
				$("#id_send").attr("disabled", "");
				$("#id_save").attr("disabled", "");
				/*在上传完成取消禁用.*/
			}//funciton end ..
		});//ajax end .
}
/*上传文件超过最大限制错误...*/
var attachmentMaxError = function(){
	rdShowMessageDialog("文件超过最大限制.",1);
	showAttachment();
}
var deleteAttachment =  function(id){
	var returnValue = rdShowConfirmDialog("确定要删除吗？");
	if (returnValue == rdConstOK) {
	$("#showAttachmentDiv").show().html('<img src="<%=request.getContextPath()%>/npage/notices/public/images/ajax-loader.gif" border="0" />');
	$.ajax({//ajax begin
		url:'delete_attachment_ajax_do.jsp?id='+id, 
		type:'get', //类型有get和post.
		dataType:'html',//有html和xml
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
	//显示等待图片....
	showAttachment();//默认加载页面的时候显示.
});
</script>
<iframe src="" name="upload_frame" height="0%" width="0%" frameborder="0" 
marginwidth="0" marginheight="0"></iframe>
<!-- ###########################上传附件Form END.################################ -->
		<tr>
			<td colspan="2" id="footer">
			<div align="center">
				<input id="id_send" class="b_foot" type="button" onclick="send();" value="发送便签"/>&nbsp;
				<input id="id_save" class="b_foot" type="button" onclick="save();" value="保存草稿"/>&nbsp;
				<input class="b_foot" type="button" value="关闭" onclick="javaScript:window.close();"/>
			</div>
			</td>
		</tr>
	</table><!-- ###########表单主体End########### -->
	</div>

<script type="text/javascript">
function checkForm(){
	var strErrorMsg = "";
	var title = $("input[name='title']");
	if(title.val() ==  ''){strErrorMsg += "便签标题不能为空!<br>";}
	var receiverPersons = $("input[name='receiverPersons']");
	if(receiverPersons.val() ==  '')
	{strErrorMsg += "接收人不能为空!<br>";}
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