<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-09 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml">
	<%@ page contentType="text/html; charset=GBK" %>
	<%@ include file="/npage/include/public_title_name.jsp" %>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%
	
	String dateStart="20150901";     
	String dateEnd="20151130";    
	String nowDate =new SimpleDateFormat("yyyyMMdd").format(new java.util.Date()).toString();
	
	boolean ifCanShow = false;
	
	if(!"".equals(nowDate)){
		if(Integer.parseInt(nowDate) >= Integer.parseInt(dateStart) && Integer.parseInt(nowDate) <= Integer.parseInt(dateEnd)){
			ifCanShow = true;
		}
	}

		String opCode = "m058";
		String opName = "ʵ���Ǽ�";

		String op_code = "m058";
		
		request.setCharacterEncoding("GBK");
		String work_no = (String)session.getAttribute("workNo");
		String loginName = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String regionCode = org_code.substring(0,2);
		String groupId =(String)session.getAttribute("groupId");
		String loginPwd    = (String)session.getAttribute("password");
		String notestr=work_no+"�����ֻ������Ӫҵ�����У��";
		String accountType =  (String)session.getAttribute("accountType")==null?"":(String)session.getAttribute("accountType");//1 ΪӪҵ���� 2 Ϊ�ͷ�����
	
		String[][] temfavStr=(String[][])session.getAttribute("favInfo");
		String[] favStr=new String[temfavStr.length];
		for(int i=0;i<favStr.length;i++)
		favStr[i]=temfavStr[i][0].trim();
		boolean hfrf=false;
		
		/* begin add ���ϻ��Ż�Ȩ�� for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/11 */
    boolean oldFav_a971 = false;
    if (WtcUtil.haveStr(favStr, "a971")) {
    	oldFav_a971 = true;
    }
 		/* end add ���ϻ��Ż�Ȩ�� for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/11 */


 	    //---------------�����ύҳ�������������-----------------------------
		String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
		/*��ȡ����ķ������*/
		String phone_no = WtcUtil.repNull(request.getParameter("srv_no"));
		/*2016/2/26 10:18:01 gaopeng */
		String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
		/*2016/6/28 10:12:44  ���ڹ������ֹ�˾�������������ͻ���Ϣ�Լ�����ϵͳ�Ż�����ʾ 
			������ʵ��opcode
		*/
		String realOpCode=WtcUtil.repNull(request.getParameter("realOpCode")) == "" ?"m058":request.getParameter("realOpCode");
		String returnPage = "/npage/sm058/s1238Login.jsp";
		if("m389".equals(realOpCode)){
			returnPage = "/npage/sm389/fm389Main.jsp";
		}
		
		String kdNo = "";
		boolean isKd = false;
		String ifKdNo = "";
		%>
		
		<wtc:service  name="sGetBroadPhone"  routerKey="region" routerValue="<%=regionCode%>" 
		 outnum="2"  retcode="errCodeGetPhone" retmsg="errMsgGetPhone">
			<wtc:param  value="0"/>
			<wtc:param  value="01"/>
			<wtc:param  value=""/>
			<wtc:param  value="<%=work_no%>"/>
			<wtc:param  value=""/>
			<wtc:param  value=""/>
			<wtc:param  value=""/>
			<wtc:param  value="<%=srv_no%>"/>
	  </wtc:service>
  	<wtc:array id="list" scope="end"/>
	<%
			if("000000".equals(errCodeGetPhone) && list.length >0){
					/*��õڶ������� �������˺� ������209���� �򷵻�ttkdXXX*/
					
					ifKdNo = list[0][1];
					System.out.println("==gaopengSeeLogM058= ifKdNo ===" + ifKdNo);
					/*���������뷵���� ֤��������� ������� */
					if(!"".equals(ifKdNo) && ifKdNo != null){
						System.out.println("==gaopengSeeLogM058= 1111 =22222==");
						isKd= true;
						/*��ֵ�������*/
						kdNo = ifKdNo;
						srv_no = srv_no;
						phone_no = phone_no;
					}else{
						isKd= true;
						System.out.println("==gaopengSeeLogM058= isKd ===" + isKd);
						/*�ǿ���˺� ��ֵ����˺���Ϣ���ڴ�ӡ���*/
						kdNo = srv_no;
						System.out.println("==gaopengSeeLogM058= kdNo ===" + kdNo);
						System.out.println("==gaopengSeeLogM058= list[0][0] ===" + list[0][0]);
							/*���ֻ����滻��ǰ����˺����ڷ���ֵ*/
							srv_no = list[0][0];
							phone_no = list[0][0];
					
				}
			}
	
	%>
	<%
		if(srv_no.equals(""))
		{
		response.sendRedirect(returnPage+"?ReqPageName=s1238Main&retMsg=1");
		}
		/* add for �Ƿ�Ϊ����������� 1���� @2014/11/19  */
		String workChnFlag = "0" ;
		
		/*2015/9/7 13:53:52 gaopeng ���ڿ����������ͻ����Ͳ��塢�����м����Ķ���Ʒ�������������ĺ�
    	���������ѯ�Ƿ���ʾ����
    */
    String backCode= "";
    String backInfo = "";
%>	
		
	<wtc:service name="sTSInfoBack" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_sTSInfoBack" retmsg="retMessage_sTSInfoBack" outnum="1"> 
    <wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=loginPwd%>"/>
		<wtc:param value="<%=phone_no%>"/>
	  <wtc:param value=""/>
	  <wtc:param value=""/>
  </wtc:service>  
  <wtc:array id="result_sTSInfoBack"  scope="end"/>
  	
		<wtc:service name="s1100Check" outnum="30"
			routerKey="region" routerValue="<%=regionCode%>" retcode="rc" retmsg="rm" >
			<wtc:param value = ""/>
			<wtc:param value = "01"/>
			<wtc:param value = "<%=opCode%>"/>
			<wtc:param value = "<%=work_no%>"/>
			<wtc:param value = "<%=loginPwd%>"/>
				
			<wtc:param value = ""/>
			<wtc:param value = ""/>
		</wtc:service>
		<wtc:array id="rst" scope="end" />
			<%
	backCode = retCode_sTSInfoBack;
	
	backInfo = retMessage_sTSInfoBack;
	System.out.println("gaopengSeeLogM058=====backCode==="+backCode);
	System.out.println("gaopengSeeLogM058=====backInfo==="+backInfo);

%>
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
    /*������ʵ����ڿ�������BOSS�Ż���������������ñ�start*/
    String sql_appregionset1 = "select count(*) from sOrderCheck where group_id=:groupids and flag='Y' ";
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
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1"> 
			<wtc:param value="<%=sql_regionCodeFlag[0]%>"/>
			<wtc:param value="<%=sql_regionCodeFlag[1]%>"/>
		</wtc:service>  
		<wtc:array id="ret2"  scope="end"/>
<%
		if("000000".equals(retCode2)){
			if(ret2.length > 0){
				if(Integer.parseInt(ret2[0][0]) > 0){
					regionCodeFlag = "Y"; 
				}
			}
		}
%>			
		<wtc:service name="s1238Init" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCodecheck" retmsg="retMsgcheck" outnum="30" >
			<wtc:param value=" "/>
			<wtc:param value="01"/>
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=work_no%>"/>	
			<wtc:param value="<%=loginPwd%>"/>		
			<wtc:param value="<%=srv_no%>"/>	
			<wtc:param value=" "/>
			<wtc:param value="<%=notestr%>"/>
		</wtc:service>
		<wtc:array id="scheckphones" scope="end"/>
<%

    if(!"000000".equals(retCodecheck)){
%>
      <script language=javascript>
        rdShowMessageDialog('������룺<%=retCodecheck%><br>������Ϣ��<%=retMsgcheck%>');
        location='<%=returnPage%>?activePhone=<%=phone_no%>';
      </script>
<%
      return;
    }
		String  isshehuiworkno="no";	
		String  checkworknoflag [] = new String[2];
						checkworknoflag[0]="	select c.group_id from schnclassinfo a,schnclassmsg b ,dchngroupmsg c,dloginmsg d "
															+" where a.parent_class_code='7' "
															+" and a.class_code=b.class_code  "
															+" and a.class_code=c.class_code  "
															+" and c.group_id = d.group_id    "
															+" and d.login_no=:loginnos ";
					  checkworknoflag[1]= "loginnos="+work_no;		
%>
  <wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCodworkno" retmsg="retMsworkno" outnum="1"> 
    <wtc:param value="<%=checkworknoflag[0]%>"/>
    <wtc:param value="<%=checkworknoflag[1]%>"/> 
  </wtc:service>  
  <wtc:array id="worknoflags"  scope="end"/>						 
<%	

if(worknoflags.length>0)	{
	isshehuiworkno="yes";
}	
System.out.println("-----m058---shehuiwork--"+isshehuiworkno);			 						
		
  /*** begin diling add for ����û��С�NFC�ֻ�Ǯ��ҵ�񡱲��������ʵ���Ǽ�ҵ�� @2013/1/6  ***/
  String  inParams_NFC [] = new String[2];
  inParams_NFC[0]="select count(*) "
                  +" from DDSMPORDERMSG "
                  +" where PHONE_NO like :phoneno || '%' "
                  +" and serv_code = '73' "
                  +" and valid_flag = '1' "
                  +" and OPR_CODE <> '07' "
                  +" and sysdate between eff_time and end_time";
  inParams_NFC[1] = "phoneno="+srv_no;
%>
  <wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode_NFC" retmsg="retMsg_NFC" outnum="1"> 
    <wtc:param value="<%=inParams_NFC[0]%>"/>
    <wtc:param value="<%=inParams_NFC[1]%>"/> 
  </wtc:service>  
  <wtc:array id="NFCArr"  scope="end"/>
<%
  if("000000".equals(retCode_NFC)){
    if(NFCArr.length>0){
      if(Integer.parseInt(NFCArr[0][0])>0){
%>

<% 
      }
    }
  }
  /*** end diling add @2013/1/6 ***/
		String  inParams [] = new String[2];
		/* diling update for ��棺1238ʵ���Ǽ�û�������Ѿ�����������ͨ�û�ʱ�� @2012/10/12 
		inParams[0]="select count(*) from dRelaBaseMsg where id_no in (select id_no from dcustmsg where phone_no = :phoneNo)";
    */
    inParams[0]="select count(*) from dRelaBaseMsg where id_no in (select id_no from dcustmsg where phone_no = :phoneNo) and to_date(endtime,'yyyy/MM/dd HH24:MI:ss')>sysdate";
    inParams[1] = "phoneNo="+srv_no;
%>
    <wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode_" retmsg="retMsg_" outnum="1"> 
      <wtc:param value="<%=inParams[0]%>"/>
      <wtc:param value="<%=inParams[1]%>"/> 
    </wtc:service>  
    <wtc:array id="str_sql"  scope="end"/>
<%
		if("000000".equals(retCode_))
		{
			if(str_sql!=null && str_sql.length>0)
			{
				if(!(str_sql[0][0]).equals("0"))
				{
				
				}
			}
		}
		String sqls="SELECT id_Name FROM sIdType order by id_type";
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
	 <wtc:sql><%=sqls%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="metaData" scope="end"/>
<%
		 String loginAccept = WtcUtil.repNull(request.getParameter("accept"));
		 boolean printFlag = true;
		 boolean is_Z_flag = true;//��¼�Ƿ��ģ����֤��ת������
		 if ("".equals(loginAccept)){
%>
				<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone"  routerValue="<%=srv_no%>" id="sLoginAccept"/>
<%
				loginAccept = sLoginAccept;
				printFlag = false;
				is_Z_flag = false;
		}
		
		/*
		String if24MonthText = "�Ƿ�����24���²��������ʵ���ǼǺ͹���";
		String if23Options = "<option value=''>--��ѡ��--</option>"
                        +"<option value='1'>��</option>"
                        +"<option value='0'>��</option>";
                        */
    String if24MonthText = "�ֻ�����ʵ���ǼǺ͹�������";
		String if23Options = "<option value=''>--��ѡ��--</option>"
                        +"<option value='Y'>�����ƹ�����ʵ���Ǽ�</option>"
                        +"<option value='K'>24���²��ܹ�����ʵ���Ǽ�</option>"
                        +"<option value='N'>���ܹ�����ʵ���Ǽ�(ʱ��Ϊ2050��)</option>";
		/*�����g551Ҳ����ģ����֤����m058����Ȼ�� �Ƿ�����24���²��������ʵ���ǼǺ͹��� 
			��������������� M058 ���Ҳ��ǿ������ ��չʾ���� �ֻ�����ʵ���ǼǺ͹�������
		*/
		/*
		if(!is_Z_flag && !isKd){
			if24MonthText = "�ֻ�����ʵ���ǼǺ͹�������";
			if23Options = "<option value=''>--��ѡ��--</option>"
                        +"<option value='2'>�����ƹ�����ʵ���Ǽ�</option>"
                        +"<option value='3'>24���²��ܹ�����ʵ���Ǽ�</option>"
                        +"<option value='4'>���ܹ�����ʵ���Ǽ�(ʱ��Ϊ2050��)</option>";
		}*/
		
		//S1210Impl im=new S1210Impl();
		//ArrayList custDoc=im.sPubUsrBaseInfo(srv_no,op_code,"phone",srv_no,work_no);
%>
		<wtc:service name="sPubUsrBaseInfo" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode1" retmsg="retMsg1" outnum="30" >
			<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=work_no%>"/>	
		<wtc:param value="<%=loginPwd%>"/>		
		<wtc:param value="<%=srv_no%>"/>	
		<wtc:param value=" "/>
		</wtc:service>
		<wtc:array id="sPubUsrBaseInfoArr" scope="end"/>
<%

    System.out.println("---m058-------retCode1="+retCode1);
    if(!"000000".equals(retCode1)){
%>
      <script language=javascript>
        rdShowMessageDialog('������룺<%=retCode1%><br>������Ϣ��<%=retMsg1%>');
        location='<%=returnPage%>?activePhone=<%=phone_no%>';
      </script>
<%
      return;
    }
		ArrayList baseInfoList = new ArrayList();
		if(sPubUsrBaseInfoArr!=null&&sPubUsrBaseInfoArr.length>0&&retCode1.equals("000000")){
			for(int i=0;i<sPubUsrBaseInfoArr.length;i++){
				for(int j=0;j<sPubUsrBaseInfoArr[i].length;j++){
					baseInfoList.add(sPubUsrBaseInfoArr[i][j]);
					System.out.println("sPubUsrBaseInfoArr["+i+"]["+j+"]="+sPubUsrBaseInfoArr[i][j]);
				}
			}
		}else{
		  response.sendRedirect(returnPage+"?ReqPageName=s1238Main&retMsg=2&activePhone="+phone_no);
		}
		String userRegionCode = ((String)baseInfoList.get(2)).length()>=2?((String)baseInfoList.get(2)).substring(0,2):"";
		String handFeeSqlStr = "select hand_fee ,trim(favour_code) from snewFunctionFee where region_code='"+userRegionCode+"' and function_code='"+opCode+"'";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
    <wtc:sql><%=handFeeSqlStr%>
    </wtc:sql>
		</wtc:pubselect>
		<wtc:array id="handFeeSqlArr" scope="end"/>
<%
		if(handFeeSqlArr!=null&&handFeeSqlArr.length>0){
			for(int i=0;i<handFeeSqlArr[0].length;i++){
				baseInfoList.add(handFeeSqlArr[0][i]);
			}
		}else{
				baseInfoList.add("");
				baseInfoList.add("");
		}

		//���񷵻ز������ܲ��淶,���緵����λ�ȵ�.��������ת����,������Ϊ����������淶�����Ĵ���
		int returnCode = retCode1==""?999999:Integer.parseInt(retCode1);
		String returnMsg = retMsg1;
		baseInfoList.add(String.valueOf(returnCode));
		baseInfoList.add(returnMsg);

		//�������������ת��һ��
		ArrayList custDoc = baseInfoList;
		if(custDoc.size()<34){ //������Ȳ���34,�ͱ���������
				response.sendRedirect(returnPage+"?ReqPageName=s1238Main&retMsg=9");
		}

		/***�û�Ʒ��***/
		String sNewSmName = ((String)custDoc.get(3))==null?"":(String)custDoc.get(3);

		///////////
		//  ��������� AT 20061011
		////////////////////////////////
		String mode_name="" ;
		String good_flag="0" ;
		//lichaoa modify 20120824 �����绯�ֹ�˾�����������������Ƶ���ʾ
		//String sql = "select count(*) from dgoodphoneres a,sbillmodedes b,dCustMsg c where c.phone_no = '"+srv_no+"' and  a.bill_code=b.mode_code and substr(c.belong_code,1,2)=b.region_code and a.phone_no=c.phone_no and (good_type like '1%' or good_type like '2%') group by mode_name";
		String sql = "select count(*) from dgoodphoneres a where a.phone_no = '"+srv_no+"' ";
		System.out.println("sql="+sql);
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
    <wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="agentCodeStr" scope="end"/>
<%
		if(agentCodeStr ==null||agentCodeStr.length==0){
			System.out.println("���������");
		}else{
			good_flag = agentCodeStr[0][0];
			if(!agentCodeStr[0][0].equals("0")) {
				sql = "select count(*) from shighlogin where login_no='" +work_no+"' and op_code='m058'";
%>
				<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
		    <wtc:sql><%=sql%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="agentCodeStr" scope="end"/>
<%
				if(agentCodeStr[0][0].equals("0")) {
					
				}
			}
		}
		/**
		sql = "select d.mode_dxpay from dbillcustdetail a,dgoodphoneres b,dcustmsg c,sgoodbillcfg d "+
				" where a.MODE_CODE=b.bill_code and a.mode_time='Y' and a.end_time>sysdate "+
				" and a.id_no=c.id_no and b.phone_no=c.phone_no and b.bill_code=d.mode_code "+
				" and a.REGION_CODE=d.region_code and c.phone_no='"+srv_no+"'";
		**/
		sql = "SELECT d.mode_dxpay FROM product_offer_instance a, dgoodphoneres b, dcustmsg c, sgoodbillcfg d "+
				"WHERE to_char(a.offer_id) = trim(b.bill_code) AND a.exp_date > SYSDATE"+
				"AND a.serv_id = c.id_no AND b.phone_no = c.phone_no"+
				"AND b.bill_code = d.mode_code AND c.phone_no = '"+srv_no+"'";
		String goodFlagNew="0";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
   		 <wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="agentCodeStr" scope="end"/>
<%
		if(agentCodeStr ==null||agentCodeStr.length==0){
			System.out.println("222���������");
		}else{
			mode_name = agentCodeStr[0][0];
			goodFlagNew = "1";
		}

		System.out.println("mode_name="+mode_name);
		System.out.println("good_flag="+good_flag);

		String HasPostBill = "";

		//�ʼ��ʵ��޸�20070327
		sql = "select count(*) from dCustPostPrtBill a,dcustmsg b where a.id_no = b.id_no and a.tran_type = '1' and a.post_type = '1' and b.phone_no = '"+srv_no+"'";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
    <wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="agentCodeStr" scope="end"/>
<%
		boolean hasPostBill = false;
		if(!agentCodeStr[0][0].equals("0"))
				HasPostBill = "Y";
		 else
		 		HasPostBill = "N"	;

		System.out.println("HasPostBill"+HasPostBill);
		System.out.println("agentCodeStr1="+agentCodeStr[0][0]);


		String HasEmailBill = "";
		//�����ʵ��޸�20070327
		sql = "select count(*) from dCustPostPrtBill a,dcustmsg b where a.id_no = b.id_no and a.tran_type = '1' and a.post_type = '2' and b.phone_no = '"+srv_no+"'";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
    <wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="agentCodeStr" scope="end"/>
<%
		boolean hasEmailBill = false;
		if(!agentCodeStr[0][0].equals("0"))
			HasEmailBill = "Y";
		else
			HasEmailBill = "N";
	  System.out.println("sql"+sql);
		System.out.println("HasEmailBill"+HasEmailBill);
		System.out.println("------------------------------------1"+custDoc.get(2));
		//������������

		/**

			ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
		  String[][] allNewSmInfo=(String[][])arrSession.get(5);
      String sNewSmName=Pub_lxd.getNewSm(org_code.substring(0,2),(String)custDoc.get(3),allNewSmInfo,"1");
    **/








	
		
		
		
		
		
		
		
		
		if(Double.parseDouble(((String)custDoc.get(19)))>Double.parseDouble(((String)custDoc.get(20))))
    {
        response.sendRedirect(returnPage+"?ReqPageName=s1238Main&retMsg=100&oweAccount="+new String(((String)custDoc.get(21)).getBytes("GBK"),"ISO8859_1")+"&oweFee="+((String)custDoc.get(22)));
    }

 		if(((String)custDoc.get(30)).trim().equals("") || ((String)custDoc.get(30)).trim().equals("0") || Double.parseDouble(((String)(custDoc.get(30))))==0)
		{
 			hfrf=true;
		}else{
      if(!WtcUtil.haveStr(favStr,((String)custDoc.get(31)).trim())){
 				hfrf=true;
		  }
		}

		if(Integer.parseInt(((String)custDoc.get(32)).trim())!=0)
		{
		  if(Integer.parseInt(((String)custDoc.get(32)).trim())==1007 || Integer.parseInt(((String)custDoc.get(32)).trim())==1008)
		  {
          //response.sendRedirect(returnPage+"?ReqPageName=s1238Main&retMsg=100&oweAccount="+new String(((String)custDoc.get(21)).getBytes("GBK"),"ISO8859_1")+"&oweFee="+((String)custDoc.get(22)));
		  }
		  else
		  {
          response.sendRedirect(returnPage+"?ReqPageName=s1238Main&retMsg=101&errCode="+((String)custDoc.get(32)).trim()+"&errMsg="+new String(((String)custDoc.get(33)).trim().getBytes("GBK"),"ISO8859_1"));
		  }
		}
		
		for( int i = 0 ; i <custDoc.size(); i ++  )
		{
			System.out.println("custDoc ["+i+"]==>"+custDoc.get(i));
		}
		
 	 %>
 	 <%
 	 /*****************liucm*****************/
 	 String main_str1="";
	 String fj_str1="";
	 String main_note="";
	 String mode_code="";
	 String detail_code="";
 	 String OldId=(String)custDoc.get(0);
 	 /*
 	 String sqlStrk ="select '('||a.mode_code||' '||trim(b.mode_name)||')',a.mode_code  from dbillcustdetail a,sbillmodecode b where id_no=to_number('"+OldId+"')"+
	" and a.mode_flag='0' 	and a.mode_time='	Y' and a.mode_status='Y' and a.mode_code=b.mode_code "+
	" and a.region_code=b.region_code";
	  */
	 String sqlStrk = "SELECT '('||a.offer_id||' '||trim(b.offer_name)||')',a.offer_id FROM product_offer_instance a, product_offer b "+
	 				  "WHERE a.offer_id = b.offer_id and SYSDATE BETWEEN a.eff_date AND a.exp_date "+
	 				  "and b.offer_type = '10' and a.state = 'A' and a.serv_id = to_number('"+OldId+"')	";
%>

		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
    <wtc:sql><%=sqlStrk%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end"/>
<%
	if(result!=null&&result.length>0){
		main_str1 = result[0][0];
		mode_code = result[0][1];
	}	else{
				 String sqlStrk2 = "select '(' || a.structvalue || ' ' || trim(c.offer_name) || ')', a.structvalue from product_order_content a ,dservordermsg b,product_offer c "+
				 " where a.prodordid= b.serv_order_id"+
				 " and b.id_no= to_number('"+OldId+"')	"+
				 " and a.structid= 1055"+
				 " and to_number(a.structvalue)=c.offer_id"+
				 " and c.offer_type= 10";
				 System.out.println("yanpx mode_code = "+sqlStrk2);
				 %>
						<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
				    <wtc:sql><%=sqlStrk2%></wtc:sql>
						</wtc:pubselect>
						<wtc:array id="result2" scope="end"/>
				<%
				  System.out.println("yanpx  main_str1="+retCode);
					System.out.println("yanpx  main_str1="+result2.length);
				if(result2!=null&&result2.length>0){
					main_str1 = result2[0][0];
					mode_code = result2[0][1];
					System.out.println("yanpx  main_str1="+main_str1);
					System.out.println("yanpx  mode_code="+mode_code);
				}
		}
	
	/*
	sqlStrk ="select '('||a.mode_code||' '||trim(b.mode_name)||')'  from dbillcustdetail a,sbillmodecode b where id_no=to_number('"+OldId+"')"+
	" and a.mode_flag='2' 	and a.mode_time='Y' and a.mode_status='Y' and a.mode_code=b.mode_code "+
	" and a.region_code=b.region_code";
	*/
	sqlStrk = "SELECT '('||a.offer_id||' '||trim(b.offer_name)||')' FROM product_offer_instance a, product_offer b "+
	 				  "WHERE a.offer_id = b.offer_id and SYSDATE BETWEEN a.eff_date AND a.exp_date "+
	 				  "and b.offer_type = '40' and a.state = 'A' and a.serv_id = to_number('"+OldId+"')	";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
    <wtc:sql><%=sqlStrk%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end"/>
<%
	for(int i=0;i<result.length;i++){
		fj_str1=fj_str1+result[i][0]+"��";
	}

	System.out.println("fj_str1===="+fj_str1);

%>
<wtc:service name="s9611Cfm3" routerKey="regionCode" routerValue="<%=regionCode%>"  outnum="4" >
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="1"/>
    <wtc:param value="2"/>
    <wtc:param value="<%=groupId%>"/>
    <wtc:param value="<%=mode_code%>"/>
    <wtc:param value="10442"/>
    <wtc:param value="<%=regionCode%>"/>
    <wtc:param value=""/>
</wtc:service>
<wtc:array id="result" scope="end" />
<%
	main_note=result.length>0?result[0][0]:"";
	main_note = main_note.replaceAll("\"","");
	main_note = main_note.replaceAll("\'","");
	System.out.println("main_note="+main_note);
%>
<%
		/*****����÷20080715���ӣ���ѯ�û��ĺڰ�������Ϣ********/
		String sqlB=" select to_char(count(*))	from dBlakWhiteList a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phone and a.list_type='B'";
		String [] paraIn1 = new String[4];
		String liststr="";
		paraIn1[0] = "region";
		paraIn1[1] = regionCode;
		paraIn1[2] = sqlB;
		paraIn1[3] = "phone="+srv_no;
    //ArrayList offonArr = callViewn.callFXService("sPubSelectNew",paraIn1,"1");
%>
		<wtc:service name="sPubSelectNew" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
		<wtc:param value="<%=paraIn1[0]%>"/>
		<wtc:param value="<%=paraIn1[1]%>"/>
		<wtc:param value="<%=paraIn1[2]%>"/>
		<wtc:param value="<%=paraIn1[3]%>"/>
		</wtc:service>
		<wtc:array id="offnodataArray" scope="end"/>
<%
		String totalListNum = offnodataArray.length>0?offnodataArray[0][0]:"";
    if(!totalListNum.equals("0"))
    {
    	liststr="�˿ͻ��ں���������!";
    }else{
 			String sqloffon="select to_char(count(*)) from dBlakWhiteList a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phone "
 				+" and op_Type='0' and op_code='0' and list_type='W' ";
  		System.out.println("sqloffon====="+sqloffon);
    	String [] paraIn2 = new String[4];
    	paraIn2[0] = "region";
    	paraIn2[1] = regionCode;
    	paraIn2[2] = sqloffon;
    	paraIn2[3] = "phone="+srv_no;
    	//offonArr = callViewn.callFXService("sPubSelectNew",paraIn2,"1");
%>
			<wtc:service name="sPubSelectNew" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
			<wtc:param value="<%=paraIn1[0]%>"/>
			<wtc:param value="<%=paraIn1[1]%>"/>
			<wtc:param value="<%=paraIn1[2]%>"/>
			<wtc:param value="<%=paraIn1[3]%>"/>
			</wtc:service>
			<wtc:array id="offnodataArray" scope="end"/>
<%
			totalListNum = offnodataArray.length>0?offnodataArray[0][0]:"";

    	if(totalListNum.equals("0"))
    	{
    		liststr="�˿ͻ����ڰ���������!";
    	}else{
    		liststr="�˿ͻ��ڰ���������!";
    	}
    }
    int listlen=liststr.length();
    String attrcode=(String)custDoc.get(9);
 System.out.println("aaaaaaaaaaaaaaaaaaa="+attrcode);
 /**************liucm end **************/
%>

<!-- 20091201 fengry begin for �����������ʵ���Ǽ����� -->
<%
	String sys_Date=new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
	String sysDate_Good=sys_Date.substring(0,8);
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@sysDate_Good in s1238Main.jsp="+sysDate_Good);

	StringBuffer Goodsql = new StringBuffer();
		Goodsql.append(" select phone_no,to_char(to_date(total_date,'YYYY-MM-DD'),'YYYY-MM-DD')");
		Goodsql.append(" from dOpenGsmChk");
		Goodsql.append(" where phone_no= '"+srv_no+"' and id_no= to_number('"+custDoc.get(0)+"')");
		Goodsql.append(" AND to_char(total_date) - to_char(sysdate,'yyyymmdd') > 0");
	System.out.println("Goodsql==="+Goodsql);
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" retcode="GoodRetCode" retmsg="GoodRetMsg" outnum="2" >
<wtc:sql><%=Goodsql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="GoodStr" scope="end" />
<%
	System.out.println("@@@@@@@@@@GoodRetCode in s1238Main.jsp="+GoodRetCode+"/GoodRetMsg="+GoodRetMsg+"/GoodStr.length="+GoodStr.length);

	if(GoodStr.length > 0 && GoodStr != null)
	{
		if(GoodStr[0][1].substring(0,10).equals("2050-01-01"))
		{%>

<%
		}else{
%>

<%
		}
	}

	String sqlStrl0 ="SELECT count(*) FROM dChnGroupMsg a,dbChnAdn.sChnClassMsg b WHERE a.group_id='"+groupId+"' AND a.is_active='Y' AND a.class_code=b.class_code AND b.class_kind='2'";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCodel0" retmsg="retMsgl0" outnum="1">
	<wtc:sql><%=sqlStrl0%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultl0" scope="end" />
<%
	StringBuffer GoodPhoneYes = new StringBuffer();
	GoodPhoneYes.append(" select phone_no from dgoodphoneres ");
	GoodPhoneYes.append(" where phone_no = '"+srv_no+"'" );

	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@GoodPhoneYes in s1238Main.jsp="+GoodPhoneYes);
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" retcode="YesRetCode" retmsg="YesRetMsg" outnum="1" >
<wtc:sql><%=GoodPhoneYes%></wtc:sql>
</wtc:pubselect>
<wtc:array id="YesStr" scope="end" />
<%
	System.out.println("@@@@@@@@@@YesRetCode in s1238Main.jsp="+YesRetCode+"/YesRetMsg="+YesRetMsg+"/YesStr.length="+YesStr.length);

	int YesStrNum = YesStr.length;
	if(YesStrNum > 0)
	{
%>
			<script language=javascript>
				//rdShowMessageDialog("���������");
				//Ĭ��ʵ���Ǽ��������ѡ�ɲ�ѡ
			</script>
<%
	}else{
%>
			<script language=javascript>
				//rdShowMessageDialog("���������");
				//ʵ���Ǽ�����������
			</script>
<%
		}
%>
<!-- 20091201 end -->
<%
	String opNote = "�û�"+srv_no+"������["+opName+"]����";
	String qRealUserName = "";
  String qRealUserAddr = "";
  String qRealUserIdType = "";
  String qRealUserIccId = "";
  
  

%>
<wtc:service name="sm245Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_realUser" retmsg="retMsg_realUser" outnum="6"	>
	<wtc:param value = "<%=loginAccept%>"/>
	<wtc:param value = "01"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=work_no%>"/>
	<wtc:param value = "<%=loginPwd%>"/>
	<wtc:param value = "<%=srv_no%>"/>
	<wtc:param value = ""/>
	<wtc:param value = "<%=opNote%>"/>
</wtc:service>
<wtc:array id="ret_realUser" scope="end" />
<%

	if("000000".equals(retCode_realUser)){
		if(ret_realUser.length > 0){
			qRealUserIdType = ret_realUser[0][2];
		  qRealUserIccId = ret_realUser[0][3];
		  qRealUserName = ret_realUser[0][4];
		  qRealUserAddr = ret_realUser[0][5];
		}
	}
	
%>
		


	 <head>
 	 <title>ʵ���Ǽ�</title>
	 <script language=javascript>
	 <%
	 	String highmsg=(String)custDoc.get(17);
		String ss="�и߶��û�";
		int spos=highmsg.indexOf(ss,0);
	%>
	if(<%=spos%>>=0){rdShowMessageDialog("���û����и߶��û���");}
	if(<%=listlen%>>0){rdShowMessageDialog("<%=liststr%>");}
	   var blackFlag3=true;     //�½��ͻ���������־
	   var blackFlag=true;    //���Ѵ��ڿͻ���������־
	   var assuBlackFlag=true; //�����˺�������־
	   
	   var v_groupId = "<%=groupId%>";
		 var v_printAccept = "<%=loginAccept%>";
		 var v_workNo = "<%=work_no%>";
		 var phone_no = "<%=phone_no%>";

	   onload=function()
	   {
	   	 getIdTypes();
	 		 self.status="";
			 fillSelect();
			 chgCustType();

				//20091201 begin
				/* if(<%=YesStrNum%>>0) */		//�г���Ҫ������к�������ʵ���Ǽ�������,������ֻ����������
				{
					//�������,ʵ���Ǽ����������,Ĭ�Ͽ�ѡ�ɲ�ѡ
					/*
					document.all.Good_PhoneDate_GSM.style.display = "";
					document.all.GoodPhoneFlag.value = "0";
					*/
				}
				//20091201 end
				setRealUserFormat();
	   }
	   
			//ʵ��ʹ����֤�����͸ı�
			function valiRealUserIdTypes(idtypeVal){
				if(idtypeVal == "0"){
					document.all.realUserIccId.v_type = "idcard";
					$("#scan_idCard_two2").css("display","");
					$("#scan_idCard_two22").css("display","");
					$("input[name='realUserName']").attr("class","InputGrey");
					$("input[name='realUserName']").attr("readonly","readonly");
					$("input[name='realUserAddr']").attr("class","InputGrey");
					$("input[name='realUserAddr']").attr("readonly","readonly");
					$("input[name='realUserIccId']").attr("class","InputGrey");
					$("input[name='realUserIccId']").attr("readonly","readonly");
					$("input[name='realUserName']").val("");
					$("input[name='realUserAddr']").val("");
					$("input[name='realUserIccId']").val("");
				}else{
					document.all.realUserIccId.v_type = "string";
					$("#scan_idCard_two2").css("display","none");
					$("#scan_idCard_two22").css("display","none");
					$("input[name='realUserName']").removeAttr("class");
					$("input[name='realUserName']").removeAttr("readonly");
					$("input[name='realUserAddr']").removeAttr("class");
					$("input[name='realUserAddr']").removeAttr("readonly");
					$("input[name='realUserIccId']").removeAttr("class");
					$("input[name='realUserIccId']").removeAttr("readonly");
				}
				if($("#realUserIdType").val() == "<%=qRealUserIdType%>"){ //ѡ���ʼ֤�����ͣ���ԭ��ʼ֤����Ϣ
					$("#realUserName").val("<%=qRealUserName%>");
					$("#realUserAddr").val("<%=qRealUserAddr%>");
					$("#realUserIccId").val("<%=qRealUserIccId%>");
				}else{
					$("input[name='realUserName']").val("");
					$("input[name='realUserAddr']").val("");
					$("input[name='realUserIccId']").val("");
				}
			}




/*
	2013/11/15 15:33:56 gaopeng ���ڽ�һ������ʡ��֧��ϵͳʵ���Ǽǹ��ܵ�֪ͨ  
	ע�⣺ֻ��Ը��˿ͻ� start
*/  

/*1���ͻ����ơ���ϵ������ У�鷽�� objType 0 ����ͻ�����У�� 1������ϵ������У��  ifConnect �����Ƿ�������ֵ(���ȷ�ϰ�ťʱ��������������ֵ)*/
function checkCustNameFunc(obj,objType,ifConnect){
	var nextFlag = true;
	var objName = "";
	var idTypeVal ="";
		
	if(objType == 0){
		objName = "�ͻ�����";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "��ϵ������";
		idTypeVal = document.all.idType.value;
	}
	/*2013/12/16 11:24:47 gaopeng ������BOSS�����������ӵ�λ�ͻ���������Ϣ�ĺ� ���뾭��������*/
	if(objType == 2){
		objName = "����������";
		/*�����վ�����֤������*/
		idTypeVal = document.all.gestoresIdType.value;
	}
	
	if(objType == 3){
		objName = "����������";
		/*�����վ�����֤������*/
		idTypeVal = document.all.responsibleType.value;
	}	
	
	idTypeVal = $.trim(idTypeVal);
	/*ֻ��Ը��˿ͻ�*/
	var opCode = "<%=opCode%>";
	/*��ȡ������ֵ*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*��ȡ�����ֵ�ĳ���*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* ��ȡ��ѡ���֤������ 
		0|���֤ 1|����֤ 2|���ڲ� 3|�۰�ͨ��֤ 
		4|����֤ 5|̨��ͨ��֤ 6|��������� 7|���� 
		8|Ӫҵִ�� 9|���� A|��֯�������� B|��λ����֤�� C|������ 
		*/
		
		/*��ȡ֤���������� */
		var idTypeText = idTypeVal.split("|")[0];
		
		/*�ͻ����ơ���ϵ��������Ҫ�󡰴��ڵ���2�����ĺ��֡�����������ճ��⣨��������տͻ����Ʊ������3���ַ�����ȫΪ����������)*/
		
		/*����������������*/
		if(idTypeText != "6"){
			/*ԭ�е�ҵ���߼�У�� ֻ������Ӣ�ġ����֡����ġ����ġ����ġ���������һ�����ԣ�*/
			if(idTypeText == "3" || idTypeText == "9" || idTypeText == "8" || idTypeText == "A" || idTypeText == "B" || idTypeText == "C"){
				if(objValueLength < 2){
					rdShowMessageDialog(objName+"������ڵ���2�����֣�");
					nextFlag = false;
					return false;
				}
				var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//�ֱ��ȡ��������
            var key = checkNameStr(code); //У��
            if(key == undefined){
              rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
                obj.value = "";
              	nextFlag = false;
                return false;
            }	
       }
       else{
					/*��ȡ�������ĺ��ֵĸ����Լ�'()����'�ĸ���*/
					var m = /^[\u0391-\uFFE5]*$/;
					var mm = /^��|\.|\��*$/;
					var chinaLength = 0;
					var kuohaoLength = 0;
					var zhongjiandianLength=0;
					for (var i = 0; i < objValue.length; i ++){
			          var code = objValue.charAt(i);//�ֱ��ȡ��������
			          var flag22=mm.test(code);
			          var flag = m.test(code);
			          /*��У������*/
			          if(forKuoHao(code)){
			          	kuohaoLength ++;
			          }else if(flag){
			          	chinaLength ++;
			          }else if(flag22){
			          	zhongjiandianLength++;
			          }
			    }
			    var machLength = chinaLength + kuohaoLength+zhongjiandianLength;
					/*���ŵ�����+���ֵ����� != ������ʱ ��ʾ������Ϣ(������Ҫע��һ�㣬��������Ҳ�����ġ�������������ֻ����Ӣ�����ŵ�ƥ������������ƥ����)*/
					if(objValueLength != machLength || chinaLength == 0){
						rdShowMessageDialog(objName+"�����������Ļ����������ŵ����(���ſ���Ϊ���Ļ�Ӣ�����š�()������)��");
						/*��ֵΪ��*/
						obj.value = "";
						
						nextFlag = false;
						return false;
					}else if(objValueLength == machLength && chinaLength != 0){
						if(objValueLength < 2){
							rdShowMessageDialog(objName+"������ڵ���2�����ĺ��֣�");
							
							nextFlag = false;
							return false;
						}
					}
					/*ԭ���߼�
					if(idTypeText == "0" || idTypeText == "2"){
						if(objValueLength > 6){
							rdShowMessageDialog(objName+"�������6�����֣�");
							
							nextFlag = false;
							return false;
						}
				}
				*/
			}
       
		}
		/*�������������� У�� ��������տͻ�����(�����������ϵ������Ҳͬ��(sunaj��ȷ��))�������3���ַ�����ȫΪ����������*/
		if(idTypeText == "6"){
			/*���У��ͻ�����*/
				if(objValue % 2 == 0 || objValue % 2 == 1){
						rdShowMessageDialog(objName+"����ȫΪ����������!");
						/*��ֵΪ��*/
						obj.value = "";
						
						nextFlag = false;
						return false;
				}
				if(objValueLength <= 3){
						rdShowMessageDialog(objName+"������������ַ�!");
						
						nextFlag = false;
						return false;
				}
         var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//�ֱ��ȡ��������
            var key = checkNameStr(code); //У��
            if(key == undefined){
              rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
		}
		
		
		if(ifConnect == 0){
		
		if(nextFlag){
		 if(objType == 0){
		 	/*��ϵ��������ͻ����Ƹ������ı�*/
			document.all.contactPerson.value = objValue;
			 
		 	}	
		}
			}
		
	}	
	return nextFlag;
}



/*
	2013/11/18 11:15:44
	gaopeng
	�ͻ���ַ��֤����ַ����ϵ�˵�ַУ�鷽��
	���ͻ���ַ������֤����ַ���͡���ϵ�˵�ַ�����衰���ڵ���8�����ĺ��֡�
	����������պ�̨��ͨ��֤���⣬���������Ҫ�����2�����֣�̨��ͨ��֤Ҫ�����3�����֣�
*/

function checkAddrFunc(obj,objType,ifConnect){
	var nextFlag = true;
	var objName = "";
	var idTypeVal = "";
	if(objType == 0){
		objName = "֤����ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "�ͻ���ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 2){
		objName = "��ϵ�˵�ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 3){
		objName = "��ϵ��ͨѶ��ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 4){
		objName = "��������ϵ��ַ";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 5){
		objName = "��������ϵ��ַ";
		idTypeVal = document.all.responsibleType.value;
	}	
	idTypeVal = $.trim(idTypeVal);
	/*ֻ��Ը��˿ͻ�*/
	var opCode = "<%=opCode%>";
	/*��ȡ������ֵ*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*��ȡ�����ֵ�ĳ���*/
	var objValueLength = objValue.length;
	
	if(objValue != ""){
		/* ��ȡ��ѡ���֤������ 
		0|���֤ 1|����֤ 2|���ڲ� 3|�۰�ͨ��֤ 
		4|����֤ 5|̨��ͨ��֤ 6|��������� 7|���� 
		8|Ӫҵִ�� 9|���� A|��֯�������� B|��λ����֤�� C|������ 
		*/
		
		/*��ȡ֤���������� */
		var idTypeText = idTypeVal.split("|")[0];
		
		/*��ȡ�������ĺ��ֵĸ���*/
		var m = /^[\u0391-\uFFE5]*$/;
		var chinaLength = 0;
		for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//�ֱ��ȡ��������
          var flag = m.test(code);
          if(flag){
          	chinaLength ++;
          }
    }
      
		/*����Ȳ������������ Ҳ����̨��ͨ��֤ */
		if(idTypeText != "6" && idTypeText != "5"){
			/*��������8�����ĺ���*/
			if(chinaLength < 8){
				rdShowMessageDialog(objName+"���뺬������8�����ĺ��֣�");
				/*��ֵΪ��*/
				obj.value = "";
				
				nextFlag = false;
				return false;
			}
		
	}
	/*��������� ����2������*/
	if(idTypeText == "6"){
		/*����2�����ĺ���*/
			if(chinaLength <= 2){
				rdShowMessageDialog(objName+"���뺬�д���2�����ĺ��֣�");
				
				nextFlag = false;
				return false;
			}
	}
	/*̨��ͨ��֤ ����3������*/
	if(idTypeText == "5"){
		/*��������3���ĺ���*/
			if(chinaLength <= 3){
				rdShowMessageDialog(objName+"���뺬�д���3�����ĺ��֣�");
				
				nextFlag = false;
				return false;
			}
	}
	/*������ֵ ifConnect ��0ʱ�Ÿ�ֵ�����򲻸�ֵ*/
	if(ifConnect == 0){
		if(nextFlag){
			/*֤����ַ�ı�ʱ����ֵ������ַ*/
			if(objType == 0){
			    document.all.custAddr.value=objValue;
			    document.all.contactAddr.value=objValue;
			    document.all.contactMAddr.value=objValue;
			}
			/*�ͻ���ַ�ı�ʱ����ֵ��ϵ�˵�ַ����ϵ��ͨѶ��ַ*/
			if(objType == 1){
				document.all.contactAddr.value = objValue;
	  		document.all.contactMAddr.value = objValue;
			}
			/*��ϵ�˵�ַ�ı�ʱ����ֵ��ϵ��ͨѶ��ַ��2013/12/16 15:20:17 20131216 gaopeng ��ֵ��������ϵ��ַ����*/
			if(objType == 2){
				document.all.contactMAddr.value=objValue;
				document.all.gestoresAddr.value=objValue;
				document.all.responsibleAddr.value=objValue;
			}
		}
	}
	
	
}
return nextFlag;
}

/*
	2013/11/18 14:01:09
	gaopeng
	֤�����ͱ��ʱ��֤�������У�鷽��
*/

function checkIccIdFunc(obj,objType,ifConnect){
	var nextFlag = true;
	var idTypeVal = "";
	if(objType == 0){
		var objName = "֤������";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "������֤������";
		idTypeVal = document.all.gestoresIdType.value;
	}	
	if(objType == 2){
		objName = "������֤������";
		idTypeVal = document.all.responsibleType.value;
	}	
	
	/*ֻ��Ը��˿ͻ�*/
	var opCode = "<%=opCode%>";
	/*��ȡ������ֵ*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*��ȡ�����ֵ�ĳ���*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* ��ȡ��ѡ���֤������ 
		0|���֤ 1|����֤ 2|���ڲ� 3|�۰�ͨ��֤ 
		4|����֤ 5|̨��ͨ��֤ 6|��������� 7|���� 
		8|Ӫҵִ�� 9|���� A|��֯�������� B|��λ����֤�� C|������ 
		*/
		
		/*��ȡ֤���������� */
		var idTypeText = idTypeVal.split("|")[0];
		
		/*1�����֤�����ڱ�ʱ��֤�����볤��Ϊ18λ*/
		if(idTypeText == "0" || idTypeText == "2"){
			if(objValueLength != 18){
					rdShowMessageDialog(objName+"������18λ��");
					
					nextFlag = false;
					return false;
			}
		}
		/*����֤ ����֤ ���������ʱ ֤��������ڵ���6λ�ַ�*/
		if(idTypeText == "1" || idTypeText == "4" || idTypeText == "6"){
			if(objValueLength < 6){
					rdShowMessageDialog(objName+"������ڵ�����λ�ַ���");
					
					nextFlag = false;
					return false;
			}
		}
		/*֤������Ϊ�۰�ͨ��֤�ģ�֤������Ϊ9λ��11λ��������λΪӢ����ĸ��H����M��(ֻ�����Ǵ�д)������λ��Ϊ���������֡�*/
		if(idTypeText == "3"){
			if(objValueLength != 9 && objValueLength != 11){
					rdShowMessageDialog(objName+"������9λ��11λ��");
					
					nextFlag = false;
					return false;
			}
			/*��ȡ����ĸ*/
			var valHead = objValue.substring(0,1);
			if(valHead != "H" && valHead != "M"){
					rdShowMessageDialog(objName+"����ĸ�����ǡ�H����M����");
					
					nextFlag = false;
					return false;
			}
			/*��ȡ����ĸ֮���������Ϣ*/
			var varWithOutHead = objValue.substring(1,objValue.length);
			if(varWithOutHead % 2 != 0 && varWithOutHead % 2 != 1){
					rdShowMessageDialog(objName+"������ĸ֮�⣬����λ�����ǰ��������֣�");
					
					nextFlag = false;
					return false;
			}
		}
		/*֤������Ϊ
			̨��ͨ��֤ 
			֤������ֻ����8λ��11λ
			֤������Ϊ11λʱǰ10λΪ���������֣�
			���һλΪУ����(Ӣ����ĸ���������֣���
			֤������Ϊ8λʱ����Ϊ����������
		*/
		if(idTypeText == "5"){
			if(objValueLength != 8 && objValueLength != 11){
					rdShowMessageDialog(objName+"����Ϊ8λ��11λ��");
					
					nextFlag = false;
					return false;
			}
			/*8λʱ����Ϊ����������*/
			if(objValueLength == 8){
				if(objValue % 2 != 0 && objValue % 2 != 1){
					rdShowMessageDialog(objName+"����Ϊ����������");
					
					nextFlag = false;
					return false;
				}
			}
			/*11λʱ�����һλ������Ӣ����ĸ���������֣�ǰ10λ�����ǰ���������*/
			if(objValueLength == 11){
				var objValue10 = objValue.substring(0,10);
				if(objValue10 % 2 != 0 && objValue10 % 2 != 1){
					rdShowMessageDialog(objName+"ǰʮλ����Ϊ����������");
					
					nextFlag = false;
					return false;
				}
				var objValue11 = objValue.substring(10,11);
  			var m = /^[A-Za-z]+$/;
				var flag = m.test(objValue11);
				
				if(!flag && objValue11 % 2 != 0 && objValue11 % 2 != 1){
					rdShowMessageDialog(objName+"��11λ����Ϊ���������ֻ�Ӣ����ĸ��");
					
					nextFlag = false;
					return false;
				}
			}
			
		}
		/*��֯������ ֤��������ڵ���9λ��Ϊ���֡���-�����д������ĸ*/
		if(idTypeText == "A"){
		 if(objValueLength != 10){
					rdShowMessageDialog(objName+"������10λ��");				
					nextFlag = false;
					return false;
			}
			if(objValue.substr(objValueLength-2,1)!="-" && objValue.substr(objValueLength-2,1)!="��") {
					rdShowMessageDialog(objName+"�����ڶ�λ�����ǡ�-����");				
					nextFlag = false;
					return false;			
			}
		}
		/*Ӫҵִ�� ֤�����������ڵ���4λ���֣����������纺�ֵ��ַ�Ҳ�Ϲ�*/
		if(idTypeText == "8"){
		
		 if(objValueLength != 13 && objValueLength != 15 && objValueLength != 18 && objValueLength != 20){
					rdShowMessageDialog(objName+"������13λ��15λ��18λ��20λ��");				
					nextFlag = false;
					return false;
			}
				    
			var m = /^[\u0391-\uFFE5]*$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//�ֱ��ȡ��������
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum > 0){
					rdShowMessageDialog(objName+"������¼�뺺�֣�");				
					nextFlag = false;
					return false;
			}

		}
		/*����֤�� ֤��������ڵ���4λ�ַ�*/
		if(idTypeText == "B"){
		 if(objValueLength != 12){
					rdShowMessageDialog(objName+"������12λ��");				
					nextFlag = false;
					return false;
			}
				    
			var m = /^[\u0391-\uFFE5]*$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//�ֱ��ȡ��������
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum > 0){
					rdShowMessageDialog(objName+"������¼�뺺�֣�");				
					nextFlag = false;
					return false;
			}
			
		}	
		/*����ԭ���߼�*/
		rpc_chkX('idType','idIccid','A');
		
	}
	return nextFlag;
}

/**
 * hejwa add 2015/5/12 14:40:16
 * ���ڽ�һ����ǿʡ��֧��ϵͳʵ�����Ǽǹ��ܵ�֪ͨ
 * 2���޸ġ�GSM����(1238)���͡�ʵ���Ǽ�(m058)�����ܣ��½��ͻ�ʱ��������֤�������Ǻ�������ĺ��룬
 *	  �򵯳���ʾ�򡣼���ͻ�����һ�¼���
 */
function rpc_chkX(x_type,x_no,chk_kind)
{
  var obj_type=document.all(x_type);
  var obj_no=document.all(x_no);
  var idname="";

  if(obj_type.type=="text")
  {
    idname=(obj_type.value).trim();
  }
  else if(obj_type.type=="select-one")
  {
    idname=(obj_type.options[obj_type.selectedIndex].text).trim();  
  }

  if((obj_no.value).trim().length>0)
  {
  	
   
      if(idname=="���֤")
    {
        if(checkElement(obj_no)==false) return false;
    }
  
  }
  else 
  return;
  var myPacket = new AJAXPacket("/npage/innet/chkX.jsp","������֤��������Ϣ�����Ժ�......");
    myPacket.data.add("retType","chkX");
    myPacket.data.add("retObj",x_no);
    myPacket.data.add("x_idType",getX_idno(idname));
    myPacket.data.add("x_idNo",obj_no.value);
    myPacket.data.add("x_chkKind",chk_kind);
    core.ajax.sendPacket(myPacket);
    myPacket=null;
  
}

   
   
   
/*
	2013/11/15 15:33:56 gaopeng ���ڽ�һ������ʡ��֧��ϵͳʵ���Ǽǹ��ܵ�֪ͨ  
	ע�⣺ֻ��Ը��˿ͻ� end
*/ 

/*2013/12/16 15:41:14 gaopeng ������֤�������������ı亯��*/
function validateGesIdTypes(idtypeVal){
	
		if(idtypeVal.indexOf("���֤") != -1){
  		document.all.gestoresIccId.v_type = "idcard";
  		$("#scan_idCard_two3").css("display","");
  		$("#scan_idCard_two31").css("display","");
  		$("input[name='gestoresName']").attr("class","InputGrey");
  		$("input[name='gestoresName']").attr("readonly","readonly");
  		$("input[name='gestoresAddr']").attr("class","InputGrey");
  		$("input[name='gestoresAddr']").attr("readonly","readonly");
  		$("input[name='gestoresIccId']").attr("class","InputGrey");
  		$("input[name='gestoresIccId']").attr("readonly","readonly");
  		$("input[name='gestoresName']").val("");
  		$("input[name='gestoresAddr']").val("");
  		$("input[name='gestoresIccId']").val("");

  	}else{
  		document.all.gestoresIccId.v_type = "string";
  		$("#scan_idCard_two3").css("display","none");
  		$("#scan_idCard_two31").css("display","none");
  		$("input[name='gestoresName']").removeAttr("class");
  		$("input[name='gestoresName']").removeAttr("readonly");
  		$("input[name='gestoresAddr']").removeAttr("class");
  		$("input[name='gestoresAddr']").removeAttr("readonly");
  		$("input[name='gestoresIccId']").removeAttr("class");
  		$("input[name='gestoresIccId']").removeAttr("readonly");

  	}
}

function validateresponIdTypes(idtypeVal){
		if(idtypeVal.indexOf("���֤") != -1){
  		document.all.responsibleIccId.v_type = "idcard";
  			$("#scan_idCard_two3zrr").css("display","");
  			$("#scan_idCard_two57zrr").css("display","");
	  		$("input[name='responsibleName']").attr("class","InputGrey");
	  		$("input[name='responsibleName']").attr("readonly","readonly");
	  		$("input[name='responsibleAddr']").attr("class","InputGrey");
	  		$("input[name='responsibleAddr']").attr("readonly","readonly");
	  		$("input[name='responsibleIccId']").attr("class","InputGrey");
	  		$("input[name='responsibleIccId']").attr("readonly","readonly");
	  		$("input[name='responsibleName']").val("");
	  		$("input[name='responsibleAddr']").val("");
	  		$("input[name='responsibleIccId']").val("");
  		
  	}else{
  		document.all.responsibleIccId.v_type = "string";
  			$("#scan_idCard_two3zrr").css("display","none");
  			$("#scan_idCard_two57zrr").css("display","none");
	  		$("input[name='responsibleName']").removeAttr("class");
	  		$("input[name='responsibleName']").removeAttr("readonly");
	  		$("input[name='responsibleAddr']").removeAttr("class");
	  		$("input[name='responsibleAddr']").removeAttr("readonly");
	  		$("input[name='responsibleIccId']").removeAttr("class");
	  		$("input[name='responsibleIccId']").removeAttr("readonly");
  		
  	}
}


//20091201 begin
/*
function GoodPhoneDateChg()
{
	if(document.all.GoodPhoneFlag.value == "Y")
	{
		//����ʵ���Ǽ�,Ĭ�Ͽ�ʵ���Ǽ�ʱ��Ϊϵͳʱ���Ҹ�ʱ����޸�
		document.all.GoodPhoneDate.value = <%=sysDate_Good%>;
		document.all.GoodPhoneDate.disabled=false;
	}
	else if(document.all.GoodPhoneFlag.value == "N")
	{
		//������ʵ���Ǽ�,Ĭ�Ͽ�ʵ���Ǽ�ʱ��Ϊ�̶�ʱ���Ҹ�ʱ�䲻���޸�
		document.all.GoodPhoneDate.value="20500101";
		document.all.GoodPhoneDate.disabled=true;
	}
	else
	{
		//��ʵ���Ǽ�������,��ʵ���Ǽ�ʱ�䲻���޸�
		document.all.GoodPhoneDate.value="";
		document.all.GoodPhoneDate.disabled=true;
	}
}
*/
//20091201 end

	  function doProcess(packet)
	  {
			//RPC������findValueByName
			var retType = packet.data.findValueByName("retType");
			var retCode = packet.data.findValueByName("retCode");
			var retMessage = packet.data.findValueByName("retMessage");
			self.status="";
			if(jtrim(retCode)=="")
			{
			   rdShowMessageDialog("����"+retType+"����ʱʧ�ܣ�");
			   return false;
			}
			//---------------------------------------
			if(retType == "chkID")
			{
				//�õ��½��ͻ�ID
				var retnewId = packet.data.findValueByName("retnewId");
				if(retCode=="000000")
				{
				   var h_custName = packet.data.findValueByName("cust_name");
				   var h_contactPhone = packet.data.findValueByName("contact_phone");
				   var h_contactAddr = packet.data.findValueByName("contact_address");
				   var h_idIccid = packet.data.findValueByName("ic_iccid");
				   var h_idAddr = packet.data.findValueByName("id_address");

				   document.all.h_custName.value=h_custName;
				   document.all.h_contactPhone.value=h_contactPhone;
				   document.all.h_contactAddr.value=h_contactAddr;
				   document.all.h_idIccid.value=h_idIccid;
				   document.all.h_idAddr.value=h_idAddr;

				   //���������벻��ͨ��
			   	  if("09" == "<%=regionCode%>"){
					 if(document.all.passwd.value == "000000"||document.all.passwd.value == "111111"||document.all.passwd.value == "222222"
		 	 		  ||document.all.passwd.value == "333333"||document.all.passwd.value == "444444"||document.all.passwd.value == "555555"
		 	 		  ||document.all.passwd.value == "666666"||document.all.passwd.value == "777777"||document.all.passwd.value == "888888"
		 	 		  ||document.all.passwd.value == "999999"||document.all.passwd.value == "123456")
	   				  {
	   						rdShowMessageDialog("������ڼ򵥣����޸ĺ��ٰ���ҵ��");
	   						return false;
	   				  }
	   			  }

		          rdShowMessageDialog("У���¿ͻ�ID�ɹ���",2);
	   			  document.all.b_print.disabled=false;
				}else{
					if(retCode=="000001"){
             rdShowMessageDialog("�������");
 					}
					if(retCode=="000001"){
					   if(rdShowConfirmDialog("�¿ͻ�ID�����ڣ��Ƿ��¿�����")==1){
                getId();
 					   }else{
                //rdShowMessageDialog("���޷���������ʵ���Ǽ�ҵ��");
						 		return false;
					   }
					}else{
					   retMessage = "����" + retCode + "��"+retMessage;
					   rdShowMessageDialog(retMessage);
					   document.all.passwd.value="";
					   document.all.new_srv_no.focus();
					   return false;
					}
				}
			 }
			 //----------------
	if(retType=="chkX_1"){
    var retObj = packet.data.findValueByName("retObj");

		if(retCode == "000000"){
       rdShowMessageDialog(retMessage,2);
       blackFlag=true;
		}else{
       retMessage = "����" + retCode + "��"+retMessage;
       rdShowMessageDialog(retMessage);
			 blackFlag=false;
			 document.all(retObj).focus();
			 return false;
    }
	}

	if(retType=="chkX_2")
	{
    var retObj = packet.data.findValueByName("retObj");
		if(retCode == "000000"){
       assuBlackFlag=true;
		}else{
		  retMessage = "����" + retCode + "��"+retMessage;
		  rdShowMessageDialog(retMessage);
		  assuBlackFlag=false;
		  document.all(retObj).focus();
		  return false;
    }
	}
	if(retType=="chkX_3")
	{
    var retObj = packet.data.findValueByName("retObj");
		if(retCode == "000000"){
          blackFlag3=true;
		}else{
		  retMessage = "����" + retCode + "��"+retMessage;
		  rdShowMessageDialog(retMessage);
		  blackFlag3=true;
		  document.all(retObj).focus();
		  return true;
    }
	}
     //----------------------------------
 	if(retType == "qryID")
	{
		//�õ��½��ͻ�ID
		var new_cus_id = packet.data.findValueByName("new_cus_id");
		var main_str1 = packet.data.findValueByName("main_str1");
		var fj_str1 = packet.data.findValueByName("fj_str1");
		var main_note = packet.data.findValueByName("main_note");
		if(retCode=="000000")
		{
			document.all.new_cus_id.value = new_cus_id;
			document.all.main_str1.value = main_str1;
			document.all.fj_str1.value = fj_str1;
			document.all.main_note.value = main_note;
			rdShowMessageDialog("�·������У��ɹ�!",2);
 		}
		else
		{
			retMessage = "����" + retCode + "��"+retMessage;
			rdShowMessageDialog(retMessage);
			document.all.new_srv_no.value="";
			document.all.new_srv_no.focus();
			return false;
		}
	}
	if(retType == "getID")
	{
 		//�õ��½��ͻ�ID
		var retnewId = packet.data.findValueByName("retnewId");
		if(retCode=="000000")
		{
			document.all.new_cus_id.value = retnewId;
			document.all.custId.value = retnewId;
			document.all.b_print.disabled=false;
		}else
		{
			retMessage = "����" + retCode + "��"+retMessage;
			rdShowMessageDialog(retMessage);
			return false;
		}
	}


	var cussid=packet.data.findValueByName("cussid");
	if(cussid!=null)
	{
	   if(cussid!="")
       document.all.new_cus_id.value=cussid;
	   else
	   {
	      rdShowMessageDialog("û�д˿ͻ���");
          document.all.new_cus_id.focus();
	   }
 	}
 	//dujl add at 20100428 for ���֤��֤
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
			document.all.get_Photo.disabled=true;
	 	}
	 	document.all.iccIdCheck.disabled=false;
	 }

	 if(retType=="iccIdCheck1")
	 {
	 	if(retCode == "000000")
	 	{
	 		rdShowMessageDialog("У��ͨ����");
	 		document.all.get_Photo1.disabled=false;
	 	}
	 	else
	 	{
	 		retMessage = retCode + "��"+retMessage;
			rdShowMessageDialog(retMessage);
			document.all.get_Photo1.disabled=true;
	 	}
	 	document.all.iccIdCheck1.disabled=false;
	 }
	 
	 
if(retType=="chkX")
   {
   	
    var retObj = packet.data.findValueByName("retObj");
    if(retCode == "000000"){
      }else if(retCode=="100001"){
        retMessage = retCode + "��"+retMessage;  
        rdShowMessageDialog(retMessage);     
        return true;
      }else{
        retMessage = "����" + retCode + "��"+retMessage;      
        rdShowMessageDialog(retMessage,0);
        return false;
       
    }
   }
}



/*1���ͻ����ơ���ϵ������ У�鷽�� objType 0 ����ͻ�����У�� 1������ϵ������У��  ifConnect �����Ƿ�������ֵ(���ȷ�ϰ�ťʱ��������������ֵ)*/
function checkCustNameFuncNew(obj,objType,ifConnect){
	var nextFlag = true;
	
	if(document.all.realUserName.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
	
	var objName = "";
	var idTypeVal = "";
	if(objType == 0){
		objName = "�ͻ�����";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "��ϵ������";
		idTypeVal = document.all.idType.value;
	}
	/*2013/12/16 11:24:47 gaopeng ������BOSS�����������ӵ�λ�ͻ���������Ϣ�ĺ� ���뾭��������*/
	if(objType == 2){
		objName = "����������";
		/*�����վ�����֤������*/
		idTypeVal = document.all.gestoresIdType.value;
	}
	
	if(objType == 3){
		objName = "ʵ��ʹ��������";
		/*�����վ�����֤������*/
		idTypeVal = document.all.realUserIdType.value;
	}
	
	idTypeVal = $.trim(idTypeVal);
	
	/*ֻ��Ը��˿ͻ�*/
	var opCode = "<%=opCode%>";
	/*��ȡ������ֵ*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*��ȡ�����ֵ�ĳ���*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* ��ȡ��ѡ���֤������ 
		0|���֤ 1|����֤ 2|���ڲ� 3|�۰�ͨ��֤ 
		4|����֤ 5|̨��ͨ��֤ 6|��������� 7|���� 
		8|Ӫҵִ�� 9|���� A|��֯�������� B|��λ����֤�� C|������ 
		*/
		/*��ȡ֤���������� */
		var idTypeText = idTypeVal;
		
		/*����ʱ�����������Ķ�����*/
		if(objValue.indexOf("��ʱ") != -1 || objValue.indexOf("����") != -1){
					rdShowMessageDialog(objName+"���ܴ��С���ʱ���򡮴��졯������");
					
					nextFlag = false;
					return false;
			
		}
		
		/*�ͻ����ơ���ϵ��������Ҫ�󡰴��ڵ���2�����ĺ��֡�����������ճ��⣨��������տͻ����Ʊ������3���ַ�����ȫΪ����������)*/
		
		/*����������������*/
		if(idTypeText != "6"){
			/*ԭ�е�ҵ���߼�У�� ֻ������Ӣ�ġ����֡����ġ����ġ����ġ���������һ�����ԣ�*/
			
			/*2014/08/27 16:14:22 gaopeng ���ֹ�˾�����Ż������������Ƶ���ʾ Ҫ��λ�ͻ�ʱ���ͻ����ƿ�����дӢ�Ĵ�Сд��� Ŀǰ�ȸ�ɸ� idTypeText == "3" || idTypeText == "9" һ�����߼� �������ʿɲ�����*/
			if(idTypeText == "3" || idTypeText == "9" || idTypeText == "8" || idTypeText == "A" || idTypeText == "B" || idTypeText == "C"){
				if(objValueLength < 2){
					rdShowMessageDialog(objName+"������ڵ���2�����֣�");
					nextFlag = false;
					return false;
				}
				 var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//�ֱ��ȡ��������
            var key = checkNameStr(code); //У��
            if(key == undefined){
              rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
       }
       else{
					
					/*��ȡ�������ĺ��ֵĸ����Լ�'()����'�ĸ���*/
					var m = /^[\u0391-\uFFE5]*$/;
					var mm = /^��|\.|\��*$/;
					var chinaLength = 0;
					var kuohaoLength = 0;
					var zhongjiandianLength=0;
					for (var i = 0; i < objValue.length; i ++){
								
			          var code = objValue.charAt(i);//�ֱ��ȡ��������
			          var flag22=mm.test(code);
			          var flag = m.test(code);
			          /*��У������*/
			          if(forKuoHao(code)){
			          	kuohaoLength ++;
			          }else if(flag){
			          	chinaLength ++;
			          }else if(flag22){
			          	zhongjiandianLength++;
			          }
			          
			    }
			    var machLength = chinaLength + kuohaoLength+zhongjiandianLength;
					/*���ŵ�����+���ֵ����� != ������ʱ ��ʾ������Ϣ(������Ҫע��һ�㣬��������Ҳ�����ġ�������������ֻ����Ӣ�����ŵ�ƥ������������ƥ����)*/
					if(objValueLength != machLength || chinaLength == 0){
						rdShowMessageDialog(objName+"�����������Ļ����������ŵ����(���ſ���Ϊ���Ļ�Ӣ�����š�()������)��");
						/*��ֵΪ��*/
						obj.value = "";
						
						nextFlag = false;
						return false;
					}else if(objValueLength == machLength && chinaLength != 0){
						if(objValueLength < 2){
							rdShowMessageDialog(objName+"������ڵ���2�����ĺ��֣�");
							
							nextFlag = false;
							return false;
						}
					}
					/*ԭ���߼�
					if(idTypeText == "0" || idTypeText == "2"){
						if(objValueLength > 6){
							rdShowMessageDialog(objName+"�������6�����֣�");
							
							nextFlag = false;
							return false;
						}
				}
				*/
			}
       
		}
		/*�������������� У�� ��������տͻ�����(�����������ϵ������Ҳͬ��(sunaj��ȷ��))�������3���ַ�����ȫΪ����������*/
		if(idTypeText == "6"){
			/*���У��ͻ�����*/
				if(objValue % 2 == 0 || objValue % 2 == 1){
						rdShowMessageDialog(objName+"����ȫΪ����������!");
						/*��ֵΪ��*/
						obj.value = "";
						
						nextFlag = false;
						return false;
				}
				if(objValueLength <= 3){
						rdShowMessageDialog(objName+"������������ַ�!");
						
						nextFlag = false;
						return false;
				}
				var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//�ֱ��ȡ��������
            var key = checkNameStr(code); //У��
            if(key == undefined){
              rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
				
		}
		
		
		
	}	
	return nextFlag;
}


/*
	2013/11/18 11:15:44
	gaopeng
	�ͻ���ַ��֤����ַ����ϵ�˵�ַУ�鷽��
	���ͻ���ַ������֤����ַ���͡���ϵ�˵�ַ�����衰���ڵ���8�����ĺ��֡�
	����������պ�̨��ͨ��֤���⣬���������Ҫ�����2�����֣�̨��ͨ��֤Ҫ�����3�����֣�
*/

function checkAddrFuncNew(obj,objType,ifConnect){
	var nextFlag = true;
	
		if(document.all.realUserAddr.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
	var objName = "";
	var idTypeVal = ""
	if(objType == 0){
		objName = "֤����ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "�ͻ���ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 2){
		objName = "��ϵ�˵�ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 3){
		objName = "��ϵ��ͨѶ��ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 4){
		objName = "��������ϵ��ַ";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 5){
		objName = "ʵ��ʹ������ϵ��ַ";
		idTypeVal = document.all.realUserIdType.value;
	}
		
	idTypeVal = $.trim(idTypeVal);
	/*ֻ��Ը��˿ͻ�*/
	var opCode = "<%=opCode%>";
	/*��ȡ������ֵ*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*��ȡ�����ֵ�ĳ���*/
	var objValueLength = objValue.length;
	
	if(objValue != ""){
		/* ��ȡ��ѡ���֤������ 
		0|���֤ 1|����֤ 2|���ڲ� 3|�۰�ͨ��֤ 
		4|����֤ 5|̨��ͨ��֤ 6|��������� 7|���� 
		8|Ӫҵִ�� 9|���� A|��֯�������� B|��λ����֤�� C|������ 
		*/
		
		/*��ȡ֤���������� */
		var idTypeText = idTypeVal;
		
		/*��ȡ�������ĺ��ֵĸ���*/
		var m = /^[\u0391-\uFFE5]*$/;
		var chinaLength = 0;
		for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//�ֱ��ȡ��������
          var flag = m.test(code);
          if(flag){
          	chinaLength ++;
          }
    }
      
		/*����Ȳ������������ Ҳ����̨��ͨ��֤ */
		if(idTypeText != "6" && idTypeText != "5"){
			/*��������8�����ĺ���*/
			if(chinaLength < 8){
				rdShowMessageDialog(objName+"���뺬������8�����ĺ��֣�");
				/*��ֵΪ��*/
				obj.value = "";
				
				nextFlag = false;
				return false;
			}
		
	}
	/*��������� ����2������*/
	if(idTypeText == "6"){
		/*����2�����ĺ���*/
			if(chinaLength <= 2){
				rdShowMessageDialog(objName+"���뺬�д���2�����ĺ��֣�");
				
				nextFlag = false;
				return false;
			}
	}
	/*̨��ͨ��֤ ����3������*/
	if(idTypeText == "5"){
		/*��������3���ĺ���*/
			if(chinaLength <= 3){
				rdShowMessageDialog(objName+"���뺬�д���3�����ĺ��֣�");
				
				nextFlag = false;
				return false;
			}
	}
	
	
}
return nextFlag;
}

/*
	2013/11/18 14:01:09
	gaopeng
	֤�����ͱ��ʱ��֤�������У�鷽��
*/

function checkIccIdFuncNew(obj,objType,ifConnect){
	var nextFlag = true;
	
	if(document.all.realUserIccId.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
	var idTypeVal = "";
	if(objType == 0){
		var objName = "֤������";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "������֤������";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 2){
		objName = "ʵ��ʹ����֤������";
		idTypeVal = document.all.realUserIdType.value;
	}
	
	/*ֻ��Ը��˿ͻ�*/
	var opCode = "<%=opCode%>";
	/*��ȡ������ֵ*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*��ȡ�����ֵ�ĳ���*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* ��ȡ��ѡ���֤������ 
		0|���֤ 1|����֤ 2|���ڲ� 3|�۰�ͨ��֤ 
		4|����֤ 5|̨��ͨ��֤ 6|��������� 7|���� 
		8|Ӫҵִ�� 9|���� A|��֯�������� B|��λ����֤�� C|������ 
		*/
		
		/*��ȡ֤���������� */
		var idTypeText = idTypeVal;
		
		/*1�����֤�����ڱ�ʱ��֤�����볤��Ϊ18λ*/
		if(idTypeText == "0" || idTypeText == "2"){
			if(objValueLength != 18){
					rdShowMessageDialog(objName+"������18λ��");
					
					nextFlag = false;
					return false;
			}
		}
		/*����֤ ����֤ ���������ʱ ֤��������ڵ���6λ�ַ�*/
		if(idTypeText == "1" || idTypeText == "4" || idTypeText == "6"){
			if(objValueLength < 6){
					rdShowMessageDialog(objName+"������ڵ�����λ�ַ���");
					
					nextFlag = false;
					return false;
			}
		}
		/*֤������Ϊ�۰�ͨ��֤�ģ�֤������Ϊ9λ��11λ��������λΪӢ����ĸ��H����M��(ֻ�����Ǵ�д)������λ��Ϊ���������֡�*/
		if(idTypeText == "3"){
			if(objValueLength != 9 && objValueLength != 11){
					rdShowMessageDialog(objName+"������9λ��11λ��");
					
					nextFlag = false;
					return false;
			}
			/*��ȡ����ĸ*/
			var valHead = objValue.substring(0,1);
			if(valHead != "H" && valHead != "M"){
					rdShowMessageDialog(objName+"����ĸ�����ǡ�H����M����");
					
					nextFlag = false;
					return false;
			}
			/*��ȡ����ĸ֮���������Ϣ*/
			var varWithOutHead = objValue.substring(1,objValue.length);
			if(varWithOutHead % 2 != 0 && varWithOutHead % 2 != 1){
					rdShowMessageDialog(objName+"������ĸ֮�⣬����λ�����ǰ��������֣�");
					
					nextFlag = false;
					return false;
			}
		}
		/*֤������Ϊ
			̨��ͨ��֤ 
			֤������ֻ����8λ��11λ
			֤������Ϊ11λʱǰ10λΪ���������֣�
			���һλΪУ����(Ӣ����ĸ���������֣���
			֤������Ϊ8λʱ����Ϊ����������
		*/
		if(idTypeText == "5"){
			if(objValueLength != 8 && objValueLength != 11){
					rdShowMessageDialog(objName+"����Ϊ8λ��11λ��");
					
					nextFlag = false;
					return false;
			}
			/*8λʱ����Ϊ����������*/
			if(objValueLength == 8){
				if(objValue % 2 != 0 && objValue % 2 != 1){
					rdShowMessageDialog(objName+"����Ϊ����������");
					
					nextFlag = false;
					return false;
				}
			}
			/*11λʱ�����һλ������Ӣ����ĸ���������֣�ǰ10λ�����ǰ���������*/
			if(objValueLength == 11){
				var objValue10 = objValue.substring(0,10);
				if(objValue10 % 2 != 0 && objValue10 % 2 != 1){
					rdShowMessageDialog(objName+"ǰʮλ����Ϊ����������");
					
					nextFlag = false;
					return false;
				}
				var objValue11 = objValue.substring(10,11);
  			var m = /^[A-Za-z]+$/;
				var flag = m.test(objValue11);
				
				if(!flag && objValue11 % 2 != 0 && objValue11 % 2 != 1){
					rdShowMessageDialog(objName+"��11λ����Ϊ���������ֻ�Ӣ����ĸ��");
					
					nextFlag = false;
					return false;
				}
			}
			
		}
		/*��֯������ ֤��������ڵ���9λ��Ϊ���֡���-�����д������ĸ*/
		if(idTypeText == "A"){
			var m = /^([0-9\-A-Z]*)$/;
			var flag = m.test(objValue);
			if(!flag){
					rdShowMessageDialog(objName+"���������֡���-�������д��ĸ��ɣ�");
					
					nextFlag = false;
					return false;
			}
			if(objValueLength < 9){
					rdShowMessageDialog(objName+"������ڵ���9λ��");
					
					nextFlag = false;
					return false;
				
			}
		}
		/*Ӫҵִ�� ֤�����������ڵ���4λ���֣����������纺�ֵ��ַ�Ҳ�Ϲ�*/
		if(idTypeText == "8"){
			var m = /^[0-9]+$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//�ֱ��ȡ��������
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum < 4){
					rdShowMessageDialog(objName+"��������4�����֣�");
					
					nextFlag = false;
					return false;
			}
			/*20131216 gaopeng ������BOSS�����������ӵ�λ�ͻ���������Ϣ�ĺ� �����е�֤������Ϊ��Ӫҵִ�ա�ʱ��Ҫ��֤�������λ��Ϊ15λ�ַ�*/
			if(objValueLength != 15){
					rdShowMessageDialog(objName+"����Ϊ15���ַ���");
					nextFlag = false;
					return false;
			}
		}
		/*����֤�� ֤��������ڵ���4λ�ַ�*/
		if(idTypeText == "B"){
			if(objValueLength < 4){
					rdShowMessageDialog(objName+"������ڵ���4λ��");
					
					nextFlag = false;
					return false;
			}
			
		}


	}else if(opCode == "1993"){

	}
	return nextFlag;
}


	var printAddFlag = false;
	 //--------4---------��ʾ��ӡ�Ի���----------------
	 function printCommit()
	 {
	 		if("<%=realOpCode%>" == "m389"){
		 		var serviceFileName = $("input[name='serviceFileName']").val();
			 	if(serviceFileName.length == 0){
			 		rdShowMessageDialog( "���ϴ�ʵ���������ļ�!" , 0 );
					return false;
			 	}
			}
		 	
	 		/* begin add �� û�н��С����������ѯ��,���ܽ����ύ for ���ڵ绰�û�ʵ���Ǽǽ����ص㹤����֪ͨ @2014/11/4 */
			if("<%=opCode%>" == "m058"){
				if(document.all.r_cus[0].checked){ //�½��ͻ�
					var checkVal = document.all.isJSX.value;//���˿������� ��ͨ�ͻ���0
					var idTypeSelect = $("#idType option[@selected]").val();//֤�����ͣ����֤
					if(idTypeSelect.indexOf("|") != -1){
						var v_idTypeSelect = idTypeSelect.split("|")[0];
						if(checkVal == "0" && v_idTypeSelect == "0" && "<%=workChnFlag%>" == "1" && "<%=regionCodeFlag%>" == "Y"){ 
						 if("<%=appregionflag%>"=="0") {//�������app���ñ�����ֻ�ܽ��й�����ѯ��
							if(($("#isQryListResultFlag").val() == "N") && (parseInt($("#sendListOpenFlag").val()) > 0)){ //�Ѳ�ѯ�����б����·���������Ϊ���������У��
								rdShowMessageDialog("���Ƚ��й��������ѯ���ٽ���ʵ���Ǽ�!");
						    return false;		
								}
							}
						}
					}
				}
		  }
			/* end add for ���ڵ绰�û�ʵ���Ǽǽ����ص㹤����֪ͨ @2014/11/4 */	 
	 	//������������� 20100201 sunaj
		/*if("02" == "<%=regionCode%>")
		{
			if(document.all.custPwd.value == "000000"||document.all.custPwd.value == "111111"||document.all.custPwd.value == "222222"
		 	 ||document.all.custPwd.value == "333333"||document.all.custPwd.value == "444444"||document.all.custPwd.value == "555555"
		 	 ||document.all.custPwd.value == "666666"||document.all.custPwd.value == "777777"||document.all.custPwd.value == "888888"
		 	 ||document.all.custPwd.value == "999999"||document.all.custPwd.value == "123456")
	   		{
	   			rdShowMessageDialog("�ͻ�������ڼ򵥣����޸ĺ��ٰ���ҵ��");
	   			return false;
	   		}
	   		if(document.all.passwd.value == "000000"||document.all.passwd.value == "111111"||document.all.passwd.value == "222222"
		 	 ||document.all.passwd.value == "333333"||document.all.passwd.value == "444444"||document.all.passwd.value == "555555"
		 	 ||document.all.passwd.value == "666666"||document.all.passwd.value == "777777"||document.all.passwd.value == "888888"
		 	 ||document.all.passwd.value == "999999"||document.all.passwd.value == "123456")
	   		{
	   				rdShowMessageDialog("�ͻ�������ڼ򵥣����޸ĺ��ٰ���ҵ��");
	   				return false;
	   		}
	   	}
	   	*/
	   	
	  /*2013/11/18 15:09:28 gaopeng �����ύ֮ǰ��У�� ���ڽ�һ������ʡ��֧��ϵͳʵ���Ǽǹ��ܵ�֪ͨ start*/
		/*����У��*/
    		/*�ͻ�����*/
    		if(!checkCustNameFunc16New(document.all.custName,0,1)){
    			return false;
    		}
    		/*��ϵ������*/
    		if(!checkCustNameFunc(document.all.contactPerson,1,1)){
					return false;
				}
				/*֤����ַ*/
				if(!checkAddrFunc(document.all.idAddr,0,1)){
					return false;
				}
				/*�ͻ���ַ*/
				if(!checkAddrFunc(document.all.custAddr,1,1)){
					return false;
				}
				/*��ϵ�˵�ַ*/
				if(!checkAddrFunc(document.all.contactAddr,2,1)){
					return false;
				}
				/*��ϵ��ͨѶ��ַ*/
				if(!checkAddrFunc(document.all.contactMAddr,3,1)){
					return false;
				}
				/*֤������*/
				if(!checkIccIdFunc16New(document.all.idIccid,0,1)){
					return false;
				}
				else{
					rpc_chkX('idType','idIccid','A');
				}
				
				/*gaopeng 20131216 2013/12/16 19:50:11 ������BOSS�����������ӵ�λ�ͻ���������Ϣ�ĺ� ���뾭������Ϣȷ�Ϸ���ǰУ�� start*/
					if(!checkElement(document.all.gestoresName)){
						return false;
					}
					if(!checkElement(document.all.gestoresAddr)){
						return false;
					}
					if(!checkElement(document.all.gestoresIccId)){
						return false;
					}
					/*����������*/
					if(!checkCustNameFunc16New(document.all.gestoresName,1,1)){
						return false;
					}
					/*��������ϵ��ַ*/
					if(!checkAddrFunc(document.all.gestoresAddr,4,1)){
						return false;
					}
					/*������֤������*/
					if(!checkIccIdFunc16New(document.all.gestoresIccId,1,1)){
						return false;
					}
					else{
						rpc_chkX('idType','idIccid','A');
					}
					
				/*gaopeng 20131216 2013/12/16 19:50:11 ������BOSS�����������ӵ�λ�ͻ���������Ϣ�ĺ� ���뾭������Ϣȷ�Ϸ���ǰУ�� start*/
				
				
					/*����������*/
				if(!checkElement(document.all.responsibleName)){
					return false;
				}
				/*��������ϵ��ַ*/
				if(!checkElement(document.all.responsibleAddr)){
					return false;
				}
				/*������֤������*/
				if(!checkElement(document.all.responsibleIccId)){
					return false;
				}
				
			
				if(!checkCustNameFunc16New(document.all.responsibleName,2,1)){
					return false;
				}
			
				if(!checkAddrFunc(document.all.responsibleAddr,5,1)){
							return false;
				}
			
				if(!checkIccIdFunc16New(document.all.responsibleIccId,2,1)){
									return false;
				}				
				else{
					rpc_chkX('idType','idIccid','A');
				}
				
				/*ʵ��ʹ��������*/
				if(!checkElement(document.all.realUserName)){
					return false;
				}
				/*ʵ��ʹ������ϵ��ַ*/
				if(!checkElement(document.all.realUserAddr)){
					return false;
				}
				/*ʵ��ʹ����֤������*/
				if(!checkElement(document.all.realUserIccId)){
					return false;
				}
				
			  if(!checkCustNameFunc16New(document.all.realUserName,3,1)){
					return false;
				}
			
				if(!checkAddrFuncNew(document.all.realUserAddr,5,1)){
							return false;
					}
			
				if(!checkIccIdFunc16New(document.all.realUserIccId,3,1)){
									return false;
				}
				else{
					rpc_chkX('idType','idIccid','A');
				}

				/*ģ����֤���������� ���� ���������������� �����Ķ������� 24����*/
				if("<%=is_Z_flag%>"=="true" || "<%=isKd%>"=="true"){
					
				}else{
					if($("#is_sPwdAuthChk_sel").val()==""){
						rdShowMessageDialog("��ѡ��<%=if24MonthText%>");
						return false;						
					}
				}
		/*2013/11/18 15:09:28 gaopeng �����ύ֮ǰ��У�� ���ڽ�һ������ʡ��֧��ϵͳʵ���Ǽǹ��ܵ�֪ͨ end*/
	 	getAfterPrompt();
	 	
	 	/*���Ķ�*/
		
		if(("100001" == "<%=backCode%>" || "100002" == "<%=backCode%>") && ("<%=sNewSmName%>" == "dn" || "<%=sNewSmName%>" == "gn" || "<%=sNewSmName%>" == "zn") && "<%=ifCanShow%>" == "true"){
			if(rdShowConfirmDialog("<%=backInfo%>")==1){
				printAddFlag = true;
			}else{
				printAddFlag = false;
			};
			
		}
		$("#printAddFlag").val(printAddFlag+"");
		$("#backCode").val("<%=backCode%>");
		
		// in here form check
		showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
	 }

	 function showPrtDlg(printType,DlgMessage,submitCfm)
	 {
//----------------------add by huy 20050722
/* update �������ȡ����ݲ��ɼ������������ϻ����½��ͻ��� for ���ڹ��ֹ�˾�����Ż�M058ʵ���ƵǼ������������������ʾ@2015/2/11
		if(jtrim(document.all.xinYiDu.value).length==0)
		{
			   rdShowMessageDialog(document.all.xinYiDu.v_name+"����Ϊ�գ�");
               document.all.xinYiDu.focus();
			   return false;
		}
*/
//-----------------------
        if(document.all.tr_newCust.style.display=="")
		{
            //�жϷǿ���
			if(jtrim(document.all.custName.value).length==0)
			{
			   rdShowMessageDialog(document.all.custName.v_name+"����Ϊ�գ�");
               document.all.custName.focus();
			   return false;
			}
			if(jtrim(document.all.idIccid.value).length==0)
			{
			   rdShowMessageDialog(document.all.idIccid.v_name+"����Ϊ�գ�");
               document.all.idIccid.focus();
			   return false;
			}

			if(jtrim(document.all.idAddr.value).length==0)
			{
			   rdShowMessageDialog(document.all.idAddr.v_name+"����Ϊ�գ�");
               document.all.idAddr.focus();
			   return false;
			} else if (!checkElement(document.all.idAddr)){
			   rdShowMessageDialog(document.all.idAddr.v_name+"��������");
               document.all.idAddr.focus();
			   return false;
			}

			if(jtrim(document.all.custPwd.value).length==0)
			{
			   /*rdShowMessageDialog(document.all.custPwd.v_name+"����Ϊ�գ�");
               document.all.custPwd.focus();
			   return false;*/
			}
			else
			{
				if(jtrim(document.all.custPwd.value).length!=6)
				{
				   rdShowMessageDialog(document.all.custPwd.v_name+"��������");
				   document.all.custPwd.focus();
				   return false;
				}
			}
			if(jtrim(document.all.custAddr.value).length==0)
			{
			   rdShowMessageDialog(document.all.custAddr.v_name+"����Ϊ�գ�");
               document.all.custAddr.focus();
			   return false;
			} else if (!checkElement(document.all.custAddr)){
			   rdShowMessageDialog(document.all.custAddr.v_name+"��������");
               document.all.custAddr.focus();
			   return false;
			}
			/* begin update ��ϵ������Ϊ���� for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/10 */
			if(jtrim(document.all.contactPerson.value).length==0)
			{
			   rdShowMessageDialog(document.all.contactPerson.v_name+"����Ϊ�գ�");
         document.all.contactPerson.focus();
			   return false;
			}
			/* end update ��ϵ������Ϊ���� for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/10 */
			if(jtrim(document.all.contactPhone.value).length==0)
			{
			   rdShowMessageDialog(document.all.contactPhone.v_name+"����Ϊ�գ�");
               document.all.contactPhone.focus();
			   return false;
			}
			if(!checkElement(document.all.contactPhone)){
				rdShowMessageDialog(document.all.contactPhone.v_name+"��ʽ����ȷ��");
               document.all.contactPhone.focus();
			   return false;
			}

			if(jtrim(document.all.contactAddr.value).length==0)
			{
			   rdShowMessageDialog(document.all.contactAddr.v_name+"����Ϊ�գ�");
               document.all.contactAddr.focus();
			   return false;
			} else if (!checkElement(document.all.contactAddr)){
			   rdShowMessageDialog(document.all.contactAddr.v_name+"��������");
               document.all.contactAddr.focus();
			   return false;
			}

			if(jtrim(document.all.contactMAddr.value).length==0)
			{
			   rdShowMessageDialog(document.all.contactMAddr.v_name+"����Ϊ�գ�");
               document.all.contactMAddr.focus();
			   return false;
			} else if (!checkElement(document.all.contactMAddr)){
			   rdShowMessageDialog(document.all.contactMAddr.v_name+"��������");
               document.all.contactMAddr.focus();
			   return false;
			}

			change_idType('2');   //�жϿͻ�֤�������Ƿ������֤
			if(jtrim(document.all.contactMail.value) == "")
			{
				document.all.contactMail.value = "";
			}
			//�ж����ա�֤����Ч����Ч��	birthDay	idValidDate

			if((typeof(document.all.birthDay)!="undefined") &&
			   (document.all.birthDay.value != ""))
			{
				if(forDate(document.all.birthDay) == false)
				{	
				return false;		}
			}
			else if((typeof(document.all.yzrq)!="undefined")&&
			   (document.all.yzrq.value != ""))
			{
				if(forDate(document.all.yzrq) == false)
				{	return false;		}
			}

			var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());

			if(jtrim(document.all.idValidDate.value).length>0)
			{
			   if(forDate(document.all.idValidDate)==false) return false;

			   if(to_date(document.all.idValidDate)<=d)
			   {
				  rdShowMessageDialog("֤����Ч�ڲ������ڵ�ǰʱ�䣬���������룡");
				  document.all.idValidDate.focus();
				  document.all.idValidDate.select();
				  return false;
			   }
			}

			if(jtrim(document.all.birthDay.value).length>0)
			{
			   if(to_date(document.all.birthDay)>=d)
			   {
				 rdShowMessageDialog("���������ڲ������ڵ�ǰʱ�䣬���������룡");
				 document.all.birthDay.focus();
				 document.all.birthDay.select();
				 return false;
			   }
			}
			
		}
if((document.all.but_flag.value =="1")&&document.all.upbut_flag.value=="0"){//����֤
	rdShowMessageDialog("�����ϴ����֤��Ƭ",0);
	return false;
	}
        
var upflag =document.all.up_flag.value;//����֤
if(upflag==3&&(document.all.but_flag.value =="1"))//����֤
{
	rdShowMessageDialog("��ѡ��jpg����ͼ���ļ�");
	return false;
	}
if(upflag==4&&(document.all.but_flag.value =="1"))//����֤
{
	rdShowMessageDialog("����ɨ����ȡ֤����Ϣ");
	return false;
	}
	
	
if(upflag==5&&(document.all.but_flag.value =="1"))//����֤
{
	rdShowMessageDialog("��ѡ�����һ��ɨ����ȡ֤�������ɵ�֤��ͼ���ļ�"+document.all.pic_name.value);
	return false;
	}
			
if((document.all.but_flag.value =="1")&&document.all.upbut_flag.value=="0"){//����֤
	rdShowMessageDialog("�����ϴ����֤��Ƭ",0);
	return false;
	}
		//20091201 begin
		/*
		var da_te= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());
		if(document.all.GoodPhoneFlag.value == "Y")
		{
			if((document.all.GoodPhoneDate.value).trim().length != 8)
			{
				rdShowMessageDialog("�밴��ȷ��ʽ����ʵ���Ǽ�ʱ��");
				document.frm1104.GoodPhoneDate.focus();
				return false;
			}

			if(to_date(document.all.GoodPhoneDate) < da_te)
			{
				rdShowMessageDialog("ʵ���Ǽ�����ʱ��С�ڵ�ǰϵͳʱ�䣬���������룡");
				document.all.GoodPhoneDate.focus();
				return false;
			}
		}
		*/
		//20091201 end


        //-------------------------------------------
		//if(check(frm))
		{
          if(document.all.tr_newCust.style.display=="" && "09" != "<%=regionCode%>")
		  {
          if(checkPwd(document.all.custPwd,document.all.cfmPwd)==false) return false;
          chkPwdEasy(document.all.custPwd.value);
		  } else {
			  continueCfm();
		  }
		}
	 }

	 //--------------------------------------
	 function checkPwd(obj1,obj2)
	 {
			//����һ����У��,����У��
			var pwd1 = obj1.value;
			var pwd2 = obj2.value;
			if(pwd1 != pwd2)
			{
					var message = "������������벻һ�£����������룡";
					rdShowMessageDialog(message);
					if(obj1.type != "hidden")
					{   obj1.value = "";    }
					if(obj2.type != "hidden")
					{   obj2.value = "";    }
					obj1.focus();
					return false;
			}
			return true;
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
			if("<%=isKd%>" == "true"){
				cust_info+="�ֻ����룺   <%=kdNo%>|";
			}else{
				cust_info+="�ֻ����룺   "+document.all.srv_no.value+"|";
			}
 		  cust_info+="�ͻ�������   " +document.all.cust_name.value+"|";
      //cust_info+="�ͻ���ַ��   "+document.all.cust_addr.value+"|";
      //cust_info+="֤�����룺   "+document.all.ic_no.value+"|";

 		  opr_info+="�û�Ʒ�ƣ�"+"<%=sNewSmName%>"+"  *"+"����ҵ��"+"ʵ���Ǽ�"+"|";
		  opr_info+="������ˮ��"+document.all.loginAccept.value+"|";


		  if(document.all.r_cus[0].checked)
		 {
			
			if("<%=isKd%>" == "true"){
				opr_info+="�û�����"+"<%=kdNo%>"+"���û�"+"<%=(String)custDoc.get(5)%>"+"ʵ���Ǽǵ��û�"+document.all.custName.value+"|";
			}else{
				opr_info+="�û�����"+"<%=srv_no%>"+"���û�"+"<%=(String)custDoc.get(5)%>"+"ʵ���Ǽǵ��û�"+document.all.custName.value+"|";
			}
		  
		  opr_info+="�¿ͻ����ϣ��ͻ����ƣ�"+document.all.custName.value+"*"+"֤�����룺"+document.all.idIccid.value+"|";
		  opr_info+="�ͻ���ַ��"+document.all.idAddr.value+"|";
		  }else{
		  
		  if("<%=isKd%>" == "true"){
				opr_info+="�û�����"+"<%=kdNo%>"+"���û�"+"<%=(String)custDoc.get(5)%>"+"ʵ���Ǽǵ��û�"+document.all.h_custName.value+"|";
			}else{
				opr_info+="�û�����"+"<%=kdNo%>"+"���û�"+"<%=(String)custDoc.get(5)%>"+"ʵ���Ǽǵ��û�"+document.all.h_custName.value+"|";
			}
		  
		  opr_info+="�¿ͻ����ϣ��ͻ����ƣ�"+document.all.h_custName.value+"*"+"֤�����룺"+document.all.h_idIccid.value+"|";
		  opr_info+="�ͻ���ַ��"+document.all.h_idAddr.value+"|";
		  }
		  opr_info+=" "+"|";
		  opr_info+="��ǰ���ʷѣ�"+"<%=main_str1%>"+"|";
		  opr_info+="��ǰ��ѡ�ʷѣ�"+"<%=fj_str1%>"+"|";
		  opr_info+=" "+"|";
		  opr_info+="���ʷ�˵����"+"<%=main_note%>"+"|";



	  	/*ģ����֤���������� ���� ���������������� �����Ķ������� 24����*/
			if("<%=is_Z_flag%>"=="true" || "<%=isKd%>"=="true"){
				
			}else{
				if($("#is_sPwdAuthChk_sel").val()=="K"){
					opr_info += "������24���²��������ʵ���ǼǺ͹���"+"|";
				}else if($("#is_sPwdAuthChk_sel").val()=="N"){
					opr_info += "ʵ���ǼǺ�����������������ҵ�񣬲�ʹ�ô˺���ʱ�������������ҵ��"+"|";
				}
			}
				
				
				
		  if("<%=goodFlagNew%>"=="1"){ 

			note_info1+=" "+"|";
			note_info1+="ע�⣺�ú���Ϊ������룬�������ѽ��Ϊ"+"<%=mode_name%>"+"Ԫ,ʵ���ǼǺ�ԭ�������ѱ�׼���ֲ��䣬�԰�ԭ�涨ִ�У���������ѡ����ʷѻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��|";
		  }

		  note_info1+="��ע��"+document.all.assuNote.value+"|";
		  
	
				  		  
<%
			if(printFlag){
%>
					note_info1 += '������ʵ���Ǽ���ͨ��ģ����֤�ķ�ʽ���а�����δ���߿�����ҵ�񹤵�����Ʊ��|';
					note_info1 += '���պ������ͻ������ƾ��Ҫ�����ʵ���Ǽǣ��ҹ�˾�����������أ��ɴ������ķ��������������ге���';
<%
			}
%>
		  /*���Ķ���ʾ��Ϣ*/
		 if("<%=backCode%>" == "100001" && printAddFlag){
		 	note_info1+= "�𾴵Ŀͻ���Ϊ��л����֧�֣��ҹ�˾���Ա�����Ϊ�����͡����Ķ���Ʒ����������桱���������������£����鵽�ڵ���25��ϵͳ���Զ�Ϊ���˶�ҵ�������ڼ���Ҳ���Է��Ͷ���QXCDBTY��10086ȡ����"+"|";
		 }
		 
		 /*������ʾ��Ϣ*/
		 if("<%=backCode%>" == "100002" && printAddFlag){
		 	note_info1+= "�𾴵Ŀͻ���Ϊ��л����֧�֣��ҹ�˾������������0Ԫ�������������������0Ԫ�������������2016��3��15�գ�����ɹ�48Сʱ����Ч�����鵽��ϵͳ�Զ�Ϊ���˶�ҵ�������ڼ���Ҳ���Է��Ͷ���QXCLTY��10086ȡ����������������������Ʒ����ͬʱ������ϵͳ�Կͻ����һ�ζ�����ƷΪ׼��"+"|";
		 }
		  //#23->#
			//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		  return retInfo;
	 }

	 //--------5----------�ύ������-------------------
	 function conf()
	 {
		if(document.all.r_cus[0].checked)
		{
			//�жϷǿ���
			if ( jtrim (document.all.new_cus_id.value).length == 0 )
			{
				rdShowMessageDialog( "�¿ͻ�ID����Ϊ��,������!" , 0 );
				return false;
			}
		}
		var responsibleType = $("select[name='responsibleType']").find("option:selected").val();
		document.all.b_print.disabled=true;
		document.all.b_clear.disabled=true;
		document.frm.method="post";
		document.frm.target="_self";
		 if("<%=realOpCode%>" == "m389"){
		 	$("input[name='b_print']").attr("disabled","disabled");
		 	frm.action="/npage/sm389/fm389Cfm.jsp";
		 	frm.submit();
		 }else{
			 if($("#gestoresInfo1").css("display")=="none"){
				 frm.action="s1238_conf.jsp";
	        }
	        else{
	        	frm.action="s1238_conf.jsp?xsjbrxx=1";
	        }
		 	
		 	frm.submit();
		 }
		 
	 }

	 function canc()
	 {
		frm.submit();
	 }

    //-------6--------ʵ����ר�ú���----------------
     function ChkHandFee()
	 {
       if(jtrim(document.all.oriHandFee.value).length>=1 && jtrim(document.all.t_handFee.value).length>=1)
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

	   if(jtrim(document.all.oriHandFee.value).length>=1 && jtrim(document.all.t_handFee.value).length==0)
	   {
         document.all.t_handFee.value="0";
	   }
	 }

	 function getFew()
	 {
		 var fee=document.all.t_handFee;
		 var fact=document.all.t_factFee;
		 var few=document.all.t_fewFee;
		 if(jtrim(fact.value).length==0)
		 {
		  rdShowMessageDialog("ʵ�ս���Ϊ�գ�");
		  fact.value="";
		  fact.focus();
		  return;
		 }
		 if(parseFloat(fact.value)<parseFloat(fee.value))
		 {
		  rdShowMessageDialog("ʵ�ս��㣡");
		  fact.value="";
		  fact.focus();
		  return;
		 }

			var tem1=((parseFloat(fact.value)-parseFloat(fee.value))*100+0.5).toString();
			var tem2=tem1;
			if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
	    few.value=(tem2/100).toString();
			few.focus();
	 }

	 function chkID()
	 {
	    if(jtrim(document.all.new_cus_id.value).length==0)
		{
		    rdShowMessageDialog("�¿ͻ�ID����Ϊ�գ�");
        document.all.new_cus_id.focus();
			  return false;
 		}

		else
		{
       if(forInt(document.all.new_cus_id)==false) return false;

		   if(jtrim(document.all.new_cus_id.value)=="<%=(String)custDoc.get(1)%>")
		   {
		  		rdShowMessageDialog("�¿ͻ�ID������ԭ�ͻ�ID��ͬ��");
          document.all.new_cus_id.focus();
	  			return false;
		   }

		   if(document.all.passwd.value.trim().len()==0){
		   		rdShowMessageDialog("�ͻ����벻��Ϊ��!");
		   		return false;
		   }

		   if(document.all.passwd.value.trim().len()!=6){
		   		rdShowMessageDialog("�ͻ����������6λ!");
		   		return false;
		   }
		   
		   if("<%=opCode%>" == "m058"){
		   	 //�ж�����ͻ��Ƿ����¿����Ŀͻ�
					var isExitCustFlag = "N";
					var userIdType = "";
					var myPacket = new AJAXPacket("/npage/portal/shoppingCar/ajax_isExitForCust.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
				  myPacket.data.add("g_CustId",jtrim(document.all.new_cus_id.value)); 
				  myPacket.data.add("opCode","<%=opCode%>");
				  core.ajax.sendPacket(myPacket,function(packet){
				  	var retCode=packet.data.findValueByName("retCode");
					  var retMsg=packet.data.findValueByName("retMsg");
					  var v_isExitCustFlag=packet.data.findValueByName("isExitCustFlag"); //��ǰ�ͻ��£��û��Ƿ����
					  var v_userIdType=packet.data.findValueByName("userIdType"); //��ǰ�ͻ��£�֤������
					  if(retCode == "000000"){
					  	isExitCustFlag = v_isExitCustFlag;
					  	userIdType = v_userIdType;
					 	}else{
					 		rdShowMessageDialog("��ѯ�˿ͻ��Ƿ�����û���Ϣʧ�ܣ��������:<%=retCode%><br>������Ϣ:<%=retMsg%>��",0);
							return  false;
					 	}
				  });
				  myPacket = null;	
					if(isExitCustFlag == "Y"){//˵���ͻ��Ѵ����û�
						//1-�жϴ��û���ǰ֤�����ͣ��Ƿ������֤
						if(userIdType == "0" || userIdType == "00"){ //���֤:��������֤�����ģ��Ͳ��������ʵ���Ǽ�
							rdShowMessageDialog("�Ͽͻ�֤������Ϊ���֤��������������Ͽͻ���ҵ�����½��ͻ���",1);
							return  false;
						}else{ //2-�ж��Ƿ����Ż�Ȩ�� ֮ǰ���ж�
							//��Ϊ��λ�ͻ���ʵ��ʹ���������Ϣ���֤�����ͼ���Ӫҵִ�ա���֯�������롢��λ����֤��ͽ�����
						  if(userIdType == "8" || userIdType == "A" || userIdType == "B" || userIdType == "C"){
								/*ʵ��ʹ��������*/
						  	document.all.realUserName.v_must = "1";
						  	/*��ʵ��ʹ���˵�ַ*/
						  	document.all.realUserAddr.v_must = "1";
						  	/*ʵ��ʹ����֤������*/
						  	document.all.realUserIccId.v_must = "1";	
						  }else{
						  	/*ʵ��ʹ��������*/
						  	document.all.realUserName.v_must = "0";
						  	/*��ʵ��ʹ���˵�ַ*/
						  	document.all.realUserAddr.v_must = "0";
						  	/*ʵ��ʹ����֤������*/
						  	document.all.realUserIccId.v_must = "0";			
						  }
						}
					}	
					/*����������*/
			  	document.all.gestoresName.v_must = "0";
			  	/*�����˵�ַ*/
			  	document.all.gestoresAddr.v_must = "0";
			  	/*������֤������*/
			  	document.all.gestoresIccId.v_must = "0";			
			  	
			  	/*������������*/
			  	document.all.responsibleName.v_must = "0";
			  	/*�������˵�ַ*/
			  	document.all.responsibleAddr.v_must = "0";
			  	/*����������֤������*/
			  	document.all.responsibleIccId.v_must = "0";  				  	
			  	  
		   }

       var getUserId_Packet = new AJAXPacket("s1238_chkID.jsp","����У���¿ͻ�ID�����Ժ�......");
  	   getUserId_Packet.data.add("retType","chkID");
   	   getUserId_Packet.data.add("new_cus_id",jtrim(document.all.new_cus_id.value));
       getUserId_Packet.data.add("region_code","<%=regionCode%>");
       getUserId_Packet.data.add("passwd",document.all.passwd.value);
       core.ajax.sendPacket(getUserId_Packet);
       getUserId_Packet = null;
		}

	 }

	 function qryID()
	 {
	    if(jtrim(document.all.new_srv_no.value).length==0)
		{
		     rdShowMessageDialog("�·�����벻��Ϊ�գ�");
         document.all.new_srv_no.focus();
			   return false;
 		}

		else
		{
		   if(forMobil(document.all.new_srv_no)==false) return false;
		   if(jtrim(document.all.new_srv_no.value)=="<%=srv_no%>")
		   {
	     		 rdShowMessageDialog("�·�����벻����ԭ���������ͬ��");
           document.all.new_srv_no.focus();
		 			 return false;
		   }

       document.all.b_print.disabled=true;
		   document.all.new_cus_id.value="";
		   if(document.all.tr_newCust.style.display=="")
		   {
			  document.all.tr_newCust.style.display="none";
		   }

       var getUserId_Packet = new AJAXPacket("s1238_qryID.jsp","���ڲ�ѯ�¿ͻ�ID�����Ժ�......");
  	   getUserId_Packet.data.add("retType","qryID");
		   getUserId_Packet.data.add("region_code","<%=regionCode%>");
		   getUserId_Packet.data.add("new_srv_no",document.all.new_srv_no.value);
       core.ajax.sendPacket(getUserId_Packet);
       getUserId_Packet = null;
		}
	 }

	 function getId()
	 {
		//�õ��ͻ�ID
		document.all.tr_newCust.style.display="";

		var getUserId_Packet = new AJAXPacket("s1238_getID.jsp","���ڻ���¿ͻ�ID�����Ժ�......");
		getUserId_Packet.data.add("retType","getID");
		getUserId_Packet.data.add("region_code","<%=regionCode%>");
		getUserId_Packet.data.add("idType","0");
		getUserId_Packet.data.add("oldId","0");
		core.ajax.sendPacket(getUserId_Packet);
		getUserId_Packet = null;
	 }

     function chgNewId()
	 {
	   //document.all.new_srv_no.value="";
	   document.all.b_print.disabled=true;

	   if(document.all.tr_newCust.style.display=="")
	   {
         document.all.tr_newCust.style.display="none";
	   }
	 }

	/*** dujl add at 20090806 for R_HLJMob_cuisr_CRM_PD3_2009_0314@���ڹ淶�ͻ����������л��������зǷ��ַ�У������� ****/
	function feifa(textName)
	{
		if(textName.value != "")
		{
			if((textName.value.indexOf("~")) != -1 || (textName.value.indexOf("|")) != -1 || (textName.value.indexOf(";")) != -1)
			{
				rdShowMessageDialog("����������Ƿ��ַ������������룡");
				textName.value = "";
	 	  		return;
			}
		}
	}
	
function forKuoHao(obj){
	var m = /^(\(?\)?\��?\��?)\��|\.|\��+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}
function forEnKuoHao(obj){
	var m = /^(\(?\)?)+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}
  function forHanZi1(obj)
  {
  	var m = /^[\u0391-\uFFE5]+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		//showTip(obj,"�������뺺�֣�");
  		return false;
  	}
  		if (!isLengthOf(obj,obj.v_minlength*2,obj.v_maxlength*2)){
  		//showTip(obj,"�����д���");
  		return false;
  	}
  	return true;
  }
  
  //ƥ����26��Ӣ����ĸ��ɵ��ַ���
  function forA2sssz1(obj)
  {
  	var patrn = /^[A-Za-z]+$/;
  	var sInput = obj;
  	if(sInput.search(patrn)==-1){
  		//showTip(obj,"����Ϊ��ĸ��");
  		return false;
  	}
  	if (!isLengthOf(obj,obj.v_minlength,obj.v_maxlength)){
  		//showTip(obj,"�����д���");
  		return false;
  	}
  
  	return true;
  }
  

  function checkNameStr(code){
  	/*����ƥ������*/
    if(forKuoHao(code)) return "KH";//����
    if(forA2sssz1(code)) return "EH"; //Ӣ��
    var re2 =new RegExp("[\u0400-\u052f]");
    if(re2.test(code)) return "RU"; //����
    var re3 =new RegExp("[\u00C0-\u00FF]");
    if(re3.test(code)) return "FH"; //����
    var re4 = new RegExp("[\u3040-\u30FF]");
    var re5 = new RegExp("[\u31F0-\u31FF]");
    if(re4.test(code)||re5.test(code)) return "JP"; //����
    var re6 = new RegExp("[\u1100-\u31FF]");
    var re7 = new RegExp("[\u1100-\u31FF]");
    var re8 = new RegExp("[\uAC00-\uD7AF]");
    if(re6.test(code)||re7.test(code)||re8.test(code)) return "KR"; //����
    if(forHanZi1(code)) return "CH"; //����
    
   }

	/**** tianyang add for �����ַ����� start ****/
	function feifaCustName(textName)
	{
		if(textName.value != "")
		{
			if(document.all.isJSX.value=="0"){
				var m = /^[\u0391-\uFFE5]+$/;
				var flag = m.test(textName.value);
				if(!flag){
					rdShowMessageDialog("ֻ�����������ģ�");
					reSetCustName();
				}
				if(textName.value.length > 6){
					rdShowMessageDialog("ֻ��������6�����֣�");
					reSetCustName();
				}
			}else{
				if((textName.value.indexOf("~")) != -1 || (textName.value.indexOf("|")) != -1 || (textName.value.indexOf(";")) != -1)
				{
					rdShowMessageDialog("����������Ƿ��ַ������˿���������ѡ������ſ�����");
					textName.value = "";
		 	  		return;
				}
			}
		}
	}
		
	function setRealUserFormat(){
  	if(document.all.r_cus[0].checked){//�½��ͻ�
  		if(document.all.isJSX.value=="1"){ //��λ�ͻ�
  			/*ʵ��ʹ��������*/
		  	document.all.realUserName.v_must = "1";
		  	/*��ʵ��ʹ���˵�ַ*/
		  	document.all.realUserAddr.v_must = "1";
		  	/*ʵ��ʹ����֤������*/
		  	document.all.realUserIccId.v_must = "1";
  		}else{
  			/*ʵ��ʹ��������*/
		  	document.all.realUserName.v_must = "0";
		  	/*��ʵ��ʹ���˵�ַ*/
		  	document.all.realUserAddr.v_must = "0";
		  	/*ʵ��ʹ����֤������*/
		  	document.all.realUserIccId.v_must = "0";
  		}
  	}else{
  		
  	}
		$("#realUserInfo1").find("td:eq(0)").attr("width","13%");
  	$("#realUserInfo1").find("td:eq(0)").attr("nowrap","nowrap");
  	$("#realUserInfo1").find("td:eq(1)").attr("nowrap","nowrap");
  	$("#realUserInfo1").find("td:eq(2)").attr("width","13%");
  	$("#realUserInfo1").find("td:eq(2)").attr("nowrap","nowrap");
  	$("#realUserInfo1").find("td:eq(3)").attr("nowrap","nowrap");
  	$("#realUserInfo1").find("td:eq(3)").attr("colSpan","3");
  	
  	$("#realUserInfo2").find("td:eq(0)").attr("width","13%");
  	$("#realUserInfo2").find("td:eq(0)").attr("nowrap","nowrap");
  	$("#realUserInfo2").find("td:eq(1)").attr("nowrap","nowrap");
  	$("#realUserInfo2").find("td:eq(2)").attr("width","13%");
  	$("#realUserInfo2").find("td:eq(2)").attr("nowrap","nowrap");
  	$("#realUserInfo2").find("td:eq(3)").attr("nowrap","nowrap");
  	$("#realUserInfo2").find("td:eq(3)").attr("colSpan","3");
  	
  	//��ʵ��ʹ���˸�ֵ
		$("#realUserName").val("<%=qRealUserName%>");
		$("#realUserIccId").val("<%=qRealUserIccId%>");
		$("#realUserAddr").val("<%=qRealUserAddr%>");
		if("<%=qRealUserIdType%>" != ""){
			$("#realUserIdType option").each(function(){
		    if($(this).val().indexOf("<%=qRealUserIdType%>") != -1){
		      $(this).attr("selected","true");
		    }
		  });
		}
		if("<%=qRealUserIdType%>" == "0" || "<%=qRealUserIdType%>" == ""){ //���֤������ʾ������ť
			$("#scan_idCard_two2").css("display","");
			$("#scan_idCard_two22").css("display","");
			$("input[name='realUserName']").attr("class","InputGrey");
			$("input[name='realUserName']").attr("readonly","readonly");
			$("input[name='realUserAddr']").attr("class","InputGrey");
			$("input[name='realUserAddr']").attr("readonly","readonly");
			$("input[name='realUserIccId']").attr("class","InputGrey");
			$("input[name='realUserIccId']").attr("readonly","readonly");
			
		}else{
			$("#scan_idCard_two2").css("display","none");
			$("#scan_idCard_two22").css("display","none");
			$("input[name='realUserName']").removeAttr("class");
			$("input[name='realUserName']").removeAttr("readonly");
			$("input[name='realUserAddr']").removeAttr("class");
			$("input[name='realUserAddr']").removeAttr("readonly");
			$("input[name='realUserIccId']").removeAttr("class");
			$("input[name='realUserIccId']").removeAttr("readonly");
		}	
	}

	function reSetCustName(){/*���ÿͻ�����*/
		document.all.custName.value="";
		document.all.contactPerson.value="";
		
		/*20131216 gaopeng 2013/12/16 15:11:05 ��ѡ��λ����ʱ��չʾ��������Ϣ��������Ϣ���Ϊ����ѡ�� start*/
  var checkVal = $("select[name='isJSX']").find("option:selected").val();
  if(checkVal == 1){
  	$("#gestoresInfo1").show();
  	$("#gestoresInfo2").show();
  	$("#sendProjectList").hide(); //�·�������ť
		$("#qryListResultBut").hide(); //���������ѯ��ť
  	/*����������*/
  	document.all.gestoresName.v_must = "1";
  	/*�����˵�ַ*/
  	document.all.gestoresAddr.v_must = "1";
  	/*������֤������*/
  	document.all.gestoresIccId.v_must = "1";
  	var checkIdType = $("select[name='gestoresIdType']").find("option:selected").val();
  	/*���֤����У�鷽��*/
  	if(checkIdType.indexOf("���֤") != -1){
  		document.all.gestoresIccId.v_type = "idcard";
			$("#scan_idCard_two3").css("display","");
			$("#scan_idCard_two31").css("display","");
  		$("input[name='gestoresName']").attr("class","InputGrey");
  		$("input[name='gestoresName']").attr("readonly","readonly");
  		$("input[name='gestoresAddr']").attr("class","InputGrey");
  		$("input[name='gestoresAddr']").attr("readonly","readonly");
  		$("input[name='gestoresIccId']").attr("class","InputGrey");
  		$("input[name='gestoresIccId']").attr("readonly","readonly");

  	}else{
  		document.all.gestoresIccId.v_type = "string";
  		$("#scan_idCard_two3").css("display","none");
  		$("#scan_idCard_two31").css("display","none");
  		$("input[name='gestoresName']").removeAttr("class");
  		$("input[name='gestoresName']").removeAttr("readonly");
  		$("input[name='gestoresAddr']").removeAttr("class");
  		$("input[name='gestoresAddr']").removeAttr("readonly");
  		$("input[name='gestoresIccId']").removeAttr("class");
  		$("input[name='gestoresIccId']").removeAttr("readonly");
  	}
  	
  	
  	//��������Ϣ
  	$("#responsibleInfo1").show();
  	$("#responsibleInfo2").show();

  	/*������������*/
  	document.all.responsibleName.v_must = "1";
  	/*�������˵�ַ*/
  	document.all.responsibleAddr.v_must = "1";
  	/*����������֤������*/
  	document.all.responsibleIccId.v_must = "1";
  	var checkIdType22 = $("select[name='responsibleType']").find("option:selected").val();
  	/*���֤����У�鷽��*/
  	if(checkIdType22.indexOf("���֤") != -1){
  		document.all.responsibleIccId.v_type = "idcard";
  		$("#scan_idCard_two3zrr").css("display","");
  		$("#scan_idCard_two57zrr").css("display","");
  		$("input[name='responsibleName']").attr("class","InputGrey");
  		$("input[name='responsibleName']").attr("readonly","readonly");
  		$("input[name='responsibleAddr']").attr("class","InputGrey");
  		$("input[name='responsibleAddr']").attr("readonly","readonly");
  		$("input[name='responsibleIccId']").attr("class","InputGrey");
  		$("input[name='responsibleIccId']").attr("readonly","readonly");  		
  		
  	}else{
  		document.all.responsibleIccId.v_type = "string";
  		$("#scan_idCard_two3zrr").css("display","none");
  		$("#scan_idCard_two57zrr").css("display","none");
  		$("input[name='responsibleName']").removeAttr("class");
  		$("input[name='responsibleName']").removeAttr("readonly");
  		$("input[name='responsibleAddr']").removeAttr("class");
  		$("input[name='responsibleAddr']").removeAttr("readonly");
  		$("input[name='responsibleIccId']").removeAttr("class");
  		$("input[name='responsibleIccId']").removeAttr("readonly");  		
  		
  	}
  	
  	
  	
  }
  /*ûѡ��λ�ͻ���ʱ�򣬾���չʾ������Ϊ����Ҫ����ѡ��*/
  else{
  	$("#gestoresInfo1").hide();
  	$("#gestoresInfo2").hide();
  	/*����������*/
  	document.all.gestoresName.v_must = "0";
  	/*�����˵�ַ*/
  	document.all.gestoresAddr.v_must = "0";
  	/*������֤������*/
  	document.all.gestoresIccId.v_must = "0";
  	
  	//��������Ϣ
  	$("#responsibleInfo1").hide();
  	$("#responsibleInfo2").hide();

  	/*������������*/
  	document.all.responsibleName.v_must = "0";
  	/*�������˵�ַ*/
  	document.all.responsibleAddr.v_must = "0";
  	/*����������֤������*/
  	document.all.responsibleIccId.v_must = "0";   	
  	
  	
  }
  /*20131216 gaopeng 2013/12/16 15:11:05 ��ѡ��λ����ʱ��չʾ��������Ϣ��������Ϣ���Ϊ����ѡ�� end*/
  
		getIdTypes();
		/* begin add �� m058+��ͨ����+���֤+�����������+����+��չ���У�����ʾ���·���������ť for ���ڵ绰�û�ʵ���Ǽǽ����ص㹤����֪ͨ @2014/11/4 */
	  if(checkVal == 0){
			var idTypeSelect = $("#idType option[@selected]").val();//֤�����ͣ����֤
			if(idTypeSelect.indexOf("|") != -1){
				var v_idTypeSelect = idTypeSelect.split("|")[0];
				if(v_idTypeSelect == "0" && "<%=workChnFlag%>" == "1" && "<%=opCode%>" == "m058" && (parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){
					$("#sendProjectList").show();
					$("#qryListResultBut").show();
				}else{
					$("#sendProjectList").hide();
					$("#qryListResultBut").hide();
				}
			}
	  }
	  /* end add for ���ڵ绰�û�ʵ���Ǽǽ����ص㹤����֪ͨ @2014/11/4 */	
	  /* begin update for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/10 */
	  var idTypeSelect2 = $("#idType option[@selected]").val();//֤�����ͣ����֤
	  if("<%=opCode%>" == "m058"){
	  	if(idTypeSelect2.indexOf("|") != -1){
	  		var v_idTypeSelect2 = idTypeSelect2.split("|")[0];
	  		if(v_idTypeSelect2 == "0"){ //���֤
					if("<%=workChnFlag%>" != "1"){ //����Ӫҵ��
						$("#idIccid").attr("class","InputGrey");
						$("#idIccid").attr("readonly","readonly");
						$("#custName").attr("class","InputGrey");
						$("#custName").attr("readonly","readonly");
						$("#idAddr").attr("class","InputGrey");
						$("#idAddr").attr("readonly","readonly");
						$("#idValidDate").attr("class","InputGrey");
						$("#idValidDate").attr("readonly","readonly");
						$("#idIccid").val("");
						$("#custName").val("");
						$("#idAddr").val("");
						$("#idValidDate").val("");
					}else{ //�������
						if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ //���Ź�˾���鿪��Ϊ������+���п���Ϊ������ʱ
							$("#idIccid").attr("class","InputGrey");
							$("#idIccid").attr("readonly","readonly");
							$("#custName").attr("class","InputGrey");
							$("#custName").attr("readonly","readonly");
							$("#idAddr").attr("class","InputGrey");
							$("#idAddr").attr("readonly","readonly");
							$("#idValidDate").attr("class","InputGrey");
							$("#idValidDate").attr("readonly","readonly");
							$("#idIccid").val("");
							$("#custName").val("");
							$("#idAddr").val("");
							$("#idValidDate").val("");
						}
					}
	  		}else{
	  			if("<%=workChnFlag%>" != "1"){ //����Ӫҵ��
						$("#idIccid").removeAttr("class");
						$("#idIccid").removeAttr("readonly");
						$("#custName").removeAttr("class");
						$("#custName").removeAttr("readonly");
						$("#idAddr").removeAttr("class");
						$("#idAddr").removeAttr("readonly");
						$("#idValidDate").removeAttr("class");
						$("#idValidDate").removeAttr("readonly");
					}else{ //�������
						if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ //���Ź�˾���鿪��Ϊ������+���п���Ϊ������ʱ
							$("#idIccid").removeAttr("class");
							$("#idIccid").removeAttr("readonly");
							$("#custName").removeAttr("class");
							$("#custName").removeAttr("readonly");
							$("#idAddr").removeAttr("class");
							$("#idAddr").removeAttr("readonly");
							$("#idValidDate").removeAttr("class");
							$("#idValidDate").removeAttr("readonly");
						}
					}
	  		}
				/* end update for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/10 */		
			}
	  }
	 	setRealUserFormat();	  
	}
	/*2013/11/07 21:14:36 gaopeng ����ʵ���ƹ����������ϵĺ�*/
function getIdTypes(){
	 var checkVal = $("select[name='isJSX']").find("option:selected").val();
	 //alert(checkVal);
   var getdataPacket = new AJAXPacket("/npage/sq100/fq100GetIdTypes.jsp","���ڻ�����ݣ����Ժ�......");
			
			getdataPacket.data.add("checkVal",checkVal);
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("opName","<%=opName%>");
			core.ajax.sendPacketHtml(getdataPacket,resIdTypes);
			getdataPacket = null;
	
}
function resIdTypes(data){
			//�ҵ���ӵ�select
				var markDiv=$("#tdappendSome"); 
				//���ԭ�б��
				markDiv.empty();
				markDiv.append(data);
 
}
	/**** tianyang add for �����ַ����� end ****/


	function change_ConPerson()
	{   //��ϵ��������ͻ����Ƹ������ı�
		document.all.contactPerson.value = document.all.custName.value;
	}
	function change_ConAddr()
	{   //��ϵ��������ͻ����Ƹ������ı�
		document.all.contactAddr.value = document.all.custAddr.value;
		document.all.contactMAddr.value = document.all.custAddr.value;
		checkElement(document.all.contactAddr);
	}
	function change_idType(chgFlag)
	{
	  var Str = document.all.idType.value;
	  
	  /* begin diling update for �������ӿ�������ͻ��Ǽ���Ϣ��֤���ܵĺ�@2013/9/22 */
    
      checkCustNameFunc16New(document.all.custName,0,1); //У��ͻ������Ƿ����
      if(Str.indexOf("����֤") > -1){
  	    $("#idAddrDiv").text("֤����ַ(����)");
  	  }else{
  	    $("#idAddrDiv").text("֤����ַ");
  	  }
    
	  /* end diling update@2013/9/22 */
		if(Str.indexOf("0") > -1||Str.indexOf("D") > -1)
		{   document.all.idIccid.v_type = "idcard";  
				document.all("card_id_type").style.display="";
				/* begin add �� m058+��ͨ����+���֤+�����������+���أ�����ʾ���·���������ť for ���ڵ绰�û�ʵ���Ǽǽ����ص㹤����֪ͨ @2014/11/19 */
				var checkVal = document.all.isJSX.value;//���˿������� ��ͨ�ͻ���0
				if(checkVal == "0" && "<%=workChnFlag%>" == "1" && "<%=opCode%>" == "m058" && (parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){
					$("#sendProjectList").show();
					$("#qryListResultBut").show();
				}else{
					$("#sendProjectList").hide();
					$("#qryListResultBut").hide();
				}
				/* end add for ���ڵ绰�û�ʵ���Ǽǽ����ص㹤����֪ͨ @2014/11/19 */
				/* begin update for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/10 */
				if("<%=opCode%>" == "m058"){
					if("<%=workChnFlag%>" != "1"){ //����Ӫҵ��
						$("#idIccid").attr("class","InputGrey");
						$("#idIccid").attr("readonly","readonly");
						$("#custName").attr("class","InputGrey");
						$("#custName").attr("readonly","readonly");
						$("#idAddr").attr("class","InputGrey");
						$("#idAddr").attr("readonly","readonly");
						$("#idValidDate").attr("class","InputGrey");
						$("#idValidDate").attr("readonly","readonly");
						if(chgFlag == "1"){
							$("#idIccid").val("");
							$("#custName").val("");
							$("#idAddr").val("");
							$("#idValidDate").val("");
						}
					}else{ //�������
						if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ //���Ź�˾���鿪��Ϊ������+���п���Ϊ������ʱ
							$("#idIccid").attr("class","InputGrey");
							$("#idIccid").attr("readonly","readonly");
							$("#custName").attr("class","InputGrey");
							$("#custName").attr("readonly","readonly");
							$("#idAddr").attr("class","InputGrey");
							$("#idAddr").attr("readonly","readonly");
							$("#idValidDate").attr("class","InputGrey");
							$("#idValidDate").attr("readonly","readonly");
							if(chgFlag == "1"){
								$("#idIccid").val("");
								$("#custName").val("");
								$("#idAddr").val("");
								$("#idValidDate").val("");
							}
						}
					}
				}
				/* end update for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/10 */		
		 }
		else
		{   document.all.idIccid.v_type = "string";   
				document.all("card_id_type").style.display="none";
				$("#sendProjectList").hide(); //�·�������ť
				$("#qryListResultBut").hide(); //���������ѯ��ť
				/* begin update for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/10 */
				if("<%=opCode%>" == "m058"){
					if("<%=workChnFlag%>" != "1"){ //����Ӫҵ��
						$("#idIccid").removeAttr("class");
						$("#idIccid").removeAttr("readonly");
						$("#custName").removeAttr("class");
						$("#custName").removeAttr("readonly");
						$("#idAddr").removeAttr("class");
						$("#idAddr").removeAttr("readonly");
						$("#idValidDate").removeAttr("class");
						$("#idValidDate").removeAttr("readonly");
					}else{ //�������
						if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ //���Ź�˾���鿪��Ϊ������+���п���Ϊ������ʱ
							$("#idIccid").removeAttr("class");
							$("#idIccid").removeAttr("readonly");
							$("#custName").removeAttr("class");
							$("#custName").removeAttr("readonly");
							$("#idAddr").removeAttr("class");
							$("#idAddr").removeAttr("readonly");
							$("#idValidDate").removeAttr("class");
							$("#idValidDate").removeAttr("readonly");
						}
					}
				}
				/* end update for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/10 */		
		}
		

		
		
	}

	function chkValid()
	{
		 var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());

		 if(jtrim(document.all.idValidDate.value).length>0)
		 {
			if(forDate(document.all.idValidDate)==false) return false;

			if(to_date(document.all.idValidDate)<=d)
			{
			  rdShowMessageDialog("֤����Ч�ڲ������ڵ�ǰʱ�䣬���������룡");
			  document.all.idValidDate.focus();
			  document.all.idValidDate.select();
			  return false;
			}
		}
	}

	/********У�����ڵĺϷ���**********/
	function to_date(obj)
{
  var theTotalDate="";
  var one="";
  var flag="0123456789";
  for(i=0;i<obj.value.length;i++)
  {
     one=obj.value.charAt(i);
     if(flag.indexOf(one)!=-1)
		 theTotalDate+=one;
  }
  return theTotalDate;
}

	function chgCustType()
	{
	  if(document.all.r_cus[0].checked)
	  {
			getIdTypes();
		  var divPassword = document.getElementById("divPassword");
		  var divCustPad1 = document.getElementById("divCustPad1");
		  var divCustPad2 = document.getElementById("divCustPad2");

		  if("09" == "<%=regionCode%>")
		  {
		  	divPassword.style.display="none";
		  	divCustPad1.style.display="none";
		  	divCustPad2.style.display="none";
		  }

		  frm.reset();

		  document.all.tr_qryCondition.style.display="none";
		  document.all.tr_iccid.style.display="none";
		  document.all.tr_srvno.style.display="none";
		  document.all.new_cus_id.readOnly=true;
		  document.all.new_cus_id.className="InputGrey";
		  document.all.b_chkId.style.display="none";
      document.all.r_cus[0].checked=true;
		  getId();
		  document.all.districtCode.focus();
		  /* begin add �� m058+��ͨ����+���֤+�����������+����+��չ���У�����ʾ���·���������ť for ���ڵ绰�û�ʵ���Ǽǽ����ص㹤����֪ͨ @2014/11/19 */
		  if("<%=opCode%>" == "m058"){
		  	var checkVal = $("select[name='isJSX']").find("option:selected").val();//���˿������� ��ͨ�ͻ���0
				$("#idType").find("option").eq(0).attr("selected","selected");
				var idTypeSelect = $("#idType").find("option:selected").val();//֤�����ͣ����֤
				if(idTypeSelect.indexOf("|") != -1){
					var v_idTypeSelect = idTypeSelect.split("|")[0];
					if(checkVal == "0" && v_idTypeSelect == "0" && "<%=workChnFlag%>" == "1" && (parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){
						$("#sendProjectList").show();
						$("#qryListResultBut").show();
					}
					/* begin update for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/10 */
					if(v_idTypeSelect == "0"){//���֤
						if("<%=workChnFlag%>" != "1"){ //����Ӫҵ��
							$("#idIccid").attr("class","InputGrey");
							$("#idIccid").attr("readonly","readonly");
							$("#custName").attr("class","InputGrey");
							$("#custName").attr("readonly","readonly");
							$("#idAddr").attr("class","InputGrey");
							$("#idAddr").attr("readonly","readonly");
							$("#idValidDate").attr("class","InputGrey");
							$("#idValidDate").attr("readonly","readonly");
							$("#idIccid").val("");
							$("#custName").val("");
							$("#idAddr").val("");
							$("#idValidDate").val("");
						}else{ //�������
							if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ //���Ź�˾���鿪��Ϊ������+���п���Ϊ������ʱ
								$("#idIccid").attr("class","InputGrey");
								$("#idIccid").attr("readonly","readonly");
								$("#custName").attr("class","InputGrey");
								$("#custName").attr("readonly","readonly");
								$("#idAddr").attr("class","InputGrey");
								$("#idAddr").attr("readonly","readonly");
								$("#idValidDate").attr("class","InputGrey");
								$("#idValidDate").attr("readonly","readonly");
								$("#idIccid").val("");
								$("#custName").val("");
								$("#idAddr").val("");
								$("#idValidDate").val("");
							}
						}
					}
					/* end update for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/10 */	
				}
		  }
		  /* end add for ���ڵ绰�û�ʵ���Ǽǽ����ص㹤����֪ͨ @2014/11/19 */
		  $("#gestoresInfo1").hide();
	  	$("#gestoresInfo2").hide();
	  	/*����������*/
	  	document.all.gestoresName.v_must = "0";
	  	/*�����˵�ַ*/
	  	document.all.gestoresAddr.v_must = "0";
	  	/*������֤������*/
	  	document.all.gestoresIccId.v_must = "0";
	  	
	  	
  	//��������Ϣ
  	$("#responsibleInfo1").hide();
  	$("#responsibleInfo2").hide();

  	/*������������*/
  	document.all.responsibleName.v_must = "0";
  	/*�������˵�ַ*/
  	document.all.responsibleAddr.v_must = "0";
  	/*����������֤������*/
  	document.all.responsibleIccId.v_must = "0";  	  	
	  	
	  	
	  	
	  }else if(document.all.r_cus[1].checked){ //���пͻ�

		  var divPassword = document.getElementById("divPassword");
  		  var divCustPad1 = document.getElementById("divCustPad1");
		  var divCustPad2 = document.getElementById("divCustPad2");

		  divPassword.style.display="";
		  divCustPad1.style.display="";
		  divCustPad2.style.display="";

		  frm.reset();
		  document.all.r_cus[1].checked=true;
		  document.all.tr_qryCondition.style.display="";
		  document.all.tr_iccid.style.display="";
		  document.all.tr_srvno.style.display="";
		  document.all.new_cus_id.readOnly=false;
		  document.all.new_cus_id.className=" ";
		  document.all.b_chkId.style.display="";
		  document.all.tr_newCust.style.display="none";
		  chgCon();
		  
			$("#sendProjectList").hide(); //�·�������ť
			$("#qryListResultBut").hide(); //���������ѯ��ť
	  }
	  setRealUserFormat();	  
	}

	function chgCon()
	{
		if(document.all.r_con[0].checked)     //�ֻ�����
		{
			/* begin add for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/13 */
			if("<%=opCode%>" == "m058"){
				//2-�ж��Ƿ����Ż�Ȩ��
				var oldFav_a971 = <%=oldFav_a971%>;
				if(!oldFav_a971){ //��Ȩ�ޣ����������
					rdShowMessageDialog("����û�в��Ͽͻ�Ȩ�ޣ�������������Ͽͻ���ҵ�����½��ͻ���",1);
					document.all.r_cus[0].checked = true;
					chgCustType();
					return  false;
				}else{//��Ȩ�ޣ�����Խ��в��ϻ� �������+�ͻ�ID �Ĺ�������
				}
			}
			/* end add for ���ڿ��������ն�CRMģʽAPP�ĺ� - �ڶ���@2015/3/13 */
			document.all.tr_srvno.style.display="";
			document.all.tr_iccid.style.display="none";
			document.all.new_srv_no.value="";
			document.all.new_cus_id.value="";
			document.all.new_srv_no.focus();
		}
		else if(document.all.r_con[1].checked)       //֤������
		{
			document.all.tr_srvno.style.display="none";
			document.all.tr_iccid.style.display="";
			document.all.id_no.value="";
			document.all.new_cus_id.value="";
			document.all.id_type.focus();
		}
		else if(document.all.r_con[2].checked)      //�ͻ�ID
		{
			document.all.tr_srvno.style.display="none";
			document.all.tr_iccid.style.display="none";
			document.all.new_cus_id.value="";
			document.all.new_cus_id.focus();
		}
	}

	function getAllId_No(){
   if(jtrim(document.all.id_no.value).length<1)
   {
     rdShowMessageDialog("֤�����벻��Ϊ�գ�");
 	 	 return;
   }

   if(jtrim(document.all.id_type.value)=="1")
   {
   	 
     if(!forIdCard(document.all.id_no)){
	  		return false;
	  	}
	  //liujian 2013-5-15 10:03:02 ���֤����18λ
	  	if(document.all.id_no.value.length != 18){
	  		rdShowMessageDialog("���֤���������18λ��");
	  		return false;
	  	}	
	  	
   }

   var h=400;
   var w=600;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
   var ret=window.showModalDialog("AllId_No.jsp?id_no="+document.all.id_no.value+"&id_type=" +document.all.id_type.value,"",prop);

   if(typeof(ret)!="undefined")
   {
		 document.all.new_cus_id.value=ret;
	 	 document.all.new_cus_id.focus();
	 	 document.all.new_cus_id.select();
		 rpc_chkX_2("id_type","id_no","A","chkX_1");
   }else{
     rdShowMessageDialog("������ѡ��һ���ͻ�ID��");
	 	 document.all.id_no.select();
     document.all.id_no.focus();
   }
 }



  function getOneId()
  {
    if(jtrim(document.all.new_srv_no.value).length<1)
	{
      rdShowMessageDialog("������벻��Ϊ�գ�");
 	  	return;
	}
	if(forMobil(document.all.new_srv_no)==false) return;

   	var myPacket = new AJAXPacket("qryCus_id.jsp","���ڲ�ѯ�ͻ�ID�����Ժ�......");
		myPacket.data.add("phoneNo",jtrim(document.all.new_srv_no.value));
		core.ajax.sendPacket(myPacket);
		myPacket = null;
  }
  /* update �������ȡ����ݲ��ɼ������������ϻ����½��ͻ��� for ���ڹ��ֹ�˾�����Ż�M058ʵ���ƵǼ������������������ʾ@2015/2/11
  function checkXi()
  {
  	if(frm.xinYiDu.value>0)
	{
	  rdShowMessageDialog("�����Ȳ��ܴ����㣡");
 	  return;
	}
  }
  */
//---------------add by baixf 20080221 ����039 �����ͻ�ʱ���Բ�ѯ¼������֤��ϵͳ�е�ʹ����Ϣ��
function getInfo_IccId_JustSee()
{
	/*
    var Str = document.all.idType.value;
    
      if(Str.indexOf("���֤") > -1){
        if($("#idIccid").val().length<18){
          rdShowMessageDialog("���֤���������18λ��");
          document.all.idIccid.focus();
          return false;
        }
      }
   */ 
    //���ݿͻ�֤������õ������Ϣ
    if(jtrim(document.frm.idIccid.value).length == 0)
    {
        rdShowMessageDialog("������ͻ�֤�����룡");
        return false;
    }
    /*
	else if(jtrim(document.frm.idIccid.value).length < 5)
	{
        rdShowMessageDialog("֤�����볤������������λ����");
        return false;
	}
	*/
    var pageTitle = "�ͻ���Ϣ��ѯ";
    var fieldName = "�ֻ�����|����ʱ��|֤������|֤������|������|״̬|";
    var sqlStr = " ";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
    custInfoQueryJustSee(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}
		//--------------------add by baixf 20080221 ��Ҫ039
		function custInfoQueryJustSee(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
		{
		    /*
		    ����1(pageTitle)����ѯҳ�����
		    ����2(fieldName)�����������ƣ���'|'�ָ��Ĵ�
		    ����3(sqlStr)��sql���
		    ����4(selType)������1 rediobutton 2 checkbox
		    ����5(retQuence)����������Ϣ������������� �������ʶ����'|'�ָ�����"3|0|2|3"��ʾ����3����0��2��3
		    ����6(retToField))������ֵ����������,��'|'�ָ�
		    */
		var custnamess=document.all.custName.value.trim();
		var idTypesss="";
		var idTypeSelect = $("#idType option[@selected]").val();//֤������
		if(idTypeSelect.indexOf("|") != -1){
			  idTypesss = idTypeSelect.split("|")[0];
			  if(idTypesss=="0") {//���֤
				    if(custnamess.len() == 0)
				    {
				        //rdShowMessageDialog("������ͻ����ƺ��ٽ�����Ϣ��ѯ��");
				        //return false;
				    }
			   }   
    }

    var path = "/npage/sq100/getPhoneNumInner.jsp";
    path = path + "?idIccid=" + document.frm.idIccid.value.trim()+"&idtype="+idTypesss+"&custnames="+custnamess+"&opcode=m058";
    window.showModalDialog(path,"","dialogWidth:30;dialogHeight:15;");
    
		}

		/***add by zhanghonga@20080911ȥ���ַ������˵Ŀո�,ʹ������ʽ��������ʽ��֤.***/
		function jtrim(str){
			return str.replace( /^\s*/, "" ).replace( /\s*$/, "" );
    }


  /***��֤�������ĺ���***/
  function rpc_chkX_2(x_type,x_no,chk_kind,retFlag)
{
	  var obj_type=document.all(x_type);
	  var obj_no=document.all(x_no);
	  var idname="";
	  if(obj_type.type=="text")
	  {
	    idname=jtrim(obj_type.value);
	  }
	  else if(obj_type.type=="select-one")
	  {
	    idname=jtrim(obj_type.options[obj_type.selectedIndex].text);
	  }

	  
			return;
		

		  var myPacket = new AJAXPacket("/npage/innet/chkX.jsp","������֤��������Ϣ�����Ժ�......");
		  myPacket.data.add("retType",retFlag);
		  myPacket.data.add("retObj",x_no);
		  myPacket.data.add("x_idType",getX_idno(idname));
		  myPacket.data.add("x_idNo",obj_no.value);
		  myPacket.data.add("x_chkKind",chk_kind);
		  core.ajax.sendPacket(myPacket);
		  myPacket = null;
	}

	/***��֤�������ĺ����е��ô˺���***/
			function getX_idno(xx)
		{
		  if(xx==null) return "0";

		  if(xx=="���֤") return "0";
		  else if(xx=="����֤") return "1";
		  else if(xx=="��ʻ֤") return "2";
		  else if(xx=="����֤") return "4";
		  else if(xx=="ѧ��֤") return "5";
		  else if(xx=="��λ") return "6";
		  else if(xx=="У԰") return "7";
		  else if(xx=="Ӫҵִ��") return "8";
		  else return "0";
		}

		//dujl add at 20100415 for ���֤У��
function checkIccId()
{
	<%if(isshehuiworkno.equals("yes")) {%>
		rdShowMessageDialog("����������Ӫҵ��Ϊ��������Ȩ�����ޣ�");
		return false;
	<%}%>
	document.all.iccIdCheck.disabled=true;
	var myPacket = new AJAXPacket("/npage/innet/fIccIdCheck.jsp","������֤���֤��Ϣ�����Ժ�......");
	myPacket.data.add("retType","iccIdCheck");
	myPacket.data.add("idIccid",document.all.ic_no.value);
	myPacket.data.add("custName",document.all.cust_name.value);
	myPacket.data.add("IccIdAccept",document.all.loginAccept.value);
	myPacket.data.add("opCode",document.all.opCode.value);
	myPacket.data.add("phoneNo","<%=srv_no%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
	document.all.iccIdCheck.disabled=false;
}

//dujl add at 20100421 for ���֤У��
// ��ȡ���֤��Ƭ
function getPhoto()
{
	window.open("../innet/fgetIccIdPhoto.jsp?idIccid="+document.all.ic_no.value,"","width="+(screen.availWidth*1-900)+",height="+(screen.availHeight*1-500) +",left=450,top=240,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
}

function checkIccId1()
{
	<%if(isshehuiworkno.equals("yes")) {%>
		rdShowMessageDialog("����������Ӫҵ��Ϊ��������Ȩ�����ޣ�");
		return false;
	<%}%>
	
	if(document.all.idType.value.split("|")[0] != "0")
	{
		rdShowMessageDialog("ֻ�����֤����У�飡");
		return false;
	}
	if(document.all.custName.value.trim() == "")
	{
		rdShowMessageDialog("��������ͻ����ƣ�");
		return false;
	}
	if(document.all.idIccid.value.trim() == "")
	{
		rdShowMessageDialog("��������֤�����룡");
		return false;
	}
	var Str = document.all.idType.value;
  
    if(Str.indexOf("���֤") > -1){
      if($("#idIccid").val().length<18){
        rdShowMessageDialog("���֤���������18λ��");
        document.all.idIccid.focus();
        return false;
      }
    }
  

	document.all.iccIdCheck1.disabled=true;
	var myPacket = new AJAXPacket("/npage/innet/fIccIdCheck.jsp","������֤���֤��Ϣ�����Ժ�......");
	myPacket.data.add("retType","iccIdCheck1");
	myPacket.data.add("idIccid",document.all.idIccid.value);
	myPacket.data.add("custName",document.all.custName.value);
	myPacket.data.add("IccIdAccept",document.all.loginAccept.value);
	myPacket.data.add("opCode",document.all.opCode.value);
	myPacket.data.add("phoneNo","<%=srv_no%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
	document.all.iccIdCheck1.disabled=false;
}

//dujl add at 20100421 for ���֤У��
// ��ȡ���֤��Ƭ
function getPhoto1()
{
	window.open("../innet/fgetIccIdPhoto.jsp?idIccid="+document.all.idIccid.value,"","width="+(screen.availWidth*1-900)+",height="+(screen.availHeight*1-500) +",left=450,top=240,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
}

function chkPwdEasy1(pwd){
	if(pwd == ""){
		rdShowMessageDialog("�����������룡");
		return ;
	}
	var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","������֤�����Ƿ���ڼ򵥣����Ժ�......");
	checkPwd_Packet.data.add("password", pwd);
	checkPwd_Packet.data.add("phoneNo", "<%=phone_no%>");
	checkPwd_Packet.data.add("idNo", frm.idIccid.value);
	checkPwd_Packet.data.add("custId", "");

	core.ajax.sendPacket(checkPwd_Packet, doCheckPwdEasy1);
	checkPwd_Packet=null;
}

function doCheckPwdEasy1(packet) {
	var retResult = packet.data.findValueByName("retResult");
	if (retResult == "1") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ��ͬ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "2") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "3") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ�ֻ������е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "4") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ֤���е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "0") {
		//rdShowMessageDialog("У��ɹ���������ã�");
	}
}
function chkPwdEasy(pwd){
	if(pwd == ""){
		rdShowMessageDialog("�����������룡");
		return ;
	}
	var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","������֤�����Ƿ���ڼ򵥣����Ժ�......");
	checkPwd_Packet.data.add("password", pwd);
	checkPwd_Packet.data.add("phoneNo", "<%=phone_no%>");
	checkPwd_Packet.data.add("idNo", frm.idIccid.value);
	checkPwd_Packet.data.add("custId", "");

	core.ajax.sendPacket(checkPwd_Packet, doCheckPwdEasy);
	checkPwd_Packet=null;
}



function doCheckPwdEasy(packet) {
	var retResult = packet.data.findValueByName("retResult");
	if (retResult == "1") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ��ͬ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "2") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "3") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ�ֻ������е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "4") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ֤���е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "0") {
		//rdShowMessageDialog("У��ɹ���������ã�");
		continueCfm();
	}
}

function continueCfm() {
	
	if("<%=realOpCode%>" == "m389"){
		document.all.t_sys_remark.value="�û�"+jtrim(document.all.cust_name.value)+"��������ʵ���Ǽ�";
		document.all.t_op_remark.value="����Ա<%=work_no%>"+"��������ʵ���Ǽǡ��˺�������ҵ��ʵ���ǼǺ��������"
		document.all.assuNote.value="����Ա<%=work_no%>"+"��������ʵ���Ǽǡ��˺�������ҵ��ʵ���ǼǺ��������"
		if(rdShowConfirmDialog('ȷ��Ҫ�ύ����ʵ���Ǽ���Ϣ��')==1)
	  {
	   conf();
	   return;
	  }
	}
			if(document.all.r_cus[0].checked)
	  {
	      document.all.t_sys_remark.value="�û�"+jtrim(document.all.cust_name.value)+"ʵ���Ǽǵ�"+document.all.custName.value;
	     }else{
	     document.all.t_sys_remark.value="�û�"+jtrim(document.all.cust_name.value)+"ʵ���Ǽǵ�"+document.all.h_custName.value;
	     }

	      if(jtrim(document.all.t_op_remark.value).length==0)
          {
          	if("<%=isKd%>" == "true"){
          		document.all.t_op_remark.value="����Ա<%=work_no%>"+"���û����<%=kdNo%>����ʵ���Ǽǡ��˺�������ҵ��ʵ���ǼǺ��������"
          	}else{
          		document.all.t_op_remark.value="����Ա<%=work_no%>"+"���û��ֻ�"+jtrim(document.all.srv_no.value)+"����ʵ���Ǽǡ��˺�������ҵ��ʵ���ǼǺ��������"
          	}
			  
	      }
		  if(jtrim(document.all.assuNote.value).length==0)
          {
          	if("<%=isKd%>" == "true"){
          		document.all.assuNote.value="����Ա<%=work_no%>"+"���û����<%=kdNo%>����ʵ���Ǽǡ��˺�������ҵ��ʵ���ǼǺ��������"
          	}else{
          		document.all.assuNote.value="����Ա<%=work_no%>"+"���û��ֻ�"+jtrim(document.all.srv_no.value)+"����ʵ���Ǽǡ��˺�������ҵ��ʵ���ǼǺ��������"
          	}
          	
			  
	      }


		 //��ʾ��ӡ�Ի���
		  var h=210;
		  var w=400;
		  var t=screen.availHeight/2-h/2;
		  var l=screen.availWidth/2-w/2;
		  var pType="subprint";
	    var billType="1";

	    var mode_code="<%=mode_code%>";
	 		var fav_code=null;
	 		var area_code=null

		  var sysAccept = document.all.loginAccept.value;

		  var printStr = printInfo("Detail");
		  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no;	scrollbars:yes; resizable:no;location:no;status:no;help:no"
				/* ningtn */
				var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
				var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
				/* ningtn */
		  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + "ȷʵҪ���е��������ӡ��"+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
  	  var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=srv_no%>&loginacceptJT="+$("#loginacceptJT").val()+"&submitCfm=" + "Yes"+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

  	  var ret=window.showModalDialog(path,printStr,prop);

		  if(typeof(ret)!="undefined")
		  {
			if((ret=="confirm"))
			{
			  if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
			  {
			   conf();
			  }
		    }
		    if(ret=="continueSub")
		    {
			  if(rdShowConfirmDialog('ȷ��Ҫ�ύʵ���Ǽ���Ϣ��')==1)
			  {
			   conf();
			  }
    		}
		  }
		  else
		  {
			  if(rdShowConfirmDialog('ȷ��Ҫ�ύʵ���Ǽ���Ϣ��')==1)
			  {
			   conf();
			  }
		  }
}

function chcek_pic1121()//����֤
{
	
var pic_path = document.all.filep.value;
	
var d_num = pic_path.indexOf("\.");
var file_type = pic_path.substring(d_num+1,pic_path.length);
//�ж��Ƿ�Ϊjpg���� //�����豸����ͼƬ�̶�Ϊjpg����
if(file_type.toUpperCase()!="JPG")
{ 
		rdShowMessageDialog("��ѡ��jpg����ͼ���ļ�");
		document.all.up_flag.value=3;
		//document.all.print.disabled=true;
		resetfilp();
	return ;
	}

	var pic_path_flag= document.all.pic_name.value;
	
	if(pic_path_flag=="")
	{
	rdShowMessageDialog("����ɨ����ȡ֤����Ϣ");
	document.all.up_flag.value=4;
	//document.all.print.disabled=true;
	resetfilp();
	return;
}
	else
		{
			if(pic_path!=pic_path_flag)
			{
			rdShowMessageDialog("��ѡ�����һ��ɨ����ȡ֤�������ɵ�֤��ͼ���ļ�"+pic_path_flag);
			document.all.up_flag.value=5;
			//document.all.print.disabled=true;
			resetfilp();
		return;
		}
		else{
			document.all.up_flag.value=2;
			document.all.uploadpic_b.disabled=false;//����֤
			}
			}
			
	}
	
	function uploadpic(){//����֤
	
	if(document.all.filep.value==""){
		rdShowMessageDialog("��ѡ��Ҫ�ϴ���ͼƬ",0);
		return;
		}
	if(document.all.but_flag.value=="0"){
		rdShowMessageDialog("����ɨ����ȡͼƬ",0);
		return;
		}
	frm.target="upload_frame";
	document.frm.encoding="multipart/form-data";
	var actionstr ="s1238Main_uppic.jsp?custId="+document.frm.custId.value+
									"&regionCode="+document.frm.regionCode.value+
									"&filep_j="+document.all.filep.value+
									"&card_flag="+document.all.card_flag.value+ 
									"&but_flag="+document.all.but_flag.value+
									"&idSexH="+document.all.idSexH.value+
									"&custName="+document.all.custName.value+
									"&idAddrH="+document.all.idAddrH.value.replace(new RegExp("#","gm"),"%23")+
									"&birthDayH="+document.all.birthDayH.value+
									"&custId="+document.all.custId.value+
									"&idIccid="+document.all.idIccid.value+
									"&workno="+document.all.workno.value+
									"&zhengjianyxq="+document.all.idValidDate.value+
									"&upflag=1";
									
	frm.action = actionstr; 
	document.all.upbut_flag.value="1";
	frm.submit();
	resetfilp();
	frm.target="_self";
	document.frm.encoding="application/x-www-form-urlencoded";
	}
	
	function resetfilp(){//����֤
		document.getElementById("filep").outerHTML = document.getElementById("filep").outerHTML;
		}
		
		function changeCardAddr(obj){

		document.all.custAddr.value=obj.value;
		document.all.contactAddr.value=obj.value;
		document.all.contactMAddr.value=obj.value;
	
}

function pubM032Cfm(){
	/*2015/8/19 16:12:01 gaopeng �����޸�BOSSϵͳʵ���ж��������ھ���ϵͳ������ȫʡʵ�����Ǽ��ձ���ĺ�-��������
					��������÷��� sM032Cfm 
				*/
				
				var myPacket = new AJAXPacket("/npage/public/pubM032Cfm.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
			  myPacket.data.add("idSexH",document.all.idSexH.value);
			  myPacket.data.add("custName",document.all.custName.value);
			  myPacket.data.add("idAddrH",document.all.idAddrH.value.replace(new RegExp("#","gm"),"%23"));
			  myPacket.data.add("birthDayH",document.all.birthDayH.value);
			  myPacket.data.add("custId",document.all.custId.value);
			  myPacket.data.add("idIccid",document.all.idIccid.value);
			  myPacket.data.add("zhengjianyxq",document.all.idValidDate.value);
			  myPacket.data.add("opCode","<%=opCode%>");
			  
			  core.ajax.sendPacket(myPacket,function(packet){
			  	var retCode=packet.data.findValueByName("retCode");
				  var retMsg=packet.data.findValueByName("retMsg");
				  
				  if(retCode == "000000"){
				  	//document.all.uploadpic_b.disabled=false;
				 	}else{
				 		//rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,0);
				 		//document.all.uploadpic_b.disabled=true;
						//return  false;
				 	}
		 		});
				myPacket = null;
}

function changeCardAddr1(obj){
  var Str = document.all.idType.value;
  
    if((Str.indexOf("���֤") > -1)||(Str.indexOf("���ڲ�") > -1)){
      if(obj.value.length<8){
        rdShowMessageDialog("Ҫ��8�������Ϻ��֣����������룡");
        obj.focus();
  			return false;
      }
    }
  
  document.all.custAddr.value=obj.value;
	document.all.contactAddr.value=obj.value;
	document.all.contactMAddr.value=obj.value;
	checkElement(document.all.contactAddr);
}

function scheckandread() {
			Idcardss();
			//alert(document.all.idIccid.value);	
			var myPacket = new AJAXPacket("addReadcardsum_1238.jsp","���ڻ��ϵͳʱ�䣬���Ժ�......");
			myPacket.data.add("srv_no","<%=srv_no%>");
			myPacket.data.add("liushuihao","<%=loginAccept%>");
			myPacket.data.add("idIccid",document.all.idIccid.value);
			core.ajax.sendPacket(myPacket,sreturncodes);
			myPacket = null;
	
}
		function sreturncodes(packet)
     	{
					var retcodes = packet.data.findValueByName("retcode");
					var retmsgs = packet.data.findValueByName("retmsg");
					if(retcodes=="000000"){
							
					}else {
					rdShowMessageDialog("��¼������������������룺"+retcodes+"������Ϣ��"+retmsgs);
					}
					
     	}
     	
     	//�·�����
		  function sendProLists(){
				var packet = new AJAXPacket("/npage/sq100/fq100_ajax_sendProLists.jsp","���ڻ�����ݣ����Ժ�......");
				packet.data.add("opCode","<%=opCode%>");
				packet.data.add("phoneNo","<%=srv_no%>");
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
					$("#custName").val(ret.split("~")[0]); //�ͻ�����
					$("#idIccid").val(ret.split("~")[1]); //֤������
					if($("#idIccid").val() != ""){
						checkIccIdFunc16New(document.all.idIccid,0,0);
						rpc_chkX('idType','idIccid','A');
					}
					$("#idAddr").val(ret.split("~")[2]);  //֤����ַ
					$("input[name='custAddr']").val(ret.split("~")[2]); //�ͻ���ַ
					$("input[name='contactAddr']").val(ret.split("~")[2]); //��ϵ�˵�ַ
					$("input[name='contactMAddr']").val(ret.split("~")[2]); //��ϵ��ͨѶ��ַ
					$("#idValidDate").val(ret.split("~")[3]); //֤����Ч��
					$("#loginacceptJT").val(ret.split("~")[4]); //������ˮ
					
					$("#idIccid").attr("class","InputGrey");
		  		$("#idIccid").attr("readonly","readonly");
		  		$("#custName").attr("class","InputGrey");
		  		$("#custName").attr("readonly","readonly");
		  		$("#idAddr").attr("class","InputGrey");
		  		$("#idAddr").attr("readonly","readonly");
		  		$("#idValidDate").attr("class","InputGrey");
		  		$("#idValidDate").attr("readonly","readonly");
				}
			}  
			
			//ֻ��Ҫ��table����һ��vColorTr='set' ���ԾͿ��Ը��б�ɫ
			$("table[vColorTr='set']").each(function(){
				$(this).find("tr").each(function(i,n){
					$(this).bind("mouseover",function(){
						$(this).addClass("even_hig");
					});
				
					$(this).bind("mouseout",function(){
						$(this).removeClass("even_hig");
					});
				
					if(i%2==0){
						$(this).addClass("even");
					}
				});
			});
			
$(document).ready(function(){
	
	/*ģ����֤���������� ͬʱ ���������������� �����Ķ������� 24����*/
	
	if("<%=is_Z_flag%>"=="true" || "<%=isKd%>"=="true"){
		$("#is_sPwdAuthChk_tr").hide();
	}else{
		$("#is_sPwdAuthChk_tr").show();
	}
	
	if("<%=realOpCode%>" == "m389"){
		
		$("select[name='isJSX']").find("option").eq(1).attr("selected","selected");
		$("select[name='isJSX']").find("option").eq(0).remove();
		reSetCustName();
		
		document.all.t_handFee.value = "0.0";
		document.all.t_factFee.value = "0.0";
		
		$("input[name='t_handFee']").attr("readonly","readonly");
		$("input[name='t_handFee']").attr("class","InputGrey");
		$("input[name='t_factFee']").attr("readonly","readonly");
		$("input[name='t_factFee']").attr("class","InputGrey");
	}
	
	
});



/*�ϴ�txt�ļ��ķ���*/
		function uploadBroad(){
			if($("#workNoList").val() == ""){
				rdShowMessageDialog("���ϴ��ļ���");
				$("#workNoList").focus();
				return false;
			}
			var formFile=frm.workNoList.value.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=frm.workNoList.value.length;
			formFile=frm.workNoList.value.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("�ϴ��ļ���ʽֻ����txt��������ѡ���ļ���",1);
				document.frm.workNoList.focus();
				return false;
			}
			else
				{
					/*׼���ϴ�*/
					document.frm.target="hidden_frame";
			    document.frm.encoding="multipart/form-data";
			    document.frm.action="/npage/sm389/fm389Upload.jsp";
			    document.frm.method="post";
			    document.frm.submit();
			    document.frm.encoding="application/x-www-form-urlencoded";
					return true;
				}
				
			
		}
		/*�ϴ��ɹ���Ҫ�����¶�*/
		function doSetFileName(oldFileName,newFileName,newFilePath){
			rdShowMessageDialog("�ϴ��ļ�"+oldFileName+"�ɹ���",2);
			$("input[name='serviceFileName']").val(newFileName);
			$("input[name='serviceFilePath']").val(newFilePath);
			/*�ϴ�����Ч*/
			$("#uploadFile").attr("disabled","disabled");
			
			
		}
		/*�ϴ�ʧ�ܺ�Ҫ�����¶�*/
		function showUploadError(errorInfo){
			rdShowMessageDialog(errorInfo,1);
		}
    
   	function tellMore1000(){
			rdShowMessageDialog("���ֻ���ϴ�1000�����ݣ���������ѡ���ļ�",1);
			return false;
		}
		function tellNotHaveOldPhone(phoneNo){
			rdShowMessageDialog("�ϴ�txt�ļ��б�����ڰ�����룺"+phoneNo,1);
			return false;
		}
		
		



	 </script>
	 </head>
	 <body>
 	<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
		<%@ include file="../../include/remark.htm" %>
		<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
		<input type="hidden" name="srv_no" id="srv_no" value="<%=srv_no%>">
  	<input type="hidden" name="cust_name" id="cust_name" value="<%=(String)custDoc.get(5)%>">
    <input type="hidden" name="cust_addr" id="cust_addr" value="<%=(String)custDoc.get(13)%>">
		<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
   	<input type="hidden" name="ic_no" id="ic_no" value="<%=(String)custDoc.get(16)%>">
  	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1238Main">
		<input type="hidden" name="user_id" id="user_id" value="<%=(String)custDoc.get(0)%>">
 		<input type="hidden" name="oriHandFee" id="oriHandFee" value="<%=((String)custDoc.get(23))%>">
    <input type="hidden" name="oldPass" id="oldPass" value="<%=((String)custDoc.get(6)).trim()%>">
    <input type="hidden" name="workno" value=<%=work_no%>>

    <input type="hidden" name="main_str1" >
    <input type="hidden" name="fj_str1"  >
    <input type="hidden" name="main_note" >

	  <input type="hidden" name="h_custName" id="h_custName" value="">
		<input type="hidden" name="h_contactPhone" id="h_contactPhone" value="">
		<input type="hidden" name="h_contactAddr" id="h_contactAddr" value="">
		<input type="hidden" name="h_idIccid" id="h_idIccid" value="">
		<input type="hidden" name="h_idAddr" id="h_idAddr" value="">
	  <input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	  <input type="hidden" name="HasPostBill" value="<%=HasPostBill%>">
	  <input type="hidden" name="HasEmailBill" value="<%=HasEmailBill%>">
	  <input type="hidden" name="ziyou_check" value="<%=resultl0[0][0]%>">
	  
<input type="hidden" name="card_flag" value="">  <!--���֤������־-->
  <input type="hidden" name="m_flag" value="">   <!--ɨ����߶�ȡ��־������ȷ���ϴ�ͼƬʱ���ͼƬ��-->
  <input type="hidden" name="sf_flag" value="">   <!--ɨ���Ƿ�ɹ���־-->
  <input type="hidden" name="pic_name" value="">   <!--��ʶ�ϴ��ļ�������-->
	<input type="hidden" name="up_flag" value="0">
	<input type="hidden" name="but_flag" value="0"> <!--��ť�����־-->
	<input type="hidden" name="upbut_flag" value="0"> <!--�ϴ���ť�����־-->
	<input type="hidden" name="custId" value="0">
	<input type="hidden" name="card2flag" value="0">
	
	<input type="hidden" name="isSendListFlag" id="isSendListFlag" value="N" />
  <input type="hidden" name="isQryListResultFlag" id="isQryListResultFlag" value="N" />
  <input type="hidden" name="sendListOpenFlag" id="sendListOpenFlag" value="<%=sendListOpenFlag%>" />
  <input type="hidden" name="loginacceptJT" id="loginacceptJT" />
  
	<input type="hidden" id="printAddFlag" name="printAddFlag" value="true"/>
	<input type="hidden" id="backCode" name="backCode" value="true"/>
	  <%@ include file="/npage/include/header.jsp" %>
	  			<div class="title">
					    <div id="title_zi">�û���Ϣ</div>
					</div>
              <table cellspacing="0">
                <tr>
                  <td class="blue" width="13%">
                    <div align="left">�ͻ�����</div>
                  </td>
                  <td width="20%">
                    <div align="left"><%=(String)custDoc.get(5)%></div>
                  </td>
                  <td class="blue" width="13%">
                    <div align="left">��ͻ���־</div>
                  </td>
                  <td width="20%">
                    <div align="left"><b><font class="orange"><%=(String)custDoc.get(17)%></font></b></div>
                  </td>
                  <td class="blue" width="13%">
                    <div align="left">���ű�־</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(18)%></div>
                  </td>
                </tr>
                <tr>
                  <td class="blue">
                    <div align="left">�ͻ�״̬</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(8)%> </div>
                  </td>
                  <td class="blue">
                    <div align="left">�ͻ�����</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(10)%> </div>
                  </td>
                  <td class="blue">
                    <div align="left">�ͻ����</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(12)%> </div>
                  </td>
                </tr>
                <tr>
                  <td class="blue">
                    <div align="left">֤������</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(15)%></div>
                  </td>
                  <td class="blue">
                    <div align="left">֤������</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(16)%></div>
                  </td>
                  <td class="blue">
                    <div align="left">�û�ID</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(0)%></div>
                  </td>
                </tr>
                <tr>
                  <td class="blue">
                    <div align="left">�ͻ���ַ</div>
                  </td>
                  <td nowrap colspan="2"><%=(String)custDoc.get(13)%></td>
                  	<td class="blue">
                  		<input type="button" name="iccIdCheck" class="b_text" value="У��" onclick="checkIccId()" >
                	</td>
                	<td class="blue">
                		<input type="button" name="get_Photo" class="b_text"   value="��ʾ��Ƭ" onClick="getPhoto()" disabled>
                	</td>
                	<td class="blue">
                	</td>
                </tr>
                <tr>
                  <td class="blue">ҵ��Ʒ��</td>
                  <td nowrap colspan="5"><%=sNewSmName%></td>
                </tr>
                <tr>
                  <td class="blue">
                    <div align="left">ҵ������</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(4)%></div>
                  </td>
                  <td class="blue">
                    <div align="left">��ǰԤ��</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(20)%></div>
                  </td>
                  <td class="blue">
                    <div align="left">��ǰǷ��</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(19)%></div>
                  </td>
                </tr>
                <tr>
                  <td class="blue">
                    <div align="left">ԭ�������</div>
                  </td>
                  <td>
                  	
                  	<%
                  		if(isKd){
                  			out.println(kdNo);
                  		}else{
                  			out.println(srv_no);
                  		}
                  	%>
                  	
                  </td>
                  <td class="blue">
                    <div align="left">ԭ�ͻ�ID</div>
                  </td>
                  <td nowrap colspan="3">
                    <div align="left"><%=(String)custDoc.get(1)%></div>
                  </td>
                  <td  class="blue" style="DISPLAY: none">
                    <div align="left" >����������</div>
                  </td>
                  <td nowrap style="DISPLAY: none">
                    <input name=assuName v_must=0 v_maxlength=30 v_type="string" v_name="����������" maxlength="30" size=20 index="0" value="<%=WtcUtil.repNull((String)custDoc.get(23))%>">
                  </td>
                </tr>
							</table>
							</div>
							<div id="Operation_Table">
								<div class="title">
									<div id="title_zi">ҵ�����</div>
								</div>
                    <table cellspacing="0">
                      <tr>
                        <td width="13%" class="blue">
                          <div align="left">�ͻ�����</div>
                        </td>
                        <td colspan="3" class="blue" width="30%">
                          <div align="left">
                            <input type="radio" name="r_cus" value="radiobutton" onclick="chgCustType()" index="7" checked>
                            �½��ͻ�
                            
                            <input type="radio" name="r_cus" value="radiobutton" <%if("m389".equals(realOpCode)){out.println("disabled");}%> onclick="chgCustType()" index="8" >
                            ���пͻ�</div>
                        </td>
                        <!-- //update �������ȡ����ݲ��ɼ������������ϻ����½��ͻ��� for ���ڹ��ֹ�˾�����Ż�M058ʵ���ƵǼ������������������ʾ@2015/2/11
											  <td class="blue" width="13%" >
													<div align="left">������</div>
												</td>
									  			<td>
									  			<input v_name="������" name= "xinYiDu" type="text" v_type="int" v_must=1 maxlength="6" value="0" size="10" onBlur="if(this.value!=''){if(checkElement(document.all.xinYiDu)==false){return false;}}; checkXi()" >
					                <font class="orange">*</font>
												</td>
												-->
                      </tr>

                      <tr id="tr_qryCondition" style="display:none">
                        <td class="blue">
                          <div align="left">��ѯ����</div>
                        </td>
                        <td colspan="3" class="blue">
                          <div align="left">
                            <input type="radio" name="r_con" id="r_con" value="0" onClick="chgCon()" index="9" checked>
                            �������
                            <input type="radio" name="r_con" id="r_con" value="1" onClick="chgCon()" index="10">
                            �ͻ�֤��
                            <input type="radio" name="r_con" id="r_con" value="2" onClick="chgCon()" index="11">
                            �ͻ�ID
                         	</div>
                        </td>
                      </tr>
                      <tr  id="tr_iccid" style="display:none">
                        <td  class="blue">
                          <div align="left">֤������</div>
                        </td>
                        <td>
                          <div align="left">
                            <select name="id_type" id="id_type"  index="0">
                            </select>
                          </div>
                        </td>
                        <td class="blue">
                          <div align="left">֤������</div>
                        </td>
                        <td>
                          <div align="left">
                            <input  type="text" size="18" name="id_no" id="id_no" v_name="֤������" maxlength="18" index="13" onKeyUp="if(event.keyCode==13)getAllId_No()">
                            <font class="orange">*</font>
                            <input type="button" class="b_text" name="qryId_No" value="��ѯ" onClick="getAllId_No()">
                          </div>
                        </td>
                      </tr>
                      <tr id="tr_srvno" style="display:none">
                        <td class="blue">
                          <div align="left">�������</div>
                        </td>
                        <td colspan="3">
                          <div align="left">
                            <input type="text" name="new_srv_no" v_must=1 id="new_srv_no" size="14" v_minlength=0 v_maxlength=11 v_type=mobphone  v_name="�������" maxlength="11" index="14" onBlur="if(this.value!=''){if(checkElement(document.all.new_srv_no)==false){return false;}}" onKeyUp="if(event.keyCode==13)qryID();">
                            <input class="b_text" type="button" name="b_print22" value="��ѯ" onMouseUp="qryID()" onKeyUp="if(event.keyCode==13)qryID()">
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">�¿ͻ�ID</div>
                        </td>
                        <td>
                           <input type="text" name="new_cus_id" value="" id="new_cus_id" size="14"  v_must=1 v_maxlength=14 v_type=int v_name="�¿ͻ�ID" maxlength="14" index="15" onKeyUp="chgNewId();if(event.keyCode==13)chkID();">
                        </td>

                        <td  class=blue>
				    		<span align="left" id="divCustPad1" style="display:;">�ͻ�����</span>&nbsp;
			      		</td>

                        <td   width=35% >
			      			<span  id="divCustPad2" style="display:;">
														<jsp:include page="/npage/query/pwd_one.jsp">
														<jsp:param name="width1" value="16%"  />
														<jsp:param name="width2" value="34%"  />
														 <jsp:param name="pname" value="passwd"  />
														<jsp:param name="pwd" value="12345"  />
							 							</jsp:include>
														<input type="button" class="b_text" name="b_chkId" value="У��" onMouseUp="chkID()" onKeyUp="if(event.keyCode==13)chkID()">
														<font class="orange">*</font>
														</span>&nbsp;
			                  	</td>
			                </tr>
			              </table>

                    <table id="tr_newCust" style="display:none" cellspacing="0">
                    	<!-- tianyang add for custNameCheck start -->
                    	<!--

					            -->
					            <tr id="ownerType_Type">
					            	<TD width=16% class="blue" >
					                <div align="left">���˿�������</div>
					              </TD>
					              <TD colspan="3" width="34%" class="blue" >
					              	<select align="left" name="isJSX" onChange="reSetCustName()" width=50 index="6">
					              		<option class="button" value="0" selected>��ͨ�ͻ�</option>
					              		<option class="button" value="1">��λ�ͻ�</option>
					              	<select align="left" name=isJSX onChange="" width=50 index="6">
					              	&nbsp;&nbsp;&nbsp;
													<input type="button" id="sendProjectList" name="sendProjectList" class="b_text" value="�·�����" onclick="sendProLists()" style="display:none" />                    
			                  	&nbsp;&nbsp;&nbsp;
                  				<input type="button" id="qryListResultBut" name="qryListResultBut" class="b_text" value="���������ѯ" onclick="qryListResults()" style="display:none" /> 
					              </TD>
					            </tr>
                      <!-- tianyang add for custNameCheck end -->
                      <tr>
                        <td class="blue" width="13%">
                          <div align="left">�ͻ���������</div>
                        </td>
                        <td width="30%">
                          <select align="left" name=districtCode width=50 index="16">
                          	<wtc:qoption name="sPubSelect" outnum="2">
														<wtc:sql>select trim(DISTRICT_CODE),DISTRICT_NAME from  SDISCODE Where region_code='<%=regionCode%>' order by DISTRICT_CODE</wtc:sql>
														</wtc:qoption>
                          </select>
                        </td>
                        <td class="blue" width="13%">
                          <div align="left">�ͻ�����</div>
                        </td>
                        <td>
                          <input name=custName id="custName" v_must=0 v_type="string" v_name="�ͻ�����"  maxlength="30" size=35 index="17" onblur="checkCustNameFunc16New(this,0,0);">
                          <font class="orange">*</font> </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">֤������</div>
                        </td>
                        <td id="tdappendSome">
                          
                        </td>
                        <td class="blue">
                          <div align="left">֤������</div>
                        </td>
                        <td>
                          <input name=idIccid id="idIccid" v_must=0 v_type="string" v_name="֤������"  maxlength="20"  index="19" onBlur="checkIccIdFunc16New(this,0,0);rpc_chkX('idType','idIccid','A');">
                          <font class="orange">*</font>
                          <input name=IDQueryJustSee type=button class="b_text" style="cursor:hand" onClick="getInfo_IccId_JustSee()" id="custIdQueryJustSee" value=��Ϣ��ѯ>&nbsp;&nbsp;&nbsp;
                          <input type="button" name="iccIdCheck1" class="b_text" value="У��" onclick="checkIccId1()" >&nbsp;
                          <input type="button" name="get_Photo1" class="b_text"   value="��ʾ��Ƭ" onClick="getPhoto1()" disabled>
                        </td>
                      </tr>
                      <TR id="card_id_type">
									    
								      <td colspan=2 align=center>
								  			<input type="button" style="display:none;" name="read_idCard_one" class="b_text"   value="ɨ��һ�����֤" onClick="RecogNewIDOnly_oness()" >
												<input type="button" name="read_idCard_two" class="b_text"   value="ɨ��������֤" onClick="RecogNewIDOnly_twoss()">
												<input type="button" name="scan_idCard_two" class="b_text"   value="����" onClick="scheckandread()" >
												<input type="button" name="scan_idCard_two222" class="b_text"   value="����(2��)" onClick="Idcard2('1')" >
								  			 <input type="hidden"  class="b_text"   value="�ϴ����֤ͼ��" onClick="sfztpsc1238()">	
								  			
												</td>
								  <td  class="blue">
								      	֤����Ƭ�ϴ�
								      </td>
								      <td>
								      	
												 <input type="file" name="filep" id="filep" onchange="chcek_pic1121();" >    &nbsp;
												 
												 <iframe name="upload_frame" id="upload_frame" style="display:none"></iframe>
												
												<input type="hidden" name="idSexH" value="1">
								  			<input type="hidden" name="birthDayH" value="20090625">
								  			<input type="hidden" name="idAddrH" value="������">
								  			
												 <input type="button" name="uploadpic_b" class="b_text"   value="�ϴ����֤ͼ��" onClick="uploadpic()"  disabled>
								      	
								      	</td>
								     </tr>
                      <tr>
                        <td class="blue">
                          <div id="idAddrDiv" align="left">֤����ַ</div>
                        </td>
                        <td>
                          <input name=idAddr id="idAddr" v_must=0 v_type="addrs" v_name="֤����ַ" v_maxlength=60 maxlength="60" size="30" index="20" onBlur="if(checkElement(this)){checkAddrFunc(this,0,0)}">
                          <font class="orange">*</font> </td>
                        <td class="blue">
                          <div align="left">֤����Ч��</div>
                        </td>
                        <td>
                          <input name="idValidDate" id="idValidDate"  v_must=0 v_maxlength=8 v_type="date" v_name="֤����Ч��" maxlength=8 size="8" index="21" onBlur="chkValid();" v_format="yyyyMMdd" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" >
                        </td>
                      </tr>
                      <tr id ="divPassword" style="display:;">
                        <td class="blue">
                          <div align="left">�ͻ�����</div>
                        </td>
                        <td>
						<input name="custPwd" type="password" onblur="" class="button"  maxlength="6">
						<input id="bttn1" name="bttn1" type="button" value="����"  class="b_text" >
						<font class="orange">*</font>
                        </td>
                        <td class="blue">
                          <div align="left">У��ͻ�����</div>
                        </td>
                        <td>
							<input  name="cfmPwd" type="password"  class="button" prefield="cfmPwd" filedtype="pwd"  maxlength="6">
						    <input onclick="showNumberDialog(document.all.cfmPwd);" id="btn2" type="button" value="������" class="b_text" >
							<font class="orange">*</font>
                        </td>
                      </tr>
<script type="text/javascript">
	var btn1Obj = document.getElementById("bttn1");
	btn1Obj.attachEvent("onclick",foo);
	btn1Obj.attachEvent("onclick",doo);
	function foo(){
		chkPwdEasy1(document.all.custPwd.value);
	}
	function doo(){
		showNumberDialog(document.all.custPwd);
	}
</script>
                      <tr>
                        <td class="blue">
                          <div align="left">�ͻ�״̬</div>
                        </td>
                        <td colspan="3">
                          <select align="left" name=custStatus width=50 index="24">
                          	<wtc:qoption name="sPubSelect" outnum="2">
														<wtc:sql>select trim(STATUS_CODE),STATUS_NAME from sCustStatusCode order by STATUS_CODE</wtc:sql>
														</wtc:qoption>
                          </select>
                          <select  align="left" name=custGrade width=50 index="25" style="display:none">
                          	<wtc:qoption name="sPubSelect" outnum="2">
														<wtc:sql>select trim(OWNER_CODE), TYPE_NAME from sCustGradeCode where REGION_CODE ='<%=regionCode%>' order by OWNER_CODE</wtc:sql>
														</wtc:qoption>
                          </select>
                        </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">�ͻ���ַ</div>
                        </td>
                        <td colspan="3">
                          <input name=custAddr v_type="addrs" v_must=0 v_name="�ͻ���ַ"  v_maxlength=60 maxlength="60" size=35 index="26" onBlur="if(checkElement(this)){checkAddrFunc(this,1,0);}">
                          <font class="orange">*</font> </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">��ϵ������</div>
                        </td>
                        <td>
                          <input name=contactPerson v_must=0 v_type="string" v_name="��ϵ������" onblur="checkCustNameFunc(this,1,0);" maxlength="20" size=20 index="27" v_maxlength=20>
                        	<font class="orange">*</font>
                        </td>
                        <td class="blue">
                          <div align="left">��ϵ�˵绰</div>
                        </td>
                        <td>
                          <input name=contactPhone v_must=0 v_type="phone" v_name="��ϵ�˵绰" maxlength="20"  index="28" size="20" onBlur="checkElement(this)">
                          <font class="orange">*</font> </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">��ϵ�˵�ַ</div>
                        </td>
                        <td>
                          <input name=contactAddr  v_must=0 v_type="addrs" v_name="��ϵ�˵�ַ" v_maxlength=60 maxlength="60" size=55 index="29" onBlur="if (checkElement(this)){ checkAddrFunc(this,2,0) }">
                          <font class="orange">*</font> </td>
                        <td class="blue">
                          <div align="left">��ϵ���ʱ�</div>
                        </td>
                        <td>
                          <input name=contactPost v_type="zip" v_name="��ϵ���ʱ�" maxlength="6"  index="30" size="20">
                        </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">��ϵ�˴���</div>
                        </td>
                        <td>
                          <input name=contactFax v_must=0 v_type="phone" v_name="��ϵ�˴���" maxlength="20"  index="31" size="20">
                        </td>
                        <td class="blue">
                          <div align="left">��ϵ��E_MAIL</div>
                        </td>
                        <td>
                          <input name=contactMail v_must=0 v_type="email" v_name="��ϵ��EMAIL" maxlength="30" size=30 index="32">
                        </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">��ϵ��ͨѶ��ַ</div>
                        </td>
                        <td colspan="3">
                          <input name=contactMAddr v_must=0 v_type="addrs" v_name="��ϵ��ͨѶ��ַ" v_maxlength=60 maxlength="60" size=55 index="33" onBlur="if(checkElement(this)){checkAddrFunc(this,3,0)};">
                          <font class="orange">*</font> </td>
                      </tr>
                      
		                 <!-- 20131216 gaopeng 2013/12/16 10:29:28 ������BOSS�����������ӵ�λ�ͻ���������Ϣ�ĺ� ���뾭������Ϣ start -->
		                 <%@ include file="/npage/sq100/gestoresInfo.jsp" %>
		                 <%@ include file="/npage/sq100/responsibleInfo.jsp" %>
                      <tr>
                        <td class="blue">
                          <div align="left">�ͻ��Ա�</div>
                        </td>
                        <td>
                          <select align="left" name=custSex width=50 index="34">
                           	<wtc:qoption name="sPubSelect" outnum="2">
														<wtc:sql>select trim(SEX_CODE), SEX_NAME from ssexcode order by SEX_CODE</wtc:sql>
														</wtc:qoption>
                          </select>
                        </td>
                        <td class="blue">
                          <div align="left">��������</div>
                        </td>
                        <td>
                          <input name=birthDay maxlength=8 index="35"  v_must=0 v_maxlength=8 v_type="date" v_name="��������" size="8" v_format="yyyyMMdd" onblur="checkElement(this);">
                        </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">ְҵ���</div>
                        </td>
                        <td>
                          <select align="left" name=professionId width=50 index="36">
                           	<wtc:qoption name="sPubSelect" outnum="2">
														<wtc:sql>select trim(PROFESSION_ID), PROFESSION_NAME from sprofessionid order by PROFESSION_ID DESC</wtc:sql>
														</wtc:qoption>
                          </select>
                        </td>
                        <td class="blue">
                          <div align="left">ѧ��</div>
                        </td>
                        <td>
                          <select align="left" name=vudyXl width=50 index="37">
                           	<wtc:qoption name="sPubSelect" outnum="2">
														<wtc:sql>select trim(WORK_CODE), TYPE_NAME from SWORKCODE Where region_code ='<%=regionCode%>' order by work_code DESC</wtc:sql>
														</wtc:qoption>
                          </select>
                        </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">�ͻ�����</div>
                        </td>
                        <td>
                          <input name=custAh maxlength="20"  index="38" size="20">
                        </td>
                        <td class="blue">
                          <div align="left">�ͻ�ϰ��</div>
                        </td>
                        <td>
                          <input name=custXg maxlength="20"  index="39">
                        </td>
                      </tr>
                      
                      
                    </table>
                     <table cellspacing="0" id="is_sPwdAuthChk_tr" >
 										<tr >
                      	<td class="blue" width="30%" >
                          <div align="left"><%=if24MonthText%></div>
                        </td>
                        <td >
                          <select style='width:220px'  id="is_sPwdAuthChk_sel" name="is_sPwdAuthChk_sel">
                          	<%=if23Options%>
                          </select>
                        </td>
                      </tr>
                    </table>

							<table cellspacing="0">
							<%@ include file="/npage/sq100/realUserInfo.jsp" %>
<!-- 20091201 begin -->
<%/*%>
							<TR style="display:none" id="Good_PhoneDate_GSM" >
								<TD nowrap class=blue width="13%">
									<div align="left">ԭ�������ʵ���Ǽ�����</div>
								</TD>
								<TD nowrap>
									<select name ="GoodPhoneFlag" onchange="GoodPhoneDateChg();">
										<option class='button' value='0' selected>--��ѡ��--</option>
										<option class='button' value='Y' >����ʵ���Ǽ�</option>
										<option class='button' value='N' >������ʵ���Ǽ�</option>
									</select>
								</TD>

								<TD nowrap class=blue width="13%">
									<div align="left" >�ɰ���ʵ���Ǽǵ�ʱ��</div>
								</TD>
								<TD nowrap colspan="3">
									<input id="GoodPhoneDate" class="button" name="GoodPhoneDate" maxlength="8" disabled >
									<font class="orange">(��ʽYYYYMMDD)</font>&nbsp;&nbsp;
								</TD>
							</TR>
<!-- 20091201 end -->
<%*/%>

                <tr>
                  <td class="blue" width="13%">
                    <div align="left">������</div>
                  </td>
                  <td width="20%">
                    <div align="left">
                      <input type="text" name="t_handFee" id="t_handFee" size="16" value="<%=(((String)custDoc.get(30)).trim().equals(""))?("0"):(((String)custDoc.get(30)).trim()) %>" v_type=float v_name="������" <%if(hfrf){%>readonly<%}%> onblur="ChkHandFee()" index="40">
                    </div>
                  </td>
                  <td class="blue" width="13%">
                    <div align="left">ʵ��</div>
                  </td>
                  <td width="20%">
                    <div align="left">
                      <input type="text" name="t_factFee" id="t_factFee" index="41" size="16"  onKeyUp="getFew()" v_type=float v_name="ʵ��"
                      <%
                        System.out.println("hfrf====="+hfrf);
	                       if(hfrf){
														 if(((String)custDoc.get(30)).trim().equals("") || ((String)custDoc.get(30)).trim().equals("0")  || Double.parseDouble(((String)(custDoc.get(30))))==0)
														 {
							   %>
								   								readonly
										<%
														 }
												 }
										%>
							   >
                    </div>
                  </td>
                  <td class="blue" width="13%">
                    <div align="left">����</div>
                  </td>
                  <td width="20%">
                    <div align="left">
                      <input type="text" name="t_fewFee" id="t_fewFee" size="16" readonly>
                    </div>
                  </td>
                </tr>
                <tr>
                	<td class="blue">
  	              	<div align="left">���ϲ�ѯ</div>
                	</td>
							  	 <td nowrap colspan="5">
							  		<select name ="print_query" >
							  			<option class='button' value='Y' >��</option> 
							  			<%/*
							  			<option class='button' value='N' selected>��</option>
							  			<option class='button' value='Y' >��</option>
							  			*/%>
							  		</select>
								  		<font class="orange">* ˵��:�»����Ƿ���Ȩ�쿴ʵ���Ǽ�ǰ����������</font>
							  		</td>
							  </tr>
							  <%if("m389".equals(realOpCode)){%>
							  <tr>
									<td width="20%" class="blue">
										�����ֻ����뵼��
									</td>
									<td colspan="5">
										<input type="file" name="workNoList" id="workNoList" class="button"
										style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
										&nbsp;&nbsp;
										<input type="button" name="uploadFile" id="uploadFile" class="b_text" value="�ϴ�" onclick="uploadBroad();"/>
										<font class="yellow">*</font>
									</td>
								</tr>
								<tr>
									<td class="blue">
										�ļ���ʽ˵��
									</td>
						      <td colspan="5"> 
						          �ϴ��ļ��ı���ʽΪ �ֻ�����+�س����� ��.txt�ļ���ʾ�����£�<br>
						          <font class='orange'>
						          	&nbsp;&nbsp; 13904510000<br/>
						          	&nbsp;&nbsp; 13904510001<br/>
						          	&nbsp;&nbsp; 13904510002<br/>
						          	&nbsp;&nbsp; 13904510003<br/>
						          	&nbsp;&nbsp; 13904510004<br/>
						          	&nbsp;&nbsp; 13904510005<br/>
						          	&nbsp;&nbsp; 13904510006<br/>
						          	&nbsp;&nbsp; 13904510007<br/>
						          	&nbsp;&nbsp; 13904510008
						          </font>
						          <b>
						          <br>&nbsp;&nbsp; ע����ʽ�е�ÿһ�����������ڿո�,��ÿ����Ϣ����Ҫ�س����С���������ϴ�1000�����ݡ�
						          		&nbsp;&nbsp; ����������Ϣ����ӵ�ǰ�����š�
						          <br>
						          </b> 
						      </td>
						      <iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
						    	<!--�ϴ��ļ��� -->	
									<input type="hidden" name="serviceFileName" value=""/>
									<!--�ϴ��ļ�ȫ·���� -->	
									<input type="hidden" name="serviceFilePath" value=""/>
						    </tr>
		    				<%}%>

                <tr>
                  <td class="blue">
                    <div align="left">ϵͳ��ע</div>
                  </td>
                  <td nowrap colspan="5">
                    <div align="left">
                      <input type="text" name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=60>
                    </div>
                  </td>
                </tr>
                <tr style="display:none">
                  <td class="blue">
                    <div align="left">�û���ע</div>
                  </td>
                  <td nowrap colspan="5">
                    <div align="left">
                      <input type="text" name="t_op_remark" id="t_op_remark" size="60"	v_maxlength=60  v_type=string  v_name="�û���ע" maxlength=60 >
                    </div>
                  </td>
                </tr>
                <tr >
                  <td class="blue">�û���ע</td>
                  <td nowrap colspan="5">
                    <input name=assuNote v_must=0 v_maxlength=60 v_type="string" v_name="�û���ע" maxlength="60" size=60  value="" index="42">
                  </td>
                </tr>
              </table>
              <jsp:include page="/npage/public/hwReadCustCard.jsp">
								<jsp:param name="hwAccept" value="<%=loginAccept%>"  />
								<jsp:param name="showBody" value="11"  />
								<jsp:param name="sopcode" value="m058"  />
							</jsp:include>
            	<table>
                <tr>
                  <td nowrap colspan="6" id="footer">
                    <div align="center">
                      <input class="b_foot" type="button" name="b_print" value="ȷ��&��ӡ" onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" index="43" disabled>
                      <input class="b_foot" type="button" name="b_clear" value="���" onClick="frm.reset();" index="44">
                      <input class="b_foot" type="button" name="b_back" value="����" onClick="location='<%=returnPage%>?activePhone=<%=phone_no%>' " index="45">
                    </div>
                  </td>
                </tr>
              </table>
		   <%@ include file="/npage/include/footer.jsp" %>
		   <%@ include file="/npage/common/pwd_comm.jsp" %>
 	 </form>

 	 </body>
 	 <%@ include file="/npage/public/hwObject.jsp" %> 
 	 <%@ include file="interface_provider1238.jsp" %> 
 	 <%@ include file="/npage/include/public_smz_check.jsp" %>
 	 </html>

	<script language="JavaScript">
	function fillSelect()
	{
		<%
			if(metaData!=null&&metaData.length>0){
		%>
		  	document.all.id_type.options.length=<%=metaData[0].length%>;
		<%
					for(int i=0;i<metaData[0].length;i++){
		%>
		    	   document.all.id_type.options[<%=i%>].text="<%=metaData[0][i].trim()%>";
		    	   document.all.id_type.options[<%=i%>].value=<%=i+1%>
		<%
					}
		%>
			    document.all.id_type.options[0].selected=true;
		<%
			}
		%>
	}

	</script>
