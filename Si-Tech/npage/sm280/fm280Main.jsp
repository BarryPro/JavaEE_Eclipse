<%
/********************
 version v2.0
������: si-tech
update:liutong@20080918
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>


<%
  	/**
  	ArrayList arrSession1 = (ArrayList)session.getAttribute("allArr");
		String[][] temfavStr1=(String[][])arrSession1.get(3);
    String[] favStr1=new String[temfavStr1.length];
    **/

    String[][]  temfavStr1 = (String[][])session.getAttribute("favInfo");
    String[] favStr1=new String[temfavStr1.length];

    String currentTime = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()); //��ǰʱ��
    String sim="readonly";

  for(int i=0;i<favStr1.length;i++){
     favStr1[i]=temfavStr1[i][0].trim();

	}//aegn0G
	if(WtcUtil.haveStr(favStr1,"a090")){
		sim="";
		}
 %>

<%
  request.setCharacterEncoding("GBK");
//	Logger logger = Logger.getLogger("sa220Main.jsp");
  String op_name="�������";
  String op_code = request.getParameter("op_code");
  boolean istestNum=false;

%>
<html>
<head>
<title><%=op_name%></title>
<%
    /**
    SPubCallSvrImpl co=new SPubCallSvrImpl();

    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
 	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String org_code = baseInfoSession[0][16];
    String region_code=org_code.substring(0,2);
    **/
	String opCode= op_code;
	String opName =op_name;
	String work_no =(String)session.getAttribute("workNo");
	String loginName =(String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String region_code = org_code.substring(0,2);
	String regionCode = org_code.substring(0,2);
	String workNo =(String)session.getAttribute("workNo");

	boolean hfrf=false;

 	String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
    String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
    String password = request.getParameter("pname");
    if(op_code.equals("1220")){
    	String[] inParas = new String[2];
    	inParas[0]="select t.phone_type from DBCUSTADM.dTestPhoneMsg t where t.phone_no = :phoneNo";
    	inParas[1]="phoneNo="+srv_no;
    	%>
    	<wtc:service name="TlsPubSelCrm" retcode="retCode1" retmsg="retMsg1" outnum="3">
    		<wtc:param value="<%=inParas[0]%>"/>
    		<wtc:param value="<%=inParas[1]%>"/>
    	</wtc:service>
    	<wtc:array id="result1" scope="end" />
    	<%
    	if(result1==null||result1.length==0){
    		istestNum=false;
		}
		else{
			if("1".equals(result1[0][0])){
				istestNum=true;
			}
			else{
				istestNum=false;
			}
		}
    }
    
//	String smCode=request.getParameter("smCode");
 	ArrayList simStatusArr=new ArrayList();

	String [][]initStr=new String[][]{};
	String [][]errStr=new String[][]{};

	ArrayList retArray = new ArrayList();
    //String[][] result = new String[][]{};

	//String [][]simStatusStr=new String[][]{};
	//String [][]springbz=new String[][]{};
 	//-----------���������-------------
	String oriHandFee="0";
	String oriHandFeeFlag="";

     //-----------���sim��״̬----------
	//String sq1="select trim(sim_status),trim(status_name) from sSimStatus where sim_status='2' or sim_status='3' or sim_status = 'B'";
	//lj. �󶨲���
	String sql_select1 = "select trim(sim_status),trim(status_name) from sSimStatus where sim_status='2' or sim_status='3' or sim_status = 'B'";

	//simStatusArr=co.sPubSelect("2",sq1,"phone",srv_no);
    //simStatusStr=(String[][])simStatusArr.get(0);
    %>
		<wtc:service name="TlsPubSelCrm"  routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code" retmsg="ret_message" outnum="2">
			<wtc:param value="<%=sql_select1%>"/>
		</wtc:service>
		<wtc:array id="simStatusStr" scope="end" />
	<%
	   if(ret_code.equals("0")||ret_code.equals("000000")){
          System.out.println("���÷���sPubSelect in s1220main.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	      if(simStatusStr.length==0){
 	      	 String forwardURL = "fm280.jsp?ReqPageName=s1220Main&activePhone="+srv_no+"&op_code="+op_code+"&retMsg=2";
 	          /*
	 	      if(!response.isCommitted())
	 	      {
	 	          response.sendRedirect("fm280.jsp?ReqPageName=s1220Main&activePhone="+srv_no+"&op_code="+op_code+"&retMsg=2");
	 	          out.close();
	 	          return;
	 	      }
	 	      */
	 	      request.getRequestDispatcher(forwardURL).forward(request,response);
	 	      return;
 	      }else{

 	      }

 	   }else{
 	         	System.out.println(ret_code+"    ret_code");
 	     		System.out.println(ret_message+"    ret_message");
 			   System.out.println("���÷���sPubSelect in s1220main.jsp  ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			   %>
					    <script language='jscript'>
					       rdShowMessageDialog("��ѯ����sPubSelect����ʧ��");
					       parent.removeTab(<%=opCode%>);
				       </script>
				<%
 		}

/*	String sq2="select to_char(count(*)) from dSpringCard a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phoneNo1 and valid_flag='N' and op_code='1442' ";*/

	//simStatusArr=co.sPubSelect("1",sq1,"phone",srv_no);
    //springbz=(String[][])simStatusArr.get(0);
    String [] paraIn = new String[2];
/*    paraIn[0] = sq2;
    paraIn[1]="phoneNo1="+srv_no;*/
    %>

	<%
/*	   if(ret_code1.equals("0")||ret_code1.equals("000000")){
          System.out.println("���÷���sPubSelect in s1220main.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
          System.out.println("springbz="+springbz);

 	   }else{
 	         	System.out.println(ret_code1+"    ret_code1");
 	     		System.out.println(ret_message1+"    ret_message1");
 			   System.out.println("���÷���sPubSelect in s1220main.jsp  ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			   %>
					    <script language='jscript'>
					       rdShowMessageDialog("��ѯ����sPubSelect����ʧ��");
					       parent.removeTab(<%=opCode%>);
				       </script>
				<%
 		}*/
    
    /*ȡdcustres��*/
    String sqlXhzw="select region_code from dcustres t where t.phone_no=:phoneNoRes";
    String [] prmXhzw = new String[2];
    prmXhzw[0]=sqlXhzw;
    prmXhzw[1]="phoneNoRes="+srv_no;
    %>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>"  
		retcode="rcXhzw" retmsg="rmXhzw" outnum="1">
		<wtc:param value="<%=prmXhzw[0]%>"/>
		<wtc:param value="<%=prmXhzw[1]%>"/>
	</wtc:service>
	<wtc:array id="belRes" scope="end" />    
   
 <%
 
 	   if(rcXhzw.equals("0")||rcXhzw.equals("000000"))
 	   {
          System.out.println("1220~~~belRes="+belRes[0][0]);
 	   }
 	   else
 	   {
         	System.out.println(rcXhzw+"    rcXhzw");
     		System.out.println(rmXhzw+"    rmXhzw");
		    System.out.println("���÷���sPubSelect in s1220main.jsp  ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
		   %>
				    <script language='jscript'>
				       rdShowMessageDialog("��ѯ����sPubSelect����ʧ��");
				       parent.removeTab(<%=opCode%>);
			       </script>
			<%
 		}
 
 
 
    String sq8="select substr(belong_code,1,2) from dcustmsg where phone_no=:phoneNo2 ";
    paraIn[0] = sq8;
    paraIn[1]="phoneNo2="+srv_no;

    %>
		<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code1" retmsg="ret_message1" outnum="1">
			<wtc:param value="<%=paraIn[0]%>"/>
			<wtc:param value="<%=paraIn[1]%>"/>
		</wtc:service>
		<wtc:array id="belreg" scope="end" />
	<%
	   if(ret_code1.equals("0")||ret_code1.equals("000000")){
          System.out.println("���÷���sPubSelect in s1220main.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
         // System.out.println("belreg="+belreg[0][0]);

 	   }else{
 	         	System.out.println(ret_code1+"    ret_code1");
 	     		System.out.println(ret_message1+"    ret_message1");
 			    System.out.println("���÷���sPubSelect in s1220main.jsp  ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			   %>
					    <script language='jscript'>
					       rdShowMessageDialog("��ѯ����sPubSelect����ʧ��");
					       parent.removeTab(<%=opCode%>);
				       </script>
				<%
 		}
 	/********* ��ػ��������Ѳ�������  sunaj 2091204*******/
	/**if(!region_code.equals(belreg[0][0]))
	{
		sim="readonly";
	}**/
   /************liucm add 20081223 ���ӿ��г�ֵ��ʶ*****************/

   /***********dujl add at 20100408 for ë�������� begin******/
   //String hlrsql = "SELECT a.hlr_code||'--'||b.hlr_name FROM shlrcode a,shlrcodename b where a.phoneno_head=substr('"+srv_no+"',1,7) and a.region_code='"+belreg[0][0]+"' AND a.hlr_code=b.hlr_code ";
	 //lj. �󶨲���
	 String sql_select2 = "SELECT a.hlr_code||'--'||b.hlr_name "
	 	+"FROM shlrcode a,shlrcodename b , dcustres t "
	 	+"where a.phoneno_head=substr(:srv_no,1,7) and t.phone_no=:srv_no2 "
	 	+"and a.region_code=t.region_code AND a.hlr_code=b.hlr_code";
	 String srv_params2 = "srv_no=" + srv_no+" ,srv_no2="+srv_no ;
	 System.out.println("sql_select2="+sql_select2);
   %>
		<wtc:service name="TlsPubSelCrm"  routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code" retmsg="ret_message" outnum="2">
			<wtc:param value="<%=sql_select2%>"/>
			<wtc:param value="<%=srv_params2%>"/>
		</wtc:service>
		<wtc:array id="hlrcode" scope="end" />
   <%
   /***********dujl add at 20100408 for ë�������� end********/
		String hlrCodeOne = "��";
		if(hlrcode.length > 0){
			hlrCodeOne = hlrcode[0][0];
		}

    String sq3="select to_char(count(*)) from dagtbasemsg where agt_phone=:phoneNo3 and status='Y' ";

    paraIn[0] = sq3;
    paraIn[1]="phoneNo3="+srv_no;
    %>
		<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code1" retmsg="ret_message1" outnum="1">
			<wtc:param value="<%=paraIn[0]%>"/>
			<wtc:param value="<%=paraIn[1]%>"/>
			</wtc:service>
		<wtc:array id="agtmsgbz" scope="end" />
	<%
	   if(ret_code1.equals("0")||ret_code1.equals("000000")){
          System.out.println("���÷���sPubSelect in s1220main.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
         // System.out.println("agtmsgbz="+agtmsgbz[0][0]);

 	   }else{
 	         	System.out.println(ret_code1+"    ret_code1");
 	     		System.out.println(ret_message1+"    ret_message1");
 			   System.out.println("���÷���sPubSelect in s1220main.jsp  ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			   %>
					    <script language='jscript'>
					       rdShowMessageDialog("��ѯ����sPubSelect����ʧ��");
					       parent.removeTab(<%=opCode%>);
				       </script>
				<%
 		}

 	//------------��÷������˳�ʼ����Ϣ����-----------
	//SPubCallSvrImpl im1210=new SPubCallSvrImpl();
	int inputNumber = 3;
	String   outputNumber = "30";
/**
	String  inputParsm [] = new String[inputNumber];
	inputParsm[0] = work_no;
	inputParsm[1] = srv_no;
	inputParsm[2] = op_code;
	**/
  	//String [] initBack = im1210.callService("s1220Init",inputParsm,outputNumber,"phone",srv_no);
  //  int retCode = im1210.getErrCode();
  //	String retMsg = im1210.getErrMsg();
  
    /*������ʵ����ڿ�������BOSS�Ż���������������ñ�start*/
    String groupId =(String)session.getAttribute("groupId");
    String sql_appregionset1 = "select count(*) from sOrderCheck where group_id=:groupids and op_code='m280' and flag='Y' ";
    String sql_appregionset2 = "groupids="+groupId;
    String appregionflag="0";//==0ֻ�ܽ��й�����ѯ��>0���Խ��й�����ѯ���߶���
 %>
 		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeappregion" retmsg="retMsgappregion" outnum="1"> 
			<wtc:param value="<%=sql_appregionset1%>"/>
			<wtc:param value="<%=sql_appregionset2%>"/>
		</wtc:service>  
		<wtc:array id="appregionarry"  scope="end"/>
<%
			if("000000".equals(retCodeappregion)){
				if(appregionarry.length > 0){
					appregionflag = appregionarry[0][0]; 
				}
		}
		/*������ʵ����ڿ�������BOSS�Ż���������������ñ�end*/
 
    String accountType =  (String)session.getAttribute("accountType")==null?"":(String)session.getAttribute("accountType");//1 ΪӪҵ���� 2 Ϊ�ͷ�����
		String sql_sendListOpenFlag = "select count(*) from shighlogin where login_no='K' and op_code='m194'";
		String sendListOpenFlag = "0"; //�·��������� 0���أ�>0����
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
			<wtc:param value="<%=sql_sendListOpenFlag%>"/>
		</wtc:service>  
		<wtc:array id="ret1"  scope="end"/>
<%
		if("000000".equals(retCode1)){
			if(ret1.length > 0){
				sendListOpenFlag = ret1[0][0]; 
			}
		}
		
		String sql_regionCodeFlag [] = new String[2];
	  sql_regionCodeFlag[0] = "select count(*) from shighlogin where op_code ='m195' and login_no=:regincode";
	  sql_regionCodeFlag[1] = "regincode="+regionCode;
		String regionCodeFlag = "N"; //�����Ƿ�ɼ� �·�������ť Y�ɼ���N���ɼ�
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode12" retmsg="retMsg12" outnum="1"> 
			<wtc:param value="<%=sql_regionCodeFlag[0]%>"/>
			<wtc:param value="<%=sql_regionCodeFlag[1]%>"/>
		</wtc:service>  
		<wtc:array id="ret2"  scope="end"/>
<%
		if("000000".equals(retCode12)){
			if(ret2.length > 0){
				if(Integer.parseInt(ret2[0][0]) > 0){
					regionCodeFlag = "Y"; 
				}
			}
		}

String passwd = ( String )session.getAttribute( "password" );
String workChnFlag = "0" ;
%>
<wtc:service name="s1100Check" outnum="30"
	routerKey="region" routerValue="<%=regionCode%>" retcode="rc" retmsg="rm" >
	<wtc:param value = ""/>
	<wtc:param value = "01"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=workNo%>"/>
	<wtc:param value = "<%=passwd%>"/>
		
	<wtc:param value = ""/>
	<wtc:param value = ""/>
</wtc:service>
<wtc:array id="rst" scope="end" />
<%
if ( rc.equals("000000") )
{
	if ( rst.length!=0 )
	{
		workChnFlag = rst[0][0];
	}
	else
	{
	%>
		<script>
			rdShowMessageDialog( "����s1100Checkû�з��ؽ��!" );
			removeCurrentTab();
		</script>
	<%	
	}
}
else
{
%>
	<script>
		rdShowMessageDialog( "<%=rc%>:<%=rm%>" );
		removeCurrentTab();
	</script>
<%
} 
  

    //add by diling for ��ȫ�ӹ��޸ķ����б�
	  String loginPswInput = (String)session.getAttribute("password");
  %>
 			<wtc:service name="s1220Init" routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code2" retmsg="ret_message2"  outnum="33" >
			<wtc:param value=""/>
			<wtc:param value="01"/>
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=loginPswInput%>"/> 
			<wtc:param value="<%=srv_no%>"/>
			<wtc:param value=""/>
			</wtc:service>
			<wtc:array id="initBack" scope="end" />
  <%
 		  if(ret_code2.equals("0")||ret_code2.equals("000000")){
       	   System.out.println("���÷���s1220Init in s1220main.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	     	}else{
 	         	System.out.println(ret_code2+"    ret_code2");
 	     		System.out.println(ret_message2+"    ret_message2");
 			    System.out.println("���÷���s1220Init in pubSysAccept.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			    String forwardURL = "fm280.jsp?ReqPageName=s1220Main&activePhone="+srv_no+"&op_code="+op_code+"&retMsg=101&errCode="+ret_code2+"&errMsg="+ret_message2;
 			    /*
 			    if(!response.isCommitted())
	 	      	{
 			    	response.sendRedirect("fm280.jsp?ReqPageName=s1220Main&activePhone="+srv_no+"&op_code="+op_code+"&retMsg=101&errCode="+ret_code2+"&errMsg="+ret_message2);
 			    	out.close();
 			    	return;
 			    }
 			    */
 			    request.getRequestDispatcher(forwardURL).forward(request,response);
 			    System.out.println("22���÷���s1220InitEx in pubSysAccept.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			    return;
 			}
/********************** add by dujl at 20090724 start ********************************/
 		if((!initBack[0][30].equals("0000"))&&(!initBack[0][30].equals("11")))
  		{
%>
  			<script language="javascript">
  				rdShowMessageDialog("ƽ̨�ڲ�����[<%=initBack[0][30]%>],���ƽ̨���ϻָ����ڼ�������!");
  				removeCurrentTab();
  			</script>
<%
  		}
  		else if(initBack[0][30].equals("0000"))
		{
%>
  			<script language="javascript">
  				var	prtFlag = rdShowConfirmDialog("ȡ���ֳ��ѻ�֧�����ܻ��Ǽ�������?");
  				if(prtFlag==1)
  				{

  				}
  				else
  				{
  					removeCurrentTab();
  				}
  			</script>
<%
  		}
/********************** add by dujl at 20090724 end   ********************************/


	//------------��ȡ��ǰ���ʷ����ƣ�������Ϣ----------
	//SPubCallSvrImpl im1220=new SPubCallSvrImpl();
	int inputNo = 4;
	String   outputNo = "31";
	/**
	String  inParsm [] = new String[inputNo];
	inParsm[0] = work_no;
	inParsm[1] = srv_no;
	inParsm[2] = op_code;
	inParsm[3] = password;
  	String [] initBack1 = im1220.callService("s1270GetMsgView",inParsm,outputNo,"phone",srv_no);
  	**/
  	  %>
 			<wtc:service name="s1270GetMsg" routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code3" retmsg="ret_message3"  outnum="32" >
 			<wtc:param value=""/>
 			<wtc:param value="01"/>
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=loginPswInput%>"/> 
			<wtc:param value="<%=srv_no%>"/>
			<wtc:param value=""/>
			</wtc:service>
			<wtc:array id="initBack1" scope="end" />
    <%
 		  if(ret_code3.equals("0")||ret_code3.equals("000000")){
       	   System.out.println("���÷���s1270GetMsg in s1220main.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
/*			System.out.println("springbz[0][0]="+springbz[0][0]);*/

 	     	}else{
 	         	System.out.println(ret_code3+"    ret_code3");
 	     		System.out.println(ret_message3+"    ret_message3");
 			    System.out.println("���÷���s1270GetMsg in  s1220main.jsp  ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			    if(!response.isCommitted())
	 	      	{
	 	      	/*begin huangrong �޸�ת��fm280.jsp������Ϣ 2010-11-1 10:41*/
 			    	response.sendRedirect("fm280.jsp?ReqPageName=s1220Main&activePhone="+srv_no+"&op_code="+op_code+"&retMsg=101&errCode="+ret_code3+"&errMsg="+ret_message3);
 			    	/*end huangrong �޸�ת��fm280.jsp������Ϣ 2010-11-1 10:41*/
 			    	out.close();
 			    	return;
 			    }
 			}



	String[] twoFlag= new String[2];
	twoFlag[0] = "0";
	twoFlag[1] = "0";

	String existPhoneNo="";

%>
<%
	/* ningtn �Ų��ܼ����� */
	String loginNo =(String)session.getAttribute("workNo");
	String workNoPsw = (String)session.getAttribute("password");
	String[] paraAray4 = new String[7];
	paraAray4[0] = initBack[0][28].trim();
	paraAray4[1] = "01";
	paraAray4[2] = opCode;
	paraAray4[3] = loginNo;
	paraAray4[4] = workNoPsw;
	paraAray4[5] = srv_no;
	paraAray4[6] = "";
	String showText = "";
%>
	<wtc:service name="sAdTermQry" routerKey="regionCode" routerValue="<%=region_code%>"
				 retcode="retCode4" retmsg="retMsg4"  outnum="3" >
		<wtc:param value="<%=paraAray4[0]%>"/>
		<wtc:param value="<%=paraAray4[1]%>"/>
		<wtc:param value="<%=paraAray4[2]%>"/>
		<wtc:param value="<%=paraAray4[3]%>"/>
		<wtc:param value="<%=paraAray4[4]%>"/>
		<wtc:param value="<%=paraAray4[5]%>"/>
		<wtc:param value="<%=paraAray4[6]%>"/>
	</wtc:service>
	<wtc:array id="result4" scope="end" />
<%
	if("000000".equals(retCode4)){
		System.out.println("~~~~����sAdTermQry�ɹ�~~~~");
		if(result4 != null && result4.length > 0){
			showText = result4[0][2];
		}
	}else{
		System.out.println("~~~~����sAdTermQryʧ��~~~~");
%>
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=retCode4%>��������Ϣ��<%=retMsg4%>");
				history.go(-1);
			</script>
<%
	}
%>

<%
String highmsg=(initBack[0][5]).trim();
String ss="�и߶��û�";
	int spos=highmsg.indexOf(ss,0);
	%>


<script language=javascript>
if(<%=spos%>>=0){rdShowMessageDialog("���û����и߶��û���");}

if("<%=agtmsgbz[0][0]%>">"0"){rdShowMessageDialog("���û��ǿ��г�ֵ�û���");}
  core.loadUnit("debug");
  core.loadUnit("rpccore");

  onload=function()
  {
    self.status="";
    document.all.s_oldStatus.focus();
	chgSmCode1220();
		if("<%=op_code%>" == "m280"){
			$("#t_sys_remark").attr("readonly",false);
		}else{
			$("#t_sys_remark").attr("readonly",true);
		}
		
		if("<%=op_code%>" == "m280meishang"){
			if("<%=initBack[0][13].trim()%>"=="���֤") {
					if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y" ){//������ض�����
			
							if("<%=workChnFlag%>" == "1"){ //�������
							$("#sendProjectList").show();
							$("#qryListResultBut").show();
							 if("<%=appregionflag%>"=="0") {//�������app���ñ�����ֻ�ܽ��й�����ѯ��
							 
							 }else {
							 		$("#scan_idCard_two").show();
							 		$("#scan_idCard_two222").show();
							 }
						  }else {//����Ӫҵ��
							 		$("#scan_idCard_two").show();
							 		$("#scan_idCard_two222").show();						  
						  }
					}else{
					
					}
	  }
			
  }
  }

function chgcardtype()

{
	document.all.t_newsimf.value="";
    	document.all.simType.value="";
    	document.all.cardcard.value="";

	 if(document.all.cardtype[1].checked==true)  //�տ�
  	{
  		 var phone = (document.all.srv_no.value).trim();
  		document.all.cardtype_bz.value="k";
  		  		 /****���������ƹ���ȡSIM������****/
  		 /* 
        * diling update for �޸�Ӫҵϵͳ����Զ��д��ϵͳ�ķ��ʵ�ַ�������ڵ�10.110.0.125��ַ�޸ĳ�10.110.0.100��@2012/6/4
        */
  		 path ="http://10.110.0.100:33000/writecard/writecard/writeCardInfo.jsp";
  		 var retInfo1 = window.showModalDialog("<%=request.getContextPath()%>/npage/s1210/Trans.html",path,"","dialogWidth:10;dialogHeight:10;");
  		 
    	retInfo1 = "RESULT=0&OP_ID=100&REQUEST_SOURCE=1&CARD_SERIAL=00000000000000000000&MSISDN=13720017196&ICCID=89860000000000000000&IMSI=400612345678900&PIN1=1234&PIN2=1234&PUK1=12345678&PUK2=12345678&KI=11111111111111111111111111111111";

		 
		 if(typeof(retInfo1) == "undefined")
    	 {
    		 rdShowMessageDialog("�������ͳ���!");
    		return false;
    	 }

    	var chPos;
    	chPosn = retInfo1.indexOf("&");
    	if(chPosn < 0)
    	{
    		rdShowMessageDialog("�������ͳ���!");
    		return false ;
    	}
   		//alert( retInfo1.substring(0,chPos));
    	retInfo1=retInfo1+"&";
    	var retVal=new Array();
    	for(i=0;i<4;i++)
    	{

    		var chPos = retInfo1.indexOf("&");
        	valueStr = retInfo1.substring(0,chPos);
        	var chPos1 = valueStr.indexOf("=");
        	valueStr1 = valueStr.substring(chPos1+1);
        	retInfo1 = retInfo1.substring(chPos+1);
        	retVal[i]=valueStr1;

    	}
    	//alert("retVal[0]"+retVal[0]);
    	if(retVal[0]=="0")
    	{

    		var rescode_str=retVal[2]+"|";

    		//alert("rescode_str"+rescode_str);
    		var rescode_strstr="";
    		//alert("rescode_str="+rescode_str)
    		var chPosm = rescode_str.indexOf("|");
    		for(i=0;i<4;i++)
    		{

    			var chPos1 = rescode_str.indexOf("|");
        		valueStr = rescode_str.substring(0,chPos1);
        		rescode_str = rescode_str.substring(chPos1+1);
        		//alert("rescode_str="+rescode_str)
        		if(i==0 && valueStr=="")
        		{
        			rdShowMessageDialog("�������ͳ���!");
    		 		return false;
        		}
        		//alert("valueStr="+valueStr);
        		if(valueStr!=""){
        			rescode_strstr=rescode_strstr+"'"+valueStr+"'"+",";
        			//alert("rescode_strstr="+rescode_strstr);
        		}

    		}
    		rescode_strstr=rescode_strstr.substring(0,rescode_strstr.length-1);
    		if(rescode_strstr=="")
    		{
    			rdShowMessageDialog("�������ͳ���!");
    		 	return false;
    		}
  			 //alert("rescode_strstr="+rescode_strstr);
  		}
  		else{
  			 rdShowMessageDialog("�������ͳ���!");
    		 return false;
    	}
  		 /****ȡSIM�����ͽ���******/
    		 var path = "/npage/innet/fgetsimno_1104.jsp";
    		 path = path + "?regioncode=" + "<%=belRes[0][0]%>";
    	         path = path + "&phone=" + phone + "&rescode=" + rescode_strstr+ "&pageTitle=" + "����SIM������";

    		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");

    		 if(typeof(retInfo) == "undefined")
    			{	return false;   }

    		var simsim=oneTok(oneTok(retInfo,"~",1));
    		var typetype=oneTok(oneTok(retInfo,"~",2));
    		var cardcard=oneTok(oneTok(retInfo,"~",3));


    		document.all.t_newsimf.value=simsim;
    		document.all.simType.value=typetype;
    		document.all.cardcard.value=cardcard;


			if("10073"==cardcard.trim()){
       	rdShowMessageDialog("��ȥ��m404����ͨ�������շѽ��桱��ȡ�����ѡ�");
       }
       
  	}else{
  		document.all.b_write.disabled=true;
  		document.all.cardtype_bz.value="s";
  	}

}
function writechg(){
	if(document.all.t_newsimf.value==""){
		rdShowMessageDialog("��sim���Ų����ǿ�!");
		return false;
	}
	if(document.all.cardtype_bz.value=="k"){
		var phone = (document.all.srv_no.value).trim();
  			document.all.b_write.disabled=true;
    		 var path = "/npage/innet/fwritecard.jsp";
    		 path = path + "?regioncode=" + "<%=region_code%>";
    		 path = path + "&sim_type=" +document.all.cardcard.value;
    		 path = path + "&sim_no=" +document.all.t_newsimf.value;
    		 path = path + "&op_code=" +"m280";
    		 path = path + "&phone=" + phone + "&pageTitle=" + "д��";
    		 path = path + "&deleteShowCardNoFlag=" +"isDelCardNo"; //add by diling  for ���ڹ��ֹ�˾�����Ż�Զ��д�������������ʾ
    		 path = path + "&selectRegionCode="+"<%=belRes[0][0]%>";
    		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    		  if(typeof(retInfo) == "undefined")
    			{	rdShowMessageDialog("д��ʧ��");
    				//document.all.b_write.disabled=false;
    				document.all.writecardbz.value="1";
    				return false;   }
    		 //rdShowMessageDialog("ssssssssssss");
    		 var retsimcode=oneTok(oneTok(retInfo,"|",1));
    		 var retsimno=oneTok(oneTok(retInfo,"|",2))
    		 var cardstatus=oneTok(oneTok(retInfo,"|",3))
    		 var cardNO=oneTok(oneTok(retInfo,"|",4));
    		 //alert("cardNO="+cardNO);
    		  if(retsimcode=="0"){
    		  	/* �����Ż�BOSS������Ӫ���ִ�в������������@2014/12/29 */
    		  	//rdShowMessageDialog("д���ɹ�");
    		 document.all.writecardbz.value="0";
    		 document.all.t_newsimf.value=retsimno;
    		  	document.all.cardstatus.value=cardstatus;
    		  	document.all.cardNO.value=cardNO;  /****add by sungq******/

    		  	if(cardstatus=="3"){document.all.t_simFeef.value="0";}
    		 }else{rdShowMessageDialog("д��ʧ��");
    		 	//document.all.b_write.disabled=false;
    		 	document.all.writecardbz.value="1";
    		 }
		// rdShowMessageDialog(document.all.writecardbz.value);

	}
	else{
		rdShowMessageDialog("ʵ������д��");
		document.all.b_write.disabled=true;
		return false;
	}
}
// ��ȡ���֤��Ƭ--wanghyd20120426
function getPhoto()
{
	window.open("../innet/fgetIccIdPhoto.jsp?idIccid="+document.all.icc_no.value,"","width="+(screen.availWidth*1-900)+",height="+(screen.availHeight*1-500) +",left=450,top=240,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
}
//wanghyd add at 20120426 for ���֤У��
function checkIccId()
{

	document.all.iccIdCheck.disabled=true;
	var myPacket = new AJAXPacket("/npage/innet/fIccIdCheck.jsp","������֤���֤��Ϣ�����Ժ�......");
	myPacket.data.add("retType","iccIdCheck");
	myPacket.data.add("idIccid",document.all.icc_no.value);
	myPacket.data.add("custName",document.all.cus_name.value);
	myPacket.data.add("IccIdAccept","<%=initBack[0][28].trim()%>");
	myPacket.data.add("opCode",document.all.op_code.value);
	myPacket.data.add("phoneNo","<%=srv_no%>");
	core.ajax.sendPacket(myPacket,docheckICCID);
	myPacket=null;
	document.all.iccIdCheck.disabled=false;
}
function docheckICCID(packet) {
   	//RPC������findValueByName
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage"); 
	if((retCode).trim()=="")
	{
       rdShowMessageDialog("����"+retType+"����ʱʧ�ܣ�");
       return false;
	}
	 if(retType=="iccIdCheck")
	 {
	 	if(retCode == "000000")
	 	{
	 		rdShowMessageDialog("У��ͨ����");
	 		document.all.get_Photo.disabled=false;
	 	}
	 	else
	 	{

	 		retMessage = retCode + "��"+retMessage;	
			rdShowMessageDialog(retMessage);

	 	}
	 }

}
//----------------��֤���ύ����-----------------
function printCommit()
{

		if("<%=op_code%>" == "m280meishang"){
			if("<%=initBack[0][13].trim()%>"=="���֤") {
					if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y" ){//������ض�����
							if("<%=workChnFlag%>" == "1"){ //�������
							$("#sendProjectList").show();
							$("#qryListResultBut").show();
							 if("<%=appregionflag%>"=="0") {//�������app���ñ�����ֻ�ܽ��й�����ѯ��
							 
								if(($("#isQryListResultFlag").val() == "N")){ //�Ѳ�ѯ�����б����·���������Ϊ���������У��
									rdShowMessageDialog("���Ƚ��й��������ѯ���ٽ���ȷ�ϲ�����");
							    return false;		
								}
				
							 }else {
							 
							 		if($("#hqdcusticcid").val().trim()==""){
									rdShowMessageDialog("���Ƚ��й��������ѯ��������ٽ���ȷ�ϲ�����");
							    return false;																 			
							 		}

							 }
						  }else {//����Ӫҵ��
							 		if($("#hqdcusticcid").val().trim()==""){
									rdShowMessageDialog("���Ƚ��ж������ٽ���ȷ�ϲ�����");
							    return false;																 			
							 		}				  
						  }
						  if($("#hqdcusticcid").val().trim()!="<%=initBack[0][14].trim()%>"){
									rdShowMessageDialog("��ȡ��֤�������ԭ֤�����벻һ�£����ܽ��л���������");
							    return false;							  
						  }
					}
	  }
			
  }

	/*zhangyan add*/

	if ("<%=initBack[0][31]%>"=="0")
	{
		if (  !(document.all.cardtype[1].checked==true )  )
		{
			rdShowMessageDialog("���������Я��ת��������ֻ��ѡ��տ�!",0);
			return false;
		}
	}
	getAfterPrompt();
	// in here form check
	// begin huangrong add ��֤sim���Ѳ���Ϊ��
	if((document.all.t_simFeef.value.trim().length==0)){
		 	rdShowMessageDialog("sim���Ѳ���Ϊ��!");
		 	return false;
 	}
 	// end huangrong add ��֤sim���Ѳ���Ϊ��
	 if((document.all.writecardbz.value!="0") && (document.all.cardtype_bz.value=="k")){
 	rdShowMessageDialog("д��δ�ɹ�����ȷ��!");
 	return false;

 }
 	
	 <%if(istestNum&&opCode.equals("m280")){%>
	 	var oaNum = $("#oaNum").val().trim();
	   	if(oaNum==""){
	 		rdShowMessageDialog("OA��Ų���Ϊ��!");
	 	    return false;
	 	}
		<%}%>
 
 	
 	
	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
}

 function showPrtDlg(printType,DlgMessage,submitCfm)
 {
	 if((document.all.assuId.value).trim().length>0)
	 {
        if(document.all.assuId.value.length<5)
		{
          rdShowMessageDialog("֤�����볤������(����5λ)��");
	      document.all.assuId.focus();
		}
	 }

     if(check(frm))
     {
     		/* diling add for �������뿪��BOSS1220�������汸ע��Ϣ������@2014/11/4  */
     		if(document.all.t_sys_remark.value == ""){
     			document.all.t_sys_remark.value="�û�"+"<%=initBack[0][1].trim()%>"+"<%=op_name%>";
     		}

		 if((document.all.t_op_remark.value).trim().length==0)
      {
			  if("<%=op_code%>" == "m280"){
			  	document.all.t_op_remark.value=document.all.t_sys_remark.value;
			  }else{
			  	document.all.t_op_remark.value="����Ա<%=work_no%>"+"���û�"+"<%=initBack[0][1].trim()%>"+"���� "+"<%=op_name%>";	
			  }

	  }
	  if("<%=op_code%>" == "m280"){
	  	document.all.t_op_remark.value=document.all.t_sys_remark.value;
	  }else{
	  	document.all.t_op_remark.value="����Ա<%=work_no%>"+"���û�"+"<%=initBack[0][1].trim()%>"+"���� "+"<%=op_name%>";
	  }
	   if((document.all.assuNote.value).trim().length==0)
      {
			  document.all.assuNote.value="����Ա<%=work_no%>"+"���û�"+"<%=initBack[0][1].trim()%>"+"����"+"<%=op_name%>";

	  }

		//��ʾ��ӡ�Ի���
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var pType="subprint";
		var billType="1";
		var printStr = printInfo(printType);

		var mode_code=null;
		var fav_code=null;
		var area_code=null;
		var sysAccept = "<%=initBack[0][28].trim()%>";
		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
		var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=op_code%>&sysAccept="+sysAccept+"&phoneNo=<%=srv_no%>&loginacceptJT="+$("#loginacceptJT").val()+"&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);

		if(typeof(ret)!="undefined")
		{
			if((ret=="confirm")&&(submitCfm == "Yes"))
			{
				if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
				{
					conf();
				}
			}
			if(ret=="continueSub")
			{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ<%=op_name%>��Ϣ��')==1)
				{
					 conf();
				}
			}
		}
		else
		{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ<%=op_name%>��Ϣ��')==1)
			{
				conf();
			}
		}
	 }
 }

function printInfo(printType)
{
  var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";

	cust_info+="�ֻ����룺"+document.all.srv_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cus_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.cus_addr.value+"|";
	cust_info+="֤�����룺"+document.all.icc_no.value+"|";

	opr_info+="�û�Ʒ�ƣ�"+"<%=initBack[0][29].trim()%>"+"  ����ҵ��:�������"+"|";
	opr_info+="������ˮ��"+"<%=initBack[0][28].trim()%>"+"  SIM���ѣ�"+parseFloat(document.all.t_simFeef.value)+"|";
	opr_info+="ԭSIM���ţ�"+"<%=initBack[0][9].trim()%>"+"  ԭSIM������"+"<%=initBack[0][10].trim()%>"+"|";
	opr_info+="��SIM���ţ�"+document.all.t_newsimf.value+"  ��SIM������"+document.all.simType.value+"|";

	note_info1="��ע��"+"|";
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	
	//4G��ĿҪ���޸���� hejwa add 2014��3��6��8:59:57
 //note_info4+=""+"|";
// note_info4+="4G��������ʾ��"+"|";
// note_info4+="1���й��ƶ�4Gҵ����ҪTD-LTE��ʽ�ն�֧�֣�������֧��4G���ܵ�USIM������ͨ4G�����ܣ�"+"|";
// note_info4+="2���ͻ�����ʱѡ�û����֧��4G����USIM��ʱ����ͬʱ��ͨ4G�����ܣ�"+"|";
// note_info4+="3��4G���ٽϿ죬����ߵ�λ�ײͿ������ܸ���������Żݣ�"+"|";
// note_info4+="4��4Gҵ�����4G���������ǵķ�Χ���ṩ���й��ƶ�����������4G����������߷���������"+"|";
	//retInfo+="�����������û���SIM���۳�����30���ڣ����ڷ���Ϊԭ�������SIM���𻵻���������"+"|";
	//retInfo+="�����SIM�޷�ʹ�ã��ҹ�˾��Ϊ����Ѳ�����"+"|";
    return retInfo;
}

 //--------3---------��֤��ťר�ú���-------------
 function chkSim(phoneNo,simOldNo,simNewNo)
 {
	if((document.all.t_newsimf.value).trim().length==0)
	{
      rdShowMessageDialog("��SIM���Ų���Ϊ�գ�");
	  document.all.t_newsimf.value="";
	  document.all.t_newsimf.focus();
	  return false;
	}
		var idsd_no = <%=initBack[0][1].trim()%>;
	var smtypesd =(document.all.t_newsimf.value).trim();
	var myPacketsd = new AJAXPacket("<%=request.getContextPath()%>/npage/s1210/checkWLYXLR.jsp","������֤��SIM���ͣ����Ժ�......");
	myPacketsd.data.add("id_no",idsd_no);
	myPacketsd.data.add("t_newsimf",smtypesd);
	myPacketsd.data.add("phoneNo",phoneNo);
	myPacketsd.data.add("simOldNo",simOldNo);
	myPacketsd.data.add("simNewNo",simNewNo);
	core.ajax.sendPacket(myPacketsd,checksimtypesd);
	myPacketsd=null;
	
  	var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/s1210/chgSim1220.jsp","������֤��SIM���ţ����Ժ�......");
	myPacket.data.add("phoneNo",phoneNo);
	myPacket.data.add("simOldNo",simOldNo);
	myPacket.data.add("simNewNo",simNewNo);
	myPacket.data.add("orgCode", document.all.orgCode.value);
	myPacket.data.add("cardsim_type",document.all.cardcard.value);
	
	var smCodeDivHtml = $.trim($("#smCodeDiv").html());
	var simTypeOne = $("select[name='simTypeOne']").find("option:selected").val();
	if( smCodeDivHtml == "��ͨe�̻�"){
		myPacket.data.add("simTypeOne",simTypeOne);
	}else{
		myPacket.data.add("simTypeOne","");
	}
	
	var cardtype="";
	if(document.all.cardtype[1].checked==true){
		document.all.cardtype_bz.value="k";
		cardtype="k";}
	else{	document.all.cardtype_bz.value="s";
		cardtype="s";
	}

	myPacket.data.add("cardtype",cardtype);

	core.ajax.sendPacket(myPacket);
	myPacket=null;
 }

 function checksimtypesd(packet) {
 var simtypesz = packet.data.findValueByName("simtypesz");
 //alert(simtypesz)
 var phoneNo = packet.data.findValueByName("phoneNo");
 var simOldNo = packet.data.findValueByName("simOldNo");
 var simNewNo = packet.data.findValueByName("simNewNo");
 
 var sim_type_code = packet.data.findValueByName("sim_type_code");
       if("10073"==sim_type_code){
       	rdShowMessageDialog("��ȥ��m404����ͨ�������շѽ��桱��ȡ�����ѡ�");
       } 
 
 		if(simtypesz=="wlyxlr") {//������������Ƚ���ͻ�������ʾ
 		rdShowMessageDialog("���û������Ƚ����û��������ר�õ�sim���������ʹ��ר�õ�sim�������û�������ʹ�����Ƚ������");
 		}
 		else {
 		}
 }
 //--------3---------��֤��ťר�ú���-------------
 function chgSmCode1220()
 {
    if("<%=op_code%>"=="m280")
    {
		if((document.all.srv_no.value).trim().length==0)
		{
		  return true;
		}
		else
		{
		  if(document.all.srv_no.value.length!=11) return false;
		}

		var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/s1210/chSmCode1220_rpc.jsp","���ڻ��ҵ��Ʒ�ƣ����Ժ�......");
		myPacket.data.add("srv_no",(document.all.srv_no.value).trim());
		myPacket.data.add("verifyType","smcode");
		core.ajax.sendPacket(myPacket);
		myPacket=null;
    }
	else
    {
		if(frm.cus_pass.disabled){frm.qryPage.focus();}else{frm.cus_pass.focus();}
	}
 }

 function doProcess(packet)
 {
	var verifyType = packet.data.findValueByName("verifyType");

	if(verifyType == "smcode" )
	{
		var smCode=packet.data.findValueByName("smCode");
 		document.getElementById("smCodeDiv").innerHTML = smCode;
 		$("#simCodeHide").val(smCode);
 		if(smCode == "��ͨe�̻�"){
 			$("#simTypeOneShowHide").show();
 		}else{
 			$("#simTypeOneShowHide").hide();
 		}
	}
    else
	{
		var errCode=packet.data.findValueByName("errCode");
		var errMsg=packet.data.findValueByName("errMsg");
		var simFee=packet.data.findValueByName("simFee");
		var nomalchg4gflag=packet.data.findValueByName("nomalchg4gflag");
		
		var simType=packet.data.findValueByName("simType");
		/*liujian 2012-12-25 15:15:58 �״ΰ�������� begin*/
		var changeType=packet.data.findValueByName("changeType");	
		if(changeType == 'N') {
			$('#changeType').val('N');
			//����sim����Ϊ0
			simFee = '0';
			rdShowMessageDialog("�ÿͻ�ΪSIM�������쳣�ͻ������β������!");
		}else {
			$('#changeType').val('Y');	
		}
		/*liujian 2012-12-25 15:15:58 �״ΰ�������� over*/
		self.status="";

		if(parseInt(errCode)!=0)
		{
		  //rdShowMessageDialog("SIM����֤����");
		  rdShowMessageDialog("����"+errCode+"��"+errMsg);
		  document.all.t_newsimf.value="";
		  document.all.t_newsimf.focus();
		}
		else
		{
		  document.all.t_simFeef.value=(simFee).trim();
		  document.all.simType.value=(simType).trim();
		  document.all.oriSimFee.value=(simFee).trim();
		  
		  if(nomalchg4gflag=="Y") {//�û��ɷ�4GSIM������Ϊ4GSIM������SIM����Ĭ��Ϊ0Ԫ
		  document.all.t_simFeef.value='0';
		  }
		  
		  if((document.all.t_simFeef.value).trim().length==0)
		  document.all.t_simFeef.value="0.00";
		  if((document.all.simType.value).trim().length=="")
		  document.all.simType.value="";
		  if((document.all.oriSimFee.value).trim().length==0)
		  document.all.oriSimFee.value="0.00";
		  document.all.t_simFeef.focus();
		  document.all.t_simFeef.select();

		  document.all.b_print.disabled=false;

		  if(document.all.cardtype_bz.value=='k'){
			  document.all.b_write.disabled=false;

		  }
		  document.all.t_newsimf.disabled=true;
		}
	}
 }
 
  /*2014/04/04 11:02:20 gaopeng ���ù�����ѯ����Ʒ��sm_code*/
	function getPubSmCode(myNo){
			var getdataPacket = new AJAXPacket("/npage/public/pubGetSmCode.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("phoneNo",myNo);
			getdataPacket.data.add("kdNo","");
			core.ajax.sendPacket(getdataPacket,doPubSmCodeBack);
			getdataPacket = null;
	}
	function doPubSmCodeBack(packet){
		retCode = packet.data.findValueByName("retcode");
		retMsg = packet.data.findValueByName("retmsg");
		smCode = packet.data.findValueByName("smCode");
		if(retCode == "000000"){
			$("#pubSmCode").val(smCode);
		}
	}

 function conf()
 {
 	var vPhoneNo = $.trim(document.all.srv_no.value);
 	getPubSmCode(vPhoneNo);
 	var pubSmCode = $("#pubSmCode").val();
 	/*gaopeng 2013/4/2 ���ڶ� 18:34:04 ���������� �ж���205 206��ͷ�����������룬���е���zhangzhea�ķ���sWLWInterFace begin */
	    if(pubSmCode=="PA"||pubSmCode=="PB")
			{
				 var myPacket = new AJAXPacket("/npage/public/sWLWI.jsp", "�����ύ�����Ժ�......");
			    myPacket.data.add("iLoginAccept", document.all.loginAccept.value);							//��ˮ              
			    myPacket.data.add("iChnSource", "01");																					//������ʶ          
			    myPacket.data.add("iOpCode", "1220");												//��������          
			    myPacket.data.add("iLoginNo", "");																							//��������	        
			    myPacket.data.add("iLoginPwd", "");																							//��������	        
			    myPacket.data.add("iPhoneNo", document.all.srv_no.value); 											//�ֻ�����	        
			    myPacket.data.add("iUserPwd", "");																							//��������          
			    myPacket.data.add("iOrgCode", "");																							//���Ź���          
			    myPacket.data.add("iIdNo", document.all.cus_id.value);                        	//�û�ID		        
			    myPacket.data.add("iOldSim", document.all.simOldNo.value);                      //�û���SIM����			
			    myPacket.data.add("iOldSimStatus", document.all.s_oldStatus.value);             //�û���SMI��״̬	  
			    myPacket.data.add("iNewSim", document.all.t_newsimf.value);                     //�û���SIM����	    
			    myPacket.data.add("iNewSimShouldFee", document.all.oriSimFee.value);            //�û���SIM��Ӧ�շ� 
			    myPacket.data.add("iNewSimRealFee", document.all.t_simFeef.value);              //�û���SIM��ʵ�շ� 
			    myPacket.data.add("iHandShouldFee", document.frm.oriHandFee.value);             //�û�������Ӧ��		
			    myPacket.data.add("iHandRealFee", document.frm.t_handFee.value);                //�û�������ʵ��	  
			    myPacket.data.add("iSystemNote", document.frm.t_sys_remark.value);              //ϵͳ��ע          
			    myPacket.data.add("iOpNote", document.frm.t_op_remark.value);                   //�û���ע          
			    myPacket.data.add("iIpAddr", document.frm.ipAdd.value);                         //IP��ַ            
			    myPacket.data.add("iCardBZ", document.frm.cardtype_bz.value);                   //д��״̬          
			    myPacket.data.add("iCardStatus", document.frm.cardstatus.value);                //�տ�״̬          
			    myPacket.data.add("iCardNo", document.frm.cardNO.value);                   			//�տ�����          
			    myPacket.data.add("iTransConId", "");                    												//ת���ʻ�          
			    myPacket.data.add("iTransMoney", "");                														//ת����          
			    myPacket.data.add("iTransPhoneNo", "");                													//ת���ֻ���        
			    myPacket.data.add("iTurnPhoneNo", "");                      										//ת����Դ����      
			    myPacket.data.add("iTurnType", "");                                      				//ת����Դ��������  
			    myPacket.data.add("iRemindPhone", "");                                          //Ƿ�����Ѻ���(��diling��ôȡ�ģ�Ŀǰ������)	    
			    
			    core.ajax.sendPacket(myPacket,retsWLWI);
			    
			    myPacket=null;
					
			}
 	else{
   frm.action="fm280_conf.jsp";
   document.all.t_newsimf.disabled=false;
   frm.submit();
	 }
 }
	function retsWLWI(packet)
{
	 var errCode = packet.data.findValueByName("errCode");
   var errMsg = packet.data.findValueByName("errMsg");
   if(errCode=="000000")
   {
	   	rdShowMessageDialog("�������û�������Ϣ�Ѿ����ͼ��Ź�˾������ͨ�������Ϊ������ҵ��");
	   	removeCurrentTab();
   }
   else
   	{
   		rdShowMessageDialog("�������û�������Ϣ����ʧ�ܣ�"+errCode + "[" + errMsg + "]",0);
   		removeCurrentTab();
   	}
   
}
 //-------6--------ʵ����ר�ú���----------------
function ChkHandFee()
 {
   if((document.all.oriHandFee.value).trim().length>=1 && (document.all.t_handFee.value).trim().length>=1)
   {
	 if(parseFloat(document.all.oriHandFee.value)<parseFloat(document.all.t_handFee.value))
	 {
	   rdShowMessageDialog("ʵ�������Ѳ��ܴ���ԭʼ�����ѣ�");
	   document.all.t_handFee.value=document.all.oriHandFee.value;
	   document.all.t_handFee.select();
	   document.all.t_handFee.focus();
	   return;
	 }
   }

   if((document.all.oriHandFee.value).trim().length>=1 && (document.all.t_handFee.value).trim().length==0)
   {
	 document.all.t_handFee.value="0";
   }
 }
  function ChkSimFee()
 {
   if((document.all.t_simFeef.value).trim().length>=1)
   {
	 if(parseFloat(document.all.oriSimFee.value)<parseFloat(document.all.t_simFeef.value))
	 {
	  rdShowMessageDialog("ʵ��SIM���Ѳ��ܴ���ԭʼSIM���ѣ�");
	  document.all.t_simFeef.value=document.all.oriSimFee.value;
	  document.all.t_simFeef.select();
	  document.all.t_simFeef.focus();
	  return;
	 }
   }

   if((document.all.oriSimFee.value).trim().length>=1 && (document.all.t_simFeef.value).trim().length==0)
   {
	 document.all.t_simFeef.value="0";
   }
 }
function getFew()
{
  if(window.event.keyCode==13)
  {
    var fee=document.all.t_handFee
	var simFee = document.all.t_simFeef;
    var fact=document.all.t_factFee;
    var few=document.all.t_fewFee;
    if((fact.value).trim().length==0)
    {
	  rdShowMessageDialog("ʵ�ս���Ϊ�գ�");
	  fact.value="";
	  fact.focus();
	  return;
    }
    if(parseFloat(fact.value)<parseFloat(fee.value) + parseFloat(simFee.value))
    {
  	  rdShowMessageDialog("ʵ�ս��㣡");
	  fact.value="";
	  fact.focus();
	  return;
    }

	var tem1=((parseFloat(fact.value)-parseFloat(fee.value)-parseFloat(simFee.value))*100+0.5).toString();
	var tem2=tem1;
	if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
    few.value=(tem2/100).toString();
    few.focus();
  }
}
/* ningtn �Ų��ܼ����� */
	$(document).ready(function(){
		var showtext = "<%=showText%>";
		var showMsgObj = $("#showMsg");
		showMsgObj.hide();
		if(showtext.length > 0){
			showMsgObj.children("div").text(showtext);
			showMsgObj.show();
		}
	});
	
	
	
	     	
     	//�·�����
		  function sendProLists(){
				var packet = new AJAXPacket("/npage/sq100/fq100_ajax_sendProLists.jsp","���ڻ�����ݣ����Ժ�......");
				packet.data.add("opCode","<%=opCode%>");
				packet.data.add("phoneNo","<%=srv_no.trim()%>");
				core.ajax.sendPacket(packet,doSendProLists);
				packet = null;
		  } 
		  
		  function doSendProLists(packet){
		  	var retCode = packet.data.findValueByName("retCode");
				var retMsg =  packet.data.findValueByName("retMsg");
				if(retCode != "000000"){
					rdShowMessageDialog( "�·�����ʧ��!<br>������룺"+retCode+"<br>������Ϣ��"+retMsg,0 );
					//��¼Ϊû���
					$("#isSendListFlag").val("N");
				}else{
					rdShowMessageDialog( "�·������ɹ�!" );
					//��¼Ϊ���
					$("#isSendListFlag").val("Y");
				}
		  }
		  
		  //���������ѯ
			function qryListResults(){
				var h=450;
				var w=800;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;status:no;help:no";
				var ret=window.showModalDialog("/npage/sq100/f1100_qryListResults.jsp?opCode=<%=opCode%>&opName=<%=opName%>&accp="+Math.random(),"",prop);
				if(typeof(ret) == "undefined"){
					rdShowMessageDialog("���û�й�����ѯ��������Ƚ����·�����������");
					$("#isQryListResultFlag").val("N");//ѡ���˹�����ѯ���
				}else if(ret!=null && ret!=""){
					$("#isQryListResultFlag").val("Y");//ѡ���˹�����ѯ���
					$("#hqdcustname").val(ret.split("~")[0]); //�ͻ�����
					$("#hqdcusticcid").val(ret.split("~")[1]); //֤������
					$("#loginacceptJT").val(ret.split("~")[4]); //������ˮ
					
				}
			}
			
</script>
</head>
<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">

<form name="frm" method="POST"  onKeyUp="chgFocus(frm)">

	   <%@ include file="/npage/include/header.jsp" %>
 <!-- /* ningtn �Ų��ܼ����� */  -->
<div class="title" id="showMsg">
	<div id="title_zi">

	</div>
</div>
					<div class="title">
						<div id="title_zi"><%=opName%></div>
					</div>


  <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1220Main">
  <input type="hidden" name="srv_no" id="srv_no"  value="<%=srv_no%>">
   <input type="hidden" name="cardcard" id="cardcard">
   <input type="hidden" name="cardNO" id="cardNO">
   <input name=writecardbz type=hidden value="">
   <input name="cardstatus" type=hidden value="">
   <input type="hidden" name="cardtype_bz" id="cardtype_bz" value="s">
  <input type="hidden" name="cus_id" id="cus_id" value="<%=initBack[0][1].trim()%>">
  <input type="hidden" name="cus_name" id="cus_name" value="<%=initBack[0][8].trim()%>">
  <input type="hidden" name="oriHandFee" id="oriHandFee" value="<%=oriHandFee.trim()%>">
  <input type="hidden" name="oriSimFee" id="oriSimFee"  value="">
  <input type="hidden" name="simOldNo" id="simOldNo" value="<%=initBack[0][9].trim()%>">
  <input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
  <input type="hidden" name="icc_no" id="icc_no" value="<%=initBack[0][14].trim()%>">
  <input type="hidden" name="cus_addr" id="cus_addr" value="<%=initBack[0][15].trim()%>">
  <input type="hidden" name="loginAccept" id="loginAccept" value="<%=initBack[0][28]%>">
  <input type="hidden" name="orgCode" id="orgCode" value="<%=org_code%>">
  <!--liujian 2012-12-25 15:17:32 �״ΰ�������� begin-->
  <input type="hidden" name="changeType" id="changeType" value="">
  <!--2015/9/7 9:10:41 gaopeng pubSmCode -->
  <input type="hidden" name="pubSmCode" id="pubSmCode" value="">
  <!--liujian 2012-12-25 15:17:32 �״ΰ�������� over-->
  <%@ include file="../../include/remark.htm" %>

        <table cellspacing="0" >
          <tr>
            <td width="11%" nowrap class="blue">
              <div align="left">��ͻ���־</div>
            </td>
            <td nowrap width="18%">
              <div align="left"><b><font color="red"><%=twoFlag[0]%></font></b></div>
            </td>
            <td width="11%" nowrap  class="blue">
              <div align="left">���ű�־</div>
            </td>
            <td nowrap height="14">
              <div align="left"><%=twoFlag[1]%></div>
            </td>
            <td nowrap  class="blue">
              <div align="left">�������</div>
            </td>
            <td nowrap height="14"><%=srv_no.trim()%></td>
          </tr>
          <tr>
            <td width="11%" nowrap  class="blue">
              <div align="left">֤������</div>
            </td>
            <td nowrap width="18%">
              <div align="left"><%=initBack[0][13].trim()%></div>
            </td>
            <td width="11%" nowrap class="blue">
              <div align="left">֤������</div>
            </td>
            <td nowrap height="14">
              <div align="left"><%=initBack[0][14].trim()%></div>
            </td>
            <td nowrap  class="blue">
              <div align="left">SIM����</div>
            </td>
            <td nowrap height="14"><%=initBack[0][10].trim()%></td>
          </tr>
          <tr>
            <td width="11%" nowrap class="blue">
              <div align="left">�û�ID</div>
            </td>
            <td nowrap width="18%">
              <div align="left"><%=initBack[0][1].trim()%></div>
            </td>
            <td nowrap width="11%" class="blue">
              <div align="left">�û�����</div>
            </td>
            <td nowrap width="31%">
              <div align="left"><%=initBack[0][8].trim()%></div>
            </td>
            <td nowrap width="11%" class="blue">
              <div align="left">�������hlr</div>
            </td>
            <td nowrap width="18%">
              <!--<div align="left"><%=initBack[0][5].trim()%></div>-->
              <div align="left"><%=hlrCodeOne%></div>
            </td>
          </tr>
          <tr>
            <td width="11%" nowrap  class="blue">
              <div align="left">��ǰԤ��</div>
            </td>
            <td nowrap width="18%" height="2">
              <div align="left"><%=initBack[0][6].trim()%></div>
            </td>
            <td nowrap width="11%"  class="blue">
              <div align="left">��ǰǷ��</div>
            </td>
            <td nowrap width="31%">
              <div align="left"><%=initBack[0][7].trim()%></div>
            </td>
            <td nowrap width="11%" class="blue">
              <div align="left">��ǰ״̬</div>
            </td>
            <td nowrap width="18%">
              <div align="left"><%=initBack[0][3].trim()%></div>
            </td>
          </tr>
		  <tr>
		  	<td nowrap width="11%" class="blue">
              <div align="left">Ʒ��</div>
            </td>
            <td nowrap width="18%">
              <div align="left" id="smCodeDiv"></div>
              <input type="hidden" name="simCodeHide" id="simCodeHide" value="" />
            </td>

			  <td nowrap width="11%"  class="blue">
							<div align="left">��ǰ���ʷ�</div>
			  </td>
				<td nowrap width="31%" >
							<div align="left"><%=initBack1[0][17].trim()%></div>
				</td>
							  <td nowrap width="11%"  class="blue">
							<div align="left"><input type="button" name="iccIdCheck" class="b_text" value="У��" onclick="checkIccId()" ></div>
			  </td>
				<td nowrap width="31%" >
							<div align="left"><input type="button" name="get_Photo" class="b_text"   value="��ʾ��Ƭ" onClick="getPhoto()" disabled></div>
				</td>

		  </tr>
		  <tr>
		  		<td colspan="6">
		  							<input type="button" id="sendProjectList" name="sendProjectList" class="b_text" value="�·�����" onclick="sendProLists()" style="display:none" />                    
                  	&nbsp;&nbsp;&nbsp;
                  	<input type="button" id="qryListResultBut" name="qryListResultBut" class="b_text" value="���������ѯ" onclick="qryListResults()" style="display:none" /> 
                  	&nbsp;&nbsp;&nbsp;   
                  	<input type="button" name="scan_idCard_two" id="scan_idCard_two" class="b_text"   value="����" onClick="Idcard_realUser()" style="display:none">
                    <input type="button" name="scan_idCard_two222" id="scan_idCard_two222" class="b_text"   value="����(2��)" onClick="Idcard2('1')" style="display:none">	
          </td>
		  </tr>
		      <tr style="display:none">
            <td nowrap width="16%" class="blue">
              <div align="left">��ȡ��֤������</div>
            </td>
            <td >
              <div align="left">
                <input type="text" name="hqdcustname" id="hqdcustname" size="20"  readonly class="InputGrey"/>
              </div>
            </td>
             <td nowrap width="16%" class="blue">
              <div align="left">��ȡ��֤������</div>
            </td>
            <td nowrap colspan="5">
              <div align="left">
                <input type="text" name="hqdcusticcid" id="hqdcusticcid" size="20" readonly  class="InputGrey"/>
              </div>
            </td>
          </tr>
          
          <tr>
            <td colspan="6">
              <hr>
            </td>
          </tr>
                <tr style="display:none">
                  <td nowrap width="15%" class="blue">
                    <div align="left">����������</div>
                  </td>
                  <td nowrap width="19%">
                    <input name=assuName class="button"  value="<%=initBack[0][16].trim()%>">
                  </td>
                  <td nowrap width="15%" class="blue">
                    <div align="left">�����˵绰</div>
                  </td>
                  <td nowrap width="18%">
                    <input name=assuPhone class="button"  value="<%=initBack[0][17].trim()%>">
                  </td>
                </tr>
                <tr style="display:none">
                  <td nowrap width="15%" class="blue">
                    <div align="left">������֤������</div>
                  </td>
                  <td nowrap width="18%">
                    <select name="assuIdType" id="assuIdType" index="2">
<%
        //�õ��������

                //String sqlStr ="select trim(ID_TYPE), ID_NAME,ID_NAME from sIdType order by id_type";
                //lj. �󶨲���
								String sql_select3 = "select trim(ID_TYPE), ID_NAME,ID_NAME from sIdType order by id_type";
                //retArray = co.sPubSelect("3",sqlStr,"phone",srv_no);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
                //result = (String[][])retArray.get(0);
                %>
						<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code" retmsg="ret_message" outnum="3">
							<wtc:param value="<%=sql_select3%>"/>
						</wtc:service>
						<wtc:array id="result" scope="end" />
				  <%


			         if(ret_code.equals("0")||ret_code.equals("000000")){
			          System.out.println("���÷���sPubSelect in s1220Main.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
			 	        	if(result.length==0){
			 	            }else{
			 	            	 int recordNum = result.length;
			 	        	      for(int i=0;i<recordNum;i++){
									  if(result[i][0].trim().equals(initBack[0][18].trim()))
					                    out.println("<option class='button' value='" + result[i][0] + "' selected>" + result[i][1] + "</option>");
					 				  else
								       out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
					                }
			 	        	}

			 	     	}else{
			 	         	System.out.println(ret_code+"    ret_code");
			 	     		System.out.println(ret_message+"    ret_message");
			 				System.out.println("���÷���sPubSelect in s1220Main.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");

			 			}

%>
                    </select>
                  </td>
                  <td nowrap width="15%" class="blue">
                    <div align="left">������֤������</div>
                  </td>
                  <td nowrap width="19%">
                    <input name=assuId class="button"  value="<%=initBack[0][19].trim()%>">
                  </td>
                </tr>
                <tr style="display:none">
                  <td nowrap width="15%" class="blue">
                    <div align="left">������֤����ַ</div>
                  </td>
                  <td nowrap colspan="3">
                    <input name=assuIdAddr class="button"  value="<%=initBack[0][20].trim()%>">
                  </td>
                </tr>
                <tr style="display:none">
                  <td nowrap width="15%" class="blue">
                    <div align="left">��������ϵ��ַ</div>
                  </td>
                  <td nowrap colspan="3">
                    <input name=assuAddr class="button"  value="<%=initBack[0][21].trim()%>">
                  </td>
                </tr>
                <tr style="display:none">
                  <td nowrap width="15%" class="blue">
                    <div align="left">�����˱�ע��Ϣ</div>
                  </td>
                  <td nowrap colspan="3">
                    <input name=assuNote0 class="button"  value="<%=initBack[0][22].trim()%>">
                  </td>
                </tr>
                
                <tr style="display:none" id="simTypeOneShowHide">
									<td class="blue">SIM������</td>
									<td colspan="3">
										<select name="simTypeOne" >
											<option value="1" selected>TD�̻�SIM��</option>	
											<option value="0">��TD�̻���SIM��</option>
										</select>	
									</td>
								</tr>
                
                <tr>
                  <td nowrap width="13%" class="blue">
                    <div align="left">�ɿ�SIM����</div>
                  </td>
                  <td nowrap width="35%">
                    <div align="left"><%=initBack[0][9].trim()%></div>
                  </td>
                  <td nowrap width="10%" class="blue">
                    <div align="left">�ɿ�״̬</div>
                  </td>
                  <td nowrap width="35%" colspan="3">

					 <div align="left">
                      <select name="s_oldStatus" index="7">
                        <%
					  for(int i=0;i<simStatusStr.length;i++)
					  {
						  if(i==0)
						  {
					  %>
                        <option value="<%=simStatusStr[i][0].trim()%>" selected><%=simStatusStr[i][1].trim()%></option>
                        <%
						  }
						  else
						  {
					   %>
                        <option value="<%=simStatusStr[i][0].trim()%>"><%=simStatusStr[i][1].trim()%></option>
                        <%
						  }
					  }
					  %>
                      </select>
                      <font color="red">*</font></div>
                  </td>
                </tr>
                <tr>
                  <td nowrap width="18%" class="blue">
                    <div align="left">�¿�SIM����</div>
                  </td>
                  <td nowrap width="35%">
                    <div align="left">
                      <input class="button" type="text" name="t_newsimf" id="t_newsimf" size="20" v_minlength=1 v_maxlength=100  v_type=string v_name="�¿�SIM����" maxlength="20" value="<%=existPhoneNo%>" index="8" onkeyup="if(event.keyCode==13)chkSim((document.all.srv_no.value).trim(),(document.all.simOldNo.value).trim(),(document.all.t_newsimf.value).trim())">
                      <font color="red">*</font>
                      <input  class="b_text" type="button" name="b_tr_normal" value="��֤"  onClick="chkSim((document.all.srv_no.value).trim(),(document.all.simOldNo.value).trim(),(document.all.t_newsimf.value).trim())">
                       <input class="b_text" type="button" name="b_write" value="д��" onmouseup="writechg()" onkeyup="if(event.keyCode==13)writechg()" disabled index="19">
                      <input type="hidden" name="flg_normal" id="flg_normal" value="0">
                    </div>
                  </td>
				  <td nowrap width="19%" colspan="4"> <input type="radio" name="cardtype" value="N" checked onclick="chgcardtype()" index="-4">
                    ʵ��
                    <input type="radio" name="cardtype"   value="Y" onclick="chgcardtype()" index="-3">
                    �տ�</td>

				  </tr>
				  <tr>
                  <td nowrap width="15%" class="blue">
                    <div align="left">SIM����</div>
                  </td>
                  <td nowrap width="19%">
                    <div align="left">

                      <input class="button" type="text" name="t_simFeef" id="t_simFeef" size="10" v_minlength=1 v_maxlength=10  v_type=float  v_name="SIM����"  maxlength="10" onblur="ChkSimFee()" <%=sim%> index="9"  >



                      <font color="red">*</font></div>
				 </td>
 					<td nowrap width="15%" class="blue">SIM������</td>
				 <td colspan="3">
				 	<input class="button" type="text" name="simType" size="20" index="9" readonly="ture"></td>
                  </td>
                </tr>
          <tr>
            <td nowrap width="16%" class="blue">
              <div align="left">������</div>
            </td>
            <td nowrap width="24%">
              <div align="left">
                <input type="text" class="button" name="t_handFee" id="t_handFee" size="16"
	value="<%=(oriHandFee.trim().equals(""))?("0"):(oriHandFee.trim()) %>" v_type=float v_name="������" <%if(hfrf){%>readonly<%}%> onblur="ChkHandFee()" index="10">
              </div>
            </td>
            <td nowrap width="10%" class="blue">
              <div align="left">ʵ��</div>
            </td>
            <td nowrap width="16%">
              <div align="left">
                <input type="text" class="button" name="t_factFee" id="t_factFee" size="16" onKeyUp="getFew()" index="11" v_type=float v_name="ʵ��" <%
	                             if(hfrf)
	                             {
							   %>
								   readonly
							  <%
								 }
							   %>
							   >
              </div>
            </td>
            <td nowrap width="10%" class="blue">
              <div align="left">����</div>
            </td>
            <td nowrap width="24%">
              <div align="left">
                <input type="text" class="button" name="t_fewFee" id="t_fewFee" size="16" readonly>
              </div>
            </td>
          </tr>
          <tr>
            <td nowrap width="16%" class="blue">
              <div align="left">ϵͳ��ע</div>
            </td>
            <td nowrap colspan="2">
              <div align="left">
                <input type="text" class="button" name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=30 />
              </div>
            </td>
            <%if(istestNum&&opCode.equals("m280")){%>
	    		<td class="blue">OA���</td>
	        	<td nowrap colspan="2">
		        	<input class="button"type="text" id="oaNum" name="oaNum" size="17" maxlength="30">
		        	<font color="orange">*</font>
	        	</td>
	    	<%}else{%>
	        	<td nowrap colspan="3"></td>
	    	<%}%>
          </tr>
          <tr style="display:none">
            <td nowrap width="16%" class="blue">
              <div align="left">�û���ע</div>
            </td>
            <td nowrap colspan="5">
              <div align="left">
                <input type="text" class="button" name="t_op_remark" id="t_op_remark" size="60"  v_maxlength=60  v_type=string  v_name="�û���ע" maxlength=60 >
              </div>
            </td>
          </tr>
          <tr style="display:none">
            <td nowrap width="16%" class="blue">�û���ע</td>
            <td nowrap colspan="5">
              <input name=assuNote class="button" v_must=0 v_maxlength=60 v_type="string" v_name="�û���ע" maxlength="60" size=60 index="12" value="">
            </td>
          </tr>
        </table>
        <jsp:include page="/npage/public/hwReadCustCard.jsp">
					<jsp:param name="hwAccept" value="<%=initBack[0][28]%>"  />
					<jsp:param name="showBody" value="11"  />
					<jsp:param name="sopcode" value="<%=opCode%>"  />
				</jsp:include>
      	<table>
          <tr>
            <td nowrap colspan="6" id = "footer">
              <div align="center">
                <input class="b_foot" type="button" name="b_print" value="ȷ��&��ӡ" onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()"  index="13" disabled />
                <input class="b_foot" type="button" name="b_clear" value="���" onClick="frm.reset();" index="14">
                <input class="b_foot" type="button" name="b_back" value="�ر�" onClick="parent.removeTab(<%=opCode%>)" index="15">
              </div>
            </td>
          </tr>
        </table>
			<%@ include file="/npage/include/footer.jsp" %>
			<input type=hidden name="ipAdd" value="<%=request.getRemoteAddr()%>">
			 <input type="hidden" name="isSendListFlag" id="isSendListFlag" value="N" />
			 <input type="hidden" name="isQryListResultFlag" id="isQryListResultFlag" value="N" />
			 <input type="hidden" name="sendListOpenFlag" id="sendListOpenFlag" value="<%=sendListOpenFlag%>" />
			 <input type="hidden" name="loginacceptJT" id="loginacceptJT" />
   </form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>
<script type="text/javascript" language="JavaScript">
var v_printAccept = "<%=initBack[0][28].trim()%>";
	function Idcard_realUser(flag){
		//��ȡ�������֤
		//document.all.card_flag.value ="2";
		
		var picName = getCuTime();
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
		var tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
		var cre_dir = filep1+":\\custID";//����Ŀ¼
		//�ж��ļ����Ƿ���ڣ��������򴴽�Ŀ¼
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);  
		}
		var picpath_n = cre_dir +"\\"+picName+"_"+ document.all.cus_id.value +".jpg";
		
		var result;
		var result2;
		var result3;

		result=IdrControl1.InitComm("1001");
		if (result==1)
		{
			result2=IdrControl1.Authenticate();
			if ( result2>0)
			{              
				result3=IdrControl1.ReadBaseMsgP(picpath_n); 
				if (result3>0)           
				{     
			  var name = IdrControl1.GetName();
				var code =  IdrControl1.GetCode();
			  	document.all.hqdcustname.value =name;//����
					document.all.hqdcusticcid.value =code;//���֤��
					$("#loginacceptJT").val(""); //������ˮ
				}
				else
				{
					rdShowMessageDialog(result3); 
					IdrControl1.CloseComm();
				}
			}
			else
			{
				IdrControl1.CloseComm();
				rdShowMessageDialog("�����½���Ƭ�ŵ���������");
			}
		}
		else
		{
			IdrControl1.CloseComm();
			rdShowMessageDialog("�˿ڳ�ʼ�����ɹ�",0);
		}
		IdrControl1.CloseComm();
	}
	
		function Idcard2(str){
			//ɨ��������֤
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
		tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
		var cre_dir = filep1+":\\custID";//����Ŀ¼
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
		var ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1000);
		if(ret_open!=0){
			ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1001);
		}	
		var cardType ="11";
		if(ret_open==0){
				//�๦���豸RFID��ȡ
				var ret_getImageMsg=CardReader_CMCC.MutiIdCardGetImageMsg(cardType,"c:\\custID\\cert_head_"+v_printAccept+str+".jpg");
				if(ret_getImageMsg==0){
					//����֤������ϳ�
					var xm =CardReader_CMCC.MutiIdCardName;					
					var xb =CardReader_CMCC.MutiIdCardSex;
					var mz =CardReader_CMCC.MutiIdCardPeople;
					var cs =CardReader_CMCC.MutiIdCardBirthday;
					var yx =CardReader_CMCC.MutiIdCardSigndate+"-"+CardReader_CMCC.MutiIdCardValidterm;
					var yxqx = CardReader_CMCC.MutiIdCardValidterm;//֤����Ч��
					var zz =CardReader_CMCC.MutiIdCardAddress; //סַ
					var qfjg =CardReader_CMCC.MutiIdCardOrgans; //ǩ������
					var zjhm =CardReader_CMCC.MutiIdCardNumber; //֤������
					var base64 =CardReader_CMCC.MutiIdCardPhoto;
					var v_validDates = "";

			    	document.all.hqdcustname.value =xm;//����
						document.all.hqdcusticcid.value =zjhm;//���֤��
						$("#loginacceptJT").val(""); //������ˮ
	
				}else{
						rdShowMessageDialog("��ȡ��Ϣʧ��");
						return ;
				}
		}else{
						rdShowMessageDialog("���豸ʧ��");
						return ;
		}
		//�ر��豸
		var ret_close=CardReader_CMCC.MutiIdCardCloseDevice();
		if(ret_close!=0){
			rdShowMessageDialog("�ر��豸ʧ��");
			return ;
		}
		
	}
	  function getCuTime(){
	 var curr_time = new Date(); 
	 with(curr_time) 
	 { 
	 var strDate = getYear()+"-"; 
	 strDate +=getMonth()+1+"-"; 
	 strDate +=getDate()+" "; //ȡ��ǰ���ڣ�������ġ��ա��ֱ�ʶ 
	 strDate +=getHours()+"-"; //ȡ��ǰСʱ 
	 strDate +=getMinutes()+"-"; //ȡ��ǰ���� 
	 strDate +=getSeconds(); //ȡ��ǰ���� 
	 return strDate; //������ 
	 } 
	}
</script>