<%@ page contentType="text/html;charset=gb2312"%>
<%request.setCharacterEncoding("gb2312");%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%

	  int  err_code=0;
		String error_msg="";
		String returnAccept = "";
		Logger logger = Logger.getLogger("f1212_rpc.jsp");
	
		SPubCallSvrImpl callView = new SPubCallSvrImpl();

    String work_no = request.getParameter("work_no");
    String password = request.getParameter("password");
    String op_code = request.getParameter("op_code");
		String CustIdType = request.getParameter("CustIdType");          
		String CustId = request.getParameter("CustId");
		String LoginAccept = request.getParameter("LoginAccept");
		String JspName = request.getParameter("JspName");  
		String IsLogAuthen = request.getParameter("IsLogAuthen");
		String IsLogContact = request.getParameter("IsLogContact");
		String tempString = request.getParameter("tempStr");
		StringTokenizer st = new StringTokenizer(tempString,"|");
		int len = st.countTokens();
		
		System.out.println("len="+len);
		String[]AuthCodeArr = new String[len];
		String[]AuthIdArr = new String[len];
		String[]TempArr = new String[len];
		String TempArr1;
		String [] A;
		
		for(int j=0;j<len;j++){
			TempArr1=st.nextToken();
				A=TempArr1.split(",");		//jdk1.4
				
				/*
				//jdk1.3 modify by wuln
				StringTokenizer functionCode_token = new StringTokenizer(TempArr1, ",");
				int len1 = functionCode_token.countTokens();
				A = new String[len1];
					
				for(int i=0; functionCode_token.hasMoreTokens(); i++)
				{		
					A[i] = functionCode_token.nextToken();
				}
				//end jdk1.3
				*/
				
				//System.out.println("===xxxxxxxxxxxxxxr=== "+A.length);
				if(A.length>1){
						AuthCodeArr[j]=A[0];
						AuthIdArr[j]=A[1];
				}
				else{AuthCodeArr[j]=A[0];
					AuthIdArr[j]="";
				}
			System.out.println("===AuthCodeArr=== "+AuthCodeArr[j]+"==AuthIdArr======"+AuthIdArr[j]);
		}
		
  try
  {	
	String paramsIn[] = new String[9];
   paramsIn[0]=work_no;
   paramsIn[1]=password;
   paramsIn[2]=op_code;
   paramsIn[3]=LoginAccept;
   paramsIn[4]=LoginAccept;
   paramsIn[5]=IsLogAuthen;
   paramsIn[6]=IsLogContact;
   paramsIn[7]=CustIdType;
   paramsIn[8]=CustId;

   ArrayList paraStrIn = new ArrayList();
   paraStrIn.add(paramsIn[0]);
   paraStrIn.add(paramsIn[1]);
   paraStrIn.add(paramsIn[2]);
   paraStrIn.add(paramsIn[3]);
   paraStrIn.add(paramsIn[4]);
   paraStrIn.add(paramsIn[5]); 
   paraStrIn.add(paramsIn[6]);
   paraStrIn.add(paramsIn[7]);
   paraStrIn.add(paramsIn[8]);

 

   
   paraStrIn.add(new String[]{"2"});//默认电子的接触方式。
   paraStrIn.add(new String[]{" "});//sContactReason。
   paraStrIn.add(new String[]{" "});//sContactContent。
   paraStrIn.add(new String[]{"5"});//接触终端界面类型terminate_interface。5:Web。


    if(AuthCodeArr.length!=0)
    {
    	 //paraStrIn.add(AuthCodeArr);
    	 paraStrIn.add(new String[]{"4"});	
    }
    
    if(AuthIdArr.length!=0)
    {
   		paraStrIn.add(AuthIdArr); 
   		
    }

   //返回结果            
   String[] ret = callView.callService("s3781Cfm", paraStrIn, "1");
   
   callView.printRetValue();
   err_code = callView.getErrCode();
   error_msg = callView.getErrMsg();
  
  
		if(err_code == 0)
		{
		   returnAccept = ret[0];
			System.out.println("=======++++++++++++++++++++++++++returnAccept: " + returnAccept);
		}
	else
		{
		System.out.println("err_code=="+err_code);
		}
  }
  catch(Exception e)
  {
	e.printStackTrace();
	logger.error("Call s3781Cfm is Failed!");
  }
%>

	var response = new RPCPacket();
	response.guid ='<%= request.getParameter("guid") %>';
	<% if(err_code == 0){ %>		
	response.data.add("returnAccept","<%=returnAccept%>");
<% } %>	
	response.data.add("errCode","<%=err_code%>");
	response.data.add("errMsg","<%=error_msg%>");
	
	
	response.data.add("rpcflag","true");
	<%System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");%>
	core.rpc.receivePacket(response);
	
