<%@ page language="java" contentType="textml; charset=gbk" pageEncoding="gbk" import="com.jspsmart.upload.*"%>
<%@ include file="/npage/common/serverip.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ page import="jxl.Cell"%>
<%@ page import="jxl.Sheet"%>
<%@ page import="jxl.Workbook"%>
<%@ page import="jxl.write.Label"%>
<%@ page import="jxl.write.WritableSheet"%>
<%@ page import="jxl.write.WritableWorkbook"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="jxl.write.Number"%>
<%
response.reset();
String fileName = request.getParameter("fileName");
String charName = request.getParameter("charName");
String iPAddr = realip;
String filePath = request.getRealPath("/npage/tmp/");
String fullFileName = filePath + "/" + fileName;
System.out.println("------liujian------filename="+fileName);
System.out.println("------liujian---------fullFileName="+fullFileName);
String loginNo = (String)session.getAttribute("workNo");
String loginPwd  = (String)session.getAttribute("password");//登陆密码
String regionCode= (String)session.getAttribute("regCode");
String e743path = request.getRealPath("/npage/se743/");
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
if(charName != null && (charName.equals("999033717") || charName.equals("999033734") 
		|| charName.equals("999033735") || charName.equals("9116014556") || charName.equals("9116014560"))) {
		//解析json串
		String[] params = new String[10];
		params[0] = loginAccept;
		params[1] = "";
		params[2] = "e743";
		params[3] = loginNo;
		params[4] = loginPwd;
		params[5] = "";
		params[6] = "";
		params[7] = charName;
		params[8] = fileName;
%>
	<wtc:service name="se743fileQry" routerKey="region" routerValue="<%=regionCode%>"
				 retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=params[0]%>"/>
			<wtc:param value="<%=params[1]%>"/>
			<wtc:param value="<%=params[2]%>"/>
			<wtc:param value="<%=params[3]%>"/>
			<wtc:param value="<%=params[4]%>"/>
			<wtc:param value="<%=params[5]%>"/>
			<wtc:param value="<%=params[6]%>"/>
			<wtc:param value="<%=params[7]%>"/>
			<wtc:param value="<%=params[8]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%		
	if("000000".equals(retCode) && result.length > 0) {
		StringBuffer sb = new StringBuffer("");
		for(int i=0;i<result.length;i++) {
			sb.append(result[i][0]);
		}
		try{
			String retMessage = sb.toString();
			JSONObject jo = new JSONObject(retMessage);
			String newFileName = "";
			if(charName.equals("999033717")) {
				//主办省上传成员明细文件
				newFileName = setHostCompFileCont(filePath+"/",jo,e743path);
			}else if(charName.equals("999033734")) {
				//号码确认反馈明细附件
				newFileName = setCoorCompSubmitFileCont(filePath+"/",jo,e743path);
			}else if(charName.equals("999033735")) {
				//号码开通反馈明细附件
				newFileName = setCoorCompOpenFileCont(filePath+"/",jo,e743path);
			}
			//liujian 2012-9-7 14:37:21 添加两种模板 物联网跨省行业应用卡业务 begin 
			else if(charName.equals("9116014556")) {
				//号码确认反馈明细附件
				newFileName = setCardCoorCompOpenFileCont(filePath+"/",jo,e743path);
			}else if(charName.equals("9116014560")) {
				//号码开通反馈明细附件
				newFileName = setCardHostCompFileCont(filePath+"/",jo,e743path);
			}
			//liujian 2012-9-7 14:37:21 添加两种模板 物联网跨省行业应用卡业务 end 
		  response.reset();//可以加也可以不加
	      response.setContentType("application/x-download");
	      String filedownload = fullFileName = filePath + "/" + newFileName;;
	      String filedisplay = newFileName;
	      response.addHeader("Content-Disposition","attachment;filename=" + filedisplay);
			System.out.println("----liujian----down---" + filedownload );
			System.out.println("----liujian----down---" + filedisplay );
	      OutputStream outp = null;
	      FileInputStream in = null;
	      try {
	          outp = response.getOutputStream();
	          in = new FileInputStream(filedownload);
	
	          byte[] b = new byte[1024];
	          int i = 0;
	
	          while((i = in.read(b)) > 0)
	          {
	              outp.write(b, 0, i);
	          }
	          outp.flush();
	      } catch(Exception e) {
	          System.out.println("Error!");
	          e.printStackTrace();
	%>
			<script>
				alert("文件下载失败");
			</script>
	<%	
	      }finally {
	          if(in != null)
	          {
	              in.close();
	              in = null;
	          }
	          if(outp != null)
	          {
	              outp.close();
	              outp = null;
	          }
	      }
		}catch(Exception e) {
			e.printStackTrace();
			
%>
			<script>
				alert("数据库中的属性解析失败！");
			</script>
<%
		}
	}else{
%>
		<script language="JavaScript">
			alert('从数据库中获取属性失败！se743fileQry，<%=retCode%>，<%=retMsg%>', 0);
			window.close();
		</script>	
<%
	}
}else {	
	String[] params = new String[10];
	params[0] = loginAccept;
	params[1] = "";
	params[2] = "e743";
	params[3] = loginNo;
	params[4] = loginPwd;
	params[5] = "";
	params[6] = "";
	params[7] = fileName;
	params[8] = iPAddr;
	params[9] = filePath;
%>		
	<wtc:service name="sFileTrans" routerKey="region" routerValue="<%=regionCode%>"
				 retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=params[0]%>"/>
			<wtc:param value="<%=params[1]%>"/>
			<wtc:param value="<%=params[2]%>"/>
			<wtc:param value="<%=params[3]%>"/>
			<wtc:param value="<%=params[4]%>"/>
			<wtc:param value="<%=params[5]%>"/>
			<wtc:param value="<%=params[6]%>"/>
			<wtc:param value="<%=params[7]%>"/>
			<wtc:param value="<%=params[8]%>"/>
			<wtc:param value="<%=params[9]%>"/>
	</wtc:service>
	<wtc:array id="ret" scope="end"/>

<%
	if("000000".equals(retCode)) {
	  response.reset();//可以加也可以不加
      response.setContentType("application/x-download");
      String filedownload = fullFileName;
      String filedisplay = fileName;
      response.addHeader("Content-Disposition","attachment;filename=" + filedisplay);

      OutputStream outp = null;
      FileInputStream in = null;
      try {
          outp = response.getOutputStream();
          in = new FileInputStream(filedownload);

          byte[] b = new byte[1024];
          int i = 0;

          while((i = in.read(b)) > 0)
          {
              outp.write(b, 0, i);
          }
          outp.flush();
      } catch(Exception e) {
          System.out.println("Error!");
          e.printStackTrace();
%>
		<script>
			alert("文件下载失败");
		</script>
<%	
      }finally {
          if(in != null)
          {
              in.close();
              in = null;
          }
          if(outp != null)
          {
              outp.close();
              outp = null;
          }
      }
	}else {
		System.out.println("------liujian--------------retCode=" + retCode);
%>
		<script>
			alert("错误代码：<%=retCode%>，错误信息：<%=retMsg%>");
			window.close();
		</script>
<%		
	}
}
%>


<%!
	public String setCoorCompSubmitFileCont(String path,JSONObject jo,String e743path)throws Exception {
		WritableWorkbook workbook = null;
		Workbook wb = null;
		String newFileName = createNewFileName();
		try{
		    // 获得原始文档   
		    wb = Workbook.getWorkbook(new File(e743path + "/submit_create.xls")); 
		    // 创建一个可读写的副本
		    workbook = Workbook.createWorkbook(new File(path + newFileName),wb); 
		    WritableSheet ws = workbook.getSheet(0);
		    JSONArray ja = jo.getJSONArray("UserList");
	       	for(int i=0;i<ja.length();i++) {
	       		JSONObject jo2 = ja.getJSONObject(i);
	       		int j = i+2; 
	       		for (Iterator iter = jo2.keys(); iter.hasNext();) {
	       		    String key = (String)iter.next();
	       		    if(key != null && "MSISDN".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,0,j,true);
	       		    }else if(key != null && "NameMatch".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,1,j,true);
	       		    }else if(key != null && "CurrFeePlan".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,2,j,false);
	       		    }else if(key != null && "UserStatus".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,3,j,false);
	       		    }
	       		}
	       	}
	       	workbook.write();
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}finally{
            workbook.close();
            wb.close();
		}
		return newFileName;
	}
	 
	public String setCoorCompOpenFileCont(String path,JSONObject jo,String e743path) throws Exception{
		WritableWorkbook workbook = null;
		Workbook wb = null;
		String newFileName = createNewFileName();
		try{
		    // 获得原始文档   
		    wb = Workbook.getWorkbook(new File(e743path + "/open_create.xls")); 
		    // 创建一个可读写的副本
		    workbook = Workbook.createWorkbook(new File(path + newFileName),wb); 
		    WritableSheet ws = workbook.getSheet(0);
		    String jn = (String)jo.get("NewUserFailDesc");
		    Label ln = new Label(1, 1, jn); 
	        ws.addCell(ln);
		    JSONArray ja = jo.getJSONArray("UserList");
	       	for(int i=0;i<ja.length();i++) {
	       		JSONObject jo2 = ja.getJSONObject(i);
	       		int j = i+5;
	       		for (Iterator iter = jo2.keys(); iter.hasNext();) {
	       		    String key = (String)iter.next();
	       		    if(key != null && "MSISDN".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,0,j,true);
	       		    }else if(key != null && "CentrolPayStatus".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,1,j,true);
	       		    }else if(key != null && "EffRule".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,2,j,true);
	       		    }else if(key != null && "AccountName".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,3,j,false);
	       		    }else if(key != null && "FailDesc".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,4,j,false);
	       		    }else if(key != null && "PayType".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,5,j,true);
	       		    }else if(key != null && "PayAmount".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,6,j,true);
	       		    }else if(key != null && "IsNewUser".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,7,j,true);
	       		    }else if(key != null && "FeePlan".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,8,j,false);
	       		    }
	       		}
	       	}
		    workbook.write();
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}finally{
            workbook.close();
            wb.close();
		}
		return newFileName;
	}
	
	public String setHostCompFileCont(String path,JSONObject jo,String e743path) throws Exception{
		WritableWorkbook workbook = null;
		Workbook wb = null;
		String newFileName = createNewFileName();
		try{
		    // 获得原始文档   
		    wb = Workbook.getWorkbook(new File(e743path + "/detail_create.xls")); 
		    // 创建一个可读写的副本
		    workbook = Workbook.createWorkbook(new File(path + newFileName),wb); 
		    WritableSheet ws = workbook.getSheet(0);
		    JSONArray jn = jo.getJSONArray("NewUser");
		    for(int i=0;i<jn.length();i++) {
	       		JSONObject jo2 = jn.getJSONObject(i);
	       		int j = i+1;
	       		for (Iterator iter = jo2.keys(); iter.hasNext();) {
	       			
	       		    String key = (String)iter.next();
	       		    if(key != null && "ProvCode".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,j,1,true);
	       		    }else if(key != null && "NewUserCount".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,j,2,true);
	       		    }else if(key != null && "FeePlan".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,j,3,false);
	       		    }else if(key != null && "PayType".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,j,4,true);
	       		    }else if(key != null && "PayAmount".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,j,5,true);
	       		    }
	       		}
	       	}
		    JSONArray ja = jo.getJSONArray("UserList");
	       	for(int i=0;i<ja.length();i++) {
	       		JSONObject jo2 = ja.getJSONObject(i);
	       		int j = i+9;
	       		for (Iterator iter = jo2.keys(); iter.hasNext();) {
	       		    String key = (String)iter.next();
	       		    if(key != null && "ProvCode".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,0,j,true);
	       		    }else if(key != null && "Msisdn".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,1,j,true);
	       		    }else if(key != null && "FeePlan".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,2,j,false);
	       		    }else if(key != null && "OperCode".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,3,j,true); 
	       		    }else if(key != null && "AccountNameReq".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,4,j,false);
	       		    }else if(key != null && "PayType".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,5,j,true);
	       		    }else if(key != null && "PayAmount".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,6,j,true);
	       		    }else if(key != null && "EffRule".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,7,j,true);
	       		    }
	       		}
	       	}
	       	
		    workbook.write();
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}finally{
            workbook.close();
            wb.close();
		}
		return newFileName;
	}

	public String setCardHostCompFileCont(String path,JSONObject jo,String e743path) throws Exception{
		WritableWorkbook workbook = null;
		Workbook wb = null;
		String newFileName = createNewFileName();
		try{
		    // 获得原始文档   
		    wb = Workbook.getWorkbook(new File(e743path + "/card_detail_create.xls")); 
		    // 创建一个可读写的副本
		    workbook = Workbook.createWorkbook(new File(path + newFileName),wb); 
		    WritableSheet ws = workbook.getSheet(0);
		    JSONArray jn = jo.getJSONArray("NewUser");
		    for(int i=0;i<jn.length();i++) {
	       		JSONObject jo2 = jn.getJSONObject(i);
	       		int j = i+1;
	       		for (Iterator iter = jo2.keys(); iter.hasNext();) {
	       		    String key = (String)iter.next();
	       		    if(key != null && "ProvCode".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,j,1,true);
	       		    }else if(key != null && "NewUserCount".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,j,2,true);
	       		    }else if(key != null && "FeePlan".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,j,3,false);
	       		    }else if(key != null && "ProdInfo".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,j,4,true);
	       		    }
	       		}
	       	}
		    JSONArray ja = jo.getJSONArray("UserList");
	       	for(int i=0;i<ja.length();i++) {
	       		JSONObject jo2 = ja.getJSONObject(i);
	       		int j = i+7;
	       		for (Iterator iter = jo2.keys(); iter.hasNext();) {
	       		    String key = (String)iter.next();
	       		    if(key != null && "ProvCode".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,0,j,true);
	       		    }else if(key != null && "MSISDN".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,1,j,true);
	       		    }else if(key != null && "FeePlan".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,2,j,false);
	       		    }else if(key != null && "ProdInfo".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,3,j,true); 
	       		    }else if(key != null && "OperCode".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,4,j,false);
	       		    }
	       		}
	       	}
	       	
		    workbook.write();
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}finally{
            workbook.close();
            wb.close();
		}
		return newFileName;
	}
	
	public String setCardCoorCompOpenFileCont(String path,JSONObject jo,String e743path) throws Exception{
		WritableWorkbook workbook = null;
		Workbook wb = null;
		String newFileName = createNewFileName();
		try{
		    // 获得原始文档   
		    wb = Workbook.getWorkbook(new File(e743path + "/card_open_create.xls")); 
		    // 创建一个可读写的副本
		    workbook = Workbook.createWorkbook(new File(path + newFileName),wb); 
		    WritableSheet ws = workbook.getSheet(0);
		    String jn = (String)jo.get("NewUserFailDesc");
		    Label ln = new Label(1, 1, jn); 
	        ws.addCell(ln);
		    JSONArray ja = jo.getJSONArray("UserList");
	       	for(int i=0;i<ja.length();i++) {
	       		JSONObject jo2 = ja.getJSONObject(i);
	       		int j = i+5;
	       		for (Iterator iter = jo2.keys(); iter.hasNext();) {
	       		    String key = (String)iter.next();
	       		    if(key != null && "MSISDN".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,0,j,true);
	       		    }else if(key != null && "BusiStatus".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,1,j,true);
	       		    }else if(key != null && "IsNewUser".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,2,j,true);
	       		    }else if(key != null && "ErrDesc".equals(key)) {
	       		    	addExcelCell(jo2.getString(key),ws,3,j,false);
	       		    }
	       		}
	       	}
		    workbook.write();
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}finally{
            workbook.close();
            wb.close();
		}
		return newFileName;
	}
	
	
	
	public void addExcelCell(String value,WritableSheet ws,int i,int j,boolean isNum)throws Exception {
   		if(isNum) {
   			if(value != null && !"".equals(value)) {
	    			//Number number = new Number(i, j,Double.valueOf(value).longValue()); 
	    			Label number = new Label(i, j, value); 
			    	ws.addCell(number); 
	    		}else {
	    			Label label = new Label(i, j, ""); 
		         	ws.addCell(label);
	    		}
   		}else {
   			Label label = new Label(i, j, value); 
         	ws.addCell(label);
   		}
   		
   	}
    
    public String createNewFileName(){
    	return "m_" + new Date().getTime() + ".xls";
    }
	
%>


