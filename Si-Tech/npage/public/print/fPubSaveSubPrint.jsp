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
 		String work_no = (String)session.getAttribute("workNo");
		String retType=request.getParameter("retType");
	    String billType=request.getParameter("billType");
	    String phoneNo=request.getParameter("phoneNo");
	    String login_accept=request.getParameter("login_accept");
	    String errCode="";
	    String errMsg="";
	    String servOrderId=request.getParameter("servOrderId");//���񶨵���
	    System.out.println("retType="+retType);
	    System.out.println("billType="+billType);
		String serverName="";
		if(billType.equals("1")){
			serverName="sCtOEltJPrint";
			System.out.println("$$$$$$$$$$$$$$$$$$$$$$");

		}else if(billType.equals("2")){
			serverName="sCtOBillJPrt";

		}
			System.out.println(billType+"      "+servOrderId+"    "+phoneNo+"$$$$$$$$$$$$$$$$$$$$");
/**-------------------��������---------------------*/
UType uBasicInfo=new UType();
	uBasicInfo.setUe("LONG",billType);
	uBasicInfo.setUe("STRING",servOrderId);
	uBasicInfo.setUe("STRING",phoneNo);
/**
 * ����ϲ���ӡ
 * @inparam uInParam
 *         <uInParam>
 *           <uBasicInfo>			 ������Ϣ
 *             print_accept �������� 
 *             lBillType Ʊ������ 
 *             serv_order_id ���񶨵�����ID 
 *             sPhoneNo �ֻ����� 
 *             sLoginNo �������� 
 *           </uBasicInfo>
 *         </uInParam>
 * @outparam ctrlInfo
 *		   <uOutParams>
 *			 <uOutInfo>
 *				class_code  �ֶ������
 *				content_type  ��Ϣ����
 *				row_num  �к�
 *				col_num  �к�
 *				font_size  �����С
 *				font_color  ������ɫ
 *				is_bold  �Ƿ����
 *				max_size  ��󳤶�
 *				line_size  ÿ����󳤶�
 *				is_wrap  �Ƿ��Զ�����
 *				print_content  ��ӡ����
 *				row_space  �м��
 *				font_name  ��������
 *			 </uOutInfo>
 *			 ..........
 *		   </uOutParams>
 * @author	wangmq
 * @return uOutParams
 */
%>

	<wtc:utype name="<%=serverName%>" id="retVal" scope="end">
		<wtc:uparam value="<%=uBasicInfo%>" type="UTYPE"/>
	</wtc:utype>
<%

System.out.println("# retCode = "+retVal.getValue(0));
System.out.println("# retMsg  = "+retVal.getValue(1));
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"+retVal.getSize("2.1"));

%>
	var impResultArr = new Array();	
	var plusResultArr=new Array();
	<%/*--------------��ȡ����----------------*/
				for(int i=0;i<retVal.getSize("2.1");i++){
	%>
					var temResultArr = new Array();
	<%
					for(int j=0;j<retVal.getSize("2.1."+i);j++){
	%>
						temResultArr[<%=j%>] = "<%=retVal.getValue("2.1."+i+"."+j).replaceAll("\r\n","")%>";
						
	<%				System.out.println(retVal.getValue("2.1."+i+"."+j));
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

