<%
  /*
   * 功能: 实现文件上传并完成 diff 操作。
   * 版本: 1.0
   * 日期: 
   * 作者: 
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.jspsmart.upload.*"%>


<jsp:useBean  id="wlUpload"  scope="page"  class="com.jspsmart.upload.SmartUpload"  />  


<%
	String opCode = "e661";
	String opName = "手工系统充值审核";
	String sRetMsg = "与已上传文件不一致！";
	String document_name	= request.getParameter("document_name") ;
	String document_no		= request.getParameter("document_no");
	String DOCUMENT_ACCEPT= request.getParameter("document_accept");

	String strFileName = document_name+"-"+document_no ;
	String strFileNameDiff = document_name+"-"+document_no+".diff" ;
	String strSaveFilePath =request.getRealPath("/npage/tmp")+"/";
	String strShellPath =request.getRealPath("/npage/e660/shell")+"/";
  String sCmdStr = "sh "+strShellPath+"mydiff.sh "+strSaveFilePath+strFileName;
	SmartUpload mySmartUpload = new SmartUpload(); 
	String	iErrorNo="";
	String	sErrorMessage="";
	String	NoteStr="";
	
	
	try
	{
		mySmartUpload.initialize(pageContext);
		mySmartUpload.upload();
	}
	catch(Exception ex) 
	{
		//System.out.println("上载文件传输中出错！");
		iErrorNo = "139045";
		sErrorMessage = "上载文件传输中出错！";
	}
	try 
	{
		com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
		if (!myFile.isMissing())
		{
			myFile.saveAs(strSaveFilePath+strFileNameDiff);
    }
	}
	catch(Exception ex) 
	{
		//System.out.println("上载文件存储时出错！");
		iErrorNo = "139046";
		sErrorMessage = "上载文件存储时出错！";
	}
	
	if( false == iErrorNo.equals("000000"))
	{
%>
	<SCRIPT type=text/javascript>
		rdShowMessageDialog("文件准备失败。<br>错误代码：'<%=iErrorNo%>'。<br>错误信息：'<%=sErrorMessage%>'。",0);
		history.go(-1);
	</SCRIPT>
<%
	}
	//调用shell
	try {

System.out.println("++++++ zhaorh ==========>"+sCmdStr);		
		Process p = Runtime.getRuntime().exec(sCmdStr);
		InputStreamReader ir = new InputStreamReader(p.getInputStream());
		LineNumberReader input = new LineNumberReader(ir);

		NoteStr = input.readLine();

	} catch (IOException e) {
%>

			<SCRIPT type=text/javascript>
				rdShowMessageDialog("执行核对脚本出错!!",0);
				history.go(-1);
			</SCRIPT>
<%
	} 
%> 


<%@ include file="/npage/include/public_title_name.jsp" %>
<title>手工系统充值查询</title>
</head>
<BODY onload=""> 

<script language="JavaScript">
function do_submit( busi_flag , document_accept )
{

	document.frm.action="e662_3.jsp?document_accept="+document_accept+"&busi_flag="+busi_flag ;

	document.frm.submit();	
}
</script>

<form action="e660_3.jsp" method="post" name="frm">
		 
  
  	<%@ include file="/npage/include/header.jsp" %> 
		<div class="title">
			<div id="title_zi">文件核对信息</div>
		</div>

  <table cellspacing="0">
    <tbody> 

     <tr> 
        <td class="blue" width="15%">新上传文件核对信息：</td>
        <td width="35%"> 
 					<input readonly class="InputGrey"type="text" name="note" size="50" value="<%=NoteStr%>"  >  
				</td>

     </tr>
   </table>
   
   
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="审核通过" onclick=do_submit("B","<%=DOCUMENT_ACCEPT%>") >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="打回" onclick=do_submit("D","<%=DOCUMENT_ACCEPT%>") >
          &nbsp;
  
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="返回" onClick="history.go(-1)" >
       </td>
    </tr>
     </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
</BODY>
</HTML>	
		

