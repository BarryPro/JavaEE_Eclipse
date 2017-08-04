<%
  /*
   * 功能: 导入特殊名单页面
　 * 版本: 1.0.0
　 * 日期: 2009/10/29
　 * 作者: yinzx
　 * 版权: sitech
   * update:
　 */
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%!
public static boolean isNumeric(String str){ 
  for (int i = str.length();--i>=0;){   
   if (!Character.isDigit(str.charAt(i))){ 
    return false; 
   } 
  } 
  return true; 
} 
%> 
<% 
  String kf_longin_no = (String) (session.getAttribute("kfWorkNo")==null?"":session.getAttribute("kfWorkNo"));
	String opCode = "K197";
	String opName = "批量导入特殊名单";
	String StrSql="";
	List sqlList=new ArrayList();
  String[] sqlArr = new String[]{};
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import= "java.util.*"%> 

<%@ page import= "java.io.*"%> 
<%@ page import= "java.text.*"%> 
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import= "org.apache.poi.hssf.usermodel.*"%>
<%@ page import= "org.apache.poi.poifs.filesystem.*"%> 
<%@ page import= "org.apache.commons.fileupload.*"%>
<%!
/*---------------获得页面传递参数开始-------------------*/

 public String getCell(HSSFCell cell){
		
		String result = "";
		
		if(cell==null)
			return result;
		
		
		if(cell.getCellType()==1){
			
			result = cell.getStringCellValue();
		}else if(cell.getCellType()==0){
            result = new Double((double)cell.getNumericCellValue()).toString();
		}	
		if (result ==null)
			result="";
		return result.replaceAll("'", "''").replaceAll("\n", "");
		
	}
%>
<%	
	
//iniFlag 1:代表有文件数据提交后的页面
String iniFlag =  request.getParameter("iniFlag") ;
String selectedItemId = request.getParameter("selectedItemId") ;
StringBuffer tmpBufferSaveVal = new StringBuffer();
String tmpSaveVal = "";
/*---------------获得页面传递参数结束-------------------*/
//result 0:发送成功 1：不成功
String result = "0";
String addColumnValue=""; 
 
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2); 
String[] addvalxnew= new String[]{};

if("1".equals(iniFlag)){
	  int maxSize = 100;
		String uploadSum = "";
		String successSum = "";
	  
	  String filename = "";
	  String sSaveName="";
	  String srvIP=request.getServerName();
	  String iErrorNo ="";
	  String sErrorMessage = "";
	  String[][] returnInfo = new String[][]{};
 
	    
	  SmartUpload mySmartUpload = new SmartUpload();
	  
	  mySmartUpload.initialize(pageContext);
	  mySmartUpload.setMaxFileSize(500 * 1024*1024);
	  mySmartUpload.upload();
	  com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
	  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	  String dateTime = sdf.format(new java.util.Date());
	  filename = myFile.getFileName().substring(0,myFile.getFileName().length()-4)+dateTime+myFile.getFileName().substring(myFile.getFileName().length()-4,myFile.getFileName().length());
 
	 
	  
	  sSaveName=request.getRealPath("/npage/callbosspage/K197/file")+"/"+filename;
	  
	  if(!myFile.isMissing()){
	     myFile.saveAs(sSaveName);
	  }else{
%>
	   <script language="javascript" >
	   	    rdShowMessageDialog("文件上传失败!");
	   	    window.replace("k197_loadPage2.jsp");
	   </script>     
<%	
    }
    String InputStr = "";
    String temStr = "";
    int validFlag = 0;
 
		    BufferedReader br = new BufferedReader(new FileReader(sSaveName));
		    while ((temStr = br.readLine()) != null) {
						if (!temStr.trim().equals("")) { // 不是空行
						  addvalxnew=temStr.split("[|]",-1); 
						  StrSql=" insert into dcallspeciallist (specialid,accept_phone,cust_name,specialtype_id,begin_date,end_date,sq_login_no,op_login_no,reason) values ( to_char(sysdate,'yyyymmddhh24miss')|| :v1 ,:v2,:v3,:v4,to_date(:v5,'yyyymmdd hh24:mi:ss'),to_date(:v6,'yyyymmdd hh24:mi:ss'),:v7,:v8,:v9 )";
							  addColumnValue = "&&"+kf_longin_no+validFlag;
							
							for (int x=0; x<addvalxnew.length ;x++)
							{
							  addColumnValue+="^"+addvalxnew[x];
							}
							 
						  sqlList.add(StrSql+addColumnValue);     	
     			    sqlArr = (String[])sqlList.toArray(new String[0]);
						}
						validFlag++;
						if(validFlag>maxSize){
						    break;
						}
				}
				if(validFlag>maxSize){
%>
						   <script language="javascript" >
						   	    rdShowMessageDialog("操作失败:最多支持上传<%=maxSize%>行!");
						   	    history.go(-1);   
						   </script>     
<%
			  } 
			  
			   
     			
     			%>
						<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
						    <wtc:param value=""/>
						    <wtc:param value="dbchange"/>
						    <wtc:params value="<%=sqlArr%>"/>
						</wtc:service>
						<wtc:array id="rows" scope="end" />
					<%
					  if(retCode.equals("000000"))
					  {
					     %>	<script> rdShowMessageDialog("导入特殊名单数据成功！") ;</script> <%
					  }else
					  {
					     %>	<script> rdShowMessageDialog("导入特殊名单数据失败！"); </script>	<%
					  }
 
}
%>

	
	
<html>
<head>
<title>批量导入特殊名单</title>

<%
	 
	Random ran = new Random();
  String _K197validFlag = ran.nextInt(100000)+"";
	 
%>
<meta http-equiv=Content-Type content="text/html; charset=GBK">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

<script>


/**
  *
  *
  */
function submitLoad(){
	 

	var fileName = document.formbar.uploadFile.value;
	  if(fileName.length<1){
	  	  rdShowMessageDialog("请选择要上传的文件!");
	  	  return false;
	  }

	  if(fileName.indexOf(".txt")==-1){
	  	  rdShowMessageDialog("上传文件格式要求为.txt!");
	  	  return false;
	  }
	  	  
 
	formbar.action="<%=request.getContextPath()%>/npage/callbosspage/K197/k197_loadPage.jsp?iniFlag=1";
	formbar.submit();
}

 

function ifSaveData(){

		var iFlag = '<%=iniFlag%>';
		if("1" == iFlag){
			document.getElementById('submit2').disabled=true;
			 
		}
}
</script>

</head>
<body onload=ifSaveData()>

<form  name="formbar" method="post" enctype="multipart/form-data">
<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B>上传数据文件</B></div>
    <div id="Operation_Table" style="width:100%;">
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    	<tr>
      	<td width=16% class="blue">请选择文件</td>
      </tr>
      <tr>
        <td width="34%"> 
        <input type="file" size="50"  name="uploadFile" id="uploadFile" />
        <div id="showAttachmentDiv" 
			style="white-space:normal; word-break:break-all; position: static; width: 80%;" >&nbsp;</div>
			
        <!--input class="b_text" name="submit1" type="button"  onclick="submitLoad();" value="导入" /-->
        </td>    
      </tr>
          
      
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
      	<tr bgcolor="EEEEEE"> 
                  <td>
                     <br>
                      说明：<br>
                      &nbsp;&nbsp; 上传文件文本格式如下： <br>
                    &nbsp;&nbsp;&nbsp;&nbsp; 手机号码|客户姓名|名单类型|开始时间（YYYYMMDD）|结束时间（YYYYMMDD）|申请人|操作人|加入原因<br>
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;例如：
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp; 13500925125|XXX|1|20091102|20101202|kf1002|kf1002|该客户集团拨测，请注意语言规范<br>
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp; 13500926697|XXX|5|20091102|20101202|kf1002|kf1002|该客户集团拨测，请注意语言规范<br>
                    <br>&nbsp;&nbsp;&nbsp;&nbsp; 5&nbsp;黑名单&nbsp;6&nbsp;白名单&nbsp;1&nbsp;红名单<br>
                    <br>&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;蓝名单&nbsp;3&nbsp;黄名单&nbsp;4	&nbsp;绿名单<br>

                      <br>
                     &nbsp;&nbsp; <b>格式中的每一项均不允许存在|，且项与项之间必须以|为间隔符。</b> 
                      &nbsp;&nbsp; <b>文件数据不允许超过100条。</b> 
                    </td>
         </tr>
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_foot" id="submit2" name="submit2" type="button" value="确认" onclick="submitLoad();">
       		<input class="b_foot" name="reset1" type="button"  onclick="document.forms(0).reset();" value="清除">
       		<input class="b_foot" name="back" type="button" onclick="window.close();" value="关闭"  >
        </td>
       </tr>  
     </table>
    </div>
    <br/>          
    </td>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
  </tr>
        
  <tr>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
    <td valign="bottom">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
      <tr>
        <td height="1"></td>
      </tr>
    </table>
    </td>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
  </tr>
</table>

</div>

</form>
<script>

</script>
</body>
</html>
 
 

