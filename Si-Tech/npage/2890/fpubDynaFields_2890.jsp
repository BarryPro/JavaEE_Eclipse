<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.01.19
 ģ��:EC��Ʒ����
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="java.util.*"%>

<%
/*
	���ƣ���̬�����ֶ�
	�����ⲿ������
		int fieldCount=resultList.length;
		boolean isGroup = true;
		String []fieldCodes=new String[fieldCount];
		String []fieldNames=new String[fieldCount];
		String []fieldPurposes=new String[fieldCount];
		String []fieldValues=new String[fieldCount];
		String []dataTypes=new String[fieldCount];
		String []fieldLengths=new String[fieldCount];
		String []fieldCtrlInfos=new String[fieldCount];
		String listShow;
	ʹ�÷������ܣ�
		���ļ����ܵ���ʹ�ã���Ҫ�����ļ�include����ļ�
	����OPCODE��3505��3508
	Author:lugz,yinyx
	wuxy �޸� Ϊȫ��MASҵ��̬������ʾ�����ɱ༭ 20080807
*/
%>

<%
	String opName = "EC��Ʒ����";
	String regCode = (String)session.getAttribute("regCode");
	StringBuffer nameList=new StringBuffer();
	StringBuffer nameValueList=new StringBuffer();

	SPubCallSvrImpl callView = new SPubCallSvrImpl();

    //wuxy add for MA
    int isMA=0;
    String[][] resultThirdValueList=null;

    int fieldCount2=0;
    
	String biz_code=request.getParameter("bizCode");
	//product_code = product_code.substring(0,product_code.indexOf("|"));

	String sqlStr ="SELECT b.param_code, c.param_name, b.default_value, c.param_type, "+
                 "c.param_length, b.null_able "+
                 "FROM SBILLSPCODE a, sbizparamdetail b, sbizparamcode c "+
                 "WHERE a.bizcodeadd = '" + biz_code + "'" +
                 "AND a.param_set = b.param_set "+
                 "AND b.param_code = c.param_code and multi_able = 'N' and show_flag = 'Y'  order by b.param_order";
                 
	//System.out.println(sqlStr);
	
	//String[][] resultList = (String[][])callView.sPubSelect("6",sqlStr).get(0);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="6">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultList" scope="end" />
<%
	if (resultList != null && resultList.length>0) {
		if (resultList[0][0].equals(""))	{
			resultList = null;
		}
	}
	//wuxy add for MA
	sqlStr ="select b.net_attr from SBILLSPCODE a,sNetAttr b where a.net_attr=b.net_attr and a.bizcodeadd = '"+biz_code+"'";
	String[] inParams = new String[2];
	inParams[0] = "select b.net_attr from SBILLSPCODE a,sNetAttr b where a.net_attr=b.net_attr and a.bizcodeadd =:biz_code";
	inParams[1] = "biz_code="+biz_code;
	//System.out.println("sqlStr="+sqlStr);
	//String [][]resultNetAttr = (String[][])callView.sPubSelect("1",sqlStr).get(0);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>	
	</wtc:service>	
	<wtc:array id="resultNetAttr"  scope="end"/>
<%
	
	if(resultNetAttr!=null && resultNetAttr.length>0)
	{
		if(resultNetAttr[0][0].equals("3"))//ȫ��MASҵ��
		{
			sqlStr="select d.third_value from dbvipadm.dgrpcustmsgadd d,sbillspcode a,sbizparamdetail b,sbizparamcode c "
	       			+" where to_char(d.cust_id)=trim(a.enterprice_code) and d.field_code='0002' and d.field_value=a.bizcodeadd"
	       			+" and a.bizcodeadd='"+biz_code+"'"
	       			+" and a.param_set=b.param_set and b.param_code=c.param_code and multi_able='N' and show_flag='Y' "
	       			+" and d.other_value=b.param_code and d.field_value='"+biz_code+"'"
	       			+" order by b.param_order";
	       	//System.out.println(sqlStr);
	       	//resultThirdValueList=(String[][])callView.sPubSelect("1",sqlStr).get(0);
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="1">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="resultThirdValueListTemp" scope="end" />
<%
			resultThirdValueList = resultThirdValueListTemp;
	       	if(resultThirdValueList!=null && resultThirdValueList.length>0)
	       	{
	       		isMA=1;
	       	    fieldCount2=resultThirdValueList.length;
	       		//System.out.println("Third_value_List");
	       	}
	       	
		}
	
	}
	
	
	
	
	
    //wuxy add end
    
    
	
	sqlStr = "select distinct c.PARAM_GROUP, c.GROUP_NAME ,d.PARAM_TYPE  "
		+ "from SBILLSPCODE a, sbizparamdetail b, sbizparamgroup c, sBizParamCode d  "
		+ "where a.PARAM_SET = b.PARAM_SET and b.PARAM_GROUP = c.PARAM_GROUP  and  b.PARAM_CODE = d.PARAM_CODE    and b.MULTI_ABLE = 'Y' and a.bizcodeadd = '"
		+ biz_code + "' order by b.param_order";
	//String[][] slParamGroup = (String[][])callView.sPubSelect("3",sqlStr).get(0);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode4" retmsg="retMsg4" outnum="3">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="slParamGroup" scope="end" />
<%	
	int fieldCount1=0;
    String[][] slGroupItem = new String[][]{};
    
    
	if (slParamGroup != null && slParamGroup.length>0) {
		for (int i=0; i < slParamGroup.length; i++) {
			sqlStr = "select c.PARAM_NAME, c.PARAM_TYPE,b.param_code ,c.param_length "
				+ "from SBILLSPCODE a, sbizparamdetail b, sbizparamcode c "
				+ "where a.PARAM_SET = b.PARAM_SET and b.PARAM_CODE = c.PARAM_CODE and a.BIZCODEADD = '" 
				+ biz_code + "' and b.PARAM_GROUP = '" + slParamGroup[i][0] + "' order by b.param_order ";
			//System.out.println("Str222="+sqlStr);
			//slGroupItem = (String[][])callView.sPubSelect("4",sqlStr).get(0);
			%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode5" retmsg="retMsg5" outnum="4">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="slGroupItemTemp" scope="end" />
<%	    
			slGroupItem = slGroupItemTemp;
	        fieldCount1 = slGroupItem.length;	
			
			out.print("<script language='javascript'>");
			out.print("var add"+slParamGroup[i][0]+" = 0;");
			out.print("function dynAdd"+slParamGroup[i][0]+"() {");
			out.print("add"+slParamGroup[i][0]+"++;");
			out.print("var tr1=tab"+slParamGroup[i][0]+".insertRow();");
	        out.print("tr1.id='tr';");
	        out.print("tr1.align='center';");
	        out.print("var ParamGroupname;");
	        for (int j = 0; j <fieldCount1; j++) {
	        out.print("var ParamGroupname='"+j+"'+'"+slParamGroup[i][0]+"'+add"+slParamGroup[i][0]+";");         
	 		out.print("tr1.insertCell().innerHTML = \"<td><input type=text  id=\'\"+ParamGroupname+\"\'  name=\'\"+ParamGroupname+\"\'  datatype="+slGroupItem[j][1]+"  maxlength="+slGroupItem[j][3]+" ></td>\";");
	 		}	
	 		out.print("tr1.insertCell().innerHTML = \"<td><input name=delbutton class=b_text type=button value='ɾ��' onclick=dynDel"+slParamGroup[i][0]+"(this) style=cursor:hand></td>\";");			
			out.print("}");
			out.print("function dynDel"+slParamGroup[i][0]+"() {");
			out.print("var args=dynDel"+slParamGroup[i][0]+".arguments[0];");
			out.print("var objTD=args.parentElement;");
			out.print("var objTR=objTD.parentElement;");
			out.print("var currRowIndex = objTR.rowIndex;");
			out.print("tab"+slParamGroup[i][0]+".deleteRow(currRowIndex);");  
			out.print("add"+slParamGroup[i][0]+"--;");
			out.print("}");
			out.print("</script>");
		}	
	}
	
	//add by wuln
	sqlStr ="select accessnumber from SBILLSPCODE where bizcodeadd = '"+biz_code+"'";
	inParams[0] = "select accessnumber from SBILLSPCODE where bizcodeadd =:biz_code";
	inParams[1] = "biz_code="+biz_code;
	//String [][]resultCheckdocId = (String[][])callView.sPubSelect("1",sqlStr).get(0);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode6" retmsg="retMsg6" outnum="1">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>	
	</wtc:service>	
	<wtc:array id="resultCheckdocId"  scope="end"/>
<%
	//end add by wuln

 //   System.out.println("resultList===="+resultList.length);
	if(resultList == null)
	{
%>
	<script>
		window.close();
	</script>
<%
	} else	{
   	int fieldCount=0;
   	
   
    

	fieldCount = resultList.length;
	

	boolean isGroup = true;
	String []fieldCodes=new String[fieldCount];
	String []fieldNames=new String[fieldCount];
	//String []fieldPurposes=new String[fieldCount];
	String []fieldValues=new String[fieldCount];
	String []dataTypes=new String[fieldCount];
	String []fieldLengths=new String[fieldCount];
	String []fieldCtrlInfos=new String[fieldCount];
	
	//wuxy add for MA
	String listShow=" ";

	int iField=0;
	int iField1=0;
	//wuxy alter for MA 20080807
	while (iField<fieldCount) {
	 
	        if(isMA==1&&(!(resultList[iField][0].equals("00007"))))
	        {
	            if(iField1<fieldCount2)
	            {
					fieldCodes[iField]=resultList[iField][0];
					fieldNames[iField]=resultList[iField][1];
					//fieldPurposes[iField]=resultList[iField][2];
					//fieldValues[iField]=resultList[iField][2];
					fieldValues[iField]=resultThirdValueList[iField1][0];
					dataTypes[iField]=resultList[iField][3];
					fieldLengths[iField]=resultList[iField][4];
					fieldCtrlInfos[iField]=resultList[iField][5];
					iField++;
					iField1++;
				}
			}
		   else
		   	{
		   		fieldCodes[iField]=resultList[iField][0];
				fieldNames[iField]=resultList[iField][1];
				//fieldPurposes[iField]=resultList[iField][2];
				fieldValues[iField]=resultList[iField][2];
				dataTypes[iField]=resultList[iField][3];
				fieldLengths[iField]=resultList[iField][4];
				fieldCtrlInfos[iField]=resultList[iField][5];
				iField++;
		   	}
	}
	String op_name = "����ҵ�񸽼���Ϣ";

	ArrayList retArray = new ArrayList();
	
	//�����б�����
	String[][] fieldParamCodes = new String[][]{};
	String[][] fieldParamSql = new String[][]{};
	/*
	HashMap hm = new HashMap();
	if(!hm.containsKey("regionCode"))   hm.put("regionCode",regionCode);
	if(!hm.containsKey("workno"))       hm.put("workno",workno);
	if(!hm.containsKey("org_code"))     hm.put("org_code",org_code);
	if(!hm.containsKey("districtCode")) hm.put("districtCode",districtCode);
	*/
	try
		{
			//��̬�����б�
			sqlStr = "select param_code, config_code, config_name from sBizParamConfig order by config_order";
			retArray = callView.sPubSelect("3",sqlStr);
			//fieldParamCodes = (String[][])retArray.get(0);
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode7" retmsg="retMsg7" outnum="3">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="fieldParamCodesTemp" scope="end" />
<%
			fieldParamCodes = fieldParamCodesTemp;
			for(int n=0; n<fieldParamCodes.length; n++)
			{
				System.out.println("fieldParamCodes["+n+"][1]="+fieldParamCodes[n][1]);
			}			
			//��̬�����б�
			sqlStr = "select param_code, config_sql from sBizParamConfig order by config_order";
			//retArray = callView.sPubSelect("2",sqlStr);
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode8" retmsg="retMsg8" outnum="2">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="fieldParamSqlTemp" scope="end" />
<%
			fieldParamSql = fieldParamSqlTemp;
		}
		catch(Exception e)
		{
			//logger.error("Call sunView is Failed!");
		}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=op_name%></TITLE>
<script language="javascript">

function checkDynaFieldValues(haveCalc)//���༭���������Ƿ�Ϸ���haveCalc:�Ƿ�����Լ����ֶεļ��
{
	var ret=true;
	var reta=true;
	var retb=true;
	var checkValues_flag = false;
<%
	int iLen=0;
	while(iLen < fieldCount)
	{
%>
			checkValues_flag = false;
<%
			//����ֶοɿգ���Ϊ�գ�����ȷreturn true ,Y-�ɿ� N-���ɿ�
		if (fieldCtrlInfos[iLen].equals("Y")) {
%>
			if(frm.F<%=fieldCodes[iLen]%>.value=='')
			checkValues_flag = true;
<%
		} else if (fieldCtrlInfos[iLen].equals("N")) {
%>
			//alert(frm.F<%=fieldCodes[iLen]%>.value);
			if (frm.F<%=fieldCodes[iLen]%>.value=='') {
				rdShowMessageDialog("<%=fieldNames[iLen]%>"+"�ֶβ���Ϊ��!");
				frm.F<%=fieldCodes[iLen]%>.focus();
				return false;
			}
<%
		}
%>

		if(!checkValues_flag)
		{
		if (frm.F<%=fieldCodes[iLen]%>.datatype=='01'){//����
			reta=parseInt(frm.F<%=fieldCodes[iLen]%>.value)==frm.F<%=fieldCodes[iLen]%>.value;
			if (JHshStrLen(frm.F<%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
			retb = false;
			}
			ret = reta && retb;
		}
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='02'){//������
			reta=parseFloat(frm.F<%=fieldCodes[iLen]%>.value)==frm.F<%=fieldCodes[iLen]%>.value;
			if (JHshStrLen(frm.F<%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
			retb = false;
			}
			ret = reta && retb;
		}
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='03'){//�ַ���
			//ret=true;
			//var reg = new RegExp(/^(\s)*$/);
			//var flag= reg.test(frm.F<%=fieldCodes[iLen]%>.value);
			flag=frm.F<%=fieldCodes[iLen]%>.value=='';
			reta=!flag;
			if(JHshStrLen(frm.F<%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
			 retb = false;
			}
			ret = reta && retb;
		}
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='09'){//���
			ret=parseFloat(frm.F<%=fieldCodes[iLen]%>.value)==frm.F<%=fieldCodes[iLen]%>.value;
		}
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='07'){//����
			ret=validDate(frm.F<%=fieldCodes[iLen]%>);
		}
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='08')//����ʱ��
		{
			frm.F<%=fieldCodes[iLen]%>.value = frm.F<%=fieldCodes[iLen]%>.value.substr(0,8)
								+ frm.F<%=fieldCodes[iLen]%>.value.substr(9,2)
								+ frm.F<%=fieldCodes[iLen]%>.value.substr(12,2)
								+ frm.F<%=fieldCodes[iLen]%>.value.substr(15,2)
			ret=validTotalDate(frm.F<%=fieldCodes[iLen]%>);
			frm.F<%=fieldCodes[iLen]%>.value = frm.F<%=fieldCodes[iLen]%>.value.substr(0,8)
								+ " "
								+ frm.F<%=fieldCodes[iLen]%>.value.substr(8,2)
								+":"
								+ frm.F<%=fieldCodes[iLen]%>.value.substr(10,2)
								+":"
								+ frm.F<%=fieldCodes[iLen]%>.value.substr(12,2)
		}
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='11')//BOOL
			ret=true;
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='10')//������
			ret=true;
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='00')//����
			ret=true;
		else if ((frm.F<%=fieldCodes[iLen]%>.datatype=='13')&&(haveCalc))//��ʽ����
			ret=parseFloat(frm.F<%=fieldCodes[iLen]%>.value)==frm.F<%=fieldCodes[iLen]%>.value;
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='04')//ip��ַ add
		    ret=forIP(frm.F<%=fieldCodes[iLen]%>);//add
		if (!ret)
		{
			rdShowMessageDialog("�����������Ͳ���!");
			frm.F<%=fieldCodes[iLen]%>.focus();
			return ret;
		}
		}//end if(!checkValues_flag)
<%
		iLen++;
	} //end while
%>

	return true;
}

function JHshStrLen(sString)//�����ַ�������
{
	var sStr,iCount,i,strTemp ;
	iCount = 0 ;
	sStr = sString.split("");
	for (i = 0 ; i < sStr.length ; i ++)
	{
		strTemp = escape(sStr[i]);
		if (strTemp.indexOf("%u",0) == -1) // ��ʾ�Ǻ���
		{
		iCount = iCount + 1 ;
		}
		else
		{
		iCount = iCount + 2 ;
		}
	}
	return iCount ;
}

function sub()
{   	
  if(checkDynaFieldValues(false)==false)
	{
		return false;
	}
	var nl = "";
	var vl = "";	
	var ul = "";
<%
	int len=0;
     while(len<fieldCount)
  {
%>
  	nl=nl+"<%=fieldCodes[len]%>"+"|";
  	var v = "F"+"<%=fieldCodes[len]%>";
  	vl=vl+frm[eval('v')].value+"|";
  	ul=ul+"S"+"|";
<%
  	len++;
    }
%>   
     var i=0;
     //alert("nl=====֮ǰ"+nl);
	 //alert("vl=====֮ǰ"+vl);
      
     <%for (int GroupNum=0; GroupNum < slParamGroup.length; GroupNum++) {
   	    		sqlStr = "select c.PARAM_NAME, c.PARAM_TYPE,b.param_code,c.param_length  "
		          + "from SBILLSPCODE a, sbizparamdetail b, sbizparamcode c "
		          + "where a.PARAM_SET = b.PARAM_SET and b.PARAM_CODE = c.PARAM_CODE and a.BIZCODEADD = '" 
		          + biz_code + "' and b.PARAM_GROUP = '" + slParamGroup[GroupNum][0] + "'";
	           //System.out.println("Str222="+sqlStr);
	           //slGroupItem = (String[][])callView.sPubSelect("4",sqlStr).get(0);
	 %>
	 			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode9" retmsg="retMsg9" outnum="4">
				<wtc:sql><%=sqlStr%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="slGroupItemTemp2" scope="end" />
	 <%          
	 			slGroupItem = slGroupItemTemp2;
	            fieldCount1 = slGroupItem.length;	
                for (int m = 0; m <fieldCount1; m++) {         
     %>
		         nl=nl+"<%=slGroupItem[m][2]%>"+"|";
		         ul=ul+"<%=slParamGroup[GroupNum][0]%>"+"|";   
		          //alert("nl=====�ڲ�"+nl);                      
				for ( i = 1; i <= add<%=slParamGroup[GroupNum][0]%>; i++)
				{	
				    v="<%=m%>"+"<%=slParamGroup[GroupNum][0]%>"+i;		   	
				    //alert("������1="+eval('v'));  
				    if(frm[eval('v')].value == "")
					{
						rdShowMessageDialog("�������벻��Ϊ��!",0);
						return false;
					}
					else if(frm[eval('v')].datatype=='01'){//����
						  if(!(parseInt(frm[eval('v')].value )==parseInt(frm[eval('v')].value ))){
						     //rdShowMessageDialog("��������Ϊ����!",0);
						     frm[eval('v')].focus();
						     return false;
						   }
			                if (JHshStrLen(frm[eval('v')].value) > "<%=slGroupItem[m]%>"){
                                   //rdShowMessageDialog("���β������Ȳ���!",0);
                                   frm[eval('v')].focus();
						     return false;
			                }					
					}
					else if(frm[eval('v')].datatype=='02'){//������
					      if(!(parseFloat(frm[eval('v')].value )==parseInt(frm[eval('v')].value ))){
						     //rdShowMessageDialog("��������Ϊ������!",0);
						     frm[eval('v')].focus();
						     return false;
						   }
			                if (JHshStrLen(frm[eval('v')].value) > "<%=slGroupItem[m]%>"){
                                   //rdShowMessageDialog("�����Ͳ������Ȳ���!",0);
                                   frm[eval('v')].focus();
						     return false;
			                }						
					}
					else if(frm[eval('v')].datatype=='03'){//�ַ���
				     	if (JHshStrLen(frm[eval('v')].value) > "<%=slGroupItem[m]%>"){
                                 //rdShowMessageDialog("�ַ��Ͳ������Ȳ���!",0);
                                 frm[eval('v')].focus();
					     return false;
		                   }	
					}					
					else if(frm[eval('v')].datatype=='07'){//����
				     	if (!validDate(frm[eval('v')])){
                                 //rdShowMessageDialog("���ڲ�����ʽ����!",0);
                                 frm[eval('v')].focus();
					     return false;
		                   }	 
				     }
					else if(frm[eval('v')].datatype=='08'){//����ʱ��
				         if (!validTotalDate(frm[eval('v')])){
                                 //rdShowMessageDialog("���ڲ�����ʽ����!",0);
                                 frm[eval('v')].focus();
					     return false;
		                   }	 					
					}
					else if(frm[eval('v')].datatype=='09'){���
				         	if(!(parseFloat(frm[eval('v')].value )==parseInt(frm[eval('v')].value ))){
					     //rdShowMessageDialog("��������Ϊ������!",0);
					     frm[eval('v')].focus();
					     return false;					
					    }	
					}else if(frm[eval('v')].datatype=='14'){//ʱ��
				         if (!validTime(frm[eval('v')])){
                                 //rdShowMessageDialog("ʱ�������ʽ����!",0);
                                 frm[eval('v')].focus();
					        return false;
		                   }	 					
					}				
					vl=vl+frm[eval('v')].value+",";		
		           } 		
                   vl=vl+"|";        
        <%
              }     
           } 
         %>		
	//alert("nl=====֮��"+nl);
	//alert("vl=====֮��"+vl);
	//alert("ul=====֮��"+ul);
	opener.getnameList_2890(nl,vl,ul);
	window.close();
}
</script>
</HEAD>
<BODY>

<FORM  action="" name="frm"  method="post">	
<%@ include file="/npage/include/header_pop.jsp" %>
<TABLE cellspacing="0" style="display:<%=listShow%>">
	<TR>
		<TD colspan=20>
			<font color=red>
				����Ϣ�������Ϊ�����������<%=resultCheckdocId[0][0]%> +XXXX  ���ѣ�MAS���ŷ�����볤�ȱ���Ϊ8-14λ,ADC���ŷ�����볤�ȱ���Ϊ14λ!��˶Ժ���ȷ�ϡ�
			</font>
		</TD>
	</TR>

<%
		int i=0;
		int colspan = 1;
		int calcButtonFlag = 0;
		int ColNumInARow = 2;
		//wuxy �޸� Ϊȫ��MAS����̬��ʾ���ݲ��ɱ༭20080807
		while (i < fieldCount) {
				out.print("<TR>");
				for (int colNum = 0; (colNum < ColNumInARow) && (i < fieldCount); colNum ++)
				{
					if (fieldCount - 1 == i)
					{
						colspan = 3;
					}
					else
					{
						colspan = 1;
					}
				  /*
					if (fieldPurposes[i].equals("10"))
					{
						out.print("<TD width='18%'><font color=green>"+fieldNames[i]+"</font></TD>");
					}
					else */
					{
						out.print("<TD class=blue>"+fieldNames[i]+"</TD>");
					}
					//�ж��Ƿ���boolean��
					if (dataTypes[i].equals("11"))//ѡ���
					{
						out.print("<TD colspan="+colspan+"> <select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' datatype="+dataTypes[i]+"><option value='Y' ");
						if (fieldValues[i].equals("Y"))
						out.print("selected");
						out.print(" >��</option><option value='N'>��</option></select> </TD>");
					}
					else if (dataTypes[i].equals("10"))//������
					{
					    if(isMA==1)
					    {
							out.print("<TD colspan="+colspan+"> <select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' datatype="+dataTypes[i]+" disabled>");
						}
					    else
					    {
					    	out.print("<TD colspan="+colspan+"> <select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' datatype="+dataTypes[i]+">");
					    }
						for (int j=0; j < fieldParamCodes.length; j++)
						{
							if (fieldParamCodes[j][0].equals(fieldCodes[i]))
							{
								out.print("<option ");
								if (fieldValues[i].equals(fieldParamCodes[j][1]))
									out.print("selected");
								out.print(" value='" + fieldParamCodes[j][1] + "'>"+fieldParamCodes[j][1]+"--" + fieldParamCodes[j][2]+ "</option>");
							}
						}
						out.print("</select> </TD>");
					}
					else if (dataTypes[i].equals("20"))//��̬SQL������
					{
					    if(isMA==1)
					    {
					    	out.print("<TD colspan="+colspan+"> <select id=\"F"+fieldCodes[i]+"\" name=\"F"+fieldCodes[i]+"\" datatype="+dataTypes[i]+" disabled>");
					    }
					    else
					    {
							out.print("<TD colspan="+colspan+"> <select id=\"F"+fieldCodes[i]+"\" name=\"F"+fieldCodes[i]+"\" datatype="+dataTypes[i]+" >");
						}
						for (int j=0; j < fieldParamSql.length; j++)
						{
							if (fieldParamSql[j][0].equals(fieldCodes[i]))
							{
								String[][] dynParamCodes = new String[][]{};
								sqlStr=fieldParamSql[j][1];
					/*
					   while(true)
                                {
                                    int startPos = sqlStr.indexOf('<');
                                    if(startPos<0)
                                    break;

                                    int endPos = sqlStr.indexOf('>');
                                    if(endPos<0)
                                    	break;

                                    String tempName = sqlStr.substring(startPos+1,endPos);
                                    String tempValue = "";
                                    if(hm.containsKey(tempName))
                                    	tempValue = (String)hm.get(tempName);

                                    sqlStr = sqlStr.substring(0,startPos)+tempValue+sqlStr.substring(endPos+1);
                                 }
					  */
								//System.out.println("sqlStr="+sqlStr);

								retArray = callView.sPubSelect("2",sqlStr);
								dynParamCodes = (String[][])retArray.get(0);

								for(int n=0;n<dynParamCodes.length;n++)
								{
									out.print("<option ");
									if (fieldValues[i].equals(dynParamCodes[n][0]))
										out.print("selected");
									out.print(" value=\"" + dynParamCodes[n][0] + "\">"+dynParamCodes[n][0]+"--" + dynParamCodes[n][1]+ "</option>");
								}
							}
						}
						out.print("</select> </TD>");
					}
					else if(dataTypes[i].equals("12"))//����
					{
						out.print("<TD colspan="+colspan+"> <input id='F "+fieldCodes[i]+" ' name='F"+fieldCodes[i]+"' class='button' type='password' v_name="+fieldNames[i]+" datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value='"+fieldValues[i]+"'>");
						if(fieldCtrlInfos[i].equals("N"))
							{out.print("<font color=\"orange\">*</font></TD>");}
					}
					else
					{
					    if(isMA==1&&(!(fieldCodes[i].equals("00007"))))
					    {
					    	out.print("<TD colspan="+colspan+"> <input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' class='button' type='text' v_name="+fieldNames[i]+" datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value='"+fieldValues[i]+"'readonly='true'");
						    if(fieldCtrlInfos[i].equals("N"))
							{out.print("<font color=\"orange\">*</font></TD>");}
					    }
					   else
					   {
						out.print("<TD colspan="+colspan+"> <input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' class='button' type='text' v_name="+fieldNames[i]+" datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value='"+fieldValues[i]+"'>");
						if(fieldCtrlInfos[i].equals("N"))
							{out.print("<font color=\"orange\">*</font></TD>");}
					   }
					}
					//ƴ���ִ�
					nameList.append(fieldCodes[i]+"|");
					nameValueList.append(fieldNames[i]+"|");//ƴֵ��
					i++;
				}
				out.print("</TR>");
		}
%>
</table>
<%
		if (slParamGroup != null) {
			i = 0;
			while (i < slParamGroup.length) {
				out.print("<div style='display:none'><TABLE id=tab" + slParamGroup[i][0] + " cellspacing='0'>");
				out.print("<TR>");
				out.print("<TD colspan=10><font color=green>" + slParamGroup[i][1] + "</font></TD>");
				out.print("</TR>");
			    sqlStr = "select c.PARAM_NAME, c.PARAM_TYPE,b.param_code,c.param_length  "
		          + "from SBILLSPCODE a, sbizparamdetail b, sbizparamcode c "
		          + "where a.PARAM_SET = b.PARAM_SET and b.PARAM_CODE = c.PARAM_CODE and a.BIZCODEADD = '" 
		          + biz_code + "' and b.PARAM_GROUP = '" + slParamGroup[i][0] + "'";
		           //System.out.println("Str333="+sqlStr);
		           //slGroupItem = (String[][])callView.sPubSelect("4",sqlStr).get(0);
%>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode10" retmsg="retMsg10" outnum="4">
				<wtc:sql><%=sqlStr%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="slGroupItemTemp3" scope="end" />
<%		           
				slGroupItem = slGroupItemTemp3;
		        fieldCount1 = slGroupItem.length;	
			    if (slGroupItem.length>1) {
					out.print("<TR>");
					for ( int k = 0; k <fieldCount1; k++) {
						out.print("<TD>" + slGroupItem[k][0] + "</TD>");
					}
					out.print("<TD><input name='add' class='b_foot' type=button value='����һ��' onclick='dynAdd"
						+ slParamGroup[i][0] + "()' style='cursor:hand'></TD>");
					out.print("</TR>");
				}				
				out.print("</TABLE></div>");
				i++;
			}
		}
%>
   <TABLE cellspacing="0">
    <TR>
	<TD colspan=10 align="center" id="footer">
		<input value="ȷ��" name=sub2890 type=button id="sub2890" class="b_foot" onClick="sub()"   style="cursor��hand">
	</TD>
    </TR>
   </TABLE>
  <%@ include file="/npage/include/footer_pop.jsp" %>
 </FORM>
</BODY></HTML>
<%
	}
%>
