<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-9
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<head>

<%
  String opCode = "8046";
  String opName = "营销案取消";
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="javascript">
	var saleTypeArray = new Array(new Array(),new Array());
</script>
<%
  //String workNoFromSession=(String)session.getAttribute("workNo");
	//String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	//String password = (String)session.getAttribute("password");
	//boolean workNoFlag=false;
	//if(workNoFromSession.substring(0,1).equals("k"))
	//  workNoFlag=true;

    //ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
  	//String[][] baseInfoSession = (String[][])arrSession.get(0);
    //String work_no = baseInfoSession[0][2];
    //String loginName = baseInfoSession[0][3];
    //String org_Code = baseInfoSession[0][16];
    
    
    //String org_Code =(String)session.getAttribute("orgCode");
    String regionCode =(String)session.getAttribute("regCode");
    String flag= request.getParameter("flag");/*huangroong add 标记是否是预约冲正 0：普通 1：预约*/
    System.out.println("---------------flag--------------------------"+flag);
		//System.out.println("---------------regionCode--------------hjw------------"+regionCode);
	  /* 
	  String[][] temfavStr=(String[][])arrSession.get(3);
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    if(WtcUtil.haveStr(favStr,"a272"))
	  pwrf=true;
	  */
%>

<%
	SPubCallSvrImpl impl = new SPubCallSvrImpl();	
%>


			

<%
/***********wangdana modifly begin********/		
    /*营销案类型*/
	String group_id=(String)session.getAttribute("groupId");
	String Grpsql="";
	String Typsql="";
	String [] GrpParamIn =new String[2];
	String [] TypParamIn =new String[2];
	Grpsql="SELECT count(*) FROM dchngroupmsg  where class_code = '200' and group_id ='" +group_id;
	GrpParamIn[0]="SELECT count(*) FROM dchngroupmsg  where class_code = '200' and group_id = :group_id";
	GrpParamIn[1]="group_id="+group_id;
	System.out.println("&&&&&&&&&&&&&&&&&&&"+group_id);
%>
	<wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=GrpParamIn[0]%>" />
			<wtc:param value="<%=GrpParamIn[1]%>" />
		</wtc:service>
		<wtc:array id="resultGrp" scope="end" start="0"  length="1" />
<%
	if(resultGrp != null)
	{
		System.out.println("&&&&&&&&&&&&&&&&&&&resultGrp"+resultGrp[0][0]);
		if(!resultGrp[0][0].equals("0"))/*是铁通的工号*/
		{
			 TypParamIn[0]=" select distinct sale_type,type_name,decode(mode_code, 'XXXXXXXX', 0, 1) mode_code "
   					+" from ssaletype "
					+" where region_code = :region_code "
    				+" and pre_flag = :pre_flag "
    				+" and op_code in (select sale_op_code "
                    +" from dbchnterm.schnressaleplantype "
                    +" where is_group = '0') ";
		}
		else/*自有营业厅的工号*/
		{
			  TypParamIn[0]="select distinct sale_type,type_name,decode(mode_code, 'XXXXXXXX', 0, 1) mode_code "
     				+" from ssaletype "
    				+" where region_code = :region_code "
      				+" and pre_flag = :pre_flag "
      				+" and op_code not in (select sale_op_code "
                    +" from dbchnterm.schnressaleplantype "
                    +" where is_group = '0') ";
		}
		TypParamIn[1]="region_code="+regionCode+",pre_flag="+flag;
	}
	/***********wangdana modifly end ********/
%>	
    <wtc:service name="TlsPubSelCrm" outnum="3" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=TypParamIn[0]%>" />
			<wtc:param value="<%=TypParamIn[1]%>" />
		</wtc:service>
		<wtc:array id="result" scope="end" start="0"  length="3" />

	<%
  //System.out.println(retList1);
	//retList1 = impl.sPubSelect("3",sqlStr1);
	//String[][] saleTypeList = new String[][]{};
/*	
  //String[][] saleTypeList = new String[][]{};
	if (retList1 != null)
	{
		saleTypeList = (String[][])retList1.get(0);
		for(int h=0;h<saleTypeList.length;h++)
		{
			for(int w=0;w<saleTypeList[h].length;w++)
				{
					System.out.print(saleTypeList[h][w]+" ");
				}
			System.out.println();	
		}
		
		
	}
	*/
	
		String[][] saleTypeList = new String[][]{};
		
		
	
	if (result != null)
	{
		saleTypeList = result;
			/*
				for(int h=0;h<saleTypeList.length;h++)
		{
			for(int w=0;w<saleTypeList[h].length;w++)
				{
					System.out.print(saleTypeList[h][w]+" ");
				}
			System.out.println();	
		}
		
		System.out.println("-----------saleTypeList.length------------------"+saleTypeList.length);	
		*/
	}
	
	String phone=(String)request.getParameter("phoneNo");
	
if(phone==null) 
	   phone=request.getParameter("phone_no");
	   System.out.println("---------------------------------------");
	    System.out.println("---------------------------------------"+phone);
%>
<script language="javascript">
<%
	for(int i=0; saleTypeList != null && i< saleTypeList.length; i++)
	{
%>

		saleTypeArray[0][<%=i%>] = "<%=saleTypeList[i][0]%>";
		saleTypeArray[1][<%=i%>] = "<%=saleTypeList[i][2]%>";

<%

	}
%>
</script>


<script language=javascript>
//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
  
  if(!check(frm)) return false;
  var mode_code_flag = "0";
  
  with(document.frm)
  {
  		  	//alert(saleTypeArray[1][0]);
	  for(var i = 0; i< saleTypeArray[0].length; i++ )

		  if(saleType.value== saleTypeArray[0][i])
		  {
		  	
		  	mode_code_flag = saleTypeArray[1][i];
		  	saleName.value = saleType.options[saleType.selectedIndex].text;
		  	break;
		  }
		  
		//  alert(mode_code_flag);
  }
  if(mode_code_flag=="0")
  {
  	//alert("f8046Main_2.jsp");
  	frm.action = "f8046Main_2.jsp";
  	frm.submit();
  }
  else if(mode_code_flag=="1")
  {
  	//alert("f8046Main.jsp");
  	frm.action = "f8046Main.jsp";
  	frm.submit();
  }
  else
  {
  	return false;
  }

  return true;
}
</script>
</head>
<body>
	
<form name="frm" method="POST" >
	
	<%@ include file="/npage/include/header.jsp" %>  
	<input type="hidden" name="saleName" value="">
		<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0" >

	      <TR> 
	          <td class="blue">营销案类型</TD>
              <td class="blue">
			       <select name="saleType">
		      		<%
						if (saleTypeList.length != 0 && (!saleTypeList[0][0].equals("")))
						{
						
							for(int i=0;i < saleTypeList.length;i ++)
							{
					%>
	          			<option value='<%=saleTypeList[i][0]%>'><%=saleTypeList[i][1]%></option>
					<%
							}
						}
					%>
				    </select>&nbsp;<font class="orange">*</font>					
	          </TD>
	          
         </TR>
         <tr> 
            <td class="blue">
              手机号码
            </td>
            <td class="blue"> 
            
                <input   type="text" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   index="0" value =<%=phone%>  Class="InputGrey" readOnly >
                &nbsp;<font class="orange">*</font>
            </td>
          
         </tr>

         <tr> 
            <td colspan="5" > 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
		     		  <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();"">
		     		  <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
              </div>
           </td>
        </tr>
      </table>

    <%@ include file="/npage/include/footer.jsp" %>
   </form>
</body>
</html>
