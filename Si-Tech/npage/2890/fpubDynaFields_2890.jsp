<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.19
 模块:EC产品订购
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="java.util.*"%>

<%
/*
	名称：动态生成字段
	调用外部变量：
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
	使用方法介绍：
		该文件不能单独使用，需要其他文件include这个文件
	参照OPCODE：3505、3508
	Author:lugz,yinyx
	wuxy 修改 为全网MAS业务动态数据显示并不可编辑 20080807
*/
%>

<%
	String opName = "EC产品订购";
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
		if(resultNetAttr[0][0].equals("3"))//全网MAS业务
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
	 		out.print("tr1.insertCell().innerHTML = \"<td><input name=delbutton class=b_text type=button value='删除' onclick=dynDel"+slParamGroup[i][0]+"(this) style=cursor:hand></td>\";");			
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
	String op_name = "集团业务附加信息";

	ArrayList retArray = new ArrayList();
	
	//下拉列表数据
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
			//静态下拉列表
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
			//动态下拉列表
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

function checkDynaFieldValues(haveCalc)//检查编辑框内数据是否合法，haveCalc:是否包含对计算字段的检查
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
			//如果字段可空，且为空，则正确return true ,Y-可空 N-不可空
		if (fieldCtrlInfos[iLen].equals("Y")) {
%>
			if(frm.F<%=fieldCodes[iLen]%>.value=='')
			checkValues_flag = true;
<%
		} else if (fieldCtrlInfos[iLen].equals("N")) {
%>
			//alert(frm.F<%=fieldCodes[iLen]%>.value);
			if (frm.F<%=fieldCodes[iLen]%>.value=='') {
				rdShowMessageDialog("<%=fieldNames[iLen]%>"+"字段不能为空!");
				frm.F<%=fieldCodes[iLen]%>.focus();
				return false;
			}
<%
		}
%>

		if(!checkValues_flag)
		{
		if (frm.F<%=fieldCodes[iLen]%>.datatype=='01'){//整型
			reta=parseInt(frm.F<%=fieldCodes[iLen]%>.value)==frm.F<%=fieldCodes[iLen]%>.value;
			if (JHshStrLen(frm.F<%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
			retb = false;
			}
			ret = reta && retb;
		}
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='02'){//浮点型
			reta=parseFloat(frm.F<%=fieldCodes[iLen]%>.value)==frm.F<%=fieldCodes[iLen]%>.value;
			if (JHshStrLen(frm.F<%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
			retb = false;
			}
			ret = reta && retb;
		}
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='03'){//字符型
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
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='09'){//金额
			ret=parseFloat(frm.F<%=fieldCodes[iLen]%>.value)==frm.F<%=fieldCodes[iLen]%>.value;
		}
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='07'){//日期
			ret=validDate(frm.F<%=fieldCodes[iLen]%>);
		}
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='08')//日期时间
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
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='10')//下拉框
			ret=true;
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='00')//其他
			ret=true;
		else if ((frm.F<%=fieldCodes[iLen]%>.datatype=='13')&&(haveCalc))//公式计算
			ret=parseFloat(frm.F<%=fieldCodes[iLen]%>.value)==frm.F<%=fieldCodes[iLen]%>.value;
		else if (frm.F<%=fieldCodes[iLen]%>.datatype=='04')//ip地址 add
		    ret=forIP(frm.F<%=fieldCodes[iLen]%>);//add
		if (!ret)
		{
			rdShowMessageDialog("数据输入类型不对!");
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

function JHshStrLen(sString)//计算字符串长度
{
	var sStr,iCount,i,strTemp ;
	iCount = 0 ;
	sStr = sString.split("");
	for (i = 0 ; i < sStr.length ; i ++)
	{
		strTemp = escape(sStr[i]);
		if (strTemp.indexOf("%u",0) == -1) // 表示是汉字
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
     //alert("nl=====之前"+nl);
	 //alert("vl=====之前"+vl);
      
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
		          //alert("nl=====内部"+nl);                      
				for ( i = 1; i <= add<%=slParamGroup[GroupNum][0]%>; i++)
				{	
				    v="<%=m%>"+"<%=slParamGroup[GroupNum][0]%>"+i;		   	
				    //alert("参数名1="+eval('v'));  
				    if(frm[eval('v')].value == "")
					{
						rdShowMessageDialog("参数代码不许为空!",0);
						return false;
					}
					else if(frm[eval('v')].datatype=='01'){//整形
						  if(!(parseInt(frm[eval('v')].value )==parseInt(frm[eval('v')].value ))){
						     //rdShowMessageDialog("参数类型为整形!",0);
						     frm[eval('v')].focus();
						     return false;
						   }
			                if (JHshStrLen(frm[eval('v')].value) > "<%=slGroupItem[m]%>"){
                                   //rdShowMessageDialog("整形参数长度不符!",0);
                                   frm[eval('v')].focus();
						     return false;
			                }					
					}
					else if(frm[eval('v')].datatype=='02'){//浮点型
					      if(!(parseFloat(frm[eval('v')].value )==parseInt(frm[eval('v')].value ))){
						     //rdShowMessageDialog("参数类型为浮点型!",0);
						     frm[eval('v')].focus();
						     return false;
						   }
			                if (JHshStrLen(frm[eval('v')].value) > "<%=slGroupItem[m]%>"){
                                   //rdShowMessageDialog("浮点型参数长度不符!",0);
                                   frm[eval('v')].focus();
						     return false;
			                }						
					}
					else if(frm[eval('v')].datatype=='03'){//字符型
				     	if (JHshStrLen(frm[eval('v')].value) > "<%=slGroupItem[m]%>"){
                                 //rdShowMessageDialog("字符型参数长度不符!",0);
                                 frm[eval('v')].focus();
					     return false;
		                   }	
					}					
					else if(frm[eval('v')].datatype=='07'){//日期
				     	if (!validDate(frm[eval('v')])){
                                 //rdShowMessageDialog("日期参数格式不符!",0);
                                 frm[eval('v')].focus();
					     return false;
		                   }	 
				     }
					else if(frm[eval('v')].datatype=='08'){//日期时间
				         if (!validTotalDate(frm[eval('v')])){
                                 //rdShowMessageDialog("日期参数格式不符!",0);
                                 frm[eval('v')].focus();
					     return false;
		                   }	 					
					}
					else if(frm[eval('v')].datatype=='09'){金额
				         	if(!(parseFloat(frm[eval('v')].value )==parseInt(frm[eval('v')].value ))){
					     //rdShowMessageDialog("参数类型为浮点型!",0);
					     frm[eval('v')].focus();
					     return false;					
					    }	
					}else if(frm[eval('v')].datatype=='14'){//时间
				         if (!validTime(frm[eval('v')])){
                                 //rdShowMessageDialog("时间参数格式不符!",0);
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
	//alert("nl=====之后"+nl);
	//alert("vl=====之后"+vl);
	//alert("ul=====之后"+ul);
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
				短消息服务代码为：基本接入号<%=resultCheckdocId[0][0]%> +XXXX  提醒：MAS短信服务号码长度必须为8-14位,ADC短信服务号码长度必须为14位!请核对好再确认。
			</font>
		</TD>
	</TR>

<%
		int i=0;
		int colspan = 1;
		int calcButtonFlag = 0;
		int ColNumInARow = 2;
		//wuxy 修改 为全网MAS，动态显示数据不可编辑20080807
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
					//判断是否是boolean型
					if (dataTypes[i].equals("11"))//选择框
					{
						out.print("<TD colspan="+colspan+"> <select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' datatype="+dataTypes[i]+"><option value='Y' ");
						if (fieldValues[i].equals("Y"))
						out.print("selected");
						out.print(" >是</option><option value='N'>否</option></select> </TD>");
					}
					else if (dataTypes[i].equals("10"))//下拉框
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
					else if (dataTypes[i].equals("20"))//动态SQL下拉框
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
					else if(dataTypes[i].equals("12"))//密码
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
					//拼名字串
					nameList.append(fieldCodes[i]+"|");
					nameValueList.append(fieldNames[i]+"|");//拼值串
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
					out.print("<TD><input name='add' class='b_foot' type=button value='增加一行' onclick='dynAdd"
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
		<input value="确定" name=sub2890 type=button id="sub2890" class="b_foot" onClick="sub()"   style="cursor：hand">
	</TD>
    </TR>
   </TABLE>
  <%@ include file="/npage/include/footer_pop.jsp" %>
 </FORM>
</BODY></HTML>
<%
	}
%>
