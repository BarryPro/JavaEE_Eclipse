<%
   /*���ƣ����ſͻ���Ŀ���� - ����ύ
�� * �汾: v1.0
�� * ����: 2007/2/7
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.10
 ģ�飺�������ҵ������
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>

<%  
    
	String workNo   = (String)session.getAttribute("workNo");                //����
	String workName = (String)session.getAttribute("workName");              //��������
	String org_code = (String)session.getAttribute("orgCode");
	String nopass  = (String)session.getAttribute("password");                    //��½����
	String regionCode = (String)session.getAttribute("regCode");

	String opCode = "2889";	
%>

<%
	
	String OprCode = request.getParameter("OprCode");//01,����,05,���
	String otherInfo = "";			
	String unit_id= "";		
	if(OprCode.equals("01"))
	{
	
		otherInfo ="EC/SIҵ������";
	}else if(OprCode.equals("05"))
	{
		otherInfo ="EC/SIҵ����";
	}
	
	String queryType=request.getParameter("queryType");	
	String spId = request.getParameter("spId");
	if(queryType.equals("1"))
	{
		 unit_id =spId;
	}
	
	String bizCode = request.getParameter("bizCode");
	String bizType = request.getParameter("bizType");;
	String bizName = request.getParameter("bizName");
	String spBizName = request.getParameter("spBizName");
	String accessModel = request.getParameter("accessModel");
	String accessNumber = request.getParameter("accNum");
	String price = request.getParameter("price")==null?"":request.getParameter("price");
	String billingType = request.getParameter("billingType")==null?"":request.getParameter("billingType");
	String bizPRI = request.getParameter("bizPRI");
	String bizStatus = request.getParameter("bizStatus");
	String rBList = request.getParameter("rBList")==null?"":request.getParameter("rBList");
	String oprEffTime = request.getParameter("oprEffTime");
	String provURL = request.getParameter("provURL");
	String usageDesc = request.getParameter("usageDesc");
	String introURL = request.getParameter("introURL");
	String svrCode = request.getParameter("svrCode"); 
	String netAttr = request.getParameter("netAttr"); 
	String bussId = request.getParameter("bussId"); 
	String CreateFlag = request.getParameter("CreateFlag"); 
	String grpParamSet       =request.getParameter("grpParamSet"); 
	String grpParamSetName   =request.getParameter("grpParamSetName"); 
	String iBizTypeL = WtcUtil.repNull((String)request.getParameter("bizTypeL"));
	String iBizTypeS = WtcUtil.repNull((String)request.getParameter("bizTypeS"));
	String Type=request.getParameter("bizLabel"); 
	String BaseServCodeProp=request.getParameter("BaseServCodeProp");
	String LimitAmount=  request.getParameter("LimitAmount")==null?"":request.getParameter("LimitAmount");
	String ServCode  = request.getParameter("accessNumber")==null?"":request.getParameter("accessNumber"); 

	

	String IsPreCharge ="";                                                 // �Ƿ�Ԥ����ҵ��
	String defaultSign="";                                                  // ȱʡǩ������
	String TextSignEn="";                                                   // Ӣ��ǩ��
	String TextSignZh="";                                                   // ����ǩ��
	String ISTextSign="";                                                   // �Ƿ�������ǩ��
	String AuthMode="";                                                     // ҵ�����ż�Ȩ��ʽ
	String MaxItemPerDay="";                                                // ÿ���·����������
	String MaxItemPerMon="";                                                // ÿ���·����������
	String StartTime="";                                                    // �������·���ʼʱ��
	String EndTime="";                                                      // �������·�����ʱ��
	String MOCode="";                                                       // ָ������
	String CodeMathMode="";                                                 // ָ������ƥ�䷽ʽ
	String MOType="";                                                       // ָ������ 
	String DestServCode="";                                                 // Ŀ�ĺ���
	String ServCodeMathMode="";                                             // Ŀ�ĺ���ƥ�䷽ʽ
	

if("2".equals(queryType.trim())&&"1".equals(bizType.trim()))
	{
		 IsPreCharge 	 	= request.getParameter("isPrepay");
		 defaultSign        = request.getParameter("defaultSign");
		 TextSignEn         = request.getParameter("TextSignEn");
		 TextSignZh         = request.getParameter("TextSignZh");	
		 ISTextSign         = request.getParameter("ISTextSign");		 
		 AuthMode           = request.getParameter("AuthMode");
		 MaxItemPerDay      = request.getParameter("MaxItemPerDay");
		 MaxItemPerMon      = request.getParameter("MaxItemPerMon");

		
		 StartTime = request.getParameter("StartTime")==null?"":request.getParameter("StartTime");
		 EndTime   = request.getParameter("EndTime")==null?"":request.getParameter("EndTime");		
		 MOCode=                 request.getParameter("MOCode")==null?"":request.getParameter("MOCode");
		 CodeMathMode=           request.getParameter("CodeMathMode")==null?"":request.getParameter("CodeMathMode");
     MOType=                 request.getParameter("MOType")==null?"":request.getParameter("MOType");
     DestServCode=           request.getParameter("DestServCode")==null?"":request.getParameter("DestServCode");
     ServCodeMathMode=       request.getParameter("ServCodeMathMode")==null?"":request.getParameter("ServCodeMathMode");
     

	} 

		

%>
	<wtc:service name="s6300Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
	<wtc:param value="<%=workNo       %>"/>
	<wtc:param value="<%=nopass       %>"/>
	<wtc:param value="<%=org_code     %>"/>
	<wtc:param value="<%=opCode       %>"/>
	<wtc:param value="<%=regionCode   %>"/>
			
	<wtc:param value="<%=spId         %>"/>
	<wtc:param value="<%=OprCode      %>"/>
	<wtc:param value="<%=bizCode      %>"/>
	<wtc:param value="<%=bizType      %>"/>
	<wtc:param value="<%=bizName      %>"/>	
		
	<wtc:param value="<%=spBizName    %>"/>
	<wtc:param value="<%=accessModel  %>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=price        %>"/>
	<wtc:param value="<%=billingType  %>"/>	
	<wtc:param value="<%=bizPRI       %>"/>
		
	<wtc:param value="<%=bizStatus    %>"/>
	<wtc:param value="<%=rBList       %>"/>
	<wtc:param value="<%=oprEffTime   %>"/>
	<wtc:param value="<%=provURL      %>"/>	
	<wtc:param value="<%=usageDesc    %>"/>
		
	<wtc:param value="<%=introURL     %>"/>
	<wtc:param value="<%=otherInfo    %>"/>
	<wtc:param value="<%=svrCode      %>"/>
	<wtc:param value="<%=netAttr      %>"/>	
	<wtc:param value="<%=bussId       %>"/>
		
	<wtc:param value="<%=CreateFlag   %>"/>
	<wtc:param value="<%=grpParamSet  %>"/>			
  <wtc:param value="<%=iBizTypeL    %>"/>	
  <wtc:param value="<%=iBizTypeS    %>"/>	
  <wtc:param value="<%=Type    %>"/>
  
  <wtc:param value="<%=unit_id    %>"/>	
  <wtc:param value="<%=accessNumber    %>"/>	
  <wtc:param value="<%=BaseServCodeProp    %>"/>
  	
  <wtc:param value="<%=IsPreCharge    %>"/>	
  <wtc:param value="<%=defaultSign    %>"/>	
  <wtc:param value="<%=TextSignEn    %>"/>
  <wtc:param value="<%=TextSignZh    %>"/>	
  <wtc:param value="<%=ISTextSign    %>"/>	
  <wtc:param value="<%=AuthMode    %>"/>
  <wtc:param value="<%=MaxItemPerDay    %>"/>	
  <wtc:param value="<%=MaxItemPerMon    %>"/>	
  <wtc:param value="<%=LimitAmount    %>"/>
  <wtc:param value="<%=StartTime    %>"/>	
  <wtc:param value="<%=EndTime    %>"/>	
  <wtc:param value="<%=MOCode    %>"/>
  <wtc:param value="<%=CodeMathMode    %>"/>	
  <wtc:param value="<%=MOType    %>"/>	
  <wtc:param value="<%=DestServCode    %>"/>
  <wtc:param value="<%=ServCodeMathMode    %>"/>	
  <wtc:param value="<%=ServCode    %>"/>	
	
	</wtc:service>	
	<wtc:array id="retStr"  scope="end"/>
<%
	String errCode ="";
	String errMsg="";

	errCode = retStr[0][0];
	errMsg = retStr[0][1];
	
	if(errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("�����ɹ���",2); 
        	
        <%	if(OprCode.equals("01"))
        {
        %>
        	parent.location="f2889_1.jsp?opCode=2889&opName=�������ҵ������"; 
        <%
        }
      else
      	{
      	 %>
      	 	parent.window.close();
        <%
      	}
        %>
        </script>
<%	}
    else
    {
%>        
		  <script language='jscript'>
	          rdShowMessageDialog("������Ϣ��<%=errMsg%>",0);	
	          //parent.location="f2889_1.jsp"; 
	            history.go(-1);
	      </script>         
<%            
    }
    
%>
