<%
/*************************************
* 功  能: 4A总开关 e269
* 版  本: version v1.0
* 开发商: si-tech
* 创建者: diling @ 2011-9-16
**************************************/
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="java.util.Date" %>

<%@ page import ="java.text.DateFormat"%>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>
<%
	String opCode=request.getParameter("opcode");
	String opName=request.getParameter("opName");
    String loginNo = (String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String passWord = (String)session.getAttribute("password");
    String ip = (String)session.getAttribute("ipAddr");
    String buttonFlag = request.getParameter("buttonFlag"); //开关标识
    
    /*操作时间*/
	java.util.Date sysdate = new java.util.Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
	String createTime = sf.format(sysdate);
	String vNote=opCode + opName;
%>   
<wtc:service name="se269Cfm" routerKey="region" routerValue="<%=regionCode%>" 
	 retcode="Code" retmsg="Msg" outnum="2" >
        <wtc:param value="0"/>  <%//流水%>
        <wtc:param value="01"/> 
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="<%=passWord%>"/>
        <wtc:param value=" "/>
        <wtc:param value=" "/>
        <wtc:param value="<%=ip%>"/>
        <wtc:param value="<%=buttonFlag%>"/>  
        <wtc:param value="<%=createTime%>"/>  
        <wtc:param value="<%=vNote%>"/>  
</wtc:service>
<wtc:array id="result"  scope="end"/>
<%
String retcode = Code;
String retmsg = Msg;
if(retcode.equals("000000"))
{
	String treasuryPath = request.getRealPath("npage/properties")
		+"/treasury.properties";
	List lSceneId=readKeyValues( "sceneId",treasuryPath  );
	List lScenceNm=readKeyValues( "sceneName",treasuryPath  );
	/*只要金库开关日志,不要总日志:根据opcode来判断
		返回正常需要生成日志 生成文件名*/
	if ( opCode.equals("e768") )
	{
		String fnTm=createTime.substring(0,11);
		
		String fileName=request.getRealPath("/npage/client4A/4aLog")+"/AAAA02.AVL";
		
		/*生成文件内容 1-开启;0-关闭*/
		String fileCont="";	
		/**/
		for ( int i=0;i<lSceneId.size();i++ )
		{
			if ( buttonFlag.equals("1") ) /*开启日志*/
			{
				fileCont+=loginNo+"|"+lSceneId.get(i)+"|"+lScenceNm.get(i)+"|手动||"+createTime+"|1|"+java.net.InetAddress.getLocalHost().getHostAddress() +"|"+ip+"|\n";
			}
			else /*关闭日志*/
			{
				fileCont+=loginNo+"|"+lSceneId.get(i)+"|"+lScenceNm.get(i)+"|手动|"+createTime+"||0|"+java.net.InetAddress.getLocalHost().getHostAddress() +"|"+ip+"|\n";
			}			
		}
		try
		{
			/*创建文件*/
			File file = new File(fileName);
			/*如果文件不存在*/
			if (!file.exists()) 
			{
				/*文件创建 >> 文件创建如果失败*/
				if (!file.createNewFile())
				{
					%>
						<script language='javascript'>
						rdShowMessageDialog("金库开关操作成功,创建金库日志失败!",0);
						window.location = "fe269_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
						</script>
					<%
				} 
			} 				

			FileWriter writer = new FileWriter(fileName, true);
			/*写文件文件*/
			writer.write(fileCont);
			writer.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			%>
				<script language='javascript'>
				rdShowMessageDialog("金库开关操作成功,记录金库日志失败!",0);
				window.location = "fe269_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				</script>
			<%			
		}
	}	

%>
	<script language='javascript'>
	rdShowMessageDialog("操作成功！",2);
	window.location = "fe269_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
}
else
{
%>
	<script language='javascript'>
	rdShowMessageDialog("错误信息：<%=retmsg%><br>错误代码：<%=retcode%>", 0);
	window.location = "fe269_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
}
%>



                                                         



   	

