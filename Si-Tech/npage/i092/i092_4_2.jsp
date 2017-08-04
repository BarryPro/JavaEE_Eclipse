
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>

<%
    String opCode = "i092";
	  String opName = "Ç¿ÖÆÔ¤²ð";
	  String workno = (String)session.getAttribute("workNo");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode = org_code.substring(0,2);
	  
	  String op_accept=request.getParameter("op_accept");
		String file_name =workno+"-i092.txt";
		String nameOfTextFile = request.getRealPath("/")+"/npage/tmp/"+file_name ;


	  String ret_val[][];
	  String ret_val_new[][];
	  String[] inParas2 = new String[5];

	  inParas2[0]=workno;
	  inParas2[1]=op_accept;

 		response.setContentType("application/octet-stream");
 		response.setHeader("Content-Disposition","attachment;filename="+file_name);
%>
<wtc:service name="bi092_QryOut" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="13">
		  <wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="mainInfo0"  start="0" length="2" scope="end"/>
<wtc:array id="mainInfo1"  start="2" length="3" scope="end"/>
	
<%
		String errCode = retCode2;
		String errMsg = retMsg2;
	 
		String[][] result1  = null ;
 
		result1 = mainInfo1; 
		

		
		if(retCode2.equals("0")||retCode2.equals("000000"))
		{

			try { 
				PrintWriter pw = new PrintWriter(new FileOutputStream(nameOfTextFile)); 
				 
				for(int i=0;i<result1.length;i++)
				{
					pw.println(result1[i][0]+"|"+result1[i][1]+"|"+result1[i][2]);
				}
				pw.close(); 
			} 
			catch(IOException e) { 
				out.println(e.getMessage()); 
				System.out.println(e.getMessage());
			}	
			
			
			OutputStream outputStream = response.getOutputStream();
			
			FileReader in = new FileReader(nameOfTextFile);
			BufferedReader read  = new BufferedReader(in);;
			String s = "";
			while ((s = read.readLine()) != null) {
						s = s + "\r\n";
						outputStream.write(s.getBytes());
			}
			outputStream.flush();
			outputStream.close();
			read.close();
			in.close();
			outputStream = null;

		}
		else
		{
			%>
				<script language="javascript">
					rdShowMessageDialog(retMsg2);
					window.location.href="i092_4.jsp";
				</script>
			<%
		}
%>	 
 
 


