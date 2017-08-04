<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%
   String retType = WtcUtil.repNull(request.getParameter("retType"));
%>
	<wtc:service name="sRK160SelAll" outnum="7">
	</wtc:service>
	<wtc:array id="row0"  start="0"  length="2" scope="end"/>	
	<wtc:array id="rows1"  start="2"  length="2" scope="end"/>	
	<wtc:array id="rows2"  start="4"  length="3" scope="end"/>
	<%
	  if(row0[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "查询失败";
	  }
	 String path=request.getRealPath("/");  
	 path=path+"/njs/csp/";
	  try
     {
     
				 File f=new File(path,"relation.js"); 
				 if(!f.exists())
				 {
				 		f.createNewFile();	
					}
					FileWriter filewriter  =   new  FileWriter(f);
          java.io.RandomAccessFile file =new  java.io.RandomAccessFile(path+"/relation.js", "rw" );
          file.setLength(0);
					//写入文件
					for(int i=0;i<rows1.length;i++)
					{  
						boolean flag=false;
						filewriter.write("var arr_"+rows1[i][0]+"= new Array('"+rows1[i][0]+"',");
					   for(int j=i*(rows1.length-1);j<(i+1)*(rows1.length-1);j++)
					   {
					    if(rows2[j][2].equals("0"))
					    {
					    if(!flag)
					    {
					       filewriter.write("'"+rows2[j][0]+"'");
					       }
					       else
					       {
					       filewriter.write(",'"+rows2[j][0]+"'");
					       }
					       flag=true;
					    }
					   }
					   filewriter.write(");");
					   filewriter.write("\n");
					   filewriter.write("\n");
					} 
          filewriter.close();
          filewriter.flush();
          
					
		}
					
     catch(Exception err)
     {
         System.err.println("ELS - Chart : 文件夹创建发生异常");
         err.printStackTrace();
     }

     
	%>


	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);

