<%
  /*
   * ����: ѫ�¶һ���Ʒ�������� e016
   * �汾: 1.0
   * ����: 2011/7/5
   * ����: huangrong
   * ��Ȩ: si-tech
   * update:
  */
%> 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	String opCode = "e016";	
	String opName = "ѫ�¶һ���Ʒ��������";	//header.jsp��Ҫ�Ĳ���   
	//��ȡsession��Ϣ	
	String loginNo = (String)session.getAttribute("workNo");    //���� 
	String nopass = (String)session.getAttribute("password");		
	String regionCode = (String)session.getAttribute("regCode"); 
	String loginAccept=getMaxAccept();//��ȡ��ˮ
	String chnSource="01";
	String reginonCodes = request.getParameter("reginonCodes");							//���д�������ȡӪҵ��ƴ��
	String giftCode = request.getParameter("giftCode");					//��Ʒ����
	String giftName = request.getParameter("giftName");		//��Ʒ����
	String giftDescribe = request.getParameter("giftDescribe");				//��Ʒ����
	String medalCount = request.getParameter("medalCount");			//��ѫ����
	String startTime = request.getParameter("startTime");	//��ʼʱ��
	String endTime = request.getParameter("endTime");		//����ʱ�� 
	String opNote = request.getParameter("opNote");								//��ע
	String retMsg = null;
	int countHall=0;    //ѡȡӪҵ������
	String[] dis_halls=reginonCodes.split("/");                    //������Ӫҵ����ʽ������~����Ӫҵ��
	int len=dis_halls.length;               //���и���
	
  for(int i=0;i<len;i++)
	{
	  String[] disHalls=dis_halls[i].split("~");
	  String disCodes=disHalls[0];
	  String hallCodes=disHalls[1];
	  int len_hall=hallCodes.split(",").length;
	  countHall=countHall+len_hall;
	}
	String dis_codes[]=new String[countHall];   //����
  String hall_codes[]=new String[countHall];   //Ӫҵ��
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
	/****************����  sE016Cfm  ***********************/
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
	String returnCode="0";  //�������	        
	String returnMsg=""; //������Ϣ
		
	returnCode=retCode1; //�������
	returnMsg=retMsg1;//������Ϣ
	

	if("000000".equals(returnCode)){
		retMsg = "ѫ�¶һ���Ʒ���������ɹ�";
		%>
		
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",2);
        window.location="/npage/se016/fe016_login.jsp?opCode=e016&opName=ѫ�¶һ���Ʒ��������";
		</script>
	<%}else{
		retMsg = returnMsg;%>
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",0);
		    window.location="/npage/se016/fe016_1.jsp";
		</script>
	<%}
	

%>



