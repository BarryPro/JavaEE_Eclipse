<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
	String offerId = WtcUtil.repNull(request.getParameter("offerId"));
	String workNo=(String)session.getAttribute("workNo");
	//String siteId=(String)session.getAttribute("siteId");
	String siteId=(String)session.getAttribute("groupId");
	String maxNum=WtcUtil.repNull(request.getParameter("maxNum"));
	//String flag = (String)session.getAttribute("isPorvinceWorkNo");//�Ƿ�ʡ������
	
	String flag = "N";

    
	System.out.println("#########################################���º��flag==="+flag);
	System.out.println("#########################################���º��siteId==="+siteId);
	String errCode = "";
	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
	int recordNum = 0; //��ѯ�����¼����
	
	Map  hashMap  = new HashMap(103);
	
	Map  dependMap  = new HashMap(103); //��ű�������ϵ
	
	UType sendInfo = new UType();
	
	sendInfo.setUe("LONG", offerId);
	sendInfo.setUe("STRING", workNo);
	sendInfo.setUe("LONG", siteId);		
  sendInfo.setUe("STRING", flag);
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
					if(relationType.equals("1"))//��ϵδ����
					{
					   hashMap.put(offerZId,offerZId);	
					}
				}
			}
		}
	}
%>
<script language="javaScript">
	var itemHash =  new Object(); //��Ʒ���ϵ
	var dependHash =  new Object(); //��Ʒ���ϵ
	
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
		
		      if(relationType.equals("1"))//��ϵΪ����
		      {%>
		      
		       itemHash['<%=offerZId%>'][0].push('<%=offerAId%>');
				   itemHash['<%=offerZId%>'][1].push('<%=relationType%>');
				   
		      <%}
					else if(relationType.equals("0")){ //��ϵΪ����
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
<%
	System.out.println("<<--------------��ѯ����Ʒ���ϵ����--------------------->>"); 
%>