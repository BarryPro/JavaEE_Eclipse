<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.commons.fileupload.*"%>
<html>
<head>
<title>批量开户</title>
</head>
<%
System.out.println("-----------------------------------upLoadFile.jsp-----------------------------------");
String workNo = (String)session.getAttribute("workNo");
String fileName = "";
String phoneText = "";

int rownum = 0;  			//记录读入文件（有效信息）总行数
String remark=" 用户批量开户"; 
String phone_no="";
String sim_no="";
	
String dateStr = new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS").format(new java.util.Date());
DiskFileUpload fu = new DiskFileUpload();    
// 设置最大文件尺寸，这里是4MB
fu.setSizeMax(4194304);
// 设置缓冲区大小，这里是4kb
fu.setSizeThreshold(4096);
// 设置临时目录：一旦文件大小超过getSizeThreshold()的值时数据存放在硬盘的目录
fu.setRepositoryPath(application.getRealPath("")+"/npage/tmp");
//开始读取上传信息
List fileItems = fu.parseRequest(request);
%>
<body>
	<div id="operation">
  <div id="operation_table">
 		<div class="input">
				<%
				
				String[][] result=new String[][]{};
				String iErrorNo ="";
				String sErrorMessage = "";
	
				// 依次处理每个上传的文件
				Iterator iter = fileItems.iterator();
				while (iter.hasNext()) {
				  FileItem item = (FileItem) iter.next();
				  //忽略其他不是文件域的所有表单信息
				  if (!item.isFormField()) {
				   String name = item.getName();
				   long size = item.getSize();
				   if((name==null||name.equals("")) && size==0)
				   continue;
			   //保存上传的文件到指定的目录
				   name = name.replace(':','_');
				   name = name.replace('\\','_');
				   File f = new File(application.getRealPath("")+"/npage/upload",workNo+"_"+dateStr+".txt");
				   fileName = workNo+"_"+dateStr+".txt";
				   System.out.println("----------------------------fileName------------------------"+fileName);
				   item.write(f);
				  }
				  else {
				     String requestName=item.getFieldName();
				     String requestValue=item.getString();
				  }
				}
				
					List list = WtcUtil.readFile(application.getRealPath("")+"/npage/upload",workNo+"_"+dateStr+".txt");
					String sSaveName = request.getRealPath("/npage/upload/")+"/"+workNo+"_"+dateStr+".txt";
					
				try
					{		
					FileReader fr = new FileReader(sSaveName);
					BufferedReader br = new BufferedReader(fr); 
					
					String line2 = null;
					int read_rownum = 0; //用来记录行数，每62行存入文件一次，并将本参数清零		
					int rowlength = 0; //用来记录一行的号码个数，文件中每行号码个数应该一致。
					while((line2=br.readLine())!= null)
					{
					 	String[] phone_sim=line2.split("\\s+");
						if(rownum == 0)
						{
							rowlength=phone_sim.length; //第一行的号码个数
						}
						if(rowlength!=phone_sim.length)
						{
							throw new Exception("[139050]：导入的文件信息格式必须一致：[服务号码]或者[服务号码 sim卡号],不能两者混排 ");
						}
						if(phone_sim.length == 2)
						{
							if(phone_sim[0].length()==11 && (phone_sim[1].length()==19 || phone_sim[1].length()==20))
							{
								sim_no ="SIMCode_Flag";
								read_rownum++;
								rownum++;
								phoneText = phoneText + phone_sim[0] + "|" + phone_sim[1] + "|" + "\n";
							    }	 
							}
						 	else if(phone_sim.length == 1)
						 	{
								if(phone_sim[0].length() == 11)
								{
									read_rownum++;
									rownum++;
									phoneText = phoneText + phone_sim[0] + "\n";
							    }	 
						 	}
									 
							if(read_rownum > 60)//if(read_rownum > 31)
							{
							
							System.out.println("read_rownum=========="+read_rownum);
							
							//在读取文本的循环中，每读31行就写入一次，31是根据服务能接受的最大长度2000和一行的最大长度33计算出来的，以免长度过大,回车"\n"的长度是1
							%> 
						   	<wtc:service name="s2204Write"  outnum="2">
								<wtc:param value="<%=fileName%>"/>
								<wtc:param value="<%=phoneText%>"/>
							</wtc:service>	
							<%
								System.out.println("s2204Write返回值 is "+retCode);
								if(!(retCode.equals("000000")))
								{
								%>
									<script language = 'jscript'>
										rdShowMessageDialog("<%=retMsg%>" + "[" + "<%=retCode%>" + "]" ,0);
										history.go(-1);
									</script>        
								<%}%>
								<%
						   		phoneText="";
						   		read_rownum=0;
							   } 
							}
						   	
							br.close();
						  fr.close();
			    }catch(IOException ie){
			    	iErrorNo = "139050";
					sErrorMessage = "解析文件时出错！";
					%>
					<script language='jscript'>
						rdShowMessageDialog("<%=sErrorMessage%>" + "[" + "<%=iErrorNo%>" + "]" ,0);
						history.go(-1);
				  </script> 
			    <%
			    }
			    catch(Exception ee)
			    {   
			       	int endindex = ee.toString().length();
			      	sErrorMessage = ee.toString().substring(20,endindex);
			    	%>
					    <script language='jscript'>
							rdShowMessageDialog("<%=sErrorMessage%>",0);
							history.go(-1);
					  </script> 
				<%
				}
			    %>
			    <wtc:service name="s2204Write"  outnum="2">
						<wtc:param value="<%=fileName%>"/>
						<wtc:param value="<%=phoneText%>"/>
					</wtc:service>	
				<%
					 System.out.println("s2204Write返回值 is "+retCode);
					 //System.out.println("s2204Write返回信息 is "+retMsg);
					if(!(retCode.equals("000000")))
					{
					%>
						  <script language='jscript'>
								rdShowMessageDialog("<%=retMsg%>" + "[" + "<%=retCode%>" + "]" ,0);
								history.go(-1);
						  </script>        
					<%		
					}
					
						String phoneNoStr = "";
						String simNoStr = "";
						
						for(int i=0;i<list.size();i++) {
							String[] tempArr = (String[])list.get(i);
								phoneNoStr += tempArr[0]+"~";	
								if(tempArr.length >1 && tempArr[1]!= null && tempArr[1]!= ""){											
									simNoStr += tempArr[1]+"~";	
								}
						}
				%>
				
     </div>
    </div>
</div>
<script language="javascript">
	<%
	
	if(!phoneNoStr.equals("")){
	
System.out.println("!!@@@fileName======================"+fileName);	  
	%>
		var phoneNoArray = "<%=phoneNoStr%>".split(",");
		var simNoArray = "<%=simNoStr%>".split(",");
		if(simNoArray.length == 1 || phoneNoArray.length == simNoArray.length){
			window.parent.prodCfm.phoneNoStr.value = "<%=phoneNoStr%>";
			window.parent.prodCfm.simNoStr.value = "<%=simNoStr%>";
			window.parent.prodCfm.psfileName.value = "<%=fileName%>";
			rdShowMessageDialog("导入文件成功");
			window.location="getFile.jsp";
		}
		else{
			rdShowMessageDialog("导入的文件中没有合法的信息，请导入正确的文件" );
			window.location="getFile.jsp";
		}
		if(simNoArray.length == 1 && phoneNoArray.length != 1){
			window.parent.prodCfm.simFlag.value = "x";
		}
	<%}
	else
		{%>
			rdShowMessageDialog("导入的文件中没有合法的信息，请导入正确的文件" );
			window.parent.$("#cfmBtn").attr("disabled",true);
			window.location="getFile.jsp";
	<%}%>
</script>	
</body>
</html>