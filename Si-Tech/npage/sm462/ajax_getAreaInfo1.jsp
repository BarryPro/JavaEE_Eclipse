<%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
/*
* ����: װ����Ϣ��ѯ
* �汾: 1.0
* ����: 2015-05-23
* ����: lijy
* ��Ȩ: sitech
*/
%>

<%
	System.out.println("==============����С����ѯ=============== ");
	String kuandaiNum = request.getParameter("kuandaiNum")==null?"":request.getParameter("kuandaiNum");
//	String regionName=request.getParameter("regionName")==null?"":request.getParameter("regionName");
	String smCode=request.getParameter("smCode")==null?"":request.getParameter("smCode");
	String iBusiType = "02";
	String iObjectType = request.getParameter("iObjectType");
	
//	System.out.println("regionName=============== "+regionName);
	System.out.println("smCode=============== "+smCode);
	
	String opName="IMS��Դ��ѯ";
	String iMsg="FIELDCHNAME=��Ʒ�ؼ���|��Ʒ����,FIELDENNAME=productCode|productType,FIELDCONTENT="+kuandaiNum+"|12";
  
 // System.out.println("gaopengSeeLog==== 111=============== "+regionName);
  String result1="";
%>
<wtc:service name="sGetJZAreaInfo" routerKey="region"   retcode="retcode" retmsg="retmsg"  outnum="17" >
	<wtc:param value="<%=iMsg%>"/>
	<wtc:param value="<%=kuandaiNum%>"/>
	<wtc:param value="<%=iBusiType%>"/>
	<wtc:param value="<%=iObjectType%>"/>
</wtc:service>	
<wtc:array id="result"  scope="end"/>
<%
	System.out.println("gaopengSeeLog==== retcode======"+retcode);
	System.out.println("retMsg======"+retmsg);
	
	//retcode="000000";
	//result[0][0]="fieldChName=С������%С������%������/��%����%��������#С������%С������%������/��%����%��������#С������%С������%������/��%����%��������#С������%С������%������/��%����%��������,fieldEnName=distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType,fieldContent=��̨���ƶ���˾%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16c9c029a%��̨��/������%100M%1#��̨�Ӻ�ΰС��%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16e8702a2%��̨��/������%100M%2#��̨�Ӳ���С��%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16d92029e%��̨��/������%100M%1#��̨������С��%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16f8702a6%��̨��/������%100M%0";
	//result[0][0]="fieldChName=С������%С������%��������%���žֱ���%����������#С������%С������%��������%���žֱ���%����������,fieldEnName=distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType,fieldContent=��̨��/������%T_SPACE_STANDARD_ADDRESS-8aee349d336479490133685be629140c%0%80045%paers#��̨��/������/��̨�Ӻ�ΰС��%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16e8702a2%2%00113%par02#��̨��/������/��̨�Ӳ���С��%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16d92029e%3%00114%par03#��̨��/������/��̨������С��%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16f8702a6%0%00115%par04";
if(retcode.equals("000000")){
	
	for(int i=0;i<result.length;i++){
		for(int j=0;j<result[i].length;j++){
			System.out.println("liangyl======"+result[i][j]);
		}
	}
	
//	var retInfo1="4%"+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type+"|"+addrCode+"|"+addrContent;
//	var retInfo2="|"+deviceType+"|"+deviceCode+"|"+model+"|"+factory+"|"+ipAddress+"|"+deviceInAddress+"|"+portType+"|"+portCode+"|"+cctId+"|"+partnerCode+"|"+belongCategory+"|"+bearType+"|"+propertyUnit+"|"+distKdCode+"|"+nearInfo;
//	var retInfo=retInfo1+retInfo2;
/* String AccessType = result[0][1];
	String AccessTypeShow="";
	if(AccessType.equals("1")){
    	AccessTypeShow = "XDSL";
    }else if(AccessType.equals("2")){
    	AccessTypeShow = "FTTH";
    }else if(AccessType.equals("3")){
    	AccessTypeShow = "FTTB";
    }else if(AccessType.equals("4")){
    	AccessTypeShow = "CABLE";
    }else if(AccessType.equals("5")){
    	AccessTypeShow = "WBS";
    }else{
    	AccessTypeShow = "����";
    } */
    /* String BelongCategory = result[0][12];
	String BelongCategoryShow="";
	if(BelongCategory.equals("0")){
		BelongCategoryShow = "����";
    }else if(BelongCategory.equals("1")){
    	BelongCategoryShow = "ũ��";
    } */
    /* String BearType = result[0][13];
	String BearTypeShow="";
	if(BearType.equals("0")){
		BearTypeShow = "����";
    }else if(BearType.equals("1")){
    	BearTypeShow = "����";
    } */
    
    /*  String propertyUnit = result[0][16];
    String propertyUnitShowText = "";
  	if(propertyUnit.equals("1")){
  		propertyUnitShowText = "�ƶ��Խ�";
  	}else if(propertyUnit.equals("2")){
  		propertyUnitShowText = "�ƶ��Ͻ�";
  	}else if(propertyUnit.equals("3")){
  		propertyUnitShowText = "ʡ���";
  	}else if(propertyUnit.equals("4")){
  		propertyUnitShowText = "�����";
  	}else if(propertyUnit.equals("5")){
  		propertyUnitShowText = "��ͨ";
  	}else if(propertyUnit.equals("6")){
  		propertyUnitShowText = "����";
  	} */
  	
  	/* String NearInfo = result[0][15];
	String NearInfoShow="";
	if(NearInfo.equals("0")){
		NearInfoShow = "¢��";
    }else if(NearInfo.equals("1")){
    	NearInfoShow = "����";
    } */
    System.out.println("liangyl+++++++++++++++++++++++++++++++++++++++"+result[0][0]);
	result1+="4%|";
	result1+=result[0][6]+"|";
	result1+=result[0][7]+"|";
	result1+=result[0][8]+"|";
	result1+=result[0][1]+"|";
	result1+="|";
	result1+=result[0][8]+"|";
	result1+="|";
	result1+="|";
	result1+="|";
	result1+="|";
	result1+="|";
	result1+="|";
	result1+="|";
	result1+="|";
	result1+=result[0][4]+"|";//���žִ���
	
	result1+=result[0][11]+"|";//����������
	
	result1+=result[0][12]+"|";//��������
	
	result1+=result[0][13]+"|";//���ط�ʽ
	
	result1+=result[0][16]+"|";//С����������
	
	result1+=result[0][14]+"|";//С������
	
	
	result1+=result[0][15]+"|";//С���������
	
	result1+=kuandaiNum+"|";//����˺�
	String return00 = result[0][0].split("fieldContent=")[1];
	System.out.println("liangyl+++++++++++++++++++++++++++++++++++++++"+return00.split("%")[5]);
	result1+=return00.split("%")[5]+"|";//����
	
%>
var response = new AJAXPacket();
var returnCode= "<%=retcode%>";
var returnMsg="<%=retmsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
response.data.add("result","<%=result[0][0]%>");
response.data.add("result1","<%=result1%>");
core.ajax.receivePacket(response);
<%}else{%>
	var response = new AJAXPacket();
	var returnCode= "<%=retcode%>";
	var returnMsg="<%=retmsg%>";
	response.data.add("retCode",returnCode);
	response.data.add("retMessage",returnMsg);
	core.ajax.receivePacket(response);
<%}%>
