<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.boss.bo.CustAuthenUtil"%>
<%
	String  opcode =  request.getParameter("opcode");
	String  functionName =  request.getParameter("functionName");
	String  phoneNo =  request.getParameter("phoneNo");
	String  idNo =  request.getParameter("idNo");
	String  servBusiId =  request.getParameter("servBusiId");
	String  sData =  request.getParameter("sData");
	String  offerId =  request.getParameter("offerId");
	String  brandId =  request.getParameter("brandId");
	String  custId =  request.getParameter("custId");
	String  workNo = (String) session.getAttribute("workNo");
	String  org_Code = (String) session.getAttribute("orgCode");
  String  regionCode=org_Code.substring(0,2);
  String  CustIdType = "0";
  int sizeFlag= 0;
  String prompt = "";
  int checkflag = 1;
  
  String[] arrayStr1 =null;
  if(!sData.equals(""))
  {
  	arrayStr1 = sData.split("\\|");
  }else
  {
		arrayStr1 = new String[0];
	}
	String[][] carArr = new String[arrayStr1.length][10];
	for (int i = 0; i < arrayStr1.length; i++) 
	{
			String [] arrayStr2 = arrayStr1[i].split(",");
			for(int j = 0; j < arrayStr2.length; j++)
			{
				carArr[i][j]=arrayStr2[j];
			}
	}
	
		UType u1 = new UType();
		u1.setUe("INT",servBusiId);
		u1.setUe("INT","0");
		u1.setUe("STRING",opcode);
		u1.setUe("INT","0");
		u1.setUe("INT","2");
		u1.setUe("STRING",workNo);
		u1.setUe("STRING",regionCode);
		
		UType u2 = new UType();
		for(int i=0;i<carArr.length;i++)
		{
			UType u = new UType();
			u.setUe("INT",carArr[i][7]);
			u.setUe("INT","0");
			u.setUe("STRING",carArr[i][6]);
			u2.setUe(u);
		}
		System.out.println("-------------------1------------------"+new Date());
%>
<wtc:utype name="sChkProdSrvRel" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode%>">
        <wtc:uparam value="<%=u1%>" type="UTYPE"/> 
        <wtc:uparam value="<%=u2%>" type="UTYPE"/> 
</wtc:utype>
<%
System.out.println("-------------------2------------------"+new Date());
	  String retCode=retVal.getValue(0);
	  String retMsg=retVal.getValue(1);
	  
	  StringBuffer logBuffer = new StringBuffer(80);
		WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
		System.out.println(logBuffer.toString());
		
		if(retCode.equals("0"))//认证
		{
				sizeFlag=retVal.getSize("2.0");
			  prompt = "";
			  if(sizeFlag>0)
			  {
			  	prompt=retVal.getValue("2.0.0.1")+"与"+retVal.getValue("2.0.0.3")+"互斥!";
			  }
	  
	  		if(retVal.getSize("2.1")>0)
	  		{
				String AuthFuncName = retVal.getValue("2.1.0.0");
				String JspName = retVal.getValue("2.1.0.1");
							 CustIdType = retVal.getValue("2.1.0.2");
				String IsLogAuthen = retVal.getValue("2.1.0.3");
				String IsLogContact = retVal.getValue("2.1.0.4");
				String sGroupRelaType = retVal.getValue("2.1.0.5");
				String sGroupSize = retVal.getValue("2.1.0.6");
			
				int size1 = retVal.getSize("2.1.1");
				String [] AuthenCode = new String[size1];
				String [] AuthenName = new String[size1];
				String [] AuthenGroup = new String[size1];
				String [] GroupInnerType = new String[size1];
				String [] GroupName = new String[size1];
				String [] AuthenType = new String[size1];
				
				System.out.println("size1size1size1="+size1);
				
				for(int i=0;i<size1;i++)
				{
				System.out.println(i+"============"+retVal.getValue("2.1.1."+i+".0"));
					AuthenCode[i]=retVal.getValue("2.1.1."+i+".0");
					AuthenName[i]=retVal.getValue("2.1.1."+i+".1");
					AuthenGroup[i]=retVal.getValue("2.1.1."+i+".2");
					GroupInnerType[i]=retVal.getValue("2.1.1."+i+".3");
					GroupName[i]=retVal.getValue("2.1.1."+i+".4");
					AuthenType[i]=retVal.getValue("2.1.1."+i+".5");
				}
				Map sessionMap = (HashMap)session.getAttribute(custId);
				Map map = null;
				
				if(sessionMap==null)
				{
					retCode="2";//session失效
				}else{
					
					if(CustIdType.equals("0"))//客户
					{
						map = (HashMap)sessionMap.get(CustIdType);
						if(map==null)
						{
							map= new HashMap();
							sessionMap.put("0",map);
						}
					}else if(CustIdType.equals("1"))//用户
					{
						map = (HashMap)sessionMap.get(phoneNo);
						if(map==null)
						{
								map=new HashMap();
								sessionMap.put(phoneNo,map);
						}
					}
					
				}
				/*
				 * return 1 不用验证
				 * return 0 需要验证
				 */
					checkflag = CustAuthenUtil.getVerify(map,AuthenCode,AuthenGroup,GroupInnerType,sGroupSize,sGroupRelaType);
			}
	}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("sizeFlag","<%=sizeFlag%>");
response.data.add("prompt","<%=prompt%>");
response.data.add("opcode","<%=opcode%>");
response.data.add("functionName","<%=functionName%>");
response.data.add("phoneNo","<%=phoneNo%>");
response.data.add("idNo","<%=idNo%>");
response.data.add("servBusiId","<%=servBusiId%>");
response.data.add("offerId","<%=offerId%>");
response.data.add("checkflag","<%=checkflag%>");
response.data.add("CustIdType","<%=CustIdType%>");
response.data.add("brandId","<%=brandId%>");
core.ajax.receivePacket(response);