<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.commons.fileupload.*"%>
<html>
<head>
<title>��������</title>
</head>
<%
System.out.println("-----------------------------------upLoadFile.jsp-----------------------------------");
String workNo = (String)session.getAttribute("workNo");
String fileName = "";
String phoneText = "";

int rownum = 0;  			//��¼�����ļ�����Ч��Ϣ��������
String remark=" �û���������"; 
String phone_no="";
String sim_no="";
	
String dateStr = new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS").format(new java.util.Date());
DiskFileUpload fu = new DiskFileUpload();    
// ��������ļ��ߴ磬������4MB
fu.setSizeMax(4194304);
// ���û�������С��������4kb
fu.setSizeThreshold(4096);
// ������ʱĿ¼��һ���ļ���С����getSizeThreshold()��ֵʱ���ݴ����Ӳ�̵�Ŀ¼
fu.setRepositoryPath(application.getRealPath("")+"/npage/tmp");
//��ʼ��ȡ�ϴ���Ϣ
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
	
				// ���δ���ÿ���ϴ����ļ�
				Iterator iter = fileItems.iterator();
				while (iter.hasNext()) {
				  FileItem item = (FileItem) iter.next();
				  //�������������ļ�������б���Ϣ
				  if (!item.isFormField()) {
				   String name = item.getName();
				   long size = item.getSize();
				   if((name==null||name.equals("")) && size==0)
				   continue;
			   //�����ϴ����ļ���ָ����Ŀ¼
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
					int read_rownum = 0; //������¼������ÿ62�д����ļ�һ�Σ���������������		
					int rowlength = 0; //������¼һ�еĺ���������ļ���ÿ�к������Ӧ��һ�¡�
					while((line2=br.readLine())!= null)
					{
					 	String[] phone_sim=line2.split("\\s+");
						if(rownum == 0)
						{
							rowlength=phone_sim.length; //��һ�еĺ������
						}
						if(rowlength!=phone_sim.length)
						{
							throw new Exception("[139050]��������ļ���Ϣ��ʽ����һ�£�[�������]����[������� sim����],�������߻��� ");
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
							
							//�ڶ�ȡ�ı���ѭ���У�ÿ��31�о�д��һ�Σ�31�Ǹ��ݷ����ܽ��ܵ���󳤶�2000��һ�е���󳤶�33��������ģ����ⳤ�ȹ���,�س�"\n"�ĳ�����1
							%> 
						   	<wtc:service name="s2204Write"  outnum="2">
								<wtc:param value="<%=fileName%>"/>
								<wtc:param value="<%=phoneText%>"/>
							</wtc:service>	
							<%
								System.out.println("s2204Write����ֵ is "+retCode);
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
					sErrorMessage = "�����ļ�ʱ����";
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
					 System.out.println("s2204Write����ֵ is "+retCode);
					 //System.out.println("s2204Write������Ϣ is "+retMsg);
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
			rdShowMessageDialog("�����ļ��ɹ�");
			window.location="getFile.jsp";
		}
		else{
			rdShowMessageDialog("������ļ���û�кϷ�����Ϣ���뵼����ȷ���ļ�" );
			window.location="getFile.jsp";
		}
		if(simNoArray.length == 1 && phoneNoArray.length != 1){
			window.parent.prodCfm.simFlag.value = "x";
		}
	<%}
	else
		{%>
			rdShowMessageDialog("������ļ���û�кϷ�����Ϣ���뵼����ȷ���ļ�" );
			window.parent.$("#cfmBtn").attr("disabled",true);
			window.location="getFile.jsp";
	<%}%>
</script>	
</body>
</html>