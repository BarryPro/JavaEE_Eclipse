<%
  /*
   * 功能: 导入流水号信息页面
　 * 版本: 1.0.0
　 * 日期: 2009/11/03
　 * 作者: zengzq
　 * 版权: sitech
   * update:
　 */
%>
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
	String opCode = "K280";
	String opName = "批量导入流水号";
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
int tmpFail = 0;
/*---------------获得页面传递参数结束-------------------*/
//result 0:发送成功 1：不成功
String result = "0";
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
							int firstRowNum;
							int lastRowNum;
							int i;
							int firstColumnNum;
							int lastColumnNum;
							firstRowNum = sheet.getFirstRowNum();
							lastRowNum = sheet.getLastRowNum();
							count2 = lastRowNum+1;
							for (i = firstRowNum; i <= lastRowNum; i++) {
								row = sheet.getRow(i);
								if(row ==null){
										continue;
								}
								firstColumnNum = row.getFirstCellNum();
								lastColumnNum = row.getLastCellNum();
								for(int j = firstColumnNum;j<lastColumnNum;j++){
										gerCellValue = getCell(row.getCell((short) j));
										if(gerCellValue!=null && !("".equals(gerCellValue))){
												if(tmpBufferSaveVal.indexOf(gerCellValue) == -1){
														tmpBufferSaveVal.append(gerCellValue);
														tmpBufferSaveVal.append(",");
												}else{
														tmpFail = tmpFail+1;
												}	
										}
								}
							}
            }catch(Exception e){   
              e.printStackTrace();   
          	}   
					}
  }
  tmpSaveVal = tmpBufferSaveVal.toString();
}
%>
	
<html>
<head>
<title>批量导入流水号</title>
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
function submitLoad(){
	if(formbar.uploadStaffno.value==''){ 
		rdShowMessageDialog('请选择文件!',2);
		return;
	}
	document.getElementById('submit2').disabled=true;
	formbar.action="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K280/K280_loadSerialPage.jsp?iniFlag=1&selectedItemId="+'<%=selectedItemId%>';
	formbar.submit();
}

function saveDataOp(){
		var selectedItemId = '<%=selectedItemId%>';
		var tmpData = '<%=tmpSaveVal%>';
		if(""==tmpData || tmpData=="undefined"){
				similarMSNPop("请选择有效流水号的文件！");
				document.getElementById('submit2').disabled=false;
				return false;
		}
		if(opener.parent.rightTopFrame.document.getElementById("check2").checked == true){
				opener.parent.rightTopFrame.document.getElementById("check2").click();
		}
		var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K280/k2801/k280_saveSerialNo.jsp","正在导入,请稍后...");
		packet.data.add("selectedItemId",selectedItemId);
		packet.data.add("unCheckValue",tmpData);
		core.ajax.sendPacket(packet,doProcessSaveData,true);
		packet=null;
}

//saveLoginNo的回调函数
function doProcessSaveData(packet){
	var retCode = packet.data.findValueByName("retCode");
	var notIsExitBuffer = packet.data.findValueByName("notIsExitBuffer");
	var succ1 = packet.data.findValueByName("succ1");
	var fail1 = packet.data.findValueByName("fail1");
	var fail2 = '<%=tmpFail%>';
	var faliTotal = parseInt(fail1)+parseInt(fail2);
	if(retCode="000000"){
			opener.parent.rightTopFrame.document.getElementById("check2").click();
			similarMSNPop("工号导入完成。成功"+succ1+"条，失败"+faliTotal+"条！");
			/*
			if(notIsExitBuffer.length>0 && notIsExitBuffer!=undefined){
					var tmpNotIsExitBuffer = notIsExitBuffer.substring(0,(notIsExitBuffer.length-1));
					similarMSNPop("导入成功,以下为非法流水号：" + tmpNotIsExitBuffer);
					rdShowMessageDialog("导入成功,以下为非法流水号：" + tmpNotIsExitBuffer,1);
			}else{
					similarMSNPop("被检组流水号导入成功！");
			}
			*/
			setTimeout("window.close()",2000);
	} else {
			similarMSNPop("被检组流水号导入失败！");
			setTimeout("window.close()",2000);
	}
}

function ifSaveData(){

		var iFlag = '<%=iniFlag%>';
		if("1" == iFlag){
			document.getElementById('submit2').disabled=true;
				saveDataOp();
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
      	<td width=16% class="blue">请选择流水号excel文件</td>
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
 
 

