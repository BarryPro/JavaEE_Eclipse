<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-19 ҳ�����,�޸���ʽ
*1270,1219,2266��ģ����ʹ�õ�ҳ��.
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%	
		/***�û��ֻ���	phone_no**��������	login_no**Ʊ������	bill_type*/
 
		String workNo =  WtcUtil.getParameter("workNo",request);
		String opCode=request.getParameter("opCode");
		String login_accept=request.getParameter("login_accept");
		String retType=request.getParameter("retType");
	    String billType=request.getParameter("billType");
	    String phoneNo=request.getParameter("phoneNo");
		String arrayOrderId=request.getParameter("arrayOrderId");//���񶨵���
		String region_code=request.getParameter("region_code");
		String time=request.getParameter("time");
		if(time==null) time="0";

	    String errCode="";
	    String errMsg="";

		String serverName="";
		if(billType.equals("1")){
			serverName="sCtOEltPrint";
		}else if(billType.equals("2")){
			serverName="sCtOBillPrt";
		}
		System.out.println(login_accept+"    "+billType+"    "+phoneNo+"    "+arrayOrderId+"   "+opCode+"   "+serverName);
/**----------------��������----------------*/
UType uBasicInfo=new UType();
	uBasicInfo.setUe("STRING",opCode);
	uBasicInfo.setUe("LONG",billType);
	uBasicInfo.setUe("STRING",arrayOrderId);
	uBasicInfo.setUe("STRING",phoneNo);
	uBasicInfo.setUe("LONG",login_accept);
	if(billType.equals("2")){
		uBasicInfo.setUe("STRING",region_code);
	}else if(billType.equals("1")){
		uBasicInfo.setUe("STRING",time);
	}
%>
<%
/**
 * �����ӡ����
 * @inparam uInParam
 *         <uInParam>
 *           <uBasicInfo>			 ������Ϣ
 *             sOpCode �������� 
 *             lBillType Ʊ������ 
 *             serv_order_id ������ˮ 
 *             sPhoneNo �ֻ����� 
 *           </uBasicInfo>
 *         </uInParam>
 * @outparam ctrlInfo
 *		   <uOutParams>
 *			 <uOutInfo>
 *				0class_code  �ֶ������
 *				1content_type  ��Ϣ����
 *				2row_num  �к�
 *				3col_num  �к�
 *				4font_size  �����С
 *				5font_color  ������ɫ
 *				6is_bold  �Ƿ����
 *				7max_size  ��󳤶�
 *				8line_size  ÿ����󳤶�
 *				9is_wrap  �Ƿ��Զ�����
 *				10print_content  ��ӡ����
 *				11row_space  �м��
 *				12font_name  ��������
 *			 </uOutInfo>
 *			 ..........
 *		   </uOutParams>
 * @author	wangmq
 * @return uOutParams
 */
//sCtOEltPrint
 %>

	<wtc:utype name="<%=serverName%>" id="retVal" scope="end">
		<wtc:uparam value="<%=uBasicInfo%>" type="UTYPE"/>
	</wtc:utype>

var impResultArr = new Array();	
var plusResultArr=new Array();
	<%
				for(int i=0;i<retVal.getSize("2.1");i++){
	%>
					var temResultArr = new Array();
	<%
					for(int j=0;j<retVal.getSize("2.1."+i);j++){
	%>
						
						temResultArr[<%=j%>] = "<%=retVal.getValue("2.1."+i+"."+j).replaceAll("\r\n","")%>";
	<%				
					}
	%>
					impResultArr[<%=i%>]=temResultArr;
	<%
				}	
	%>
	<%/*---------------��ȡͷβ��Ϣ------------------*/
				for(int i=0;i<retVal.getSize("2.0");i++){
	%>
					var temResultArr2 = new Array();
	<%
					for(int j=0;j<retVal.getSize("2.0."+i);j++){
	%>
						temResultArr2[<%=j%>] = "<%=retVal.getValue("2.0."+i+"."+j).replaceAll("\r\n","")%>";
	<%				
					}
	%>
					plusResultArr[<%=i%>]=temResultArr2;
	<%
				}	
	%>

	
<%

String retCode=retVal.getValue(0);
String retMsg=retVal.getValue(1);
System.out.println("#  return  # - "+retCode+" | "+retMsg);
if(retCode.equals("0")){   
	if(retVal.getSize(2)>0)
	{
		 errCode="000000";
     errMsg="������ӡ�ɹ���";
	}
	else{
		 errCode="000001";
     errMsg="��ӡ����Ϊ�գ�";
	}



}else{ 
   errCode=retCode;
   errMsg=retMsg;
	}

%>
var response = new AJAXPacket();
var retType = "";
var errCode = ""
var errMsg = "";
retType = "<%=retType%>";
errCode = "<%=errCode%>";
errMsg = "<%=errMsg%>";
response.data.add("retType",retType);
response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);
response.data.add("impResultArr",impResultArr);
response.data.add("plusResultArr",plusResultArr);
core.ajax.receivePacket(response);

