<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%
   /*
   * ����: Ӫҵ�շ�
�� * �汾: v1.0
�� * ����: 2009-01-13 14:37
�� * ����: wanglj
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      		�޸���      �޸�Ŀ��
 ��*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	String opName =  request.getParameter("opName");
	String opCode =  request.getParameter("opCode");
	String op_strong_pwd = (String) session.getAttribute("password");
	//��ˮ��
 	String PrintAccept = getMaxAccept();
  String v_smCode = WtcUtil.repNull(request.getParameter("v_smCode"));/*diling add for Ʒ��@2012/9/18 */
	String v_isDisabledBtnFlag = "N";/*diling add for ��װ���Ƿ��ȡ�ɹ���ʶ@2012/9/18 */
  String password = (String)session.getAttribute("password");	
	String work_no = (String)session.getAttribute("workNo");
	System.out.println("gaopengSeeLog============sq046====v_smCode=="+v_smCode);
	
	String closealertFlag =  WtcUtil.repNull(request.getParameter("closealertFlag"));
	String offerId_88 = "";
	String regCode_88 = (String)session.getAttribute("regCode");
%>
<%
	long totalBegin = System.currentTimeMillis();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title><%=opName%></title>
</head>
<body>
	<%---%%%%%%%%%%%add by liubo@2008-01-10,��Ϊ��ҳ����ؽ���,�Ӹ�����ʵ�ֲ�%%%%%%%%%%%%%--%>
		<style type="text/css">
				#addContainer{ 
				    position: absolute;
				    top: 50%;
				    left: 50%;
				    margin: -150px 0 0 -320px;
						text-align: center;
						width: 640px;
						padding: 20px 0 20px 0;
						border: 1px solid #339;
						background: #EEE;
						white-space: nowrap;
				}
				#addContainer img, #addContainer p{
						display: inline; 
						vertical-align: middle; 
						font: bold 12px "����", serif; 
				}
		</style>
		<script type="text/javascript">
			<!--
			     function loader(){
							var oDiv = document.createElement("div");
							oDiv.noWrap = true;
							oDiv.innerHTML = "<div id='addContainer'><nobr><img src='/nresources/default/images/blue-loading.gif'><p class='orange'>&nbsp;&nbsp;&nbsp;&nbsp;���ڽ���ͳһ�ɷѴ�������򡭡������ʱ��û�м��������ˢ�£�</p></nobr></div>"
							document.body.insertBefore(oDiv,document.body.firstChild);
							if(document.all){
								window.attachEvent("onload",function(){ oDiv.parentNode.removeChild(oDiv);});
							}else{
								window.addEventListener("load",function(){ oDiv.parentNode.removeChild(oDiv);},false);
							}
					 }
			//-->
		</script>
		<script>loader();</script>
	<%---%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����add by liubo@2010-01-10%%%%%%%%%%%%%%%%%%%%%%%%%%%%--%>
<%
	long beginTime1 = System.currentTimeMillis();
%>

<%@ include file="/npage/common/qcommon/print_includeq046.jsp" %>

<%
	long endTime1 = System.currentTimeMillis();
	System.out.println("...................���ش�ӡͷ�ļ���ʱ��Ϊ:  " + endTime1 +"-" + beginTime1 + " =="+(endTime1-beginTime1));	
%>

<%@ page import="java.util.Date" %>
<%@ page import="java.util.Locale"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<%
		 opName = "һ���Է��ýɷ�";
		 String servPhoneNo = "";
		 String  servOrder  = "";
		 String errCode = "";
		 String errMsg  = "";
		 String gCustId =  request.getParameter("gCustId");		//�ͻ�ID
     String pathFlag = request.getParameter("pathFlag");	
		 String orgCode =(String)session.getAttribute("orgCode");
		 String regionCode = orgCode.substring(0,2);
		 String gCustName = "";
		 String idNo =  request.getParameter("offerSrvId"); 	//�û�ID
		 String custOrderId =  request.getParameter("custOrderId");	//�ͻ�������		 
		 String prtFlag = request.getParameter("prtFlag");		//��ӡ��ʶ,���������ӡ,Y�ϴ�  N�ִ�
		 String loginNo = (String) session.getAttribute("workNo");	//��������		 
		 String selStr = "";	//�տʽ�õ��ַ���
		 String selStrCdma = "<option selected value='1'>ǰ̨Ӫҵ��ȡ</option><option selected value='4'>ϵͳ�Զ�����Ԥ��</option>";//����C���û�,ֻ��ǰ̨Ӫҵ��ȡ		 
		 String siteId  = (String)session.getAttribute("objectId"); //wuln add
		 String siteName = (String)session.getAttribute("siteName");//�����,���ڷ�Ʊ��ӡ
		 System.out.println(siteName+"046 siteId list==========================="+siteId);		 
		 //String printinfo   =  WtcUtil.repNull(request.getParameter("printinfo"));  //��ӡʹ�����ݴ�
		 String opcodeadd   =  WtcUtil.repNull(request.getParameter("opcodeadd"));  //��ӡʹ�����ݴ�
		 String oldMSISDN   =  WtcUtil.repNull(request.getParameter("oldMSISDN"));  //4100ԭ�ֻ��� ��ѯʹ��

		 String main_k_flag   =  WtcUtil.repNull(request.getParameter("main_k_flag")); 		 
		 
		 
		 /*2015/7/3 10:41:32 gaopeng ��ȡm275�����������ӡ��*/
		 String m275Printinfo   =  WtcUtil.repNull(request.getParameter("m275Printinfo"));  //��ӡʹ�����ݴ�
		 System.out.println("gaopengSeeLog=====m275Printinfo=="+m275Printinfo);
		 System.out.println("lijy add @20110517");
		 String isMmtel=WtcUtil.repNull(request.getParameter("isMmtel")); //�Ƿ���mmtel�û��ı�־��1��ʾ��mmtel�û���0��ʾ����
		 System.out.println("------------------------isMmtel----------------"+isMmtel);
		 System.out.println("lijy add end@20110517");
		 System.out.println("mylog------------------opcodeadd-------------------"+opcodeadd);
		 System.out.println("mylog------------------oldMSISDN-------------------"+oldMSISDN);
		 String offeridkd = WtcUtil.repNull(request.getParameter("offeridkd"));
		 String isJTTFflag="N";
		 //System.out.println("��ӡʹ�����ݴ���ӡʹ�����ݴ���ӡʹ�����ݴ���ӡʹ�����ݴ� siteId list==========================="+printinfo);		 
		 Map parametersMap = request.getParameterMap();
		 /*StringBuffer sb = new StringBuffer(80);
		 for(Iterator iterator = parametersMap.keySet().iterator(); iterator.hasNext(); sb.append("&"))
        {
            String key = (String)iterator.next();
            System.out.println("key========" + key);
            System.out.println("parametersMap.get(key)========" + parametersMap.get(key));
            Object values[] = (Object[])parametersMap.get(key);
            Object value = values == null ? "" : values[0];
            System.out.println("value========" + value);
            sb.append(key);
            sb.append("=");
            sb.append(value);
        }
        System.out.println("sb=============="+sb.toString()); //��������˹�����,���½ɷ�ʧ��,���ע�͵��ĳ��������������ȡ����*/ 
		 beginTime1 =  System.currentTimeMillis();
		 
		 	/** tianyang add for pos start **/
			String groupId = (String)session.getAttribute("groupId");
			/** tianyang add for pos end **/
			/* ningtn �����û��Ż�Ȩ����Ϣ�����ÿ��޸Ľ�� */
			String[][] favInfo = (String[][])session.getAttribute("favInfo");
			String[] feeFav = new String[4];
			feeFav[0] = "";
			feeFav[1] = "";
			feeFav[2] = "";
			feeFav[3] = "";
			String tempStr = "";
			for(int feefavi = 0; feefavi< favInfo.length; feefavi++){
				tempStr = (favInfo[feefavi][0]).trim();
				System.out.println("-------- fav -- " + tempStr);
				if(tempStr.compareTo("a002") == 0){
				/*�����������Ż� �����޸Ŀ���Ԥ�桢����Ԥ������Ԥ���*/
					feeFav[0] = favInfo[feefavi][0];
				}else if(tempStr.compareTo("a003") == 0){
					/*����SIM�����Ż� �����޸�SIM������*/
					feeFav[1] = favInfo[feefavi][0];
				}else if(tempStr.compareTo("a004") == 0){
					/*����ѡ�ŷ��Ż� �����޸Ŀ���ѡ�ŷ�*/
					feeFav[2] = favInfo[feefavi][0];
				}else if(tempStr.compareTo("a998") == 0){
					/*g785Ԥ����Ż�Ȩ��*/
					feeFav[3] = favInfo[feefavi][0];
				}
			}
			for(int feei = 0; feei < feeFav.length; feei++){
				System.out.println("======= fav feefav ===== " + feeFav[feei]);
			}
			
			
			/**
			System.out.println("zhouby --- sq046.jsp ---opCode" + opCode);
			System.out.println("zhouby --- sq046.jsp ---work_no" + work_no);
			System.out.println("zhouby --- sq046.jsp ---password" + password);
			System.out.println("zhouby --- sq046.jsp ---gCustId" + gCustId);
			*/
			String ipAddrss1 = (String)session.getAttribute("ipAddr");
			String ssss = "����cust_id[" + gCustId + "]���в�ѯ";
			String beizhussdese1="����custid=["+gCustId+"]���в�ѯ";
			
			/*2016/5/11 9:40:33 gaopeng ��ѯƷ��sm_code ��ֹ�ϵ�ָ�����ʱsm_code��ʧ*/
			String[] inParamsss3 = new String[2];
	    inParamsss3[0] = 
		"SELECT SM_CODE "
	  +" from dcustmsg t "
	 	+" where t.id_no in (select distinct ID_NO"
	  +" from dservordermsg t "
	  +" where t.cust_order_id =:custOrderId "
	  +" and t.serv_busi_id = '40006')"; 
	    inParamsss3[1] = "custOrderId="+custOrderId;
	    
    
%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3ss" retmsg="retMsg3ss" outnum="1">     
  <wtc:param value="<%=inParamsss3[0]%>"/>
  <wtc:param value="<%=inParamsss3[1]%>"/>
  </wtc:service>
  <wtc:array id="resultSSy" scope="end" />
  <%
   if(resultSSy.length > 0) {
    if(v_smCode != null && !"".equals(v_smCode)){
    
  	}else{
  		v_smCode = resultSSy[0][0];
  	}
   }
   System.out.println("gaopengSeelOg20160511==================v_smCode======="+v_smCode);
    
	%>

  <!-- 2013/11/12 16:06:23 gaopeng �޸�zhouby֮ǰ�ĵڶ����ͻ�������Ϣ���죬��������sUserCustInfo Ϊ  sQBasicInfo-->
	<wtc:utype name="sQBasicInfo" id="retBd0002" scope="end"  routerKey="region" routerValue="<%=regionCode%>">
     <wtc:uparam value="<%=gCustId%>" type="LONG"/>
  </wtc:utype>
  
  	<wtc:service name="sUserCustInfo" outnum="100" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="4977" />	
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=password%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss1%>" />
			<wtc:param value="<%=beizhussdese1%>" />
			<wtc:param value="<%=gCustId%>" />
	</wtc:service>
	<wtc:array id="result_custInfo" scope="end"/>	
		 	
		 	
	<%	 		
  String custiccids="";
  String custiccidtypes="";
  String custditypesnames="";
  
	if(result_custInfo.length>0){
	if(result_custInfo[0][0].equals("01")) {
		custiccidtypes = result_custInfo[0][12].trim();
		custiccids = result_custInfo[0][13];
		}
	}
	
	if("0".equals(custiccidtypes)) {
		custditypesnames="���֤";
  }else if("1".equals(custiccidtypes)) {
  	custditypesnames="����֤";
 	}else if("2".equals(custiccidtypes)) {
 		custditypesnames="���ڲ�";
 	}else if("3".equals(custiccidtypes)) {
 		custditypesnames="�۰�ͨ��֤";
 	}else if("4".equals(custiccidtypes)) {
 		custditypesnames="����֤";
 	}else if("5".equals(custiccidtypes)) {
 		custditypesnames="̨��ͨ��֤";
 	}else if("6".equals(custiccidtypes)) {
 		custditypesnames="���������";
 	}else if("7".equals(custiccidtypes)) {
 		custditypesnames="����";
 	}else if("8".equals(custiccidtypes)) {
 		custditypesnames="Ӫҵִ��";
 	}else if("9".equals(custiccidtypes)) {
 		custditypesnames="����";
 	}else if("A".equals(custiccidtypes)) {
 		custditypesnames="��֯��������";
 	}else if("B".equals(custiccidtypes)) {
 		custditypesnames="��λ����֤��";
 	}else if("C".equals(custiccidtypes)) {
 		custditypesnames="��λ֤��";
 	}else if("00".equals(custiccidtypes)) {
 		custditypesnames="���֤";
 	}
	
 %>
  
	<%
	String errCodeGetCust =retBd0002.getValue(0);
	String errMsgGetCust  =retBd0002.getValue(1);

	if(errCodeGetCust.equals("0") || errCodeGetCust.equals("000000")){
		System.out.println("���÷���sQBasicInfo in fq046(sq046).jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
		gCustName = retBd0002.getValue("2.0");
		System.out.println("���÷���sQBasicInfo in fq046(sq046).jsp custName : "+gCustName);
	}
	else{	 
		System.out.println("���÷���sQBasicInfo in fq046(sq046).jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
	%>
		<script language="JavaScript">
			rdShowMessageDialog("������룺<%=errCodeGetCust%>��������Ϣ��<%=errMsgGetCust%>");
			removeCurrentTab();
		</script>
	<%
	}
	%>

	<%
	String sql_rft = "select receive_fee_type,receive_fee_name from sServReceiveFeeType where receive_fee_type in ('1')";
	%>
	<!--��ѯ��ȡ��ʽ,ƴ��<select>,����selStr  jsp������,�ڴ�������Ϣ��ʱ����=====BEGIN-->
	<wtc:pubselect  name="sPubSelect"  outnum="2">
       <wtc:sql><%=sql_rft%></wtc:sql>													 
    </wtc:pubselect> 
     <wtc:iter id="IdRows" indexId="i">
		<%
				if("1".equals(IdRows[0])){
					selStr += "<option selected value="+IdRows[0]+">"+IdRows[1]+"</option>";
				}else{
					selStr += "<option  value="+IdRows[0]+">"+IdRows[1]+"</option>";	
				}
		%>
  	</wtc:iter>
  	<%
  		endTime1 = System.currentTimeMillis();
	 	System.out.println("...................��ѯ��ȡ��ʽ��ʱ��Ϊ:  " + endTime1 +"-" + beginTime1 + " =="+(endTime1-beginTime1));	
  		selStrCdma = selStr;
  		beginTime1 =  System.currentTimeMillis();
  	%>
  	<!--��ѯ��ȡ��ʽ,ƴ��<select>,����selStr  jsp������,�ڴ�������Ϣ��ʱ����=====END-->
  	
  	<!--����sOrderItemShow����,���ؿͻ�����custOrderId�µ����ж�������,���񶩵�,�ͷ��ÿ�Ŀ,�����д���=====BEGIN-->
  	
<%String regionCode_sOrderItemShow = (String)session.getAttribute("regCode");%>
	 <wtc:utype name="sOrderItemShow" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode_sOrderItemShow%>">
			<wtc:uparam value="<%=custOrderId%>" type="STRING"/>  
			<wtc:uparam value="<%=loginNo%>" type="STRING"/>      
			<wtc:uparam value="<%=opCode%>" type="STRING"/>  
     </wtc:utype>
   	
  	<%
  		 	endTime1 = System.currentTimeMillis();
	 		System.out.println("...................���÷��ò�ѯ��ʱ��Ϊ:  " + endTime1 +"-" + beginTime1 + " =="+(endTime1-beginTime1));	
	 		beginTime1 =  System.currentTimeMillis();
     	    String retCode_046 = retVal.getValue(0);
     	    
     		String retMsg_046 = retVal.getValue(1);
     		System.out.println("------------------retMsg_046---------------------"+retMsg_046);
     	
     	               StringBuffer logBuffer046 = new StringBuffer(80);
			WtcUtil.recursivePrint(retVal,1,"2",logBuffer046);		
			System.out.println(logBuffer046.toString());
			
			String str_g798_accept = retVal.getValue("2.0.3");
			System.out.println("-------hejwa-----------str_g798_accept--------------------->"+str_g798_accept);

			
			
			System.out.println(retCode_046+"......................"+retMsg_046);
     		String arrayOrders = "";
     		String servOrders = "";
     		float totalOpFee = 0;	
     		String feeFlag = "0";	//�շѱ�־,�ڻ�ȡ���ÿ�Ŀ��ʱ���޸�Ϊ1,�����Ϊ0,��ֱ��ת��ɷѽ���
 %>
 <script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/validate_class.js"></script>
 <script>
 <%
				out.println("var arrayOrder = new Array();");  //������������,����ƴ���������б�
				out.println("var servOrder = new Array();");	//���񶨵�����,����ƴ���񶨵��б�
				out.println("var allFeeArray = new Array();"); //���ÿ�Ŀ����,����ƴ���ÿ�Ŀ�б� ,ѹ��feeOrder����
				out.println("var savenames;");
				
				out.println("var servOrderNoArray = new Array();"); //���񶨵�������,���ڷ�Ʊ��ӡ
				
				out.println("var totalFee1 = '';");		//Ӧ�շ���
				out.println("var totalFee2 = '';");		//�Żݷ���
				out.println("var totalFee3 = '';");		//ʵ�շ���
				
				Set prtFlagSet = new HashSet();	//ͨ�������������ˮ��������Ʊ��ӡ,��set���ڴ洢 ��������~��ˮ�� ��
				out.println("var prtFlagSet = new Array();");	
				out.println("var opCodeOrderJs = new Array();");	//����opcode�ŵ�js������hejwa add 2013��6��5�� Ӫ����ӡ��� ��Ʊ
				out.println("var sysAcceptOrderJs = new Array();");	//������ӡ��ˮ�ŵ�js������hejwa add 2013��6��5�� Ӫ����ӡ��� ��Ʊ
				out.println("var sysOrderNoFJs = new Array();");	//���񶨵��ţ��ŵ�js������hejwa add 

				
				/**hejwa add 2013��11��20��10:08:01 ���ڱ����г���Ӫ��2013��8�µڶ���ҵ��֧��ϵͳ����ĺ�-�����ն�ҵ��ȡ�����ܵ�����
   				*����ȡ�ڵ�js���� ��ע�������������ظ����ظ�Ҳ����������Ӱ������
   				**/
     		out.println("var g798BillTypeArr      = new Array();");	//Ӫ������Ʊ���ͣ�0�����1תԤ���
     		out.println("var g798BillNameArr      = new Array();");	//��Ʊ����               
     		out.println("var g798ActualFeeUppeArr = new Array();");	//��Ʊ����д��       
     		out.println("var g798ActualFeeLoweArr = new Array();");	//��Ʊ��Сд��       
     		out.println("var g798BrandNameArr     = new Array();");	//�ն�Ʒ��               
     		out.println("var g798TypeNameArr      = new Array();");	//�ն��ͺ� 
     		out.println("var g798shuilvArr     = new Array();");	//˰��             
     		out.println("var g798shuieArr     = new Array();");	//˰��    
     		out.println("var g798actionnameArr     = new Array();");	//�����
     		out.println("var g798actionidArr     = new Array();");	//�����    
     		out.println("var g798IMEIArr     = new Array();");	//imei    
     		out.println("var g798JSJE     = new Array();");	//imei    
				
     		if(retCode_046.equals("0")){
     			int num = retVal.getSize("2");	//ȡ�ö����������
     			for(int i = 0 ;i < num;i++){
     			
     				//��ʾ���������б�
     				
     				UType arrayOrderUtype = retVal.getUtype("2."+i+".0");	//ȡ��������UTYPE
     				String opCodeOrders   = arrayOrderUtype.getValue(9);	//ȡ��������opcode
     				
     				String eiType         = arrayOrderUtype.getValue(10);	//ȡ��������ʽ
     				String instNum        = arrayOrderUtype.getValue(11);	//���ڸ��������������ǺͶ��������Ű�
     				String arrayOrderNo046 = arrayOrderUtype.getValue(1);	//ȡ����������
     				
     				//��ʾ���񶨵��б�
     			   	     			   	
	     			  /**hejwa add 2013��11��20��10:08:01 ���ڱ����г���Ӫ��2013��8�µڶ���ҵ��֧��ϵͳ����ĺ�-�����ն�ҵ��ȡ�����ܵ�����
	     				*ȡӪ���ɷѽڵ㣬���ݽڵ�ƴ�ӷ�Ʊ�����뵽�ύ����
	     				**/
	     				if("g798".equals(opCodeOrders)){
	     					feeFlag = "1";
	     					if(retVal.getSize("2."+i+".2")>0){
	     						if(retVal.getSize("2."+i+".2.0")>0){
		     						UType g798Utype = retVal.getUtype("2."+i+".2.0");	//Ӫ����Ʊ�ڵ�UTYPE
		     						int g798BillSize = g798Utype.getSize();
		     						for(int g=0; g<g798BillSize;g++){
		     							UType g798BillUType = g798Utype.getUtype(g);
		     							out.println("g798BillTypeArr.push('"+g798BillUType.getValue(1)+"');");
		     							out.println("g798BillNameArr.push('"+g798BillUType.getValue(2)+"');");
		     							out.println("g798ActualFeeUppeArr.push('"+g798BillUType.getValue(3)+"');");
		     							out.println("g798ActualFeeLoweArr.push('"+g798BillUType.getValue(4)+"');");
		     							out.println("g798BrandNameArr.push('"+g798BillUType.getValue(5)+"');");
		     							out.println("g798TypeNameArr.push('"+g798BillUType.getValue(6)+"');");
		     							out.println("g798shuilvArr.push('"+g798BillUType.getValue(7)+"');");
		     							out.println("g798shuieArr.push('"+g798BillUType.getValue(8)+"');");
		     							out.println("g798actionnameArr.push('"+g798BillUType.getValue(9)+"');");
		     							out.println("g798actionidArr.push('"+g798BillUType.getValue(10)+"');");
		     							out.println("g798IMEIArr.push('"+g798BillUType.getValue(11)+"');");
		     							out.println("g798JSJE.push('"+g798BillUType.getValue(12)+"');");
	     							}	
	     						}
	     					}
	     				}
     				
     				
     				String arrayOrderName = arrayOrderUtype.getValue(3);	//��������
     				String isComp = arrayOrderUtype.getValue(7);	//�Ƿ���ϲ�Ʒ��ʶ
     				String isPrtFeeDetail = arrayOrderUtype.getValue(8);	//�Ƿ��ӡ�վ�
     				
     				System.out.println("------------------isPrtFeeDetail---------------------------"+isPrtFeeDetail);
     				
     				arrayOrders = arrayOrders + arrayOrderNo046 + "|" ;
     				
     				for(int j = 0 ; j < arrayOrderUtype.getSize()-5;j++){
     						String tmp = arrayOrderUtype.getValue(j);
     						if(j == 2){					//����	ҵ���������
     						  if("100".equals(tmp)){
     								out.println("arrayOrder.push('��װ');");
     						  }else{
     						  	out.println("arrayOrder.push('�ͻ�����');");	
     						  }
	     					}else{
	     						out.println("arrayOrder.push('" + tmp + "');");
	     					}
     			  }
     			  	
     			  int servNum = retVal.getSize("2."+i+".1");			//ȡ�ö��������µķ��񶩵�����
     			  System.out.println("..................servNum="+servNum);
     			  
     			  
     			  for(int j = 0 ; j < servNum ; j++){
     			  
     			   	//��ʾ���񶨵��б�
     			   	
     			   	UType servOrderUtype = retVal.getUtype("2."+i+".1."+j+".0");	//ȡ���񶩵�UTYPE
     			   	
     			   	out.println("opCodeOrderJs.push('"+opCodeOrders+"');");//����opcode�ŵ�js������hejwa add 2013��6��5�� Ӫ����ӡ��� ��Ʊ
     			   	
     			   	out.println("servOrderNoArray.push('"+ servOrderUtype.getValue(0) +"');");	//�����񶩵���ŷ���servOrderNoArray JS������
     			   	servOrders = servOrders + arrayOrderUtype.getValue(1) + "~" + servOrderUtype.getValue(0) + "|" ;	//��������~���񶩵����  ��,���ڽɷ��ύ
     			   	String serv_bus_id = servOrderUtype.getValue(6);	//ȡserv_bus_id,���������sql��ѯ,�õ������������master_serv_type,���master_serv_type��0 ,����C��ҵ��,C��ҵ��ֻ����ȡ��ʽ������
     			   	String master_serv_type = "";
     			   	
     			   	isJTTFflag = servOrderUtype.getValue(9);
     			   	
%>

						<wtc:pubselect  name="sPubSelect"  outnum="1">
					       <wtc:sql>select c.master_serv_type from product a , service_offer b ,master_server c where a.product_id =b.product_id and a.master_serv_id = c.master_serv_id and b.service_offer_id='?'</wtc:sql>													 
					       <wtc:param value="<%=serv_bus_id%>"/>
					    </wtc:pubselect> 
					   <wtc:iter id="IdRows" indexId="ii">
					    
					<%
							 master_serv_type = IdRows[0];
							 System.out.println("..................master_serv_type="+master_serv_type);
							 

					%>
					</wtc:iter>
					
<%     			   	
     			  	for(int m = 0 ; m < servOrderUtype.getSize()-3;m++){
     			  		String tmp = servOrderUtype.getValue(m);
     			  		if(m == 0){
     			  			String phoneNum = "";
     			  			String prePayFee = "";
     			  			String jifen = "";
     			  			String phoneFeeStr  = "";
     			  			if("TRUE".equals(isPrtFeeDetail) || "true".equals(isPrtFeeDetail)){
     			  				UType phoneUtype = new UType();
     			  				servPhoneNo = servOrderUtype.getValue(2);
     			  				//if("0".equals(servPhoneNo))	continue;
     			  				System.out.println(".................servPhoneNo == " + servPhoneNo);
     			  				phoneUtype.setUe("STRING", servPhoneNo);    
     			  				System.out.println("--------------------------------------phoneUtype----------------------"+phoneUtype);			  				
     			  				%>
                 <%String regionCode_sShowNumInfo = (String)session.getAttribute("regCode");%>
     			  					<wtc:utype name="sShowNumInfo" id="retVal2"  scope="end"  routerKey="region" routerValue="<%=regionCode_sShowNumInfo%>">
								          <wtc:uparam value="<%=phoneUtype%>" type="UTYPE"/>      
								      </wtc:utype>
     			  				<%
     			  				
     			  				 errCode  = retVal2.getValue(0);
     			  				 errMsg  = retVal2.getValue(1);
     			  				System.out.println("--------------sShowNumInfo---------------retVal2.getValue(0)------------------------"+retVal2.getValue(0));
     			  				if("0".equals(retVal2.getValue(0))){
     			  				phoneNum = retVal2.getValue("2.0.0");
     			  				prePayFee = retVal2.getValue("2.0.1");
     			  				jifen = retVal2.getValue("2.0.2");
     			  				phoneFeeStr  = phoneNum+"~"+prePayFee+"~"+jifen+"~";
     			  				System.out.println("--------------------------------------phoneFeeStr----------------------"+phoneFeeStr);			  				
     			  				}
     			  				
     			  			}
     			  			//ÿ�����񶩵��᷵��һ����ˮ,�ɶ�������~��ˮ����ӡһ�ŷ�Ʊ, ��������ȷ���set�й����ظ�Ԫ��,��ѹ��JS������
     			  			
     			  			String prtLoginAccept = servOrderUtype.getValue(7);
     			  			
     			  			out.println("sysAcceptOrderJs.push('"+prtLoginAccept+"');");
     			  			String prtFlagElement = arrayOrderNo046 + "~" + prtLoginAccept;
     			  			
     			  			System.out.println("-----------------prtFlagElement-------------------"+prtFlagElement);
     			  			prtFlagSet.add(prtFlagElement) ;
     			  			if("Y".equals(isComp)){
     			  				out.print("servOrder.push('<input type=radio  style=\"display:none\" v_isPrtFeeDetail = " + isPrtFeeDetail + "  v_phone_no_str=" + phoneNum + "  v_opCode_order=\""+opCodeOrders+"\"  v_sys_accept=\""+servOrderUtype.getValue(7)+"\" v_instNum=\""+instNum+"\"   v_ei_type=\""+eiType+"\""+" v_phone_fee_str=" + phoneFeeStr + "  v_prtFlag=" + prtFlagElement + " v_iscomp="+isComp+" v_phoneNo ="+gCustId+" v_opType="+ arrayOrderName +" v_custName= "+ gCustName +" onclick=showMyFee(this,this.v_span) v_span="+tmp+" name=servOrders value=" +arrayOrderUtype.getValue(1)+"~"+ tmp+"~"+servOrderUtype.getValue(6) + "~" + master_serv_type+">"+ tmp +"');");
     			  			
     			  			}else{
     			  				
     			  				out.print("servOrder.push('<input type=radio   style=\"display:none\"  v_isPrtFeeDetail = " + isPrtFeeDetail + "  v_opCode_order=\""+opCodeOrders+"\"  v_sys_accept=\""+servOrderUtype.getValue(7)+"\" v_instNum=\""+instNum+"\"   v_ei_type=\""+eiType+"\""+"  v_phone_no_str=" + phoneNum + " v_phone_fee_str= " + phoneFeeStr + " v_prtFlag=" + prtFlagElement + " v_iscomp="+isComp+" onclick=showMyFee(this,this.v_span) v_span="+tmp+" name=servOrders value=" +arrayOrderUtype.getValue(1)+"~"+ tmp+"~"+servOrderUtype.getValue(6) + "~" + master_serv_type+">"+ tmp +"');");	
     			  			}
     			  		}else if(m ==5){		//������񶨵��Ľɷ�״̬
     			  		  if("0".equals(tmp)){
     			  				out.println("servOrder.push('δ�ɷ�')");
     			  		  }else if("1".equals(tmp)){
     			  		  	out.println("servOrder.push('�ѽɷ�')");	
     			  		  }else{
     			  		  	out.println("servOrder.push('���ֽɷ�')");		
     			  		  }
	     			  	}else{
	     			  		out.println("servOrder.push('" + tmp + "');");
	     			  	}
     			    }
     			       			    
     			    //��ʾ������Ϣ�б�
     			    
     			    out.println("var feeOrder = new Array();");	// ��ŷ��ÿ�Ŀ��JS����,һ�����񶩵�һ������������,�������з��񶩵��ķ�������ѹ��allFeeArray
     			     
     			    for(int m = 0 ; m < retVal.getSize("2."+i+".1."+j+".1");m++){
     			    	UType feesUtype = retVal.getUtype("2."+i+".1."+j+".1."+m);	//ȡ����UTYPE
     			    	out.println("totalFee1 = Number(totalFee1) + Number("+feesUtype.getValue(1)+")");	       //Ӧ�շ���	�ۼ�
     			    	out.println("totalFee2 = Number(totalFee2) + Number("+feesUtype.getValue(2)+")");          //�Żݷ���	�ۼ�
     			    	out.println("totalFee3 = Number(totalFee3) + Number("+feesUtype.getValue(3)+")");          //ʵ�շ���	�ۼ�
     			    	
     			    	UType totalUtype = feesUtype.getUtype(4);	//ȡ���ÿ�Ŀ����UTYPE
   			    		String  arrayOrder = arrayOrderUtype.getValue(1);
   			    		servOrder = servOrderUtype.getValue(0);
     			    	int rowcount = totalUtype.getSize();	//ȡ���ÿ�Ŀ���ϸ���
     			    	
     			    	for(int n = 0 ; n< rowcount; n++){
     			    		if("0".equals(feeFlag)) feeFlag = "1"; 	//ֻҪ�з��ÿ�Ŀ,�Ͳ�������ѵ�,Ҫ��ʾ�ɷѽ���
     			    		UType uuu = totalUtype.getUtype(n);
     			    		String textStyle = "";
     			    		String classStyle = "";
     			    		String feeCode = "";	//2011/11/17 wanghfa���
     			    		for (int k = 0 ; k< uuu.getSize()-8;k++){
     			    			String tmp = uuu.getValue(k);
     			    		  if(k == 1) continue;
     			    		  if(k == 0){
     			    		  	String  tmp2 = uuu.getValue(k+1);	//ȡ���ô���
     			    		  	System.out.println("gaopengS1===tmp2="+tmp2+",tmp="+tmp);
     			    		  	feeCode = uuu.getValue(k+1);	//ȡ���ô���
     			    		  	String  feeName = uuu.getValue(6);	//ȡ��������,��������ǰ���и�������,��������ͺͷ��ô���,�Լ����ÿ�Ŀ�ķ��񶩵��������
     			    		  	/* ningtn �����װ�Ѳ������޸� */
     			    		  		textStyle = "readonly";
     			    		  		classStyle = "forMoney required";
     			    		  		if(tmp2.equals("21")){
     			    		  			/* �������Ԥ�棬���ɸ� */
     											textStyle = "readonly";
     											classStyle = "forMoney required InputGrey";
     										}else if(tmp2.equals("9001")){
     											textStyle = "readonly";
     											classStyle = "forMoney required InputGrey";
     			    		  			/* SIM������ */
     			    		  			/* SIM�����ã��ָĻ�ԭģʽ��
     			    		  			if(WtcUtil.haveStr(feeFav,"a003")){
     												textStyle = "";
     												classStyle = "forMoney required";
     											}else{
     												textStyle = "readonly";
     												classStyle = "forMoney required InputGrey";
     											}
     											*/
     											if("g784".equals(opcodeadd) || "g785".equals(opcodeadd) || "m028".equals(opcodeadd) || "m094".equals(opcodeadd)){
     											/*ningtn Ӫҵǰ̨Ԥ������ͳһ�ɷѣ�sim����Ϊ0Ԫ(�������޸�)*/
     												textStyle = "readonly";
     												classStyle = "forMoney required InputGrey";
     											}else{
	     											textStyle = "";
	     											classStyle = "forMoney required";
     											}
     										}else if(tmp2.equals("9002")){
     			    		  			/* ����ѡ�ŷ� */
     			    		  			if(WtcUtil.haveStr(feeFav,"a004")){
     												textStyle = "";
     												classStyle = "forMoney required";
     											}else{
     												textStyle = "readonly";
     												classStyle = "forMoney required InputGrey";
     											}
     										}else if(tmp2.equals("1001") || tmp2.equals("2") || tmp2.equals("1000")){
     			    		  			/* ����Ԥ��� ����Ԥ�� ����Ԥ��� */
     			    		  			/*ningtn  У԰Ӫҵǰ̨Ԥ������ͳһ�ɷѣ�sim����Ϊ0Ԫ������Ԥ��Ϊ0Ԫ*/
     			    		  			if("g785".equals(opcodeadd)){
     			    		  					textStyle = "readonly";
	     												classStyle = "forMoney required InputGrey";
	     			    		  		}else{
	     			    		  			if(WtcUtil.haveStr(feeFav,"a002")){
	     												textStyle = "";
	     												classStyle = "forMoney required";
	     											}else{
	     												textStyle = "readonly";
	     												classStyle = "forMoney required InputGrey";
	     											}
     											}
     										}
     										
     			    		  	if(opcodeadd.equals("4977")){
     										if(tmp2.equals("9003")){
     											textStyle = "readonly";
     											classStyle = "forMoney required InputGrey";
     										}/*2016/5/11 9:30:05 gaopeng kiƷ�� ����ƷԤ���ûҲ����޸�*/
     										else if(tmp2.equals("200") && "ki".equals(v_smCode)){
     											textStyle = "readonly";
	     										classStyle = "forMoney required InputGrey";
	     										System.out.println("gaopengSeelOg20160511==================�����޸���======="+tmp);
     										}
     									}else if(opcodeadd.equals("g629")){//��ͥ������������Ԥ���
     										if(tmp2.equals("3001")){
     											textStyle = "";
     											classStyle = "forMoney required ";
     										}
     									}
     			    		  %>
	     									feeOrder.push("<%=servOrder%>");
	     									feeOrder.push("<input type=hidden v_pparent=<%=arrayOrder%> v_type=fee_codes v_mustFee=1 v_parent=<%=servOrder%> name=fee_code<%=n%>_<%=k%> v_feeType=<%=tmp%> value=<%=tmp2%>><input type='text'name=fee_name<%=n%>_<%=k%> value=<%=feeName%>>"); 
	     									
     			    			<%
     			    				continue;
     			    			}
     			    			if(k == 4){
     			    			String  tmp2 = uuu.getValue(1);	//ȡ���ô���
     			    			System.out.println("gaopengSeeLog============tmp2="+tmp2);
     			    			/*2014/07/08 13:35:23 gaopeng ����9001�жϣ������SIM�����ã���Ϊֻ��*/
     			    			if(tmp2.equals("9001")){
     			    					textStyle = "readonly";
 												classStyle = "forMoney required InputGrey";
 												System.out.println("gaopengSeeLog============textStyle="+textStyle);
 												System.out.println("gaopengSeeLog============classStyle="+classStyle);
 										}
     			    				//����Ӫҵ�Ż�,Ӫ��=ʵ��-����-ʵ��,������ʵ���ı����ĵڶ�����������,��һ����������ʵ�ո���,�����û�����Ƿ�ʱ,�ָ�ԭֵ
     			    			    float opFee0466 = Float.parseFloat(uuu.getValue(2)) -  Float.parseFloat(uuu.getValue(3)) - Float.parseFloat(uuu.getValue(4));
     			    				//�ۼ�Ӫҵ�Ż�
     			    				totalOpFee += opFee0466;	
     			    				String opFee046 = String.valueOf(opFee0466);
     			    				//System.out.println(Float.parseFloat(uuu.getValue(2))+"-"+Float.parseFloat(uuu.getValue(4))+":"+Float.parseFloat(uuu.getValue(3))+" =opFee046  = " +opFee046);
     			    			if(feeCode.equals("9003")) {
										%>
     			    			//2013/07/04 10:22:10 gaopeng �޸Ĳ���
     			    			
     			    				savenames="realPayFee"+"<%=n%>"+"_"+"<%=k%>";     			 
     			    			<%
     			    			}
     			    				if(opcodeadd.equals("g785")){
     			    					if(uuu.getValue(6).equals("����Ԥ���")) {
	     			    		  			if(WtcUtil.haveStr(feeFav,"a998")){
 												textStyle = "";
 												classStyle = "forMoney required";
 												System.out.println("��У԰�뿪��g785��a998�Ż�Ȩ��");
 											}else{
 												textStyle = "readonly";
 												classStyle = "forMoney required InputGrey";
 												System.out.println("û����У԰�뿪��g785��a998�Ż�Ȩ��");
 											}
     		     			    	%>
     		     			    
         			    					//document.all.totalFee3.value="0.00";
         			    					feeOrder.push("<input type=text size=10  maxLength='15' name=realPayFee<%=n%>_<%=k%> v_feeCode=<%=feeCode%> class='<%=classStyle%>' vflag=1  onchange = changeRealPayFee() <%=textStyle%> value='0.00'><input type=hidden name=realfee<%=n%>_<%=k%>  value='0.00'><input type='text' style='display:none' id='opchangeFee<%=n%>_<%=k%>' value='<%=opFee046%>' v_oldvalue='0'>");
         			    			<%     			    						
     			    					}else {
     			    			%>
     			    			
     			    					//document.all.totalFee3.value="0.00";
     			    					feeOrder.push("<input type=text size=10  maxLength='15' name=realPayFee<%=n%>_<%=k%> v_feeCode=<%=feeCode%> class='<%=classStyle%>' vflag=1  onchange = changeRealPayFee() <%=textStyle%> value='0.00'><input type=hidden name=realfee<%=n%>_<%=k%>  value='0.00'><input type='text' style='display:none' id='opchangeFee<%=n%>_<%=k%>' value='<%=opFee046%>' v_oldvalue='0'>");
     			    			<%
     			    					}
     			    				}
     			    			else{
     			    				
     			    			%>
     			    					if("<%=feeCode%>" == "200" && "<%=v_smCode%>" == "ki"){
     			    		   			feeOrder.push("<input type=text size=12  maxLength='15' id='realPayFee<%=n%>_<%=k%>' name=realPayFee<%=n%>_<%=k%> v_feeCode=<%=feeCode%> class='<%=classStyle%>' vflag=1  onchange = changeRealPayFee() <%=textStyle%> value='0.0'><input type=hidden name=realfee<%=n%>_<%=k%>  value='0.0'><input type='text' style='display:none' id='opchangeFee<%=n%>_<%=k%>' value='<%=opFee046%>' v_oldvalue='0'>");
     			    		   		}else{
     			    						feeOrder.push("<input type=text size=12  maxLength='15' id='realPayFee<%=n%>_<%=k%>' name=realPayFee<%=n%>_<%=k%> v_feeCode=<%=feeCode%> class='<%=classStyle%>' vflag=1  onchange = changeRealPayFee() <%=textStyle%> value='<%=tmp%>'><input type=hidden name=realfee<%=n%>_<%=k%>  value='<%=tmp%>'><input type='text' style='display:none' id='opchangeFee<%=n%>_<%=k%>' value='<%=opFee046%>' v_oldvalue='0'>");	
     			    					}
     			    					
     			    					
     			    			<%
     			    				}
     			    			%>
     			    			<%
     			    				continue;
     			    			}
     			    			if(k == 5){	//������û�������Ҫ�ж������⴦��,��ʵ����дѭ����,�����տ�ʼ����ʱ�������ӵ�,��������...
     			    			 	k++;
     			    				continue;
     			    			}
     			    			System.out.println(" ========gaopengmmm= ningtn fq046 ====  [" + n + " = " + k + " - " + tmp + "]");
     			  		    //out.println("feeOrder.push('" + tmp + "');");	//ѹ�����JS������
     			  		    if(k==2 && feeCode.equals("9003")) {
     			    			System.out.println(" ====gaopengmmm===== ningtn fq046 ====  111111111111");
     		
     			    						/*begin diling add for ��̬�����ݿ��л�ȡ��װ��@2012/9/19 */	
     			    						String  inParams [] = new String[2];
     			    						inParams[0]="SELECT prefee FROM sbandprefee where region_code=:regioncode and sm_code=:smcode order by prefee asc";	 
     			    						inParams[1] = "regioncode="+regionCode+",smcode="+v_smCode;   
     			    						//System.out.println(" ====gaopengSeelog===f046.jsp=====  regioncode="+regionCode);		
     			    						System.out.println(" ====gaopengSeelog===f046.jsp=====  smcode="+v_smCode);					
     			    			%>
     			    			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeFee" retmsg="retMsgFee" outnum="1"> 
                      <wtc:param value="<%=inParams[0]%>"/>
                      <wtc:param value="<%=inParams[1]%>"/> 
                    </wtc:service>  
                    <wtc:array id="retFee"  scope="end"/>
     			    			
     			    			<%
     			    			String checkFlag="";
     			    			ArrayList feeValues = new ArrayList();
     			    			System.out.println(" ====gaopengSeelog===f046.jsp=====  tmp="+tmp);	
     			    			if("000000".equals(retCodeFee)){
     			    			  if(retFee.length>0){
     			    			    v_isDisabledBtnFlag = "N";
     			    			   
     			    			    out.print("feeOrder.push('<select style=width:100px onchange=changeKDvalues(this.value) onclick=getNowSelectVal(this.value) >");	//ѹ�����JS������
     			    			    for(int ii=0;ii<retFee.length;ii++){
     			    			     System.out.println(" ====gaopengSeelog===f046.jsp===== retFee["+ii+"]="+retFee[ii][0]);	
                          if(tmp.equals(retFee[ii][0])){
                            checkFlag = "selected";
                          }else{
                            checkFlag = "";
                          }
     			    			      out.print("<option value="+retFee[ii][0]+" "+checkFlag+">"+retFee[ii][0]+"</option>");
     			    			    }
     			    			    out.print("</select>');");	
     			    			    
     			    			  }else{
     			    			  %>
     			    			    rdShowMessageDialog("û�л�ȡ����װ�ѣ�������룺<%=retCodeFee%><br>������Ϣ��<%=retMsgFee%>!",0);	
     			    			  <%
     			    			    v_isDisabledBtnFlag = "Y";
     			    			    out.println("feeOrder.push('<select style=width:100px onchange=changeKDvalues(this.value)><option value= ></option></select>');");
     			    			  }
     			    			}else{
     			    			%>
     			    			  rdShowMessageDialog("��ȡ��װ�Ѵ��󣡴�����룺<%=retCodeFee%><br>������Ϣ��<%=retMsgFee%>!",0);	
     			    			<%
     			    			  v_isDisabledBtnFlag = "Y";
     			    			  out.println("feeOrder.push('<select style=width:100px onchange=changeKDvalues(this.value)><option value= ></option></select>');");
     			    			}
                     
     			    		   /*end diling add for ��̬�����ݿ��л�ȡ��װ��@2012/9/19 */	
     			    		 }else {
     			  		    out.println("feeOrder.push('" + tmp + "');");	//ѹ�����JS������
     			  		    System.out.println(" ====diling===== ningtn fq046 ====  22222222222");
     			  		    }
     			   
     			    	  }
     			    	  		if("0".equals(master_serv_type)){	//�����C��ҵ��,��ȡ��ʽΪselStrCdma	,������ı䶨����changeFeeWay����
     			    	 	 %>
     			    	  		feeOrder.push("<select v_type='feeWay' style='width:100px' name='feeWay<%=m%>_<%=n%>' onchange='changeFeeWay()'><%=selStrCdma%></select>");
     			    	   <%
     			    	   		}else{	//����ΪselStr
     			    	   %>
     			    	   		feeOrder.push("<select v_type='feeWay' style='width:100px' name='feeWay<%=m%>_<%=n%>' onchange='changeFeeWay()'><%=selStr%></select>");
     			    	   <%	}
     			    	  		if("9004".equals(uuu.getValue(1))){//ѡ�ŷ�Ĭ�ϲ���ӡ�ڷ�Ʊ�� ��ӡ��ʽ�ı�ʱ,���仯��ֵ�����isPrint������,����ͬ����ӡ��ʽ
     			    	   %>		
		     						feeOrder.push("<select v_type='isPrint' style='width:100px' name='isPrint<%=m%>_<%=n%>' onchange='g(v_type).value=this.options[selectedIndex].value'><br><option value='T'>��ӡ</option><option selected value='F'>����ӡ</option></select>");
		     					<%}else{
		     					%>
		     						feeOrder.push("<select v_type='isPrint' style='width:100px' name='isPrint<%=m%>_<%=n%>' onchange='g(v_type).value=this.options[selectedIndex].value'><br><option selected value='T'>��ӡ</option><option value='F'>����ӡ</option></select>");
		     					<%}
		     					
		     						String feeCodeSeq            = 		uuu.getValue(8).trim();	   //������ϸ���   	
		     						String factorType    		     = 		uuu.getValue(9).trim();    //������������      
		     						String factorCode            = 		uuu.getValue(10).trim();    //�������Ӵ���      
		     						String factorValueBegin      = 		uuu.getValue(11).trim();   //����������ʼֵ    
		     						String factorValueEnd        = 		uuu.getValue(12).trim();   //�������ӽ���ֵ    
		     						String factorDetailCode      = 		uuu.getValue(13).trim();   //����������ϸ����  
		     						String offerId               = 		uuu.getValue(14).trim();   //����Ʒ��ʶ   
		     						  
		     						String feeParams			 =   	feeCodeSeq + "~" + factorType + "~" + factorCode + "~" + factorValueBegin + "~" + factorValueEnd + "~" + factorDetailCode + "~" + offerId;
		     						System.out.println(".........feeParams = "+feeParams);
		     						
		     						offerId_88 = offerId;
		     						
		     					%>
		     					feeOrder.push("<input type='hidden' name='feeParams<%=m%>_<%=n%>' value=<%=feeParams%>><%=uuu.getValue(6)%>");
     			    	 
     			    	  <%
     			      } 
     			    }
     			    out.println(" allFeeArray.push(feeOrder);");
     			    
     			  }%>
     			  
     			 
     	<%
       }   
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@servOrders =  "+servOrders);
				Iterator it = prtFlagSet.iterator(); 
				while(it.hasNext()){
 					String prtFlagTmp =(String) it.next();
					out.println("prtFlagSet.push('" + prtFlagTmp + "');");
				}

		}else{%>
					rdShowMessageDialog("�ͻ�������ϸ��Ϣ��ѯʧ��!",0);	
					feeFlag = "1";
		<%}%>
</script>


<%

//2010-7-2 19:27 wanghfa��� ��ͨ��������������޸� start
		boolean isTT = false;
		String searchSql = "select count(*) from dloginmsg a,dchngroupmsg b where a.GROUP_ID=b.group_id and b.class_code='200' and a.login_no = '" + loginNo + "'";
%>
		<wtc:pubselect name="sPubSelect" outnum="1" retcode="retCode2" retmsg="retMsg2">
			<wtc:sql><%=searchSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result2" scope="end"/>
<%
		if ((!"0".equals(result2[0][0])) && (servPhoneNo.substring(0,3).equals("451") || servPhoneNo.substring(0,3).equals("045") || servPhoneNo.substring(0,3).equals("046"))) {
			isTT = true;
			System.out.println("============wanghfa=============�Ƿ�Ϊ��ͨ������ ��");
		} else {
			isTT = false;
			System.out.println("============wanghfa=============�Ƿ�Ϊ��ͨ������ ��");
		}
//2010-7-2 19:27 wanghfa��� ��ͨ��������������޸� end
	
	/*2016/4/13 11:12:30 gaopeng ��ȡ������ID ����ʵ��ħ�ٺ���ȡ�ն�Ѻ���ܵ�����*/
	
  String[] inParamsss1 = new String[2];
  inParamsss1[0] = 
  "select a.class_value "
  	+" from dservorderdata a, dservordermsg b "
 		+" where a.serv_order_id = b.serv_order_id "
   	+" and b.cust_order_id = :cust_order_id "
   	+" and a.class_code = 40000 "
   	+" and rownum < 2";
  inParamsss1[1] = "cust_order_id="+custOrderId;
  String jdhId="";

%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="3">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>
	</wtc:service>
	<wtc:array id="resultJdh" scope="end" />
<%
	if("000000".equals(retCode1ss) && resultJdh.length > 0){
		jdhId = resultJdh[0][0];
	}
	
	String imei_HMYJ = "";
	 String[] inParamsss_HMYJ = new String[2];
  inParamsss_HMYJ[0] = "select res.imei_no from dbmarketadm.mk_actrecord_info rec, dbmarketadm.mk_actrecordres_info res where rec.order_id=:cust_order_id and rec.SERIAL_NO=ORDER_NO";
  inParamsss_HMYJ[1] = "cust_order_id="+custOrderId;
	System.out.println("-------hejwa-------------inParamsss_HMYJ[0]------------>"+inParamsss_HMYJ[0]);
	System.out.println("-------hejwa-------------inParamsss_HMYJ[1]------------>"+inParamsss_HMYJ[1]);
%>
 
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="3">			
		<wtc:param value="<%=inParamsss_HMYJ[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>
	</wtc:service>
	<wtc:array id="resultHMJY" scope="end" />
<%
	if( resultHMJY.length > 0){
		imei_HMYJ = resultHMJY[0][0];
	}
	
  if("0".equals(feeFlag.trim())){	// ��ѵ�,ֱ�������ɷ�
%>
    <script language="javaScript">
     window.location = "/npage/sq046/fq046_3.jsp?<%=PageListNav.writeRequestUrl(parametersMap)%>&arrayOrder="+"<%=arrayOrders%>"+"&servOrder="+"<%=servOrders%>";
    </script>
  <%  
  }else{
  	String sql = "SELECT create_accept FROM dservordermsg WHERE serv_order_id ='"+servOrder+"'";
  	System.out.println("sOrderItemShowsOrderItemShowsOrderItemShowsOrderItemShowsOrderItemShowsOrderItemShow"+sql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode5" retmsg="retMsg5" outnum="1">
	<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result5" scope="end" />
<%

%>
<!--����sOrderItemShow����,���ؿͻ�����custOrderId�µ����ж�������,���񶩵�,�ͷ��ÿ�Ŀ,�����д���=====END-->	
<script type="text/JavaScript">
		
	  var selStr = "";
	  var selStrCdma = "";
	  var closeFlag = false;	//����ӪҵԱ�Ƿ�����,��ɴ������շѶ���,�ڷǷ��رսɷѽ����,����onbeforeonload��¼��־,�趨��һ����־λ
	  $(function (){
		  if("g629"=="<%=opcodeadd%>"){
	 			$("#totalFee1").val("0.00");
	 			$("#totalFee3").val("0.00");
	 			submit_cfm();
	 		 }  
	  });
 	  window.onload=function(){
 	  	
 	  	
   			
		   	$("#sys_note").val("����Ա<%=loginNo%>�Զ���<%=custOrderId%>����<%=opName%>����");
		  	var prnFlag = "<%=prtFlag%>";
		  	if(prnFlag == "Y"){
		  	}
		  	
		  	if("<%=feeFlag%>"!="0")
		  	{
					g("tbl0").innerHTML='<table  cellSpacing=0  id="listdiv2"><tr><th>�ͻ��������</th><th>�ͻ�����������</th><th>ҵ���������</th><th>����Ʒ</th><th>��������״̬</th><th>����ʱ��</th><th>����Ա��</th></tr></table>';
					g("tbl1").innerHTML='<table   cellSpacing=0 id="servtbl"><tr><th>���񶨵���</th><th>�ͻ����������</th><th>ҵ�����</th><th style=\"display:none\">�û�����</th><th>��������</th><th>�ɷ�״̬</th> </tr></table>';
					g("tbl2").innerHTML="<table   cellSpacing=0 id='feetbl'><tr><th>���񶨵���</th><th>���ÿ�Ŀ</th><th>Ӧ�ս��</th><th style=\"display:none\">�Żݽ��</th><th>ʵ�ս��</th><th>��ȡ��ʽ</th><th>��ӡ</th><th>˵��</th></tr></table>";
					selStr = "<%=selStr%>";
					selStrCdma = "<%=selStrCdma%>";
					addTr046('listdiv2','1',arrayOrder ,7);	//�����������б�
					addTr046('servtbl','1',servOrder ,6);		//�����񶨵��б�
					var radioObj = document.getElementsByName("servOrders"); 
					radioObj[0].checked = true;		//ѡ��һ�����񶨵�,���񶩵�ǰ���radioֻ������ѡ����������
					
					//for(var i =allFeeArray.length-1 ; i>=0; i--){	//ѭ���������б�,һ�����񶩵�һ�������б�,������ʾ
					for(var i =0 ; i<allFeeArray.length; i++){	//ѭ���������б�,һ�����񶩵�һ�������б�,������ʾ
						var tableName = "tbl"+servOrderNoArray[i];	//�����б������: tbl+���񶩵���
						if(i == 0){
							g("tbl2").innerHTML ="<table   cellSpacing=0 id='"+ tableName +"'><tr class='showhand'><th>���񶨵���&nbsp;&nbsp; <span id='span"+servOrderNoArray[i]+"' style='cursor:pointer;color:#ff9900' onclick='showhand(this)'>������ϸ</span></th><th>���ÿ�Ŀ</th><th>Ӧ�ս��</th><th  style=\"display:none\">�Żݽ��</th><th>ʵ�ս��</th><th>��ȡ��ʽ</th><th>��ӡ</th><th>˵��</th></tr></table>";
						}else{
							g("tbl2").innerHTML = g("tbl2").innerHTML + "<table   cellSpacing=0  id='"+ tableName +"'><tr class='showhand'><th>���񶨵���&nbsp;&nbsp; <span id='span"+servOrderNoArray[i]+"' style='cursor:pointer;color:#ff9900' onclick='showhand(this)'>������ϸ</span></th><th>���ÿ�Ŀ</th><th>Ӧ�ս��</th><th style=\"display:none\">�Żݽ��</th><th>ʵ�ս��</th><th>��ȡ��ʽ</th><th>��ӡ</th><th>˵��</th></tr></table>";
						}
						var rowIndex = g(tableName).rows.length;
						addTr046(tableName,"1",allFeeArray[i] ,8);
					}
					g("arrayOrder").value = "<%=arrayOrders%>";
					g("servOrder").value = "<%=servOrders%>";
					document.all.form1.totalFee1.value= totalFee1;
					document.all.form1.totalFee2.value= Number(totalFee2) + Number("<%=totalOpFee%>");
					/*2013/07/04 10:47:45 gaopeng ǰ̨У԰Ӫ��Ԥ����������Ԥ���Ϊ0*/
					if("<%=opcodeadd%>" == "g785"){
						document.all.form1.totalFee3.value= "0.00";
					}
					else
					{
						document.all.form1.totalFee3.value= totalFee3;
					}
				

					//2010-7-2 19:27 wanghfa��� ��ͨ��������������޸� start
<%
					if (isTT == true) {
%>
						document.all.form1.totalFee1.value= "0";
						document.all.form1.totalFee2.value= "0";
						document.all.form1.totalFee3.value= "0";
<%
					}
%>
					//2010-7-2 19:27 wanghfa��� ��ͨ��������������޸� end

		  	}
			//2010-7-2 19:27 wanghfa��� ��ͨ��������������޸� start
<%
			if (isTT == true) {
%>
			submit_cfm();
<%
			}
%>
			//2010-7-2 19:27 wanghfa��� ��ͨ��������������޸� end
			
			var a = 0;
			var realPayFeeObj;
			while(true) {
				realPayFeeObjs = document.getElementsByName("realPayFee" + a + "_4");
				if (realPayFeeObjs.length > 0) {
					if (realPayFeeObjs[0].v_feeCode == "9001") {
						realPayFeeObjs[0].value = "0";
					}
					
					var inputObj = realPayFeeObjs[0]; 
					
					var feeValue = inputObj.value;
					var trObj = inputObj.parentNode.parentNode;
					var objs = trObj.childNodes;
					var inputObjOld =  objs[4].childNodes[1];	//ʵ���ı�����һ��������,����ǰʵ�ո���,���ڷǷ������Ļָ�
					if(!validateElement(inputObj)){
						inputObj.value = inputObjOld.value;
						return false;	
					}
					var opFee = objs[4].childNodes[2];// ʵ���ı����ڶ���������,�浱ǰӪҵ�Żݶ�
					var ningtnVal = "";
					if($(objs[2]).find("select").length > 0){
						ningtnVal = $(objs[2]).find("select").val();
					}else{
						ningtnVal = objs[2].innerHTML;
					}
					var opValueTmp = Number(ningtnVal)-Number(objs[3].innerHTML)-Number(inputObj.value) ;//ʵ�ոı��,�µ�ӪҵԱ�Ż� = Ӧ��-����-��ʵ��
	
					/* ��ͨ�������û�������������õ����Ԥ��� */
					if("<%=opcodeadd%>" == "4977"){
						var valueTemp = Number(inputObj.value) - Number(ningtnVal);
						if(valueTemp < 0){
							inputObj.value = inputObjOld.value;
							rdShowMessageDialog("ʵ�ս���С����Ӧ���ս��!",0);	
							return false;
						}
					}
					g("totalFee2").value = Number(g("totalFee2").value) + opValueTmp - Number(opFee.value);//���Ż�+���Ż�-���Ż�(���Ų���)
					opFee.value = opValueTmp;	//����ҲҪ����,���ӳ���Ҫ��үү��	--������Χ�۵�
					
				  g("totalFee3").value = Number(g("totalFee3").value) + Number(feeValue) - Number(inputObjOld.value);	//��ʵ�� ,ȥ�ɼ���
				  inputObjOld.value = feeValue;	//����ҲҪ����,���ӳ���Ҫ��үү��
			 	  //alert(objs[4].childNodes[2].value);
				} else {
					break;
				}
				a ++;
			}
			
			//alert($("#servtbl").html()+"\nȡ��һ����ѡ�� ="+$("#servtbl").find("input[type='radio']:first").html());
			$("#servtbl").find("input[type='radio']:first").click();
   			 
   		//Ӫ����ҵ���ӡ����ӡ�û�
   		
   		var ijFlag        = 0;// ��¼����λ��
			for(var i=0;i<opCodeOrderJs.length;i++){
				if(opCodeOrderJs[i]=="g794"){
					opCodeBillPrt = opCodeOrderJs[i];
					ijFlag        = i;
					break;
				}
			}
			var servOrderNoJsPt = "";
			if(servOrderNoArray.length >ijFlag){
				servOrderNoJsPt = servOrderNoArray[ijFlag];
			}
			//�����û�ʵ����
			$("#servtbl tr").each(function(){
				$(this).find("td:eq(3)").attr("style","display:none");
			});
			//alert("servOrderNoJsPt|"+servOrderNoJsPt);
			//�����ӡ ����ӡ������
			
			$("#tbl"+servOrderNoJsPt+" tr:gt(0)").each(function(){
				var servOrderNoIn = $(this).find("td:eq(0)").text().trim();
				//alert("servOrderNoJsPt|"+servOrderNoJsPt+"\nservOrderNoIn|"+servOrderNoIn);
				if(servOrderNoIn==servOrderNoJsPt){//Ӫ���ķ��񶨵�
					var selObj = $(this).find("td:eq(6)").find("select");
							selObj.val("T");
							selObj.attr("disabled","disabled");
				}
			});
		}
		  
			   /*
		        * ��ʾ�����ط����б�
		       */ 
			  function showhand(srcObj){
					var s = srcObj.innerHTML;
					var tblObj = srcObj.parentNode.parentNode.parentNode;
					var trObjs = tblObj.childNodes;
				if(s.indexOf("������ϸ") >= 0){
					for(i=1;i<trObjs.length;i++)
					{
						trObjs[i].style.display="none";
					}
					srcObj.innerHTML="��ʾ��ϸ";
				}else if (s.indexOf("��ʾ��ϸ") >= 0) {
					for(i=1;i<trObjs.length;i++)
					{
						 trObjs[i].style.display="";
					}
					srcObj.innerHTML="������ϸ";
				}
			}

			/*
	        * ������ÿ�Ŀǰ���radio,�ͻ���ʾ������б�
	       	*/
			function showMyFee(bt,servOrderNo){
				
				var j_ei_type = $(bt).attr("v_ei_type");
				var j_instNum = $(bt).attr("v_instNum");
				if(typeof(j_ei_type)!="undefined") j_ei_type.trim();
				if(typeof(j_instNum)!="undefined") j_instNum.trim();
				if(j_ei_type=="EI"){//��������POS���ڸ���
					//���÷�֧Ʊ����ѡ��
					document.all.icbc.checked=true;
					document.all.NocheckRadio.checked=false;
					
					//NocheckWay();
					document.all.payType.value="EI";
					$("input[v_disab_attr='1']").attr("disabled","disabled");
					$("#icbcInstNum").val(j_instNum);
					$("#icbcInsDiv").show();
				}else{
					$("input[v_disab_attr='1']").removeAttr("disabled");
					$("#icbcInstNum").val("");
					$("#icbcInsDiv").hide();
				}
				
				var obj = g("span"+servOrderNo);
				obj.innerHTML="��ʾ��ϸ";
				showhand(obj);	
			}
		  
		   /*
	        * ��ǰ��ajax��ʽ���÷��ò�ѯ,����������ѵ����߽ɷ�ҳ�������,�������ַ�ʽ��
	       	*/
		 /* function initData(){
		  		var myPacket = new AJAXPacket("fq046_ajax.jsp","���ڻ�÷�����Ϣ�����Ժ�......");
		  		myPacket.data.add("retType","showAll");
		  		myPacket.data.add("custOrderId","<%=custOrderId%>");
		  		myPacket.data.add("opCode","<%=opCode%>");
		  		core.ajax.sendPacket(myPacket);
			    myPacket=null;
		  }*/
		  
		   /*
	        * �ı���ȡ��ʽ,�����ϵͳ����Ԥ��(4)��ʽʱ,����ӡ��ʽ��Ϊ����ӡ,������ӡ����Ʊ
	       	*/
		  function changeFeeWay(){
		  	var srcObj = event.srcElement;
		  	g(srcObj.v_type).value=srcObj.options[srcObj.selectedIndex].value;	
		  	var trobj = srcObj.parentNode.parentNode;
		  	var tdobjs = trobj.childNodes;
		  	// alert(srcObj.options[srcObj.selectedIndex].value);
		  	if(srcObj.options[srcObj.selectedIndex].value == "4"){
		  		tdobjs[6].childNodes[0].value='F'	;
		  		g(tdobjs[6].childNodes[0].v_type).value = tdobjs[6].childNodes[0].value;	
		  	}else{
		  		tdobjs[6].childNodes[0].value='T'	;	
		  		g(tdobjs[6].childNodes[0].v_type).value=tdobjs[6].childNodes[0].value;
		  	}
		  }
		  
       /*
        *��̬ɾ����
       */ 
     function delTr046(serverOrderNo,tableName){
          var obj = document.getElementById(tableName);
     	    var trObjs = obj.childNodes[0].childNodes;
     	    for ( var i =1; i < trObjs.length; i++)	{
     	    			 var tdObjs = trObjs[i].childNodes;
     	    	     var inputObj = tdObjs[0].childNodes[0];
     	    	     if(inputObj.v_parent == serverOrderNo){
     	    	       if(tableName == "servtbl"){delTr046(inputObj.value,"feetbl");}
     	    	       if(tableName == "feetbl"){
     	    	       		document.all.form1.totalFee1.value= Number(document.all.form1.totalFee1.value)-Number(tdObjs[1].innerHTML);
      								document.all.form1.totalFee2.value= Number(document.all.form1.totalFee2.value)-Number(tdObjs[2].innerHTML)-Number(tdObjs[4].childNodes[0].value);
      								document.all.form1.totalFee3.value= Number(document.all.form1.totalFee3.value)-Number(tdObjs[3].childNodes[0].value);
      								document.all.form1.fee_submit.disabled=true;
     	    	       }
	                 trObjs[i].parentNode.removeChild(trObjs[i]);
	 		      			 i--;    
                 }  
     	    }         
     }
     
       /*
        *ʵ�ս��,����niuycҪ��,ȡ��ӪҵԱ�Ż�,�ſ��ı�ʵ�ս���Ȩ��,Ӫ��=Ӧ��-����-ʵ�� ,���������ֶ�
       */ 	
       var beforeChangeFee = "";
	/*��ȡ��װ�������б�ı�ǰ�Ľ��*/
	function getNowSelectVal(tmp){
		beforeChangeFee = tmp;
	}   
			function changeRealPayFee(){
				
				var inputObj = event.srcElement; 
				
				var feeValue = inputObj.value;
				var trObj = inputObj.parentNode.parentNode;
				var objs = trObj.childNodes;
				var inputObjOld =  objs[4].childNodes[1];	//ʵ���ı�����һ��������,����ǰʵ�ո���,���ڷǷ������Ļָ�
				
				if(!validateElement(inputObj)){
					inputObj.value = inputObjOld.value;
					return false;	
				}
				var opFee = objs[4].childNodes[2];// ʵ���ı����ڶ���������,�浱ǰӪҵ�Żݶ�
					var ningtnVal = "";
					if($(objs[2]).find("select").length > 0){
						ningtnVal = $(objs[2]).find("select").val();
					}else{
						ningtnVal = objs[2].innerHTML;
					}
					
				var opValueTmp = Number(ningtnVal)-Number(objs[3].innerHTML)-Number(inputObj.value) ;//ʵ�ոı��,�µ�ӪҵԱ�Ż� = Ӧ��-����-��ʵ��
				/*if(opValueTmp < 0){	����ɽ��Ҫ��,ȥ���������
					inputObj.value = inputObjOld.value;
					rdShowMessageDialog("ʵ�ս��ܴ���Ӧ���ս��!",0);	
				}else{*/
				/* ��ͨ�������û�������������õ����Ԥ��� */
				if("<%=opcodeadd%>" == "4977"){
					var valueTemp = Number(inputObj.value) - Number(ningtnVal);
					if(valueTemp < 0){
						inputObj.value = inputObjOld.value;
						rdShowMessageDialog("ʵ�ս���С��Ӧ�ս��!",0);	
						return false;
					}
				}
					/*һ��ʼ���ܶ� ��totalFee1*/
					
					/*֮ǰӦ���ܶ��Ǯ*/
					var asdsasdas = g("totalFee1").value; 
					//opFee.v_oldvalue = opFee.value;
					g("totalFee1").value = Number(ningtnVal) - Number(beforeChangeFee) + Number(asdsasdas);
					
					g("totalFee2").value = Number(g("totalFee2").value) + opValueTmp - Number(opFee.value);//���Ż�+���Ż�-���Ż�(���Ų���)
					opFee.value = opValueTmp;	//����ҲҪ����,���ӳ���Ҫ��үү��	--������Χ�۵�
					
				  g("totalFee3").value = Number(g("totalFee3").value) + Number(feeValue) - Number(inputObjOld.value);	//��ʵ�� ,ȥ�ɼ���
				  inputObjOld.value = feeValue;	//����ҲҪ����,���ӳ���Ҫ��үү��
			 	  //alert(objs[4].childNodes[2].value);
			}
	
			/*
	        *��������,��ȡԪ��
	       */ 	
			function g(objectId) 
			{
				if (document.getElementById && document.getElementById(objectId))
				{
					return document.getElementById(objectId);
				}
				else if (document.all && document.all[objectId])
				{
					return document.all[objectId];
				}
				else 
				{
					return false;
				}
			}
	
	
			 /*
	        *��̬�����
	       */ 					
			function addTr046(tableID,trIndex,arrTdCont,colNum)
			{
				if(colNum == "undefined")
					colNum = 1;
				var tableId=g(tableID);
				var insertTr=new Array();
				for(var i = 0 ; i < (arrTdCont.length/colNum); i++){
						var k =1+i*colNum;
						//alert(tableID.indexOf("tbl") + "::" +  arrTdCont[k].indexOf("value=2"));
						if(tableID.indexOf("tbl") == 0 && (arrTdCont[k].indexOf("value=22") != -1 || arrTdCont[k].indexOf("value=2") != -1 || arrTdCont[k].indexOf("value=200") != -1 || arrTdCont[k].indexOf("value=20") != -1 || arrTdCont[k].indexOf("value=21") != -1)){
							insertTr[i] = tableId.insertRow(1);		
						}else{
							insertTr[i] = tableId.insertRow(trIndex);			
						}
						
						var arrTd=new Array();				
						for(var j = 0;j < colNum;j++)
						{
							
							arrTd[j]=insertTr[i].insertCell(j);
							if(tableID.substring(0,3)=="tbl"&&j==1){
								arrTdCont[i*colNum+j] = arrTdCont[i*colNum+j].replace("type='text'","type='text' readOnly class='InputGrey'");
							}
							arrTd[j].innerHTML = arrTdCont[i*colNum+j];
							if(tableID.substring(0,3)=="tbl"&&j==3){
								arrTd[j].style.display="none";
							}
							
						}
						trIndex  = Number(trIndex)+1;
					}
			}
 
	  	 /*
        *�ص�����
       */ 
     	function doProcess(packet)
     	{
	     		/*tianyang add for pos�ɷ� start*/
					var verifyType = packet.data.findValueByName("verifyType");
					var sysDate = packet.data.findValueByName("sysDate");
					if(verifyType=="getSysDate"){
						document.all.Request_time.value = sysDate;
						return false;
					}
					/*tianyang add for pos�ɷ� end*/
     	}
     
       /*
        *ͬ���ɷѷ�ʽ���Ƿ��ӡ
       */ 
	     function changeAll(vType){
	          var selValue = g(vType).value;
	          var obj = document.form1.elements;
	          for(var i = 0 ; i< obj.length; i ++){
	               if(obj[i].v_type == vType){
	                    var objs = obj[i].childNodes;
	               	 for(var j = 0 ; j < objs.length ; j ++ ){
	               	     if(objs[j].value == selValue){
	               	          objs[j].selected = true;    
	               	     }
	               	 }
	               }
	          }
	     }
	     
	     var custId = "";
function formatNumber(feeValue){
	
	feeValue = feeValue+"";
	if(feeValue.indexOf("\.")!=-1){
		feeValue = feeValue+"00";
	}else{
		feeValue = feeValue+".00";
	}
	return feeValue.substring(0,feeValue.indexOf("\.")+3);
	
}  

//Ӫ������������ӡ��Ʊ hejwa add 2013��5��30��15:24:37
//��Ʊ�ϴ�
function showMarkBillPrt_H(billArr,opCodeBillPrt,iFlag){
	//--------------��ʼƴװ��Ʊ---------------------------
	
	var custName       = billArr[2];
	var phoneNo        = billArr[3];
	var busiName       = billArr[1];
	var totalFee          = billArr[6];
	var totalFeeC        = billArr[5];
	var prtLoginAccept = sysAcceptOrderJs[iFlag];
	var printInfo           = "";
	var feeName           = "�ϼƽ��";
	var actionId = billArr[14];  
	var shuilv = billArr[15];
	var shuier = billArr[16];
	var jsje     =  billArr[17];   //��˰���
 	 var  billArgsObj = new Object();
	$(billArgsObj).attr("10001","<%=loginNo%>");     //����
	$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10005",custName);   //�ͻ�����
	$(billArgsObj).attr("10006",busiName);    //ҵ�����
	$(billArgsObj).attr("10008",phoneNo);    //�û�����
	$(billArgsObj).attr("10015", totalFee);   //���η�Ʊ���
	$(billArgsObj).attr("10016", totalFee);   //��д���ϼ�
	$(billArgsObj).attr("10025", totalFee);   //��д���ϼ�
	
	var sumtypes1="*";
	var sumtypes2="";
	var sumtypes3="";
	$(billArgsObj).attr("10017",sumtypes1);        //���νɷѣ��ֽ�
	$(billArgsObj).attr("10018",sumtypes2);        //֧Ʊ
	$(billArgsObj).attr("10019",sumtypes3);        //ˢ��
    $(billArgsObj).attr("10028",busiName);   //�����Ӫ������ƣ�
	$(billArgsObj).attr("10029",actionId);	 //Ӫ������	
	
	$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ

	$(billArgsObj).attr("10036","<%=opcodeadd%>");   //��������
	if(billArr[10]!=""){//���ն�
			$(billArgsObj).attr("10041", billArr[9]);           //Ʒ�����
			$(billArgsObj).attr("10042","̨");                   //��λ
			$(billArgsObj).attr("10043","1");	                   //����
			$(billArgsObj).attr("10044","0.0");	                //����
			$(billArgsObj).attr("10045",billArr[11]);	       //IMEI
			$(billArgsObj).attr("10061",billArr[10]);	       //�ͺ�
			$(billArgsObj).attr("10071","6");	//��ӡģ��
			$(billArgsObj).attr("10062",shuilv);	//˰��
			$(billArgsObj).attr("10063",shuier);	//˰��	 
			$(billArgsObj).attr("10076",jsje);	
			$(billArgsObj).attr("10081","5");
			$(billArgsObj).attr("11214","HID_PR");	 //�����վݰ�ť== ��ӡ���ӷ�Ʊ  ��ӡֽ�ʷ�Ʊ
    }else{
	    	$(billArgsObj).attr("10062",shuilv);	//˰��
		    $(billArgsObj).attr("10063",shuier);	//˰��	 
			$(billArgsObj).attr("10071","4");	//��ӡģ��
    }  
 
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
//		var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;

		//��Ʊ��Ŀ�޸�Ϊ��·��
		var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;


		var loginAccept = prtLoginAccept;
		var path = path + "&loginAccept="+loginAccept+"&opCode="+opCodeBillPrt+"&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop);
}

//��Ʊ�ִ�2
function showMarkBillPrt_F2(billArr,opCodeBillPrt,iFlag){

//--------------��ʼƴװ��Ʊ---------------------------
	
		var custName       = billArr[2];
		var phoneNo        = billArr[3];
		var busiName       = billArr[1];
		var totalFeeC      = billArr[5];
		var totalFee       = billArr[6];
		var prtLoginAccept = sysAcceptOrderJs[iFlag];
		var printInfo      = "";
		var feeName        = "������";
		var actionId = billArr[14];  
		var shuilv = billArr[15];
	    var shuier = billArr[16];
	    var jsje     =  billArr[17];   //��˰���
	    var  billArgsObj = new Object();
	    if(totalFee>0.01){
			$(billArgsObj).attr("10001","<%=loginNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005",custName);   //�ͻ�����
			$(billArgsObj).attr("10006",busiName);    //ҵ�����
			$(billArgsObj).attr("10008",phoneNo);    //�û�����
			$(billArgsObj).attr("10015", totalFee);   //���η�Ʊ���
			$(billArgsObj).attr("10016", totalFee);   //��д���ϼ�
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
		    $(billArgsObj).attr("10028",busiName);   //�����Ӫ������ƣ�
			$(billArgsObj).attr("10029",actionId);	 //Ӫ������	
			$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
			
			$(billArgsObj).attr("10036","<%=opcodeadd%>");   //��������
			$(billArgsObj).attr("10041", billArr[9]);           //Ʒ�����
			$(billArgsObj).attr("10042","̨");                   //��λ
			$(billArgsObj).attr("10043","1");	                   //����
			$(billArgsObj).attr("10044",billArr[6]);	                //����
			$(billArgsObj).attr("10045",billArr[11]);	       //IMEI
			$(billArgsObj).attr("10061",billArr[10]);	       //�ͺ�
			$(billArgsObj).attr("10062",shuilv);	//˰��
			$(billArgsObj).attr("10063",shuier);	//˰��	   
	        $(billArgsObj).attr("10071","6");	//˰��	
	 		$(billArgsObj).attr("10076",jsje);
	 		$(billArgsObj).attr("10081","5");
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;
			
			//��Ʊ��Ŀ�޸�Ϊ��·��
			$(billArgsObj).attr("11214","HID_PR");	 //�����վݰ�ť== ��ӡ���ӷ�Ʊ  ��ӡֽ�ʷ�Ʊ
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;
			
			
			var loginAccept = prtLoginAccept;
			var path = path +"&loginAccept="+loginAccept+"&opCode="+opCodeBillPrt+"&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
		}
}
//��Ʊ�ִ�2
function showMarkBillPrt_F4(billArr,opCodeBillPrt,iFlag){
//--------------��ʼƴװ��Ʊ---------------------------
		var custName       = billArr[2];
		var phoneNo        = billArr[3];
		var busiName       = billArr[1];
		var totalFeeC      = billArr[5];
		var totalFee       = billArr[5];
		var prtLoginAccept = sysAcceptOrderJs[iFlag];
		var printInfo      = "";
		var feeName        = "������";
		var actionId = billArr[14];  
		var shuilv = billArr[15];
	    var shuier = billArr[16];
	    var jsje     =  billArr[17];   //��˰���
	    var  billArgsObj = new Object();
	    if(totalFee>0.01){
			$(billArgsObj).attr("10001","<%=loginNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005",custName);   //�ͻ�����
			$(billArgsObj).attr("10006",busiName);    //ҵ�����
			$(billArgsObj).attr("10008",phoneNo);    //�û�����
			$(billArgsObj).attr("10015", totalFee);   //���η�Ʊ���
			$(billArgsObj).attr("10016", totalFee);   //��д���ϼ�
			$(billArgsObj).attr("10025",totalFee);   //���ӷ�Ʊ��ϸ���ݲ���Ϊ�� model13 ֻȡ10025 �ֶ� �������ܶ����
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
		    $(billArgsObj).attr("10028",busiName);   //�����Ӫ������ƣ�
			$(billArgsObj).attr("10029",actionId);	 //Ӫ������	
			$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
			$(billArgsObj).attr("10036","<%=opcodeadd%>");   //��������
			$(billArgsObj).attr("10041", billArr[9]);           //Ʒ�����
			$(billArgsObj).attr("10042","̨");                   //��λ
			$(billArgsObj).attr("10043","1");	                   //����
			$(billArgsObj).attr("10044",billArr[6]);	                //����
			$(billArgsObj).attr("10045",billArr[11]);	       //IMEI
			$(billArgsObj).attr("10061",billArr[10]);	       //�ͺ�
			$(billArgsObj).attr("10038",billArr[18]);
			$(billArgsObj).attr("10039",billArr[19]);
			$(billArgsObj).attr("10040",billArr[20]);
			$(billArgsObj).attr("10037",billArr[21]);
			//$(billArgsObj).attr("10062",shuilv);	//˰��
			//$(billArgsObj).attr("10063",shuier);	//˰��	   
	    $(billArgsObj).attr("10071","6");	//˰��	
	 		$(billArgsObj).attr("10076",totalFee);
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;
			
			$(billArgsObj).attr("11214","HID_PR");	 //�����վݰ�ť== ��ӡ���ӷ�Ʊ  ��ӡֽ�ʷ�Ʊ
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;

			
			var loginAccept = prtLoginAccept;
			var path = path +"&loginAccept="+loginAccept+"&opCode="+opCodeBillPrt+"&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
		}
}
//��Ʊ�ִ�2
function showMarkBillPrt_F6(billArr,opCodeBillPrt,iFlag){
//--------------��ʼƴװ��Ʊ---------------------------
		var custName       = billArr[2];
		var phoneNo        = billArr[3];
		var busiName       = billArr[1];
		var totalFeeC      = billArr[5];
		var totalFee       = billArr[6];
		var prtLoginAccept = sysAcceptOrderJs[iFlag];
		var printInfo      = "";
		var feeName        = "������";
		var actionId = billArr[14];  
		var shuilv = billArr[15];
	    var shuier = billArr[16];
	    var jsje     =  billArr[17];   //��˰���
	    var  billArgsObj = new Object();
	   
			$(billArgsObj).attr("10001","<%=loginNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005",custName);   //�ͻ�����
			$(billArgsObj).attr("10006",busiName);    //ҵ�����
			$(billArgsObj).attr("10008",phoneNo);    //�û�����
			$(billArgsObj).attr("10015", totalFee);   //���η�Ʊ���
			$(billArgsObj).attr("10016", totalFee);   //��д���ϼ�
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
		  $(billArgsObj).attr("10028",busiName);   //�����Ӫ������ƣ�
			$(billArgsObj).attr("10029",actionId);	 //Ӫ������	
			$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
			$(billArgsObj).attr("10036","<%=opcodeadd%>");   //��������
			$(billArgsObj).attr("10041", billArr[9]);           //Ʒ�����
			$(billArgsObj).attr("10042","̨");                   //��λ
			$(billArgsObj).attr("10043","1");	                   //����
			$(billArgsObj).attr("10044",billArr[6]);	                //����
			$(billArgsObj).attr("10045",billArr[11]);	       //IMEI
			$(billArgsObj).attr("10061",billArr[10]);	       //�ͺ�
			$(billArgsObj).attr("10062",shuilv);	//˰��
			$(billArgsObj).attr("10063",shuier);	//˰��	   
	        $(billArgsObj).attr("10071","6");	//˰��	
	 		$(billArgsObj).attr("10076",jsje);
	 		$(billArgsObj).attr("10081","5");
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;

			//��Ʊ��Ŀ�޸�Ϊ��·��
			$(billArgsObj).attr("11214","HID_PR");	 //�����վݰ�ť== ��ӡ���ӷ�Ʊ  ��ӡֽ�ʷ�Ʊ
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;

			
			var loginAccept = prtLoginAccept;
			var path = path +"&loginAccept="+loginAccept+"&opCode="+opCodeBillPrt+"&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
		
}
//��Ʊ�ִ�1
function showMarkBillPrt_F7(billArr,opCodeBillPrt,iFlag){
//--------------��ʼƴװ��Ʊ---------------------------
	var custName       = billArr[2];
	var phoneNo        = billArr[3];
	var busiName       = billArr[1];
	var actionId = 	billArr[14]; 
	var totalFee       = billArr[7];
	var totalFeeC      = billArr[7];
	var prtLoginAccept = sysAcceptOrderJs[iFlag];
	var printInfo      = "";
	var feeName        = "ר��";
 	if(totalFee>0.01){
		var  billArgsObj = new Object();
		$(billArgsObj).attr("10001","<%=loginNo%>");     //����
		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10005",custName);   //�ͻ�����
		$(billArgsObj).attr("10006",busiName);    //ҵ�����
		$(billArgsObj).attr("10008",phoneNo);    //�û�����
		$(billArgsObj).attr("10015", totalFee);   //���η�Ʊ���
		$(billArgsObj).attr("10016", totalFee);   //��д���ϼ�
		$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
		$(billArgsObj).attr("10025",totalFee); //Ԥ�滰��
		$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
		$(billArgsObj).attr("10036","<%=opcodeadd%>");   //��������
		$(billArgsObj).attr("10048",totalFee);	//ͨ�ŷ���Ѻϼ�
    $(billArgsObj).attr("10071","4");	//��ӡģ��
    $(billArgsObj).attr("10028",busiName);   //�����Ӫ������ƣ�
		$(billArgsObj).attr("10029",actionId);	 //Ӫ������	
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;
			
			//��Ʊ��Ŀ�޸�Ϊ��·��
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;

			
			var loginAccept = prtLoginAccept;
			var path = path +"&loginAccept="+loginAccept+"&opCode="+opCodeBillPrt+"&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
	}
}
//��Ʊ�ִ�1
function showMarkBillPrt_F1(billArr,opCodeBillPrt,iFlag){

//--------------��ʼƴװ��Ʊ---------------------------
	
	var custName       = billArr[2];
	var phoneNo        = billArr[3];
	var busiName       = billArr[1];
	var actionId = 	billArr[14]; 
	var totalFee       = billArr[8];
	var totalFeeC      = billArr[7];
	var prtLoginAccept = sysAcceptOrderJs[iFlag];
	var printInfo      = "";
	var feeName        = "ר��";
 	if(totalFee>0.01){
		var  billArgsObj = new Object();
		$(billArgsObj).attr("10001","<%=loginNo%>");     //����
		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10005",custName);   //�ͻ�����
		$(billArgsObj).attr("10006",busiName);    //ҵ�����
		$(billArgsObj).attr("10008",phoneNo);    //�û�����
		$(billArgsObj).attr("10015", totalFee);   //���η�Ʊ���
		$(billArgsObj).attr("10016", totalFee);   //��д���ϼ�
		$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
		$(billArgsObj).attr("10025",totalFee); //Ԥ�滰��
		$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
		$(billArgsObj).attr("10036","<%=opcodeadd%>");   //��������
		$(billArgsObj).attr("10048",totalFee);	//ͨ�ŷ���Ѻϼ�
    $(billArgsObj).attr("10071","4");	//��ӡģ��
    $(billArgsObj).attr("10028",busiName);   //�����Ӫ������ƣ�
		$(billArgsObj).attr("10029",actionId);	 //Ӫ������	
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;
			
			//��Ʊ��Ŀ�޸�Ϊ��·��
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;
			
			var loginAccept = prtLoginAccept;
			var path = path +"&loginAccept="+loginAccept+"&opCode="+opCodeBillPrt+"&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
	}
}

//����ͳ����Ʊֻ�򹺻�����ȷ��
function showMarkBillPrt_JTTFGJ(billArr,opCodeBillPrt,iFlag){
//--------------��ʼƴװ��Ʊ---------------------------
		var custName       = billArr[2];
		var phoneNo        = billArr[3];
		var busiName       = billArr[1];
		var totalFeeC      = billArr[5];
		var totalFee       = billArr[6];
		var prtLoginAccept = sysAcceptOrderJs[iFlag];
		var printInfo      = "";
		var feeName        = "������";
		var actionId = billArr[14];  
		var shuilv = billArr[15];
	    var shuier = billArr[16];
	    var jsje     =  billArr[17];   //��˰���
	    var  billArgsObj = new Object();
	   
			$(billArgsObj).attr("10001","<%=loginNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005",custName);   //�ͻ�����
			$(billArgsObj).attr("10006",busiName);    //ҵ�����
			$(billArgsObj).attr("10008",phoneNo);    //�û�����
			$(billArgsObj).attr("10015", totalFee);   //���η�Ʊ���
			$(billArgsObj).attr("10016", totalFee);   //��д���ϼ�
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
		    $(billArgsObj).attr("10028",busiName);   //�����Ӫ������ƣ�
			$(billArgsObj).attr("10029",actionId);	 //Ӫ������	
			$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
			$(billArgsObj).attr("10036","<%=opcodeadd%>");   //��������
			$(billArgsObj).attr("10041", billArr[9]);           //Ʒ�����
			$(billArgsObj).attr("10042","̨");                   //��λ
			$(billArgsObj).attr("10043","1");	                   //����
			$(billArgsObj).attr("10044",billArr[6]);	                //����
			$(billArgsObj).attr("10045",billArr[11]);	       //IMEI
			$(billArgsObj).attr("10061",billArr[10]);	       //�ͺ�
			$(billArgsObj).attr("10062",shuilv);	//˰��
			$(billArgsObj).attr("10063",shuier);	//˰��	   
	        $(billArgsObj).attr("10071","6");	//˰��	
	 		$(billArgsObj).attr("10076",jsje);
	 		$(billArgsObj).attr("10081","5");
	 		$(billArgsObj).attr("10082",prtLoginAccept);
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ_JTTF.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;
			
			//��Ʊ��Ŀ�޸�Ϊ��·��
			$(billArgsObj).attr("11214","HID_PR");	 //�����վݰ�ť== ��ӡ���ӷ�Ʊ  ��ӡֽ�ʷ�Ʊ
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=ȷʵҪ���з�Ʊ��ӡ��";

			
			var loginAccept = prtLoginAccept;
			var path = path +"&loginAccept="+loginAccept+"&opCode="+opCodeBillPrt+"&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
		
}

//g784��ӡ��Ʊ���� ���ڱ����г���Ӫ��2013��8�µڶ���ҵ��֧��ϵͳ����ĺ�-�����ն�ҵ��ȡ�����ܵ�����
//����תΪ�ַ������������ajax���ζ�ʧ
function toParam(jsArr){
	var retStr = "";
	for(var i=0; i<jsArr.length;i++){
		if(i<jsArr.length-1){
			retStr += jsArr[i]+"��";
		}else{
			retStr += jsArr[i];
		}
	}
	return retStr;
}
function goto_G798BillPrint(iFlag){
	
		
		var custName       = "";
  	var phoneNo        = "";
  	var busiName       = "Ӫ���˻�";
		var prtLoginAccept = prtFlagSet[0].split("~")[1];  	
  	$("#servtbl :radio").each(function(i){
   			if(this.checked){
   				custName = $(this).parent().parent().find("td:eq(3)").text();
   				phoneNo  = $(this).parent().parent().find("td:eq(2)").text();
   			}
 		});
  	
  	for(var i=0;i<g798BillTypeArr.length;i++){
  		
  			var totalFee       = g798ActualFeeLoweArr[i];
	  		var totalFeeC      = g798ActualFeeUppeArr[i];
	  		if(totalFee>0.01){
			var printInfo      = "";
			var feeName        = "�ϼƽ��";
				var  billArgsObj = new Object();
				$(billArgsObj).attr("10001","<%=loginNo%>");     //����
				$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
				$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
				$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
				$(billArgsObj).attr("10005",custName);   //�ͻ�����
				$(billArgsObj).attr("10006",busiName);    //ҵ�����
				$(billArgsObj).attr("10008",phoneNo);    //�û�����
				$(billArgsObj).attr("10015", "-"+totalFee);   //���η�Ʊ���
				$(billArgsObj).attr("10016", "-"+totalFee);   //��д���ϼ�
				$(billArgsObj).attr("10025", "-"+totalFee);   //�����Ӫ������ƣ�
			  $(billArgsObj).attr("10028",g798actionnameArr[i]);   //�����Ӫ������ƣ�
				$(billArgsObj).attr("10029",g798actionidArr[i]);	 //Ӫ������	
				$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
				$(billArgsObj).attr("10036","<%=opcodeadd%>");   //��������
				$(billArgsObj).attr("10041", g798BrandNameArr[i]);           //Ʒ�����
				$(billArgsObj).attr("10042","̨");                   //��λ
				$(billArgsObj).attr("10043","1");	                   //����
				$(billArgsObj).attr("10044",totalFee);	                //����
				$(billArgsObj).attr("10045",g798IMEIArr[i]);	       //IMEI
				$(billArgsObj).attr("10061",g798TypeNameArr[i]);	       //�ͺ�	 
				
				if(g798BillTypeArr[i]==0){  
							$(billArgsObj).attr("10062",g798shuilvArr[i]);	//˰��
			        $(billArgsObj).attr("10063",""+g798shuieArr[i]);	//˰��	  
			        $(billArgsObj).attr("10076",""+g798JSJE[i]);
		    			$(billArgsObj).attr("10071","6");	       //�ͺ�	
		    			$(billArgsObj).attr("10081","5");   
		    			$(billArgsObj).attr("11214","HID_PR");	 //�����վݰ�ť== ��ӡ���ӷ�Ʊ  ��ӡֽ�ʷ�Ʊ
		 		}
	
	
				var param11216 = $("#listdiv2 tr:eq(1)").find("td:eq(5)").text();
				
				if(param11216.length>6){
					param11216 = param11216.substring(0,6);
				}
				
				
				$(billArgsObj).attr("11215","<%=str_g798_accept%>"); //��ҵ����ˮ
				$(billArgsObj).attr("11216",param11216); //ԭҵ������		yyyyMM							 		
				$(billArgsObj).attr("10072","2");	//����
				
		 					
				var h=210;
				var w=400;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
				//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;
				
				//��Ʊ��Ŀ�޸�Ϊ��·��
				var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;

				
				var loginAccept = prtLoginAccept;
				var path = path + "&loginAccept="+loginAccept+"&opCode=g798"+"&submitCfm=submitCfm";
				var ret = window.showModalDialog(path,billArgsObj,prop);
			}
  	}
}


function to_showMarkBillPrt(opCodeBillPrt,iFlag){
		var getdataPacket = new AJAXPacket("ajaxGetSalebillData.jsp","���ڻ�����ݣ����Ժ�......");
		getdataPacket.data.add("custOrderId","<%=custOrderId%>");
		getdataPacket.data.add("billFlag","0");
		getdataPacket.data.add("opCodeBillPrt",opCodeBillPrt);
		getdataPacket.data.add("iFlag",iFlag);
		core.ajax.sendPacket(getdataPacket,doGetSalebillData);
		getdataPacket = null;
}

function doGetSalebillData(packet){
	retCode = packet.data.findValueByName("retCode");
	if(retCode == "000000"||retCode == "0"){
		var getbillArr    = packet.data.findValueByName("getbillArr");
		var opCodeBillPrt = packet.data.findValueByName("opCodeBillPrt");
		var iFlag         = packet.data.findValueByName("iFlag");
		if(getbillArr.length>0){
			var printFlag = getbillArr[4];//��ӡ��ʶ��0�ϴ�1�ִ�3����						
			if(printFlag=="0"){//�ϴ�
				showMarkBillPrt_H(getbillArr,opCodeBillPrt,iFlag);
			}else if(printFlag=="1"){
				
				showMarkBillPrt_F1(getbillArr,opCodeBillPrt,iFlag);
				if(getbillArr[10]!=""){//���ն�
					showMarkBillPrt_F2(getbillArr,opCodeBillPrt,iFlag);
				}
			}else if(printFlag=="4") {
			
						if(confirm("�Ƿ񿪾�ͨ�û���Ԥ�淢Ʊ��"))
			{
		var myPacket = new AJAXPacket("fq046_addBilltype.jsp","�ύ��ӡ��Ʊ����......");
		myPacket.data.add("addtype",'0');
		myPacket.data.add("custOrderId",'<%=custOrderId%>');
		core.ajax.sendPacket(myPacket,doreturnmsgs);
		myPacket = null;		
						showMarkBillPrt_F4(getbillArr,opCodeBillPrt,iFlag);						
			}else {
		var myPacket = new AJAXPacket("fq046_addBilltype.jsp","�ύ��ӡ��Ʊ����......");
		myPacket.data.add("addtype",'1');
		myPacket.data.add("custOrderId",'<%=custOrderId%>');
		core.ajax.sendPacket(myPacket,doreturnmsgs);
		myPacket = null;			
						showMarkBillPrt_F6(getbillArr,opCodeBillPrt,iFlag);
						showMarkBillPrt_F7(getbillArr,opCodeBillPrt,iFlag);
			}	
			
			}else if(printFlag=="5") {
						showMarkBillPrt_F4(getbillArr,opCodeBillPrt,iFlag);	
			}
			
			
			
		}else{
			rdShowMessageDialog("û��ȡ����Ʊ��ӡ����",0);
		}	
	}else{
		rdShowMessageDialog("ȡӪ����Ʊ��Ϣ����");
	}
}

function to_showMarkBillPrtJTTF(opCodeBillPrt,iFlag){
		var getdataPacket = new AJAXPacket("ajaxGetSalebillData.jsp","���ڻ�����ݣ����Ժ�......");
		getdataPacket.data.add("custOrderId","<%=custOrderId%>");
		getdataPacket.data.add("billFlag","0");
		getdataPacket.data.add("opCodeBillPrt",opCodeBillPrt);
		getdataPacket.data.add("iFlag",iFlag);
		core.ajax.sendPacket(getdataPacket,doGetSalebillDataJTTF);
		getdataPacket = null;
}

function doGetSalebillDataJTTF(packet){
	retCode = packet.data.findValueByName("retCode");
	if(retCode == "000000"||retCode == "0"){
		var getbillArr    = packet.data.findValueByName("getbillArr");
		var opCodeBillPrt = packet.data.findValueByName("opCodeBillPrt");
		var iFlag         = packet.data.findValueByName("iFlag");
		if(getbillArr.length>0){
			var printFlag = getbillArr[4];//��ӡ��ʶ��0�ϴ�1�ִ�3����
			
				if(document.all.jtzhtf.checked == true)
        {
        showMarkBillPrt_JTTFGJ(getbillArr,opCodeBillPrt,iFlag);
        
        }else{
			
			if(printFlag=="0"){//�ϴ�
				showMarkBillPrt_H(getbillArr,opCodeBillPrt,iFlag);
			}else if(printFlag=="1"){
				
				showMarkBillPrt_F1(getbillArr,opCodeBillPrt,iFlag);
				if(getbillArr[10]!=""){//���ն�
					showMarkBillPrt_F2(getbillArr,opCodeBillPrt,iFlag);
				}
			}else if(printFlag=="4") {
			
						if(confirm("�Ƿ񿪾�ͨ�û���Ԥ�淢Ʊ��"))
			{
		var myPacket = new AJAXPacket("fq046_addBilltype.jsp","�ύ��ӡ��Ʊ����......");
		myPacket.data.add("addtype",'0');
		myPacket.data.add("custOrderId",'<%=custOrderId%>');
		core.ajax.sendPacket(myPacket,doreturnmsgs);
		myPacket = null;		
						showMarkBillPrt_F4(getbillArr,opCodeBillPrt,iFlag);						
			}else {
		var myPacket = new AJAXPacket("fq046_addBilltype.jsp","�ύ��ӡ��Ʊ����......");
		myPacket.data.add("addtype",'1');
		myPacket.data.add("custOrderId",'<%=custOrderId%>');
		core.ajax.sendPacket(myPacket,doreturnmsgs);
		myPacket = null;			
						showMarkBillPrt_F6(getbillArr,opCodeBillPrt,iFlag);
						showMarkBillPrt_F7(getbillArr,opCodeBillPrt,iFlag);
			}	
			
			}else if(printFlag=="5") {
						showMarkBillPrt_F4(getbillArr,opCodeBillPrt,iFlag);	
			}
			
			}
			
		}else{
			rdShowMessageDialog("û��ȡ����Ʊ��ӡ����",0);
		}	
	}else{
		rdShowMessageDialog("ȡӪ����Ʊ��Ϣ����");
	}
}

	function doreturnmsgs(packet){
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
		if(retcode=="000000" || retcode=="0"){
			//rdShowMessageDialog("¼���ӡ��Ʊ���ͳɹ���",2);
		}else {
			rdShowMessageDialog("¼���ӡ��Ʊ����ʧ�ܣ��������"+retcode+"������ԭ��"+retmsg,0);
		}
	}
	

var chinaFee = "";
function showPrtDlgbill(printType,DlgMessage,submitCfm){
	var printInfo = "";
	var printInfo1 = "";
	var  billArgsObj = new Object();
	for (var m = 0 ; m < prtFlagSet.length; m ++){
	     			var arrayOrderId = prtFlagSet[m].split("~")[0];
	     			var prtLoginAccept = prtFlagSet[m].split("~")[1];
	     			var opType = "";
	     			var custName = "";
	     			var phoneNo = "";
	     			var userId = "<%=gCustId%>"
	     			var checkNo = "";
	     			
 						var machFee = 0;
 						var simFee = 0;
 						var fee_sumPay = 0;
 						var cashPay = "";
 						var posPay = "0.00"; 						
 						if(document.all.payType.value=="BX" || document.all.payType.value=="BY"){
 							posPay = document.all.totalFee3.value; 							
 						}else{
 							cashPay = document.all.totalFee3.value;
 						}
 						var checkPay = document.all.checkPay.value;
 						
  	
  	
    $("#servtbl :radio").each(function(i){
   			if(this.checked){
   				opType   = $(this).parent().parent().find("td:eq(4)").text();
   				custName = $(this).parent().parent().find("td:eq(3)").text();
   				phoneNo  = $(this).parent().parent().find("td:eq(2)").text();
   			}
 		});
 		
  	    var tableName = "tbl"+servOrderNoArray[0];
	     	var tabobj = g(tableName);
	     	  
				for(i=1; i < tabobj.rows.length; i++){
						var feename = tabobj.rows(i).cells(1).children[1].value;
						if(feename == "SIM������"){
							simFee  +=parseInt(tabobj.rows(i).cells(4).children[0].value);
						}else if(feename.indexOf("Ԥ��")!=-1){
							fee_sumPay +=parseInt(tabobj.rows(i).cells(4).children[0].value);
						}else if(feename.indexOf("������")!=-1){
							machFee +=parseInt(tabobj.rows(i).cells(4).children[0].value);
						}
				}

 	   /**
 	   **�ж��Ƿ�Ϊ֧Ʊ�ɷ����Ϊ֧Ʊ�ɷ����֧Ʊ���븳ֵ
 	   **/
	   var val=$('input:radio[name="checkRadio"]:checked').val();
		if(val!=null){
				checkNo = document.all.checkNo.value��
		}
		
 		$(billArgsObj).attr("10001","<%=loginNo%>");       //����
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",custName); //�ͻ�����
 		var ywlb = "��ͨ����";
 		if("<%=opcodeadd%>" == "m275"){
 			ywlb = "У԰ӭ����������";
 		}
 		$(billArgsObj).attr("10006",ywlb); //ҵ�����
 		$(billArgsObj).attr("10008",phoneNo); //�û�����
 		$(billArgsObj).attr("10009",userId); //Э�����
 		$(billArgsObj).attr("10013",checkNo); //֧Ʊ��
 		$(billArgsObj).attr("10014",""); //����ͳ������
 		$(billArgsObj).attr("10015", document.all.totalFee3.value); //���η�Ʊ���(Сд)��
 		$(billArgsObj).attr("10016", document.all.totalFee3.value); //��д���ϼ�
 		var sumtypes1="";
 		var sumtypes2="";
 		var sumtypes3="";
 		
 		if(cashPay!="" && (cashPay!="0" && cashPay!="0.00" && cashPay!=0)) {
 			sumtypes1="*";
 		}
 		
  	   if(checkPay!="" && (checkPay!="0" && checkPay!="0.00" && checkPay!=0)) {
 			sumtypes2="*";
 		}
 		
 		if(posPay!=""  && (posPay!="0" && posPay!="0.00"  && posPay!=0)) {
 			sumtypes3="*";

 		} 				
 		$(billArgsObj).attr("10017",sumtypes1); //���νɷ��ֽ�
 		$(billArgsObj).attr("10018",sumtypes2); //֧Ʊ
 		$(billArgsObj).attr("10019",sumtypes3); //ˢ��
 		$(billArgsObj).attr("10020","0.00"); //������
 		$(billArgsObj).attr("10021","0.00"); //������
 		$(billArgsObj).attr("10022","0.00"); //ѡ�ŷ�
 		$(billArgsObj).attr("10023","0.00"); //Ѻ��
 		$(billArgsObj).attr("10024",simFee); //SIM����
 		$(billArgsObj).attr("10025",fee_sumPay); //Ԥ�滰��
 		$(billArgsObj).attr("10026",machFee); //������
 		$(billArgsObj).attr("10027","0.00"); //������
 		$(billArgsObj).attr("10030",prtLoginAccept); //��ˮ��--ҵ����ˮ
 		$(billArgsObj).attr("10036","<%=opcodeadd%>"); //��������
 		/********tianyang add at 20090928 for POS�ɷ�����****start*****/
    	if(document.all.payType.value=="BX" || document.all.payType.value=="BY"){
	 		$(billArgsObj).attr("10049",document.all.payType.value);  //��������   
			$(billArgsObj).attr("10050",document.MerchantNameChs.value); //�̻����ƣ���Ӣ��)
			$(billArgsObj).attr("10051",document.CardNoPingBi.value); //���׿��ţ����Σ�
			$(billArgsObj).attr("10052",document.MerchantId.value); //�̻�����
			$(billArgsObj).attr("10053",document.BatchNo.value); //���κ�
			$(billArgsObj).attr("10054",document.IssCode.value); //�����к�
			$(billArgsObj).attr("10055",document.TerminalId.value); //�ն˱���
			$(billArgsObj).attr("10056",document.AuthNo.value); //��Ȩ��
			$(billArgsObj).attr("10057",document.Response_time.value); //��Ӧ����ʱ��
			$(billArgsObj).attr("10058",document.Rrn.value); //�ο���
			$(billArgsObj).attr("10059",document.TraceNo.value); //��ˮ��----pos��������ˮ
			$(billArgsObj).attr("10060",document.AcqCode.value); //�յ��к�
		}
	 }
 		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + DlgMessage;

		var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + DlgMessage;
		var loginAccept = prtLoginAccept;
		var path = path + "&loginAccept="+loginAccept+"&opCode=<%=opcodeadd%>&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop);
 		/**
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		var path = "/npage/innet/pubBillPrintCfm.jsp?dlgMsg=" + DlgMessage;
		var loginAccept = prtLoginAccept;
		var path = path + "&infoStr="+printInfo+"&loginAccept="+loginAccept+"&opCode=<%=opcodeadd%>&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,"",prop);
		*/
}	    

function showBroadKdZdBill2(printType,DlgMessage,submitCfm){
			
	var printInfo = "";
	var prtLoginAccept = "";
	var iccidtypess="<%=custditypesnames%>";
	var iccidnoss="<%=custiccids%>";
	var fysqfss="";
	var  billArgsObj = new Object();
	for (var m = 0 ; m < prtFlagSet.length; m ++){
		var arrayOrderId = prtFlagSet[m].split("~")[0];
		prtLoginAccept = prtFlagSet[m].split("~")[1];
		var opType = "";
		var custName = "";
		var phoneNo = "";
		var feeName = "����ն˷���";
		var cashPay = document.all.totalFee3.value;
	  $("#servtbl :radio").each(function(i){
 			if(this.checked){
 				opType   = $(this).parent().parent().find("td:eq(4)").text();
 				custName = $(this).parent().parent().find("td:eq(3)").text();
 				phoneNo  = $(this).parent().parent().find("td:eq(2)").text();
 			}
 		});
 		/*2014/09/11 15:18:07 gaopeng ����ʷ�չ�ּ��ն˹��������ϵͳ֧���Ż�����
	  		���� ����豸�ն˿� 
	  	*/
	  	var shuilv = 0.17;
	  	var kdZdFee = "";
	  	var danjia = 0;
	  	var shuie = 0;
  	var tableName = "tbl"+servOrderNoArray[0];
  	var tabobj = g(tableName);
		for(i=1; i < tabobj.rows.length; i++){
				var feename = tabobj.rows(i).cells(1).children[1].value;
				 if(feename.indexOf("����豸�ն�Ѻ��")!=-1){
					kdZdFee += parseInt(tabobj.rows(i).cells(4).children[0].value);
					fysqfss="zsj";
					/*2016/7/25 10:55:51 gaopeng ���ڼ��ſ����ƷBOSS���ο��������� 
	  				ki  Ѻ���ʱ�� ˰��Ϊ0
	  			*/
	  			if("<%=v_smCode%>" == "ki" ){
	  				shuilv = 0.00;
	  			}
				}				
		}
		
		danjia = Number(kdZdFee) - Number(kdZdFee)*shuilv;
		shuie = Number(kdZdFee)*shuilv;
		getBroadMsg(phoneNo);
 		
			$(billArgsObj).attr("10001","<%=loginNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005",custName);   //�ͻ�����
			$(billArgsObj).attr("10006","�������");    //ҵ�����
			$(billArgsObj).attr("10008",phoneNo);    //�û�����
			$(billArgsObj).attr("10015", kdZdFee+"");   //���η�Ʊ���
			$(billArgsObj).attr("10016", kdZdFee+"");   //��д���ϼ�
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
			/*10028 10029 ����ӡ*/
		  $(billArgsObj).attr("10028","");   //�����Ӫ������ƣ�
			$(billArgsObj).attr("10029","");	 //Ӫ������	
			$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
			$(billArgsObj).attr("10036","<%=opcodeadd%>");   //��������
			
			$(billArgsObj).attr("10042","̨");                   //��λ
			$(billArgsObj).attr("10043","1");	                   //����
			$(billArgsObj).attr("10044",kdZdFee+"");	                //����
			/*10045����ӡ*/
			$(billArgsObj).attr("10045","");	       //IMEI
			/*�ͺŲ���*/
			$(billArgsObj).attr("10061","");	       //�ͺ�
			$(billArgsObj).attr("10062",shuilv+"");	//˰��
			$(billArgsObj).attr("10063",shuie+"");	//˰��	   
	    $(billArgsObj).attr("10071","6");	//˰��	
	 		$(billArgsObj).attr("10076",danjia+"");
	 		$(billArgsObj).attr("10077", kdZdFee+""); //����ն˽��
 			$(billArgsObj).attr("10078", "<%=v_smCode%>"); //���Ʒ��			
 			
 			if(fysqfss=="zsj") {
	 			$(billArgsObj).attr("10083", iccidtypess); //֤������
	 			$(billArgsObj).attr("10084", iccidnoss); //֤������
	 			$(billArgsObj).attr("10085", fysqfss); //���������ȡ��ʽ
	 			$(billArgsObj).attr("10086", "�𾴵��û���������������������ʱ����Я��ONT�豸��Ѻ��Ʊ����Ч֤�������ƶ�ָ������Ӫҵ��������Ѻ��"); //��ע
	 			$(billArgsObj).attr("10041", "����ն�Ѻ�����");           //Ʒ����� ʵ���ǿ���ն�����
	 			$(billArgsObj).attr("10065", $("#broadNo").val()); //����˺�
	 			$(billArgsObj).attr("11213","REC");  //�°淢Ʊ����Ʊ�ݱ�־λ��Ĭ�Ͽ�λ��Ʊ REC == ֻ�� ��ӡֽ���վ�
 			}else {
	 			$(billArgsObj).attr("10041", "����ն˷���");           //Ʒ����� ʵ���ǿ���ն�����
	 			$(billArgsObj).attr("11214","HID_PR");	 //�����վݰ�ť== ��ӡ���ӷ�Ʊ  ��ӡֽ�ʷ�Ʊ
 			}
 			
	 		}
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;
			
			//��Ʊ��Ŀ�޸�Ϊ��·��
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;
			
			var loginAccept = prtLoginAccept;
			var path = path +"&loginAccept="+loginAccept+"&opCode=<%=opcodeadd%>"+"&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);		

}


function showBroadKdZdBill_HMYJ(printType,DlgMessage,submitCfm){
			
	var printInfo = "";
	var prtLoginAccept = "";
	var iccidtypess="<%=custditypesnames%>";
	var iccidnoss="<%=custiccids%>";
	var fysqfss="MBH";
	var  billArgsObj = new Object();
	for (var m = 0 ; m < prtFlagSet.length; m ++){
		var arrayOrderId = prtFlagSet[m].split("~")[0];
		prtLoginAccept = prtFlagSet[m].split("~")[1];
		var opType = "";
		var custName = "";
		var phoneNo = "";
		var feeName = "��ĿѺ��";
		var cashPay = document.all.totalFee3.value;
	  $("#servtbl :radio").each(function(i){
 			if(this.checked){
 				opType   = $(this).parent().parent().find("td:eq(4)").text();
 				custName = $(this).parent().parent().find("td:eq(3)").text();
 				phoneNo  = $(this).parent().parent().find("td:eq(2)").text();
 			}
 		});
 		/*2014/09/11 15:18:07 gaopeng ����ʷ�չ�ּ��ն˹��������ϵͳ֧���Ż�����
	  		���� ����豸�ն˿� 
	  	*/
	  	var shuilv = 0;
	  	var kdZdFee = 0;
	  	var danjia = 0;
	  	var shuie = 0;
  	var tableName = "tbl"+servOrderNoArray[0];
  	var tabobj = g(tableName);
		for(i=1; i < tabobj.rows.length; i++){
				var feename = tabobj.rows(i).cells(1).children[1].value;
				//alert("feename===="+feename);
				 if(feename.indexOf("��ĿѺ��")!=-1){
					kdZdFee += parseInt(tabobj.rows(i).cells(4).children[0].value);
					fysqfss="MBH";
				}				
		}
		
		var tableName2 = "tbl"+servOrderNoArray[1];
  	var tabobj = g(tableName2);
  	if(typeof(tabobj.rows) != "undefined"){
  		for(i=1; i < tabobj.rows.length; i++){
				var feename = tabobj.rows(i).cells(1).children[1].value;
				//alert("feename===="+feename);
				 if(feename.indexOf("��ĿѺ��")!=-1){
					kdZdFee += parseInt(tabobj.rows(i).cells(4).children[0].value);
					fysqfss="MBH";
				}				
			}
  	}
		
		
		danjia = Number(kdZdFee) - Number(kdZdFee)*shuilv;
		shuie = Number(kdZdFee)*shuilv;
		getBroadMsg(phoneNo);
 		//alert("ħ�ٺ�Ѻ��"+kdZdFee);
			$(billArgsObj).attr("10001","<%=loginNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005",custName);   //�ͻ�����
			$(billArgsObj).attr("10006","Ӫ��ִ��");    //ҵ�����
			
			$(billArgsObj).attr("10008",phoneNo);    //�û�����
			$(billArgsObj).attr("10015", kdZdFee+"");   //���η�Ʊ���
			$(billArgsObj).attr("10016", kdZdFee+"");   //��д���ϼ�
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
			/*10028 10029 ����ӡ*/
		  $(billArgsObj).attr("10028","");   //�����Ӫ������ƣ�
			$(billArgsObj).attr("10029","");	 //Ӫ������	
			$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
			$(billArgsObj).attr("10036","<%=opcodeadd%>");   //��������
			/**/
			$(billArgsObj).attr("10042","");                   //��λ
			$(billArgsObj).attr("10043","");	                   //����
			$(billArgsObj).attr("10044","");	                //����
			/*10045����ӡ*/
			$(billArgsObj).attr("10045","");	       //IMEI
			/*�ͺŲ���*/
			$(billArgsObj).attr("10061","");	       //�ͺ�
			$(billArgsObj).attr("10062",shuilv+"");	//˰��
			$(billArgsObj).attr("10063",shuie+"");	//˰��	   
	    $(billArgsObj).attr("10071","6");	//˰��	
	 		$(billArgsObj).attr("10076",danjia+"");
	 		$(billArgsObj).attr("10077", kdZdFee+""); //����ն˽��
 			$(billArgsObj).attr("10078", "<%=v_smCode%>"); //���Ʒ��			
 			
 			$(billArgsObj).attr("10083", iccidtypess); //֤������
 			$(billArgsObj).attr("10084", iccidnoss); //֤������
 			$(billArgsObj).attr("10085", fysqfss); //���������ȡ��ʽ
 			$(billArgsObj).attr("10086", "�𾴵Ŀͻ�����������ҵ���˶���ȡ������ֹҵ��ʹ�õĲ���ʱ����Я�����վݡ���Ч���֤��������ҵ��ʱ���ú�Ŀ�ն˵��ƶ�ָ������Ӫҵ������Ѻ���˻�������"); //��ע
 			$(billArgsObj).attr("10041", "");           //Ʒ����� ʵ���ǿ���ն�����
 			$(billArgsObj).attr("10065", $("#broadNo").val()); //����˺�
 			$(billArgsObj).attr("10087", "<%=imei_HMYJ%>"); //�ն˴���
			$(billArgsObj).attr("11213","REC");  //�°淢Ʊ����Ʊ�ݱ�־λ��Ĭ�Ͽ�λ��Ʊ REC == ֻ�� ��ӡֽ���վ�
	 
 			
	 		}
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;

			//��Ʊ��Ŀ�޸�Ϊ��·��
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;

			
			var loginAccept = prtLoginAccept;
			var path = path +"&loginAccept="+loginAccept+"&opCode=<%=opcodeadd%>"+"&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);		

} 



function showBroadKdZdBill(printType,DlgMessage,submitCfm){
			
	var printInfo = "";
	var prtLoginAccept = "";
	var iccidtypess="<%=custditypesnames%>";
	var iccidnoss="<%=custiccids%>";
	var fysqfss="MBH";
	var  billArgsObj = new Object();
	for (var m = 0 ; m < prtFlagSet.length; m ++){
		var arrayOrderId = prtFlagSet[m].split("~")[0];
		prtLoginAccept = prtFlagSet[m].split("~")[1];
		var opType = "";
		var custName = "";
		var phoneNo = "";
		var feeName = "����ն˷���";
		var cashPay = document.all.totalFee3.value;
	  $("#servtbl :radio").each(function(i){
 			if(this.checked){
 				opType   = $(this).parent().parent().find("td:eq(4)").text();
 				custName = $(this).parent().parent().find("td:eq(3)").text();
 				phoneNo  = $(this).parent().parent().find("td:eq(2)").text();
 			}
 		});
 		/*2014/09/11 15:18:07 gaopeng ����ʷ�չ�ּ��ն˹��������ϵͳ֧���Ż�����
	  		���� ����豸�ն˿� 
	  	*/
	  	var shuilv = 0;
	  	var kdZdFee = 0;
	  	var danjia = 0;
	  	var shuie = 0;
  	var tableName = "tbl"+servOrderNoArray[0];
  	var tabobj = g(tableName);
		for(i=1; i < tabobj.rows.length; i++){
				var feename = tabobj.rows(i).cells(1).children[1].value;
				//alert("feename===="+feename);
				 if(feename.indexOf("ħ�ٺ�Ѻ��")!=-1){
					kdZdFee += parseInt(tabobj.rows(i).cells(4).children[0].value);
					fysqfss="MBH";
				}				
		}
		
		var tableName2 = "tbl"+servOrderNoArray[1];
  	var tabobj = g(tableName2);
  	if(typeof(tabobj.rows) != "undefined"){
  		for(i=1; i < tabobj.rows.length; i++){
				var feename = tabobj.rows(i).cells(1).children[1].value;
				//alert("feename===="+feename);
				 if(feename.indexOf("ħ�ٺ�Ѻ��")!=-1){
					kdZdFee += parseInt(tabobj.rows(i).cells(4).children[0].value);
					fysqfss="MBH";
				}				
			}
  	}
		
		
		danjia = Number(kdZdFee) - Number(kdZdFee)*shuilv;
		shuie = Number(kdZdFee)*shuilv;
		getBroadMsg(phoneNo);
 		//alert("ħ�ٺ�Ѻ��"+kdZdFee);
			$(billArgsObj).attr("10001","<%=loginNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005",custName);   //�ͻ�����
			if($("#broadNo").val().length == 0 ){
				$(billArgsObj).attr("10006","Ӫ��ִ��");    //ҵ�����
			}else{
				$(billArgsObj).attr("10006","�������");    //ҵ�����
			}
			
			$(billArgsObj).attr("10008",phoneNo);    //�û�����
			$(billArgsObj).attr("10015", kdZdFee+"");   //���η�Ʊ���
			$(billArgsObj).attr("10016", kdZdFee+"");   //��д���ϼ�
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
			/*10028 10029 ����ӡ*/
		  $(billArgsObj).attr("10028","");   //�����Ӫ������ƣ�
			$(billArgsObj).attr("10029","");	 //Ӫ������	
			$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
			$(billArgsObj).attr("10036","<%=opcodeadd%>");   //��������
			/**/
			$(billArgsObj).attr("10042","");                   //��λ
			$(billArgsObj).attr("10043","");	                   //����
			$(billArgsObj).attr("10044","");	                //����
			/*10045����ӡ*/
			$(billArgsObj).attr("10045","");	       //IMEI
			/*�ͺŲ���*/
			$(billArgsObj).attr("10061","");	       //�ͺ�
			$(billArgsObj).attr("10062",shuilv+"");	//˰��
			$(billArgsObj).attr("10063",shuie+"");	//˰��	   
	    $(billArgsObj).attr("10071","6");	//˰��	
	 		$(billArgsObj).attr("10076",danjia+"");
	 		$(billArgsObj).attr("10077", kdZdFee+""); //����ն˽��
 			$(billArgsObj).attr("10078", "<%=v_smCode%>"); //���Ʒ��			
 			
 			if(fysqfss=="MBH") {
	 			$(billArgsObj).attr("10083", iccidtypess); //֤������
	 			$(billArgsObj).attr("10084", iccidnoss); //֤������
	 			$(billArgsObj).attr("10085", fysqfss); //���������ȡ��ʽ
	 			$(billArgsObj).attr("10086", "�𾴵Ŀͻ�����������ҵ���˶���ȡ������ֹҵ��ʹ�õĲ���ʱ����Я�����վݡ���Ч���֤��������ҵ��ʱ����ħ�ٺ��ն˵��ƶ�ָ������Ӫҵ������Ѻ���˻�������"); //��ע
	 			$(billArgsObj).attr("10041", "");           //Ʒ����� ʵ���ǿ���ն�����
	 			$(billArgsObj).attr("10065", $("#broadNo").val()); //����˺�
	 			$(billArgsObj).attr("10087", "<%=jdhId%>"); //ħ�ٺл�����ID
 				$(billArgsObj).attr("11213","REC");  //�°淢Ʊ����Ʊ�ݱ�־λ��Ĭ�Ͽ�λ��Ʊ REC == ֻ�� ��ӡֽ���վ�
 			}else {
 				$(billArgsObj).attr("10041", "����ն˷���");           //Ʒ����� ʵ���ǿ���ն�����
 				$(billArgsObj).attr("11214","HID_PR");	 //�����վݰ�ť== ��ӡ���ӷ�Ʊ  ��ӡֽ�ʷ�Ʊ
 			}
 			
	 		}
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;

			//��Ʊ��Ŀ�޸�Ϊ��·��
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;

			
			var loginAccept = prtLoginAccept;
			var path = path +"&loginAccept="+loginAccept+"&opCode=<%=opcodeadd%>"+"&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);		

} 

function showBroadBill(printType,DlgMessage,submitCfm){
	var printInfo = "";
	var prtLoginAccept = "";
	var  billArgsObj = new Object();
	for (var m = 0 ; m < prtFlagSet.length; m ++){
		var arrayOrderId = prtFlagSet[m].split("~")[0];
		prtLoginAccept = prtFlagSet[m].split("~")[1];
		var opType = "";
		var custName = "";
		var phoneNo = "";
		var cashPay = document.all.totalFee3.value;
	  $("#servtbl :radio").each(function(i){
 			if(this.checked){
 				opType   = $(this).parent().parent().find("td:eq(4)").text();
 				custName = $(this).parent().parent().find("td:eq(3)").text();
 				phoneNo  = $(this).parent().parent().find("td:eq(2)").text();
 			}
 		});
 		var tableName = "tbl"+servOrderNoArray[0];
  	var tabobj = g(tableName);
  	var simcardfee = 0;
  	var prefee = 0;
  	var installfee = 0;
  	var jdhFee = 0;
  	var kdzFee = 0;
		for(i=1; i < tabobj.rows.length; i++){
				var feename = tabobj.rows(i).cells(1).children[1].value;
				if(feename == "SIM������"){
					simcardfee  +=parseInt(tabobj.rows(i).cells(4).children[0].value);
				}else if(feename.indexOf("Ԥ��")!=-1){
					prefee +=parseInt(tabobj.rows(i).cells(4).children[0].value);
				}else if(feename.indexOf("��װ��")!=-1){
					installfee += parseInt(tabobj.rows(i).cells(4).children[0].value);
				}else if(feename.indexOf("����豸�ն�Ѻ��")!=-1){
					kdzFee += parseInt(tabobj.rows(i).cells(4).children[0].value);
				}else if(feename.indexOf("ħ�ٺ�Ѻ��")!=-1){
					jdhFee += parseInt(tabobj.rows(i).cells(4).children[0].value);
				}
		}
		
		var tableName2 = "tbl"+servOrderNoArray[1];
		var tabobj = g(tableName2);
		if(typeof(tabobj.rows) != "undefined"){
			for(i=1; i < tabobj.rows.length; i++){
				var feename = tabobj.rows(i).cells(1).children[1].value;
				if(feename.indexOf("ħ�ٺ�Ѻ��")!=-1){
					jdhFee += parseInt(tabobj.rows(i).cells(4).children[0].value);
				}
			}
		}
		
		
		/*��Ʊ��ӡ�Ľ��=ʵ��-ħ�ٺ�Ѻ�� ħ�ٺ�Ѻ��Ҫ������ӡ
				
		*/
		cashPay = Number(cashPay)-Number(jdhFee)-Number(kdzFee);
		if(cashPay==0){
			return;
		}
		
		getBroadMsg(phoneNo);
		printInfo += "<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>" + "|";
		printInfo += "<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>" + "|";
		printInfo += "<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>" + "|";
		printInfo += prtLoginAccept + "|";
		printInfo += custName + "|";
		printInfo += " " + "|";
		printInfo += " " + "|";
		printInfo += $("#broadNo").val() + "|";
		printInfo += " " + "|";
		printInfo += cashPay + "|";
		printInfo += cashPay + "|";
		printInfo += "��װ�ѣ�" + installfee + "Ԫ" + "~" + "����ײ�Ԥ��" + prefee + "Ԫ" + "~";
		printInfo += "�ͷ����ߣ�10050" + "~";
		printInfo += "��ַ��http://www.bc880.com" + "|";
		
		
 		$(billArgsObj).attr("10001","<%=loginNo%>");       //����
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",custName); //�ͻ�����
 		$(billArgsObj).attr("10006","�������"); //ҵ�����
 		$(billArgsObj).attr("10008",phoneNo); //�û�����
 		$(billArgsObj).attr("10015", cashPay); //���η�Ʊ���(Сд)��
 		$(billArgsObj).attr("10016", cashPay); //��д���ϼ�
 		$(billArgsObj).attr("10036","4977"); //��������	
 		$(billArgsObj).attr("10030",prtLoginAccept); //��ˮ��--ҵ����ˮ
 		$(billArgsObj).attr("10065", $("#broadNo").val()); //����˺�
 		$(billArgsObj).attr("10066", installfee); //��װ��
 		$(billArgsObj).attr("10067", prefee); //����ײ�Ԥ���
 		$(billArgsObj).attr("10078", "<%=v_smCode%>"); //���Ʒ��
 		//$(billArgsObj).attr("10068", "10086"); 
 	    $(billArgsObj).attr("10071","8"); //ģ��
 	    $(billArgsObj).attr("10017","*"); //���νɷ��ֽ�
 	    

	}
	var path ="";
	if($("#broadNo").val().indexOf("yd")==0 || $("#broadNo").val().indexOf("jt")==0 || $("#broadNo").val().indexOf("kdz")==0){
		//path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "��Ʊ��ӡ";
		
					//��Ʊ��Ŀ�޸�Ϊ��·��
	  path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "��Ʊ��ӡ";

	}else{
		path = "/npage/public/pubBillPrintBroad.jsp?dlgMsg=" + "��Ʊ��ӡ";
	}
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var loginAccept = prtLoginAccept;
	path = path + "&infoStr="+printInfo+"&loginAccept="+loginAccept+"&opCode=4977&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop);
}


//��ͥ������ӡ��Ʊ���� hejwa add 2013��5��7��
function showFamilyBill(printType,DlgMessage,submitCfm){
	var printInfo = "";
	var printInfo1 = "";
	for (var m = 0 ; m < prtFlagSet.length; m ++){
	     			var arrayOrderId = prtFlagSet[m].split("~")[0];
	     			var prtLoginAccept = prtFlagSet[m].split("~")[1];
	     			var opType = "";
	     			var custName = "";
	     			var phoneNo = "";
	     			var userId = "<%=gCustId%>"
	     			var checkNo = "";
	     			
 						var machFee = 0;
 						var simFee = 0;
 						var fee_sumPay = 0;
 						var cashPay = "";
 						var posPay = "0.00"; 						
 						if(document.all.payType.value=="BX" || document.all.payType.value=="BY"){
 							posPay = document.all.totalFee3.value; 							
 						}else{
 							cashPay = document.all.totalFee3.value;
 						}
 						var checkPay = document.all.checkPay.value;
 						
  	
    
		    $("#servtbl :radio").each(function(i){
		   			if(this.checked){
		   				opType   = $(this).parent().parent().find("td:eq(4)").text();
		   				custName = $(this).parent().parent().find("td:eq(3)").text();
		   				phoneNo  = $(this).parent().parent().find("td:eq(2)").text();
		   			}
		 		});
 		
  	     	  var tableName = "tbl"+servOrderNoArray[0];
	     	  	var tabobj = g(tableName);
	     	  
				for(i=1; i < tabobj.rows.length; i++){
						var feename = tabobj.rows(i).cells(1).children[1].value;
						if(feename == "SIM������"){
							simFee  +=parseInt(tabobj.rows(i).cells(4).children[0].value);
						}else if(feename.indexOf("Ԥ��")!=-1){
							fee_sumPay +=parseInt(tabobj.rows(i).cells(4).children[0].value);
						}else if(feename.indexOf("������")!=-1){
							machFee +=parseInt(tabobj.rows(i).cells(4).children[0].value);
						}
				}
 	   /**
 	   **�ж��Ƿ�Ϊ֧Ʊ�ɷ����Ϊ֧Ʊ�ɷ����֧Ʊ���븳ֵ
 	   **/
	   var val=$('input:radio[name="checkRadio"]:checked').val();
		if(val!=null){
				checkNo = document.all.checkNo.value��
		}				
		 var  billArgsObj = new Object();
 		$(billArgsObj).attr("10001","<%=loginNo%>");       //����
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",custName); //�ͻ�����
 		$(billArgsObj).attr("10006","��ͥ�û�����"); //ҵ�����
 		$(billArgsObj).attr("10007",""); //�ͻ�Ʒ��
 		$(billArgsObj).attr("10008",phoneNo); //�û�����
 		$(billArgsObj).attr("10009",userId); //Э�����
 		$(billArgsObj).attr("10010",""); //��������
 		$(billArgsObj).attr("10011",""); //��ͬ��
 		$(billArgsObj).attr("10012",""); //����
 		$(billArgsObj).attr("10013",checkNo); //֧Ʊ��
 		$(billArgsObj).attr("10014",""); //����ͳ������
 		$(billArgsObj).attr("10015", document.all.totalFee3.value); //���η�Ʊ���(Сд)��
 		$(billArgsObj).attr("10016", document.all.totalFee3.value); //��д���ϼ�
 		var sumtypes1="";
 		var sumtypes2="";
 		var sumtypes3="";
 		
 		if(cashPay!="" && (cashPay!="0" && cashPay!="0.00" && cashPay!=0)) {
 			sumtypes1="*";
 		}
 		
  	   if(checkPay!="" && (checkPay!="0" && checkPay!="0.00" && checkPay!=0)) {
 			sumtypes2="*";
 		}
 		
 		if(posPay!=""  && (posPay!="0" && posPay!="0.00"  && posPay!=0)) {
 			sumtypes3="*";

 		} 				
 		$(billArgsObj).attr("10017",sumtypes1); //���νɷ��ֽ�
 		$(billArgsObj).attr("10018",sumtypes2); //֧Ʊ
 		$(billArgsObj).attr("10019",sumtypes3); //ˢ��
 		$(billArgsObj).attr("10020","0.00"); //������
 		$(billArgsObj).attr("10021","0.00"); //������
 		$(billArgsObj).attr("10022","0.00"); //ѡ�ŷ�
 		$(billArgsObj).attr("10023","0.00"); //Ѻ��
 		$(billArgsObj).attr("10024",simFee); //SIM����
 		$(billArgsObj).attr("10025",fee_sumPay); //Ԥ�滰��
 		$(billArgsObj).attr("10026",machFee); //������
 		$(billArgsObj).attr("10027","0.00"); //������
 		$(billArgsObj).attr("10028",""); //�����Ӫ�������
 		$(billArgsObj).attr("10029",""); //Ӫ������
 		$(billArgsObj).attr("10030",prtLoginAccept); //��ˮ��--ҵ����ˮ
 		
 		$(billArgsObj).attr("10032",""); //Ӫҵ��
 		$(billArgsObj).attr("10033",""); //��Ʊ����
 		$(billArgsObj).attr("10034",""); //��Ʊ����
 		$(billArgsObj).attr("10035",""); //��Ʊ����
 		$(billArgsObj).attr("10036","<%=opcodeadd%>"); //��������
 		$(billArgsObj).attr("10037",""); //���ɽ�
 		$(billArgsObj).attr("10038",""); //�������
 		$(billArgsObj).attr("10039",""); //δ���˻���
 		$(billArgsObj).attr("10040",""); //��ǰ�������
 		/********tianyang add at 20090928 for POS�ɷ�����****start*****/
    	if(document.all.payType.value=="BX" || document.all.payType.value=="BY"){
	 		$(billArgsObj).attr("10049",document.all.payType.value);  //��������   
			$(billArgsObj).attr("10050",document.MerchantNameChs.value); //�̻����ƣ���Ӣ��)
			$(billArgsObj).attr("10051",document.CardNoPingBi.value); //���׿��ţ����Σ�
			$(billArgsObj).attr("10052",document.MerchantId.value); //�̻�����
			$(billArgsObj).attr("10053",document.BatchNo.value); //���κ�
			$(billArgsObj).attr("10054",document.IssCode.value); //�����к�
			$(billArgsObj).attr("10055",document.TerminalId.value); //�ն˱���
			$(billArgsObj).attr("10056",document.AuthNo.value); //��Ȩ��
			$(billArgsObj).attr("10057",document.Response_time.value); //��Ӧ����ʱ��
			$(billArgsObj).attr("10058",document.Rrn.value); //�ο���
			$(billArgsObj).attr("10059",document.TraceNo.value); //��ˮ��----pos��������ˮ
			$(billArgsObj).attr("10060",document.AcqCode.value); //�յ��к�
		}else{
			$(billArgsObj).attr("10049","");
			$(billArgsObj).attr("10050","");
			$(billArgsObj).attr("10051","");
			$(billArgsObj).attr("10052","");
			$(billArgsObj).attr("10053","");
			$(billArgsObj).attr("10054","");
			$(billArgsObj).attr("10055","");
			$(billArgsObj).attr("10056","");
			$(billArgsObj).attr("10057","");
			$(billArgsObj).attr("10058","");
			$(billArgsObj).attr("10059","");
			$(billArgsObj).attr("10060","");
		} 
  }
  
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + DlgMessage;
	
			//��Ʊ��Ŀ�޸�Ϊ��·��
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + DlgMessage;
	
	
	var loginAccept = prtLoginAccept;
	var path = path +"&loginAccept="+loginAccept+"&opCode=<%=opcodeadd%>&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop);
}



function getBroadMsg(phoneNo){
		var getdataPacket = new AJAXPacket("fq046_getBroadmsg.jsp","���ڻ�����ݣ����Ժ�......");
		getdataPacket.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(getdataPacket,doBroadMsgBack);
		getdataPacket = null;
}
function doBroadMsgBack(packet){
	retCode = packet.data.findValueByName("retcode");
	retMsg = packet.data.findValueByName("retmsg");
	result = packet.data.findValueByName("result");
	if(retCode == "000000"){
		$("#broadNo").val(result);
	}
}

function ajaxGetToCFee(totalFee){
	var packet1 = new AJAXPacket("ajaxGetTcf.jsp","���Ժ�...");
								packet1.data.add("totalFee",totalFee);
								core.ajax.sendPacket(packet1,doAjaxGetToCFee);
								packet1 =null;
}
function doAjaxGetToCFee(packet){
		chinaFee =  packet.data.findValueByName("chinaFee");
}
function showPrtDlg1(printType,DlgMessage,submitCfm,printStr)
{   
	var h=198;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var sysAccept = "<%=result5[0][0]%>";
	var phone_no	= "<%=servPhoneNo%>";
	var mode_code = null;
	var fav_code = null;
	var area_code = null;
	var printStr = printStr;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=1104&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	if(printStr!=""){//�ϵ�ָ�ʱȡ����printStr
	//alert(printStr);
		var ret=window.showModalDialog(printStr,printStr,prop);
	}
	
	return true;
}

$(document).ready(function (){
	getprintinfonew();

});
				var sysAccept4977 = "";
				var printinfo = "";//�ϵ�ָ�ʱȡ������̬div
function getprintinfonew(){   	

     	  if(typeof(parent.document.getElementById("<%=gCustId%>"))!="undefined"&&parent.document.getElementById("<%=gCustId%>")!=null){
     	  	printinfo = parent.document.getElementById("<%=gCustId%>").printinfo;
     	  	parent.document.getElementById("<%=gCustId%>").printinfo = "";//ȡ��ֵ���
     	  	//alert(printinfo);
     	  }
     	  if(printinfo=="") {
     	   
	     	  var arrayOrderss = new Array();
	     	  arrayOrderss="<%=arrayOrders%>".split("|");
	     	  //alert(arrayOrderss.length);
	     	 
	     	  for (var i = 0 ; i < arrayOrderss.length ; i++ ){
	     	  	 if(printinfo!=""){
		     	  	//������2����������һ��ȡ�������Ϣ��ڶ�������ִ��
		     	  	break;
			     	 }
		     	  //alert("diaoyong");
			     	var myPacket = new AJAXPacket("/npage/s1104/savePrintInfos.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
						myPacket.data.add("path","");
						myPacket.data.add("sOrderArrayId",arrayOrderss[i]);
						myPacket.data.add("opcode","<%=opcodeadd%>");
						myPacket.data.add("optype","1");
					  core.ajax.sendPacket(myPacket,dosaveflag);
					  myPacket = null;
					}
     	  
     	  }
}
     	 
function dosaveflag(packet){
		var retCode = packet.data.findValueByName("retcode");
		var retMsg = packet.data.findValueByName("retmsg");
		var printinfoquery = packet.data.findValueByName("printinfoquery");
		
		 if(retCode != "000000"){
			rdShowMessageDialog("��ѯ�����Ϣ�����������:"+retCode+"��������Ϣ:"+retMsg,0);
		 }else {
		 	if(printinfo.length==0) {
		 		printinfo=printinfoquery;
		 	}
		 	
		 }

    }
    
    
    
    //alert(printinfo); 

     	  
     	  
     	  var opcode = "<%=opcodeadd%>";
     	  
     		function submit_cfm(){
     	  	/*yanpx add*/
     	  	//�շѴ���ʱ�ȱ���opcode���飬����4977��ȥ���ݿ�ȡ��ӡ��Ϣ���ص�ҳ����д��� hejwa
     	  	 
		     	  //���4977�Ĵ�ӡ��ˮ��Ϊ����ȥ���ݿ�ȡ�������
		     	  //��ӡ����������
						
						for(var i=0;i<opCodeOrderJs.length;i++){
							if(opCodeOrderJs[i]=="4977"){
								sysAccept4977 = sysAcceptOrderJs[i];
								break;
							}
						}
						if(sysAccept4977!=""){//��ӡ������
							var senddata={};
									senddata["opCode"]       = "4977";
									senddata["login_accept"] = sysAccept4977;
							$.ajax({
								url: 'ajaxGetPrintInfo4977.jsp',
								type: 'POST',
								data: senddata,
								async: false,
								error: function(data){
										if(data.status=="404"){
										  alert( "�ļ�������!");
										}else if (data.status=="500"){
										  alert("�ļ��������!");
										}else{
										  alert("ϵͳ����!");
										}
								},
								success: function(msg){
								  if(msg.trim()!=""){
								  	msg=msg.trim().replace(new RegExp("#","gm"),"%23");
								  	//alert("msg = "+msg);
								  	var pathInfo  = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=ȷʵҪ���е��������ӡ��";
								  	    pathInfo += "&mode_code=null&fav_code=null&area_code=null&opCode=4977&sysAccept="+sysAccept4977+"&phoneNo=<%=servPhoneNo%>&submitCfm=Yes&pType=subprint&billType=1&printInfo=" + msg;
								  	printinfo  = pathInfo;
								  }else{
										rdShowMessageDialog("ȡ������������Ϣ����!");
								  }
								}
							});
						}
     	  	if("<%=opcodeadd%>" =="e887" ||"<%=opcodeadd%>" =="1104" || "<%=opcodeadd%>" =="m275" ||"<%=opcodeadd%>" =="d535" ||"<%=opcodeadd%>" =="4977"||"<%=opcodeadd%>" =="g784"||"<%=opcodeadd%>" =="g785"||"<%=opcodeadd%>" =="m028"||"<%=opcodeadd%>" =="m094"||sysAccept4977!=""){/* lijy add @20110517 d535,4977��֧����ӣ��û�ims����,������������ӡ*/
	     	  	var tableName = "tbl"+servOrderNoArray[0];
	     	  	var tabobj = g(tableName);
	     	  	var simcardfee = 0;
	     	  	var prefee = 0;
	     	  	var installfee = 0;
						for(i=1; i < tabobj.rows.length; i++){
								var feename = tabobj.rows(i).cells(1).children[1].value;
								if(feename == "SIM������"){
									simcardfee  +=parseInt(tabobj.rows(i).cells(4).children[0].value);
									//printinfo = printinfo.replace("SIMCARDFEE",tabobj.rows(i).cells(4).children[0].value);
								}else if(feename.indexOf("Ԥ��")!=-1){
									prefee +=parseInt(tabobj.rows(i).cells(4).children[0].value);
									//printinfo = printinfo.replace("PREMONEY",tabobj.rows(i).cells(4).children[0].value);
								}else if(feename.indexOf("��װ��")!=-1){
									installfee += parseInt(tabobj.rows(i).cells(4).children[0].value);
								}
						}
						printinfo = printinfo.replace("SIMCARDFEE",simcardfee+".00");
						printinfo = printinfo.replace("PREMONEY",prefee+".00");
						printinfo = printinfo.replace("INSTALLFEE",installfee+".00");
						printinfo = printinfo.replace(/\|xg\|/g,"\\");
						showPrtDlg1("Detail","ȷʵҪ��ӡ���������","Yes",printinfo);
						
					//alert(printinfo);
						//alert(g(tableName).rows(1).cells(1).children[1].value+"|"+g(tableName).rows(1).cells(4).children[0].value);
		   		}
		   		/*end*/
     	  	if("<%=errCode%>"!=0){
     	  		rdShowMessageDialog("����sShowNumInfo��ѯ����<%=errCode%>--<%=errMsg%>");
     	  		return false;
     	  	}
     	  	closeFlag = true;
     	  	doCfm();
     	  }
 		 var map046 = {};
			map046.put = {
			      "items": function(obj,a,c){
			        var b = [];
			        for(var i in obj){
			          if(a == i){
			          	obj[i]=	Number(obj[i]) + Number(c);
			          	  //alert(a+":"+ obj[a]);
										return;
			          }
			         }
			          obj[a] =c;
			//           alert(a+":"+ obj[a]);
			        return b;
			      }
			};
	      function showPrtDlg(){
	     		var prtAccpetLoginStr = "";
	     		//��Ʊ��ӡ���ݶ�������+��ˮ��()ȷ��һ�ŷ�Ʊ ,prtFlagSet�����д洢�ľ��� ��������~��ˮ��
	     		for (var m = 0 ; m < prtFlagSet.length; m ++){
	     			var arrayOrderId = prtFlagSet[m].split("~")[0];
	     			var prtLoginAccept = prtFlagSet[m].split("~")[1];
	     			var phoneFlag = 0;
		        	var  feeArray = {}
	     			
	     				var phoneNo = "";
						var custName = "";
						var opType = "";
						
						 

						var detail="";
						var city="<%=siteName%>";
						
	     			var detailFee1 = 0;
						var detailFee2 = 0;
						var detailFee3 = 0;
						var detailFee4 = 0;
						var amount = 0;
			      var detailstr = "";
		      	var tblObj = g("servtbl");
		      	var trObjs = tblObj.childNodes[0].childNodes;
		      	for(var i = 1;i<trObjs.length;i++){
		      		var tdObjs = trObjs[i].childNodes;
		      		//var inputObj = tdObjs[0].childNodes[0]
		      		
		      		var inputObj = tdObjs[0].childNodes[0]   //update 2009
		      		if( inputObj.v_prtFlag == prtFlagSet[m]){
			      				if(inputObj.v_iscomp == "Y"){
				      				phoneNo = inputObj.v_phoneNo; 
									//custName = inputObj.v_custName;
									opType =  inputObj.v_opType; 
								}else{
									phoneNo = tdObjs[2].innerHTML; 
									//custName = tdObjs[3].innerHTML;
									opType =  tdObjs[4].innerHTML; 	
								}
								var servOrderNo = inputObj.v_span;
								var feeTblObj = g("tbl"+servOrderNo);
								var feeTrObjs = feeTblObj.childNodes[0].childNodes;
								for(var j = 1; j < feeTrObjs.length;j++){
									var feeTdObjs = feeTrObjs[j].childNodes;
									var isprintvalue = feeTdObjs[6].childNodes[0].value;
									if(isprintvalue == "T" && parseFloat(feeTdObjs[4].childNodes[0].value) != 0){//���÷��ÿ�Ŀʵ�շ��ò�Ϊ0����Ϊ��ӡ״̬,�Ŵ�ӡ����Ʊ��
										map046.put.items(feeArray,feeTdObjs[1].childNodes[1].value,feeTdObjs[4].childNodes[0].value);
										detailFee1 += Number(feeTdObjs[2].innerText);
										detailFee3 += Number(feeTdObjs[4].childNodes[0].value);
									}
								}
								if(inputObj.v_isPrtFeeDetail == "TRUE"){
									var feeDetail = "";
									var phoneFeeStr = inputObj.v_phone_fee_str;
									var phoneNoStr = inputObj.v_phone_no_str;
									feeDetail += "�ɷ�ǰ���ѣ�" + phoneFeeStr.split("~")[1] +"|";
									feeDetail += "�ɷ�ǰ���֣�" +  phoneFeeStr.split("~")[2] +"|" ;
									getPayFeeAfter(phoneNoStr);
									var feeStrAfter = g("payFeeAfter").value;
									feeDetail += "�ɷѺ󻰷ѣ�" + feeStrAfter.split("~")[0] +"|";
									feeDetail += "�ɷѺ���֣�" + feeStrAfter.split("~")[1] +"|";
		      						//printDetailBill2(phoneNoStr,arrayOrderId,custName,opType,amount,city,prtLoginAccept,feeDetail,arrayOrderId);
		      					}
							}
						}
						for(var aa in feeArray){
							detail += aa + "��"	+ feeArray[aa] +"|";
						}
					 	amount = detailFee3;
					 	if(detailFee1 == 0 && detailFee3 ==0){
					 		//continue;	
					 	}
					 	custName = document.all.custNameforsQ046.value;
					 	var sqlVq046 = "select id_no from dcustmsg where phone_no= '"+phoneNo+"'";
					 	var packet1 = new AJAXPacket("/npage/offerConfiguration/offerScene/ajaxGetSqlResult.jsp","���Ժ�...");
								packet1.data.add("sqlV1",sqlVq046);
								core.ajax.sendPacket(packet1,doQuerySel);
								packet1 =null;		
						
						city = custId		;
					 	var mode_code = "";
					 	var fav_code = "";
					 	var area_code ="";
					 	var memo = "��ע��"+custId+phoneNo+opType;
					 	
						a=printDetailBill(phoneNo,arrayOrderId,custName,opType,amount,city,prtLoginAccept,detail,arrayOrderId,mode_code,fav_code,area_code,memo);
						
						prtAccpetLoginStr = arrayOrderId + "~" + a + "~|";
					}
					g("prtAccpetLoginStr").value = prtAccpetLoginStr;
				}
			function doQuerySel(packet){
				  var error_code = packet.data.findValueByName("code");
					var error_msg =  packet.data.findValueByName("msg");
					prodCompInfo1 = packet.data.findValueByName("offerLimitArray");
					custId = prodCompInfo1[0][0];
			}  
			function getPayFeeAfter(phoneNoStr)	  {
				var myPacket = new AJAXPacket("fq046_getAfterFee.jsp","������֤���룬���Ժ�......");       
				myPacket.data.add("phone_no",phoneNoStr);
				core.ajax.sendPacket(myPacket,getPayFeeAfter046,true);
				myPacket =null;
			}
		function getPayFeeAfter046(packet){
			var retCode = packet.data.findValueByName("retCode");
			if(retCode != "0"){
					rdShowMessageDialog("��ȡ���������Ϣʧ�ܣ��޷���ӡ�վ�!",0)	;
					g("payFeeAfter").value = "0~0~";
			}else{
				var result = packet.data.findValueByName("payFeeAfter");
				g("payFeeAfter").value = result;
			}
		}
		function changeKDvalues(ss) {
			
	    document.getElementById(savenames).value=ss;
	    changeRealPayFee();
  	}
			
			 function doCfm()
		    {
		    	
		        //��ʾ��ӡ�Ի���
		        var h = 150;
		        var w = 350;
		        var t = screen.availHeight / 2 - h / 2;
		        var l = screen.availWidth / 2 - w / 2;
		        if(g("op_note").value.trim() == "") g("op_note").value=g("sys_note").value;
	      		if(!checksubmit(form1))	
	     				return false;
	     		  //$("#fee_submit").attr("disabled",true);
	     		  if("g629"=="<%=opcodeadd%>"){
			         conf();
	     		  }
		        else if (rdShowConfirmDialog("ȷ��Ҫ�ύ���β�����") == 1){
		        	try{
			        		
					     	  var printObj = parent.document.getElementById("<%=gCustId%>");
					     	  if(printObj){
					     	  	parent.document.removeChild(printObj);
					     	  }
					     	  
				     	}catch(e){
				     	}		        	
		            conf();
		        }else{
		        	$("#fee_submit").attr("disabled",false);	
		        }
		    }
		    
	       /*
	        *�ύ��, ���ɷѷ���׼�����ô�,����������~���񶨵����~@���ô���~ʵ��~����~Ӧ��~Ӫ��~��ȡ��ʽ~�Ƿ��ӡ~���ô���~�߸�����
	       */ 
						function conf(){
							
							var feeStr = "";
							for( var k = 0 ; k < servOrderNoArray.length;k++){
							var obj = document.getElementById("tbl"+servOrderNoArray[k]);
							var trObjs = obj.childNodes[0].childNodes;
							var rowsNum = trObjs.length;
							for ( var i =1; i < trObjs.length; i++)	{
								var tdObjs = trObjs[i].childNodes; 
								var ningtnVal = "";
										if($(tdObjs[2]).find("select").length > 0){
											ningtnVal = $(tdObjs[2]).find("select").val();
											
										}else{
											ningtnVal = tdObjs[2].innerHTML;
										
										}
										
										
								//�Ӹ��ж�,ÿ������,���Ӧ��!=����+Ӫ��+ʵ��,˵�����ó�������,��������,return false;
								//alert(Number(tdObjs[2].innerText) +"=="+Number(tdObjs[3].innerText)+"+"+Number(tdObjs[4].childNodes[0].value)+"+"+Number(tdObjs[4].childNodes[2].value));
								//alert(Number(tdObjs[2].innerText)!= Number(tdObjs[3].innerText)+Number(tdObjs[4].childNodes[0].value)+Number(tdObjs[4].childNodes[2].value));
								if(Number(ningtnVal)!= Number(tdObjs[3].innerText)+Number(tdObjs[4].childNodes[0].value)+Number(tdObjs[4].childNodes[2].value)){
									rdShowMessageDialog("���ó����쳣����,�뵽�ͻ���ҳ���ϵ���������!",0);
									$("#fee_submit").attr("disabled",false);	
									return false;
								
								}    	    	
								for(var j = 1; j < tdObjs.length-1; j++){
									//var inputObj = tdObjs[j].childNodes[0];
									if(j == 1  || j == 4 || j == 5 || j == 6 ){
										var inputObj = tdObjs[j].childNodes[0];
										if(j == 1){
											feeStr += inputObj.v_pparent;
											feeStr += "~";
											feeStr += inputObj.v_parent;
											feeStr += "~@";    	    		           
										}     	    		    
										feeStr += inputObj.value; 
										
										if(j == 4){
											feeStr += "~" + tdObjs[j].childNodes[2].value; 	
											
										}
									}else{
										var ningtnVal = "";
										if($(tdObjs[j]).find("select").length > 0){
											ningtnVal = $(tdObjs[j]).find("select").val();

										}else{
											ningtnVal = tdObjs[j].innerHTML;

										}
										feeStr += ningtnVal;
										
									}
									feeStr += "~";
								}
								if(tdObjs[7].childNodes[0].value == "otherFee"){
									rowsNum = rowsNum+1;
									feeStr += tdObjs[1].childNodes[0].v_feeType + "~" + rowsNum  + "~0~0~0~0~0~0" + "|";	
								  
								}else{
									feeStr += tdObjs[1].childNodes[0].v_feeType + "~" + tdObjs[7].childNodes[0].value + "|";  //�����ɷѷ������ӷ�������(ȡ��������ǰ���hidden�ؼ���v_feeType����ֵ)�ͷ�������(ȡ˵��ǰ���hidden�ؼ���valueֵ)����,	
								
								}
								}
							}
														
							/*2014/07/09 10:16:43 gaoppeng ��ӡ���ƷѴ��Ĵ�
							alert("���Ǵ����ƷѵĴ�---"+feeStr);
							*/
							/*alert(document.all.totalFee3.value);*/
							/**** tianyang add for pos start ****/
							if(Number(document.all.totalFee3.value)>99999){
									rdShowMessageDialog("ʵ���ܶ�ӦС��10��!");
							}else{
									if(document.all.payType.value=="BX")
						    	{
							    		/*set �������*/
											var transerial    = "000000000000";  	                     //����Ψһ�� ������ȡ��
											var trantype      = "00";                                  //��������
											var bMoney        = document.all.totalFee3.value;					 //�ɷѽ��
											var tranoper      = "<%=loginNo%>";                        //���ײ���Ա
											var orgid         = "<%=groupId%>";                        //ӪҵԱ��������
											var trannum       = "<%=servPhoneNo%>";                    //�绰����
											getSysDate();       /*ȡbossϵͳʱ��*/
											var respstamp     = document.all.Request_time.value;       //�ύʱ��
											var transerialold = "";			                               //ԭ����Ψһ��,�ڽɷ�ʱ�����
											var org_code      = "<%=orgCode%>";                        //ӪҵԱ����						
											CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
											if(ccbTran=="succ") posSubmitForm(feeStr);
						    	}
									else if(document.all.payType.value=="BY"||document.all.payType.value=="EI")
									{
											var transType     = "05";																	/*�������� */         
											var bMoney        = document.all.totalFee3.value;         /*���׽�� */         
											var response_time = "";                                   /*ԭ�������� */       
											var rrn           = "";                                   /*ԭ����ϵͳ������ */ 
											var instNum       = "";                                   /*���ڸ������� */     
											var terminalId    = "";                                   /*ԭ�����ն˺� */			
											getSysDate();       //ȡbossϵͳʱ��                                            
											var request_time  = document.all.Request_time.value;      /*�����ύ���� */     
											var workno        = "<%=loginNo%>";                       /*���ײ���Ա */       
											var orgCode       = "<%=orgCode%>";                       /*ӪҵԱ���� */       
											var groupId       = "<%=groupId%>";                       /*ӪҵԱ�������� */   
											var phoneNo       = "<%=servPhoneNo%>";                   /*���׽ɷѺ� */       
											var toBeUpdate    = "";						                        /*Ԥ���ֶ� */         
											
											
											/** Ӫ�������еķ��ڸ������Ӱ������ģ�� hejwa 2013��8��27��14:23:11 **/
											for(var i=0;i<opCodeOrderJs.length;i++){
												if(opCodeOrderJs[i]=="g794"||opCodeOrderJs[i]=="g796"){
													if($("#icbcInstNum").val()!=""){//���ڸ���Ľ�Ϊ0���Ƿ���
														transType     = "12";
														instNum       = $("#icbcInstNum").val();
														break;
													}
												}
											}
											
											var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
											//����POS������ҵ�񷵻�ֵ������ 20121011 gaopeng ���п�ҵ�񵥱��ʴ������� ��ͨ������1104��ʱ
												if("<%=opcodeadd%>"=="1104")
												{
													if(icbcTran=="succ"){
													SsPosPayPre();
												}
												}
											if(icbcTran=="succ") posSubmitForm(feeStr);
									}else{
											posSubmitForm(feeStr);
									}
							}							
							/**** tianyang add for pos end ****/
						}

/**����POS������ҵ�񷵻�ֵ������ 20121011 gaopeng ���п�ҵ�񵥱��ʴ������� start**/
  function SsPosPayPre()
  {
  		var MydataPacket = new AJAXPacket("/npage/sg175/fg175_1.jsp","���ڴ���POS���ݣ����Ժ�......");
			//��ˮ��
			MydataPacket.data.add("iLoginAccept","<%=PrintAccept%>");
			//������ʶ
			MydataPacket.data.add("iChnSource","01");
			//��������
			MydataPacket.data.add("iOpCode","<%=opcodeadd%>");
			//����
			MydataPacket.data.add("iLoginNo","<%=loginNo%>");
			//��������
			MydataPacket.data.add("iLoginPwd","<%=op_strong_pwd%>");
			//�û�����
			MydataPacket.data.add("iPhoneNo","<%=servPhoneNo%>");
			//��������
			MydataPacket.data.add("iUserPwd","");
			//�ɷ�����
			MydataPacket.data.add("iPayType",document.all.payType.value);
			//�ɷѽ��
			MydataPacket.data.add("iPayFee",document.all.totalFee3.value);
			//�����к�
			MydataPacket.data.add("iCatdNo",document.all.CardNo.value);
			//���ڸ�������
			MydataPacket.data.add("iInstNum",$("#iInstNum").val());
			//ԭ��������
			MydataPacket.data.add("iResponseTime","");
			//ԭ�����ն˺�
			MydataPacket.data.add("iTerminalId",document.all.TerminalId.value);
			//ԭ����ϵͳ������
			MydataPacket.data.add("iRrn",document.all.Rrn.value);
			//�ύ����
			MydataPacket.data.add("iRequestTime",document.all.Request_time.value);
			//Ԥ���ֶ�
			MydataPacket.data.add("iOtherS","");
			
			core.ajax.sendPacket(MydataPacket,dsPosPayPre12);
			
			MydataPacket = null;
  	
  }
  function dsPosPayPre12(packet)
  {
		var ErrorCode = packet.data.findValueByName("retCode12");
		var ErrorMsg = packet.data.findValueByName("retMsg12");
		if(ErrorCode!="0" && ErrorCode!="000000")
		{
			rdShowMessageDialog(ErrorMsg,1);
		}
  	else
  		{
  			return true;
  		}
  }
	/**����POS������ҵ�񷵻�ֵ������ 20121011 gaopeng ���п�ҵ�񵥱��ʴ������� end**/
   
   	function do_cfm(packet){
   		var err_code = packet.data.findValueByName("errorCode");
   		var retMessage = packet.data.findValueByName("retMessage");
   		
   		if(err_code == "0"){
   			if(typeof(parent.frames['user_index'])!="undefined"){
   		    parent.frames['user_index'].location.reload();
   		  }
   		  /*** tianyang add for pos start *** boss���׳ɹ� ��������ȷ�Ϻ��� *****/
				if(document.all.payType.value=="BX"){
					try{
						BankCtrl.TranOK();
					}catch(e){
						alert("���ý��пؼ�����");
					}
					//alert("�����ύ BankCtrl.TranOK()");
				}
				if(document.all.payType.value=="BY"||document.all.payType.value=="EI"){
					try{
						var IfSuccess = KeeperClient.UpdateICBCControlNum();//�����ɹ��������пؼ�ȷ��
					}catch(e){
						alert("���ù��пؼ�����");
					}
				}
				/*** tianyang add for pos end *** boss���׳ɹ� ��������ȷ�Ϻ��� *****/
				
			//2010-7-5 8:46 wanghfa�޸� ��ͨ��������ͨ���������ʾ��Ϣ��ͬ start
<%
			if (isTT == true) {
%>
	   			rdShowMessageDialog("ҵ������ɹ�!",2);
<%
			} else if (isTT == false) {
%>
	   			if("g629"=="<%=opcodeadd%>"&&"0"=="<%=closealertFlag%>"){
	   				rdShowMessageDialog("��ͥ�ͻ������ɹ�!",2);
	   				parent.removeTab("q046");
		     	}
	   			else if("g629"=="<%=opcodeadd%>"&&"1"=="<%=closealertFlag%>"){
	   				rdShowMessageDialog("�ɷѳɹ�!",2);
	   				rdShowMessageDialog("�뵽m357����ͥ��Ա��ϵ����!",1);
	   				parent.removeTab("q046");
		     	}
	   			else{
	   				rdShowMessageDialog("�ɷѳɹ�!",2);
	   			}
<%
			}
%>

	   	var opCodeBillPrt = "";
			var iFlag         = 0;// ��¼����λ��
			for(var i=0;i<opCodeOrderJs.length;i++){
				if(opCodeOrderJs[i]=="g794"||opCodeOrderJs[i]=="g796"){
					opCodeBillPrt = opCodeOrderJs[i];
					iFlag         = i;
					break;
				}
			}
			//1.����Ǽ���ͳ������ѡ���˼���ͳ�����ڽɷѳɹ����Ʊ
			<%if("Y".equals(isJTTFflag)){%>
				if(document.all.jtzhtf.checked == true)
        {
        if(opCodeBillPrt!=""){//��ӡӪ����Ʊ
				 to_showMarkBillPrtJTTF(opCodeBillPrt,iFlag);
			  }
			
        }		
		  <%}%>
		  
		  
   			//rdShowMessageDialog("�ɷѳɹ�!",2);
			//2010-7-5 8:46 wanghfa�޸� ��ͨ��������ͨ���������ʾ��Ϣ��ͬ end
   			var is_release = packet.data.findValueByName("is_release");
   			
   			if(is_release == "Y"){
   				//�رչ��ﳵ��ҳ�����ʱ��û�з�����룬������ʻᱨ��
   				<%if(opcodeadd.equals("g629")){%>
						if(typeof(parent.frames['user_index'])!="undefined"){
							//�ر���ҳ
							//var tabId = "custidgCustId";
							//parent.parent.removeTab(tabId);
							//ˢ����ҳ
							parent.user_index.clearPage();	
		   		  }
					<%}else{%>
						
     				if("<%=opcodeadd%>" == "m275"){
     					parent.removeTab('<%=opCode%>');
     				}else{
     					removeCurrentTab();
     				}
     			<%}%>
	     	}else{
		      parent.addTab(false,'q025','�ͻ��������','/npage/sq025/fq025.jsp?gCustId=<%=gCustId%>&custOrderId='+g("custOrderId").value+'&opCode=q025&opName=�ͻ��������');
		      if((typeof parent.removeTab )=="function")
					{
						 parent.removeTab('<%=opCode%>');
					}
			}
   		}else{
   			rdShowMessageDialog("�ɷ�ʧ��!"+retMessage,0);	
   			$("#fee_submit").attr("disabled",false);	
   			return false;
   		}
   	}
       /*
        *������������
       */ 
    function addType()
		{	
			var iWidth=45; //���ڿ��
			var iHeight=35;//���ڸ߶�
			var typeStr="";
			/*for(var i=0;i<parseFloat(document.all.table1.rows.length,10)-1;i++)
			{
				//alert(document.all.table1.rows.length);
				//alert(document.all.table1.rows[i+1].cells[1].innerText)
				typeStr=typeStr+document.all.table1.rows[i+1].cells[1].innerText+"~";
			}*/
			var servOrder = $("input[@type=radio][@name=servOrders][@checked]").val();	//ȡҪ��ӿ�ѡ���õķ��񶨵���  �����~�����~�����ʶ~�����������
			if(typeof(servOrder)=="undefined"){
				rdShowMessageDialog("����ѡ��Ҫ����������õķ��񶨵�!",0);
				return false;
			}
			var obj = document.form1.elements;
			var servOrderNo = servOrder.split("~")[1];
		 	for(var i = 0 ; i< obj.length; i ++){
             if(obj[i].v_type == "fee_codes" && obj[i].v_mustFee != "1" && obj[i].v_parent == servOrderNo){//�����Ѿ���ӹ�����������,������֤,����ӵķ����Ƿ�Ϸ�
               typeStr +=  obj[i].v_parent+"@"+obj[i].value+"$";  
             }
      }
			var newUrl="fq046_add_type.jsp?typeStr="+typeStr+"&servOrder="+servOrder;
			//var newUrl="f_add_type1.jsp";
			var ss= window.showModalDialog(newUrl,"������Ŀ","dialogWidth:"+iWidth+";dialogHeight:"+iHeight+";");
			//���ص��������ô�:
			//�ֽ��������ô�,��̬��ӵ���Ӧ���񶩵��ķ����б�,����Ԫ��,��ʽ���ѡ������ͬ,ֻ������˵������ɾ����ť,���Խ���ɾ������,����delFee();delTr()
			if(ss != undefined)
			{
				var rowArray =  ss.split("|");
				var arrayOrderNo = rowArray[0].split("~")[0];
				var servOrderNo = rowArray[0].split("~")[1];
				var masterServType = rowArray[0].split("~")[3];
				for(var i =1 ; i < rowArray.length-1; i++){
					var tabRowNum = g("tbl"+servOrderNo).rows.length;
					var colArray = rowArray[i].split("~");
					var trArray = new Array();
					for(var j=0;j< colArray.length-4;j++)
					if(j==0){
						trArray.push(servOrderNo);
						var tmpStr = "<input type=hidden v_type=fee_codes v_pparent="+arrayOrderNo+"  v_parent="+servOrderNo+" name=other_fee_code"+i+" v_feeType=" + colArray[j] + " value=" + colArray[1] + "><input id=other_fee_name"+i+" class='required' name=other_fee_name"+i+" type=text  class='required' value="+colArray[7]+">";
						trArray.push(tmpStr);						
					}else if(j==1){
					}else if(j==4){
						trArray.push("<input type=text size=10 maxLength='15' name=otherRealPayFee_"+i+" class='forMoney required' vflag=1 onchange = changeRealPayFee() value='"+colArray[j]+"'><input type=hidden name=otherRealfee_"+i+"  value='"+colArray[j]+"'><input type=hidden id=otherOpchangeFee_"+i+" value='0' v_oldvalue='0'>");
					}else{
						trArray.push(colArray[j]);
					}
					if(masterServType =="0"){
						trArray.push("<select v_type='feeWay' style='width:100px' name='otherFeeWay_"+i+"' onchange='changeFeeWay()'>"+selStrCdma+"</select>");
					}else{
						trArray.push("<select v_type='feeWay' style='width:100px' name='otherFeeWay_"+i+"' onchange='changeFeeWay()'>"+selStr+"</select>");	
					}
					trArray.push("<select v_type='isPrint' style='width:100px' name='otherIsPrint_"+i+"' onchange='g(v_type).value=this.options[selectedIndex].value'><br><option selected value='T'>��ӡ</option><option value='F'>����ӡ</option></select>");
					
					//1.��ɾ����ť�ؼ�����v_fee1����,�洢����������ú��ԭʼӦ���ܶ�,�û�ɾ����������ɾ����,�ָ�ԭ���ķ���״̬.
					//2.ɾ����ť�ؼ�ǰ���hidden�ؼ�,�洢�߸��������Ӳ���.д����, 20090330 wangljadd
					
					trArray.push("<input type='hidden' name='otherFeeParams_"+i+"' value='otherFee'><input type='button' v_fee1='"+colArray[2]+"' class='butDel' onclick='delFee();delTr()'>");
					addTr("tbl"+servOrderNo,tabRowNum,trArray,"0|1");
					setselect(g("otherFeeWay_"+i),colArray[5]);
					setselect(g("otherIsPrint_"+i),colArray[6]);
					g("totalFee1").value = Number(g("totalFee1").value)+ Number(colArray[2]); //Ӧ���ܶ�
					g("totalFee2").value = Number(g("totalFee2").value)+ Number(colArray[3]); //�Ż��ܶ�
					g("totalFee3").value = Number(g("totalFee3").value)+ Number(colArray[4]); //ʵ���ܶ�
				}
			}
		}
		
		   /*
        *ɾ����������
       */ 
		function delFee(){
					var obj = event.srcElement;
					var trobj = obj.parentNode.parentNode;
					var tdobjs = trobj.childNodes;
					var inputobj1 = tdobjs[4].childNodes[0];
					var inputobj2 = tdobjs[4].childNodes[2];
					var innerobj3 = tdobjs[3].innerText;
					g("totalFee1").value = Number(g("totalFee1").value)- Number(obj.v_fee1);  //Ӧ���ܶ�
					g("totalFee2").value = Number(g("totalFee2").value)-Number(inputobj2.value)-Number(innerobj3); //�Ż��ܶ�
					g("totalFee3").value = Number(g("totalFee3").value)-Number(inputobj1.value); //ʵ���ܶ�
		}
		
		  /*
        *����������
       */ 
		function setselect(obj,obj_value){
				var objs = obj.childNodes;
				for(var i = 0 ; i<objs.length;i++){
					if(objs[i].value==obj_value){
						objs[i].selected = true; 
					}	
				}
		}
		  /*
	        *Ϊ�˱���������շѺʹ���˵��Ӳ���,����ӪҵԱ
	       */ 
		//window.onbeforeunload =function LeaveWin(){
		//	/*if (rdShowMessageDialog("�����뿪�ɷ�ҳ��֮ǰ,�����нɷѲ���,��ȷ�������������,���нɷ���?") == 1)
	  //      {
	  //         doCfm();
	  //      } */
	  //      if(!closeFlag){
	  //      	//doCfm();
	  //      	closeLog();
	  //      	rdShowMessageDialog("�ö�����δ�ɷ�,���ڴ��շ�״̬,�뵽�ͻ���ҳ��ѯ�ö������жϵ������������!");
	  //      	
	  //      	
	  //      	
	  //  	}
		//}
		   /*
	        *Ϊ�˷����������շѺʹ���˵��Ӳ��������,�ڷǷ��رսɷ�ҳ���ʱ��,������־��¼����
	       */ 
		function closeLog(){
			var myPacket = new AJAXPacket("fq046_log_ajax.jsp","���ڻ����Ϣ�����Ժ�......");
			var opNote = "����Ա<%=loginNo%>�Ƿ��ر�<%=opName%>ҳ��,<%=custOrderId%>�������ڴ��ɷ�״̬";
			myPacket.data.add("opNote",opNote);
			myPacket.data.add("custOrderId",g("custOrderId").value);	
			myPacket.data.add("opCode",g("opCode").value);	
			myPacket.data.add("loginNo","<%=loginNo%>");
			core.ajax.sendPacket(myPacket,getCloseLog);	
			myPacket=null;	
		}
		function getCloseLog(packet){
			var err_code = packet.data.findValueByName("errorCode");
			//alert(err_code);
		}
    		
/*tianyang add POS�ɷ� start*/
function getSysDate()
{
	var myPacket = new AJAXPacket("../s1300/s1300_getSysDate.jsp","���ڻ��ϵͳʱ�䣬���Ժ�......");
	myPacket.data.add("verifyType","getSysDate");
	core.ajax.sendPacket(myPacket);
	myPacket = null;

}
function padLeft(str, pad, count)
{
		while(str.length<count)
		str=pad+str;
		return str;
}
function getCardNoPingBi(cardno)
{
		var cardnopingbi = cardno.substr(0,6);
		for(i=0;i<cardno.length-10;i++)
		{
			cardnopingbi=cardnopingbi+"*";
		}
		cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
		return cardnopingbi;
}
/* POS�ɷ��� ��ť��Ч���ó�false  start*/
/*function posSetButton(){
		document.form1.fee_submit.disabled=false;
		document.form1.confirm.disabled=false;
}*/
/* POS�ɷ��� ҳ���ύ  start*/
function posSubmitForm(feeStr){
	
			/*��ȡ ����豸�ն�Ѻ��*/
			var tableName = "tbl"+servOrderNoArray[0];
	  	var tabobj = g(tableName);
	  	
	  	var kdZdFee = 0;
	  	var jdhFee = 0;
	  	
	  	var jdhFee_SN  = 0;
	  	
	  	var j_HMYJ_fee = 0;
	  	
			for(i=1; i < tabobj.rows.length; i++){
					var feename = tabobj.rows(i).cells(1).children[1].value;
					if(feename.indexOf("����豸�ն�Ѻ��")!=-1){
						kdZdFee += parseInt(tabobj.rows(i).cells(4).children[0].value);
					}else if(feename.indexOf("ħ�ٺ�Ѻ��")!=-1){
						if(feename.indexOf("ʡ��ħ�ٺ�Ѻ��")!=-1){
							jdhFee_SN += parseInt(tabobj.rows(i).cells(4).children[0].value);
						}else{
							jdhFee += parseInt(tabobj.rows(i).cells(4).children[0].value);
						}
					} 
					
					if(feename.indexOf("��ĿѺ��")!=-1){
						j_HMYJ_fee += parseInt(tabobj.rows(i).cells(4).children[0].value);
					}
					
			}
			var tableName2 = "tbl"+servOrderNoArray[1];
			var tabobj = g(tableName2);
			if(typeof(tabobj.rows) != "undefined"){
				for(i=1; i < tabobj.rows.length; i++){
					var feename = tabobj.rows(i).cells(1).children[1].value;
					 if(feename.indexOf("ħ�ٺ�Ѻ��")!=-1){
					 	if(feename.indexOf("ʡ��ħ�ٺ�Ѻ��")!=-1){
							jdhFee_SN += parseInt(tabobj.rows(i).cells(4).children[0].value);
						}else{
							jdhFee += parseInt(tabobj.rows(i).cells(4).children[0].value);
						}
					 }
					 
					if(feename.indexOf("��ĿѺ��")!=-1){
						j_HMYJ_fee += parseInt(tabobj.rows(i).cells(4).children[0].value);
					}
					 
				}
			}
			
			
			<%if(opcodeadd.equals("1104")||opcodeadd.equals("m275")||opcodeadd.equals("g784") ||opcodeadd.equals("m028") ||opcodeadd.equals("m094")){%>
				showPrtDlgbill("Bill","ȷʵҪ���з�Ʊ��ӡ��","Yes");
			<%}else if(opcodeadd.equals("4977")){%>
				showBroadBill("Bill","ȷʵҪ���з�Ʊ��ӡ��","Yes");
				
			<%}else if(opcodeadd.equals("g629")){%>
				
				//���ж�ʵ���ܶ����0�ʹ�ӡ��Ʊ hejwa 2013��5��7�� add
				var totalFee = document.all.totalFee3.value;
				if(parseFloat(totalFee)>0){
					showFamilyBill("Bill","ȷʵҪ���з�Ʊ��ӡ��","Yes");
				}
			<%}%>
			
			
						
						//Ӫ����ʶ����߼���ӡ�����Ʊ
						var sysAccept4977 = "";
						for(var i=0;i<opCodeOrderJs.length;i++){
							if(opCodeOrderJs[i]=="4977"){
								sysAccept4977 = sysAcceptOrderJs[i];
								break;
							}
						}
						//alert("4977��ˮ����sysAccept4977=|"+sysAccept4977+"|");
						if(sysAccept4977!=""){
							
							//alert(sysAccept4977);
							/*4977�������ʱ��ȥ��ħ�ٺ�Ѻ��Ľ�� �ڴ�ӡ���������Ʊ���վ�ʱ*/
							showBroadBill("Bill","ȷʵҪ���з�Ʊ��ӡ��","Yes");
						}
						
						//alert("������Ѻ��"+jdhFee);
						//alert("����ն�Ѻ��"+kdZdFee);
							/*2016/4/19 14:45:31 gaopeng ���ħ�ٺ�Ѻ����0 ��ӡ��Ʊ*/
							if(Number(jdhFee) != 0){
								showBroadKdZdBill("Bill","ȷʵҪ����ħ�ٺ��վݴ�ӡ��","Yes");
							}
			/*
				������id�жϣ�����ħ�ٺϡ�ʡ��ħ�ٺϣ�����֮ǰ�Ǽ���ħ�ٺϣ�����֮������ħ�ٺ�
				ʡ��ħ�ٺ�ƽ̨���裨һ�ڹ��ܣ�����������ʡ��ħ�ٺ��վݴ�ӡ
				
				hejwa 2016��9��26��
			*/							
							if(Number(jdhFee_SN) != 0){
								to_showMarkBillPrt_SN("g794","1");
							}
							
							if(Number(j_HMYJ_fee) != 0){
								showBroadKdZdBill_HMYJ("Bill","ȷʵҪ���к�ĿѺ���վݴ�ӡ��","Yes");
							}
							
							
							/*2016/4/19 14:45:31 gaopeng ����ն˿��0 ��ӡ��Ʊ*/
							if(Number(kdZdFee) != 0){
								showBroadKdZdBill2("Bill","ȷʵҪ���п���ն˷�Ʊ��ӡ��","Yes");
							}
						
			var opCodeBillPrt = "";
			var iFlag         = 0;// ��¼����λ��
			for(var i=0;i<opCodeOrderJs.length;i++){
				if(opCodeOrderJs[i]=="g794"||opCodeOrderJs[i]=="g796"){
					opCodeBillPrt = opCodeOrderJs[i];
					iFlag         = i;
					break;
				}
			}
			//1.����Ǽ���ͳ������ѡ���˼���ͳ�����ڽɷѳɹ����Ʊ
			//2.������Ǽ���ͳ������ѭԭ���߼�����--�ȴ�Ʊ
			//3.����Ǽ���ͳ������û��ѡ����ͳ��ѡ��������ѭԭ�߼�--�ȴ�Ʊ
			<%if("Y".equals(isJTTFflag)){%>
						if(document.all.jtzhtf.checked == true)
        {
        }else {
 			if(opCodeBillPrt!=""){//��ӡӪ����Ʊ
				to_showMarkBillPrt(opCodeBillPrt,iFlag);
			}       	
        }
			
		  <%}else {%>
			if(opCodeBillPrt!=""){//��ӡӪ����Ʊ
				to_showMarkBillPrt(opCodeBillPrt,iFlag);
			}
			<%}%>
			
	
			
			for(var i=0;i<opCodeOrderJs.length;i++){
				if(opCodeOrderJs[i]=="g794"||opCodeOrderJs[i]=="g796"){
					if($("#icbcInstNum").val()!=""){//���ڸ���Ľ�Ϊ0���Ƿ���
						document.all.payType.value = "EI";
						break;
					}
				}
			}
			//g784��ӡ��Ʊ���� hejwa add ���ڱ����г���Ӫ��2013��8�µڶ���ҵ��֧��ϵͳ����ĺ�-�����ն�ҵ��ȡ�����ܵ�����
			for(var i=0;i<opCodeOrderJs.length;i++){
				if(opCodeOrderJs[i]=="g798"){
					goto_G798BillPrint(i);
					break;
				}
			}
			
		
			
			//if(rdShowConfirmDialog('ȷ���ύ��')!=1) return;
			var myPacket = new AJAXPacket("fq046_3_ajax.jsp","���ڻ����Ϣ�����Ժ�......");
			
			myPacket.data.add("loginAccept","<%=PrintAccept%>");
			myPacket.data.add("feeStr",feeStr);
			myPacket.data.add("arrayOrder",g("arrayOrder").value);	
			myPacket.data.add("servOrder",g("servOrder").value);	
			myPacket.data.add("custOrderId",g("custOrderId").value);	
			if("<%=opcodeadd%>" =="g784"||"<%=opcodeadd%>" =="g785"||"<%=opcodeadd%>" =="m028"||"<%=opcodeadd%>" =="m094"||"<%=opcodeadd%>" =="m275"){
				myPacket.data.add("opCode","<%=opcodeadd%>");
			}else{
				myPacket.data.add("opCode",g("opCode").value);	
			}
			myPacket.data.add("opName",g("opName").value);	
			myPacket.data.add("gCustId",g("gCustId").value);	
			myPacket.data.add("feeWay",g("feeWay").value);	
			myPacket.data.add("isPrint",g("isPrint").value);	
			myPacket.data.add("prtAccpetLoginStr",g("prtAccpetLoginStr").value);			
			myPacket.data.add("checkNo",g("checkNo").value);	
			myPacket.data.add("bankCode",g("bankCode").value);	
			myPacket.data.add("checkPay",g("checkPay").value);
			myPacket.data.add("offeridkd","<%=offeridkd%>");
			myPacket.data.add("servPhoneNo","<%=servPhoneNo%>");
			myPacket.data.add("v_opCode_order","<%=opcodeadd%>");
			
			/** pos���������� start **/
			
			myPacket.data.add("payType" ,document.all.payType.value);/** �ɷ����� payType=BX �ǽ��� payType=BY �ǹ��� **/
			myPacket.data.add("MerchantNameChs" ,document.all.MerchantNameChs.value);
			myPacket.data.add("MerchantId" ,document.all.MerchantId.value);
			myPacket.data.add("TerminalId" ,document.all.TerminalId.value);
			myPacket.data.add("IssCode" ,document.all.IssCode.value);
			myPacket.data.add("AcqCode" ,document.all.AcqCode.value);
			myPacket.data.add("CardNo" ,document.all.CardNo.value);
			myPacket.data.add("BatchNo" ,document.all.BatchNo.value);
			myPacket.data.add("Response_time" ,document.all.Response_time.value);
			myPacket.data.add("Rrn" ,document.all.Rrn.value);
			myPacket.data.add("AuthNo" ,document.all.AuthNo.value);
			myPacket.data.add("TraceNo" ,document.all.TraceNo.value);
			myPacket.data.add("Request_time" ,document.all.Request_time.value);
			myPacket.data.add("CardNoPingBi" ,document.all.CardNoPingBi.value);
			myPacket.data.add("ExpDate" ,document.all.ExpDate.value);
			myPacket.data.add("Remak" ,document.all.Remak.value);
			myPacket.data.add("TC" ,document.all.TC.value);
			/** pos���������� end **/
				/** g784���� start **/
           //alert("g798BillTypeArr="+g798BillTypeArr+"\ng798ActualFeeUppeArr="+g798ActualFeeUppeArr+"\ng798ActualFeeLoweArr="+g798ActualFeeLoweArr+"\ng798BrandNameArr|"+g798BrandNameArr+"\ng798TypeNameArr|"+g798TypeNameArr);
			myPacket.data.add("g798BillTypeArr" ,toParam(g798BillTypeArr));
			myPacket.data.add("g798BillNameArr" ,toParam(g798BillNameArr));
			myPacket.data.add("g798ActualFeeUppeArr" ,toParam(g798ActualFeeUppeArr));
			myPacket.data.add("g798ActualFeeLoweArr" ,toParam(g798ActualFeeLoweArr));
			myPacket.data.add("g798BrandNameArr" ,toParam(g798BrandNameArr));
			myPacket.data.add("g798TypeNameArr" ,toParam(g798TypeNameArr));
			
			
				
		
			
			
			/** g784���� end **/
			core.ajax.sendPacket(myPacket,do_cfm);	
			myPacket=null;
}
/*tianyang add POS�ɷ� end*/    		


function to_showMarkBillPrt_SN(opCodeBillPrt,iFlag){
		var getdataPacket = new AJAXPacket("ajaxGetSalebillData.jsp","���ڻ�����ݣ����Ժ�......");
		getdataPacket.data.add("custOrderId","<%=custOrderId%>");
		getdataPacket.data.add("billFlag","0");
		getdataPacket.data.add("opCodeBillPrt",opCodeBillPrt);
		getdataPacket.data.add("iFlag",iFlag);
		core.ajax.sendPacket(getdataPacket,doGetSalebillData_SN);
		getdataPacket = null;
}

function doGetSalebillData_SN(packet){
	retCode = packet.data.findValueByName("retCode");
	if(retCode == "000000"||retCode == "0"){
		var getbillArr    = packet.data.findValueByName("getbillArr");
		var opCodeBillPrt = packet.data.findValueByName("opCodeBillPrt");
		var iFlag         = packet.data.findValueByName("iFlag");
		if(getbillArr.length>0){
			 showBroadKdZdBill_SN(getbillArr);
		}else{
			rdShowMessageDialog("û��ȡ����Ʊ��ӡ����",0);
		}	
	}else{
		rdShowMessageDialog("ȡӪ����Ʊ��Ϣ����");
	}
}


function showBroadKdZdBill_SN(billArr){
	var printInfo = "";
	var prtLoginAccept = "";
	var iccidtypess="<%=custditypesnames%>";
	var iccidnoss="<%=custiccids%>";
	var fysqfss="MBH";
	var  billArgsObj = new Object();
	for (var m = 0 ; m < prtFlagSet.length; m ++){
		var arrayOrderId = prtFlagSet[m].split("~")[0];
		prtLoginAccept = prtFlagSet[m].split("~")[1];
		var opType = "";
		var custName = "";
		var phoneNo = "";
		var feeName = "����ն˷���";
		var cashPay = document.all.totalFee3.value;
	  $("#servtbl :radio").each(function(i){
 			if(this.checked){
 				opType   = $(this).parent().parent().find("td:eq(4)").text();
 				custName = $(this).parent().parent().find("td:eq(3)").text();
 				phoneNo  = $(this).parent().parent().find("td:eq(2)").text();
 			}
 		});

	  	var shuilv = 0;
	  	var kdZdFee = 0;
	  	var danjia = 0;
	  	var shuie = 0;
  	var tableName = "tbl"+servOrderNoArray[0];
  	var tabobj = g(tableName);
		for(i=1; i < tabobj.rows.length; i++){
				var feename = tabobj.rows(i).cells(1).children[1].value;
				//alert("feename===="+feename);
				 if(feename.indexOf("ʡ��ħ�ٺ�Ѻ��")!=-1){
					kdZdFee += parseInt(tabobj.rows(i).cells(4).children[0].value);
					fysqfss="MBH";
				}				
		}
		
		var tableName2 = "tbl"+servOrderNoArray[1];
  	var tabobj = g(tableName2);
  	if(typeof(tabobj.rows) != "undefined"){
  		for(i=1; i < tabobj.rows.length; i++){
				var feename = tabobj.rows(i).cells(1).children[1].value;
				//alert("feename===="+feename);
				 if(feename.indexOf("ʡ��ħ�ٺ�Ѻ��")!=-1){
					kdZdFee += parseInt(tabobj.rows(i).cells(4).children[0].value);
					fysqfss="MBH";
				}				
			}
  	}
		
		
		danjia = Number(kdZdFee) - Number(kdZdFee)*shuilv;
		shuie = Number(kdZdFee)*shuilv;
		getBroadMsg(phoneNo);
 		//alert("ħ�ٺ�Ѻ��"+kdZdFee);
			$(billArgsObj).attr("10001","<%=loginNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005",custName);   //�ͻ�����
			
			if($("#broadNo").val().length == 0 ){
				$(billArgsObj).attr("10006","Ӫ��ִ��");    //ҵ�����
			}else{
				$(billArgsObj).attr("10006","�������");    //ҵ�����
			}
			
			$(billArgsObj).attr("10008",phoneNo);    //�û�����
			$(billArgsObj).attr("10015", kdZdFee+"");   //���η�Ʊ���
			$(billArgsObj).attr("10016", kdZdFee+"");   //��д���ϼ�
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
			/*10028 10029 ����ӡ*/
		  $(billArgsObj).attr("10028","");   //�����Ӫ������ƣ�
			$(billArgsObj).attr("10029","");	 //Ӫ������	
			$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
			$(billArgsObj).attr("10036","<%=opcodeadd%>");   //��������
			/**/
			$(billArgsObj).attr("10042","");                   //��λ
			$(billArgsObj).attr("10043","");	                   //����
			$(billArgsObj).attr("10044","");	                //����
			/*10045����ӡ*/
			$(billArgsObj).attr("10045","");	       //IMEI
			/*�ͺŲ���*/
			$(billArgsObj).attr("10061","");	       //�ͺ�
			$(billArgsObj).attr("10062",shuilv+"");	//˰��
			$(billArgsObj).attr("10063",shuie+"");	//˰��	   
	    $(billArgsObj).attr("10071","6");	//
	 		$(billArgsObj).attr("10076",danjia+"");
	 		$(billArgsObj).attr("10077", kdZdFee+""); //����ն˽��
 			$(billArgsObj).attr("10078", "<%=v_smCode%>"); //���Ʒ��			
 			
 			if(fysqfss=="MBH") {
	 			$(billArgsObj).attr("10083", iccidtypess); //֤������
	 			$(billArgsObj).attr("10084", iccidnoss); //֤������
	 			$(billArgsObj).attr("10085", fysqfss); //���������ȡ��ʽ
	 			$(billArgsObj).attr("10086", "�𾴵Ŀͻ�����������ҵ���˶���ȡ������ֹҵ��ʹ�õĲ���ʱ����Я�����վݡ���Ч���֤��������ҵ��ʱ����ħ�ٺ��ն˵��ƶ�ָ������Ӫҵ������Ѻ���˻�������"); //��ע
	 			$(billArgsObj).attr("10041", "");           //Ʒ����� ʵ���ǿ���ն�����
	 			$(billArgsObj).attr("10065", $("#broadNo").val()); //����˺�
	 			$(billArgsObj).attr("10087", billArr[11]); //imei����
 				$(billArgsObj).attr("11213","REC");  //�°淢Ʊ����Ʊ�ݱ�־λ��Ĭ�Ͽ�λ��Ʊ REC == ֻ�� ��ӡֽ���վ�
 			}else {
 				$(billArgsObj).attr("10041", "����ն˷���");           //Ʒ����� ʵ���ǿ���ն�����
 				$(billArgsObj).attr("11214","HID_PR");	 //�����վݰ�ť== ��ӡ���ӷ�Ʊ  ��ӡֽ�ʷ�Ʊ
 			}
 			
	}
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;

			//��Ʊ��Ŀ�޸�Ϊ��·��
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;

			
			var loginAccept = prtLoginAccept;
			var path = path +"&loginAccept="+loginAccept+"&opCode=<%=opcodeadd%>"+"&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);		

} 


    		
//add by liubo ���볷�� start-----------------------------------------				
function commitJsp3(a,b)
{
		var quetype="q034";
		var reasonType ="3";
		var reasonDescription = "�ڽɷѴ�ͳһ����";		
		var startTime = "";
		var endTime = "";
		var osr="1";
		
 	 //var stateFlag = document.frm.stateFlag[document.frm.stateFlag.selectedIndex].value;		
		var aa=g("arrayOrder").value.substring(0,g("arrayOrder").value.indexOf("|"));    //�ͻ���������ͷ��񶨵�
		var myPacket = new AJAXPacket("fq046_cancel.jsp?opcodestr=1&opCode=<%=opCode %>&opName=<%=opName%>","���ڳ��������Ժ�......");
		myPacket.data.add("retType","orderdata");
		myPacket.data.add("quetype",quetype);
		myPacket.data.add("reasonType",reasonType); 
		myPacket.data.add("reasonDescription",reasonDescription);
		myPacket.data.add("quevalue",aa);
		myPacket.data.add("phoneNo",<%=servPhoneNo%>);	
		myPacket.data.add("startTime",startTime);
		myPacket.data.add("endTime",endTime);
		myPacket.data.add("_orderID",g("custOrderId").value+"->"+g("arrayOrder").value);
		myPacket.data.add("workName","<%=loginNo%>");
		core.ajax.sendPacket(myPacket,rollbackPro);		 
		myPacket=null; 
}

function rollbackPro(packet){
	 var errorCode = packet.data.findValueByName("errorCode");
	 var errorMsg = packet.data.findValueByName("errorMsg");
	 if(errorCode!="0"){
		  rdShowMessageDialog("����ʧ��!"+errorMsg,0);
		 
	 }else{
	 	  rdShowMessageDialog("�����ɹ�!");
	 	  if("<%=opcodeadd%>" == "m275"){
	 	  	parent.removeTab('<%=opCode%>');
	 	  }else{
	 	  	parent.user_index.clearPage();	
	 		}
	}
	return;
}

function checkWay()
{   //֧Ʊ֧����ʽ
    var obj = "check"+0;
    if(document.all.checkRadio.checked == true)
    {
    		document.all.payType.value = "0";/*��������*/
        document.all.checkRadio.checked = true;
        document.all.NocheckRadio.checked = false;
        document.all(obj).style.display = "";	
        /*�����м�����radioȡ��checked
          20100201 ningtn tianyang add for pos*/
        document.all.ccb.checked = false;
        document.all.icbc.checked = false;
        
        <%if("Y".equals(isJTTFflag)){%>
        document.all.jtzhtf.checked=false;
        <%}%>
        
    }
}    
function NocheckWay()
{   //��֧Ʊ֧����ʽ 
    var obj = "check"+0;
    var obj1 = "chPayNum" + 0;
    if(document.all.NocheckRadio.checked == true)
    {
    		document.all.payType.value = "0";/*��������*/
    		/*ningtn ǰ̨Ԥ���� js����*/
    		if("<%=opcodeadd%>" != "g784" && "<%=opcodeadd%>" != "m028" && "<%=opcodeadd%>" != "m094"){
    			document.all.checkRadio.checked = false;
    		}
        document.all.NocheckRadio.checked = true;
        document.all(obj).style.display = "none";
        document.all(obj1).style.display = "none";
		
        document.all.checkNo.value = "";
        document.all.bankCode.value = "";
        document.all.bankName.value = "";
        document.all.checkPay.value = "";
				document.all.checkPrePay.value = "";
				/*�����м�����radioȡ��checked
          20100201 ningtn tianyang add for pos*/
        if("<%=opcodeadd%>" != "g784" && "<%=opcodeadd%>" != "m028" && "<%=opcodeadd%>" != "m094"){
	        document.all.ccb.checked = false;
	        document.all.icbc.checked = false;
	      }
	      
	      <%if("Y".equals(isJTTFflag)){%>
        document.all.jtzhtf.checked=false;
        <%}%>
        
     }    
}
/** ����POS���ɷ� @20100201 ningtn tianyang add for pos start **/
function checkCCB(){
		//��֧Ʊ�ɷѲ�������
		var obj = "check"+0;
    var obj1 = "chPayNum" + 0;
    if(document.all.ccb.checked == true)
    {  		
    		document.all.payType.value = "BX";/*��������*/
        document.all.checkRadio.checked = false;
        document.all.NocheckRadio.checked = false;
        document.all(obj).style.display = "none";
        document.all(obj1).style.display = "none";		
        document.all.checkNo.value = "";
        document.all.bankCode.value = "";
        document.all.bankName.value = "";
        document.all.checkPay.value = "";
				document.all.checkPrePay.value = ""; 
				/*���������� ȡ����ѡ*/
				document.all.icbc.checked = false;
				
				<%if("Y".equals(isJTTFflag)){%>
        document.all.jtzhtf.checked=false;
        <%}%>
        
     }
     
}
function checkICBC(){
		//��֧Ʊ�ɷѲ�������
		var obj = "check"+0;
    var obj1 = "chPayNum" + 0;
    if(document.all.icbc.checked == true)
    {    		
    		document.all.payType.value = "BY";/*��������*/
        document.all.checkRadio.checked = false;
        document.all.NocheckRadio.checked = false;
        document.all(obj).style.display = "none";
        document.all(obj1).style.display = "none";		
        document.all.checkNo.value = "";
        document.all.bankCode.value = "";
        document.all.bankName.value = "";
        document.all.checkPay.value = "";
				document.all.checkPrePay.value = ""; 
				/*���������� ȡ����ѡ*/
				document.all.ccb.checked = false;
				
				<%if("Y".equals(isJTTFflag)){%>
        document.all.jtzhtf.checked=false;
        <%}%>
     }     
}
/** ����POS���ɷ� @20100201 ningtn tianyang add for pos end **/

function getBankCode()
{ 
  	//���ù���js�õ����д���
    if((document.all.checkNo.value).trim() == "")
    {
        rdShowMessageDialog("������֧Ʊ���룡",0);
        document.all.checkNo.focus();
        return false;
    }
    
  var getCheckInfo_Packet = new AJAXPacket("f1104_6.jsp","���ڻ��֧Ʊ�����Ϣ�����Ժ�......");
	getCheckInfo_Packet.data.add("retType","getCheckInfo");
  getCheckInfo_Packet.data.add("checkNo",document.all.checkNo.value);
	core.ajax.sendPacket(getCheckInfo_Packet,doGetBankCode);
	getCheckInfo_Packet=null;   
 } 

function doGetBankCode(packet){   //�õ�֧Ʊ��Ϣ
		var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage");	
    
    var obj = "chPayNum" + 0;        
    if(retCode=="000000")
    	{
            var bankCode = packet.data.findValueByName("bankCode");
            var bankName = packet.data.findValueByName("bankName");
            var checkPrePay = packet.data.findValueByName("checkPrePay");
            if(checkPrePay == "0")
            {
    		        document.all.checkNo = "";
                document.all.bankCode.value = "";
                document.all.bankName.value = "";                
                document.all.checkNo.focus();
                document.all(obj).style.display = "none";
                rdShowMessageDialog("��֧Ʊ���ʻ����Ϊ0��",0);
            }
            else
            {   document.all(obj).style.display = "";            }
            
            document.all.bankCode.value = bankCode;
            document.all.bankName.value = bankName;
            document.all.checkPrePay.value = checkPrePay;            
    	}
    	else
    	{
    		document.all.checkNo.value = "";
            document.all.bankCode.value = "";
            document.all.bankName.value = "";
            document.all(obj).style.display = "none"; 
            document.all.checkNo.focus();
    	    retMessage = retMessage + "[errorCode9:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);               		
			return false;
    	}	
	}


function getpreFee()
{
 	if(1*document.all.checkPay.value>1*document.all.totalFee3.value){
 		rdShowMessageDialog("����Ҫ�ɿ���",0);               		
 		document.all.checkPay.value = "";
 		document.all.totalFee3.value = document.all.totalFee1.value;
 		document.all.checkPay.focus();
		return false;	
 	}
 	
 	document.all.totalFee3.value = 1*document.all.totalFee3.value - 1*document.all.checkPay.value;
}

 
//add by liubo ���볷�� end-----------------------------------------		


function show4100Page(){
    var path="show4100Page.jsp?oldMSISDN=<%=oldMSISDN%>&servPhoneNo=<%=servPhoneNo%>";
    var ret=window.showModalDialog(path,"","dialogWidth:750px;center:yes;");
}

function checkjtzhtf() {
    var obj = "check"+0;
    var obj1 = "chPayNum" + 0;
				if(document.all.jtzhtf.checked == true)
        {
        
    		document.all.payType.value = "TF";/*��������*/
    		/*ningtn ǰ̨Ԥ���� js����*/
    		if("<%=opcodeadd%>" != "g784" && "<%=opcodeadd%>" != "m028" && "<%=opcodeadd%>" != "m094"){
    			document.all.checkRadio.checked = false;
    		}
        
        document.all.NocheckRadio.checked = false;
        document.all(obj).style.display = "none";
        document.all(obj1).style.display = "none";
		
        document.all.checkNo.value = "";
        document.all.bankCode.value = "";
        document.all.bankName.value = "";
        document.all.checkPay.value = "";
				document.all.checkPrePay.value = "";
				/*�����м�����radioȡ��checked
          20100201 ningtn tianyang add for pos*/
        if("<%=opcodeadd%>" != "g784" && "<%=opcodeadd%>" != "m028" && "<%=opcodeadd%>" != "m094"){
	        document.all.ccb.checked = false;
	        document.all.icbc.checked = false;
	      }
        
      	}

}
$(function (){
	if("g629"=="<%=opcodeadd%>"){
		parent.removeTab("g638");
		$("#totalFee1").val("0.00");
		$("#totalFee3").val("0.00");
		submit_cfm();
	}
});

$(document).ready(function(){
					if("<%=main_k_flag%>"=="Y"){
								var totalFee1 = 0;
								var totalFee3 = 0;
								
								for( var k = 0 ; k < servOrderNoArray.length;k++){
										var tab_name =  "#tbl"+servOrderNoArray[k];
										$(tab_name).find("tr:gt(0)").each(function(){
											//alert($(this).html());
											var t_name = $(this).find("td:eq(1)").find("input:eq(1)").val();
											if(t_name=="����Ԥ���"||t_name=="����Ԥ���"){
													$(this).find("td:eq(2)").html("0.00");
													$(this).find("td:eq(4)").find("input:eq(0)").val("0.00");
													$(this).find("td:eq(4)").find("input:eq(1)").val("0.00");
													$(this).find("td:eq(4)").find("input:eq(0)").attr("readOnly","readOnly");
											}
												totalFee1 = totalFee1 + Number($(this).find("td:eq(2)").html().trim());
												totalFee3 = totalFee3 + Number($(this).find("td:eq(4)").find("input:eq(1)").val().trim());
										});
								}			
						
								$("#totalFee1").val(totalFee1+"");
								$("#totalFee3").val(totalFee3+"");
					}
});




$(document).ready(function (){
	

	
	
	/*

1��188�ײ�Ҫ�󿪻�Ԥ����200Ԫ��288�ײͿ���Ԥ�����300Ԫ
3��238�ײ�Ҫ�󿪻�Ԥ����200Ԫ��


188�ײ��ʷѷ�Χ 

58105 ������ �����258Ԫ�ײ�      01	������               
58106 �������                    02	�������            
58107 ĵ����                      03	ĵ����              
58108 ��ľ˹                      04	��ľ˹              
58109 ˫Ѽɽ                      05	˫Ѽɽ              
58110 ��̨��                      06	��̨��              
58111 ����                        07	����                
58112 �׸�                        08	�׸�                
58113 ����                        09	����                
58114 �ں�                        10	�ں�                
58115 �绯                        11	�绯                
58116 ���˰���                    12	���˰���            
58117 ����                        13	����                

288�ײ��ʷѷ�Χ

58118 ������ �����458Ԫ�ײ�     01	������               
58119 �������                   02	�������            
58120 ĵ����                     03	ĵ����              
58121 ��ľ˹                     04	��ľ˹              
58122 ˫Ѽɽ                     05	˫Ѽɽ              
58123 ��̨��                     06	��̨��              
58124 ����                       07	����                
58125 �׸�                       08	�׸�                
58126 ����                       09	����                
58127 �ں�                       10	�ں�                
58128 �绯                       11	�绯                
58129 ���˰���                   12	���˰���            
58130 ����                       13	����                
	*/

	var fee_88 = 0;
	
		
	var offerId_88 = "<%=offerId_88%>";
	var regCode_88 = "<%=regCode_88%>";
	

	if(offerId_88=="58105"&&regCode_88=="01"){
			fee_88 = "200";
	}
	
	if(offerId_88=="58106"&&regCode_88=="02"){
			fee_88 = "200";
	}
	
	if(offerId_88=="58107"&&regCode_88=="03"){
			fee_88 = "200";
	}
	
	if(offerId_88=="58108"&&regCode_88=="04"){
			fee_88 = "200";
	}
	
	if(offerId_88=="58109"&&regCode_88=="05"){
			fee_88 = "200";
	}
	
	if(offerId_88=="58110"&&regCode_88=="06"){
			fee_88 = "200";
	}
	
	if(offerId_88=="58111"&&regCode_88=="07"){
			fee_88 = "200";
	}
	
	if(offerId_88=="58112"&&regCode_88=="08"){
			fee_88 = "200";
	}
	
	if(offerId_88=="58113"&&regCode_88=="09"){
			fee_88 = "200";
	}
	
	if(offerId_88=="58114"&&regCode_88=="10"){
			fee_88 = "200";
	}
	
	if(offerId_88=="58115"&&regCode_88=="11"){
			fee_88 = "200";
	}
	
	if(offerId_88=="58116"&&regCode_88=="12"){
			fee_88 = "200";
	}
	
	if(offerId_88=="58117"&&regCode_88=="13"){
			fee_88 = "200";
	}
	
	
	
	
	if(offerId_88=="58118"&&regCode_88=="01"){
			fee_88 = "300";
	}
	
	if(offerId_88=="58119"&&regCode_88=="02"){
			fee_88 = "300";
	}

	if(offerId_88=="58120"&&regCode_88=="03"){
			fee_88 = "300";
	}	
	
	if(offerId_88=="58121"&&regCode_88=="04"){
			fee_88 = "300";
	}
	
	if(offerId_88=="58122"&&regCode_88=="05"){
			fee_88 = "300";
	}
	
	
	if(offerId_88=="58123"&&regCode_88=="06"){
			fee_88 = "300";
	}
	
	if(offerId_88=="58124"&&regCode_88=="07"){
			fee_88 = "300";
	}
	
	if(offerId_88=="58125"&&regCode_88=="08"){
			fee_88 = "300";
	}
	
	if(offerId_88=="58126"&&regCode_88=="09"){
			fee_88 = "300";
	}
	
	if(offerId_88=="58127"&&regCode_88=="10"){
			fee_88 = "300";
	}
	
	if(offerId_88=="58128"&&regCode_88=="11"){
			fee_88 = "300";
	}
	
	if(offerId_88=="58129"&&regCode_88=="12"){
			fee_88 = "300";
	}
	
	if(offerId_88=="58130"&&regCode_88=="13"){
			fee_88 = "300";
	}
	 
	
						if(fee_88!=""){
								var totalFee1 = 0;
								var totalFee3 = 0;
								
								for( var k = 0 ; k < servOrderNoArray.length;k++){
										var tab_name =  "#tbl"+servOrderNoArray[k];
										$(tab_name).find("tr:gt(0)").each(function(){
											//alert($(this).html());
											var t_name = $(this).find("td:eq(1)").find("input:eq(1)").val();
											if( t_name=="����Ԥ���"){
													$(this).find("td:eq(2)").html(fee_88);
													$(this).find("td:eq(4)").find("input:eq(0)").val(fee_88);
													$(this).find("td:eq(4)").find("input:eq(1)").val(fee_88);
											}
												totalFee1 = totalFee1 + Number($(this).find("td:eq(2)").html().trim());
												totalFee3 = totalFee3 + Number($(this).find("td:eq(4)").find("input:eq(1)").val().trim());
										});
								}			
						
								$("#totalFee1").val(totalFee1+"");
								$("#totalFee3").val(totalFee3+"");	
						}		
});	



</script>
     <!--ͨ���ͻ�������Ų�ѯ�ͻ�����״̬ -->
     <%
     	long startTime2 = System.currentTimeMillis();
     	System.out.println("------------------custOrderId---------------------"+custOrderId);
     %>
<%String regionCode_sQCustOrderInfo = (String)session.getAttribute("regCode");%>
     <wtc:utype name="sQCustOrderInfo" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode_sQCustOrderInfo%>">
          <wtc:uparam value="<%=custOrderId%>" type="STRING"/>      
     </wtc:utype>
<%
		long endTime2 = System.currentTimeMillis();
		System.out.println("...................���ö���״̬��ѯ��ʱ��Ϊ:  " + endTime2 +"-" + startTime2 + " =="+(endTime2-startTime2));

       retCode_046 = retVal.getValue(0);
       retMsg_046 = retVal.getValue(1);
       
      System.out.println("------------------retCode_046---------------------"+retCode_046);
			System.out.println("------------------retMsg_046----------------------"+retMsg_046);
			
     if(!retCode_046.equals("0")){
%>
<script>
       rdShowMessageDialog("��ѯ�ͻ�����״̬��Ϣʧ�ܣ�",0);	   
       window.history.go(-1);
</script>
<%
     }
     System.out.println();
     String feeStatus = retVal.getValue("2.1.0");//�ɷ�״̬,0δ�ɷ�,1�ѽɷ�,2���ֽɷ�
     if(feeStatus.equals("0")){
          feeStatus = "δ�ɷ�";
     }else if(feeStatus.equals("1")){
          feeStatus = "�ѽɷ�";     
     }else{
         feeStatus = "���ֽɷ�";    
     }
%>

<div id = "operation">
  <FORM action="" method="post" name="form1" id="Form" >
<%@ include file="/npage/include/header.jsp" %>  

     <div class="title"><div id="title_zi">�ͻ�������Ϣ</div></div>
     <%@ include file="/npage/common/qcommon/bd_0002.jsp" %>
</div>
<div id="Operation_Table">
     <div class="title"><div id="title_zi">δ�ɷѶ���</div></div>
     <div class="list">
     <table  cellSpacing=0>
     	<tr>
     		<th>ѡ��</th><th>�ͻ��������</th><th>����Ӫҵ��</th><th>��������ʱ��</th><th>����״̬</th><th>������</th><th>�ɷ�״̬</th>
     	</tr>
     	<tr>
     		<td><input type="radio" checked disabled="true" name="sCustOrderId" id="sCustOrderId" value="<%=custOrderId%>" onclick="FeeCheck()">1</td>
     		<td><%=custOrderId%></td> 
     		<td><%=retVal.getValue("2.0.1")%></td>
     		<td><%=retVal.getValue("2.0.3")%></td>
     		<td><%=retVal.getValue("2.0.4")%></td>
     		<td><%=retVal.getValue("2.0.5")%></td>
     		<td><%=feeStatus%></td>	
     	</tr>
     </table>
     </div>
     </div>
<div id="Operation_Table">
     <div class="title"><div id="title_zi">�ͻ���������</div></div>
     <div class="list">
          <table  cellSpacing=0 id="listdiv2">
               <tr>
                    <th>�ͻ��������</th>
                    <th>�ͻ�����������</th>
                    <th>ҵ���������</th>
                    <th>����Ʒ</th>
                    <th>��������״̬</th> 
                    <th>����ʱ��</th>
                    <th>����Ա��</th>
               </tr>                                                                        
          </table> 
     </div>
     
     
     </div>
<div id="Operation_Table">
     <div class="title"><div id="title_zi">���񶨵���Ϣ</div></div>
		<div class="list" id="tbl1">
          <table  cellSpacing=0 id="servtbl">
          	<tr>
          		 <th>���񶨵���</th><th>�ͻ����������</th><th>ҵ�����</th><th style="display:none">�û�����</th><th>��������</th><th>�ɷ�״̬</th> 
          	</tr> 
          </table>
     </div>
</div>
<div id="Operation_Table">
    <div class="title"><div id="title_zi">ѡ�����ÿ�Ŀ</div></div>
     <div class="list" id="tbl2">
     	 <table  cellSpacing=0 id="feetbl">
                 <tr>
                 	 <th>���񶨵���</th>
                   <th>���ÿ�Ŀ</th>
                   <th>Ӧ�ս��</th>
                   <th  style=\"display:none\">�Żݽ��</th>
                   <th>ʵ�ս��</th>
                   
                   <th>��ȡ��ʽ</th>
                   <th>��ӡ</th>
                   <th>˵��</th>
                 </tr>            
               </table>
     </div>
	<div class="search">
		<table cellSpacing=0>
		  <tr>
			<td class=blue>Ӧ���ܶ�</td>
			<td>
                    <input type="text" name="totalFee1" class='forMoney required' vflag=1  id="totalFee1" size="15" readonly="true" />
               </td>
               
               <td class=blue>ʵ���ܶ�</td>
            	<td>
                    <input type="text" name="totalFee3" class='forMoney required' vflag=1  id="totalFee3" size="15" readonly="true" />
               </td>
                    <input type="hidden" name="totalFee2"  vflag=1  id="totalFee2" size="15" readonly="true"   />
		   </tr>
		   <TR  > 
                  <TD nowrap   class=blue > 
                    <div align="left">���ʽ</div>
                  </TD>
                  <TD nowrap  style="width:150px"> 
                  	<%
                  	/*ningtn Ӫҵǰ̨Ԥ������ӪҵԱ���п���������pay_type��¼Ϊ0���г����Ͳ����Ͽɡ�*/
                  	if(!"g784".equals(opcodeadd) && !"m028".equals(opcodeadd) && !"m094".equals(opcodeadd)){
                  	%>
                    &nbsp;<input name="checkRadio"  v_disab_attr="1" type="radio" onclick="checkWay()" value="check"  index="48">
                    ֧Ʊ���� <br>	
                    <%}%>
                    &nbsp;<input type="radio"   v_disab_attr="1"  name="NocheckRadio" onClick="NocheckWay()" value="nocheck" checked index="49">
                    ��֧Ʊ���� 
                    <%
                  	if(!"g784".equals(opcodeadd) && !"m028".equals(opcodeadd) && !"m094".equals(opcodeadd)){
                  	%>
                   <!-- ningtn 20100201 tianyang add for pos --><br>
					&nbsp;<input name="ccb" type="radio"   v_disab_attr="1"  onclick="checkCCB()" value="ccb"  index="50">��������POS������<br>					      
				    &nbsp;<input name="icbc" type="radio"   v_disab_attr="1"  onClick="checkICBC()" value="icbc" index="51">��������POS������
				    <%}%>
				    <%if("Y".equals(isJTTFflag)){%>
				    <br>
				    &nbsp;<input name="jtzhtf" id="jtzhtf" type="radio"     onclick="checkjtzhtf()"  value="111111"  >ͳ���˻�ת�˽���<font color="red">����ͳ���˺�ת�ˣ������û��ֽ�</font>
				    <%}%>
				    
                  </TD>
                  <td  style="width:190px">
                  	<div id="icbcInsDiv" style="display:none">
	                  	���ڸ���������	<br>
	                  	<input type="text" name="icbcInstNum" id="icbcInstNum"  readOnly size="10" class="InputGrey" />
	                  	<br>
	                  	<font class="orange" >��Ӫ�����շѷ�ʽ����Ϊ���ڸ���</font> 
                  	</div>
                  </td>
                  <td>&nbsp;</td>
          </tr>
		</table>
		    
		    <TABLE id=check0  cellSpacing="0" style="display:none">
                <TBODY> 
                <TR > 
                  <TD  nowrap class=blue   width=15%> 
                    <div align="left">֧Ʊ����</div>
                  </TD>
                  <TD  nowrap   width=35%> 
                    <input class="button" v_must=0 v_name="֧Ʊ����" v_type="0_9" name=checkNo maxlength=20 onkeyup="if(event.keyCode==13)getBankCode();" index="50">
                    <font color="red">*</font>
								<input name=bankCodeQuery type=button class="b_text" style="cursor:hand" onClick="getBankCode()" value=��ѯ>
            </TD>
                  <TD nowrap class=blue   width=15%> 
                    <div align="left">���д���</div>
                  </TD>
                  <TD  nowrap   width=35%> 
                    <input name=bankCode  class="button" maxlength="12" readonly Class="InputGrey" size="8">
				<input name=bankName  class="button" readonly Class="InputGrey">
                  </TD>                                              
            </TR>
           </TBODY>
         </TABLE>
        <TABLE id=chPayNum0  cellSpacing="0" style="display:none">
          <TBODY> 
            <TR> 
                  <TD  nowrap class=blue width="15%"> 
                    <div align="left">֧Ʊ����</div>
                  </TD>
            <TD  width="35%">
              	    <input class="button" v_must=1 v_type=money v_account=subentry name=checkPay value=0.00 maxlength=15 onkeyup="getpreFee()" index="51" onblur="checkElement(this)">
                    <font color="red">*</font> </TD> 
                  <TD  class=blue width="15%"> 
                    <div align="left">֧Ʊ���</div>
                  </TD>
                  <TD  width="35%"> 
                    <input class="button" name="checkPrePay" value=0.00 readonly Class="InputGrey">
                  </TD>               
            </TR>            
          </TBODY>
        </TABLE>
         
     </div>
     </div>
<div id="Operation_Table">
 	<div class="title"><div id="title_zi">��ע��Ϣ</div></div> 
 	<div class="input">	
			<table cellSpacing=0>
		 
				<tr>
					<td class=blue>�û���ע</td>
					<td colspan="3">
							<input type="hidden" size="100"  value="" name="op_note" id="op_note"/>
							<input type="text" size="100" maxlength="100"  value=""  name="sys_note" id="sys_note" readOnly class="InputGrey"  />
					</td>
				</tr>			
				<tr>
					<td id=footer colspan=4>
						<div id="operation_button">
	<input type="button" class="b_foot_long" name="b_pay_way" value="ͬ����ȡ��ʽ" onclick="changeAll('feeWay')" style="display:none"/>
	<input type="button" class="b_foot_long" name="b_is_print" value="ͬ����ӡ��ʽ" onclick="changeAll('isPrint')" style="display:none"/>
		<input type="button" class="b_foot_long" name="BAddOtherFee" value="��������" onClick="addType()" style="display:none"/>
		<input type="hidden"  value="<%=offeridkd%>">
    <input type="button" class="b_foot_long" name="fee_submit" id="fee_submit"  onclick="submit_cfm()"   value="�շѴ���" />
   <input class="b_foot" name=confirm  type=button index="8" value="����" onclick="commitJsp3('q034','����')" onkeydown="if(event.keyCode==13){}">
   <%if(opcodeadd.equals("4100")){%>
   	<input class="b_foot_long" name=confirm  type=button index="8" value="��ѯ��ʡ�������" onclick="show4100Page()">
   <%}%>
</div>
					</td>
				</tr>	 
			</table>
		</div>	
</div>

	<%@ include file="/npage/include/footer.jsp" %>
	<input type="hidden" name="arrayOrder" id="arrayOrder" value="">
	<input type="hidden" name="servOrder" id="servOrder" value="">
	<input type="hidden" name="feeStr" id="feeStr" value="">
	<input type="hidden" name="custOrderId" id="custOrderId" value="<%=custOrderId%>">
	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" id="opName" value="<%=opName%>">
	<input type="hidden" name="gCustId" id="opName" value="<%=gCustId%>">
	<input type="hidden" name="feeWay" id="feeWay" value="0">
	<input type="hidden" name="isPrint" id="isPrint" value="0">
	<input type="hidden" name="prtAccpetLoginStr" id="prtAccpetLoginStr" value="0">
	<input type="hidden" name="payFeeAfter" id="payFeeAfter" value="0">
	
	<!-- tianyang add at 20100201 for POS�ɷ�����*****start*****-->	
	<input type="hidden" id="iInstNum" name="iInstNum" value=""/>		
	<input type="hidden" name="payType"  value=""><!-- �ɷ����� payType=BX �ǽ��� payType=BY �ǹ��� -->			
	<input type="hidden" name="MerchantNameChs"  value=""><!-- �Ӵ˿�ʼ����Ϊ���в��� -->
	<input type="hidden" name="MerchantId"  value="">
	<input type="hidden" name="TerminalId"  value="">
	<input type="hidden" name="IssCode"  value="">
	<input type="hidden" name="AcqCode"  value="">
	<input type="hidden" name="CardNo"  value="">
	<input type="hidden" name="BatchNo"  value="">
	<input type="hidden" name="Response_time"  value="">
	<input type="hidden" name="Rrn"  value="">
	<input type="hidden" name="AuthNo"  value="">
	<input type="hidden" name="TraceNo"  value="">
	<input type="hidden" name="Request_time"  value="">
	<input type="hidden" name="CardNoPingBi"  value="">
	<input type="hidden" name="ExpDate"  value="">
	<input type="hidden" name="Remak"  value="">
	<input type="hidden" name="TC"  value="">
	<!-- tianyang add at 20100201 for POS�ɷ�����*****end*******-->
	<input type="hidden" name="broadNo" id="broadNo" value="">
</form>
</div>

<!-- **** tianyang add for pos ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/sq046/posCCB.jsp" %>
<!-- **** tianyang add for pos ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/sq046/posICBC.jsp" %>

</body>
</html>
<%
		endTime1 = System.currentTimeMillis();
	 	System.out.println("...................��������ʱ��Ϊ:  " + endTime1 +"-" + beginTime1 + " =="+(endTime1-beginTime1));	
	 	
	 	long totalend =  System.currentTimeMillis();
	 	System.out.println("...................��ʱ��:  " + totalend +"-" + totalBegin + " =="+(totalend-totalBegin));	
	 	
}%>
     
