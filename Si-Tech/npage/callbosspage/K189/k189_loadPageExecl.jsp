<%
  /*
   * 功能: 导入咨询语音数据
　 * 版本: 1.0.0
　 * 日期: 2009/11/19
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
	String opName = "批量导入咨询语音数据";
	String strSql="";
	String strFrame="";
	int xflagsucess= 0 ;
	int xflagfail= 0 ;
 
  String[] sqlArr = new String[]{};
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import= "java.util.*"%> 

<%@ page import= "java.io.*"%> 
<%@ page import= "org.apache.poi.hssf.usermodel.*"%>
<%@ page import= "org.apache.poi.poifs.filesystem.*"%> 
<%@ page import= "org.apache.commons.fileupload.*"%>
<%!
/*---------------获得页面传递参数开始-------------------*/

 public String getCell(HSSFCell cell){
		
		 if (cell== null)
		{
			return "";
		}
		int cellType = cell.getCellType();
		if (cellType == HSSFCell.CELL_TYPE_STRING) {
			return cell.getStringCellValue();
		}		
		if (cellType == HSSFCell.CELL_TYPE_NUMERIC) {
			return "" + (long)(cell.getNumericCellValue());
		}
		if (cellType == HSSFCell.CELL_TYPE_FORMULA) {
			return cell.getCellFormula();
		}
		if (cellType == HSSFCell.CELL_TYPE_BLANK) {
			return "";
		}		
		if (cellType == HSSFCell.CELL_TYPE_BOOLEAN) {
			return ""+cell.getBooleanCellValue();
		}		
		if (cellType == HSSFCell.CELL_TYPE_ERROR) {
			return "";
		}
		return "";
		
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

if("1".equals(iniFlag)){
	DiskFileUpload   fu   =   new   DiskFileUpload(); 
	try{

			fu.setSizeMax(2048000);
			fu.setSizeThreshold(2048000);
			
	}catch(Exception e){
			e.printStackTrace();
	}

  List fileItems = fu.parseRequest(request);
  String fileName = "";
  Iterator   iter   =   fileItems.iterator(); 
  while(iter.hasNext()){
    FileItem item = (FileItem) iter.next(); //忽略其他不是文件域的所有表单信息 
  	if (!item.isFormField()) {
						fileName = item.getName();
						if(fileName.toLowerCase().indexOf(".xls")==-1){
								result = "1";
								break;
						}
						int count = 0;
						int count2 = 0;
						POIFSFileSystem fs = null;
						HSSFWorkbook wb = null;
						try{
              InputStream   in   =   item.getInputStream();  
							fs = new POIFSFileSystem(in);
							wb = new HSSFWorkbook(fs);
							HSSFSheet sheet = wb.getSheetAt(0);
							HSSFRow row = null;
							HSSFCell cell = null;
							String gerCellValue = null;
							String gerAccesscode = null;
							String gercitycode = null;
							String gerdigitcode = null;
							String gerServicename = null;
							String gerTransfercode = null;
						  String gerMessegecontent = null;
						  String gerTypeid = null;
						  String gerVisiable = null;
							int firstRowNum;
							int lastRowNum;
							int i;
							int firstColumnNum;
							int lastColumnNum;
							firstRowNum = sheet.getFirstRowNum();
							lastRowNum = sheet.getLastRowNum();
							count2 = lastRowNum+1;

							for (i = firstRowNum; i <= lastRowNum; i++) {
							List sqlList=new ArrayList();
								row = sheet.getRow(i);
								if(row ==null){
										continue;
								}
								firstColumnNum = row.getFirstCellNum();
								lastColumnNum = row.getLastCellNum(); 	
  
               gerAccesscode=getCell(row.getCell((short) firstColumnNum)).trim();     
          	 
               gercitycode= getCell(row.getCell((short) (firstColumnNum + 1))).trim() ;     
            
               gerdigitcode= getCell(row.getCell((short) (firstColumnNum + 2))).trim() ;     
            	 
               gerServicename=getCell(row.getCell((short) (firstColumnNum + 6))).trim();     
            	    
               gerTransfercode=getCell(row.getCell((short) (firstColumnNum + 3))).trim();     

               gerMessegecontent=getCell(row.getCell((short) (firstColumnNum + 4))).trim();     

               gerTypeid=getCell(row.getCell((short) (firstColumnNum + 5))).trim();     

               gerVisiable=getCell(row.getCell((short) (firstColumnNum + 7))).trim(); 
               
               
               if(gerdigitcode =="" || gerVisiable==null){
										continue;
								}
								
							 
								if(gerVisiable.equals("") || gerVisiable==null){
										gerVisiable="1";
									 		
								}

	 
	  strSql=" INSERT INTO DZXSCETRANSFERTAB  ";
		strSql+="select   :v1|| :v2||user_class_id|| :v3,substr( :v4|| :v5||user_class_id|| :v6,0,length( :v7|| :v8||user_class_id|| :v9)-1), ";
		strSql+="  :v10 ,  :v11,  user_class_id  , :v12, :v13, :v14, :v15, :v16, '', '', '',  :v17";
		strSql+=" FROM DUAL ,SCALLGRADECODE B  "; 
		strSql+="&&"+gerAccesscode+"^"+gercitycode+"^"+gerdigitcode+"^"+gerAccesscode+"^"+gercitycode+"^"+gerdigitcode+"^"+gerAccesscode+"^"+gercitycode+"^"+gerdigitcode+"^"+gerAccesscode+"^"+gercitycode+"^"+gerServicename+"^"+gerdigitcode+"^"+gerTransfercode+"^"+gerMessegecontent+"^"+gerTypeid+"^"+gerVisiable; 
		
		
 
		strFrame="insert into DZXSCETRANSFERDETAIL ";
		strFrame+= "select distinct  FRAMEID, :v1, :v2, :v3, :v4, :v5,'','0','','','','1', :v6, :v7,sysdate ,sysdate + 365*1000,'','' from dsceconsulttype where CITYCODE=  :v8 and accesscode='10086' ";
		strFrame+="&&"+gerdigitcode+"^"+gerTransfercode+"^"+gerMessegecontent+"^"+gerTypeid+"^"+gerServicename+"^"+gerServicename+"^"+gerVisiable+"^"+gercitycode;
						 
		 
		sqlList.add(strSql+addColumnValue); 
		sqlList.add(strFrame+addColumnValue);     	
    sqlArr = (String[])sqlList.toArray(new String[0]);
						
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
					     xflagsucess= xflagsucess + 1;
					  }else
					  {
					     	xflagfail= xflagfail + 1;
					     	System.out.println(strSql);					 
				        System.out.println(strFrame);		
					     %>	<script> 
					             rdShowMessageDialog("导入咨询语音数据失败！失败节点按键路由为："+<%=gerdigitcode%>); 
 
					        </script>	
					     <%
					  }
					 	}
            }catch(Exception e){   
              e.printStackTrace();   
          	}   
					}
         }
         
       
            %>	<script> rdShowMessageDialog("导入咨询语音数据完成！其中成功:"+<%=xflagsucess%>+"条 失败："+<%=xflagfail%>+"条") ;</script> <%
        
         
 
}
%>

	
	
<html>
<head>
<title>批量导入咨询语音</title>
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
	 
	
	formbar.action="<%=request.getContextPath()%>/npage/callbosspage/K189/k189_loadPageExecl.jsp?iniFlag=1";
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
      	<td width=16% class="blue">请选择excel文件</td>
      </tr>
      <tr>
        <td width="34%"> 
        <input type="file" size="50"  name="uploadStaffno" id="uploadStaffno" />
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
                      &nbsp;&nbsp; 上传execl文件格式如下： <br>
                    &nbsp;&nbsp;&nbsp;&nbsp; 接入码	地市代码	按键路由	后续码	短信内容	特定流程标志	流程的中文名称 是否显示<br>
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;例如：
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp; 10086 0431 122* 6090 办理业务咨询音 2003 办理业务咨询音 1
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;  请选择execl文件上传并且不要带标题
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;  建议一次不要导入过多的记录
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
 
  