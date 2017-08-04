<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%
	String workNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	//String siteId = (String)session.getAttribute("siteId");
	String siteId = (String)session.getAttribute("groupId");
	//if(siteId==null) siteId = orgCode;
	String regionCode = orgCode.substring(0,2);
	
	String sData = request.getParameter("sData");
	String optorMsg = request.getParameter("optorMsg");
	String custId = request.getParameter("custId");
	String prtFlagValue = request.getParameter("prtFlagValue");

	System.out.println("sData===="+sData);
	System.out.println("optorMsg===="+optorMsg);

	String[] arrayStr1 = sData.split("\\|");
	String[] optorMsgArray = optorMsg.split(",");
	
	for(int hh=0 ;hh<optorMsgArray.length;hh++){
	   System.out.println(hh+"-----------------------------sCustOrderC.jsp----------------------------"+optorMsgArray[hh]);
	}
	
	String[][] carArr = new String[arrayStr1.length][10];
	for (int i = 0; i < arrayStr1.length; i++) 
	{
			String [] arrayStr2 = arrayStr1[i].split(",");
			for(int j = 0; j < arrayStr2.length; j++)
			{
				carArr[i][j]=arrayStr2[j];
	            System.out.println("arrayStr2[j]===="+arrayStr2[j]);
			}
	}
	
	
	UType TCustOrder = new UType();
		TCustOrder.setUe("STRING","0");
		TCustOrder.setUe("STRING","0");
		TCustOrder.setUe("STRING","0");
		TCustOrder.setUe("INT","1");
		TCustOrder.setUe("INT","2");
		TCustOrder.setUe("STRING","sContactId");//接触ID
		TCustOrder.setUe("INT","2");
		TCustOrder.setUe("INT","10");
		TCustOrder.setUe("INT","1");
		TCustOrder.setUe("STRING","0");
		TCustOrder.setUe("STRING",workNo);//工号
		TCustOrder.setUe("INT","1");
		TCustOrder.setUe("STRING","0");
		TCustOrder.setUe("LONG","0");
		TCustOrder.setUe("STRING","N");
		TCustOrder.setUe("STRING","0");
		TCustOrder.setUe("STRING",siteId);	//siteId
		TCustOrder.setUe("INT","1");
		TCustOrder.setUe("LONG",custId);	//cust_id
		TCustOrder.setUe("STRING","0");
		TCustOrder.setUe("STRING","0");
		TCustOrder.setUe("STRING","0");
		TCustOrder.setUe("STRING","Y");	//发票打印标识
		TCustOrder.setUe("STRING",prtFlagValue);	//免填单打印标识
		TCustOrder.setUe("STRING","sOpNote");//备注
		TCustOrder.setUe("STRING",regionCode);	//RegionCode
		
		
		System.out.println("-----------------------------siteId----------------------------"+siteId);
		System.out.println("-----------------------------custId----------------------------"+custId);
		System.out.println("-----------------------------prtFlagValue----------------------------"+prtFlagValue);
		System.out.println("-----------------------------regionCode----------------------------"+regionCode);
		
		
	UType CustOrderExtDatas = new UType();	
	
	UType dOrderArrayMsgs	= new UType();
	for(int i=0;i<carArr.length;i++)
	{
		UType dOrderArrayMsg	= new UType();
			dOrderArrayMsg.setUe("STRING","0");
			dOrderArrayMsg.setUe("STRING","0");
			dOrderArrayMsg.setUe("STRING","0");
			dOrderArrayMsg.setUe("STRING",carArr[i][1]);	//function_name
			System.out.println("-----------------------------carArr[1]----------------------------"+carArr[i][1]);
			System.out.println("-----------------------------carArr[3]----------------------------"+carArr[i][3]);
			if(carArr[i][3].equals("Y"))//
			{
			
			dOrderArrayMsg.setUe("STRING","101");	//100新装 101客户服务
			System.out.println("-----------------------------carArr[5]----------------------------"+carArr[i][5]);
			System.out.println("-----------------------------carArr[4]----------------------------"+carArr[i][4]);
			dOrderArrayMsg.setUe("STRING",carArr[i][5]);//销售品代码
			
			dOrderArrayMsg.setUe("LONG",carArr[i][4]);//idNo
			}else
			{
			dOrderArrayMsg.setUe("STRING","100");	//100新装 101客户服务
			dOrderArrayMsg.setUe("STRING",carArr[i][5]);//销售品代码
			dOrderArrayMsg.setUe("LONG","0");
			}
			System.out.println("-----------------------------carArr[2]----------------------------"+carArr[i][2]);
			dOrderArrayMsg.setUe("INT",carArr[i][2]);//数量
			dOrderArrayMsg.setUe("INT",String.valueOf(i));//顺序，从0开始
			dOrderArrayMsg.setUe("INT","10");//状态受理中
			dOrderArrayMsg.setUe("STRING","20500101 00:00:01");
			dOrderArrayMsg.setUe("STRING","0");
			dOrderArrayMsg.setUe("STRING","N");
			dOrderArrayMsg.setUe("INT","0");
			dOrderArrayMsg.setUe("STRING","0");
			System.out.println("-----------------------------carArr[6]----------------------------"+carArr[i][6]);
			dOrderArrayMsg.setUe("STRING",carArr[i][6]);//FUNCTION_CODE
			dOrderArrayMsg.setUe("STRING","opNote");//备注
			System.out.println("-----------------------------carArr[7]----------------------------"+carArr[i][7]);
			dOrderArrayMsg.setUe("STRING",carArr[i][7]);//servBusiId
			
			UType dOrderArrayMsgDatas	= new UType();
			System.out.println("-----------------------------carArr[8]----------------------------"+carArr[i][8]);
			System.out.println("-----------------------------carArr[9]----------------------------"+carArr[i][9]);
			
			if(carArr[i][8]!=null&&carArr[i][9]!=null)
			{
			
				String [] offerInfoCodeArr = carArr[i][8].split("~");
				String [] offerInfoValueArr = carArr[i][9].split("~");
			
				for(int j =0;j<offerInfoCodeArr.length;j++)
				{
					UType dOrderArrayMsgData = new UType();
					dOrderArrayMsgData.setUe("STRING","0");
					dOrderArrayMsgData.setUe("LONG",offerInfoCodeArr[j]);
					dOrderArrayMsgData.setUe("INT","0");
					System.out.println(j+"-----------------------------offerInfoValueArr[8]----------------------------"+offerInfoValueArr[j]);
					dOrderArrayMsgData.setUe("STRING",offerInfoValueArr[j]);
					
					dOrderArrayMsgDatas.setUe(dOrderArrayMsgData);
				}
			}
			
			dOrderArrayMsg.setUe(dOrderArrayMsgDatas);
			dOrderArrayMsgs.setUe(dOrderArrayMsg);
		}
			
			UType dCustOrderContactInfoList	= new UType(); //经办人列表信息
			UType dCustOrderContactInfo	= new UType(); //经办人信息
				dCustOrderContactInfo.setUe("INT","2"); //ContactRelaType
				dCustOrderContactInfo.setUe("INT","0"); //ContactSeq

				dCustOrderContactInfo.setUe("STRING",optorMsgArray[0]); //ContactCustName
				dCustOrderContactInfo.setUe("STRING",optorMsgArray[3]); //ContactPhone
				dCustOrderContactInfo.setUe("STRING",optorMsgArray[4]); //ContactMobile
				dCustOrderContactInfo.setUe("STRING",optorMsgArray[1]); //ContactIdType
				dCustOrderContactInfo.setUe("STRING",optorMsgArray[2]); //ContactIdIccId
				dCustOrderContactInfo.setUe("STRING",optorMsgArray[5]); //ContactZipCode
				dCustOrderContactInfo.setUe("STRING",optorMsgArray[6]); //ContactUserAddr
				dCustOrderContactInfo.setUe("STRING",optorMsgArray[7]); //ContactEmailAddress
				
				
				dCustOrderContactInfoList.setUe(dCustOrderContactInfo);
System.out.println("-----------------------------OK----------------------------");
%>


<wtc:utype name="sCustOrderC" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode%>">
      <wtc:uparam value="<%=TCustOrder%>" type="UTYPE"/> 
      <wtc:uparam value="<%=CustOrderExtDatas%>" type="UTYPE"/> 
      <wtc:uparam value="<%=dOrderArrayMsgs%>" type="UTYPE"/> 
      <wtc:uparam value="<%=dCustOrderContactInfoList%>" type="UTYPE"/> 
</wtc:utype>
<%
	  String retCode  =retVal.getValue(0);
	  String retMsg	  =retVal.getValue(1);
		String custOrderNo ="";//订单编号
		String custOrderId ="";//订单Id
		
if(retCode.equals("0"))
{
		custOrderId = retVal.getValue("2.0.0"); 
		custOrderNo = retVal.getValue("2.0.1"); 
}
		
		System.out.println("retCode===="+retCode);
		System.out.println("retMsg===="+retMsg);
		System.out.println("custOrderId===="+custOrderId);
		System.out.println("custOrderNo===="+custOrderNo);
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("custOrderNo","<%=custOrderNo%>");
response.data.add("custOrderId","<%=custOrderId%>");
response.data.add("retMsg","error");
core.ajax.receivePacket(response);
