<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%System.out.println("----------------------------ajaxGetEPf.jsp--------把传过来的字符串查出批价接回去----------------------------");  %>

<%
	String offerIdv = WtcUtil.repNull(request.getParameter("offerIdv"));
	String opCodev = WtcUtil.repNull(request.getParameter("opCode"));
	String regionCode = (String)session.getAttribute("regCode");
	
	String xqJf = WtcUtil.repNull(request.getParameter("xqJf"));
	
	System.out.println("小区资费|======"+xqJf);
	
	if(opCodev==null||"".equals(opCodev)){
		opCodev = "1270";
	}
	
	String workNo = (String)session.getAttribute("workNo");
	
	String retResultStr = "";
	String descResultStr = "";
	String resultFlag="";
 	
 	String newZOfferECode  = "";  //新申请主资费二批代码
 	String newZOfferDesc   = "";  //新申请主资费描述
 	String dOfferId        = "";  //到期后执行资费Id
 	String dOfferName      = "";  //到期后执行资费Name
 	String dECode          = "";  //到期后二批代码
 	String dOfferDesc      = "";  //到期后资费描述
 	String xq_name         = "";  //小区名称
 	
 	
 	System.out.println("-------------offerIdv----------------------"+offerIdv);
 	System.out.println("-------------workNo------------------------"+workNo);
 	System.out.println("-------------opCodev-----------------------"+opCodev);
 	System.out.println("-------------xqJf--------------------------"+xqJf);
 	
 	
		if(!offerIdv.equals("")&&offerIdv!=null){
%>

    <wtc:service name="sGetDetailCode" outnum="9" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=offerIdv%>" />
			<wtc:param value="<%=workNo%>" />	
			<wtc:param value="<%=opCodev%>" />	
			<wtc:param value="<%=xqJf%>" />	
		</wtc:service>
		<wtc:array id="result_t33" scope="end"   />

<%
		if(code.equals("000000") && result_t33.length > 0){
			for(int j=0;j<result_t33.length;j++){
				
				if(retResultStr+result_t33[j][2]!=null&&(!result_t33[j][2].equals(""))){
						retResultStr = retResultStr+" 新申请主资费二批代码："+result_t33[j][2]+"|";
						newZOfferECode = result_t33[j][2];
					}
					
					descResultStr+=" 新申请主资费描述：";
				if(retResultStr+result_t33[j][3]!=null&&(!result_t33[j][3].equals(""))){
						descResultStr += result_t33[j][3];
						newZOfferDesc = result_t33[j][3];
					}
				descResultStr+="|";
				
				if(retResultStr+result_t33[j][4]!=null&&(!result_t33[j][4].equals("")))	{
						retResultStr = retResultStr+" 到期后执行资费："+result_t33[j][4];
						dOfferId = result_t33[j][4];
					}
				
				if(retResultStr+result_t33[j][6]!=null&&(!result_t33[j][6].equals("")))	{
						retResultStr+= " "+result_t33[j][6];
						dOfferName = result_t33[j][6];
					}
					
				if((retResultStr+result_t33[j][4]!=null&&(!result_t33[j][4].equals("")))||(retResultStr+result_t33[j][6]!=null&&(!result_t33[j][6].equals(""))))	
					retResultStr += "|";	
					
				if(retResultStr+result_t33[j][5]!=null&&(!result_t33[j][5].equals(""))){		
						retResultStr = retResultStr+" 到期后二批代码："+result_t33[j][5]+"|";
						dECode = result_t33[j][5];
					}
				
				if(retResultStr+result_t33[j][7]!=null&&(!result_t33[j][7].equals(""))){
					descResultStr+= " 到期后资费描述："+result_t33[j][7]+"|";
					dOfferDesc = result_t33[j][7];
					}
					
				if(retResultStr+result_t33[j][8]!=null&&(!result_t33[j][8].equals(""))){
					xq_name = result_t33[j][8];
				}
			}
		}else {
		   resultFlag="none";
		}
	}
	System.out.println("---------------retResultStr---------------"+retResultStr);
	System.out.println("---------------descResultStr--------------"+descResultStr);
	System.out.println("---------------newZOfferECode--------------"+newZOfferECode);
		
	retResultStr = retResultStr.replaceAll("\r\n","</br>");  
	retResultStr = retResultStr.replaceAll("\r","</br>"); 
	retResultStr = retResultStr.replaceAll("\n","</br>"); 
	retResultStr = retResultStr.replaceAll("\"","&quot;"); 
	retResultStr = retResultStr.replaceAll("\'","&quot;"); 
	
	descResultStr = descResultStr.replaceAll("\r\n","</br>");  
	descResultStr = descResultStr.replaceAll("\r","</br>"); 
	descResultStr = descResultStr.replaceAll("\n","</br>"); 
	descResultStr = descResultStr.replaceAll("\"","&quot;"); 
	descResultStr = descResultStr.replaceAll("\'","&quot;"); 
	
	
	newZOfferDesc = newZOfferDesc.replaceAll("\r\n","</br>");  
	newZOfferDesc = newZOfferDesc.replaceAll("\r","</br>"); 
	newZOfferDesc = newZOfferDesc.replaceAll("\n","</br>"); 
	newZOfferDesc = newZOfferDesc.replaceAll("\"","&quot;"); 
	newZOfferDesc = newZOfferDesc.replaceAll("\'","&quot;"); 
	
	dOfferDesc = dOfferDesc.replaceAll("\r\n","</br>");  
	dOfferDesc = dOfferDesc.replaceAll("\r","</br>"); 
	dOfferDesc = dOfferDesc.replaceAll("\n","</br>"); 
	dOfferDesc = dOfferDesc.replaceAll("\"","&quot;"); 
	dOfferDesc = dOfferDesc.replaceAll("\'","&quot;"); 
%>

var response = new AJAXPacket();
response.data.add("resultFlag","<%=resultFlag%>");
<%if(!resultFlag.equals("none")){%>
response.data.add("retResultStr","<%=retResultStr%>");
response.data.add("descResultStr","<%=descResultStr%>");  
response.data.add("newZOfferECode","<%=newZOfferECode%>"); 
response.data.add("newZOfferDesc","<%=newZOfferDesc%>"); 
response.data.add("dOfferId","<%=dOfferId%>"); 
response.data.add("dOfferName","<%=dOfferName%>"); 
response.data.add("dECode","<%=newZOfferECode%>"); 
response.data.add("dOfferDesc","<%=dOfferDesc%>"); 
response.data.add("xq_name","<%=xq_name%>"); 

<%}%>
core.ajax.receivePacket(response);




