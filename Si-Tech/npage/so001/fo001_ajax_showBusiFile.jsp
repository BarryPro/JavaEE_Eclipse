<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>

<%
	String list_name = request.getParameter("list_name");
	StringBuffer buffer = new StringBuffer();
	String []file=list_name.split("\\|");
	String[] file_name = new String[1];
	String source_name="";
	String save_name="";
	for(int i=0;i<file.length;i++){
    file_name=file[i].split("\\*");
    source_name=file_name[0];
    save_name=file_name[1];
    System.out.println("source_name========================"+source_name);
    System.out.println("save_name========================"+save_name);
  
%>
<div><a href="javascript:doShowOne('<%=source_name%>','<%=save_name%>')"><%=source_name%></a><input class="butDel" type="button" title="É¾³ý" onclick="deleteFile('<%=i%>')"/></div>
<%
  }
%>
<script type="text/javascript">
	function doShowOne(source_name,save_name){
		frmo001.action="fo001_busiFileInfoDown.jsp?source_name="+source_name+"&save_name="+save_name;
		frmo001.submit();
		unLoading("ajaxLoadingDiv");
	}
	
	function deleteFile(dindex)
	{
			doDeleteFile(dindex);
	}
	
	function doDeleteFile(dindex){
		var a=save_name.splice(dindex,1);
		index--;
		showFile();
	}
</script>



