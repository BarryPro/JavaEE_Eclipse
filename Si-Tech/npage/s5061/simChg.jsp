 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-12 ҳ�����,�޸���ʽ
	********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%

	String phoneNo = request.getParameter("phoneNo");
	String opCode = request.getParameter("opCode");
 	String loginNo = (String)session.getAttribute("workNo");
	String regionCode= (String)session.getAttribute("regCode");
	//SPubCallSvrImpl co = new SPubCallSvrImpl();
	String inputParsm [] = new String[3];
	inputParsm[0] = loginNo;
	inputParsm[1] = phoneNo;
	inputParsm[2] = opCode;
	%>
		<wtc:service name="s1445Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="28" >
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>			
		<wtc:param value="<%=%>"/>
		</wtc:service>
		<wtc:array id="cussidArr" scope="end"/>
	<%
	//String [] cussidArr=co.callService("s1445Init",inputParsm,"28");

	String retCode= retCode1;
	String retMsg = retMsg1;

	for(int ii=0;ii<cussidArr.length;ii++){
				for(int jj=0;jj<cussidArr[ii].length;jj++){
					System.out.println("cussidArr["+ii+"]["+jj+"]="+cussidArr[ii][jj]);
				}
		}

	String idNo="";//�û�id
	String smCode="";//ҵ�����ʹ���
	String smName="";//ҵ����������
	String belongCode="";//�ͻ�����
	String custName="";//�ͻ�����
	String userPassword="";//�û�����
	String runCode="";//״̬����
	String runName="";//״̬����
	String idName="";//֤������
	String idIccid="";//֤������
	String ownerGrade="";//�ȼ�����
	String gradeName="";//�ȼ�����
	String card_name="";//�ͻ�������
	String totalPrepay="";//��ǰԤ��
	String totalOwe="";//��ǰǷ��
	String card_code="";//��ͻ�����
	String card_no="";//VIP����
	String loginAccept="";// ��ˮ
	String transMoney = "";
	String  curModeCode = "";
	String  curModeName = "";
	String  nextModeCode = "";
	String  nextModeName="";
	String nextModeDate = "";
	String endPlanDate = "";
	String orderNode = "";
	String ownerAddress="";			  //�ͻ���ַ
	String iphoneNo="";				  //��ϵ�绰


	String rpcPage = "simChk";
	System.out.println(retCode);
	if(retCode.equals("000000")){	
	  	if(cussidArr!=null&&cussidArr.length>0){
			idNo= cussidArr[0][0];
			smCode= cussidArr[0][1];
			smName= cussidArr[0][2];
			belongCode= cussidArr[0][3];
			custName= cussidArr[0][4];
			userPassword= cussidArr[0][5];
			runCode= cussidArr[0][6];
			runName= cussidArr[0][7];
			idName= cussidArr[0][8];
			idIccid= cussidArr[0][9];
			ownerGrade= cussidArr[0][10];	  //�ͻ�����
			gradeName= cussidArr[0][11];
			card_name= cussidArr[0][12];
			totalPrepay= cussidArr[0][13];
			totalOwe= cussidArr[0][14];
			card_code= cussidArr[0][15];
			card_no= cussidArr[0][16];
			loginAccept = cussidArr[0][17];
			
			transMoney = cussidArr[0][18];
			curModeCode=cussidArr[0][19];
			curModeName=cussidArr[0][20];
			nextModeCode=cussidArr[0][21];
			nextModeName=cussidArr[0][22];
			nextModeDate=cussidArr[0][23];
			endPlanDate=cussidArr[0][24];
			orderNode=cussidArr[0][25];
			ownerAddress=cussidArr[0][26];		 //�ͻ���ַ
			iphoneNo=cussidArr[0][27];		 //��ϵ�绰
			System.out.println("AAAAA = " + orderNode);
		}
	}

	String cussidStr="";
%>

<%
	/******************new add*********************/	
	ArrayList retArray = new ArrayList();
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//String[][] resultx = new String[][]{};
	String goodbz="N";
	String modedxpay="";
	String sqlStr = "select mode_dxpay "+
  						 "from dgoodphoneres a, sGoodBillCfg b "+
 						 "where a.bill_code = b.mode_code "+
   						 "and b.region_code = '"+regionCode+"'"+
   						 "and a.phone_no = '"+phoneNo+"' and b.valid_flag='Y' and a.bak_field='1' and end_time>sysdate and b.mode_dxpay>0";
	
        
      	    //retArray = impl.sPubSelect("1",sqlStr); 
      	    %>
      	    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
	    </wtc:pubselect>
	   <wtc:array id="resultx" scope="end" />
      	    <%
      	    		System.out.println("resultx=============="+resultx.length);
      	    		System.out.println("sql=============="+sqlStr);
            		//resultx = (String[][])retArray.get(0);  
            		if(resultx!=null&&resultx.length>0)  {        		
				if(resultx[0][0].equals(""))
				{
					goodbz="N";
				}else{
					goodbz="Y";
					modedxpay = resultx[0][0];
					System.out.println("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
					System.out.println(modedxpay);
				}
			}
			System.out.println("========================end==========================");

%>
var response = new AJAXPacket();
var retCode = "<%=retCode%>";
var retMsg= "<%=retMsg%>";
var idNo= "<%=idNo%>";
var smCode= "<%=smCode%>";
var smName= "<%=smName%>";
var belongCode= "<%=belongCode%>";
var custName= "<%=custName%>";
var userPassword= "<%=userPassword%>";
var runCode= "<%=runCode%>";
var runName= "<%=runName%>";
var idName= "<%=idName%>";
var idIccid= "<%=idIccid%>";
var ownerGrade= "<%=ownerGrade%>";
var gradeName= "<%=gradeName%>";
var card_name= "<%=card_name%>";
var totalPrepay= "<%=totalPrepay%>";
var totalOwe= "<%=totalOwe%>";
var card_code= "<%=card_code%>";
var card_no= "<%=card_no%>";
var loginAccept = "<%=loginAccept %>";
var transMoney = "<%=transMoney %>";
var curModeCode = "<%=curModeCode %>";
var curModeName = "<%=curModeName %>";
var nextModeCode = "<%=nextModeCode %>";
var nextModeName = "<%=nextModeName %>";
var nextModeDate = "<%=nextModeDate %>";
var endPlanDate= "<%=endPlanDate %>";
var orderNode= "<%=orderNode %>";
var ownerAddress= "<%=ownerAddress %>";
var iphoneNo= "<%=iphoneNo%>";
var rpcPage = "<%=rpcPage%>";
var goodbz="<%=goodbz%>"
var modedxpay="<%=modedxpay%>"

response.data.add("rpc_page",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 
response.data.add("idNo",idNo); 
response.data.add("smCode",smCode); 
response.data.add("smName",smName); 
response.data.add("belongCode",belongCode); 
response.data.add("custName",custName); 
response.data.add("userPassword",userPassword); 
response.data.add("runCode",runCode); 
response.data.add("runName",runName); 
response.data.add("idName",idName); 
response.data.add("idIccid",idIccid); 
response.data.add("ownerGrade",ownerGrade); 
response.data.add("gradeName",gradeName); 
response.data.add("card_name",card_name); 
response.data.add("totalPrepay",totalPrepay); 
response.data.add("totalOwe",totalOwe); 
response.data.add("card_code",card_code); 
response.data.add("card_no",card_no); 
response.data.add("loginAccept",loginAccept); 
response.data.add("transMoney",transMoney); 
response.data.add("curModeCode",curModeCode); 
response.data.add("curModeName",curModeName); 
response.data.add("nextModeCode",nextModeCode); 
response.data.add("nextModeName",nextModeName); 
response.data.add("nextModeDate",nextModeDate); 
response.data.add("endPlanDate",endPlanDate);
response.data.add("orderNode",orderNode);
response.data.add("ownerAddress",ownerAddress);
response.data.add("iphoneNo",iphoneNo);
response.data.add("goodbz",goodbz);
response.data.add("modedxpay",modedxpay);
core.ajax.receivePacket(response);
