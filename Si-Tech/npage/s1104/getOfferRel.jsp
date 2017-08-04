<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
System.out.println("----------------------------getOfferRel.jsp-------------------------------------");  
	String offerId = WtcUtil.repNull(request.getParameter("offerId"));
	String workNo=(String)session.getAttribute("workNo");
	String groupId =(String)session.getAttribute("groupId");
	String flag ="N";
		System.out.println("####################################sq001/getOfferRel.jsp==flag=="+flag);
	System.out.println("####################################sq001/getOfferRel.jsp==groupId=="+groupId);
	String errCode = "";
	int valid = 1;	//0:正确，1：系统错误，2：业务错误
	int recordNum = 0; //查询结果记录数量
	
	Map  hashMap  = new HashMap(103);
	
	Map  dependMap  = new HashMap(103); //存放被依赖关系
	
	UType sendInfo = new UType();
	
	sendInfo.setUe("LONG", offerId);
	System.out.println("-------------------------offerId---------------------"+offerId);
	sendInfo.setUe("STRING",workNo);
	System.out.println("-------------------------workNo---------------------"+workNo);
	sendInfo.setUe("LONG", groupId);
	System.out.println("-------------------------groupId---------------------"+groupId);
	sendInfo.setUe("STRING", flag);
	System.out.println("-------------------------flag---------------------"+flag);
%>

<wtc:utype name="sQryOfferRel" id="retVal" scope="end">
	<wtc:uparam value="<%=sendInfo%>" type="UTYPE"/>  	 
</wtc:utype>

<%
	errCode = String.valueOf(retVal.getValue(0));
	
	if(!errCode.equals("0")){
		valid = 1;
	}
	else{
		recordNum = retVal.getUtype("2").getSize();
		if(recordNum == 0)
		{
			valid = 2;
		}
		else
		{
			valid = 0;
		}
	}	
%>
<%
	if(valid == 0){
		for(int k=0;k<retVal.getUtype("2").getSize();k++){
			UType utypeOneLevel = retVal.getUtype("2."+k);
			for(int i=0;i<utypeOneLevel.getSize();i++)
			{
			 
				if(utypeOneLevel.getUtype(i).getSize() > 0){
					String  offerAId = utypeOneLevel.getUtype(i).getValue(0).trim();
					String  offerZId = utypeOneLevel.getUtype(i).getValue(1).trim();
					String  relationType = utypeOneLevel.getUtype(i).getValue(2).trim();
					hashMap.put(offerAId,offerAId);						
					dependMap.put(offerZId,offerZId);
					if(relationType.equals("1"))//关系未互斥
					{
					   hashMap.put(offerZId,offerZId);	
					}
				}
			}
		}
	}
%>
<script language="javaScript">
	var itemHash =  new Object(); //产品间关系
	var dependHash =  new Object(); //产品间关系
	
<%
		Iterator dependIt = dependMap.keySet().iterator();
		while(dependIt.hasNext())
		{
		  String str = (String)dependIt.next();
%>
	 		dependHash['<%=str%>'] = [];
<%	}

		Iterator it = hashMap.keySet().iterator();
		while(it.hasNext())
		{
		  String str = (String)it.next();
%>
	 		itemHash['<%=str%>'] = [[],[]];
<%	}

	if(valid == 0){	
		for(int k=0;k<retVal.getUtype("2").getSize();k++){
			UType utypeOneLevel = retVal.getUtype("2."+k);
			for(int i=0;i<utypeOneLevel.getSize();i++)
			{
			   if(utypeOneLevel.getUtype(i).getSize() > 2){
				   String  offerAId = utypeOneLevel.getUtype(i).getValue(0).trim();
				   String  offerZId = utypeOneLevel.getUtype(i).getValue(1).trim();
				   String  relationType = utypeOneLevel.getUtype(i).getValue(2).trim();
		%>
				   itemHash['<%=offerAId%>'][0].push('<%=offerZId%>');
				   itemHash['<%=offerAId%>'][1].push('<%=relationType%>');
		<%
		
		      if(relationType.equals("1"))//关系为互斥
		      {%>
		      
		       itemHash['<%=offerZId%>'][0].push('<%=offerAId%>');
				   itemHash['<%=offerZId%>'][1].push('<%=relationType%>');
				   
		      <%}
					else if(relationType.equals("0")){ //关系为依赖
		%>
						dependHash['<%=offerZId%>'].push('<%=offerAId%>');
		<%			
					}
				}
			}
		}	
	}	
	%>
</script>		
