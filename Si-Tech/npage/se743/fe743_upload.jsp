<%
/********************
 * version v3.0
 * 开发商: si-tech
 * author: wangzn 2010-3-23 14:49:16
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/serverip.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ page import="jxl.*"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>

<%
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String failFileName = "";//上传失败的文件名
	String jsonText = "";
	String pageHref = "";
	String[] jsons = new String[30];
	String loginAccept = "";
	int start = 0;
	boolean runFlag = true;
	String rstCode = "";
	String rstMsg = "";
	String errorStatus = "1";//1：文件上传错误 2:解析xls错误；3：se743file返回错误
	
	
	System.out.println("-----liujian------------------------------------------welcome to fe743_upload.jsp");
try {                                                             
	
	SmartUpload mySmartUpload = new SmartUpload();
	mySmartUpload.initialize(pageContext);
	mySmartUpload.setMaxFileSize(10*1024*1024); 
	mySmartUpload.upload();
	String mapping = mySmartUpload.getRequest().getParameter("mapping");
	String inTypeSome = mySmartUpload.getRequest().getParameter("inType");
	System.out.println("-----gaopeng---inTypeSome=" + inTypeSome);
	System.out.println("-----liujian---mapping=" + mapping);
	pageHref = mySmartUpload.getRequest().getParameter("pageHref");
	jsonText = mySmartUpload.getRequest().getParameter("json1");
	com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();	
	
	Map map=new HashMap();  
	if(mapping != null && !mapping.equals("")) {
		String[] mapps = mapping.split(";");
		String[] mapp = null;
		for(int i=0;i<mapps.length;i++) {
			mapp = mapps[i].split(":");
			map.put(mapp[0],mapp[1]);
		}
	}
	System.out.println("----liujian----jsonText--" + jsonText);
	System.out.println("----liujian----pageHref--" + pageHref);

	System.out.println("================liujian=============mapping==========="+mapping);
	System.out.println("================liujian=============fileCounts==========="+myfiles.getCount());
	String path = request.getRealPath("/npage/tmp/");
	java.io.File fileNew = new java.io.File(path);
	if(!fileNew.exists()) fileNew.mkdirs();
	if(myfiles.getCount()>0) {
		String myFileName = "";
		String fieldName = "";
		String newFileName = "";
		String filePath = "";
		String flag = "";
		FileInputStream fis = null;
		DataInputStream dis = null;
		for (int i=0; i<myfiles.getCount(); i++) {
			com.jspsmart.upload.File myFile = myfiles.getFile(i);
			myFileName = myFile.getFileName();//上传的源文件名
			fieldName = myFile.getFieldName();//表单的name
			newFileName= (String)map.get(myFile.getFieldName());//以时间戳定义的新文件名
			System.out.println("-----liujian--------上传文件名:" + myFileName );
			System.out.println("-----liujian--------表单的name:" + fieldName );
			System.out.println("-----liujian--------以时间戳定义的新文件名:" + newFileName );
			failFileName = myFileName;
			if(fieldName != null && myFileName != null && !"".equals(myFileName)) {
				if(fieldName.split("_").length > 2) {
					//属性附件			
					if("".equals(myFileName) || myFileName == null) {
						System.out.println("-liujian-continue");
						continue;
					}
					filePath = path+"/"+newFileName;
					//1. 上传文件
					myFile.saveAs(filePath);
					//上传文件
					try {
						System.out.println("-liujian-run--filePath=" + filePath + "--fieldName=" + fieldName);
						fis = new FileInputStream(filePath);    
						dis = new DataInputStream(fis); 
						dis.close();
						fis.close();
					} catch(IOException e) {
						e.printStackTrace();
						flag = "error1";
						System.out.println("文件不存在");
						dis.close();
						fis.close();
						break;
					} catch(Exception e) {
						e.printStackTrace();
						flag = "error2";
						System.out.println("文件上传失败");
						dis.close();
						fis.close();
						break;
					}
					//2. 解析文件
					//如果是三个模板文件就解析
					//fieldName:A501_1_999033717_0
					if(fieldName != null && fieldName.split("_").length == 4 
						&& (fieldName.split("_")[2].equals("999033734") 
							||fieldName.split("_")[2].equals("999033735") 
							||fieldName.split("_")[2].equals("999033717")
							||fieldName.split("_")[2].equals("9116014560")
							||fieldName.split("_")[2].equals("9116014556")
							||fieldName.split("_")[2].equals("1113035011")) ) {
						String charName = fieldName.split("_")[2];
						String rst = "";
						String[] rsts = new String[100];
						
						/*liujian 2013-3-14 14:54:39 se743file添加产品订购关系编码 begin*/
						String productID = "";
						//父节点id的部分字符串 
						String parentIdPartStr = fieldName.split("_")[0].replaceAll("A","") + "_" + fieldName.split("_")[1];
						String productIDName = "PRO_" + parentIdPartStr + "_ID";
						System.out.println("---liujian---productIDName=" + productIDName);
						if(!mySmartUpload.getRequest().getParameter("productIDs").equals("")) {
						JSONObject jo = new JSONObject(mySmartUpload.getRequest().getParameter("productIDs"));
						String newProductIDName = (String)jo.get(productIDName);
						if(newProductIDName != null && !newProductIDName.equals("")) {
							productID = newProductIDName;
						}
						System.out.println("----liujian----productID=" + productID);
						}
						/*liujian 2013-3-14 14:54:39 se743file添加产品订购关系编码 end*/
						
						
						
						//获得json串
						if(charName !=null && "999033734".equals(charName)) {
							errorStatus = "2";
							rst = getCoorCompSubmitFileCont(filePath);
							errorStatus = "1";
						}else if(charName !=null && "999033735".equals(charName)) {
							errorStatus = "2";
							rst = getCoorCompOpenFileCont(filePath);
							errorStatus = "1";
						}else if(charName !=null && "999033717".equals(charName)) {
							errorStatus = "2";
							rst = getHostCompFileCont(filePath);
							errorStatus = "1";
						}
						//liujian 2012-9-7 14:37:21 添加两种模板 物联网跨省行业应用卡业务 begin 
						else if(charName !=null && "9116014556".equals(charName)) {
							errorStatus = "2";
							rst = getCardCoorCompOpenFileCont(filePath);
							errorStatus = "1";
						}else if(charName !=null && "9116014560".equals(charName)) {
							errorStatus = "2";
							rst = getCardHostCompFileCont(filePath);
							errorStatus = "1";
							/*gaopeng 2013/12/18 15:37:35 关于下发优化呼叫中心业务支撑实施方案的通知 加入全网局数据申请单 */
						}else if(charName !=null && "1113035011".equals(charName)) {
							errorStatus = "2";
							System.out.println("gaopengSeeRstJson ===========1");
							rst = getCallCenterFileCont(filePath,inTypeSome);
							//System.out.println("gaopengSeeRstJson ==========="+rst);
							errorStatus = "1";
							System.out.println("gaopengSeeRstJson ===========2");
						}
						//liujian 2012-9-7 14:37:21 添加两种模板 物联网跨省行业应用卡业务 end 
						System.out.println("ningtn rst【" + rst + "】");
						int s = 0;
						for (int m = 0; m < (rst.length() / 400) + 1; m ++) {
							if (m == (rst.length() / 400)) {
								rsts[m] = rst.substring(s, rst.length());
							} else {
								rsts[m] = rst.substring(s, s + 400);
								s += 400;
							}
						}
						String[] inputParams = new String[10];
						inputParams[0] = "";
						inputParams[1] = "01";
						inputParams[2] = "e743";
						inputParams[3] = workNo;
						inputParams[4] = password;
						inputParams[5] = "";
						inputParams[6] = "";
						inputParams[7] = charName;
						inputParams[8] = newFileName;
						%>
						<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
							routerValue="<%=regionCode%>"  id="loginAccept2" />
						<wtc:service name="se743file" routerKey="region" routerValue="<%=regionCode%>"
							retcode="retCode" retmsg="retMsg" outnum="1">
							<wtc:param value="<%=loginAccept2%>"/>
							<wtc:param value="<%=inputParams[1]%>"/>
							<wtc:param value="<%=inputParams[2]%>"/>
							<wtc:param value="<%=inputParams[3]%>"/>
							<wtc:param value="<%=inputParams[4]%>"/>
							<wtc:param value="<%=inputParams[5]%>"/>
							<wtc:param value="<%=inputParams[6]%>"/>
							<wtc:param value="<%=inputParams[7]%>"/>
							<wtc:param value="<%=inputParams[8]%>"/>
							<wtc:params value="<%=rsts%>"/>
							<wtc:param value="<%=productID%>"/>	
						</wtc:service>
						<wtc:array id="tempArr"  scope="end"/>
						
						<%
						if(retCode.equals("000000")) {
							continue;
						}else {
							System.out.println("----" + retCode + "----" + retMsg);
							errorStatus = "3";	
							runFlag = false;
							rstCode = retCode;
							rstMsg = retMsg;
							break;
						}
					}
				}else {
					//商品订购对应的附件信息
					filePath = path+"/"+newFileName;
					myFile.saveAs(filePath);	
				}
				
				
			}
		}	
	} 
	if(runFlag){
		for (int i = 0; i < (jsonText.length() / 400) + 1; i ++) {
			if (i == (jsonText.length() / 400)) {
				jsons[i] = jsonText.substring(start, jsonText.length());
			} else {
				jsons[i] = jsonText.substring(start, start + 400);
				start += 400;
			}
		}	
	
%>	
		<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
		<%
			loginAccept = seq;
			System.out.println("----liujian----loginAccept=" + loginAccept);
		%>
		<wtc:service name="se743Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:param value="<%=loginAccept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="e743"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:params value="<%=jsons%>"/>
		</wtc:service>
<%
	if("000000".equals(retCode1)){
%>
		<script>
			rdShowMessageDialog("提交成功！", 2);
			parent.remove743Tab();
		</script>
<%
	} else {
%>
		<script language="JavaScript">
			rdShowMessageDialog('提交失败！se743Cfm，<%=retCode1%>，<%=retMsg1%>', 0);
			parent.resetPage();
		</script>
<%
	}
	}//end runFlag
	else {
			%>
				<script>
					rdShowMessageDialog('文件上传数据库失败！se743file--<%=rstCode%>--<%=rstMsg%>');
					parent.hideLightBoxFn();
					window.close();
				</script>
			<%
	}
} catch(Exception e) {
	e.printStackTrace();
	if(errorStatus.equals("1")) {
%>
		<script>
			rdShowMessageDialog('文件上传失败！');
			parent.hideLightBoxFn();
			window.close();
		</script>
<%
	}else if(errorStatus.equals("2")) {
		
%>
		<script>
			rdShowMessageDialog('解析xls失败！请确认上传的模板文件是否对应！');
			parent.hideLightBoxFn();
			window.close();
		</script>
<%
	}else if(errorStatus.equals("3")) {
%>
		<script>
			rdShowMessageDialog('文件上传数据库失败！');
			parent.hideLightBoxFn();
			window.close();
		</script>
<%		
	}
}
%>


<%!
		//主办省上传成员明细文件
	public String getHostCompFileCont(String path) throws Exception {
		StringBuffer rstJson = new StringBuffer("");//{"key":[{},{}]}
		StringBuffer tempJson = null;
		Workbook book = null;
		//用try-catch为了关闭book，防止内存异常
		try{
			book = getWorkbook(path);
			Sheet sheet = book.getSheet(0);
			Cell ct = sheet.getCell(0, 1);
			if(ct.getContents() == null || !ct.getContents().equals("省代码")) {
				throw new Exception();
			}
            //单个单元格
            Cell cell = null;
            String[] userNames = new String[5];
            userNames[0] = "ProvCode";
            userNames[1] = "NewUserCount";
            userNames[2] = "FeePlan";
            userNames[3] = "PayType";
            userNames[4] = "PayAmount";
            String[] values = new String[5];
            int blankCount = 0;
            rstJson.append("{\"NewUser\":[");
            for(int i = 1;i<256;i++){
            	blankCount = 0;
            	tempJson = new StringBuffer("{");
            	for (int j = 1; j < 6; j++) {
					cell = sheet.getCell(i, j);
					String cont = cell.getContents();
					if( cont == null || "".equals(cont)) {
						blankCount++;
						values[j-1] = "";
					}else {
						values[j-1] = cont;
					}
					tempJson.append("\"" + userNames[j-1] + "\":\"" + values[j-1] + "\",");
				}
            	if(!tempJson.equals("") && tempJson.lastIndexOf(",") == tempJson.length()-1) {
            		tempJson.deleteCharAt(tempJson.length()-1);
                }
            	tempJson.append("},");
            	if(blankCount == 5) {
            		break;
            	}else {
            		rstJson.append(tempJson);
            	}
            }
            //删除末尾的","
            if(!rstJson.equals("") && rstJson.lastIndexOf(",") == rstJson.length()-1) {
            	rstJson.deleteCharAt(rstJson.length()-1);
            }
            rstJson.append("],");
            rstJson.append("\"UserList\":[");
            String[] piNames = new String[8];//产品信息名称
            piNames[0] = "ProvCode";
            piNames[1] = "MSISDN";
            piNames[2] = "FeePlan";
            piNames[3] = "OperCode";
            piNames[4] = "AccountNameReq";
            piNames[5] = "PayType";
            piNames[6] = "PayAmount"; 
            piNames[7] = "EffRule";
			for (int i = 9; i < sheet.getRows(); i++) {
				int m = 0;
				String[] params = new String[8];
				tempJson = new StringBuffer("{");
				for (int j = 0; j < 8; j++) {
					cell = sheet.getCell(j, i);
					if(cell.getContents() == null || "".equals(cell.getContents())) {
						m++;
						params[j] = "";
					}else {
						params[j] = cell.getContents();
					}
					tempJson.append("\"" + piNames[j] + "\":\"" + params[j] + "\",");
				}
				if(!tempJson.equals("") && tempJson.lastIndexOf(",") == tempJson.length()-1) {
					tempJson.deleteCharAt(tempJson.length()-1);
                }
				tempJson.append("},");
				if(m == 8) {
					System.out.println("空行！");
					break;
				}else {
            		rstJson.append(tempJson);
            	}
			}
			//删除末尾的","
            if(!rstJson.equals("") && rstJson.lastIndexOf(",") == rstJson.length()-1) {
            	rstJson.deleteCharAt(rstJson.length()-1);
            }
            rstJson.append("]}");
            
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}finally{
			book.close();
		}
        return rstJson.toString();
	}

	//配合省反馈成员开通结果明细文件
	public String getCoorCompOpenFileCont(String path) throws Exception{
		StringBuffer rstJson = new StringBuffer("{");//{"key":[{},{}]}
		StringBuffer tempJson = null;
		Workbook book = null;
		try{
		   book = getWorkbook(path);
           //获得第一个工作表对象
           Sheet sheet=book.getSheet(0);
           Cell ct = sheet.getCell(0, 3);
			if(ct.getContents() == null || !ct.getContents().equals("MSISDN")) {
				throw new Exception();
			}
           //单个单元格
           Cell cell = sheet.getCell(1, 1);
           rstJson.append("\"NewUserFailDesc\":");
           rstJson.append("\"" + cell.getContents() + "\",");
           rstJson.append("\"UserList\":[");
           String[] openNames = new String[9];
           openNames[0] = "MSISDN";
           openNames[1] = "CentrolPayStatus";
           openNames[2] = "EffRule";
           openNames[3] = "AccountName";
           openNames[4] = "FailDesc";
           openNames[5] = "PayType";
           openNames[6] = "PayAmount";
           openNames[7] = "IsNewUser";
           openNames[8] = "FeePlan";
           for (int i = 5; i < sheet.getRows(); i++) {
        	   tempJson = new StringBuffer("{");
				int blankCount = 0;
				String[] params = new String[9];
				for (int j = 0; j < 9; j++) {
					cell = sheet.getCell(j, i);
					if(cell.getContents() == null || "".equals(cell.getContents())) {
						blankCount++;
						params[j] = "";
					}else {
						params[j] = cell.getContents();
					}
					tempJson.append("\"" + openNames[j] + "\":\"" + params[j] + "\",");
				}
				if(!tempJson.equals("") && tempJson.lastIndexOf(",") == tempJson.length()-1) {
					tempJson.deleteCharAt(tempJson.length()-1);
                }
				tempJson.append("},");
				if(blankCount == 9) {
					System.out.println("空行！");
					break;
				}else {
					rstJson.append(tempJson);
				}
			}
           //删除末尾的","
           if(!rstJson.equals("") && rstJson.lastIndexOf(",") == rstJson.length()-1) {
           	rstJson.deleteCharAt(rstJson.length()-1);
           }
           rstJson.append("]}");
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}finally{
           book.close();
		}
           return rstJson.toString();
	}
	//配合省反馈成员确认结果明细文件
	public String getCoorCompSubmitFileCont(String path) throws Exception{
		StringBuffer rstJson = new StringBuffer("{");//{"key":[{},{}]}
		StringBuffer tempJson = null;
		Workbook book = null;
		try{
		   book = getWorkbook(path);
           //获得第一个工作表对象
           Sheet sheet=book.getSheet(0);
           Cell ct = sheet.getCell(0, 0);
			if(ct.getContents() == null || !ct.getContents().equals("MSISDN")) {
				throw new Exception();
			}
           //单个单元格
           Cell cell = sheet.getCell(1, 1);
           String[] submitNames = new String[4];
           submitNames[0] = "MSISDN";
           submitNames[1] = "NameMatch";
           submitNames[2] = "CurrFeePlan";
           submitNames[3] = "UserStatus";
           rstJson.append("\"UserList\":[");
           for (int i = 2; i < sheet.getRows(); i++) {
        	   tempJson = new StringBuffer("{");
        	   int blankCount = 0;
        	   String[] params = new String[4];
        	   for (int j = 0; j < 4; j++) {
					cell = sheet.getCell(j, i);
					if(cell.getContents() == null || "".equals(cell.getContents())) {
						blankCount++;
						params[j] = "";
					}else {
						params[j] = cell.getContents();
					}
					tempJson.append("\"" + submitNames[j] + "\":\"" + params[j] + "\",");
        	   }
        	   if(!tempJson.equals("") && tempJson.lastIndexOf(",") == tempJson.length()-1) {
					tempJson.deleteCharAt(tempJson.length()-1);
               }
        	   tempJson.append("},");
        	   if(blankCount == 4) {
        		   System.out.println("空行！");
        		   break;
        	   }else {
        		   rstJson.append(tempJson);
        	   }
			}
           //删除末尾的","
           if(!rstJson.equals("") && rstJson.lastIndexOf(",") == rstJson.length()-1) {
           	rstJson.deleteCharAt(rstJson.length()-1);
           }
           rstJson.append("]}");
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception();
		}finally{
           book.close();
		}
           return rstJson.toString();
	}
	
	/*gaopeng 2013/12/18 15:51:13 关于下发优化呼叫中心业务支撑实施方案的通知 加入新的返回json串方法 start*/
	public String getCallCenterFileCont(String path,String inType) throws Exception {
	System.out.println("gaopengSeeRstJson ===========init OK");
		StringBuffer rstJson = new StringBuffer("");//{"key":[{},{}]}
		StringBuffer tempJson = null;
		Workbook book = null;
		//用try-catch为了关闭book，防止内存异常
		try{
			book = getWorkbook(path);
			Sheet sheet = book.getSheet(0);
			Cell ct = sheet.getCell(7, 0);
			System.out.println("gaopengSeeRstJson ===========ct.getContents()"+ct.getContents());
			if(ct.getContents() == null || !ct.getContents().equals("业务汇接区")) {
				throw new Exception();
			}
            //单个单元格
            Cell cell = null;
            String[] userNames = new String[50];
            /*
            	1 业务类别（呼入接入方式） BuziTypeIn
							2 业务类别（呼出接入方式） BuziTypeOut
							8 开放范围（呼入）		 OpenRangeIn
							9 开放范围（呼出）		OpenRangeOut
							12 拨号方式		CallType
							13 HLR呼转		HLRCall
							14 生效时间		EffTime
							15 局数据批复号 CommentNo

            	*/
            userNames[0] = "unKnow0";
            userNames[1] = "BuziTypeIn";
            userNames[2] = "BuziTypeOut";
            userNames[3] = "unKnow3";
            userNames[4] = "unKnow4";
            userNames[5] = "unKnow5";
            userNames[6] = "unKnow6";
            userNames[7] = "unKnow7";
            
            userNames[8] = "OpenRangeIn";
            userNames[9] = "OpenRangeOut";
            userNames[10] = "unKnow10";
            userNames[11] = "unKnow11";
            userNames[12] = "CallType";
            userNames[13] = "HLRCall";
            userNames[14] = "EffTime";
            userNames[15] = "CommentNo";
            
            userNames[16] = "unKnow16";
            userNames[17] = "unKnow17";
            userNames[18] = "unKnow18";
            userNames[19] = "unKnow19";
            userNames[20] = "unKnow20";
            userNames[21] = "unKnow21";
            userNames[22] = "unKnow22";
            userNames[23] = "unKnow23";
            userNames[24] = "unKnow24";
            userNames[25] = "unKnow25";
            userNames[26] = "unKnow26";
            userNames[27] = "unKnow27";
            userNames[28] = "unKnow28";
            userNames[29] = "unKnow29";
            userNames[30] = "unKnow30";
            userNames[31] = "unKnow31";
            userNames[32] = "unKnow32";
            userNames[33] = "unKnow33";
            userNames[34] = "unKnow34";
            userNames[35] = "unKnow35";
            userNames[36] = "unKnow36";
            userNames[37] = "unKnow37";
            userNames[38] = "unKnow38";
            userNames[39] = "unKnow39";
            userNames[40] = "unKnow40";
            userNames[41] = "unKnow41";
            userNames[42] = "unKnow42";
            userNames[43] = "unKnow43";
            userNames[44] = "unKnow44";
            userNames[45] = "unKnow45";
            userNames[46] = "unKnow46";
            userNames[47] = "unKnow47";
            userNames[48] = "unKnow48";
            userNames[49] = "unKnow49";
            
            
            String[] values = new String[50];
            int blankCount = 0;
            rstJson.append("{\"inType\": \""+inType+"\",");
            for(int i = 0;i<50;i++){
            	blankCount = 0;
            	tempJson = new StringBuffer("");
            	for (int j = 1; j < 2; j++) {
            	/*
            	1 业务类别（呼入接入方式） BuziTypeIn
							2 业务类别（呼出接入方式） BuziTypeOut
							8 开放范围（呼入）		 OpenRangeIn
							9 开放范围（呼出）		OpenRangeOut
							12 拨号方式		CallType
							13 HLR呼转		HLRCall
							14 生效时间		EffTime
							15 局数据批复号 CommentNo

            	*/
            	
					cell = sheet.getCell(i, j);
					String cont = cell.getContents();
					System.out.println("gaopengSeeRstJson ===========cont["+i+"]["+j+"]:"+cont);
					if( cont == null || "".equals(cont)) {
						blankCount++;
						values[j-1] = "";
					}else {
						values[j-1] = cont;
					}
					tempJson.append("\"" + userNames[i] + "\":\"" + values[j-1] + "\",");
					System.out.println("gaopengSeeRstJson ===========tempJson:"+tempJson);
					
					
				}
            	if(!tempJson.equals("") && tempJson.lastIndexOf(",") == tempJson.length()-1) {
            		tempJson.deleteCharAt(tempJson.length()-1);
                }
            	tempJson.append(",");
            	if(blankCount == 4) {
            		break;
            	}else {
            		rstJson.append(tempJson);
            	}
            }
            //删除末尾的","
            if(!rstJson.equals("") && rstJson.lastIndexOf(",") == rstJson.length()-1) {
            	rstJson.deleteCharAt(rstJson.length()-1);
            }
            rstJson.append("}");
            System.out.println("gaopengSeeRstJson ==========="+rstJson);
            
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}finally{
			book.close();
		}
        return rstJson.toString();
	}
	
	/*gaopeng 2013/12/18 15:51:13 关于下发优化呼叫中心业务支撑实施方案的通知 加入新的返回json串方法 end*/
	
	
	//物联网跨省行业应用卡业务 卡主办省明细
	public String getCardHostCompFileCont(String path) throws Exception {
		StringBuffer rstJson = new StringBuffer("");//{"key":[{},{}]}
		StringBuffer tempJson = null;
		Workbook book = null;
		//用try-catch为了关闭book，防止内存异常
		try{
			book = getWorkbook(path);
			Sheet sheet = book.getSheet(0);
			Cell ct = sheet.getCell(0, 4);
			if(ct.getContents() == null || !ct.getContents().equals("新开卡功能需求")) {
				throw new Exception();
			}
            //单个单元格
            Cell cell = null;
            String[] userNames = new String[4];
            userNames[0] = "ProvCode";
            userNames[1] = "NewUserCount";
            userNames[2] = "FeePlan";
            userNames[3] = "ProdInfo";
            String[] values = new String[4];
            int blankCount = 0;
            rstJson.append("{\"NewUser\":[");
            for(int i = 1;i<256;i++){
            	blankCount = 0;
            	tempJson = new StringBuffer("{");
            	for (int j = 1; j < 5; j++) {
					cell = sheet.getCell(i, j);
					String cont = cell.getContents();
					if( cont == null || "".equals(cont)) {
						blankCount++;
						values[j-1] = "";
					}else {
						values[j-1] = cont;
					}
					tempJson.append("\"" + userNames[j-1] + "\":\"" + values[j-1] + "\",");
				}
            	if(!tempJson.equals("") && tempJson.lastIndexOf(",") == tempJson.length()-1) {
            		tempJson.deleteCharAt(tempJson.length()-1);
                }
            	tempJson.append("},");
            	if(blankCount == 4) {
            		break;
            	}else {
            		rstJson.append(tempJson);
            	}
            }
            //删除末尾的","
            if(!rstJson.equals("") && rstJson.lastIndexOf(",") == rstJson.length()-1) {
            	rstJson.deleteCharAt(rstJson.length()-1);
            }
            rstJson.append("],");
            rstJson.append("\"UserList\":[");
            String[] piNames = new String[5];//产品信息名称
            piNames[0] = "ProvCode";
            piNames[1] = "MSISDN";
            piNames[2] = "FeePlan";
            piNames[3] = "ProdInfo";
            piNames[4] = "OperCode";
			for (int i = 7; i < sheet.getRows(); i++) {
				int m = 0;
				String[] params = new String[5];
				tempJson = new StringBuffer("{");
				for (int j = 0; j < 5; j++) {
					cell = sheet.getCell(j, i);
					if(cell.getContents() == null || "".equals(cell.getContents())) {
						m++;
						params[j] = "";
					}else {
						params[j] = cell.getContents();
					}
					tempJson.append("\"" + piNames[j] + "\":\"" + params[j] + "\",");
				}
				if(!tempJson.equals("") && tempJson.lastIndexOf(",") == tempJson.length()-1) {
					tempJson.deleteCharAt(tempJson.length()-1);
                }
				tempJson.append("},");
				if(m == 5) {
					System.out.println("空行！");
					break;
				}else {
            		rstJson.append(tempJson);
            	}
			}
			//删除末尾的","
            if(!rstJson.equals("") && rstJson.lastIndexOf(",") == rstJson.length()-1) {
            	rstJson.deleteCharAt(rstJson.length()-1);
            }
            rstJson.append("]}");
            
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}finally{
			book.close();
		}
        return rstJson.toString();
	}
	//物联网跨省行业应用卡业务 卡配合省开通
	public String getCardCoorCompOpenFileCont(String path) throws Exception{
		StringBuffer rstJson = new StringBuffer("{");//{"key":[{},{}]}
		StringBuffer tempJson = null;
		Workbook book = null;
		try{
		   book = getWorkbook(path);
           //获得第一个工作表对象
           Sheet sheet=book.getSheet(0);
           Cell ct = sheet.getCell(1, 3);
			if(ct.getContents() == null || !ct.getContents().equals("BusiStatus")) {
				throw new Exception();
			}
           //单个单元格
           Cell cell = sheet.getCell(1, 1);
           rstJson.append("\"NewUserFailDesc\":");
           rstJson.append("\"" + cell.getContents() + "\",");
           rstJson.append("\"UserList\":[");
           String[] openNames = new String[4];
           openNames[0] = "MSISDN";
           openNames[1] = "BusiStatus";
           openNames[2] = "IsNewUser";
           openNames[3] = "ErrDesc";
           for (int i = 5; i < sheet.getRows(); i++) {
        	   tempJson = new StringBuffer("{");
				int blankCount = 0;
				String[] params = new String[9];
				for (int j = 0; j < 4; j++) {
					cell = sheet.getCell(j, i);
					if(cell.getContents() == null || "".equals(cell.getContents())) {
						blankCount++;
						params[j] = "";
					}else {
						params[j] = cell.getContents();
					}
					tempJson.append("\"" + openNames[j] + "\":\"" + params[j] + "\",");
				}
				if(!tempJson.equals("") && tempJson.lastIndexOf(",") == tempJson.length()-1) {
					tempJson.deleteCharAt(tempJson.length()-1);
                }
				tempJson.append("},");
				if(blankCount == 4) {
					System.out.println("空行！");
					break;
				}else {
					rstJson.append(tempJson);
				}
			}
           //删除末尾的","
           if(!rstJson.equals("") && rstJson.lastIndexOf(",") == rstJson.length()-1) {
           	rstJson.deleteCharAt(rstJson.length()-1);
           }
           rstJson.append("]}");
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}finally{
           book.close();
		}
           return rstJson.toString();
	}
	
	
	//获得workbook
	public Workbook getWorkbook(String path) throws Exception{
		Workbook book = null;
		try{
			book = Workbook.getWorkbook(new File(path));
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("get Workbook error");
			throw new Exception();
		}
		return book;
	}
	
%>