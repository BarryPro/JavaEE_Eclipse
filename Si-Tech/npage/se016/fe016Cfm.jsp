<%
  /*
   * 功能: 勋章兑换礼品配置新增 e016
   * 版本: 1.0
   * 日期: 2011/7/5
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%> 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	String opCode = "e016";	
	String opName = "勋章兑换礼品配置新增";	//header.jsp需要的参数   
	//读取session信息	
	String loginNo = (String)session.getAttribute("workNo");    //工号 
	String nopass = (String)session.getAttribute("password");		
	String regionCode = (String)session.getAttribute("regCode"); 
	String loginAccept=getMaxAccept();//获取流水
	String chnSource="01";
	String reginonCodes = request.getParameter("reginonCodes");							//地市代码与领取营业厅拼串
	String giftCode = request.getParameter("giftCode");					//礼品代码
	String giftName = request.getParameter("giftName");		//礼品名称
	String giftDescribe = request.getParameter("giftDescribe");				//礼品描述
	String medalCount = request.getParameter("medalCount");			//扣勋章数
	String startTime = request.getParameter("startTime");	//开始时间
	String endTime = request.getParameter("endTime");		//结束时间 
	String opNote = request.getParameter("opNote");								//备注
	String retMsg = null;
	int countHall=0;    //选取营业厅个数
	String[] dis_halls=reginonCodes.split("/");                    //地市与营业厅格式：地市~若干营业厅
	int len=dis_halls.length;               //地市个数
	
  for(int i=0;i<len;i++)
	{
	  String[] disHalls=dis_halls[i].split("~");
	  String disCodes=disHalls[0];
	  String hallCodes=disHalls[1];
	  int len_hall=hallCodes.split(",").length;
	  countHall=countHall+len_hall;
	}
	String dis_codes[]=new String[countHall];   //地市
  String hall_codes[]=new String[countHall];   //营业厅
  int inter=0;
  for(int i=0;i<len;i++)
  {
	  String[] disHalls=dis_halls[i].split("~");
	  String disCodes=disHalls[0];
	  String hallCodeList=disHalls[1];
	  String[] hallCodes=hallCodeList.split(",");
	  int len_hall=hallCodes.length;
	  for(int j=0;j<len_hall;j++)
	  {
	 	  	if(inter==0)
		  	{
		  		hall_codes[j]=hallCodes[j];
		  		dis_codes[j]=disCodes;
		  		inter=inter+1;
		  	}else
	  		{
	  			hall_codes[inter]=hallCodes[j];
	  			dis_codes[inter]=disCodes;
	  			inter=inter+1;
	  		}
	  } 	  
  }
	/****************调用  sE016Cfm  ***********************/
	%>

	<wtc:service name="sE016Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1"  outnum="2" >
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=chnSource%>"/>		
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=nopass%>"/>			
		<wtc:param value=" "/>
		<wtc:param value=" "/>		
	  <wtc:params value="<%=dis_codes%>"/>								
		<wtc:param value="<%=giftCode%>"/>			
		<wtc:param value="<%=giftName%>"/>	
		<wtc:param value="<%=giftDescribe%>"/>	
		<wtc:param value="<%=medalCount%>"/>						
		<wtc:param value="<%=startTime%>"/>	
		<wtc:param value="<%=endTime%>"/>	
		<wtc:param value="<%=opNote%>"/>	
	  <wtc:params value="<%=hall_codes%>"/>				
	</wtc:service>
	<wtc:array id="result" scope="end" />		
	<%    
	String returnCode="0";  //错误代码	        
	String returnMsg=""; //错误信息
		
	returnCode=retCode1; //错误代码
	returnMsg=retMsg1;//错误信息
	

	if("000000".equals(returnCode)){
		retMsg = "勋章兑换礼品配置新增成功";
		%>
		
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",2);
        window.location="/npage/se016/fe016_login.jsp?opCode=e016&opName=勋章兑换礼品配置新增";
		</script>
	<%}else{
		retMsg = returnMsg;%>
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",0);
		    window.location="/npage/se016/fe016_1.jsp";
		</script>
	<%}
	

%>



