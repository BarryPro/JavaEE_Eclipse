<%
/********************
version v2.0
������: si-tech
update:anln@2009-02-25 ҳ�����,�޸���ʽ
********************/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.csp.bsf.pwm.util.*"%>

<%
	//��ȡ�û�session��Ϣ
	
	String workNo=(String)session.getAttribute("workNo");               //����
	String nopass=(String)session.getAttribute("password");             //��½����
	String regionCode=(String)session.getAttribute("regCode");
	String opCode          = request.getParameter("opCode");
	String opType          = request.getParameter("opType");
	String loginNo         = request.getParameter("loginNo");
	String contractPhoneNo = request.getParameter("contractPhoneNo");
	String loginName       = request.getParameter("loginName");
	String loginFlag       = request.getParameter("loginFlag");
	String loginPass       = request.getParameter("loginPass");
	String powerCode       = request.getParameter("powerCode");
	String powerRight      = request.getParameter("powerRight").trim();
	String rptRight        = request.getParameter("rptRight");
	String allowBegin      = request.getParameter("allowBegin");
	String allowEnd        = request.getParameter("allowEnd");
	String expireTime      = request.getParameter("expireTime");
	String tryTimes        = request.getParameter("tryTimes");
	String maintainFlag    = request.getParameter("maintainFlag");
	String validFlag       = request.getParameter("validFlag");
	String orgCode         = request.getParameter("orgCode");
	String deptCode        = request.getParameter("deptCode");
	String lastIpAdd       = request.getParameter("lastIpAdd");
	String reFlag          = request.getParameter("reFlag");
	String otherFlag       = request.getParameter("otherFlag");
	String loginStatus     = request.getParameter("loginStatus");
	String remark          = request.getParameter("remark");
	
	String regionChar      = request.getParameter("regionChar");
	String AccountNo       = request.getParameter("AccountNo");
	String AccountType     = request.getParameter("AccountType");
	String groupId         = request.getParameter("groupId");
	String SEQ_MailCode    = request.getParameter("SEQ_MailCode");//20100317 add
	String reject_flag    	 = request.getParameter("reject_flag");//add ���Ų�����ʵ�ձ������޳�@2014/3/10 
	String oaNumber = request.getParameter("oaNumber");//OA���
	String oaTitle = request.getParameter("oaTitle");  //OA����
	System.out.println("liangyl===oaNumber========================"+oaNumber);
	System.out.println("liangyl===oaTitle========================"+oaTitle);
	
	MD5 _md5 = new MD5();
	String kfPassWord = _md5.encode(loginPass); /*���� loginPass Ϊ����ǰ�����룬����������*/
	
	if(opType.equals("1"))
	{
		/*������޸Ĺ�����Ϣ�����봫�գ��ͷ��˽��պ��޸�����*/
		kfPassWord = "";
		System.out.println("++++++1+++�޸Ĺ�����Ϣ����+++++++++++");
	}
	else if(!AccountType.equals("2"))
	{
		/*�����BOSS���ţ������ͷ�������Ϊ111111�ļ���*/
		kfPassWord = _md5.encode("111111");
		System.out.println("++++++2+++����BOSS������Ϣ����+++++++++++");
	}
	
	System.out.println("gourpId       is : " + groupId      );
	
	//ArrayList acceptList = new ArrayList();
	String paramsIn[] = new String[34];//20100317 modified String[30] to String[31]

	paramsIn[0]  = workNo;          //����
	paramsIn[1]  = nopass;          //����
	paramsIn[2]  = opCode;          //OP_CODE �½�  8058	 �޸�  8059
	paramsIn[3]  = opType;          //��������(0_����; 1_�޸�; 2_��ѯ);
	paramsIn[4]  = loginNo;         //�½����Ŵ���
	paramsIn[5]  = loginName;       //�½���������
	paramsIn[6]  = loginFlag;       //��������
	paramsIn[7]  = loginPass;       //��½����
	paramsIn[8]  = powerCode;       //��ɫ����
	paramsIn[9]  = powerRight; 	    //��ɫȨ��
	paramsIn[10] = rptRight;        //����Ȩ��
	paramsIn[11] = allowBegin;      //��ʼ��½ʱ��
	paramsIn[12] = allowEnd;   	    //������½ʱ��
	paramsIn[13] = expireTime;      //����ʧЧʱ��
	paramsIn[14] = tryTimes;        //��½����
	paramsIn[15] = validFlag;       //��Ч��ʶ
	paramsIn[16] = maintainFlag;    //ά����ʶ
	paramsIn[17] = orgCode;         //��������
	paramsIn[18] = deptCode;   	    //������������
	paramsIn[19] = lastIpAdd;       //��½IP��ַ
	paramsIn[20] = reFlag;          //�ظ���½��־
	paramsIn[21] = loginStatus;     //��½״̬
	paramsIn[22] = remark;     	    //��ע
	paramsIn[23] = contractPhoneNo;	//���ŵ绰
	paramsIn[24] = regionChar;      //��ز���Ȩ��
	paramsIn[25] = "0";             //Ա������
	paramsIn[26] = AccountNo;       //�ͷ�����
	paramsIn[27] = AccountType;     //�ʺ�����
	paramsIn[28] = groupId;         //��֯�ڵ����
	paramsIn[29] = kfPassWord;      //�ͷ���������
	paramsIn[30] = SEQ_MailCode;    //������������ 20100317 add
	paramsIn[31] = "";    	  			//2014/3/10 add
	paramsIn[32] = reject_flag;    	  //���Ų�����ʵ�ձ������޳� 2014/3/10 add
	paramsIn[33] = "RJBB";    	    //��־λ 2014/3/10 add
	System.out.println(">>>>["+powerRight+"]>>>>>["+rptRight+"]>>>>["+lastIpAdd);
	for(int i = 0 ; i <paramsIn.length ; i ++){
		System.out.println("1--------hejwa---------paramsIn["+i+"]--------------->"+paramsIn[i]);
	}
	if("0".equals(paramsIn[27])){
		String sql = "select substr(a.boss_org_code,1,4)||substr(:pLoginNo,2,5) from dChnGroupMsg a where a.group_id = trim(:vGroupId)";
		String sqlpLoginNo = "pLoginNo="+paramsIn[4]+",vGroupId="+paramsIn[28];
		%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=sqlpLoginNo%>" />
		</wtc:service>
		<wtc:array id="result_orgcode" scope="end" />
		<%
		if("000000".equals(retCode)){
			if(result_orgcode.length>0){
				System.out.println("--------hejwa---------result_orgcode[0][0]="+result_orgcode[0][0]);
				paramsIn[17]=result_orgcode[0][0];
			}
        }
	}
			for(int i = 0 ; i <paramsIn.length ; i ++){
			System.out.println("2--------hejwa---------paramsIn["+i+"]--------------->"+paramsIn[i]);
		}
	String errCode="0";
	String errMsg="";
	
	 	//acceptList = impl.callFXService("s8002Cfm",paramsIn,"2");
%>
	<wtc:service name="s8002Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="29" >
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>				
		<wtc:param value="<%=paramsIn[5]%>"/>
		<wtc:param value="<%=paramsIn[6]%>"/>
		<wtc:param value="<%=paramsIn[7]%>"/>
		<wtc:param value="<%=paramsIn[8]%>"/>
		<wtc:param value="<%=paramsIn[9]%>"/>		
		<wtc:param value="<%=paramsIn[10]%>"/>		
		<wtc:param value="<%=paramsIn[11]%>"/>
		<wtc:param value="<%=paramsIn[12]%>"/>
		<wtc:param value="<%=paramsIn[13]%>"/>
		<wtc:param value="<%=paramsIn[14]%>"/>		
		<wtc:param value="<%=paramsIn[15]%>"/>
		<wtc:param value="<%=paramsIn[16]%>"/>
		<wtc:param value="<%=paramsIn[17]%>"/>
		<wtc:param value="<%=paramsIn[18]%>"/>
		<wtc:param value="<%=paramsIn[19]%>"/>		
		<wtc:param value="<%=paramsIn[20]%>"/>
		<wtc:param value="<%=paramsIn[21]%>"/>
		<wtc:param value="<%=paramsIn[22]%>"/>
		<wtc:param value="<%=paramsIn[23]%>"/>
		<wtc:param value="<%=paramsIn[24]%>"/>		
		<wtc:param value="<%=paramsIn[25]%>"/>
		<wtc:param value="<%=paramsIn[26]%>"/>
		<wtc:param value="<%=paramsIn[27]%>"/>
		<wtc:param value="<%=paramsIn[28]%>"/>
		<wtc:param value="<%=paramsIn[29]%>"/>
		<wtc:param value="<%=paramsIn[30]%>"/>//20100317 add
		<wtc:param value="<%=paramsIn[31]%>"/>//2014/3/10  add
	  	<wtc:param value="<%=paramsIn[32]%>"/>//2014/3/10  add
	  	<wtc:param value="<%=paramsIn[33]%>"/>//2014/3/10  add
	  	<wtc:param value="<%=oaNumber%>" />
		<wtc:param value="<%=oaTitle%>" />
	</wtc:service>
	<wtc:array id="results" scope="end"/>
<%
		errCode=retCode1;
		errMsg=retMsg1;	
	System.out.println("errCode       is : " + errCode      );
	System.out.println("errMsg       is : " + errMsg      );
	
	if(errCode.equals("000000"))
    {
%>
        alert("�����ɹ���");
<%	}
    else
    {
%>
		alert("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" );
		//history.go(-1);
<%
    }
    	
	String[]info=new String[29];	
	if(results!=null&&results.length>0){
		for(int i = 0 ; i <results[0].length ; i ++){
			
			info[i]=results[0][i];
			System.out.println("info["+i+"]=:"+info[i]);
		}
	}
	

	
    String strArray="";
%>

<%=strArray%>

var info=new Array();
info[0]=new Array;
info[1]=new Array;
info[0][0]="<%=errCode%>";
info[1][0]="<%=errMsg%>";

var response = new AJAXPacket();
response.data.add("backString",info);
response.data.add("flag","9");
core.ajax.receivePacket(response);




