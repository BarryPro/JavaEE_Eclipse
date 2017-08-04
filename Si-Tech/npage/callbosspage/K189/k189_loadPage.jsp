<%
  /*
   * 功能: 导入咨询语音页面
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
	String opCode = "K189";
	String opName = "批量咨询语音数据";
	String strSql="";
	String strFrame="";
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
 
	 
	  
	  sSaveName=request.getRealPath("/npage/callbosspage/K189/file")+"/"+filename;
	  
	  if(!myFile.isMissing()){
	     myFile.saveAs(sSaveName);
	  }else{
%>
	   <script language="javascript" >
	   	    rdShowMessageDialog("文件上传失败!");
	   	    window.replace("k189_loadPage.jsp");
	   </script>     
<%	
    }
    String InputStr = "";
    String temStr = "";
    int validFlag = 0;
    String gerAccesscode = null;
							String gercitycode = null;
							String gerdigitcode = null;
							String gerServicename = null;
							String gerTransfercode = null;
						  String gerMessegecontent = null;
						  String gerTypeid = null;
						  String gerVisiable = null;
 
		    BufferedReader br = new BufferedReader(new FileReader(sSaveName));
		    while ((temStr = br.readLine()) != null) {
						if (!temStr.trim().equals("")) { // 不是空行
						  addvalxnew=temStr.split("[|]",-1); 
			 
			         gerAccesscode=   addvalxnew[0];            
               gercitycode=     addvalxnew[1];         
               gerdigitcode=    addvalxnew[2];             
               gerServicename=  addvalxnew[3];             
               gerTransfercode= addvalxnew[4];             
               gerMessegecontent= addvalxnew[5];           
               gerTypeid=        addvalxnew[6];            
               gerVisiable= addvalxnew[7];  
               
		/**strSql=" INSERT INTO DZXSCETRANSFERTAB  ";
		strSql+="select  "+gerAccesscode+"||'"+gercitycode+"'||user_class_id||'"+gerdigitcode+"',substr("+gerAccesscode+"||'"+gercitycode+"'||user_class_id||'"+gerdigitcode+"',0,length("+gerAccesscode+"||'"+gercitycode+"'||user_class_id||'"+gerdigitcode+"')-1), ";
		strSql+="  "+gerAccesscode+" ,'"+gercitycode+"',  user_class_id  ,'" +gerServicename+"','"+gerdigitcode+"',"+gerTransfercode+",'"+gerMessegecontent+"',"+gerTypeid+",'','','', " +gerVisiable;
		strSql+=" FROM DUAL ,SCALLGRADECODE B  ";
		
		strSql=" INSERT INTO DZXSCETRANSFERTAB  ";
		strSql+="select  '"+gerAccesscode+"'||'"+gercitycode+"'||user_class_id||'"+gerdigitcode+"',substr('"+gerAccesscode+"'||'"+gercitycode+"'||user_class_id||'"+gerdigitcode+"',0,length('"+gerAccesscode+"'||'"+gercitycode+"'||user_class_id||'"+gerdigitcode+"')-1), ";
		strSql+="  '"+gerAccesscode+"' , '"+gercitycode+"',  user_class_id  ,'"+gerServicename+"','"+gerdigitcode+"','"+gerTransfercode+"','"+gerMessegecontent+"','"+gerTypeid+"','','','', '"+gerVisiable+"'";
		strSql+=" FROM DUAL ,SCALLGRADECODE B  "; 
     	*/
    strSql=" INSERT INTO DZXSCETRANSFERTAB  ";
		strSql+="select   :v1|| :v2||user_class_id|| :v3,substr( :v4|| :v5||user_class_id|| :v6,0,length( :v7|| :v8||user_class_id|| :v9)-1), ";
		strSql+="  :v10 ,  :v11,  user_class_id  , :v12, :v13, :v14, :v15, :v16, '', '', '',  :v17";
		strSql+=" FROM DUAL ,SCALLGRADECODE B  "; 
		strSql+="&&"+gerAccesscode+"^"+gercitycode+"^"+gerdigitcode+"^"+gerAccesscode+"^"+gercitycode+"^"+gerdigitcode+"^"+gerAccesscode+"^"+gercitycode+"^"+gerdigitcode+"^"+gerAccesscode+"^"+gercitycode+"^"+gerServicename+"^"+gerdigitcode+"^"+gerTransfercode+"^"+gerMessegecontent+"^"+gerTypeid+"^"+gerVisiable; 
		
		
		/**
		strFrame="insert into DZXSCETRANSFERDETAIL ";
		strFrame+= "select distinct  FRAMEID,'"+gerdigitcode+"','"+gerTransfercode+"','"+gerMessegecontent+"',"+gerTypeid+",'" +gerServicename+"','','0','','','','1','" +gerServicename+"',  " +gerVisiable+",sysdate ,sysdate + 365*1000,'','' from dsceconsulttype where CITYCODE= '"+gercitycode+"' and accesscode='10086' ";
		
		strFrame="insert into DZXSCETRANSFERDETAIL ";
		strFrame+= "select distinct  FRAMEID,'"+gerdigitcode+"','"+gerTransfercode+"','"+gerMessegecontent+"','"+gerTypeid+"','"+gerServicename+"','','0','','','','1','"+gerServicename+"','"+gerVisiable+"',sysdate ,sysdate + 365*1000,'','' from dsceconsulttype where CITYCODE= '"+gercitycode+"' and accesscode='10086' ";
		*/
		strFrame="insert into DZXSCETRANSFERDETAIL ";
		strFrame+= "select distinct  FRAMEID, :v1, :v2, :v3, :v4, :v5,'','0','','','','1', :v6, :v7,sysdate ,sysdate + 365*1000,'','' from dsceconsulttype where CITYCODE=  :v8 and accesscode='10086' ";
		strFrame+="&&"+gerdigitcode+"^"+gerTransfercode+"^"+gerMessegecontent+"^"+gerTypeid+"^"+gerServicename+"^"+gerServicename+"^"+gerVisiable+"^"+gercitycode;
						 
					 
		sqlList.add(strSql+addColumnValue); 
		sqlList.add(strFrame+addColumnValue);     	
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
					     %>	<script> rdShowMessageDialog("导入咨询语音数据成功！") ;</script> <%
					  }else
					  {
					     %>	<script> rdShowMessageDialog("导入咨询语音数据失败！"); </script>	<%
					  }
 
}
%>

	
	
<html>
<head>
<title>批量导入咨询语音数据</title>

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
	  	  
 
	formbar.action="<%=request.getContextPath()%>/npage/callbosspage/K189/k189_loadPage.jsp?iniFlag=1";
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
                    &nbsp;&nbsp;&nbsp;&nbsp; 接入码|地市区号|路由键值|流程的中文名称 |后续码|短信内容|特定流程标志|是否显示<br>
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;例如：
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp; 10086|0451|122*|办理业务咨询音|6090|办理业务咨询音|2003|1<br>


                      <br>
                     &nbsp;&nbsp; <b>格式中的每一项均不允许存在|，且项与项必须以|为间隔符。</b> 
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
 
 

