 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-14 ҳ�����,�޸���ʽ
	********************/
%> 

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String regionCode = (String)session.getAttribute("regCode");   
	String[][] errCodeMsg = null;
	boolean showFlag=false;	//showFlag��ʾ�Ƿ������ݿɹ���ʾ
  	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
	
	String errorCode="444444";
	String errorMsg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	String strArray="var arrMsg; ";  //must 
    
        String verifyType = request.getParameter("verifyType");
	String insql = request.getParameter("sqlBuf");
	String recv_number = request.getParameter("recv_number");
    String param = request.getParameter("params");
    String [] params = param.split("\\|");
    	int recordNum = 0;
    	ArrayList retArray = new ArrayList();
    	//String[][] result = new String[][]{};
    	%>
		<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="<%=recv_number%>">
		  <wtc:param value="<%=insql%>"/>
		 <%
		 		for(int i=0;i<params.length;i++){
		 			System.out.println("yanpx ="+params[i]);
		 %>		
		 		 <wtc:param value="<%=params[i]%>"/>
		 	<%
		 		}
		 %>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
    	<%
		/*SPubCallSvrImpl viewBean = new SPubCallSvrImpl();//ʵ����viewBean
	   
	    	retArray = viewBean.sPubSelect(recv_number,insql);
	    	result = (String[][])retArray.get(0);*/
   
    //�������ʹ�����Ϣ�ڴ˴�ͳһ����.
    if( result == null ){
		valid = 1;
    }else{
        recordNum = result.length;
        System.out.println("result.length====================="+result.length);
        if (result[0][0].trim().length() == 0)
            recordNum = 0;

		if ( recordNum == 0 )
		{
			valid = 2;
			errorMsg = "û���ҵ��û���Ϣ";
 		}else{
			valid = 0;
			errorCode="000000";
			strArray = WtcUtil.createArray("arrMsg",result.length);
		}
	}	
%>

<%=strArray%>
<%////System.out.println(strArray);%>

<% if( valid == 0 ){  %>

<%
for(int i = 0 ; i < recordNum; i ++){
      for(int j = 0 ; j < result[i].length ; j ++){

if(result[i][j].trim().equals("") || result[i][j] == null){
   result[i][j] = "";
}
System.out.println("||---------" + result[i][j].trim() + "-------------||");
%>

arrMsg[<%=i%>][<%=j%>] = "<%=result[i][j].trim()%>";
<%
  }
}
%>


<% } %>


<%////System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>
var response = new AJAXPacket();

response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType","<%= verifyType %>");
response.data.add("retCode","<%= errorCode %>");
response.data.add("retMessage","<%= errorMsg %>");
response.data.add("backArrMsg",arrMsg );

core.ajax.receivePacket(response);


