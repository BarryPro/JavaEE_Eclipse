<%
/********************
 version v2.0
开发商: si-tech
*
*author:gonght@2009-5-9 10:40:33
*
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	System.out.println("===============qryMode.jsp================");
    String retType = request.getParameter("retType");
		String fam_prod_id = request.getParameter("fam_prod_id");
		String regionCode = request.getParameter("regionCode");
		String phone_no = request.getParameter("phone_no");
		String MainProd="",OtherProd="",MainName="",OtherProdName="";
		String groupId ="";
		/* liujian 安全加固修改 2012-4-6 16:18:13 begin */
    String workNo = (String)session.getAttribute("workNo");
		String op_strong_pwd = (String) session.getAttribute("password");
	  /* liujian 安全加固修改 2012-4-6 16:18:13 end */
		String insql="";
		System.out.println("=========retType ==="+retType);
		insql ="select unique main_product,other_product from sfamilyproduct where region_code='" + regionCode + "' and fam_prod_id= '"+ fam_prod_id+ "' ";

  	System.out.println("+++++++getModeInfo begin++++++++++");

%>
		 <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="2">
		 <wtc:sql><%=insql%></wtc:sql>
		 </wtc:pubselect>
		 <wtc:array id="result1" scope="end" />
<%
     String retCode=errCode;
		 String retMsg=errMsg;
     System.out.println(retCode+"   :   "+retMsg);
     if(result1 != null && result1.length>0 && errCode.equals("000000"))
     {
     		MainProd = WtcUtil.repNull(result1[0][0]).trim();
     		OtherProd = WtcUtil.repNull(result1[0][1]).trim();
     }
     System.out.println("+++++++ MainProd==="+MainProd);
     System.out.println("------- OtherProd==="+OtherProd);
     
	 System.out.println("===============gonght add 2010-3-17 fetch ModeNote================");	
	 	String sqlstr="";
	 	sqlstr = "select group_id from dcustmsg where phone_no = '"+ phone_no +"' ";
%>
		 <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="1">
		 <wtc:sql><%=sqlstr%></wtc:sql>
		 </wtc:pubselect>
		 <wtc:array id="result5" scope="end" />
<%
		if(result5 != null && result5.length>0 && errCode.equals("000000"))
     	{
     			groupId = WtcUtil.repNull(result5[0][0]).trim();
     	}
		String note="";
		String note1="";
		String erpi ="";
		String[] inParas = new String[]{""};
			inParas = new String[3];
			inParas[0] = regionCode;
			inParas[1] = fam_prod_id;
			inParas[2] = erpi;
%>
		<wtc:service name="s1270NoteNew" routerKey="region" routerValue="<%=regionCode%>" retCode="errCode" retMsg="errMsg" outnum="7" >
			<wtc:param value=""/>
			<wtc:param value="01"/>
			<wtc:param value="7333"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=op_strong_pwd%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
				
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>
			<wtc:param value="<%=inParas[2]%>"/>
			<wtc:param value="<%=groupId%>"/>
		</wtc:service>
		<wtc:array id="result3" scope="end"/>
<%
	if(result3!=null){
		if(result3.length>0){
			String before_mode_note = result3[0][4];
			String after_mature_note = result3[0][6];
			note= note+" "+before_mode_note;
			note1 = note1+" "+after_mature_note;
			}
		}
		
		note = note.replaceAll("\"","");
		note = note.replaceAll("\'","");
		note = note.replaceAll("\r\n","");
		note1 = note1.replaceAll("\"","");
		note1 = note1.replaceAll("\'","");
			
		System.out.println("note="+note);
		System.out.println("note1="+note1);		
	System.out.println("===============gonght add end================");	
				
		 String sqlStr4 = "select offer_name from product_offer where offer_id=to_number('" + MainProd + "' )";
		 /*
		 *		 String sqlStr4 = "select mode_name from sbillmodecode where region_code='" + regionCode + "' and  mode_code='" + MainProd + "' ";
		 */
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retCode="errCode" retMsg="errMsg"  outnum="1">
			<wtc:sql><%=sqlStr4%></wtc:sql>
		 	</wtc:pubselect>
			<wtc:array id="result0" scope="end" />
<%
			System.out.println(retCode+"   :   "+retMsg);
			if(result0 != null && result0.length>0 && errCode.equals("000000"))
			{
				MainName = WtcUtil.repNull(result0[0][0]).trim();
			}
			System.out.println("0000000 MainName==="+MainName);
			/*
			**String strSql = "select mode_name from sbillmodecode where region_code='" + regionCode + "' and  mode_code='" + OtherProd + "' ";
			*/
			String strSql = "select offer_name from product_offer where offer_id=to_number('" + OtherProd + "') ";

%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retCode="errCode" retMsg="errMsg" outnum="1">
			<wtc:sql><%=strSql%></wtc:sql>
		 	</wtc:pubselect>
			<wtc:array id="result2" scope="end" />
<%
			System.out.println(retCode+"   :   "+retMsg);
			if(result2 != null && result2.length>0 && errCode.equals("000000"))
			{
				OtherProdName = WtcUtil.repNull(result2[0][0]).trim();
			}
			System.out.println("11111111 OtherProdName==="+OtherProdName);

      System.out.println(MainProd);
      System.out.println(MainName);
      System.out.println(OtherProd);
      System.out.println(OtherProdName);

%>

<% System.out.println("+++++++getModeInfo end++++++++++");%>
var response = new AJAXPacket();

response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType","<%= retType %>");
response.data.add("MainProd","<%= MainProd %>");
response.data.add("MainName","<%= MainName %>");
response.data.add("OtherProd","<%= OtherProd %>");
response.data.add("OtherProdName","<%= OtherProdName %>");
response.data.add("note","<%= note %>");
response.data.add("note1","<%= note1 %>");
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
core.ajax.receivePacket(response);
<%
		System.out.println(MainProd);
    System.out.println(MainName);
    System.out.println(OtherProd);
    System.out.println(OtherProdName);
%>
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>
