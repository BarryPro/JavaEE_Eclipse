<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>



<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

//----生成权限js文件----

String str="000000";
try{
	String path=request.getRealPath("/");  
	path=path+"/njs/csp/";
     File f=new File(path,"funcRoleRel.js"); 
	if(!f.exists()){
		f.createNewFile();	
	}
	FileWriter filewriter  =   new  FileWriter(f);
     java.io.RandomAccessFile file =new  java.io.RandomAccessFile(path+"/funcRoleRel.js", "rw" );
     //清空js文件
     file.setLength(0);

   String sql_allFunc="select t.funcid  from DCALLQUERYFUNCLIST t where t.is_leaf='Y' and t.is_del='N' ";
   
  // String sql_func="select distinct t.menu_id from DCALLQUERYROLEMENU t ";
   
   
%>
	
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
		<wtc:param value="<%=sql_allFunc%>"/>
</wtc:service>
<wtc:array id="funcs" scope="end" />
	
<%

if(funcs.length>0){
	for(int i=0;i<funcs.length;i++){
		//funcs[i][0] 中保存roleid
		String sql_role="select t.role_id from DCALLQUERYROLEMENU t where t.menu_id=:funcsi0";
		myParams = "funcsi0="+funcs[i][0] ;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:param value="<%=sql_role%>"/>
	<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="roles" scope="end" />
		
		
<%
	
	if(roles.length>0){
	//生成权限角色关系的js文件
     filewriter.write("var "+funcs[i][0]+"_RolesArr=[");
     for(int j = 0; j<roles.length; j++){
     	filewriter.write("'"+roles[j][0]+"'");
     	if(roles.length>1&&j!=roles.length-1){
     		filewriter.write(",");
     	}
     }
     filewriter.write("];\n");

	}else{
		filewriter.write("var "+funcs[i][0]+"_RolesArr=[];\n");
	}
		
	}//end of for(int i==0;i<funcs.length;i++)


}//end of if(funcs.length>0)

	filewriter.flush();
     filewriter.close();
}catch(Exception err){
	str="000001";
         System.err.println("K098-genJs : 文件夹创建发生异常");
         err.printStackTrace();
}
%>
	
	var response = new AJAXPacket();
	response.data.add("retCode","<%=str%>");
	core.ajax.receivePacket(response);

