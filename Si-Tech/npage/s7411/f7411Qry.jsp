<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%String regionCode = (String)session.getAttribute("regCode");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%
	String motive_code = request.getParameter("motive_code"); 
	String op_type = request.getParameter("opr_type");
	
	String retCode = "";
	String retMsg = "";
%>

<wtc:service name="s7411UpCfm" outnum="15" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1">
	<wtc:param value="<%=motive_code%>"/>
	<wtc:param value="<%=regionCode%>"/>
	<wtc:param value="<%=op_type%>"/>
</wtc:service>
<wtc:array id="result" scope="end" start="0" length="9"/>
<wtc:array id="result1" scope="end" start="9" length="6"/>
<%
	retCode=retCode1;
	retMsg=retMsg1;
	String offer_name = "";			//�ʷ�����
	String eff_date = "";			//ҵ�����ʼʱ��
	String exp_date = "";			//ҵ�������ʱ��
	String offer_id = "";
	String motivePriceCodeStr = "";
	String motivePriceNameStr = "";
	String motivePriceCheckStr = "";
	
	//result_product��ֵΪ���¶���ֵ��˳��һ��
	//String subsm_code = "";//�Ӳ�ƷƷ��
	//String product_code = "";//�Ӳ�Ʒ����
	//String product_name = "";//�Ӳ�Ʒ����
	//String product_level = "";//�Ӳ�Ʒ����
	//String product_note = "";//�Ӳ�Ʒע��

    System.out.println("# result.length = "+result.length);
    System.out.println("# result1.length = "+result1.length);
  	if(retCode.equals("000000")){
  	    if(result.length>0){
	  	    offer_name = result[0][2];
	  		eff_date = result[0][3];
	  		exp_date = result[0][4]; 
	  		offer_id = result[0][5];
	  		motivePriceCodeStr = result[0][6];
	  		motivePriceNameStr = result[0][7];
	  		motivePriceCheckStr= result[0][8];
  		}else{
  		    retCode="û�����ݣ�";
  		    retMsg="999999";
  		}		
    }
	String result_array = CreatePlanerArray.createArray("result_product",result1.length);
%>
<%=result_array%>
<%
	for(int i = 0;i < result1.length;i++){
		for(int j = 0;j < result1[i].length;j++){
		System.out.println("result1["+i+"]["+j+"]="+result1[i][j]);
%>
	result_product[<%=i%>][<%=j%>] = "<%=result1[i][j]%>";
<%			
		}
	} 
%>

var response = new AJAXPacket();

response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("offer_name","<%=offer_name%>"); 
response.data.add("eff_date","<%=eff_date%>");
response.data.add("exp_date","<%=exp_date%>");
response.data.add("offer_id","<%=offer_id%>");
response.data.add("motivePriceCodeStr","<%=motivePriceCodeStr%>");
response.data.add("motivePriceNameStr","<%=motivePriceNameStr%>");
response.data.add("motivePriceCheckStr","<%=motivePriceCheckStr%>");
response.data.add("result_product",result_product);
core.ajax.receivePacket(response);
