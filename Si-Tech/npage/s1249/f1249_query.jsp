

<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-16 页面改造,修改样式
********************/
%>

<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String regionCode = (String)session.getAttribute("regCode");
        	//得到输入参数
        
		//ArrayList str = new ArrayList();
		//String temp[][]=new String[][]{};
		String retCode = "0";
		String retMessage="";
		String smCode="";
		
		String note="";
		String cardNo="";
		String yuan="";       //paycard_fee 优惠项目元
		String arrContent = "";//性别+月薪水平+业务种类+话费支付方式+寄送帐单+优惠项目+金卡领取形式+更换STK卡＋赠送体验卡
		String personalLike="";
		String email="";
		String phoneType="";
		String fPostalcode="";
		String familyAddr="";
		String uPostalcode="";
		String unitAddr="";
		String contactPhone="";
		String businessType="";
		String occupation="";
		String IDNo="";
		String registerTime="";
		String custName="";
		String vipNo="";
		String businessTypeName="";
		String occupationName="";
		//--------------------------
		String retType = request.getParameter("retType");
		String phoneNo = request.getParameter("phoneNo");
		String org_code = request.getParameter("org_code"); 
		String opCode = request.getParameter("opCode"); 
		String loginNo = request.getParameter("loginNo"); 
		String opFlag = request.getParameter("opFlag");
		String serviceName = "s1249_Valid";
	try{
		System.out.println("-------query.jsp----------------");
		System.out.println("---retType---" + retType);
		System.out.println("---phoneNo---" + phoneNo);
		System.out.println("---org_code---" + org_code);
		System.out.println("---opCode---" + opCode);
		System.out.println("---loginNo---" + loginNo);
		System.out.println("----opFlag---" + opFlag);
		System.out.println("----serviceName--" + serviceName);

		String[] paraStrIn = new String[]{loginNo,phoneNo,opCode,org_code,opFlag};
		String outParaNums= "26";   
		//SPubCallSvrImpl callSvrImpl = new SPubCallSvrImpl();
		//str = callSvrImpl.callFXService(serviceName, paraStrIn, outParaNums);
	%>
		<wtc:service name="s1249_Valid" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="26" >				
				<wtc:param value="<%=loginNo%>"/>	
				<wtc:param value="<%=phoneNo%>"/>	
				<wtc:param value="<%=opCode%>"/>	
				<wtc:param value="<%=org_code%>"/>	
				<wtc:param value="<%=opFlag%>"/>		
		</wtc:service>			
		<wtc:array id="temp"  scope="end"/>	
	<%
		if(temp!=null&&temp.length>0){
			retCode = temp[0][0];
	       		retMessage =temp[0][1];
	       		
			System.out.println("11111111111111111111111111111=");		
			System.out.println("------retCodeannananana-------" + retCode );
			System.out.println("------retMessageanannanan----" + retMessage);
			
			//temp=(String[][])str.get(3);
			smCode=temp[0][3];
			System.out.println("smCode="+smCode);
			//temp=(String[][])str.get(25);
			businessTypeName=temp[0][25];//职务类别名字
			System.out.println("businessTypeName"+businessTypeName);
			//temp=(String[][])str.get(24);
			occupationName=temp[0][24];//职业名字
			System.out.println("occupationName"+occupationName);
			//temp=(String[][])str.get(23);
			note=temp[0][23];
			System.out.println("note"+note);
			//temp=(String[][])str.get(22);
			cardNo=temp[0][22];
			System.out.println("cardNo"+cardNo);
			//temp=(String[][])str.get(21);
			yuan=temp[0][21];       //paycard_fee 优惠项目元
			System.out.println("yuan"+yuan);
			//temp=(String[][])str.get(20);
			arrContent = temp[0][20];//性别+月薪水平+业务种类+话费支付方式+寄送帐单+优惠项目+金卡领取形式+更换STK卡＋赠送体验卡
			System.out.println("arrContent"+arrContent);
			//temp=(String[][])str.get(19);
			personalLike=temp[0][19];
			//temp=(String[][])str.get(18);
			email=temp[0][18];
			System.out.println("----email--"+email);
			//temp=(String[][])str.get(17);
			phoneType=temp[0][17];
			//temp=(String[][])str.get(16);
			fPostalcode=temp[0][16];
			//temp=(String[][])str.get(15);
			familyAddr=temp[0][15];
			//temp=(String[][])str.get(14);
			uPostalcode=temp[0][14];
			//temp=(String[][])str.get(13);
			unitAddr=temp[0][13];
			//temp=(String[][])str.get(12);
			contactPhone=temp[0][12];
			//temp=(String[][])str.get(11);
			businessType=temp[0][11];
			System.out.println("---businessType"+businessType);
			//temp=(String[][])str.get(10);
			occupation=temp[0][10];
			System.out.println("---occupation"+occupation);
			//temp=(String[][])str.get(9);
			IDNo=temp[0][9];
			//temp=(String[][])str.get(8);
			registerTime=temp[0][8];
			System.out.println("---registerTime"+registerTime);
			//temp=(String[][])str.get(7);
			custName=temp[0][7];
			System.out.println("custName="+custName);
			//temp=(String[][])str.get(6);
			vipNo=temp[0][6];
			System.out.println("vipNo="+vipNo);
			
		}
		}catch(Exception e){
			
		}
%>
var response = new AJAXPacket();
var retType = "<%=retType%>";
var retCode = "<%=retCode%>";
var retMessage = "<%=retMessage%>";
var smCode="<%=smCode%>";

var note="<%=note%>";
var cardNo="<%=cardNo%>";
var yuan="<%=yuan%>";
var arrContent="<%=arrContent%>";
var personalLike="<%=personalLike%>";
var email="<%=email%>";
var phoneType="<%=phoneType%>";
var fPostalcode="<%=fPostalcode%>";
var familyAddr="<%=familyAddr%>";
var uPostalcode="<%=uPostalcode%>";
var unitAddr="<%=unitAddr%>";
var contactPhone="<%=contactPhone%>";
var businessType="<%=businessType%>";
var businessTypeName="<%=businessTypeName%>";
var occupation="<%=occupation%>";
var occupationName="<%=occupationName%>";
var IDNo="<%=IDNo%>";
var registerTime="<%=registerTime%>";
var custName="<%=custName%>";
var vipNo="<%=vipNo%>";


response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("smCode",smCode);

response.data.add("note",note);
response.data.add("cardNo",cardNo);
response.data.add("yuan",yuan);
response.data.add("arrContent",arrContent);
response.data.add("personalLike",personalLike);
response.data.add("email",email);
response.data.add("phoneType",phoneType);
response.data.add("fPostalcode",fPostalcode);
response.data.add("familyAddr",familyAddr);
response.data.add("uPostalcode",uPostalcode);
response.data.add("unitAddr",unitAddr);
response.data.add("contactPhone",contactPhone);
response.data.add("businessType",businessType);
response.data.add("businessTypeName",businessTypeName);
response.data.add("occupation",occupation);
response.data.add("occupationName",occupationName);
response.data.add("IDNo",IDNo);
response.data.add("registerTime",registerTime);
response.data.add("custName",custName);
response.data.add("vipNo",vipNo);
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                           