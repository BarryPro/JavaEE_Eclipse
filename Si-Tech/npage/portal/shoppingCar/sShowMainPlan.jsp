<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
	String custOrderId = request.getParameter("custOrderId");
	String custOrderNo = request.getParameter("custOrderNo");
	String prtFlag = request.getParameter("prtFlag");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
%>

<wtc:utype name="sShowMainPlan" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode%>" >
      <wtc:uparam value="<%=custOrderId%>" type="String"/>
</wtc:utype>
<%
System.out.println("====wanghfa");
		StringBuffer logBuffer046 = new StringBuffer(80);
		WtcUtil.recursivePrint(retVal,1,"2",logBuffer046);
		System.out.println(logBuffer046.toString());
	  String retCode  =retVal.getValue(0);
	  String retMsg	  =retVal.getValue(1);
    System.out.println("# ---- "+retCode+" || "+retMsg);
		String sData = ""; //显示在操作向导中的内容
		String status = "";//状态
		String funciton_code = "";
		String funciton_add = "";
		String funciton_name = "";
		String pageUrl = "";
		String offerSrvId = ""; //新装-新装销售品实例ID;客户服务-idNo
		String num = "";				//数量
		String offerId  = "";		//销售品ID
		String offerName  = ""; //销售品名称
		String phoneNo  = "";		//真实业务号码
		String sitechPhoneNo  = "";		//sitech虚拟号码
		String orderArrayId = "";	//客户订单子项ID
		String servOrderId = "";//服务订单ID
		String servBusiId = "";//服务提供
		String validVal="";    //是否验证
		String openWay="";     //打开方式
		if(retCode.equals("0"))
		{
			String orderPos=retVal.getValue("2.0.0");
			String servPos =retVal.getValue("2.0.1");
			String custOrderStatus = retVal.getValue("2.0.2");//客户订单状态
			System.out.println("gaopeng-orderPos---|"+orderPos);
			System.out.println("gaopeng-servPos---|"+servPos);
			System.out.println("gaopeng-custOrderStatus---|"+custOrderStatus);
			if(servPos.equals("-1")&&!orderPos.equals("-1"))
			{
					status=retVal.getValue("2.1.0."+orderPos+".0");
					funciton_code=retVal.getValue("2.1.0."+orderPos+".1");
					funciton_name=retVal.getValue("2.1.0."+orderPos+".2");
					pageUrl=retVal.getValue("2.1.0."+orderPos+".3");
					offerSrvId=retVal.getValue("2.1.0."+orderPos+".4");
					offerId=retVal.getValue("2.1.0."+orderPos+".5");
					offerName=retVal.getValue("2.1.0."+orderPos+".6");
					num=retVal.getValue("2.1.0."+orderPos+".7");
					orderArrayId=retVal.getValue("2.1.0."+orderPos+".8");
					phoneNo=retVal.getValue("2.1.0."+orderPos+".9");
					servOrderId=retVal.getValue("2.1.0."+orderPos+".10");
					servBusiId=retVal.getValue("2.1.0."+orderPos+".11");
					sitechPhoneNo=retVal.getValue("2.1.0."+orderPos+".12");
			}
			
			else if (("-1").equals(orderPos))
			{
			/*2013/07/04 10:11:41 待收费状态的订单，直接进入q046，但是opcodeadd传不进去*/
				if(custOrderStatus.equals("11"))
				{
						if(retVal.getUtype("2.1.0").getSize() > 0){
							funciton_add = retVal.getValue("2.1.0.0.1");
						}
						System.out.println("ntnlog-funciton_add---|"+funciton_add);
						funciton_code = "q046";
						funciton_name="统一缴费";
						pageUrl="sq046/fq046.jsp";
					
				}else if(custOrderStatus.equals("12"))
				{
					funciton_code = "q025";
					funciton_name="客户订单审核";
					pageUrl="sq025/fq025.jsp";
				}
			}else
			{
					status = retVal.getValue("2.1.0."+orderPos+".13.0."+servPos+".0");
					funciton_code = retVal.getValue("2.1.0."+orderPos+".13.0."+servPos+".1");
					funciton_name = retVal.getValue("2.1.0."+orderPos+".13.0."+servPos+".6");
					pageUrl = retVal.getValue("2.1.0."+orderPos+".13.0."+servPos+".3");
					offerSrvId=retVal.getValue("2.1.0."+orderPos+".13.0."+servPos+".4");
					offerId=retVal.getValue("2.1.0."+orderPos+".13.0."+servPos+".5");
					offerName=retVal.getValue("2.1.0."+orderPos+".13.0."+servPos+".6");
					num=retVal.getValue("2.1.0."+orderPos+".13.0."+servPos+".7");
					orderArrayId=retVal.getValue("2.1.0."+orderPos+".13.0."+servPos+".8");
					phoneNo=retVal.getValue("2.1.0."+orderPos+".13.0."+servPos+".9");
					servOrderId=retVal.getValue("2.1.0."+orderPos+".13.0."+servPos+".10");
					servBusiId=retVal.getValue("2.1.0."+orderPos+".13.0."+servPos+".11");
					sitechPhoneNo=retVal.getValue("2.1.0."+orderPos+".13.0."+servPos+".12");
			}
			validVal = retVal.getValue("2.2.0.0");
			openWay = retVal.getValue("2.2.0.1");
			System.out.println("====wanghfa====sShowMainPlan.jsp==== validVal = " + validVal);
			System.out.println("====wanghfa====sShowMainPlan.jsp==== openWay = " + openWay);
			
			int o_size = retVal.getSize("2.1.0");
			String o_status ="";
			String s_status ="";
			String stat= "";
			
			boolean o_firstFlag = true;
			for(int i=0;i<o_size;i++)
			{
				o_status = retVal.getValue("2.1.0."+i+".0");
				
				if(o_status.equals("10")&&o_firstFlag)//当前
				{
						stat = "on";
						o_firstFlag=false;
				}else if(o_status.equals("10")&&!o_firstFlag)//未处理
				{
					stat = "";
				}else//已处理
				{
					stat = "dealed";
				}
				sData+="<dt class='"+stat+"'>"+retVal.getValue("2.1.0."+i+".6")+"["+retVal.getValue("2.1.0."+i+".2")+"]</dt>";

				int s_size = retVal.getSize("2.1.0."+i+".13.0");
			
				for(int j=0;j<s_size;j++)
				{
					s_status = retVal.getValue("2.1.0."+i+".13.0."+j+".0");
					
					if(s_status.equals("100"))//当前
					{
						stat = "on";
					}else if(s_status.equals("0"))//未处理
					{
						stat = "";
					}else //已处理
					{
						stat = "dealed";
					}
				
				sData+="<dd class='"+stat+"'>"+retVal.getValue("2.1.0."+i+".13.0."+j+".6")+"["+retVal.getValue("2.1.0."+i+".13.0."+j+".2")+"]</dd>";
				}
			}
		}
		
		/*2016/4/12 16:53:56 gaopeng 查询该offer_id是否是宽带包年0元资费
			如果选择的主资费是宽带包年主资费并且包年预存款为0元，则宽带开户与“新营销执行(g794)”必须通过购物车一起办理
		*/
		String is0flag = "false";
		String[] inParamsss1 = new String[2];
    inParamsss1[0] = "select b.offer_id,b.offer_name,b.offer_attr_type,b.offer_comments from product_offer_attr a,product_offer b where a.offer_attr_seq ='5070' and a.offer_id = b.offer_id and a.offer_attr_value='0' and b.eff_date<sysdate and b.exp_date>sysdate and b.offer_attr_type ='YnKB' and b.offer_id=:bofferid";
    inParamsss1[1] = "bofferid="+offerId;
    
    /*查询68折里面0元的资费*/
    String[] inParamsss2 = new String[2];
    inParamsss2[0] = 
	   "select count(1) "
		+"  from product_offer_attr a, product_offer b "
		+" where 1 = 1 "
		+"   and a.offer_id = b.offer_id "
		+"   and a.offer_attr_seq in ('80009', '80010') "
		+"   and a.offer_id in "
		+"       (select a.offer_id "
		+"          from product_offer_attr a, product_offer b "
		+"         where 1 = 1 "
		+"           and a.offer_id = b.offer_id "
		+"           and a.offer_attr_value = '0' "
		+"           and a.offer_attr_seq in ('5070')) "
		+"   and a.offer_id = :bofferid ";
    inParamsss2[1] = "bofferid="+offerId;
    
		
		
%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="3">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>
	</wtc:service>
	<wtc:array id="result0y" scope="end" />
		
 <%
	 if(result0y.length>0) {
	 /*2016/4/12 15:16:01 gaopeng 0元的包年资费不进行营销案流水校验了 原来在这里是进行 is0flag="true";*/
	 	is0flag="yes";
	 }
	 System.out.println("is0flag======="+is0flag);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="3">     
  <wtc:param value="<%=inParamsss2[0]%>"/>
  <wtc:param value="<%=inParamsss2[1]%>"/>
  </wtc:service>
  <wtc:array id="result68y" scope="end" />
  <%
   if(!"0".equals(result68y[0][0])) {
   	/*6 8 折里面的0元资费 也赋值is0flag 为 yes*/
    is0flag="yes";
   }
   System.out.println("is0flag======="+is0flag);
   
   
   String[] gundongyueArr = new String[2];
   gundongyueArr[0] = "SELECT count(1) FROM product_offer_attr WHERE offer_id =:offerId and offer_attr_seq = 70009";
   gundongyueArr[1] = "offerId="+offerId;
   String gundongyueFlag = "0";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="gundongyueCode" retmsg="gundongyueMsg" outnum="1">			
	<wtc:param value="<%=gundongyueArr[0]%>"/>
	<wtc:param value="<%=gundongyueArr[1]%>"/>
</wtc:service>
<wtc:array id="gundongyueReslut" scope="end" />
<%
	if(gundongyueReslut.length!=0){
		gundongyueFlag = gundongyueReslut[0][0]; //大于0是滚动月包年  为0就不是滚动月包年
	}
%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","error");
response.data.add("sData","<%=sData%>");
response.data.add("status","<%=status%>");
response.data.add("custOrderId","<%=custOrderId%>");
response.data.add("custOrderNo","<%=custOrderNo%>");
response.data.add("funciton_code","<%=funciton_code%>");
response.data.add("funciton_add","<%=funciton_add%>");
response.data.add("funciton_name","<%=funciton_name%>");
response.data.add("pageUrl","<%=pageUrl%>");
response.data.add("offerSrvId","<%=offerSrvId%>");
response.data.add("num","<%=num%>");
response.data.add("offerId","<%=offerId%>");
response.data.add("offerName","<%=offerName%>");
response.data.add("phoneNo","<%=phoneNo%>");
response.data.add("sitechPhoneNo","<%=sitechPhoneNo%>");
response.data.add("orderArrayId","<%=orderArrayId%>");
response.data.add("servOrderId","<%=servOrderId%>");
response.data.add("prtFlag","<%=prtFlag%>");
response.data.add("servBusiId","<%=servBusiId%>");
response.data.add("validVal","<%=validVal%>");
response.data.add("openWay","<%=openWay%>");
response.data.add("is0flag","<%=is0flag%>");
response.data.add("gundongyueFlag","<%=gundongyueFlag%>");
core.ajax.receivePacket(response);